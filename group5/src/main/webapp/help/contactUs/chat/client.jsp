<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MemberDto mDto = (MemberDto)session.getAttribute("dto"); 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>채팅방</title>
    <script src="/group5/js/jquery-3.7.0.min.js"></script>
    <script src="/group5/js/chat.js"></script>
    <link rel="stylesheet" href="/group5/css/layout/chatRoom.css" />
    <script>
    	let nickname = "<%=mDto.getNickname() %>";
    </script>
</head>
<body>
	<div class="chatArea">
		<div class="notificationContainer"></div>
	    <div class="messageContainer"></div>
	    <form class="chatForm" onsubmit="sendMessage(); return false;">
	        <textarea class="messageInput" placeholder="메시지 입력" required></textarea>
	        <button type="submit">전송</button>
	    </form>
	</div>
</body>
</html>
