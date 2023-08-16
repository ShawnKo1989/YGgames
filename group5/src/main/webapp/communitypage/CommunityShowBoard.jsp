<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="servlet.UpdateLikeCntMinusServlet" %>
<%@ page import="servlet.UpdateLikeCntPlusServlet" %>
<%@ page import="dto.PostDTO" %>
<%@ page import="dto.ReplyDTO" %>
<%@ page import="dao.ReplyDAO" %>

<%
String loginNickname = ""+session.getAttribute("userNickname");
int showPostNo=0;
try {
	if(request.getParameter("showPostNo")!=null){
	showPostNo = Integer.parseInt(request.getParameter("showPostNo"));
	}
} catch (java.lang.NumberFormatException e) {
	showPostNo=0;
}
int regNo=0;
try{	//세션에서 로그인 정보 받아오기
	if(session.getAttribute("reg_no")!=null){
	regNo=(Integer)session.getAttribute("reg_no");}
} catch(java.lang.NullPointerException e){
	regNo=0;
}


int replyCnt = (int)request.getAttribute("replyCnt");

// ArrayList<PostDTO> showPosts = (ArrayList<PostDTO>)request.getAttribute("showPosts");
ArrayList<?> list1 = (ArrayList<?>)request.getAttribute("showPosts");		//controller를 통해 게시글 불러오기
ArrayList<PostDTO> showPosts = new ArrayList<PostDTO>();
for(Object obj : list1){
	if(obj instanceof PostDTO)
		showPosts.add((PostDTO)obj);
}

//ArrayList<ReplyDTO> showReply = (ArrayList<ReplyDTO>)request.getAttribute("showReply");
ArrayList<?> list2 = (ArrayList<?>)request.getAttribute("showReply");
ArrayList<ReplyDTO> showReply = new ArrayList<ReplyDTO>();
for(Object obj : list2){
	if(obj instanceof ReplyDTO)
		showReply.add((ReplyDTO)obj);
}

PostDTO post = showPosts.get(0);

%>


