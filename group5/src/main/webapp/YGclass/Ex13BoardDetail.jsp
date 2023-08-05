<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%!
	public Connection getConnection(){
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "testw8";
		String dbPw = "pass1234";
		
		Connection conn = null;
		try{
			Class.forName(driver);	// JDBC 드라이버 로딩.
			conn = DriverManager.getConnection(url, dbId, dbPw);
								// DB접속 시도 ---> Connection 객체 리턴.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
%>
<%
	int bno=Integer.parseInt(request.getParameter("bno"));
	
	Connection conn = getConnection();
	
	String sql = "SELECT * FROM board WHERE bno=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상세보기</title>
	<script src="/WebProject1/js/jquery-3.7.0.min.js"></script>
	<script>
		$(function(){
			$("#btn_del").click(function() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href = "Ex13BoardDeleteAction.jsp?bno=<%=bno%>";
				}
			});
		});
	</script>
	<style>
		table {
			border-collapse: collapse;
		}
		th, td {
			border: 1px solid grey;
			padding: 8px;
		}
	</style>
</head>
<body>
	<table>
	<%
		if(rs.next()) {
	%>
		<tr>
			<th>번호</th>
			<td><%=rs.getInt("bno") %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=rs.getString("title") %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=rs.getString("content") %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=rs.getString("writer") %></td>
		</tr>
		<tr>
			<th>작성일시</th>
			<td><%=rs.getString("writedate") %></td>
		</tr>
	<%
		}
	%>
	</table>
	<input type="button" value="목록으로" onclick="location.href = `Ex13BoardList.jsp`" />
	<input type="button" value="수정하기" onclick="location.href = `Ex13BoardUpdate.jsp?bno=<%=bno%>`" />
	<input id="btn_del" type="button" value="삭제하기" />
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>
