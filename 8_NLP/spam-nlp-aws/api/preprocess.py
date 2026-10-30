"""Same preprocessing as the notebook (kept in one place so API and notebook match)."""
import re
import string

import emoji
import nltk
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from nltk.tokenize import word_tokenize
from spellchecker import SpellChecker

for pkg in ["punkt", "punkt_tab", "stopwords", "wordnet", "omw-1.4"]:
    nltk.download(pkg, quiet=True)

chat_words = {
    "u": "you", "ur": "your", "r": "are", "plz": "please", "pls": "please", "thx": "thanks",
    "asap": "as soon as possible", "b4": "before", "2": "to", "4": "for", "tonite": "tonight",
    "lol": "laughing out loud", "lmao": "laughing", "omg": "oh my god", "brb": "be right back",
    "gtg": "got to go", "ttyl": "talk to you later", "idk": "i do not know", "btw": "by the way",
    "af": "very", "gonna": "going to", "wanna": "want to", "txt": "text", "msg": "message",
    "yr": "your", "bro": "brother", "tmrw": "tomorrow", "fr33": "free", "acount": "account",
}

stop_words = set(stopwords.words("english"))
lemmatizer = WordNetLemmatizer()
spell = SpellChecker()
_spell_cache = {}


def remove_html(text):
    return re.sub(r"<.*?>", " ", text)


def remove_urls(text):
    return re.sub(r"(https?://\S+|www\.\S+|\b\S+\.(com|biz|ru|xyz|top|info|io|co)\S*)", " ", text)


def chat_conversion(text):
    return " ".join(chat_words.get(w, w) for w in text.split())


def handle_emoji(text):
    return emoji.demojize(text, delimiters=(" ", " ")).replace("_", " ")


def remove_punct(text):
    return text.translate(str.maketrans("", "", string.punctuation))


def correct_spelling(text):
    out = []
    for w in text.split():
        if w not in _spell_cache:
            if w.isalpha() and w in spell.unknown([w]):
                _spell_cache[w] = spell.correction(w) or w
            else:
                _spell_cache[w] = w
        out.append(_spell_cache[w])
    return " ".join(out)


def remove_stopwords(text):
    return " ".join(w for w in text.split() if w not in stop_words)


def lemmatize_tokens(tokens):
    return [lemmatizer.lemmatize(lemmatizer.lemmatize(t, pos="v"), pos="n") for t in tokens]


def preprocess(text):
    text = text.lower()
    text = remove_html(text)
    text = remove_urls(text)
    text = chat_conversion(text)
    text = handle_emoji(text)
    text = remove_punct(text)
    text = re.sub(r"\d+", " ", text)
    text = re.sub(r"\s+", " ", text).strip()
    text = correct_spelling(text)
    text = remove_stopwords(text)
    tokens = word_tokenize(text)
    return " ".join(lemmatize_tokens(tokens))
