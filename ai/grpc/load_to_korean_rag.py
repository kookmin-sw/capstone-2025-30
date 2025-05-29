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

load_dotenv()
api_key = os.getenv("OPEN_AI_KEY")
embeddings = OpenAIEmbeddings(model="text-embedding-ada-002", api_key=api_key)

env = os.getenv('APP_ENV', 'local')

if env == 'production':
    loader = PyMuPDFLoader("docs/한국수어문법.pdf")
else:
    loader = PyMuPDFLoader("../docs/한국수어문법.pdf")

data = loader.load()
grammer = ""

for i in range(7, 16):
    grammer += (" " + data[i].page_content)

if env == 'production':
    path = 'gesture_dict/60_v22_pad_gesture_dict.json'
else:
    path = '../gesture_dict/60_v22_pad_gesture_dict.json'

with open(path, 'r', encoding='utf-8') as f:
    gesture_dict = json.load(f)

actions = [gesture_dict[str(i)] for i in range(len(gesture_dict))]


to_korean_prompt = ChatPromptTemplate.from_messages([
    ("system", f"""
    {grammer}

    Convert the given Korean Sign Language (KSL) input into a natural Korean sentence. The input will include actions and postures (e.g., 고개숙이기, 상체숙이기) in addition to words. Follow these rules to ensure accurate and contextually appropriate translation:

    1. **Interpret KSL Actions and Postures**:
       - Analyze the actions and postures included in the KSL input (e.g., 고개숙이기, 상체숙이기) and translate them into corresponding natural expressions in Korean.
       - Integrate the meaning of these gestures seamlessly into the sentence.
       - For non-verbal gestures (e.g., 고개숙이기), do not enclose them in brackets. Simply describe them naturally in Korean.

    2. **Rearrange According to Korean Grammar**:
       - Rearrange the input sequence, often following Subject-Object-Verb (SOV) order, into a natural Subject-Verb-Object (SVO) structure typical of Korean.
       - Ensure that the final output is grammatically correct and coherent.

    3. **Handle Compound Words and Idiomatic Expressions**:
       - For compound words or phrases (e.g., 휴지 청소), ensure they are translated into the most natural equivalent in Korean.
       - Interpret idiomatic or symbolic expressions in a contextually appropriate manner.

    4. **Preserve the Context and Intent**:
       - Retain the original intent, tone, and context of the KSL input when translating into Korean.
       - Ensure that the final Korean sentence accurately conveys the intended meaning of the KSL input.

    5. **Output Only the Final Translation**:
       - Provide only the final Korean translation. Do not include additional explanations or intermediate steps.

    Example Input:
    - Input: [어머니] 시선응시 [나] 휴지 [청소] [해라] 고개숙이기 상체숙이기
    - Output: 어머니께서 나에게 청소를 하라고 하셨다.

    Format for the output:
    - [Translated Sentence]
    """),
    ("user", "Context: {context}\n\nQuestion: {question}")
])

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

def get_translate_from_sign_language(text):

    solo_words = ["포크", "휴지"]
    cleaned_text = text.strip()

    for word in solo_words:
        if cleaned_text.startswith(word):
            return f"{word}가 있나요?"
    
    retriever = get_retriever()
    model = ChatOpenAI(temperature=0.6, model="gpt-4o", api_key=api_key)
    rag_chain_debug = {
        "context": retriever,                  
        "question": DebugPassThrough()       
    }  | DebugPassThrough() | ContextToText()|   to_korean_prompt | model

    response = rag_chain_debug.invoke(text)

    return response.content
    return text