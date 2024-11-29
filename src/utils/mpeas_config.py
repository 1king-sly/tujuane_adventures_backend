from datetime import datetime

from dotenv import load_dotenv

import os

import  requests
from fastapi import HTTPException
from httpx import AsyncClient

import base64


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


def initiate_stk_push(phone_number: str, amount: int):
    """Initiate an STK Push request."""
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
            "CallBackURL": "https://mydomain.com/path",
            "AccountReference": "CompanyXLTD",
            "TransactionDesc": "Payment of X"
        }

        response = requests.request("POST", 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
                                    headers=headers, json=payload)
        response.raise_for_status()
        response_data = response.json()
        return response_data
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")




# def query_stkpush_status(access_token, checkout_request_id):
#     """Query the stk push status using the checkout request ID."""
#     headers = {"Authorization": f"Bearer {access_token}"}
#     password, timestamp = generate_password()
#     payload = {
#     "BusinessShortCode": STKPUSH_BUSINESS_SHORTCODE,
#     "Password": password,
#     "Timestamp": timestamp,
#     "CheckoutRequestID": checkout_request_id
#     }
#
#     response = requests.post(STKPUSH_STATUS_URL, json=payload, headers=headers, timeout=10)
#     print(response.json())
#     if response.status_code == 200:
#         return response.json()
#     else:
#         raise Exception("Failed to query stk push status")