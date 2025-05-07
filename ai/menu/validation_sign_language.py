import os
from dotenv import load_dotenv
from pymongo import MongoClient
from langchain_openai import ChatOpenAI
from langchain_community.document_loaders import PyMuPDFLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain_openai import OpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain.retrievers import BM25Retriever, EnsembleRetriever
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough

load_dotenv()
api_key = os.getenv("OPEN_AI_KEY")
mongo_db_url = os.getenv("MONGO_DB_URL")
client = MongoClient(mongo_db_url)
db = client["dev"]

embeddings = OpenAIEmbeddings(model="text-embedding-ada-002", api_key=api_key)
loader = PyMuPDFLoader("한국수어문법.pdf")
data = loader.load()


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
                weights=[0.3, 0.7]
            )
    
    return retriever

grammer = ""

for i in range(7, 16):
    grammer += (" " + data[i].page_content)

prompt = ChatPromptTemplate.from_messages([
    ("system", f"""
     {grammer}

     You are an expert in Korean Sign Language (KSL) and its grammar rules. Your task is to verify and correct the word order of a given description according to KSL grammar. 

    - The input consists of a list of words representing a sentence in KSL.
    - You must **only rearrange the words** to match proper KSL grammar.
    - **Do not add or remove any words**—use only the words given in the input.
    - The output format must be the same as the input: words separated by ", ".
    - Follow the correct KSL sentence structure, ensuring that verbs and adjectives are placed appropriately.

    **Example**
    ### Input:
    # Menu: americano Description: "당, 우유, 없다, 커피, 진하다, 쓰다"
    ### Output:
    # 당, 우유, 커피, 진하다, 쓰다, 없다
    
    Now, process the following input and return only the corrected description in the required format.
     """),
    ("user", "#Context: {context}\n\n#Menu: {menu}\n\n#Description: {description}")
])


def get_validation_of_menu(menu):


    menu_collection = db["menu"]

    menu_data = menu_collection.find_one({"name": menu}, {"sign_language_description": 1})

    if not menu_data or "sign_language_description" not in menu_data:
        print(f"{menu} 메뉴에 대한 sign_language_description이 없습니다.")
        return []
    
    description = menu_data["sign_language_description"]

    retriever = get_retriever()

    model = ChatOpenAI(temperature=0.6, model="gpt-4o", api_key=api_key)

    rag_chain = prompt | model

    response = rag_chain.invoke({"context": retriever, "menu": menu, "description" : description})

    print(response.content)

    result_dict = {'fixed_sign_language_description': response.content}

    return result_dict


# get_validation_of_menu("sandwich")