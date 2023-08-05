<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%
session = request.getSession(false);
if (session != null) {
	session.setMaxInactiveInterval(1800); // 1800초 = 30분
	response.setStatus(HttpServletResponse.SC_OK);
} else {
	response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
}
%>
