<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	session.setAttribute("previousUrl", request.getRequestURL().toString());
	String command = request.getParameter("command");
	command = command==null ? "reservationForm" : command;
	
	String url = "/Controller?command=" + command;
	
	RequestDispatcher rd = request.getRequestDispatcher(url);
	rd.forward(request, response);
%>
