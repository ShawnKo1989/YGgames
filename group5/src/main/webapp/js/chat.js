const urlParams = new URLSearchParams(window.location.search);
const room = urlParams.get("room");

const socket = new WebSocket(`ws://210.114.1.134:9090/team5/serverChat?room=${room}`);

socket.onopen = function() {
	console.log(`Connected to room: ${room}`);
	const message = `${room}에 입장하셨습니다.`;
	displayNotification(message);
	socket.send(`notice|SERVER|${nickname}님이 입장하였습니다.`);
};

socket.onmessage = function(event) {
	const message = event.data;
	displayMessage(message);
};

function sendMessage() {
	const messageInput = document.querySelector(".messageInput");
	const message = `message|${nickname}|` + messageInput.value;
	socket.send(message);
	messageInput.value = "";
}

function displayNotification(message) {
	const notificationContainer = document.querySelector(".notificationContainer");
	const notificationElement = document.createElement("div");
	notificationElement.className = "serverMessage";
	notificationElement.textContent = message;
	notificationContainer.appendChild(notificationElement);
}

function displayMessage(message) {
	const messageContainer = document.querySelector(".messageContainer");
	const messageElement = document.createElement("div");
	const regex = /^CLIENT/;
	const regex2 = /^SERVER/;
	messageElement.className = regex.test(message) ? "clientMessage" : (regex2.test(message) ? "serverMessage" : "myMessage");
	message = regex.test(message) ? message.replace(regex, "") : (regex2.test(message) ? message.replace(regex2, "") : message);
	messageElement.textContent = message;
	messageContainer.appendChild(messageElement);
}
