import time

from fastapi import HTTPException
from intasend import APIService
from dotenv import load_dotenv

import os
load_dotenv()


token = os.getenv('PAYMENT_PUBLISHABLE_TOKEN')
publishable_key = os.getenv('PAYMENT_PUBLISHABLE_KEY')
service = APIService(token=token, publishable_key=publishable_key, test=True)

def create_payment(amount:int,phone_number:str):
    try:
        # Initiate MPesa STK push
        response = service.collect.mpesa_stk_push(
            phone_number=phone_number,
            email="kinslybyrone17@gmail.com",
            amount=amount,
            narrative="Purchase"
        )

        payment_id = response.get("id")
        invoice_data = response.get("invoice", {})
        invoice_id = invoice_data.get("invoice_id")
        initial_status = invoice_data.get("state")

        if not invoice_id:
            raise ValueError("Invoice ID is missing in the response.")

        # Log the initial response
        print(f"Payment initiated: ID={payment_id}, Invoice ID={invoice_id}, Status={initial_status}")
        max_retries = 20
        retries = 0

        while retries < max_retries:
            try:
                status_response = service.collect.status(invoice_id=invoice_id)
                status = status_response.get("invoice", {}).get("state")
                message = status_response.get("invoice", {}).get("failed_reason", "Transaction has not failed")

                if not status:
                    raise ValueError("State is missing in the status response.")

                print(f"Attempt {retries + 1}: Payment status is {status}")

                if status not in ["PENDING",'PROCESSING']:
                    return {
                        "status": status,
                        "message": message,
                        "invoice_id": invoice_id,
                        "status_response": status_response
                    }

            except Exception as e:
                raise HTTPException(status_code=500, detail=f"Error checking payment status: {str(e)}")

            retries += 1
            time.sleep(10)
        if retries == 20:
            raise HTTPException(status_code=408, detail="Request TimeOut")


    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

