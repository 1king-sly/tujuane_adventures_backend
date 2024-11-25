from fastapi import APIRouter, Depends, HTTPException, status,Body
from src.utils.config import get_current_user
from pydantic import BaseModel
from typing import Annotated


router = APIRouter(
    prefix="/events",
    tags=["events"],
)

class Activity(BaseModel):
    name: str
    location: str
    date: str
    price:int
    discount:int | None = None


@router.post('/create')
async def create_event(activity: Annotated[Activity,Body(embed=True)],user: dict = Depends(get_current_user)):
    print(activity.model_dump())

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token",
        )
    print(user)

# @router.get("/protected")
# async def read_protected_data(current_user: dict = Depends(get_current_user)):
#     return {"message": f"Hello, {current_user['sub']}!"}