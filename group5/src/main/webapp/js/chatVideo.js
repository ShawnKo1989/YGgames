const urlParams = new URLSearchParams(window.location.search);
const room = urlParams.get('reservationNo');

const websocket = new WebSocket(`ws://210.114.1.134:9090/group5/serverVideoChat?reservationNo=${room}`);

const localVideo = document.getElementById('localVideo');
const remoteVideos = document.getElementById('remoteVideos');
let localStream;
let peerConnection; 

// 웹캠 스트림 캡처;
async function startCapture() {
	try {
		const stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: false });
		localStream = stream;
		localVideo.srcObject = stream;
		createPeerConnection();
	} catch (err) {
		console.error('Error accessing the webcam:', err);
	}
}

// PeerConnection 생성
function createPeerConnection() {
	peerConnection = new RTCPeerConnection();

	// 로컬 스트림을 PeerConnection에 추가
	localStream.getTracks().forEach(track => peerConnection.addTrack(track, localStream));

	// 원격 스트림 수신 핸들러
	peerConnection.ontrack = event => {
		const remoteVideo = document.createElement('video');
		remoteVideo.srcObject = event.streams[0];
		remoteVideo.autoplay = true;
		remoteVideos.appendChild(remoteVideo);
	};
}



websocket.onopen = function() {
	websocket.send(`notice|SERVER|${name}님이 입장하였습니다.`);
};

websocket.onmessage = function(event) {
	const data = event.data;
	if(typeof data === 'string') {
		displayMessage(data);
	}
	
	if(typeof data !== 'string'){
		const jsonData = JSON.parse(event.data);
		if (jsonData.type === 'offer') {
			handleOffer(jsonData);
		} else if (jsonData.type === 'answer') {
			handleAnswer(jsonData);
		} else if (jsonData.type === 'candidate') {
			handleCandidate(jsonData);
		}
	}
};

websocket.onclose = function() {
	console.log('WebSocket disconnected');
};

// 웹캠 스트림 캡처 시작
startCapture(); 

// Offer SDP 생성 및 웹소켓으로 전송
async function createOffer() {
	const offer = await peerConnection.createOffer();
	await peerConnection.setLocalDescription(offer);
	websocket.send(JSON.stringify({ type: 'offer', sdp: offer }));
}

// Offer SDP 처리
async function handleOffer(offer) {
	await peerConnection.setRemoteDescription(new RTCSessionDescription(offer.sdp));
	const answer = await peerConnection.createAnswer();
	await peerConnection.setLocalDescription(answer);
	websocket.send(JSON.stringify({ type: 'answer', sdp: answer }));
}

// Answer SDP 처리
async function handleAnswer(answer) {
	await peerConnection.setRemoteDescription(new RTCSessionDescription(answer.sdp));
}

// ICE candidate 처리
function handleCandidate(candidate) {
	peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
} 
function sendMessage() {
	const messageInput = document.querySelector(".messageInput");
	const message = `message|${name}|` + messageInput.value;
	websocket.send(message);
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