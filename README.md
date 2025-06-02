# 농인을 위한 수어 기반 주문 소통 서비스 <span style="color:#458EFD; font-weight:bold; font-size:1.5em;">SignOrder</span>
![image](https://github.com/user-attachments/assets/cdc0d617-af3c-479a-99ab-4b30006cdd21)


## 목차
1️⃣ [프로젝트 소개](#-프로젝트-소개)

2️⃣ [주요 기능](#-주요-기능)

3️⃣ [소개 영상](#-소개-영상)

4️⃣ [팀원 소개](#-팀원-소개)

5️⃣ [시스템 구조](#-시스템-구조)

6️⃣ [기술 스택](#-기술-스택)   

7️⃣ [소개 자료](#-소개-자료)


## 1. 프로젝트 소개

<div style="text-align: center; padding: 20px;">
    <img src="https://github.com/user-attachments/assets/1794e351-6c51-4656-84e6-09b1247bf75b" alt="sign_order_logo" style="width: 300px; height: auto; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); margin-bottom: 20px;">
    <blockquote style="font-size: 1.4em; font-style: italic; text-align: center; border-left: 5px solid #3182F6; padding-left: 20px; margin: 20px 0; color: #333;">
        카페에서 만나는 수어 소통, 농인과 청인을 이어주는 주문 서비스 <strong>Sign Order</strong> 입니다.
    </blockquote>
    <p style="font-size: 1.2em; color: #555; font-weight: bold;">
        <a href="https://kookmin-sw.github.io/capstone-2025-30/" style="color: #3182F6; text-decoration: none; border-bottom: 2px solid #3182F6;">
            소개 페이지
        </a>
    </p>
</div>

## 2. 주요 기능

### 농인 맞춤 주문 서비스
* 메뉴판 웹페이지에서 수어 아바타 영상을 단계별로 제공하여 농인 사용자가 절차를 직관적으로 이해 가능

### 실시간 AI 수어 양방향 통역 서비스
* 실시간 AI 수어 양방향 통역 서비스로 직원과의 소통을 원활하게 하고 직원의 요청 처리 편의성 향상

### 주문 상태 확인 서비스 
* 메뉴판 웹페이지에서 실시간으로 주문 상태를 확인하여 기다리는 불편을 줄이고 정보 접근성 향상


## 3. 소개 영상

영상 넣기 

### 4. 팀원 소개

<table>
    <tr align="center">
        <td style="min-width: 150px;">
            <a href="https://github.com/sangkim99">
              <br />
              <b>김상민</b>
            </a> 
            <br/>
        </td>
        <td style="min-width: 150px;">
            <a href="https://github.com/decollzoq">
              <br />
              <b>박민선</b>
            </a>
            <br/>
        </td>
        <td style="min-width: 150px;">
            <a href="https://github.com/KooSuYeon">
              <br />
              <b>구수연</b>
            </a> 
            <br/>
        </td>
        <td style="min-width: 150px;">
            <a href="https://github.com/nnyouung">
              <br />
              <b>하은영</b>
            </a> 
            <br/>
        </td>
                <td style="min-width: 150px;">
            <a href="https://github.com/ghdyd586">
              <br />
              <b>정호용</b>
            </a> 
            <br/>
        </td>
    </tr>
    <tr align="center">
        <td>
            팀장, Backend
        </td>
        <td>
            Backend, UI 디자인
        </td>
        <td>
            AI, AI 서버 개발
        </td>
        <td>
            Frontend
        </td>
        <td>
            아바타 개발
        </td>
    </tr>
</table>

## 5. 시스템 구조

![KakaoTalk_Photo_2025-05-18-19-31-09-1](https://github.com/user-attachments/assets/7ddeb640-9728-4dfc-9161-2b17e57a8d32)


## 6. 기술 스택

### 🖥 Backend

| Category              | Technology |
|-----------------------|------------|
| **Programming Language** | ![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white) |
| **Network**              | ![Gin](https://img.shields.io/badge/Gin-000000?style=for-the-badge&logo=go&logoColor=white) ![gRPC](https://img.shields.io/badge/gRPC-0089D6?style=for-the-badge&logo=grpc&logoColor=white) ![WebSocket](https://img.shields.io/badge/Gorilla_WebSocket-4A90E2?style=for-the-badge&logo=websocket&logoColor=white) |
| **CI/CD**                | ![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white) |
| **Containerization**     | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) |
| **Database**             | ![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white) ![MongoDB Atlas](https://img.shields.io/badge/MongoDB_Atlas-47A248?style=for-the-badge&logo=mongodb&logoColor=white) |
| **Cloud Infrastructure** | ![AWS EC2](https://img.shields.io/badge/AWS_EC2-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white) ![AWS S3](https://img.shields.io/badge/AWS_S3-569A31?style=for-the-badge&logo=amazon-s3&logoColor=white) |
| **Web Server / Proxy**   | ![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white) |
| **Version Control**      | ![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white) |

### 🖥 Frontend

| Category              | Technology |
|-----------------------|------------|
| **Framework / Library** | ![React](https://img.shields.io/badge/React-61DAFB?style=for-the-badge&logo=react&logoColor=black) ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white) |
| **Network**             | ![REST API](https://img.shields.io/badge/REST_API-121212?style=for-the-badge&logo=api&logoColor=white) ![gRPC](https://img.shields.io/badge/gRPC-0089D6?style=for-the-badge&logo=grpc&logoColor=white) ![WebSocket](https://img.shields.io/badge/WebSocket-4A90E2?style=for-the-badge&logo=websocket&logoColor=white) |

### 🤖 AI

| Category              | Technology |
|-----------------------|------------|
| **Programming Language** | ![Python](https://img.shields.io/badge/Python_3.10-3776AB?style=for-the-badge&logo=python&logoColor=white) |
| **Network**              | ![gRPC](https://img.shields.io/badge/gRPC-0089D6?style=for-the-badge&logo=grpc&logoColor=white) |
| **Framework** | ![PyTorch](https://img.shields.io/badge/PyTorch-EE4C2C?style=for-the-badge&logo=pytorch&logoColor=white) |
| **AI / ML Algorithm** | ![Bi-LSTM](https://img.shields.io/badge/Bi--LSTM-FF6F00?style=for-the-badge) ![Attention](https://img.shields.io/badge/Attention-9C27B0?style=for-the-badge) |
| **Vision Processing** | ![MediaPipe](https://img.shields.io/badge/MediaPipe-FF6D00?style=for-the-badge) ![OpenCV](https://img.shields.io/badge/OpenCV-5C3EE8?style=for-the-badge&logo=opencv&logoColor=white) |
| **Vector Search** | ![Faiss](https://img.shields.io/badge/Faiss-0A7EB4?style=for-the-badge) ![BM25](https://img.shields.io/badge/BM25-4CAF50?style=for-the-badge) |

### 🧍아바타
| Category              | Technology |
|-----------------------|------------|
| **3D Engine** | ![Unity](https://img.shields.io/badge/Unity-000000?style=for-the-badge&logo=unity&logoColor=white) |
| **3D Modeling** | ![Blender](https://img.shields.io/badge/Blender-F5792A?style=for-the-badge&logo=blender&logoColor=white) |
| **Motion Capture** | ![Dollars Mocap](https://img.shields.io/badge/Dollars_Mocap-795548?style=for-the-badge) |
| **Cloud Integration** | ![Boto3](https://img.shields.io/badge/Boto3-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white) |
| **Spreadsheet API** | ![gspread](https://img.shields.io/badge/gspread-34A853?style=for-the-badge&logo=google-sheets&logoColor=white) |

## 7. 소개 자료
### [중간 발표 자료](https://drive.google.com/file/d/1R-pnw1muGACA_5_bLgEAGD-EcvWx0-XL/view?usp=drive_link)
### [중간 보고서](https://drive.google.com/file/d/1jetP1r_VG7WsAy0ZcKv1CvQkPUQ2O3gr/view?usp=sharing)
### [시연 동영상](https://www.youtube.com/watch?v=IHmwz-3R1Yo)
### [포스터](https://drive.google.com/file/d/16t_PlK_TkFd09JLe3dJyIgxU3XmBpNjf/view?usp=drive_link)
### [최종 발표 자료](https://drive.google.com/file/d/1ohzAjFnFfPPdGY30yLIPBp3_HJu_tqNk/view?usp=sharing)
### [결과 보고서](https://drive.google.com/file/d/14fOL9dVCOZJEYAjtLDl2ZG_CtCYYjiRo/view?usp=drive_link)
