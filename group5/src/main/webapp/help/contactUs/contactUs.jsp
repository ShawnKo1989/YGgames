<%@page import="dto.MemberDto"%>
<%@page import="dto.ContactAttachmentDto"%> 
<%@page import="dto.ContactDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int pno = (Integer)request.getAttribute("page");
	ArrayList<ContactDto> cList = (ArrayList<ContactDto>)request.getAttribute("cList");
	int lastPno = (Integer)request.getAttribute("lastPage");
	MemberDto mDto = (MemberDto)session.getAttribute("dto");
	String nickname = mDto.getNickname();
	String email = mDto.getEmail();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>QKYG 지원요청</title>
	<link rel="stylesheet" href="/group5/css/public/common.css" />
	<link rel="stylesheet" href="/group5/css/layout/contactUs.css" />
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<script src="/group5/js/common.js"></script>
	<script src="/group5/js/contactUs.js"></script>
	<script>
		let id = "<%=email %>";
		$(function() {
			$(document).on("click", "#btn_chat", function() {
				alert(`준비중입니다.`);
				return false;
				popUpChat();
			});
		});
	</script>
</head>
<body>
	<header>
		<jsp:include page="/outframe/NavBar2.jsp"></jsp:include>
	</header>
	<main>
		<div class="pageHead">
			<span class="goHelp clickable">메인 페이지</span> <span>&gt;</span> <span>지원 요청</span>
		</div>
		<div class="contactWrap">
			<div class="contentTitle">
				<h1>지원 요청</h1>
				<div class="btnRow">
					<button id="btn_back" class="goHelp clickable height50">
						<span>&lt;</span> <span>뒤로</span>
					</button>
				</div>
			</div>
			<div class="contactMain">
				<input id="tmpDrop" type="file" accept="image/*, video/* " multiple hidden />
				<form class="contactContent" action="/group5/ControllerHelp" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="command" value="contactUs" />
					<input class="name height50" name="name" type="text" value="<%=nickname %>" placeholder="표시명(선택사항)" />
					<input class="email height50" name="email" type="email" value="<%=email %>" required readonly />
					<textarea id="contactDescription" name="description" placeholder="자세한 내용을 적어주세요." required></textarea>
					<div class="dropzone" id="dropzone">
						<label for="tmpDrop" class="attachmentsContent">
							<img src="/group5/media/icon/uploadIcon.svg" />
							<div>
								<span>파일 선택</span>
								<!-- <span>또는 여기에 파일 놓기</span> -->
							</div>
							<p>image or video file only</p>
						</label>
						<input id="attachments" name="attachments" type="file" accept="image/*, video/* " multiple hidden />
					</div>
					<ul id="attachList"></ul>
					<div class="btnWrap">
						<button id="btn_email" class="clickable height50" >
							<span><img src="/group5/media/icon/emailIcon.svg" /></span><span>이메일 문의 제출</span>
						</button>
						<button id="btn_chat" type="button" class="clickable height50">
							<span><img src="/group5/media/icon/chatIcon.svg" /></span><span>실시간 채팅 시작</span>
						</button>
						<input id="btn_quit" type="button" value="취소" class="clickable height50" onclick="return quit();"/>
					</div>
				</form>
				<div class="contactHistory">
					<h2>내 지원 요청</h2>
					<div class="myContactHistories">
						<ul class="historyList">
						<%
							for(ContactDto cDto : cList) {
								//이미지를 포함한 HTML 응답 생성
								response.setContentType("text/html");
						%>
							<il class="myHistory">
								<div class="historyHead">
									<h3>
										<span class="cno" hidden ><%=cDto.getCno()%></span>
										<span class="regdate"><%=cDto.getRegdate().split(" ")[0]%></span>
									</h3>
									<div class="userInfo">
										<span class="regName"><%=cDto.getName()%></span>
										<span class="regEmail"><%=cDto.getEmail()%></span>
									</div>
								</div>
								<p class="regDescription"><%=cDto.getDescription()%></p>
								<div class="historyAttachments">
								<%
									for(ContactAttachmentDto cAtmt : cDto.getAttachments()) {
										String fileType = cAtmt.getType();
										String base64FileUrl = cAtmt.getBase64url();
										String tag = fileType.contains("image/") ? "img" : (fileType.contains("video/") ? "video" : "");
								%>
								<%--	<<%=tag %> class="regAttachment" src="data:<%=fileType %>;base64,<%=base64FileUrl %>" height="150" <%=tag.equals("video") ? "muted autoplay loop controls ></video>" : "/>" %>--%>
								<%
									}
								%>
								</div>
							</il>
						<%
							}
						
						%>
						</ul>
						<%--<%
							if(lastPno>1) {
						%>
							<div class="paginations">
								<<%=pno==1 ? "span":"a" class="pagination" <%=pno==1 ? "":"href=\"?page=1\"" %> >첫 페이지</<%=pno==1?"span":"a" %>>
							<%
								for(int i=pno<4 ? 1 : pno-3; i<=(pno+3<lastPno ? pno+3 : lastPno); i++) {
									String tag = pno==i ? "span": "a";
							%>
								<<%=tag %> class="pagination" <%=tag.equals("a") ? "href=\"?page=" + i + "\"" : ""%>><%=i %></<%=tag %>>
							<%
								}
							%>
								<<%=pno==lastPno ? "span":"a" %> class="pagination" <%=pno==lastPno ? "":"href=\"?page=" + lastPno + "\"" %> >마지막 페이지</<%=pno==lastPno?"span":"a" %>>
						<%
							}
						%>
						</div>--%>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/outframe/BottomFooter.jsp"></jsp:include>
	</footer>
</body>
</html>