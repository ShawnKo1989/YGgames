<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DTO.BoardDTO" %>
<%@ page import="java.util.ArrayList"%>

<%
	int regNo=0;
	if(session.getAttribute("reg_no")!=null){
		regNo=(Integer)session.getAttribute("reg_no");
	}
	
	ArrayList<BoardDTO> boardTitle = (ArrayList<BoardDTO>)request.getAttribute("boardTitle");
	String titleChan = "";
	String content = "";
	int postNo=0;
	if(request.getAttribute("postNo")!=null){
		postNo = (int)request.getAttribute("postNo");
	}
	if(request.getAttribute("title")!=null){
		titleChan = (String)request.getAttribute("title");
	}
	if(request.getAttribute("content")!=null)	{
		content = (String)request.getAttribute("content");
	}
	int updateValue=0;
	if(request.getAttribute("updateValue")!=null){
		updateValue=(int)request.getAttribute("updateValue");
	}
	
%>



<!DOCTYPE html>
<html>
<head>
	<script src="jq/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="SE2/js/HuskyEZCreator.js" charset="UTF-8"></script>
	<meta charset="UTF-8">
	<title>게시판 글쓰기</title>
	<script>	//스마트에디터 불러오기
		let oEditors=[];
		smartEditor = function(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef:oEditors,
				elPlaceHolder:"writeContent",
				sSkinURI:"SE2/SmartEditor2Skin.html",
				fCreator: "createSEditor2"
			});
		};

		$(document).ready(function() {
			smartEditor();
		});
		
		function submitPost(){	//게시글 저장
			oEditors.getById["writeContent"].exec("UPDATE_CONTENTS_FIELD",[])
			let content = document.getElementById("writeContent").value;
			let title = document.getElementById("writeTitle").value;
			let board = document.getElementById("selectBoard").value;
			let reg_no = <%=regNo%>
			if (board==''){
				alert("게시판을 지정해주세요.");
			}
			else if(title==''){
				alert("제목을 입력해주세요.");
				return
			} else if(content=='<p>&nbsp;</p>'){
				alert("내용을 입력해주세요.");
				oEditors.getById["writeContent"].exec("FOCUS");
				return
			} else{
				console.log(board);
				console.log(title);
				console.log(content);
					$.ajax({
					    type: "POST",
					    url: "PostSaveServlet",
					    data: { 
					        board: board,
					        title: title,
					        content: content,
					        reg_no: reg_no
					    },
					    success: function() {
					        alert("등록되었습니다!");
					        location.href = "Controller?command=community";
					    },
					    error: function(request, status, error) {
					        alert("오류가 발생했습니다.");
					        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					    }	
					});

			    }
			}
		
		function updatingPost(){	//게시글 수정 시 재등록
			oEditors.getById["writeContent"].exec("UPDATE_CONTENTS_FIELD",[])
			let content = document.getElementById("writeContent").value;
			let title = document.getElementById("writeTitle").value;
			let board = document.getElementById("selectBoard").value;
			let postNo = <%=postNo%>;
			let reg_no = <%=regNo%>
			if (board==''){		//내용을 입력 안할 시 유효성검사
				alert("게시판을 지정해주세요.");
			}
			else if(title==''){
				alert("제목을 입력해주세요.");
				return
			} else if(content=='<p>&nbsp;</p>'){
				alert("내용을 입력해주세요.");
				oEditors.getById["writeContent"].exec("FOCUS");
				return
			} else{
			    $.ajax({
		            type: "POST",
		            url: "PostUpdateServlet",
		            data: { 
		                board: board,
		                title: title,
		                content: content,
		                reg_no: reg_no,
		                postNo: postNo
		            },
		            success: function() {
		                alert("등록되었습니다!");
		                location.href="Controller?command=community";
		            },
		            error: function(request, status, error) {
		                alert("오류가 발생했습니다!");
		                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		            }	
		        });
			}
		}
	</script>
</head>
<body>
	<jsp:include page="CommunitySideBar.jsp" />
	<div class="right">
		<div class="rightBackImg">
			<div class="postWrite">
				<form action="insertStudentInfoFrom" method="post">
					<div id="postWriteTop">
						<h2 style="color: white;">&emsp;카페 글쓰기</h2>
						<%if(updateValue==0){ %>	<!-- 글 수정 or 새 게시글 작성 구분 -->
						<input type="button" value="등록" id="signUp" onclick="submitPost();"/>
						<%} else{ %>
						<input type="button" value="등록" id="signUp" onclick="updatingPost();"/>
						<%} %>
					</div>
					<div id="selectBox">
						<select id="selectBoard">	<!-- 게시판 선택 -->
							<option value="" selected disabled hidden>게시판을 선택해 주세요.</option>
							<%
								for (int q = 0; q <= boardTitle.size() - 1; q++) {
									BoardDTO board = boardTitle.get(q);
								%>
								<option value="<%out.print(board.getBoardTitle());%>">
									<%
										out.print(board.getBoardTitle());
									%>
								</option>
							<%
								}
							%>
						</select>
					</div>
					<div>	<!-- 제목 작성 -->
						<input type="text" id="writeTitle" placeholder="제목을 입력해 주세요." spellcheck="false" autocomplete="off"<%if(titleChan!=null){ out.print("value="+'"'+titleChan+'"');}%>>
					</div>	<!-- 스마트에디터 사용 게시글 작성 -->
					<div id="smarteditor">
						<textarea id="writeContent" name="writeContent" placeholder="내용을 입력해 주세요." rows="20" cols="10"><%if(content!=null){out.print(content);} %></textarea>
					</div>
				</form>
			</div>
			<div class="bottomSpace"></div>
		</div>
	</div>
</body>
</html>
