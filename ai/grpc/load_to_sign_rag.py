import os
from dotenv import load_dotenv
import json
from langchain_openai import ChatOpenAI
from langchain_community.document_loaders import PyMuPDFLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain_openai import OpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_community.retrievers import BM25Retriever
from langchain.retrievers import EnsembleRetriever
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from pydantic import BaseModel
from typing import List
from langchain.output_parsers import PydanticOutputParser
from pymongo import MongoClient

import load_sim

load_dotenv()
api_key = os.getenv("OPEN_AI_KEY")
env = os.getenv('APP_ENV', 'local')

embeddings = OpenAIEmbeddings(model="text-embedding-ada-002", api_key=api_key)

if env == 'production':
    loader = PyMuPDFLoader("docs/한국수어문법.pdf")
else:
    loader = PyMuPDFLoader("../docs/한국수어문법.pdf")
mongo_db_url = os.getenv("MONGO_DB_URL")
client = MongoClient(mongo_db_url)
db = client["dev"]
data = loader.load()
grammer = ""



for i in range(7, 16):
    grammer += (" " + data[i].page_content)

if env == 'production':
    path = 'gesture_dict/60_v18_pad_gesture_dict.json'
else:
    path = '../gesture_dict/60_v18_pad_gesture_dict.json'

with open(path, 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)

actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]


gesture_vocab = ", ".join(actions)

class KSLTranslation(BaseModel):
    signs: List[str]

ksl_parser = PydanticOutputParser(pydantic_object=KSLTranslation)

to_sign_language_prompt = ChatPromptTemplate.from_messages([
    ("system", f"""
     {grammer}

     You should answer in Korean Sign Language (KSL). Please transform the sentence based on the given KSL grammar rules, including compound words, compound verbs, and combined actions, following the structure presented in the provided material. After transforming the sentence, please arrange the elements according to the KSL grammar structure, showing the correct order of signs.

     ⚠️ **Guideline for Omitting Formal Expressions** ⚠️  
    The following formal sentence endings and auxiliary verbs — **'합니다', '입니다', '이다', '하다'** — must be **strictly excluded** from the output.  
    These expressions are **grammatical markers in Korean** and carry no semantic value in Korean Sign Language (KSL). KSL is meaning-focused, and such formalities are omitted entirely.

    Examples:
    - "감사합니다" → ['감사']
    - "학생입니다" → ['학생']
    - "공부하다" → ['공부']

    ✅ Ensure that these expressions are **never included** in the transformed KSL sentence.  
    Only include signs that carry actual meaning in KSL.


     ⚠️ **Allowed Vocabulary Words** ⚠️  
     You must use only the following KSL signs when forming your answer:  
     [{gesture_vocab}]

     When dealing with question forms, distinguish between:

     1. **'무엇'** (what): Use when replacing a noun with an unknown (e.g., "이것은 무엇입니까?" → ['이것', '무엇']).
     2. **'물음표'** (question mark): 
        - Use when the sentence **ends with a "?"**, or when the sentence is a **yes/no question** or **choice-based question**.  
        - If "?" appears in the input sentence, it must be represented with **'물음표'** in the output.  
        - In **choice-based questions** (e.g., "현금이세요? 카드이세요?"), do not use '무엇1'. Instead, append '물음표' after each item:  
          e.g., "현금이세요? 카드이세요?" → ['현금', '물음표', '카드', '물음표']
     3. **'어디'** (where): Use only when location is being questioned. (e.g., "어디에 있어요?" → ['어디', '있다']).

     ⚠️ Especially for **choice-based questions** (e.g., "현금이세요? 카드이세요?"), you must avoid using '무엇1'. Instead, append '물음표' after each item to indicate they are separate questions. For example:
     "현금이세요? 카드이세요?" → ['현금', '물음표', '카드', '물음표']

     For compound words like [강원도], you should break it down into its components based on KSL grammar. For example, '강원도' is made up of two concepts: [산] (mountain) and [흐르다] (flow). Therefore, [강원도] is represented by simultaneously showing [산] and [흐르다] using both hands.

     Some compound words may not directly map to the sum of their individual components' meanings. For example, [검정] (black) and [벌레] (bug) when combined form the meaning of [개미] (ant), not [black bug]. Similarly, words like [바지저고리] represent a "country-style person," which cannot be directly deduced from its individual parts. Please be aware of such special compound words and apply the correct KSL transformation.

     For verbs, if a compound verb is present, such as [알리다], you should break it down into its individual components, such as [알다] (know) and [주다] (give), and show them in sequence according to KSL grammar.

     Please make sure that all words used in the transformation exist within the established KSL signs. Use only valid KSL signs to form the sentence, and ensure that the transformed sentence follows the KSL grammar structure and utilizes correct sign language vocabulary.

     After transforming the sentence, please **only show the transformed KSL sentence** without any additional explanation or breakdown. Just display the final KSL sentence using the correct signs and their order according to KSL grammar.
     """),
    ("user", "#Format: {format_instructions}\n\nContext: {context}\n\nQuestion: {question}")
])

