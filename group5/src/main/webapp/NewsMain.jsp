<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DTO.NewsDTO" %>

<%
    int number = 0;
    int newsPage = 0;
    try {
        newsPage = Integer.parseInt(request.getParameter("page"));
    } catch (NumberFormatException e) {
        newsPage=1;
    }
    if (newsPage == 1) {
        number = 0;
    } else if (newsPage == 2) {
        number = 10;
    } else if (newsPage == 3) {
        number = 18;
    }

    ArrayList<NewsDTO> newsList = (ArrayList<NewsDTO>)request.getAttribute("newsList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 소식</title>
    <link rel="stylesheet" href="css/NewsMain.css" />
    <script src="jq/jquery-3.7.0.min.js"></script>
</head>
<body>
    <jsp:include page="NavBar2.jsp" />
    <jsp:include page="SecondNav.jsp" />
    <main>
    	<!-- 뉴스 메인페이지 이동 -->
        <div>
            <h3>에픽게임즈 새 소식</h3>
        </div>
        <div class="newsMain">
            <div class="newsLeft">
                <a href="Controller?command=newsIn&newsNo=<%= newsList.get(9).getNewsNo() %>">
                    <div class="newsMainImg">
                        <img src="<%= newsList.get(9).getNewsMainImg() %>" style="width: 100%; height: 100%;">
                    </div>
                </a>
                <br/>
                <span style="color: rgba(255, 255, 255, 0.6)">
                    <%= newsList.get(9).getNewsDate() %>
                </span>
                <a href="Controller?command=newsIn&newsNo=<%= newsList.get(9).getNewsNo() %>">
                    <h5 style="color: white; font-size: 16px;">
                        <%= newsList.get(9).getTitle() %>
                    </h5>
                </a>
                <span class="subtitle">
                    <%= newsList.get(9).getSubtitle() %>
                </span>
                <a class="see" href="Controller?command=newsIn&newsNo=<%= newsList.get(9).getNewsNo() %>">
                    <br/>
                    <br/>
                    <br/>
                    <span class="See">자세히보기</span>
                </a>
            </div>
            <div class="newsRight">
                <a href="Controller?command=newsIn&newsNo=<%= newsList.get(8).getNewsNo() %>">
                    <div class="newsMainImg">
                        <img src="<%= newsList.get(8).getNewsMainImg() %>" style="width: 100%; height: 100%;">
                    </div>
                </a>
                <br/>
                <span style="color: rgba(255, 255, 255, 0.6)">
                    <%= newsList.get(8).getNewsDate() %>
                </span>
                <a href="Controller?command=newsIn&newsNo=<%= newsList.get(8).getNewsNo() %>">
                    <h5 style="color: white; font-size: 16px;">
                        <%= newsList.get(8).getTitle() %>
                    </h5>
                </a>
                <span class="subtitle">
                    <%= newsList.get(8).getSubtitle() %>
                </span>
                <a class="see" href="Controller?command=newsIn&newsNo=<%= newsList.get(8).getNewsNo() %>">
                    <br/>
                    <br/>
                    <br/>
                    <span class="See">자세히보기</span>
                </a>
            </div>
        </div>
        <br/>
        <br/>
        <!-- 각 새 소식에 대한 정보 입력(페이지네이션 기능 추가) -->
        <div class="subNews">
            <ul class="subNewsItem">
                <% for (int k = 7; k >= 0; k--) { %>
                <li>
                    <article>
                        <div class="subNewsFlex">
                            <a href="Controller?command=newsIn&newsNo=<%= newsList.get(k).getNewsNo() %>" class="subNewsImg">
                                <img src="<%= newsList.get(number + k).getNewsImg() %>" style="width: 200px; height: 112.5px;">
                            </a>
                            <div class="subNewsContent">
                                <span style="color: rgba(255, 255, 255, 0.6)">
                                    <%= newsList.get(number + k).getNewsDate() %>
                                </span>
                                <a href="Controller?command=newsIn&newsNo=<%= newsList.get(k).getNewsNo() %>" class="subNewsImg">
                                    <span class="subNewsTitle">
                                        <br/>
                                        <%= newsList.get(number + k).getTitle() %>
                                    </span>
                                    <br/>
                                </a>
                                <span class="subNewsSubtitle">
                                    <% if (newsList.get(number + k).getSubtitle() != null) { %>
                                        <%= newsList.get(number + k).getSubtitle() %>
                                    <% } %>
                                </span>
                                <a class="see" href="Controller?command=newsIn&newsNo=<%= newsList.get(k).getNewsNo() %>">
                                    <br/>
                                    <br/>
                                    <span class="See">자세히보기</span>
                                </a>
                            </div>
                        </div>
                    </article>
                </li>
                <% } %>
            </ul>
        </div>
        <!-- 페이지 네이션 기능 -->
        <div class="pageChange">
            <a href="Controller?command=news&page=1">
                <span class="<% if (number == 0) { %>stay<% } else { %>change<% } %>">1</span>
            </a>
            <a href="Controller?command=news&page=2">
                <span class="<% if (number == 10) { %>stay<% } else { %>change<% } %>">&nbsp;&nbsp;2&nbsp;&nbsp;</span>
            </a>
            <a href="Controller?command=news&page=3">
                <span class="<% if (number == 18) { %>stay<% } else { %>change<% } %>">3</span>
            </a>
        </div>
    </main>
    <jsp:include page="BottomFooter.jsp" />
</body>
</html>
