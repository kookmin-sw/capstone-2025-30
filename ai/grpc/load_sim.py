from sentence_transformers import SentenceTransformer, util
import torch
import json
import os
from dotenv import load_dotenv

load_dotenv()
HF_TOKEN = os.getenv("HF_TOKEN")

# 배포용
with open('gesture_dict/v6_pad_gesture_dict.json', 'r', encoding='utf-8') as f:

# # 로컬용
# with open('../gesture_dict/v6_pad_gesture_dict.json', 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)

actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]

os.environ["HUGGINGFACEHUB_API_TOKEN"] = HF_TOKEN
model = SentenceTransformer('jhgan/ko-sbert-nli')

def get_sentence_embedding(sentence):
    if not sentence:  
        return torch.zeros(768) 

    sentence_embedding = model.encode([sentence], convert_to_tensor=True)
    return sentence_embedding.squeeze()  

def compute_similarity(emb1, emb2):
    if emb1.dim() == 0:
        emb1 = emb1.unsqueeze(0)
    if emb2.dim() == 0:
        emb2 = emb2.unsqueeze(0)

    similarity = util.pytorch_cos_sim(emb1, emb2)
    return similarity.item()

def get_most_similar_word(word):
    candidates = []

    input_embedding = get_sentence_embedding(word)

    for action in actions:
        action_embedding = get_sentence_embedding(action)
        similarity = compute_similarity(input_embedding, action_embedding)

        if similarity > 0.6:
            # print(f"유사도 : {similarity}, 비교대상 : {word}, 유사한 단어: {action}")
            candidates.append((action, similarity))

    candidates.sort(key=lambda x: x[1], reverse=True)
    if len(candidates) < 1:
        return ""
    most_similar = candidates[0]
    print(f"유사한 단어 : {most_similar[0]}, 유사도 : {most_similar[1]}")
    return most_similar[0]

# similar_words = get_most_similar_from_actions("설탕")
# print(similar_words)
