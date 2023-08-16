<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	response.setContentType("text/html");

	session.setAttribute("previousUrl", request.getRequestURL().toString());

	try {
		if((Boolean)session.getAttribute("isLogin")) {
			RequestDispatcher rd = request.getRequestDispatcher("/ControllerHelp?command=contactUsForm");
			rd.forward(request, response);
		}
	} catch(Exception e) {
		String url = "/group5/signinpage/signin.jsp";
		String script = "<script>location.href='" + url + "'</script>";
		out.println(script);
	}
%>
