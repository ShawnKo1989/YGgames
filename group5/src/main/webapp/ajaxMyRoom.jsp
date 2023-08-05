<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="jdbc.User" %>
<%
User user = new User();
try{
	request.setCharacterEncoding("utf-8");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","temp","1234");
	String sql = "";
	if(request.getParameter("rno")==null) {
		sql = "SELECT * FROM member m, my_room r WHERE m.reg_no=r.reg_no AND r.reg_no=" + session.getAttribute("reg_no");
	} else {
		sql = "SELECT * FROM member m, my_room r WHERE m.reg_no=r.reg_no AND r.reg_no=" + request.getParameter("rno");
	}
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	while(rs.next()) {
		user.setReg_no(rs.getString("reg_no"));
		user.setNickname(rs.getString("nickname"));
		user.setExp(rs.getInt("user_exp"));
		user.setNow_style(rs.getString("now_style"));
	}
	rs.close();
	stmt.close();
	conn.close();
} catch(Exception e) {
	e.printStackTrace();
}
%>
<style>
	body {
		margin: 0px;
	}
	.profile-container {
	    background-image: url(Images/profilebg.png);
    	background-color: #0b0d11;
    	position: relative;
    	display: block;
    	color: white;
    	padding: 50px;
    	height: 36%;
	}
	.profile-bg {
		background-image: url(https://dev.epicgames.com/community/assets/images/bg-profile.svg); */
	    width: -webkit-fill-available;
	    padding: 5px;
	    border-radius: 10px;
	    background: #2a2a2a;
	}
	.page-profile-header {
		display: flex;
		gap: 2rem;
		align-items: center;
		padding-top: 0px;
		padding-bottom: 10px;
		z-index: 1;
		position: relative;
	}
	.header-center {
	    display: flex;
	    flex-direction: column;
	    flex-basis: 100%;
	    line-height: initial;
	}
	.header-h1 {
		font-size: 2.25rem;
        margin: 0px;
    	margin-bottom: 10px;
    	margin-top: 10px;
    	width: max-content;
	}
	.num {
	    font-weight: 700;
	    padding-right: 0.25rem;
	    margin-bottom: 0;
	}
	.text {
		font-weight: 700;
		padding-right: 15px;
		margin-right: 15px;
		position: relative;
		width: max-content;
	}
	.text:not(:last-child):after {
		content: "";
	    display: block;
	    width: 1.25px;
    	height: 12px;
	    background: #A0A4B4;
	    position: absolute;
	    top: 50%;
	    right: 0;
	    transform: translateY(-45%);
	}
	.profile-edit {
		cursor: pointer;
		align-self: flex-start;
	    flex-shrink: 0;
	    display: flex;
	}
	.btn {
		--bs-btn-padding-x: .75rem;
		--bs-btn-padding-y: .4375rem;
		--bs-btn-font-family: var(--bs-font-sans-serif);
		--bs-btn-font-size: .75rem;
		--bs-btn-font-weight: 500;
		--bs-btn-line-height: 1.6;
		--bs-btn-color: #A0A4B4;
		--bs-btn-bg: transparent;
		--bs-btn-border-width: 1px;
		--bs-btn-border-color: transparent;
		--bs-btn-border-radius: .5rem;
		--bs-btn-hover-border-color: transparent;
		--bs-btn-box-shadow: inset 0 1px 0 rgba(255, 255, 255, .15), 0 1px 1px rgba(0, 0, 0, .075);
		--bs-btn-disabled-opacity: .65;
		--bs-btn-focus-box-shadow: 0 0 0 .25rem rgba(var(--bs-btn-focus-shadow-rgb), .5);
		padding: var(--bs-btn-padding-y) var(--bs-btn-padding-x);
		font-family: var(--bs-btn-font-family);
		font-size: var(--bs-btn-font-size);
		font-weight: var(--bs-btn-font-weight);
		line-height: var(--bs-btn-line-height);
		color: var(--bs-btn-color);
		text-align: center;
		text-decoration: none;
		vertical-align: middle;
		cursor: pointer;
		-webkit-user-select: none;
		user-select: none;
		border: var(--bs-btn-border-width) solid var(--bs-btn-border-color);
		border-radius: var(--bs-btn-border-radius);
		background-color: var(--bs-btn-bg);
		transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
	}
	.btn-primary {
	    --bs-btn-color: #000;
	    --bs-btn-bg: #E4E7EC;
	    --bs-btn-border-color: #E4E7EC;
	    --bs-btn-hover-color: #000;
	    --bs-btn-hover-bg: #e8ebef;
	    --bs-btn-hover-border-color: #e7e9ee;
	    --bs-btn-focus-shadow-rgb: 194, 196, 201;
	    --bs-btn-active-color: #000;
	    --bs-btn-active-bg: #e9ecf0;
	    --bs-btn-active-border-color: #e7e9ee;
	    --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
	    --bs-btn-disabled-color: #000;
	    --bs-btn-disabled-bg: #E4E7EC;
	    --bs-btn-disabled-border-color: #E4E7EC;
	}
	.my-edit {
		content: url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8' standalone='no'%3F%3E%3C!-- Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools --%3E%3Csvg width='17px' height='17px' viewBox='0 0 18 18' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns:sketch='http://www.bohemiancoding.com/sketch/ns'%3E%3Ctitle%3Eicon/18/icon-edit%3C/title%3E%3Cdesc%3ECreated with Sketch.%3C/desc%3E%3Cdefs%3E%3C/defs%3E%3Cg id='out' stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' sketch:type='MSPage'%3E%3Cpath d='M2.25,12.9378906 L2.25,15.75 L5.06210943,15.75 L13.3559575,7.45615192 L10.5438481,4.64404249 L2.25,12.9378906 L2.25,12.9378906 L2.25,12.9378906 Z M15.5306555,5.28145396 C15.8231148,4.98899458 15.8231148,4.5165602 15.5306555,4.22410082 L13.7758992,2.46934454 C13.4834398,2.17688515 13.0110054,2.17688515 12.718546,2.46934454 L11.3462366,3.84165394 L14.1583461,6.65376337 L15.5306555,5.28145396 L15.5306555,5.28145396 L15.5306555,5.28145396 Z' id='path' fill='%23000000' sketch:type='MSShapeGroup'%3E%3C/path%3E%3C/g%3E%3C/svg%3E");
		padding-right: 0.5rem;
	}
	.page-profile-section {
	    background: #0C0D16;
	    padding: 0.875rem 2.5rem 0;
	    border-radius: 0.375rem;
	    color: #A0A4B4;
	}
	.profile-section-nav {
		display: flex;
	    gap: 0.25rem 1.875rem;
	    font-size: .8125rem;
	    font-weight: 600;
	}
	.section-nav-item {
	    font-size: 1rem;
	    font-weight: 600;
	    text-transform: none;
	    letter-spacing: 0;
	    display: inline-block;
        background: transparent;
        border-radius: 0;
	    padding: 0.25rem 0 1rem;
	    border: 0;
	    border-bottom: 0.125rem solid transparent;
        min-height: 1.5rem;
        cursor: pointer;
	}
	.section-nav-item:hover {
	    color: #FFFFFF;
	}
	.header-center-level {
	    display: flex;
	    flex-direction: column;
	    top: -15px;
	    position: relative;
	}
	.user-level {
		font-size: 12px;
		width: max-content;
	}
	.header-center-title {
	    display: flex;
	    flex-direction: column;
	    flex-basis: 564%;
	    top: -15px;
	    position: relative;
	}
	.exp-bar {
		border: 1px solid #ccc;
		background: #e9e9e9;
		height: 20px;
		border-radius: 10px;
		margin-bottom: 20px;
	}
	.exp {
		display: block;
		border: 1px solid #ABF200;
		background: #1DDB16;
		height: 19px;
		margin: 0px;
		border-radius: 10px;
		width: <%=user.getExp()%100%>%;
	}
	.exp-info {
	    float: right;
	    top: -30px;
	    position: relative;
	    font-size: 20px;
	}
	#friends:active {
		color: grey;
	}
	.page-profile-main {
   		margin-top: 2.75rem;
	}
