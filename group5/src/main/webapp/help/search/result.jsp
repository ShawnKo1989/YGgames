<%@page import="dto.FaqDto"%> 
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	session.setAttribute("previousUrl", request.getRequestURL().toString());
%>
<%
	int pno = 1;
	int isTotal = 1;
	String search = null;
	int cno = 0;
	String resultStyle = null;
	
	pno = (int)request.getAttribute("pno");
	isTotal = (int)request.getAttribute("isTotal");
	search = (String)request.getAttribute("search");
	cno = (int)request.getAttribute("cno");
	resultStyle = (String)request.getAttribute("resultStyle");
	
	ArrayList<FaqDto> fList = (ArrayList<FaqDto>)request.getAttribute("fList");
	int[] rsSize = (int[])request.getAttribute("rsSize");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>검색결과 - QKYG 지원센터</title>
	<link rel="stylesheet" href="/group5/css/public/common.css" />
	<link rel="stylesheet" href="/group5/css/elements/searchBar.css" />
	<link rel="stylesheet" href="/group5/css/layout/search.css" />
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<script defer src="/group5/js/common.js"></script>
	<script defer src="/group5/js/search.js"></script>
	<script>
		let search = `<%=search %>`;
		let category = <%=cno %>;
		let total = <%=isTotal %>;
		let resultStyle = `<%=resultStyle %>`;
		let page = resultStyle === `list` ? 1 : <%=pno %>;
	</script>
</head>
<body>
	<header>
		<jsp:include page="/outframe/NavBar2.jsp"></jsp:include>
	</header>
	<main>
		<div id="pageHeader_wrap">
			<div>
				<span> &lt; </span> <span> <span class="goHelp clickable">메인 페이지</span>
				</span>
			</div>
			<form action="/group5/ControllerHelp" class="searchBarForm">
				<input class="searchBar" name="search" type="text" placeholder="지원센터 겁색" />
				<input type="hidden" name="command" value="search" />
			</form>
			<%
				if (!search.equals("")) {
			%>
			<h1>다음에 대한 결과 "<strong id="search">${search }</strong>"	</h1>
			<select id="resultFormType" name="resultStyle" class="fr">
				<option value="<%=resultStyle.equals("page") ? "page" : "list" %>"><%=resultStyle.equals("page") ? "페이지" : "리스트" %> 보기</option>
				<option value="<%=resultStyle.equals("page") ? "list" : "page" %>"><%=resultStyle.equals("page") ? "리스트" : "페이지" %> 보기</option>
			</select>
			<div class="clear"></div>
			<%
				} else {
			%>
			<h1>검색어를 입력하세요.</h1>
				<%
					if(isTotal==1) {
				%>
				<select id="resultFormType" name="resultStyle" class="fr">
					<option value="<%=resultStyle.equals("page") ? "page" : "list" %>"><%=resultStyle.equals("page") ? "페이지" : "리스트" %> 보기</option>
					<option value="<%=resultStyle.equals("page") ? "list" : "page" %>"><%=resultStyle.equals("page") ? "리스트" : "페이지" %> 보기</option>
				</select>
				<div class="clear"></div>
			<%
					}
				}
			%>
		</div>
		<div id="searchResultWrap">
			<div id="categoryNav" class="fl">
				<h3 class="clickable<%=isTotal==1 ? " pickedCategory":"" %>" onclick="location.href=`?command=search&total=1`">전체 글 보기</h3>
				<h3>카테고리 찾아보기</h3>
				<ul>
					<li><button class="btn_cat<%=cno==0 ? " pickedCategory":"" %>" value="0" >전체 카테고리 <%=!search.equals("") ? "("+ rsSize[0] + ")" :"" %></button></li>
					<li><button class="btn_cat<%=cno==1 ? " pickedCategory":"" %>" value="1" >QKYG 스토어 <%=!search.equals("") ? "(" + rsSize[1] + ")" : "" %></button></li>
					<li><button class="btn_cat<%=cno==2 ? " pickedCategory":"" %>" value="2" >계정 관련 <%=!search.equals("") ? "(" + rsSize[2] + ")" : "" %></button></li>
					<li><button class="btn_cat<%=cno==3 ? " pickedCategory":"" %>" value="3" >과금 지원 <%=!search.equals("") ? "(" + rsSize[3] + ")" : "" %></button></li>
					<li><button class="btn_cat<%=cno==4 ? " pickedCategory":"" %>" value="4" >기술 지원 <%=!search.equals("") ? "(" + rsSize[4] + ")" : "" %></button></li>
				</ul>
			</div>
			<%
				if (search.length()>0 || isTotal==1) {
			%>
			<div id="article_list_wrap" class="fr">
				<ul>
					<%
						for (FaqDto fDto :  fList) {
					%>
					<li class="articleList_item">
						<a class="articleList_item_link" href="/group5/help/search/faqDetail/?command=viewFaq&fno=<%=fDto.getFno() %>" >
							<div class="link-title"><%=fDto.getTitle() %></div>
						</a>
					</li>
					<%
						}
					%>
				</ul>
				<%
					if(resultStyle.equals("page") && rsSize[cno]/10>0) {
				%>
				<ul class="paginations">
					<<%=pno==1 ? "span":"a" %> class="pagination" <%=pno==1 ? "":"href=\"?command=search&page=1" + "&total=" + isTotal + "&search=" + search + "&category=" + cno + "\"" %> >첫 페이지</<%=pno==1?"span":"a" %>>
					<%
						int lastPno = rsSize[cno]%10==0 ? rsSize[cno]/10 : rsSize[cno]/10+1;
						for(int i = (pno < 5 ? 1 : pno-4); i <= (pno+4<lastPno ? pno+4 : lastPno); i++) {
							String tag = pno==i ? "span": "a";
					%>
						<<%=tag %> class="pagination" <%=tag.equals("a") ? "href=\"?command=search&page=" + i + "&total=" + isTotal + "&search=" + search + "&category=" + cno + "\"" : ""%>><%=i %></<%=tag %>>
					<%
						}
					%>
					<<%=pno==lastPno ? "span":"a" %> class="pagination" <%=pno==lastPno ? "":"href=\"?command=search&page=" + lastPno + "&total=" + isTotal + "&search=" + search + "&category=" + cno + "\"" %> >마지막 페이지</<%=pno==lastPno?"span":"a" %>>
				</ul>
				<%
					}
				%>
			</div>
			<%
				}
			%>
			<div class="clear"></div>
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
