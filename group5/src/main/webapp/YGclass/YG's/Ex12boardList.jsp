<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
	String dbid = "testw8";
	String dbpw = "pass1234";
%>
<%
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbid, dbpw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ex12_전체_게시글_목록</title>
	<script src="/WebProject1/js/jquery-3.7.0.min.js"></script>
	<script>
		$(function() {
			$("table tr").click(function() {
				let bno = $(this).find(".bno").text();
				location.href = "Ex12detailView.jsp?bno=" + bno;
			});
		});
	</script>
	<style>
		table { border-collapse: collapse; }
		th, td { border: 1px solid grey; padding: 8px; }
	</style>
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
			String sql = "SELECT bno, title, writer, writedate FROM board ORDER BY bno DESC";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			// 비고: SELECT
			ResultSet rs = pstmt.executeQuery();
// 			// 비고: INSERT, UPDATE, DELETE
// 			int r = pstmt.executeUpdate();
			while(rs.next()) {
		%>
		<tr>
			<td class="bno"><%=rs.getInt("bno") %></td>
			<td class="title"><%=rs.getString("title") %></td>
			<td class="writer"><%=rs.getString("writer") %></td>
			<td class="writedate"><%=rs.getString("writedate") %></td>
		</tr>
		<% } %>
	</table>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>