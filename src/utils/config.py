import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

from src.db import prisma
from src.utils.auth import decode_token, SECRET_KEY, ALGORITHM

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    if payload is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    email: str = payload.get("sub")
    if email is None:
        raise HTTPException(status_code=404,detail="Email not found")



    staff = await prisma.staff.find_unique(where={"id": email})
    partner =await prisma.partner.find_unique(where={"id": email})
    client =await prisma.client.find_unique(where={"id": email})

    if staff:
        return staff
    elif partner:
        return partner
    elif client:
        return client

    else:
        raise HTTPException(status_code=404,detail="Account not found")

