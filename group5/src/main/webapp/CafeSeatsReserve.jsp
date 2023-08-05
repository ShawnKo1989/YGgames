<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int seatNum = (int)request.getAttribute("seatNumber");
	String nickname="";
	try{
		nickname=(String)session.getAttribute("userNickname");
	} catch(java.lang.NullPointerException e){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<title>
		<%
			out.print(seatNum);
		%>번 좌석 예약
	</title>
	<link rel="stylesheet" href="css/CafeSeatsReserve.css" />
</head>
<body>
	<jsp:include page="NavBar2.jsp" />
	<!-- 좌석예약 확인 -->
	<div class="reserve">
		<div class="reserveItemsTop">
			<p><%=nickname%>님</p>
			<p>
				<%=seatNum %>번 좌석 예약을 진행하시겠습니까?
			</p>
		</div>
		<div class="btnItems">
			<!-- 좌석 예약 페이지 이동 -->
			<a href="Controller?command=reservePay&seatNumber=<%=seatNum%>"><button class="btn">예</button></a> 
			<!-- 기존 페이지 이동 -->
			<a href="Controller?command=pcCafe"><button class="btn">아니요</button></a>
		</div>
	</div>
	<jsp:include page="BottomFooter.jsp" />
</body>
</html>
