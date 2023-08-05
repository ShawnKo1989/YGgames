<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--     파라미터 dan : 정수 -->
<!--     구구단(dan단)을 출력. -->
<!--   Ex) .../Ex05.jsp?dan=5 -->
<!--   (출력) 5*1=1 -->
<!--   .... -->
<% 
	int dan = Integer.parseInt(request.getParameter("dan"));
%>
	<%!
	void gugudan(int dan) throws Exception{
		for(int i=1; i<=9; i++){
// 			out.println(dan+"*"+i+"="+ i*dan +"<br/>");
		}
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>
	<%
	gugudan(dan);
	%>
	</h1>
</body>
</html>