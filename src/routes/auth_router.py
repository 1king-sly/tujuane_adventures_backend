from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel

from src.models.schema import UserOut, UserIn, UserLogin
from src.utils.auth import hash_password, verify_password, create_access_token
from src.db import prisma
router = APIRouter(
    prefix="/auth",
    tags=["auth"],
)



@router.post("/signup",response_model=UserOut)
async def signup(user: UserIn) -> UserOut:
    print(user.model_dump())
    existing_user = await prisma.client.find_unique(where={"email": user.email})
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered",
        )

    # Hash the password before saving
    hashed_password = hash_password(user.password)

    # Create new user
    new_user = await prisma.client.create(
        data={
            'fullName':user.fullName,
            "email": user.email,
            "password": hashed_password,
        }
    )

    return new_user
@router.post("/login")
async def login(form_data: UserLogin):
    user = await prisma.staff.find_unique(where={"email": form_data.email})
    if not user or not verify_password(form_data.password, user.password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = create_access_token(data={"sub": user.id})
    return {"access_token": access_token, "token_type": "bearer"}