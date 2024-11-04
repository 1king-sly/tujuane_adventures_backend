from routes import auth_router,booking,events
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from db import prisma, connect_db, disconnect_db






app = FastAPI()

origins = [
    "http://localhost:3000/",  # Allow your frontend application
    "https://your-frontend-domain.com",  # Allow your production frontend domain
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Update this with your frontend URL if applicable
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth_router.router)
app.include_router(booking.router)
app.include_router(events.router)

# Connect to the database before the application starts
@app.on_event("startup")
async def startup():
    await connect_db()

# Disconnect from the database when the application stops
@app.on_event("shutdown")
async def shutdown():
    await disconnect_db()


@app.get("/")
async def root():
    return {"message": "Hello World"}




