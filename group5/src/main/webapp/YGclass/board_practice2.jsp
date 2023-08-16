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
	String sql = "SELECT * FROM board WHERE bno= ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	ResultSet rs = pstmt.executeQuery();
	String title = "";
	String content = "";
	String writer = "";
	String writedate = "";
	if(rs.next()){
		title = rs.getString("title");
		content = rs.getString("content");
		writer = rs.getString("writer");
		writedate = rs.getString("bdate");
	}
	rs.close();
	pstmt.close();
	conn.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<script src="js/jquery-3.7.0.min.js"></script>
<style>
	table { border-collpse: collapse;}
	th,td { border: 1px solid black; padding: 8px;}
</style>
<script>
	$(function() {
		$(".go_to_list").click(function() {
			location.href = "board_practice.jsp";
		});
		$(".delete_board_btn").click(function() {
			location.href = "deleteAction.jsp?bno=<%=bno%>";
		});
	});
</script>
</head>
<body>
	<table>
		<tr>
			<th>글번호</th>
			<td><%= bno %></td>
		</tr>
		<tr>
			<th>글제목</th>
			<td><%= title %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%= content %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= writer %></td>
		</tr>
		<tr>
			<th>작성일시</th>
			<td><%= writedate %></td>
		</tr>
	</table>
	<input class="go_to_list"type="submit" value="목록으로"/>
	<input class="delete_board_btn" type="submit" value="삭제하기"/>
</body>
</html>