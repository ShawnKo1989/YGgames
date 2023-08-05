<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DTO.PostDTO" %>
<%@ page import="Servlet.CommunityBoardServlet" %>
<%
	int boardNo = (int)request.getAttribute("boardNo");
	
	int pageNo = 1;
	try {
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
	} catch (NumberFormatException e) {
		pageNo = 1;
	}
	int postsPerPage = 10;

	String boardName = (String)request.getAttribute("boardName");
	int totalPosts = (int)request.getAttribute("totalPosts");
	int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);
	
// 	List<PostDTO> postList = (List<PostDTO>)request.getAttribute("postList");
	ArrayList<?> list1 = (ArrayList<?>)request.getAttribute("postList");
	ArrayList<PostDTO> postList = new ArrayList<PostDTO>();
	for(Object obj : list1){
		if(obj instanceof PostDTO)
			postList.add((PostDTO)obj);
	}
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=boardName%></title>
	<script src="jq/jquery-3.7.0.min.js"></script>

</head>
<body>
<jsp:include page="CommunitySideBar.jsp" />
<div class="right">
	<div class="rightBackImg">
		<div class="rightTopIn">
			<!-- 게시글 검색 기능 -->
			<div class="searchBox">
				<div class="searchGlass">
					<img src="images/search.png" alt="Search">
				</div>
				<form action="Controller" method="GET">
					<input type="text" id="searchTitleIn" name="searching" placeholder="검색어를 입력해주세요." spellcheck="false" autocomplete="off"/>
					<input type="hidden" name="command" value="communitySearch"/>
				</form>
			</div>
		</div>
		<!-- 게시판 이름 출력 -->
		<div class="showBoardName">
			<%=boardName%>게시판
		</div>
		<!-- 게시글 갯수 출력 -->
		<div class="showCntPost">
			<%=totalPosts%>개의 글
		</div>
		<div class="leftBarIn">
			<table style="margin-bottom: 50px;">
				<tr class="allBoardTitleInBoard">
					<th class="postNo"><span>글 번호</span></th>
					<th class="title"><span>제목</span></th>
					<th class="writer"><span>작성자</span></th>
					<th class="day"><span>작성일</span></th>
					<th class="view"><span>조회</span></th>
				</tr>
				<!-- 게시글 불러오기 -->
				<%
					for (PostDTO post : postList) {
				%>
				<tr class="allBoardItemsInBoard">
					<td class="postNo"><span><%= post.getPostNo() %></span></td>
					<td class="title">
						<a href="Controller?command=showPostAction&showPostNo=<%= post.getPostNo() %>">
							<span><%= post.getTitle() %></span>
						</a>
					</td>
					<td class="writer"><span><%= post.getNickname() %></span></td>
					<td class="day"><span><%= post.getUploadDate() %></span></td>
					<td class="view"><span><%= post.getViewCnt() %></span></td>
				</tr>
				<% } %>
			</table>
		</div>
		<!-- 페이지네이션 -->
		<div class="pagination">
			<%
			int maxPagesDisplayed = 8;
			int startPage = ((pageNo - 1) / maxPagesDisplayed) * maxPagesDisplayed + 1;
			int endPage = startPage + maxPagesDisplayed - 1;
			if (endPage > totalPages) {
				endPage = totalPages;
			}

			if (pageNo > 1) {
				out.print("<a class='pageSource' href='Controller?command=communityBoard&boardNo=" + boardNo + "&pageNo=" + 1 + "'>&laquo;</a>");
				out.print("<a class='pageSource' href='Controller?command=communityBoard&boardNo=" + boardNo + "&pageNo=" + (pageNo - 1) + "'>&lt;</a>");
			}

			for (int i = startPage; i <= endPage; i++) {
				if (i == pageNo) {
					out.print("<a class='currentPage' href='Controller?command=communityBoard&boardNo=" + boardNo + "&pageNo=" + i + "'>" + i + "</a>");
				} else {
					out.print("<a class='pageSource' href='Controller?command=communityBoard&boardNo=" + boardNo + "&pageNo=" + i + "'>" + i + "</a>");
				}
			}

			if (pageNo < totalPages) {
				out.print("<a class='pageSource' href='Controller?command=communityBoard&boardNo=" + boardNo + "&pageNo=" + (pageNo + 1) + "'>&gt;</a>");
				out.print("<a class='pageSource' href='Controller?command=communityBoard&boardNo=" + boardNo + "&pageNo=" + totalPages + "'>&raquo;</a>");
			}
			%>
		</div>
		<div class="bottomSpace"></div>
	</div>
</div>
</body>
</html>
