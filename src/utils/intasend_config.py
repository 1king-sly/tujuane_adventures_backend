import time
from time import sleep

import httpx
from fastapi import HTTPException
from intasend import APIService
from dotenv import load_dotenv

import os
load_dotenv()


token = os.getenv('PAYMENT_PUBLISHABLE_TOKEN')
publishable_key = os.getenv('PAYMENT_PUBLISHABLE_KEY')
service = APIService(token=token, publishable_key=publishable_key, test=True)

async def create_payment(amount:int,phone_number:str):
    try:
        url = "https://sandbox.intasend.com/api/v1/checkout/"
        headers = {
            "Authorization": f"Bearer {publishable_key}",
            "Content-Type": "application/json",
        }
        payload = {
            "currency": "KES",
            "amount": amount,
            "email": "kinslybyrone17@gmail.com",
            "phone_number": phone_number,
            "method": "M-PESA",
            "reference": "Booking Event"
        }

        async with httpx.AsyncClient() as client:
            response = await client.post(url, json=payload, headers=headers,)
            if response.status_code != 200:
                raise HTTPException(status_code=400, detail="Failed to initiate Intasend payment")
            return response.json()



    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

