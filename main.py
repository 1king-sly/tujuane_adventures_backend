from mpesasync.contracts import STKPushResult

from src.routes import auth_router, booking, events
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src.db import connect_db, disconnect_db






app = FastAPI()



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
    return {"message": "Hello Byrone"}

@app.post("stkpush/callback")
def stk_push_callback(data: STKPushResult):
    ## do your zing
    print("Callback called")
    print(data)
    return {"OK"}




