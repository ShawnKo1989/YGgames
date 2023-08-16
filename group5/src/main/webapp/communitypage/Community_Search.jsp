<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.PostDTO" %>
<%@ page import="dao.PostDAO" %>
<%@ page import="java.util.List" %> 
	<%
		String searchData = request.getParameter("Commu_Search"); 
		String upload_text = request.getParameter("write_reply");
		PostDAO commuDAO = PostDAO.getInstance();
		List<PostDTO> searchPost = commuDAO.searchPost(searchData);	
		int totalPosts = commuDAO.getSearchPosts(searchData);
		
	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%out.print(searchData+"에 대한 검색 결과"); %></title>
	<link rel="stylesheet" href="css/Community.css" />
</head>
<body>
	<jsp:include page="CommunitySideBar.jsp" />
	<div class="right">
		<div class="rightBackImg">
			<div class="rightTopIn">
				<div class="searchBox">
					<div class="searchGlass">
						<img src="images/search.png">
					</div>
					<form action="/group5/communitypage/Community_Search.jsp" method="GET">
					<input type="text" id="searchTitleIn" name="Commu_Search" placeholder="  검색어를 입력해주세요." spellcheck="false" autocomplete="off"/>
					</form>
				</div>
			</div>
			<div class="showBoardName">
			<%out.print(searchData+"에 대한 검색 결과"); %>
			</div>
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
						<td class="writer"><span>
								<% out.print(post.getNickname());%>
						</span></td>
						<td class="day"><span>
								<%out.print(post.getUploadDate()); %>
						</span></td>
						<td class="view"><span>
								<%out.print(post.getViewCnt()); %>
						</span></td>
					</tr>
					<%} %>
				</table>
				<div class="bottomSpace"></div>
			</div>
		</div>
</body>
</html>