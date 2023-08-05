<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DTO.PostDTO" %>
<%@ page import="java.util.ArrayList" %>
	<%
		String searchData = request.getParameter("searching"); 
		ArrayList<PostDTO> searchPost = (ArrayList<PostDTO>)request.getAttribute("searchPost");	
		int totalPosts = (int)request.getAttribute("totalPosts");
		
	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%out.print(searchData+"에 대한 검색 결과"); %></title>		<!-- 검색한 정보 입력 -->
	<script src="jq/jquery-3.7.0.min.js"></script>
	<link rel="stylesheet" href="css/Community.css" />
</head>
<body>
	<jsp:include page="CommunitySideBar.jsp" />
	<div class="right">
		<div class="rightBackImg">
			<div class="rightTopIn">
				<!-- 게시글 검색 기능 -->
				<div class="searchBox">
					<div class="searchGlass">
						<img src="images/search.png">
					</div>
					<form action="Controller" method="GET">
						<input type="text" id="searchTitleIn" name="searching" placeholder="  검색어를 입력해주세요." spellcheck="false" autocomplete="off"/>
						<input type="hidden" name="command" value="communitySearch"/>
					</form>
				</div>
			</div>
			<!-- 검색에 대한 정보 입력 -->
			<div class="showBoardName">
			<%out.print(searchData+"에 대한 검색 결과"); %>
			</div>
			<!-- 게시글 갯수 -->
			<div class="showCntPost">
				<%out.print(totalPosts); %>개의 글
			</div>
				<table style="margin-bottom: 50px;" class="leftBarSearch">
					<tr class="allBoardTitleInBoard">
						<th class="postNo"><span>글 번호</span></th>
						<th class="title"><span>제목</span></th>
						<th class="writer"><span>작성자</span></th>
						<th class="day"><span>작성일</span></th>
						<th class="view"><span>조회</span></th>
					</tr>
					<!-- 검색 정보와 맞는 게시글 불러오기 -->
					<%for (PostDTO post : searchPost) { %>
					<tr class="allBoardItemsInBoard">
						<td class="postNo"><span>
								<%out.print(post.getPostNo()); %>
						</span></td>
						<td class="title">
							<a href="Community_ShowBoard.jsp?showPostNo=<%out.print(post.getPostNo()); %>">
							 	<span>
									<%out.print(post.getTitle()); %>
								</span>
							</a>
						</td>
						<td class="writer">
							<span>
								<% out.print(post.getNickname());%>
							</span>
						</td>
						<td class="day">
							<span>
								<%out.print(post.getUploadDate()); %>
							</span>
						</td>
						<td class="view">
							<span>
								<%out.print(post.getViewCnt()); %>
							</span>
						</td>
					</tr>
					<%} %>
				</table>
				<div class="bottomSpace"></div>
			</div>
		</div>
</body>
</html>