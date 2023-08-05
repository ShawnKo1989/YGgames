<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cookieString = "cookieName=value;domain=.tistory.com;max-age=2592000;path=/;SameSite=None;secure;";
	response.setHeader("Set-Cookie", cookieString);	
	response.addHeader("Set-Cookie", cookieString);
%>
<!DOCTYPE html>
<html id="html">
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="js/logout.js"></script>
	<script src="js/myroom.js"></script>
	<script defer src="js/FriendsRefresh.js"></script>
</head>
<body>
	<!-- 상단 네비바 -->
    <jsp:include page="NavBar2.jsp" />
    <!-- 중간 본문 -->
    <jsp:include page="Content.jsp" />
    <!-- 하단 footer -->
    <jsp:include page="BottomFooter.jsp" />
</body>
</html>