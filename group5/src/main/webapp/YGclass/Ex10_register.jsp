<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
    
    <%
	    String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
		String dbid = "group5";
		String dbpw = "abcd1234";
    %>
    <%
    	String id = request.getParameter("id");
    	String pw = request.getParameter("pw");
    	String name = request.getParameter("name");
    	String test = "test";
    	
    	Class.forName(driver);
    	Connection conn = DriverManager.getConnection(url,dbid,dbpw);
    	
    	String sql = "INSERT INTO register(id,pw,name,email) VALUES(?,?,?,?)";
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	
    	
    	pstmt.setString(1,id);
    	pstmt.setString(2,pw);
    	pstmt.setString(3,name);
    	pstmt.setString(4,test);
    	
    	int ret = pstmt.executeUpdate();
    	
    	pstmt.close();
    	conn.close();
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 연습</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="Ex10_register.jsp" method="post"> <!--포스트방식은 폼(form)태그에서만 된다  -->
		아이디: <input type="text" name="id" /><br/>
		패스워드:<input type="password" name="pw"/><br/>
		이름: <input type="text" name="name" /><br/>
		<input type="submit" value="작성완료"/>
	</form>
		<% if(ret==1){%>
			<h1>가입되었습니다.</h1>
		<%} else {%>
			<h1>가입실패..... 무언가 잘못되었습니다.</h1>
		<%} %>
</body>
</html>