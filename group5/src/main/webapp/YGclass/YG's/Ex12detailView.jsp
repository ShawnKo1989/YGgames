<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
// 	System.out.println("bno : " + bno);
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
	
	String sql = "SELECT bno, title, content, writer, writedate FROM board WHERE bno=?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	
	ResultSet rs = pstmt.executeQuery();
	
	String title = "";
	String content = "";
	String writer = "";
	String writedate = "";
	if(rs.next()) {
		bno = rs.getInt("bno");
		title = rs.getString("title");
		content = rs.getString("content");
		writer = rs.getString("writer");
		writedate = rs.getString("writedate");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 상세보기</title>
	<script src="/WebProject1/js/jquery-3.7.0.min.js"></script>
	<script>
		$(function() {
			$("#btn_list").click(function() {
				history.back();
			});
			$("#btn_delete").click(function() {
				if(confirm("정말 삭제하시겠습니까?")===true) {
					location.href = "Ex12deleteAction.jsp?bno=<%=bno%>";
				};
			})
		});
	</script>
	<style>
		table { border-collapse: collapse; }
		th, td { border: 1px solid grey; padding: 8px; }
	</style>
</head>
<body>
	<input id="btn_list" type="button" value="목록보기" />
	<input id="btn_delete" type="button" value="삭제하기" />
	<table>
		<tr>
			<th>글_번호</th>
			<td><%=bno %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=title %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=content %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=writer %></td>
		</tr>
		<tr>
			<th>작성일시</th>
			<td><%=writedate %></td>
		</tr>
	</table>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>