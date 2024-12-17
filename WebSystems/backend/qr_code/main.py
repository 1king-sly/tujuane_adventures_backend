from fastapi import FastAPI
import qrcode
from io import BytesIO

from src.config.cloudinary_config import upload_image



app = FastAPI()

@app.get("/")
async def create_qrcode():
    
    data_to_encode = "https://www.youtube.com/watch?v=ZGJxTuYJP8o&list=RDEMiH8aXmL0GBif6quidMdHew&index=27"
    
    qr = qrcode.QRCode(version=1, box_size=10, border=5)
    qr.add_data(data_to_encode)
    qr.make(fit=True)
    
    qr_image = qr.make_image(fill="black", back_color="white")
    buffer = BytesIO()
    qr_image.save(buffer, format="PNG")
    buffer.seek(0)
    
    image_url = await upload_image(buffer)
    
    return image_url
    
    
    
 
    
