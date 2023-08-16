<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dto.NewsDTO"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList"%>

<%
        int newsNo = (int)request.getAttribute("newsNo");
        
        NewsDTO news = (NewsDTO)request.getAttribute("news");
        ArrayList<String> contentList = new ArrayList<>();
        ArrayList<Integer> contentTypeList = news.getContentType();
		String title="";
        String news_date = "";
        String writer = "";
        String img = "";

        if (news != null) {
	        title = news.getTitle();
            news_date = news.getNewsDate();
            writer = news.getWriter();
            img = news.getNewsMainImg();
            contentList = news.getContent();
        }
    %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=title%></title>
	<link rel="stylesheet" href="/group5/css/News.css" />
	<script src="../group5/js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<jsp:include page="../outframe/NavBar2.jsp" />
	<jsp:include page="../outframe/SecondNav.jsp" />
	<!-- 각 새소식에 따른 정보 출력 -->
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
	<jsp:include page="../outframe/BottomFooter.jsp" />
</body>
</html>
