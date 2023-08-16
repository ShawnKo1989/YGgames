<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		int regNo=0;
		try{regNo=(Integer)session.getAttribute("reg_no");
		} catch(java.lang.NullPointerException e){
			regNo=0;
		}
	%>
<!DOCTYPE html>
<html>
	<head>
	
		<script src="/group5/js/jquery-3.7.0.min.js"></script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="css/Community.css" />
	
		<script>
			$(document).ready(function() {
				let anonymousIdInput = $('#anonymousId');
				let anonymousBtn = $('#anonymousBtn');
				let writeChatValueInput = $('#writeChatValue');
				let writeChatBtn = $('#writeChatBtn');
				let nickname = '';
				let socket;

				anonymousBtn.click(function() {
					let inputIdValue = anonymousIdInput.val().trim();
					if (inputIdValue === '') {
						alert('닉네임을 입력해주세요.');
					} else {
						// 최대 글자 8글자로 지정
						if (inputIdValue.length > 8) {
							alert('닉네임은 최대 8글자까지 입력할 수 있습니다.');
							return;
						}
						//유효성 검사
						if (!/^[a-zA-Z가-힣]+$/.test(inputIdValue)) {
							alert('닉네임에는 영어와 한글만 사용가능합니다.');
							return;
						}

						nickname = inputIdValue;
						setTimeout(function() {
							$('#anonymousId').hide();
							$('#anonymousBtn').hide();
						}, 1000);
						anonymousIdInput.prop('disabled', true); // 입력한 닉네임 필드 비활성화
						const joinMessage = nickname + '님 등장!';
						sendMessage(joinMessage);
					}
				});


				writeChatBtn.click(function() {	//메세지가 비지 않았을 경우 보내기
					let message = writeChatValueInput.val().trim();
					if (message !== '') {
						sendMessage(message);
					}
				});

				function sendMessage(message) {
					// 닉네임 확인
					if (nickname === '') {
						alert('닉네임을 입력해주세요.');
						return; // 닉네임이 없을 경우 메시지 전송 중단
					}
					socket.send(nickname + ":" + message);
					writeChatValueInput.val(''); // 입력 필드 초기화
				}

				let chatArea = document.getElementById("showChatArea");

				function displayMessage(nickname, message) {
					if (message.startsWith(nickname + '님 등장!')) {
						// 등장 메시지인 경우
						const joinMemberDiv = document.createElement("div");
						joinMemberDiv.classList.add("joinMember");
						const joinMemberSpan = document.createElement("span");
						joinMemberSpan.textContent = message;
						joinMemberDiv.appendChild(joinMemberSpan);

						chatArea.appendChild(joinMemberDiv);
					} else {
						// 일반 메시지인 경우
						const chatDiv = document.createElement("div");
						chatDiv.classList.add("showChating");

						const img = document.createElement("img");
						let inputIdValue = anonymousIdInput.val().trim();
						if (inputIdValue === nickname) {	//본인 닉네임이랑 일치 시 
							img.src = "images/카와이쿼카.jpg";
						} else {							//비일치시
							img.src = "images/달려드는쿼카.jpg";
						}

						const chatTime = document.createElement("span");
						chatTime.classList.add("chatTime");
						const currentTime = new Date();		//현재시간
						let hour = currentTime.getHours();
						let minute = currentTime.getMinutes();
						if (hour < 10) {
							hour = "0" + hour;
						}
						if (minute < 10) {
							minute = "0" + minute;
						}
						
						chatTime.textContent = hour + ":" + minute;

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

						// 스크롤을 아래로 이동
						chatArea.scrollTop = chatArea.scrollHeight;
					}
				}

				// WebSocket 연결 코드
				socket = new WebSocket("ws://210.114.1.134:9090/group5/websocket");

				socket.onopen = function() {
					console.log("WebSocket 연결 성공");
				};

				socket.onmessage = function(event) {
					const message = event.data.split(":");
					reNickname = message[0];
					reMessage = message[1];
					displayMessage(reNickname, reMessage);
				};

				socket.onerror = function(error) {
					console.error("WebSocket 오류:", error);
				};

				socket.onclose = function(event) {
					console.log("WebSocket 연결 종료");
				};
			});
		</script>
	
		<script>
			$(document).on("click","#postWriteBtn2",function(){
				alert("로그인이 필요한 서비스입니다.");
			});
		</script>	
		<script>		//실시간 채팅방 버튼
			$(document).ready(function() {
				$("#chatBtn").hover(
					function() {
						$("#chatImage").attr("src", "images/talk_hover.gif");
					},
					function() {
						$("#chatImage").attr("src", "images/talk.png");
					}
				);
	
				$('#chatBtn').on('click', function(e) {
					e.preventDefault();
	
					$('.chatBg').fadeIn();
					$('#chatPop').show();
					$('html').css({overflow: 'hidden'});
				});
	
				$('.chatClose').on('click', function() {
					$('#anonymousId').val('');
					$('#writeChatValue').val('');
					$('.chatBg').fadeOut();
					$('#chatPop').hide();
					$('#chatPop').removeAttr('style');
					$('html').removeAttr('style');
				});
			});

		</script>
	</head>
	<body>
		<jsp:include page="../outframe/NavBar2.jsp" />
		<ul class="leftBar">
			<%if(regNo!=0){ %>
				<li id="postWrite">	<!-- 게시판 글쓰기 이동 -->
					<a href="/group5/Controller?command=postWrite">
						<button id="postWriteBtn1">게시판 글쓰기</button>
					</a>
				</li>
			<%} else { %>
				<li id="postWrite">	<!-- 비 로그인시 이동 X -->
					<button id="postWriteBtn2">게시판 글쓰기</button>
				</li>
			<%} %>
			<li class="allWrite">	<!-- 게시판 메인화면 이동 -->
				<a href="/group5/Controller?command=community">
					<img src=images/home.png>
					<span class="boardMain">&nbsp;홈</span>
				</a>
			</li>
			<li class="bottomSpaceSideBar"></li>
			<li class="allWrite">		<!-- 게시판의 모든 글 불러오기 -->
				<a href="/group5/Controller?command=communityBoard&boardNo=0">
					<img src="images/select-all.png"> 
					<span class="boardMain" style="font-weight:600;">전체 글보기</span>
				</a> 
				<br>
			</li>
			<li class="bottomSpaceSideBar"></li>
			<!-- 각 게시판 이동 -->
			<li>
				<a href="/group5/Controller?command=communityBoard&boardNo=1">&nbsp;
					<img src="images/gameCon.png">
					<span class="boardMain" style="font-weight:450;"> 게임 게시판</span>
				</a>
				<br>
			</li>
			<li><a href="/group5/Controller?command=communityBoard&boardNo=3"> &emsp;┖&nbsp; <span class="boardMain" style="font-weight:300;">공략 게시판 </span></a><br></li>
			<li><a href="/group5/Controller?command=communityBoard&boardNo=7"> &emsp;┖&nbsp; <span class="boardMain" style="font-weight:300;">자랑 게시판 </span></a><br></li>
			<li><a href="/group5/Controller?command=communityBoard&boardNo=6"> &emsp;┖&nbsp; <span class="boardMain" style="font-weight:300;">질문 게시판 </span></a><br></li>
			<li>
				<a href="/group5/Controller?command=communityBoard&boardNo=2">&nbsp;
					<img src="images/keyboard.png">
					<span class="boardMain" style="font-weight:450;"> 자유 게시판</span>
				</a>
				<br>
			</li>
			<li>
				<a href="/group5/Controller?command=communityBoard&boardNo=4">&nbsp;
					<img src="images/monitor.png">
					<span class="boardMain" style="font-weight:450;"> PC방 게시판</span>
				</a> 
				<br>
			</li>
			<li><a href="/group5/Controller?command=communityBoard&boardNo=5"> &emsp;┖&nbsp; <span class="boardMain" style="font-weight:300;">PC방 문의 게시판 </span></a><br></li>
			<li id="p2pChat">
				<div id="chatBtn">
					<img id="chatImage" src="images/talk.png"/>
				</div>
			</li>
		</ul>
		<!-- 실시간 채팅방 모달창 -->
		<div class="chatBg"></div>
		<div id="chatPop" class="chatWrap">
			<div id="chatTop">
				<button class="chatClose">
					<img src="images/xBtn.png"/>
				</button>
			</div>
			<div id="insertId">
			  <input type="text" id="anonymousId" placeholder="닉네임을 입력해 주세요."/>
			  <input type="button" id="anonymousBtn" value="확인"/>
			</div>
			<div id="showChatArea"></div>
			<div id="writeChat">
				<textarea id="writeChatValue"></textarea>
				<button id="writeChatBtn">전송</button>
			</div>
		</div>
	</body>
</html>
