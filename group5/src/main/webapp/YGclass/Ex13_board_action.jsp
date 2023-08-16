<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");

	int bno = Integer.parseInt(request.getParameter("bno"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	
	boardWrite(bno, title, content, writer);
%>
<%!
	public Connection getConnection() throws Exception{
		Connection conn;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
		String dbid = "group5";
		String dbpw = "abcd1234";
		
		Class.forName(driver); // jdbc 드라이버 로딩
		conn = DriverManager.getConnection(url, dbid, dbpw);
					//DB접속으로 시도--> Connection 객체를 리턴
		
		return conn;
	}
	public void boardWrite(int bno, String title, String content, String writer) throws Exception{
		String sql = "INSERT INTO board(bno, title, content, writer, bdate, viewer)"
				+ " VALUES(?,?,?,?,sysdate,0)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,bno);
		pstmt.setString(2,title);
		pstmt.setString(3,content);
		pstmt.setString(4,writer);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
%>
<script>
	alert("작성이 완료되었습니다.");
	location.href = "Ex13_board_paging.jsp";
</script>