<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "testw8";
	String dbPw = "pass1234";
%>
<%
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "DELETE FROM board WHERE bno=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	
	int r = pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
%>
<script>alert("삭제되었습니다."); location.href="Ex12boardList.jsp";</script>