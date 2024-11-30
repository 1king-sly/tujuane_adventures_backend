from asyncio import Future
from datetime import datetime

from dotenv import load_dotenv

import os
import aiohttp


import  requests
from fastapi import HTTPException
from httpx import AsyncClient

import base64

from starlette.responses import JSONResponse

load_dotenv()

DARAJA_CONSUMER_KEY = os.getenv('DARAJA_CONSUMER_KEY')
DARAJA_CONSUMER_SECRET = os.getenv('DARAJA_CONSUMER_SECRET')
DARAJA_API_URL = os.getenv('DARAJA_API_URL')
CALLBACK_URL = os.getenv('CALLBACK_URL')
SHORTCODE = os.getenv('SHORTCODE')
PASSKEY = os.getenv('PASSKEY')
TOKEN_URL=f"{DARAJA_API_URL}/oauth/v1/generate?grant_type=client_credentials"
STK_PUSH_URL = f"{DARAJA_API_URL}/mpesa/stkpush/v1/processrequest"

def get_access_token() -> str:
    """Fetch access token from Daraja API."""

    encoded_credentials = base64.b64encode(f"{DARAJA_CONSUMER_KEY}:{DARAJA_CONSUMER_SECRET}".encode()).decode()
    headers = {"Authorization": f"Basic {encoded_credentials}"}

    response = requests.get(TOKEN_URL, headers=headers, timeout=10)
    response.raise_for_status()
    token = response.json().get('access_token')
    return token


def generate_password():
    """Generate the password for STK push."""
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    password = base64.b64encode(f"{SHORTCODE}{PASSKEY}{timestamp}".encode()).decode()
    return password, timestamp
async def initiate_stk_push(phone_number: str, amount: int):
    try:

        access_token = get_access_token()
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        password = base64.b64encode(f"{SHORTCODE}{PASSKEY}{timestamp}".encode()).decode()


        headers = {
            'Content-Type': 'application/json',
            'Authorization': f'Bearer {access_token}'
        }

        payload = {
            "BusinessShortCode": SHORTCODE,
            "Password": password,
            "Timestamp": timestamp,
            "TransactionType": "CustomerPayBillOnline",
            "Amount": amount,
            "PartyA": phone_number,
            "PartyB": SHORTCODE,
            "PhoneNumber": phone_number,
            "CallBackURL": "https://85d6-197-248-74-74.ngrok-free.app/booking/callback",
            "AccountReference": "Booking Payment",
            "TransactionDesc": "Payment for booking an event"
        }

        async with aiohttp.ClientSession() as async_session:
            async with async_session.post(url='https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest', headers=headers, json=payload) as response:
                response.raise_for_status()
                response_data = await response.json()

                print("STK Push response:", response_data)


                return response_data

    except aiohttp.ClientError as e:
        raise HTTPException(status_code=500, detail=f"HTTP request failed: {e}")


    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")




async def check_transaction_status(transaction_id: str):
    access_token = get_access_token()

    url = "https://sandbox.safaricom.co.ke/mpesa/transactionstatus/v1/query"
    headers = {
        "Authorization": f"Bearer {access_token}",
        "Content-Type": "application/json"
    }
    payload = {
        "Initiator": "api_initiator",
        "SecurityCredential": "encrypted_credential",
        "CommandID": "TransactionStatusQuery",
        "TransactionID": transaction_id,
        "PartyA": SHORTCODE,
        "IdentifierType": "1",
        "ResultURL": "https://85d6-197-248-74-74.ngrok-free.app/booking/transaction-status",
        "QueueTimeOutURL": "https://85d6-197-248-74-74.ngrok-free.app/booking/timeout",
        "Remarks": "Checking transaction status"
    }

    response = requests.post(url, headers=headers, json=payload)
    if response.status_code == 200:
        return response.json()
    raise HTTPException(status_code=500, detail="Transaction status query failed")

callback_responses = {}

async def notify_booking_process(transaction_id: str):
    """
    Notify the main booking flow about the callback.
    """
    print(f'Notify Booking Process : {transaction_id}')
    if transaction_id in callback_responses:
        callback_responses[transaction_id].set_result(transaction_id)
    else:
        callback_responses[transaction_id] = Future()
        callback_responses[transaction_id].set_result(transaction_id)

async def wait_for_callback_and_get_transaction_id(checkout_request_id: str):
    """
    Wait for the callback to provide transaction ID.
    """
    if checkout_request_id not in callback_responses:
        callback_responses[checkout_request_id] = Future()
    return await callback_responses[checkout_request_id]