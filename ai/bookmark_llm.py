import os
from dotenv import load_dotenv
from langchain_core.output_parsers import JsonOutputParser
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from pydantic import BaseModel, Field

class Emoji(BaseModel):
    description: str = Field(description="AI가 생성한 북마크에 대한 자동생성 이모지")

load_dotenv()
api_key = os.getenv("OPEN_AI_KEY")
parser = JsonOutputParser(pydantic_object=Emoji)

prompt = ChatPromptTemplate.from_messages(
    [
        ("system", f"""
        You are an advanced AI that converts text descriptions into highly expressive emoji representations.
        Analyze the meaning, emotions, and context of the user's input, then generate a set of emojis that best capture the essence.
        
        - Do not provide any explanations or words, only emojis.
        - Use multiple emojis when necessary to convey depth and nuance.
        - Consider emotional tone, objects, actions, and abstract concepts.
        - Be creative and ensure that the emojis clearly represent the description.
        - **If the input contains a number, always include the corresponding number emoji (e.g., "3" → "3️⃣").**
        - If the input refers to **public transportation (subway, bus, etc.)**, use relevant transportation emojis.
        - If the input is a **question**, add an appropriate symbol like ❓ or 🤔 to indicate inquiry.

        Example:
        - "따뜻한 아메리카노 주세요" → "☕🔥😊" (hot coffee, warmth, and happiness)
        - "비 오는 날의 감성적인 밤" → "🌧️🌙🎶☕" (rain, night, music, coffee)
        - "3호선으로 갈아타려면 어디로 가야해요?" → "3️⃣🚇🔄❓" (subway line 3, transfer, question)
        - "강남역에서 홍대까지 가려면 어떻게 해야 해요?" → "📍🚇➡️❓" (location, subway, direction, question)
        - "이 쿠폰을 사용해주세요" → "🧾💳🙏" (receipt, payment, request)
        """),
        ("user", "#Format: {format_instructions}\n\n#Question: {question}"),
    ]
)

prompt = prompt.partial(format_instructions=parser.get_format_instructions())


def get_bookmark_emoji(query):

    # 모델 초기화
    # temperature이 0에 가까울 수록 정확도가 높은 답변만을 선택함 (1에 가까울수록 랜덤성을 가미함)
    model = ChatOpenAI(temperature=0.6, model="gpt-4o-mini", api_key=api_key)

    chain = prompt | model | parser

    response = chain.invoke({"question": query}) 

    return response


# # {'description': '🍔🥩🔥😊'}
# emoji_result = get_bookmark_emoji("불고기 버거 주세요")
# print(emoji_result)

# # {'description': '👋😊'}
# emoji_result = get_bookmark_emoji("안녕하세요")
# print(emoji_result)

# # {'description': '3️⃣🚇🔄❓'}
# emoji_result = get_bookmark_emoji("3호선으로 갈아타려면 어디로 가야해요?")
# print(emoji_result)

# # {'description': '☕🏪❓'}
# emoji_result = get_bookmark_emoji("근처에 가장 가까운 카페는 어디에요?")
# print(emoji_result)

# # {'description': '🧾❓'}
# emoji_result = get_bookmark_emoji("이 쿠폰을 사용할 수 있나요?")
# print(emoji_result)

# {'description': '🧾💳🙏'}
# emoji_result = get_bookmark_emoji("이 쿠폰을 사용해주세요")
# print(emoji_result)





