# backend/main.py
from fastapi import FastAPI
from api.v1.api import router as api_router
from database import engine, Base
from fastapi.middleware.cors import CORSMiddleware
from config import settings

Base.metadata.create_all(bind=engine)


app = FastAPI(title="Initial System API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health():
    return {"status": "OK"}
app.include_router(api_router, prefix="/v1")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=settings.PORT)
