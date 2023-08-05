<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	page import="java.sql.*"%>

<%
	// [기억] request.getParameter("파라미터명"); --> 해당 파라미터의 값을 리턴.(문자열)
	// Ex. "...?page=1" ---> request.getParameter("page")는 "1"을 리턴.
	// [기억] Integer.parseInt("1") ---> 1을 리턴. (즉, 문자열 --> 정수)
// 	int pageNum = Integer.parseInt(request.getParameter("page")==null ?
// 					"1" : request.getParameter("page"));
	int pageNum = 0;
	try {
		pageNum = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException e) {
		pageNum = 1;
	}
%>

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

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<script src="/WebProject1/js/jquery-3.7.0.min.js"></script>
	<script>
		$(function() {	/* html을 다 읽은 후 읽겠다는 표현. */
			$("#btn_write").click(function() {
				location.href = "Ex13BoardWrite.jsp";
			});
			$(".bookList .book").click(function() {
				let bno = $(this).find(".bno").text();
				location.href = "Ex13BoardDetail.jsp?bno=" + bno;
			});
		});
	</script>
	<style>
		table { border-collapse: collapse; /* 한 줄의 경계선으로 만듦. */}
		th, td { border: 1px solid grey; padding 8px; }
	</style>
</head>
<body>
	<table class="bookList">
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일시</th>
		</tr>
		<%
			Connection conn = getConnection();
		
			String sql =
					" SELECT b2.* "
					+ " FROM (  SELECT rownum rnum, b1.* "
					       + " FROM (SELECT * FROM board ORDER BY bno DESC) b1) b2 "
					+ " WHERE b2.rnum>=? AND b2.rnum<=?";
			int endNum = pageNum * 10;
			int startNum = endNum + 1 - 10;

			PreparedStatement pstmt = conn.prepareStatement(sql);
						// PreparedStatement : sql문을 저장하고 실행하는 객체.
						// conn.prepareStatement(sql) : pstmt 객체를 만듦. & SQL문을 장착함.
			pstmt.setInt(1, startNum);
						// pstmt.setInt(물음표번호, 정수값); --> 물음표를 그 값으로 치환.
						// 참고) pstmt.setString(물음표번호, 문자열);
			pstmt.setInt(2, endNum);
			
			// [암기]
			// SELECT문의 실행 ---> ResultSet rs = pstmt.executeQuery();
			// INSERT, UPDATE, DELETE문의 실행 --> int r = pstmt.executeUpdate();
			ResultSet rs = pstmt.executeQuery();	// rs손가락이 1번행 바로 위를 가리키고 있음! (중요)
			
			String sql2 = "SELECT count(*) FROM board";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			
			ResultSet rs2 = pstmt2.executeQuery();
			int lastPage = 1;
			if(rs2.next()) {
				lastPage = rs2.getInt("count(*)")/10 + 1;
			}
		%>
		<%
			while(rs.next()) {
						// rs.next() :	rs손가락을 한 줄 내리고
						//				가리키는 데이터가 존재하면 true를 리턴.
						//				가리키는 데이터가 존재하지 않으면 false를 리턴.
		%>
		<tr class="book">
			<td class="bno"><%=rs.getInt("bno") %></td>
			<td class="title"><%=rs.getString("title") %></td>
			<td class="writer"><%=rs.getString("writer") %></td>
			<td class="writedate"><%=rs.getString("writedate") %></td>
		</tr>
		<%
			}
		%>
	</table>
	<!-- Pagenation(페이지네이션) -->
	<div style="padding-left: 200px;">
	<%
		
		for(int i=1; i<=lastPage; i++){
			if(i==pageNum) {
				out.print("<span>" + i + "</span>");
				continue;
			}
	%>
		<a href="Ex13BoardList.jsp?page=<%=i%>"><%=i%></a>
	<%
		}
	%>
	</div>
	<div>
		<button id="btn_write">글쓰기</button>
	</div>
	<!-- $(function(){});을 쓰는 이유가 없음. -->
<!-- 	<script> -->
<!-- 		$("#btn_write").click(function() { -->
<!-- 			alert("!"); -->
<!-- 		}); -->
<!-- 	</script> -->
</body>
</html>
<%
	// JDBC 관련 객체들을, 만든 순서의 역순으로 닫아줌.
	rs.close();
	pstmt.close();
	conn.close();
%>