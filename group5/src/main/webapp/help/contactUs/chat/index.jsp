<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	RequestDispatcher rd = request.getRequestDispatcher("/ControllerHelp?command=contactChat");
	rd.forward(request, response);
%>
