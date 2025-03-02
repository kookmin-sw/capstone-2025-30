import os
from dotenv import load_dotenv
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage
from langchain_community.document_loaders import PyMuPDFLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain_openai import OpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain.retrievers import BM25Retriever, EnsembleRetriever
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough

load_dotenv()
api_key = os.getenv("OPEN_AI_KEY")
# OpenAI 임베딩 모델 초기화
embeddings = OpenAIEmbeddings(model="text-embedding-ada-002", api_key=api_key)
loader = PyMuPDFLoader("한국수어문법.pdf")
data = loader.load()
grammer = ""

for i in range(7, 16):
    grammer += (" " + data[i].page_content)

contextual_prompt = ChatPromptTemplate.from_messages([
    ("system", f"""
     {grammer}

     You should answer in Korean Sign Language (KSL). Please transform the sentence based on the given KSL grammar rules, including compound words, compound verbs, and combined actions, following the structure presented in the provided material. After transforming the sentence, please arrange the elements according to the KSL grammar structure, showing the correct order of signs.

     For compound words like [강원도], you should break it down into its components based on KSL grammar. For example, '강원도' is made up of two concepts: [산] (mountain) and [흐르다] (flow). Therefore, [강원도] is represented by simultaneously showing [산] and [흐르다] using both hands.

     Some compound words may not directly map to the sum of their individual components' meanings. For example, [검정] (black) and [벌레] (bug) when combined form the meaning of [개미] (ant), not [black bug]. Similarly, words like [바지저고리] represent a "country-style person," which cannot be directly deduced from its individual parts. Please be aware of such special compound words and apply the correct KSL transformation.

     For verbs, if a compound verb is present, such as [알리다], you should break it down into its individual components, such as [알다] (know) and [주다] (give), and show them in sequence according to KSL grammar.

     Please make sure that all words used in the transformation exist within the established KSL signs. Use only valid KSL signs to form the sentence, and ensure that the transformed sentence follows the KSL grammar structure and utilizes correct sign language vocabulary.

     After transforming the sentence, please **only show the transformed KSL sentence** without any additional explanation or breakdown. Just display the final KSL sentence using the correct signs and their order according to KSL grammar.
     """),
    ("user", "Context: {context}\n\nQuestion: {question}")
])

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
    
    
# 문서 리스트를 텍스트로 변환하는 단계 추가
class ContextToText(RunnablePassthrough):
    def invoke(self, inputs, config=None, **kwargs):  # config 인수 추가
        # context의 각 문서를 문자열로 결합
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

def get_translate_fron_sign_language(text_path):

    retriever = get_retriever()

    # 모델 초기화
    # temperature이 0에 가까울 수록 정확도가 높은 답변만을 선택함 (1에 가까울수록 랜덤성을 가미함)
    model = ChatOpenAI(temperature=0.6, model="gpt-4o", api_key=api_key)

    # RAG 체인에서 각 단계마다 DebugPassThrough 추가
    rag_chain_debug = {
        "context": retriever,                    # 컨텍스트를 가져오는 retriever
        "question": DebugPassThrough()        # 사용자 질문이 그대로 전달되는지 확인하는 passthrough
    }  | DebugPassThrough() | ContextToText()|   to_korean_prompt | model

    # 텍스트를 파일에서 읽어 한 줄씩 띄워서 추가하기
    with open(text_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    
    # 텍스트 각 줄을 공백으로 구분하여 한 칸씩 띄운 문자열로 변환
    formatted_text = " ".join([line.strip() for line in lines])

    # 변환된 텍스트로 query 설정
    response = rag_chain_debug.invoke(formatted_text)

    result_dict = {'translation': response.content}

    return result_dict

"""
예시 
Input
방심,부주의
똑같다,같다,동일하다
가난,곤궁,궁핍,빈곤
느끼다,느낌,뉘앙스
장애인 기능 경진 대회
똑같다,같다,동일하다
가난,곤궁,궁핍,빈곤

Output
{'translation': '방심과 부주의는 동일하며, 가난, 곤궁, 궁핍, 빈곤은 유사한 의미를 지닌다. 장애인 기능 경진 대회는 똑같이 가난, 곤궁, 궁핍, 빈곤과 같은 의미를 공유한다.'}
"""

print(get_translate_fron_sign_language("output.txt"))