import os
from dotenv import load_dotenv


from mpesasync import MpesaEnvironment
from mpesasync.lipa_na_mpesa import STKPush

load_dotenv()

DARAJA_CONSUMER_KEY = os.getenv('DARAJA_CONSUMER_KEY')
DARAJA_CONSUMER_SECRET = os.getenv('DARAJA_CONSUMER_SECRET')
DARAJA_API_URL = os.getenv('DARAJA_API_URL')
CALLBACK_URL = os.getenv('CALLBACK_URL')
SHORTCODE = os.getenv('SHORTCODE')
PASSKEY = os.getenv('PASSKEY')
TOKEN_URL=f"{DARAJA_API_URL}/oauth/v1/generate?grant_type=client_credentials"
STK_PUSH_URL = f"{DARAJA_API_URL}/mpesa/stkpush/v1/processrequest"

mpesa_app = STKPush(
        Environment=MpesaEnvironment.sandbox, # use sandbox to authenticate with sandbox credentials
        BusinessShortCode=SHORTCODE,
        CallBackURL="https://07a6-197-248-74-74.ngrok-free.app/booking/callback",
        PassKey=PASSKEY
    )