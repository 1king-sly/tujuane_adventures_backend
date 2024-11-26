from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, status,  Form, UploadFile

from src.models.schema import  TestimonyCreate
from src.utils.cloudinary_config import upload_image
from src.utils.config import get_current_user
from typing import Annotated, List

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

@router.get("/")
async def get_events():
    try:
        events = await prisma.activity.find_many(
            order={
                "createdAt":"desc"
            }
        )
        return events
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/{event_id}")
async def get_single_event(event_id:str):
    try:
        event = await prisma.activity.find_unique(
            where={
                "id":event_id
            }
        )
        if not event:
            raise HTTPException(status_code=404, detail="Event Not Found")
        return event
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{event_id}/uploads")
async def get_images(event_id:str):
    try:
        uploads = await prisma.activity.find_unique(
            where={
                "id":event_id
            },
            select={
                "images":True,
                "testimonies":True
            }

        )
        if not uploads:
            raise HTTPException(status_code=404, detail="Images Not Found")
        return uploads
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{event_id}/bookings")
async def get_bookings(event_id:str,user = Depends(get_current_user)):
    try:
        if not user:
            raise HTTPException(status_code=404, detail="User Not Found")

        if user.role != "ADMIN":
            raise HTTPException(status_code=401, detail="User Not Admin")

        bookings = await prisma.activity.find_unique(
            where={
                "id": event_id
            },
            select={
                "bookings": True
            }
        )
        return bookings
    except Exception as e:
        raise HTTPException(status_code=400,detail=str(e))


@router.post("/{event_id}/testimony")
async def create_testimony(event_id:str,testimony:TestimonyCreate,user= Depends(get_current_user)):
    try:
        if not user:
            raise HTTPException(status_code=404, detail="user Not Found")

        match user.role:
            case "PARTNER":
                testimony = await prisma.testimony.create(
                    data={
                        "content":testimony.content,
                        "partnerId":user.id,
                        "activityId":event_id
                    }
                )
                return testimony
            case "CLIENT":
                testimony = await prisma.testimony.create(
                    data={
                        "content":testimony.content,
                        "clientId":user.id ,
                        "activityId":event_id

                    }
                )
                return testimony

    except Exception as e:
        raise HTTPException(status_code=400,detail=str(e))


@router.post("/{event_id}/upload")
async def upload_images(event_id:str,images:List[UploadFile],user= Depends(get_current_user)):
    try:
        if not user:
            raise HTTPException(status_code=404, detail="user Not Found")
        if user.role != "ADMIN":
            raise HTTPException(status_code=401, detail="User Not Admin")

        images_url = []

        for image in images:
            image_url = await upload_image(image)
            if image_url:
                images_url.append(image_url)
                
        images_upload = await prisma.activity.update(
            where={
                "id":event_id
            },
            data={
               "images" :images_url
            }

        )
        return images_upload
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.put("/{event_id}")
async def update_event(
    event_id:str,
    name: Annotated[str| None, Form()] = None,
    location: Annotated[str | None, Form()] = None,
    date: Annotated[str| None, Form()] = None,
    price: Annotated[int| None, Form()] = None,
    image: UploadFile | None = None,
    discount: Annotated[int | None, Form()] = None,
    max_attendees: Annotated[int | None, Form()] = None,
    user=Depends(get_current_user),):


    logo =None
    newPrice = None
    try:
        if not user:
            raise HTTPException(status_code=404,detail="User Not Found")

        if discount and discount > 0:
            newPrice = price - (price * discount / 100)
        if date:
            date = datetime.fromisoformat(date)

        if image:
            logo = await upload_image(image)

            if not logo:
                if not logo:
                    raise HTTPException(status_code=400, detail="Failed to upload image")
        data = {}
        if name:
            data["name"] = name
        if location:
            data["location"] = location
        if date:
            data["date"] = date
        if price:
            data["pricePerPerson"] = price
        if discount:
            data["discount"] = discount
        if newPrice:
            data["newPrice"] = newPrice
        if max_attendees:
            data["maxAttendees"] = max_attendees
        if logo:
            data["logo"] = logo

        updated_event = await prisma.activity.update(
            where={
                "id":event_id
            },
            data=data
        )
        return updated_event
    except Exception as e:
        raise HTTPException(status_code=400,detail=str(e))

@router.delete("/{event_id}")
async def delete_event(event_id:str, user = Depends(get_current_user)):
    try:
        if not user:
            raise HTTPException(status_code=404, detail="User Does Not Exist")
        if user.role != "ADMIN":
            raise HTTPException(status_code= 401, detail = "User Not Admin")
        deleted_event = await prisma.activity.delete(
            where={
                "id":event_id
            }
        )
        return deleted_event
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))