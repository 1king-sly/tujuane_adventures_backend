from typing import Annotated

from fastapi import UploadFile, Form
from pydantic import BaseModel

class UserLogin(BaseModel):
    email: str
    password: str

class UserIn(UserLogin):
    fullName: str

class UserOut(BaseModel):
    fullName: str
    email: str

class UserDB(UserOut):
    hashed_password: str

class Activity(BaseModel):
    name: Annotated[str, Form()]
    location: str
    date: str
    price:int
    discount:int | None = None
    image: UploadFile | None = None

class TestimonyCreate(BaseModel):
    content:str

class Booking(BaseModel):
    people:int
    totalCost:int
    phoneNumber:str

class CallbackRequest(BaseModel):
    Body: dict
