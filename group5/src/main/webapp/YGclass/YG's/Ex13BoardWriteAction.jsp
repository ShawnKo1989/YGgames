<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<%!
	public Connection getConnection(){
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
		String dbid = "testw8";
		String dbpw = "pass1234";
		
		Connection conn = null;
		try{
			Class.forName(driver);	// JDBC 드라이버 로딩.
			conn = DriverManager.getConnection(url, dbid, dbpw);
								// DB접속 시도 ---> Connection 객체 리턴.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
%>
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	
	Connection conn = getConnection();
	
	String sql = "INSERT INTO board(bno, title, content, writer) VALUES (?,?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	pstmt.setString(2, title);
	pstmt.setString(3, content);
	pstmt.setString(4, writer);
	
	
	int r = 0;
	try {
		r = pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	pstmt.close();
	conn.close();
%>
<script>
	<%
		if(r==1) {
	%>
	alert("글이 등록되었습니다.");
	location.href = "Ex13BoardList.jsp";
	<%
		} else {
	%>
	alert("등록 실패.");
	history.back();
	<%
		} 
	%>
</script>