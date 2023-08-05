<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String dbId = "hr";
String dbPw = "hr";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = null;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, dbId, dbPw);
		out.println("JDBC 접속 성공적");		
	}catch (Exception e){
		out.println("접속실패");
	}
		String sql= "SELECT * FROM employees";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		%>
		<%
		while(rs.next()) {
		%>
		<h1><%= rs.getString("first_name") %> <%= rs.getString("last_name") %> <%= rs.getInt("salary") %>
		</h1>	
		<%
		}
		rs.close();
		pstmt.close();
		conn.close();
		%>
</body>
</html>