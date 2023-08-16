<%@page import="dto.RsvDto"%> 
<%@page import="dao.RsvDao"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	int rsvno = Integer.parseInt(request.getParameter("reservationNo"));
	RsvDao rDao = RsvDao.getInstance();
	String name = null;
	try {
		name = rDao.getRsvDto(rsvno).getName();
	} catch (Exception e) {
		RequestDispatcher rd = request.getRequestDispatcher("/help/refused.jsp");
		rd.forward(request, response);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>room</title>
    <link rel="stylesheet" href="/group5/css/layout/chatRoom.css" />
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<script>
		let name = "<%=name %>";
	</script>
</head>
<body>
	<header>
		<h1>
			예약번호 :
			<%=rsvno %></h1>
	</header>
	<main>
		<div id="call">
			<div id="myStream">
				<div class="control">
					<button id="mute">Mute</button>
					<button id="camera">Turn_Camera_Off</button>
					<select id="cameras"></select>
				</div>
				<div class="face">
					<video id="localVideo" muted autoplay playsinline width="300" height="300"></video>
					<video id="peerVideo" muted autoplay playsinline width="500" height="500"></video>
				</div>
				<div class="chatArea">
					<div class="notificationContainer"></div>
				    <div class="messageContainer"></div>
				    <div class="chatForm">
				        <textarea class="messageInput" placeholder="메시지 입력" required></textarea>
				        <button type="button" onclick="sendMessage();">전송</button>
				    </div>
				</div>
			</div>
		</div>
	</main>
	<footer></footer>
	<script defer src="/group5/js/chatVideo.js"></script>
</body>
</html>