to_sign_language_prompt = to_sign_language_prompt.partial(format_instructions=ksl_parser.get_format_instructions())

class DebugPassThrough(RunnablePassthrough):
    def invoke(self, *args, **kwargs):
        output = super().invoke(*args, **kwargs)
        # print("Debug Output:", output)
        return output
    
    
class ContextToText(RunnablePassthrough):
    def invoke(self, inputs, config=None, **kwargs):
        context_text = "\n".join([f"Page {doc.metadata.get('page', 'Unknown')}: {doc.page_content}" for doc in inputs["context"]])
        # print(context_text)
        return {"context": context_text, "question": inputs["question"]}

def get_retriever():
    text_splitter = CharacterTextSplitter(
        separator="\n\n",
        chunk_size=2000,
        chunk_overlap=20,
        length_function=len,
        is_separator_regex=False,
    )

    splits_char = text_splitter.split_documents(data)
    splits = splits_char


    vectorstore = FAISS.from_documents(documents=splits, embedding=embeddings)

    bm25_retriever = BM25Retriever.from_documents(splits)
    faiss_retriever = vectorstore.as_retriever(search_type="similarity", search_kwargs={"k": 7})

    retriever = EnsembleRetriever(
                retrievers=[bm25_retriever, faiss_retriever],
                weights=[0.3, 0.7]  # 가중치 설정 (가중치의 합은 1.0)
            )
    
    return retriever

def get_translate_to_sign_language(text):

    retriever = get_retriever()

    model = ChatOpenAI(temperature=0.6, model="gpt-4o", api_key=api_key)

    chain = (
        {
            "context": retriever,
            "question": DebugPassThrough()
        }
        | DebugPassThrough()
        | ContextToText()
        | to_sign_language_prompt
        | model
        | ksl_parser
    )

    result: KSLTranslation = chain.invoke(text)

    return result.signs


import re

def get_sign_language_url_list(inqury):
    sign_language_collection = db["avatar_sign_language"]

    escaped_inqury = re.escape(inqury)

    potential_matches = list(sign_language_collection.find({
        "name": {"$regex": f"^{escaped_inqury}", "$options": "i"}
    }))

    if potential_matches:
        for match in potential_matches:
            if match["name"].strip().lower() == inqury.strip().lower():
                print("🎯 원문 정확 일치:", match["name"])
                return [match["url"]]
        
        print("🔎 부분 일치 사용:", potential_matches[0]["name"])
        return [potential_matches[0]["url"]]

    sign_language_inqury = get_translate_to_sign_language(inqury)
    print(f"✨ 한국 수어 문법 문장 : {sign_language_inqury}")
    words = sign_language_inqury

    recombined_word = "".join(words)
    recombined_match = sign_language_collection.find_one({"name": {"$regex": f"^{recombined_word}$", "$options": "i"}})
    if recombined_match:
        print("🔁 변환된 단어 조합으로 매칭 성공:", recombined_word)
        return [recombined_match["url"]]

    sign_data_list = list(sign_language_collection.find({"name": {"$regex": "|".join(words), "$options": "i"}}))
    sign_data_map = {item['name']: item for item in sign_data_list} 

    url_list = []

    for word in words:
        if word in sign_data_map:
            url_list.append(sign_data_map[word]["url"])
        else:
            print(f"👮 데이터 셋에 없는 단어입니다! {word}")
            similar_word = load_sim.get_most_similar_word(word)
            if similar_word != "":
                print(f"유사한 단어는 찾았습니다: {similar_word}")
                similar_data = sign_language_collection.find_one({"name": {"$regex": similar_word}})
                if similar_data and "url" in similar_data:
                    url_list.append(similar_data["url"])

    return url_list

# urls = get_sign_language_url_list("저는 직원입니다")
# print("\n📦 전체 URL 리스트:")
# for i, url in enumerate(urls, 1):
#     print(f"{i}. {url}")