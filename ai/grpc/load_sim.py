import torch
from sentence_transformers import SentenceTransformer, util
import os
import json
from dotenv import load_dotenv
from concurrent.futures import ThreadPoolExecutor

load_dotenv()
HF_TOKEN = os.getenv("HF_TOKEN")
env = os.getenv('APP_ENV', 'local')

if env == 'production':
    path = 'gesture_dict/60_v18_pad_gesture_dict.json'
else:
    path = '../gesture_dict/60_v18_pad_gesture_dict.json'

with open(path, 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)

actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]

os.environ["HUGGINGFACEHUB_API_TOKEN"] = HF_TOKEN
model = SentenceTransformer('jhgan/ko-sbert-nli')

def get_sentence_embedding(sentences):
    if not sentences:  
        return torch.zeros(len(sentences), 768)

    sentence_embeddings = model.encode(sentences, convert_to_tensor=True)
    return sentence_embeddings

def compute_similarity_batch(embeddings1, embeddings2):
    similarity = util.pytorch_cos_sim(embeddings1, embeddings2)
    return similarity

def compute_similarity_batch(embeddings1, embeddings2):
    if embeddings1.size(0) == 1 and embeddings2.size(0) == 1:
        return util.pytorch_cos_sim(embeddings1, embeddings2).unsqueeze(0)

    similarity = util.pytorch_cos_sim(embeddings1, embeddings2)
    return similarity

def get_most_similar_word(word):
    candidates = []
    input_embedding = get_sentence_embedding([word])

    actions_embeddings = get_sentence_embedding(actions)

    similarities = compute_similarity_batch(input_embedding, actions_embeddings)

    if similarities.size(0) == 1: 
        similarities = similarities.squeeze(0)

    for i, similarity in enumerate(similarities):
        if similarity > 0.6:
            candidates.append((actions[i], similarity.item()))

    candidates.sort(key=lambda x: x[1], reverse=True)

    if len(candidates) < 1:
        return ""
    
    most_similar = candidates[0]
    print(f"유사한 단어 : {most_similar[0]}, 유사도 : {most_similar[1]}")
    return most_similar[0]



# similar_words = get_most_similar_from_actions("설탕")
# print(similar_words)
