from fastapi import APIRouter, Depends,HTTPException

from src.models.schema import Booking
from src.utils.config import get_current_user
from src.utils.intasend_config import create_payment

router = APIRouter(
    prefix="/booking",
    tags=["booking"],
)

@router.post("/{event_id}")
async def book_event(event_id: str, booking: Booking):



    payment_response = await create_payment()
    print(payment_response)