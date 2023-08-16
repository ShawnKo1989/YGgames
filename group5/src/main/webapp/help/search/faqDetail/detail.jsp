<%@page import="dto.FaqDetailDto"%> 
<%@page import="dto.FaqDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	session.setAttribute("previousUrl",	request.getRequestURL().toString());

	FaqDto fDto = (FaqDto)request.getAttribute("fDto");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FAQ 상세보기</title>
	<link rel="stylesheet" href="/group5/css/public/common.css" />
	<link rel="stylesheet" href="/group5/css/elements/searchBar.css" />
	<link rel="stylesheet" href="/group5/css/layout/faqDetail.css" />
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<script defer src="/group5/js/common.js"></script>
	<style>
	header .nav {
		position: static;
	}
	</style>
</head>
<body>
	<header>
		<jsp:include page="/outframe/NavBar2.jsp"></jsp:include>
	</header>
	<main>
		<div id="pageHeader_wrap">
			<div>
				<span>
					<span class="goHelp clickable">메인 페이지</span>
				</span>
				<span>&gt;</span> <span><%=fDto.getCategoryName() %></span>
			</div>
			<form action="/group5/ControllerHelp" class="searchBarForm">
				<input name="command" value="search" type="hidden" />
				<input class="searchBar" name="search" type="text" placeholder="지원센터 겁색" />
			</form>
		</div>
		<div class="articleView">
			<div class="sectionNav">
				<div class="articleLinks">
					<h4 class="articleLinksTitle">섹션으로 이동</h4>
					<ul class="articleLinksList">
						<%
							for(int i=1; i<fDto.getDetail().size(); i++) {
									FaqDetailDto fDetail = fDto.getDetail().get(i);
									String tag = fDetail.getTag();
									if(!tag.equals("h2")){
										continue;
									}
									String content = fDetail.getContent();
									
						%>
						<li><a href="#subtitle<%=i %>" ><%=content %></a></li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
			<div class="article">
				<h1 class="articleTitle"><%=fDto.getDetail().get(0).getContent() %></h1>
				<div class="articleBody">
					<%
						for(int i=1; i<fDto.getDetail().size(); i++) {
							FaqDetailDto fDetail = fDto.getDetail().get(i);
							String tag = fDetail.getTag();
							String content = fDetail.getContent();
							if(tag.equals("ol")||tag.equals("ul")) {
					%>
					<<%=tag %>>
						<%
								String[] lists = content.split("다\\.");
								for(String list : lists) {
									list = list.trim();
						%>
						<li><%=list + ((list.charAt(list.length()-1)+"").equals(".") ? "":"다.") %></li>
						<%
								}
						%>
					</<%=tag %>>
					<%
							} else {
					%>
					<<%=tag.equals("h2") ? tag + " id=\"subtitle" + i + "\"" : tag %>><%=content %></<%=tag %>>
					<%
							}
						}
					%>
				</div>
			</div>
		</div>
		<div class="tailWrap">
			<div>
				<h3>원하는 내용을 찾을 수 없나요?</h3>
				<p>자주 조회되는 문서를 살펴보시거나 어떤 도움이 필요한지 알려주시면 기꺼이 도와드리겠습니다.</p>
			</div>
			<a class="button_contact" href="/group5/help/contactUs">문의하기</a>
		</div>
	</main>
	<footer>
		<jsp:include page="/outframe/BottomFooter.jsp"></jsp:include>
	</footer>
</body>
</html>