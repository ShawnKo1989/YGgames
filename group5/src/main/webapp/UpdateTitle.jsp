<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.io.PrintWriter" %>
<%
request.setCharacterEncoding("utf-8");
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection con = DriverManager.getConnection("jdbc:oracle:thin:@210.114.1.134:1521:xe","project5","qwer1234");
String title = request.getParameter("title");
String sql = "UPDATE my_room SET now_style=? WHERE reg_no=" + session.getAttribute("reg_no");
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, title);
pstmt.executeUpdate();
%>