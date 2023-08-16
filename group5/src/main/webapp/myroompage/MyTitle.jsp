<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="jdbc.User" %>
<%@page import="jdbc.UserDAO" %>
<style>
	.now-title {
		font-size: 16px;
		margin-bottom: 10px;
	}
	.change-title {
		color: #A0A4B4;
	    display: flex;
    	align-items: center;
    	cursor: pointer;
    	width: 150px;
	}
	.change-title:after {
		content: url("data:image/svg+xml,%3C%3Fxml version='1.0' standalone='no'%3F%3E%3C!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 20010904//EN' 'http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd'%3E%3Csvg version='1.0' xmlns='http://www.w3.org/2000/svg' width='30.000000pt' height='30.000000pt' viewBox='0 0 30.000000 30.000000' preserveAspectRatio='xMidYMid meet'%3E%3Cg transform='translate(0.000000,30.000000) scale(0.100000,-0.100000)'%0Afill='%23000000' stroke='none'%3E%3Cpath d='M170 205 c0 -23 -3 -24 -72 -27 -70 -3 -73 -4 -73 -28 0 -24 3 -25%0A73 -28 69 -3 72 -4 72 -27 0 -14 3 -25 6 -25 10 0 104 73 104 80 0 7 -94 80%0A-104 80 -3 0 -6 -11 -6 -25z'/%3E%3C/g%3E%3C/svg%3E%0A");
		width: 40px;
	    height: 40px;
	    display: flex;
	    position: relative;
	    margin-left: 10px;
	}
	.update-title {
	    border: none;
	    padding: 0px;
	    background: transparent;
	    outline: none;
	    color: #FFFFFF;
	    border-bottom: 1px solid #FFFFFF;
	    font-size: 16px;
	    width: 160px;
	}
	.submit-title {
	    border: 1px solid #A0A4B4;
	    background: transparent;
	    color: #a0a4b4;
	    cursor: pointer;
	    transition: border 0.3s ease-out 0s, color 0.3s ease-out 0s;
	    margin-left: 10px;
	}
	.submit-title:hover {
		border: 1px solid #FFFFFF;
	    color: #FFFFFF;
	}
</style>
<%
request.setCharacterEncoding("utf-8");
User user = new User();
UserDAO a = new UserDAO();
String title = null;
if(request.getParameter("rno")==null) {
	title = a.getTitle((int)session.getAttribute("reg_no"));
} else {
	title = a.getTitle(Integer.parseInt(request.getParameter("rno")));
}
if(title==null) {
%>
<div class="now-title">별명이 존재하지 않습니다.</div>
<div style="display: 
					<%if(request.getParameter("rno")==null) {
						%>flex<%
					} else {
						%>none<%
					}
					%>;">
	<div role="button" id="change-title" class="change-title">별명 추가하기</div>
	<input type="text" placeholder="별명을 입력해 주세요." id="update-title" class="update-title" style="display: none;">
	<input type="submit" value="확인" id="submit-title" class="submit-title" style="display: none;">
</div>
<script defer type="text/javascript">
	var changeT = document.getElementById("change-title");
	var updateT = document.getElementById("update-title");
	var submitT = document.getElementById("submit-title");
	
	changeT.onclick = function() {
		if (updateT.style.display === "none") {
			updateT.style.display = "block";
			submitT.style.display = "block";
		} else {
			updateT.style.display = "none";
			submitT.style.display = "none";
		}
	};
</script>
<script defer src="js/UpdateTitle.js"></script>
<%
} else {
%>
<div class="now-title"><%=title%></div>
<div style="display: 
					<%if(request.getParameter("rno")==null || Integer.parseInt(request.getParameter("rno"))==(int)session.getAttribute("reg_no")) {
						%>flex<%
					} else {
						%>none<%
					}
					%>;">
	<div role="button" id="change-title" class="change-title">별명 변경하기</div>
	<input type="text" placeholder="별명을 입력해 주세요." id="update-title" class="update-title" style="display: none;">
	<input type="submit" value="확인" id="submit-title" class="submit-title" style="display: none;">
</div>
<script defer type="text/javascript">
	var changeT = document.getElementById("change-title");
	var updateT = document.getElementById("update-title");
	var submitT = document.getElementById("submit-title");
	
	changeT.onclick = function() {
		if (updateT.style.display === "none") {
			updateT.style.display = "block";
			submitT.style.display = "block";
		} else {
			updateT.style.display = "none";
			submitT.style.display = "none";
		}
	};
</script>
<script defer src="js/UpdateTitle.js"></script>
<%
}
%>
