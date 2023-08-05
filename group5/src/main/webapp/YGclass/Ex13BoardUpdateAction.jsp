<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
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
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Connection conn = getConnection();
	
	String sql = "UPDATE board SET title=?, content=?, writedate=sysdate WHERE bno=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, content);
	pstmt.setInt(3, bno);
	
	int r = pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
%>
<script>
	<%
		if(r==1) {
	%>
	alert("수정된 글이 등록되었습니다.");
	location.href = "Ex13BoardDetail.jsp?bno=<%=bno%>";
	<%
		} else {
	%>
	alert("등록 실패.");
	history.back();
	<%
		} 
	%>
</script>