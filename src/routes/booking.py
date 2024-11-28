from fastapi import APIRouter, Depends,HTTPException

from src.models.schema import Booking
from src.utils.config import get_current_user
from src.utils.intasend_config import create_payment

router = APIRouter(
    prefix="/booking",
    tags=["booking"],
)

@router.post("/{event_id}")
async def book_event(event_id: str, booking: Booking, user = Depends(get_current_user)):

    print(booking.model_dump())
    if not user:
        raise HTTPException(status_code=404, detail="User Not Found")

    payment_response = await create_payment(amount=booking.totalCost,phone_number=booking.phoneNumber)
    print(payment_response)