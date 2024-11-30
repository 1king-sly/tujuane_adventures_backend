from urllib import request

from fastapi import APIRouter, Depends, HTTPException, Request, BackgroundTasks

from src.models.schema import Booking, CallbackRequest
from src.utils.config import get_current_user
from src.utils.intasend_config import create_payment
from src.utils.mpeas_config import get_access_token, initiate_stk_push, check_transaction_status, \
    wait_for_callback_and_get_transaction_id, notify_booking_process

from mpesasync.contracts import STKPushResult

from src.utils.mpesasync_config import mpesa_app

router = APIRouter(
    prefix="/booking",
    tags=["booking"],
)

@router.post("/{event_id}")
async def book_event(event_id: str, booking: Booking):

    await mpesa_app.authorize(consumer_key="YOUR CONSUMER KEY",
                              consumer_secret="YOUR CONSUMER SECRET")
    await mpesa_app.stk_push(
        amount=1.0, phone_number="phone number"
    )




    # payment_response = await initiate_stk_push(phone_number=booking.phoneNumber,amount=booking.totalCost)

    # if payment_response.get("ResponseCode") != "0":
    #     raise HTTPException(
    #         status_code=400, detail="Failed to initiate STK push. Please try again."
    #     )
    #
    # checkout_request_id = payment_response.get("CheckoutRequestID")
    #
    # transaction_id = await wait_for_callback_and_get_transaction_id(checkout_request_id)
    #
    # print(f'Booking Transaction id: {transaction_id}')
    #
    # transaction_response = await check_transaction_status(transaction_id)
    #
    # print(f' Booking transaction process : {transaction_response}')
    # if transaction_response.get("ResultCode") != 0:
    #     raise HTTPException(status_code=400, detail="Payment validation failed.")

    # return payment_response


@router.post("/transaction-status")
async def get_transaction_status(transaction_id: str):
    response = check_transaction_status(transaction_id)
    return {"message": "Transaction status fetched", "response": response}

@router.post("/callback")
async def mpesa_callback(data: STKPushResult):

    print(data)

    """
    Handle Mpesa payment callback.
    """


    try:
        print("Callback Called")

        # raw_body = await request.body()
        # print("Raw Request Body:", raw_body)
        #
        # data = await request.json()
        # print("Callback Received:", data)
        # result_code = data["Body"]["stkCallback"]["ResultCode"]
        # callback_metadata = data["Body"]["stkCallback"]["CallbackMetadata"]["Item"]
        #
        # print(f'Callback Metadata : {callback_metadata}')
        # print(f'Callback Result code : {result_code}')
        #
        # if result_code == 0:
        #     transaction_id = next(
        #         (item["Value"] for item in callback_metadata if item["Name"] == "MpesaReceiptNumber"), None
        #     )
        #     phone_number = next(
        #         (item["Value"] for item in callback_metadata if item["Name"] == "PhoneNumber"), None
        #     )
        #     amount_paid = next(
        #         (item["Value"] for item in callback_metadata if item["Name"] == "Amount"), None
        #     )
        #
        #     # Save transaction to database
        #     # save_transaction_to_db(transaction_id, phone_number, amount_paid)
        #
        #     # Notify the main booking process
        #     background_tasks.add_task(notify_booking_process, transaction_id)
        # else:
        #     print("Transaction Failed")
        #
        #     raise HTTPException(status_code=500, detail=f"Payment Failed: {result_code}")
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"An error Occured in callback {str(e)}")

    return {"status": "success"}


@router.post("/timeout")
async def handle_timeout(request: Request):
    data = await request.json()
    # Extract useful information
    result_desc = data.get("ResultDesc")
    transaction_id = data.get("TransactionID")
    print(f"Timeout occurred: {result_desc}, Transaction ID: {transaction_id}")

    # Notify user or retry logic
    return {"status": "Timeout received and processed"}
