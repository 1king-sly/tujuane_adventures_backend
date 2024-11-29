from fastapi import APIRouter, Depends,HTTPException,Request

from src.models.schema import Booking
from src.utils.config import get_current_user
from src.utils.intasend_config import create_payment
from src.utils.mpeas_config import get_access_token,  initiate_stk_push

router = APIRouter(
    prefix="/booking",
    tags=["booking"],
)

@router.post("/{event_id}")
async def book_event(event_id: str, booking: Booking, user = Depends(get_current_user)):

    if not user:
        raise HTTPException(status_code=404, detail="User Not Found")

    payment_response = initiate_stk_push(phone_number=booking.phoneNumber,amount=booking.totalCost)

    return payment_response
@router.post("/callback")
async def payment_callback(request: Request):
    data = await request.json()
    print("Callback received:", data)


    result_code = data.get("Body", {}).get("stkCallback", {}).get("ResultCode")
    if result_code == 0:
        return {"message": "Payment successful"}
    else:
        return {"message": "Payment failed", "details": data}