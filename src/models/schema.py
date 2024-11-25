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

