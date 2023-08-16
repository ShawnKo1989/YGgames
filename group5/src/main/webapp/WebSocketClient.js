// websocketClient.js

// WebSocket 서버에 연결
const socket = new WebSocket("ws://210.114.1.134:9090/websocket");

// WebSocket 연결 성공 시 실행될 이벤트 핸들러
socket.onopen = function() {
  console.log("WebSocket 연결 성공");
  
  // 닉네임 전송
  const nickname = "사용자 닉네임"; // 사용자가 입력한 닉네임을 가져와서 변수에 할당
  socket.send(nickname);
};

// WebSocket 메시지 수신 시 실행될 이벤트 핸들러
socket.onmessage = function(event) {
  const message = event.data;
  console.log("수신 메시지:", message);
  
  // 수신한 메시지를 처리하여 채팅 영역에 출력하는 등의 동작 수행
  displayMessage(message);
};

// WebSocket 에러 발생 시 실행될 이벤트 핸들러
socket.onerror = function(error) {
  console.error("WebSocket 오류:", error);
};

// WebSocket 연결 종료 시 실행될 이벤트 핸들러
socket.onclose = function(event) {
  console.log("WebSocket 연결 종료");
};

// 메시지를 서버로 전송
function sendMessage(message) {
  socket.send(message);
}

// 채팅 메시지를 화면에 출력하는 함수
function displayMessage(message) {
  const chatArea = document.getElementById("showChatArea");
  
  const chatDiv = document.createElement("div");
  chatDiv.classList.add("showChating");

  const img = document.createElement("img");
  img.src = "Images/달려드는쿼카.jpg";

  const chatTime = document.createElement("span");
  chatTime.classList.add("chatTime");
  const currentTime = new Date();
  chatTime.textContent = currentTime.getHours() + ":" + currentTime.getMinutes();

  const showChatID = document.createElement("span");
  showChatID.classList.add("showChatID");
  showChatID.textContent = nickname;

  const showChatContent = document.createElement("span");
  showChatContent.classList.add("showChatContent");
  showChatContent.textContent = message;

  chatDiv.appendChild(img);
  chatDiv.appendChild(chatTime);
  chatDiv.appendChild(showChatID);
  chatDiv.appendChild(document.createElement("br"));
  chatDiv.appendChild(document.createElement("br"));
  chatDiv.appendChild(showChatContent);

  chatArea.appendChild(chatDiv);
}