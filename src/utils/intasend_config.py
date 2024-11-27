from fastapi import HTTPException
from intasend import APIService
from dotenv import load_dotenv

import os
load_dotenv()


token = os.getenv('PAYMENT_PUBLISHABLE_TOKEN')
publishable_key = os.getenv('PAYMENT_PUBLISHABLE_KEY')
service = APIService(token=token, publishable_key=publishable_key, test=True)

async def create_payment():
    try:
        response = service.collect.mpesa_stk_push(phone_number=254720041750,
                                                  email="kinslybyrone17@gmail.com", amount=10, narrative="Purchase")
        return response
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

