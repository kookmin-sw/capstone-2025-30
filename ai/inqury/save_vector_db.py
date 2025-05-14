from sentence_transformers import SentenceTransformer
from langchain_community.vectorstores import FAISS
from langchain_core.documents import Document
from langchain.embeddings import HuggingFaceEmbeddings
from pymongo import MongoClient
import pickle
from dotenv import load_dotenv
import os


load_dotenv()
model = SentenceTransformer('jhgan/ko-sbert-nli')
mongo_db_url = os.getenv("MONGO_DB_URL")
client = MongoClient(mongo_db_url)
db = client["dev"]

collection = db["sign_language"]

sign_items = list(collection.find({}, {"_id": 0, "name": 1, "url": 1}))

docs = [Document(page_content=item["name"], metadata={"url": item["url"]}) for item in sign_items]

embeddings = HuggingFaceEmbeddings(model_name="jhgan/ko-sbert-nli")
vectorstore = FAISS.from_documents(docs, embeddings)

vectorstore.save_local("vectorstore/sign_words")
