<%@page import="dto.RsvDto"%>
<%@page import="dao.RsvDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int rsvno = 0;
	try {
		rsvno= Integer.parseInt(request.getParameter("rsvNo"));
	} catch (Exception e) {
		rsvno = 0;
	}
	RsvDao rDao = RsvDao.getInstance(); 
	RsvDto rDto = rDao.getRsvDto(rsvno);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약확인</title>
</head>
<body>
	<div class="rsvInfo">
		<h4>예약정보</h4>
		<ul>
			<%
			if(rDto==null){
		%>
			<li>예약정보가 없습니다.</li>
			<%
			} else {
		%>
			<li>이름 : <%=rDto.getName() %></li>
			<li>예약번호 : <%=rDto.getRsvno() %></li>
			<li>상담일시 : <%=rDto.getSchedule() %></li>
			<li>상담타입 : <%=rDto.getType() %></li>
			<li>상담사 : <%=rDto.getSupporter() %></li>
		</ul>
		<%
			}
		%>
	</div>
</body>
</html>