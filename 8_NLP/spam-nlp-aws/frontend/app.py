import os

import requests
import streamlit as st

API_URL = os.getenv("API_URL", "http://localhost:8000")

st.set_page_config(page_title="Spam Classifier", page_icon="✉️")
st.title("✉️ Spam Classifier")
st.caption("TF-IDF + Naive Bayes, served by FastAPI on AWS")

message = st.text_area("Paste a message", height=140, placeholder="Congratulations!! You won a free iPhone...")

if st.button("Check", type="primary"):
    if not message.strip():
        st.warning("Please type a message first.")
    else:
        try:
            r = requests.post(f"{API_URL}/predict", json={"message": message}, timeout=30)
            r.raise_for_status()
            out = r.json()
            if out["prediction"] == "spam":
                st.error(f"SPAM  ({out['spam_probability']:.0%} sure)")
            else:
                st.success(f"NOT SPAM  ({1 - out['spam_probability']:.0%} sure)")
            st.progress(out["spam_probability"], text="Spam probability")
            with st.expander("Cleaned text the model saw"):
                st.code(out["cleaned_text"] or "(empty)")
        except requests.exceptions.RequestException:
            st.error("Cannot reach the API. If the server just started, wait 1-2 minutes and try again.")
