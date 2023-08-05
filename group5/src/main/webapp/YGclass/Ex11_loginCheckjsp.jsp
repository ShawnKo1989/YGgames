<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "temp";
	String dbPw = "1234";
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url,dbId,dbPw);
	
	String sql = "SELECT *FROM register WHERE id = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()){
		String userId = rs.getString("id");
		String userPw = rs.getString("pw");
		if(userPw.equals(pw)){
			out.print("로그인되었습니다.");
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
	<form action="Ex11_loginCheckjsp.jsp">
		id: <input type="text" name="id"/><br/>
		pw: <input type="password" name="pw"/><br/>
		<input type="submit" value="제출"/>
	</form>
</body>
</html>