<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="DTO.NewsDTO"%>
<%@ page import="DAO.NewsDAO"%>
<%@ page import="java.util.ArrayList"%>

<%
        int newsNo = Integer.parseInt(request.getParameter("newsNo"));
        NewsDAO newsDAO = NewsDAO.getInstance();
        NewsDTO news = newsDAO.getNewsByNo(newsNo);
 
        String title = news.getTitle();
        String news_date = news.getNewsDate();
        String writer = news.getWriter();
        String img = news.getNewsMainImg();
        ArrayList<String> contentList = news.getContent();
        ArrayList<Integer> contentTypeList = news.getContentType();
    %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=title%></title>
	<link rel="stylesheet" href="css/News.css" />
</head>
<body>
	<jsp:include page="NavBar2.jsp" />
	
	<img src="<%=img%>" class="mainImg">
	<main>
		<h1>
			<%=title%>
		</h1>
		<br>
		<div>
			<span><%=news_date%><br></span>
		</div>
		<div>
			<%
                if (writer != null) {
            %>
			<h6 style="font-size: 18px;">
				작성자 : <%=writer%>
			</h6>
			<%
            }
            %>
		</div>
		<br>
		<div>
			<%
                for (int i = 0; i < contentList.size(); i++) {
                    int contentType = contentTypeList.get(i);
                    String content = contentList.get(i);
            %>
			<div class="content">
				<%
                    if (contentType == 2) {
                %>
				<br> <img src="<%=content%>" class="contentImg"><br> <br>
				<%
                    } else if (contentType == 1) {
                %><span><%=content%></span><br>
                <% } else if (contentType == 0) { %>
				<h2><%=content%></h2><br>
			</div>
		</div>
		<%
            }
        }
        %>
	</main>
	<jsp:include page="BottomFooter.jsp" />
</body>
</html>
