<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@210.114.1.134:1521:xe","project5","qwer1234");
	Statement stmt = conn.createStatement();
	String reg_no = request.getParameter("reg_no");
	String sql = "UPDATE friends SET are_we_friend = 1"
			  + " WHERE from_reg_no = "+reg_no+" AND to_reg_no = "+session.getAttribute("reg_no");
	stmt.executeUpdate(sql);
	stmt.close();
	conn.close();
} catch(Exception e) {
	e.printStackTrace();
}
%>