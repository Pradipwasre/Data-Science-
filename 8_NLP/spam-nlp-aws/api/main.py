"""FastAPI service. On AWS it downloads the model from S3 (env var BUCKET); locally it reads ../models."""
import os

import joblib
from fastapi import FastAPI
from pydantic import BaseModel

from preprocess import preprocess

BUCKET = os.getenv("BUCKET")
FILES = ["tfidf_vectorizer.joblib", "naive_bayes_model.joblib"]

if BUCKET:
    import boto3
    MODEL_DIR = "/tmp/models"
    os.makedirs(MODEL_DIR, exist_ok=True)
    s3 = boto3.client("s3")
    for f in FILES:
        s3.download_file(BUCKET, f"models/{f}", f"{MODEL_DIR}/{f}")
else:
    MODEL_DIR = os.path.join(os.path.dirname(__file__), "..", "models")

tfidf = joblib.load(os.path.join(MODEL_DIR, FILES[0]))
model = joblib.load(os.path.join(MODEL_DIR, FILES[1]))

app = FastAPI(title="Spam Classifier API")


class Message(BaseModel):
    message: str


@app.get("/health")
def health():
    return {"status": "ok", "model_source": "s3" if BUCKET else "local"}


@app.post("/predict")
def predict(body: Message):
    cleaned = preprocess(body.message)
    proba = float(model.predict_proba(tfidf.transform([cleaned]))[0][1])
    return {
        "prediction": "spam" if proba > 0.5 else "ham",
        "spam_probability": round(proba, 3),
        "cleaned_text": cleaned,
    }
