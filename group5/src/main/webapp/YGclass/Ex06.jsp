<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	int a = Integer.parseInt(request.getParameter("a"));
	int b = Integer.parseInt(request.getParameter("b"));
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
		int sum= 0;
		for(int i=a;i<=b; i++){
			sum += i;
			if(i!=b){
			%>
			<%=i%> +
			<% } else { out.print(i); %> = 
			<%= sum%>
			<%} %>
			<%
		}
	%>
	</h1>
</body>
</html>