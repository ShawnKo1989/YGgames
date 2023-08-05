<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    int num1 = (int)(Math.random()*10)+1;
    int num2 = (int)(Math.random()*10)+1;
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- Ex08.jsp 연습. -->
<!-- 	(첫 번째 페이지) - Ex08.jsp -->
<!-- 		숫자1 = _____   // 난수발생 : 1 ~ 10 -->
<!-- 		숫자2 = _____   // 난수발생 : 1 ~ 10 -->
<!-- 		답 = ______ -->
<!-- 		[정답확인] -->
<!-- 	(두 번째 페이지) - Ex08p2.jsp -->
<!-- 		(숫자1+숫자2)가 입력한 답과 일치하는지, -->
<!-- 		- <h1>정답!</h1> -->
<!-- 		- <h1>틀렸음!</h1> -->
</head>
<body>
	<form action="Ex08p2.jsp">
	<h1>
		숫자1 = <%=num1 %><br/>
		숫자2 = <%=num2 %><br/>
		숫자1 + 숫자2 = ?<br/>
		답 = <input type="text" name="answer"/><br/>
		<input type="submit" value="정답확인" />
	</h1>
	</form>
</body>
</html>