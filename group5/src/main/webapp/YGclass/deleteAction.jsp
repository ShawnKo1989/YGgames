<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%@ page import="java.sql.*" %>    
<% 
	int bno = Integer.parseInt(request.getParameter("bno"));
%>
<% 
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
	String dbid = "group5";
	String dbpw = "abcd1234"; 
%>
<%
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbid, dbpw);
	String sql = "DELETE FROM board WHERE bno= ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DELETE action page</title>
</head>
<script>
	alert("해당게시글이 삭제되었습니다!");
	location.href="board_practice.jsp";
</script>
<body>

</body>
</html>