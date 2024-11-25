from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, status, Body, Form, UploadFile

from src.models.schema import Activity
from src.utils.cloudinary_config import upload_image
from src.utils.config import get_current_user
from pydantic import BaseModel
from typing import Annotated

from src.db import prisma


router = APIRouter(
    prefix="/events",
    tags=["events"],
)




@router.post('/create')
async def create_event(
    name: Annotated[str, Form()],
    location: Annotated[str, Form()],
    date: Annotated[str, Form()],
    price: Annotated[int, Form()],
    image: UploadFile | None = None,
    discount: Annotated[int | None, Form()] = None,
    max_attendees: Annotated[int | None, Form()] = None,
    user=Depends(get_current_user),):

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token",
        )



    image_url = await upload_image(image)

    if not image_url:
        raise HTTPException(status_code=404, detail="Image Not Found")

    new_price = None
    if discount and discount > 0:
        new_price = price - (price * discount / 100)

    # Parse the date to match the `DateTime` type in the model
    try:
        parsed_date = datetime.fromisoformat(date)
    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid date format. Use ISO format.")

    try:
        activity =  await prisma.activity.create(
            data={
                "name": name,
                "location": location,
                "date": parsed_date,
                "pricePerPerson": price,
                "discount": discount,
                "newPrice": new_price,
                "createdById": user.id,
                "logo": image_url,
                "maxAttendees":max_attendees
            }
        )

        return activity
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
