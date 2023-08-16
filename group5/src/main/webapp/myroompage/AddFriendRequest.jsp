<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
try {
	String reg_no = request.getParameter("reg_no");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@210.114.1.134:1521:xe","project5","qwer1234");
	Statement stmt = conn.createStatement();
	String sql = "INSERT INTO friends(from_reg_no, to_reg_no) VALUES("+session.getAttribute("reg_no")+", "+reg_no+")";
	stmt.executeUpdate(sql);
	stmt.close();
	conn.close();
} catch(Exception e) {
	e.printStackTrace();
}
%>