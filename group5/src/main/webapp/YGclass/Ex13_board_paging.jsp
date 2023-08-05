<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	int pageNum = 0;
	try{
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}catch(NumberFormatException e){
		// pageNum 을 1로 만들어
		pageNum = 1;
	}
%>
<%!
	// request.getParameter(파라미터명) --> 해당 파라미터의 값을 리턴(문자열)
	// Ex. "...?page=1"  ---> request.getParameter("page") 는 1을 리턴.
	// [기억] integer.parseInt("1") ---> 1을 리턴
	public Connection getConnection() throws Exception{
		Connection conn;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "temp";
		String dbPw = "1234";
		
		Class.forName(driver); // jdbc 드라이버 로딩
		conn = DriverManager.getConnection(url, dbId, dbPw);
					//DB접속으로 시도--> Connection 객체를 리턴
		
		return conn;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이징연습</title>
<script src="js/jquery-3.7.0.min.js"></script>
<script>
	$(function(){
		$(".write_btn_board").click(function(){
			location.href = "Ex13_board_write.jsp";
		});
	});
</script>
<style>
	table {
		margin: 12% auto 1%;
		text-align: center;
		border-collapse: collapse; 
	}
	th, td {
		border: 1px solid black;
		padding: 8px;
	}
	tr:hover {transition: .5s; background: #E0EBFF; cursor: pointer; font-weight: 700;}
	.btn_board{ margin: auto; width: 300px; display: flex;}
	.single_btn_board{ padding: 5px; margin: auto; }
	.btn_area{width: 300px; margin: 1% auto 0%;}
</style>
</head>
<body>
	<div style="width: 100%;">
		<table>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일시</th>
			</tr>
			<%
				Connection conn = getConnection();
				String sql = "SELECT rownum, b2.*"
					+" FROM(SELECT rownum rnum , b1.* FROM (SELECT *FROM board ORDER BY bno DESC)b1)b2"
					+" WHERE b2.rnum >=? AND b2.rnum <=?";
					int startNum = (pageNum * 10)-9;
					int endNum = pageNum * 10;
				PreparedStatement pstmt = conn.prepareStatement(sql);
							// PreparedStatement : spl문을  저장하고 실행하는 객체.
							// conn.prepareStatement(...) : pstmt 객체를 만들 & sql 문을 장착함
							
				pstmt.setInt(1, startNum);
							// pstmt.setInt(물음표번호, 정수값)--> 물음표를 그값으로 전환
							// 참고) pstmt.setString(물음표번호, 문자열);
				pstmt.setInt(2, endNum);
							// SELECT 문의 실행 ---> "ResultSet rs = pstmt.executeQuery();"	
							// INSERT INTO, UPDATE, DELETE 문의 실행 -->  pstmt.executoUpdate();
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()){	
							// rs.next() : rs손가락을 한줄 내리고
							//				가리키는 데이터가 존재하면 true를 리턴
							//				가리키는 데이터가 존재하지않으면 false를 리턴
			%>
			<tr>
				<td><%=rs.getInt("bno") %></td>			
				<td><%=rs.getString("title") %></td>			
				<td><%=rs.getString("writer")%></td>			
				<td><%=rs.getString("bdate") %></td>			
			</tr>
			<%
				}
			%>
		</table>
			<div class="btn_board">
				<%for(int i =1; i<=10; i++){ %>
					<a href="Ex13_board_paging.jsp?pageNum=<% out.print(i); %>" class="single_btn_board"><%out.print(i);%></a>
				<%} %>
			</div>
			<div class="btn_area">
				<button class="write_btn_board"> 글쓰기</button>
			</div>
		</div>
</body>
</html>