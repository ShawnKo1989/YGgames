<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>채팅방_관리자</title>
    <script src="/group5/js/jquery-3.7.0.min.js"></script>
    <script src="/group5/js/chat.js"></script>
    <link rel="stylesheet" href="/group5/css/elements/chat.css" />
    <script>
    	let nickname = "admin";
    </script>
</head>
<body>
	<div class="chatArea">
		<div class="notificationContainer"></div>
	    <div class="messageContainer"></div>
	    <form class="chatForm" onsubmit="sendMessage(); return false;">
	        <input type="text" class="messageInput" placeholder="메시지 입력" />
	        <button type="submit">전송</button>
	    </form>
	</div>
</body>
</html>