<!DOCTYPE html>
<html>
<head>
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<meta charset="UTF-8">
	<title><% out.print(post.getTitle()); %></title>
	
	<script>		// 답글 쓰기 클릭 시 댓글 수정 및 삭제가 숨김처리 및 열려있던 다른 답글쓰기 버튼 닫힘
	
	$(document).ready(function() {
		$(".childReply").click(function() {
			let replyBox = $(this).next(".childReplyBoxWrite");
			let isReplyBoxVisible = replyBox.is(":visible");
			$(".childReply").not(this).next(".childReplyBoxWrite").hide();
			$(".childReply").not(this).siblings(".updateReply").show();
			$(".childReply").not(this).siblings(".deleteReply").show();
			replyBox.toggle();
			$(this).siblings(".updateReply").toggle();
			$(this).siblings(".deleteReply").toggle();
			if (isReplyBoxVisible) {
				$(this).siblings(".updateReply").show();
				$(this).siblings(".deleteReply").show();
			}
		});
	});
	
	</script>
	
	<script>		// 댓글 수정 클릭 시 다른 댓글 수정 버튼 닫힘
	
	$(document).ready(function() {
		$(".updateReply").click(function() {
			let replyBox = $(this).next(".updateReplyBoxWrite");
			let isReplyBoxVisible = replyBox.is(":visible");
			$(".updateReply").not(this).next(".updateReplyBoxWrite").hide();
			$(".updateReply").not(this).siblings(".childReply").show();
			$(".updateReply").not(this).siblings(".deleteReply").show();
			replyBox.toggle();
			$(this).siblings(".childReply").toggle();
			$(this).siblings(".deleteReply").toggle();
			if (isReplyBoxVisible) {
				$(this).siblings(".childReply").show();
				$(this).siblings(".deleteReply").show();
			}
		});
		});
	
	</script>
	
	<script>	//댓글등록 aJax
	
		function submitReply() {
			let replyContent = $("#writeReply").val();
			let regNo = <%=regNo%>
			let showPostNo = <%=showPostNo%>
			if (replyContent === '') { 
				alert("내용을 입력해주세요.");
				return;
			} else {
				$.ajax({
					type: "POST",
					url: "ReplySaveServlet",
					data: { 
						writeReply: replyContent,
						reg_no: regNo,
						showPostNo: showPostNo
					},
					success: function() {
						alert("등록되었습니다!");
						$("#writeReply").val('');
						$(".replyBox").load("${contextPath} .replyBox")
					},
					error: function(request,status,error) {
						alert("오류가 발생했습니다.");
						console.log("code : "+request.status);
						console.log("message : "+request.responseText);
						console.log("error : "+error);
					}	
				});
			}
		}
	
	</script>
	
	<script>	//대댓글등록 aJax
	
	function submitChildReply(event) {
		let replyContent = $(event.target).siblings(".childWriteReply").val();
		let regNo = <%=regNo%>;
		let showPostNo = <%=showPostNo%>;
		let up_rpl_no = $(event.target).siblings(".upRplNoValue").val();
	
		if (replyContent === '') { 
			alert("내용을 입력해주세요.");
			return;
		} else {
			$.ajax({
				type: "POST",
				url: "ChildReplySaveServlet",
				data: { 
					writeReply: replyContent,
					reg_no: regNo,
					showPostNo: showPostNo,
					up_rpl_no:up_rpl_no
				},
				success: function() {
					alert("등록되었습니다!");
					$(".replyBox").load("${contextPath} .replyBox")
				},
				error: function(request,status,error) {
					alert("오류가 발생했습니다.");
					console.log("code : "+request.status);
					console.log("message : "+request.responseText);
					console.log("error : "+error);
				}	
			});
		}
	}
	</script>
	
	<script>	//댓글수정
	    function updateReply(event) {
	        let updateComment = $(event.target).siblings(".updateWriteReply").val();
	        let rpl_no = $(event.target).siblings(".rplNoValue").val();
	
	        if (confirm("수정하시겠습니까?")) {
	            $.ajax({
	                type: "POST",
	                url: "UpdateReplyServlet",
	                data: {
	                    rpl_no: rpl_no,
	                    updateComment: updateComment
	                },
	                success: function(response) {
	                    alert("수정되었습니다!");
	                    $(".replyBox").load("${contextPath} .replyBox")
	                },
	                error: function(request,status,error) {
	                    alert("오류가 발생했습니다.");
	                    console.log("code : "+request.status);
						console.log("message : "+request.responseText);
						console.log("error : "+error);
	                }
	            });
	        }
	    }
	</script>
	
	
	
	<script>	//댓글삭제 aJax
	function deleteReply(event) {
		let rpl_no = $(event.target).val();
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type: "POST",
				url: "DeleteReplyServlet",
				data: {
					rpl_no: rpl_no
				},
				success: function () {
					alert("삭제되었습니다!");
					$(".replyBox").load("${contextPath} .replyBox")
				},
				error: function (request,status,error) {
					alert("오류가 발생했습니다.");
					console.log("code : "+request.status);
					console.log("message : "+request.responseText);
					console.log("error : "+error);
				}
			});
		} 
	}
	
	</script>
	
	<script>
		function deletePost() {		//글삭제 aJax
			if (confirm("삭제하시겠습니까?")) {
				$.ajax({
					type: "POST",
					url: "DeletePostServlet",
					data: {
						post_no: <%=showPostNo%>
					},
					success: function () {
						alert("삭제되었습니다!");
						location.href="Controller?command=communityBoard&boardNo=0";
					},
					error: function (request,status,error) {
						alert("오류가 발생했습니다.");
						console.log("code : "+request.status);
						console.log("message : "+request.responseText);
						console.log("error : "+error);
					}
				});
			} 
		}
	</script>
	
	<script>	//좋아요 aJax
		$(document).ready(function() {
			let likeButton = $("#likeBtn");
			let likeImage = $("#heartImage");
			let isLiked = false;
			let likeCount = parseInt("<%=post.getLikeCnt()%>");
		
			likeButton.click(function() {
				if (isLiked) {		//좋아요 취소 시 aJax실행
				$.ajax({
					url: "UpdateLikeCntMinusServlet",
					method: "POST",
					data: { showPostNo: <%=showPostNo%> },
					success: function(response) {
					likeImage.attr("src", "images/heart.png");
					isLiked = false;
					likeCount--;
					$("#likeCnt").text(" 좋아요 " + likeCount + " ");
					},
					error: function(request,status,error) {
						console.log("code : "+request.status);
						console.log("message : "+request.responseText);
						console.log("error : "+error);
					}
				});
				} else {			//좋아요 클릭 시 aJax실행
				$.ajax({
					url: "UpdateLikeCntPlusServlet",
					method: "POST",
					data: { showPostNo: <%=showPostNo%> },
					success: function(response) {
					likeImage.attr("src", "images/fullHeart.png");
					isLiked = true;
					likeCount++;
					$("#likeCnt").text(" 좋아요 " + likeCount + " ");
					},
					error: function(request,status,error) {
						console.log("code : "+request.status);
						console.log("message : "+request.responseText);
						console.log("error : "+error);
					}
				});
				}
			});
		});

	
	</script>

