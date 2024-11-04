from fastapi import APIRouter,Depends
from starlette.requests import Request
from config import get_current_user


router = APIRouter(
    prefix="/events",
    tags=["events"],
)

router.get('/')
async def create_event(req:Request):
    data = req

router.get("/protected")
async def read_protected_data(current_user: dict = Depends(get_current_user)):
    return {"message": f"Hello, {current_user['sub']}!"}