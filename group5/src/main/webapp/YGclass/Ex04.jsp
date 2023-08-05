<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네번째 강의</title>
</head>
<body>
	<h1>파라미터에서 가져온 값 num * 10 = <%= num*10 %></h1>
</body>
</html>