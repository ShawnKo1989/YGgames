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
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbid, dbpw);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판 로딩 연습</title>
	<script src="js/jquery-3.7.0.min.js"></script>
	<style>
		table{ border-collapse: collapse;}
		th, td { border: 1px solid grey; padding: 8px;}
		tr {cursor: pointer;}
		tr:hover {background: #E8F5FF; transition: 0.3s;}
	</style>
	<script>
		$(function(){
			$("table tr").click(function(){
				let bno = $(this).find(".bno").text();
				location.href = "board_practice2.jsp?bno="+ bno;
			});
		});
	</script>
</head>
<body>
	<table>
		<tr>
			<th>글번호</th>		
			<th>제목</th>		
			<th>작성자</th>		
			<th>작성일시</th>		
		</tr>
		<% 
			String sql = "SELECT * FROM board ORDER BY bno DESC";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
		%>
		<tr>
			<td class="bno"><%= rs.getInt("bno") %></td>
			<td><%= rs.getString("title") %></td>
			<td><%= rs.getString("writer") %></td>
			<td><%= rs.getString("bdate") %></td>
		</tr>
		<%} %>
	</table>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>