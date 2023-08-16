<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	session.setAttribute("previousUrl", request.getRequestURL().toString());
	String command = request.getParameter("command");
	String url = "/ControllerHelp?command=" + (command==null ? "search" : command);
	RequestDispatcher rd = request.getRequestDispatcher(url);
	rd.forward(request, response);
%>