</head>
<body>
	
<jsp:include page="CommunitySideBar.jsp" />
	<div class="right">
		<div class="rightBackImg">
			<div id="postSearchBox">
				<div id="postSearchGlass">
					<img src="images/search.png">
				</div>
				<form action="Controller" method="get" name="searchForm">
					<input type="text" id="searchTitleInPost" name="searching" placeholder="검색어를 입력해주세요." spellcheck="false" autocomplete="off"/>
					<input type="hidden" name="command" value="communitySearch"/>
				</form>
			</div>
			<div id="postItems">
				<!-- 본인의 게시글일 시 수정,삭제 활성화 -->
				<%	if (post.getNickname().equals(loginNickname)) {%>
				<a href="Controller?command=postWrite&postNo=<%=showPostNo%>&title=<%=post.getTitle()%>&updateValue=1&content=<%=post.getContent()%>">
					<button class="postItemsBtnLeft">글수정</button>	
				</a>
				<button class="postItemsBtnLeft" onclick="deletePost();">글삭제</button>
				<%}%>
				<a href="Controller?command=communityBoard&boardNo=0">
					<button class="postItemsBtnRight">목록</button>
				</a>
		    </div>
			<div id=showPost>	<!-- 게시글 정보 불러오기 -->
				<div id="showSubtitleInPost">
					<span>&emsp;★ &nbsp;<%out.print(post.getBoardTitle()); %>&nbsp;★</span>
				</div>
				<div id="showTitleInPost">
					<h3><%out.print(post.getTitle()); %></h3>		<!-- 제목 불러오기 -->
				</div>
				<div id="showNicknameInPost">
					<span>&emsp;&emsp;<%out.print(post.getNickname()); %></span>	<!-- 작성자 불러오기 -->
				</div>
				<div id="showUploadDateInPost">
					<span>&emsp;&emsp;<%out.print(post.getUploadDate()); %>&emsp;<%out.print("조회 "+post.getViewCnt()); %></span>
					<div style="float:right; margin-right:20px;">
					<a href="#replyBox">
						<img src="images/speech.png">
					</a>
						<span>댓글 &nbsp;<%out.print(replyCnt); %></span>	<!-- 댓글 갯수 출력 -->
					</div>
				</div>
				<div class="underLine"></div>
				<div id="postInContent">		<!-- content불러오기 ( 스마트에디터 정보 이용 ) -->
						<p><%out.print(post.getContent()); %></p>
				</div>
				<a name="replyBox"></a>
				<div id="showLikeViewCnt">
					<button id="likeBtn">
					<img id="heartImage" src="images/heart.png"/>
					</button>
					<span id="likeCnt" style="margin-right:40px;"> 좋아요 <%out.print(post.getLikeCnt()); %></span>
					<span><a href="#replyBox">
						<img src="images/speech.png">
					</a> 댓글&nbsp;<%out.print(replyCnt); %></span>
				</div>
				<div class="underLine"></div>
				<!-- 댓글창 불러오기 -->
				<div class="replyBox">
					<h2>댓글</h2>
					<div id="showReply">
						<%
						if (showReply.size() != 0) {
							for (int i = 0; i <= showReply.size() - 1; i++) {
								ReplyDTO reply = showReply.get(i);
								if(reply.getReplyCondition()==1){
									%>
										<div style="border-top:1px solid grey;margin-bottom:30px;"></div>
									<%
									out.print("삭제된 댓글입니다.");
								} else{
						%>
						<div class = "replyGroup">
							<div class="replyWriter">
								<h4><%out.print(reply.getNickname());%></h4>
							</div>
							<div class="replyContent">
								<p>
									<%
										out.print(reply.getContent());
									%>
								</p>
							</div>
							<%} %>
							<div class="replyTime">
								<%if(reply.getReplyCondition()==1){
									%><div style="margin-bottom:30px; margin-top:30px;"></div><%
								} else{
									
								
									%>
								<p>
									<%
										out.print(reply.getReplyTime());
									%>
								</p>
								<button class="childReply">답글쓰기</button>
								<div class="childReplyBoxWrite" style="display: none">
									<%
										if (regNo != 0) {
									%>
									<span> 
										<%
										 	out.print(loginNickname);
										 %>
									</span>
									<form>
										<input type="text" name="childWriteReply" class="childWriteReply" placeholder="댓글을 입력해 주세요." spellcheck="false" autocomplete="off" /> 
										<input type="hidden" name="upRplNoValue" class="upRplNoValue" value="<%=reply.getRplNo()%>">
										<input type="button" class="childReplyItemsBtn" value="등록" onclick="submitChildReply(event)">
									</form>
									</div>
									<%
										} else {
									%>
									<h5>댓글 작성은 로그인이 필요한 서비스입니다.</h5>
									<%
										}
									%>
								</div>
								<%
									if (reply.getNickname().equals(loginNickname)) {
								%>
								<!-- 본인 댓글일 시 수정 활성화 -->
								<button class="updateReply">댓글 수정</button>
								<div class="updateReplyBoxWrite" style="display: none">
									<span> 
										<%
										 	out.print(loginNickname);
										 %>
									</span><br />
									<form class="updateReplyForm">
										<input type="text" class="updateWriteReply" placeholder="댓글을 입력해 주세요." spellcheck="false" autocomplete="off" />
										<input type="hidden" class="rplNoValue" value="<%= reply.getRplNo() %>">
										<input type="button" class="updateReplyItemsBtn" value="등록" onclick="updateReply(event);">
									</form>
								</div>
								<!-- 본인 댓글일 시 댓글삭제 활성화 -->
								<button name = "deleteReply" class="deleteReply" value="<%=reply.getRplNo()%>" onclick="deleteReply(event);">댓글 삭제</button>
								<%
									}
								}
								%>
						</div>
						<!-- 대댓글   -->
						<%
						ReplyDAO replyDao = ReplyDAO.getInstance();
						ArrayList<ReplyDTO> showChildReply = replyDao.showChildReply(reply.getRplNo());
						for(int j = 0 ; j < showChildReply.size() ; j++){
						ReplyDTO childReply = showChildReply.get(j);
						
						%>
						<div class="showChildReply">
							<div class="replyWriter">
								<p><%=childReply.getNickname()%></p>
							</div>
							<div class="replyContent">
								<p><%=childReply.getContent()%></p>
							</div>
							<div class="replyTime">
								<p><%=childReply.getReplyTime()%></p>
								</div>
								<%
									if (childReply.getNickname().equals(loginNickname)) {
								%>
								<!-- 본인 대댓글일 시 수정 활성화 -->
								<button class="updateReply">댓글 수정</button>
									<div class="updateReplyBoxWrite" style="display: none">
										<span> 
											<%
											 	out.print(loginNickname);
											 %>
										</span><br />
										<form class="updateReplyForm">
										<input type="text" class="updateWriteReply" placeholder="댓글을 입력해 주세요." spellcheck="false" autocomplete="off" />
										<input type="hidden" class="rplNoValue" value="<%= childReply.getRplNo() %>">
										<input type="button" class="updateReplyItemsBtn" value="등록" onclick="updateReply(event);">
										</form>
									</div>
									<!-- 본인 댓글일 시 댓글삭제 활성화 -->
								<button name = "deleteReply" class="deleteReply" value="<%=childReply.getRplNo()%>" onclick="deleteReply(event);">댓글 삭제</button>
								<%
									}
								%>
							</div>
						<%
						}
					}
				}
						
						%>
					</div>
				</div>
				<!-- 댓글 작성 박스 -->
				<div id="replyBoxWrite">
						<%
							if (regNo != 0) {
						%>
						<span><%
							out.print(loginNickname);
						%></span><br/>
						<form action="Community_ShowBoard.jsp" method="post">
							<input type="text"name="writeReply" id="writeReply" placeholder="댓글을 입력해 주세요." spellcheck="false" autocomplete="off"/>
							<input type="button" class="replyItemsBtn" value="등록" onclick="submitReply();">
						</form>
							<%} else { %>
							<h5>댓글 작성은 로그인이 필요한 서비스입니다.</h5>
							<%} %>
					</div>
				</div>
				<div class="bottomSpace"></div>
			</div>
		</div>
</body>
</html>
