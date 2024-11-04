from fastapi import APIRouter

router = APIRouter(
    prefix="/booking",
    tags=["booking"],
)

router.get('/')
async def get_bookings_counts():
    booking = 0