</style>
<div class="profile-container">
	<div class="page-profile-header">
		<div class="header-image">
			<div class="header-image-wrap">
				<img src="https://dev.epicgames.com/community/assets/images/default-user.svg" width="152" height="152" style="border-radius: 50%;">
			</div>
		</div>
		<div id="my-room-rno" style="display: none;"><%=user.getReg_no() %></div>
		<div class="header-center">
			<h1 class="header-h1"><%=user.getNickname()%></h1>
			<div style="display: flex; font-size: 12px;">
				<div class="num">0</div>
				<div class="text">게시물</div>
				<div class="num">0</div>
				<div class="text">답변</div>
			</div>
		</div>
		<div class="header-center-level">
			<div class="user-level">레벨</div>
			<h1 class="header-h1"><%=user.getExp()/100%></h1>
		</div>
		<div class="header-center-title">
			<div class="user-level">별명</div>
			<h1 class="header-h1" id="header-h1">
			<%if(user.getNow_style()!=null) {
				%><%=user.getNow_style()%><%
			} else {
				%>
				별명이 없습니다.
				<%
			}
			%>
			</h1>
		</div>
		<div class="profile-edit">
			<div role="button" id="profile-edit" class="profile-edit btn btn-primary">
				<i class="my-edit"></i>
				프로필 설정
			</div>
			<script>
				var profileEdit = document.getElementById("profile-edit");
				
				profileEdit.onclick = function() {
					alert("프로필 설정");
				};
			</script>
		</div>
	</div>
	<div class="exp-info"><%=user.getExp()%100%> / 100 XP</div>
	<div class="exp-bar">
		<span class="exp"></span>
	</div>
	<div class="profile-bg">
		<div class="page-profile-section">
			<div role="navigation" class="profile-section-nav">
				<div role="button" id="mytitle" class="section-nav-item" style="color: #FFFFFF;">별명</div>
				<div role="button" id="community" class="section-nav-item">활동내역</div>
				<div role="button" id="reward" class="section-nav-item">업적</div>
				<div role="button" id="friends" class="section-nav-item" style="display: 
				<%if(request.getParameter("rno")==null || Integer.parseInt(request.getParameter("rno"))==(int)session.getAttribute("reg_no")) {
					%>inline-block<%
				} else {
					%>none<%
				}%>;">친구</div>
			</div>
		</div>
	</div>
	<div id="friend">
		<jsp:include page="Friends.jsp" />
	</div>
	<div class="page-profile-main" id="profile-main">
		<jsp:include page="MyTitle.jsp" />
	</div>
	<script defer src="js/ProfileSectionMove.js"></script>
	<script defer src="js/UpdateTitle.js"></script>
	<script defer src="js/FriendsRefresh.js"></script>
	<script>
		var myTitle = document.getElementById("mytitle");
		var community = document.getElementById("community");
		var reward = document.getElementById("reward");
		var friends = document.getElementById("friends");
		
		myTitle.onclick = function() {
			myTitle.style.color = "#FFFFFF";
			community.style.color = "#A0A4B4";
			reward.style.color = "#A0A4B4";
			friends.style.color = "#A0A4B4";
		};
		community.onclick = function() {
			myTitle.style.color = "#A0A4B4";
			community.style.color = "#FFFFFF";
			reward.style.color = "#A0A4B4";
			friends.style.color = "#A0A4B4";
		};
		reward.onclick = function() {
			myTitle.style.color = "#A0A4B4";
			community.style.color = "#A0A4B4";
			reward.style.color = "#FFFFFF";
			friends.style.color = "#A0A4B4";
		};
	</script>
</div>