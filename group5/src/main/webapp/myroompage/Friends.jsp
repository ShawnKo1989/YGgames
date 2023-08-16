<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="jdbc.Friend"%>
<%@page import="java.util.ArrayList"%>
<%
	ArrayList<Friend> f1 = new ArrayList<Friend>();
	ArrayList<Friend> f2 = new ArrayList<Friend>();
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@210.114.1.134:1521:xe","temp","1234");
		Statement stmt1, stmt2;
		stmt1 = conn.createStatement();
		stmt2 = conn.createStatement();
		String sql1 = "SELECT m.nickname, m.name, m.connecting, m.reg_no " +
					 "FROM friends f, member m " +
					 "WHERE f.are_we_friend=1 AND f.from_reg_no="+session.getAttribute("reg_no")+" AND f.to_reg_no=m.reg_no AND m.valid=0 " +
					 "ORDER BY m.connecting DESC";
		String sql2 = "SELECT distinct m.reg_no, m.nickname,"
				   + " 	   CASE WHEN f.are_we_friend = 1 AND m.connecting = 1 THEN '1'"
		           + " 			WHEN f.are_we_friend = 1 AND m.connecting = 0 THEN '0'"
		           + " 			WHEN m.reg_no = "+session.getAttribute("reg_no")+" AND m.connecting = 1 THEN '1'"
		           + " 			WHEN m.reg_no = "+session.getAttribute("reg_no")+" AND m.connecting = 0 THEN '0'"
		           + " 			ELSE NULL"
		           + "		    END AS connecting,"
				   + "     CASE WHEN m.reg_no = "+session.getAttribute("reg_no")+" THEN '2'"
				   + "          WHEN f.are_we_friend = 1 THEN '1'"
				   + "          WHEN f.are_we_friend = 0 AND f.to_reg_no = "+session.getAttribute("reg_no")+" THEN '4'"
				   + "          WHEN f.are_we_friend = 0 AND f.from_reg_no = "+session.getAttribute("reg_no")+" THEN '3'"
				   + "     		ELSE '0'"
				   + " 	   		END AS relationship"
				   + " FROM member m"
				   + " LEFT JOIN friends f ON (m.reg_no = f.from_reg_no AND f.to_reg_no = "+session.getAttribute("reg_no")+") OR (m.reg_no = f.to_reg_no AND f.from_reg_no = "+session.getAttribute("reg_no")+")"
				   + " WHERE m.valid = 0"
				   + " ORDER BY relationship DESC";
		ResultSet rs1, rs2;
		rs1 = stmt1.executeQuery(sql1);
		rs2 = stmt2.executeQuery(sql2);
		while(rs1.next()) {
			Friend e = new Friend(rs1.getString("nickname"),rs1.getString("name"),rs1.getInt("connecting"));
			e.setReg_no(rs1.getInt("reg_no"));
			f1.add(e);
			f1.size();
		}
		while(rs2.next()) {
			Friend e = new Friend(rs2.getInt("reg_no"),rs2.getString("nickname"),rs2.getInt("connecting"),rs2.getInt("relationship"));
			f2.add(e);
		}
		rs1.close();
		rs2.close();
		stmt1.close();
		stmt2.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<html>
	<head>
		<script>
			$(function() {
				$(document).on("click", ".friend-accept", function() {
					var element = $(this);
					var regNo = $(this).closest(".friend-list").find(".reg_no").text();
					var param = { reg_no: regNo };
	
					$.ajax({
						url: "FriendAccept.jsp",
						data: param,
						success: function(data) {
							element.hide();
							element.parent().find(".friend-decline").hide();
							element.parent().find(".message").html("친구 요청이 수락되었습니다.").removeClass("hidden");
						},
						error: function(e) {
							alert("서버 오류: " + e.status);
						},
					});
					return false;
				});
	
				$(document).on("click", ".friend-decline", function() {
					var element = $(this);
					var regNo = $(this).closest(".friend-list").find(".reg_no").text();
					var param = { reg_no: regNo };
	
					$.ajax({
						url: "FriendDecline.jsp",
						data: param,
						success: function(data) {
							element.hide();
							element.parent().find(".friend-accept").hide();
							element.parent().find(".message").html("친구 요청이 거절되었습니다.").removeClass("hidden");
						},
						error: function(e) {
							alert("서버 오류: " + e.status);
						},
					});
	
					return false;
				});
			});
	    </script>
		<meta charset="UTF-8">
		<style>
			.friends-popup-layer {
			    position: fixed;
			    top: 10%;
		    	left: 60%;
			    z-index: 10000;
			    background-color: #141414;
			    width: 380px;
			    height: 550px;
			    display: none;
		        border: 2px solid #5a5a5a;
    			border-radius: 5px;
			}
			.show {
				display: block;
			}
			.popup-nav-section {
				margin-top: 5px;
				display: flex;
				justify-content: center;
			}
			.popup-nav-box {
				background-color: #262626;
				width: 240px;
				height: 50px;
			    border-radius: 26px;
			}
			.drag-section {
				cursor: move;
				width: auto;
				height: 20px;
				background-color: #5a5a5a;
			}
			.popup-nav-box-in {
			    margin: 5px;
			    width: auto;
			    height: 40px;
			    border-radius: 25px;
			    display: flex;
			}
			.popup-nav-button {
				width: 76px;
				height: 100%;
				border-radius: 25px;
				display: flex;
    			justify-content: center;
    			cursor: pointer;
			}
			.popup-nav-button:not(:last-child) {
				margin-right: 1px;
			}
			.popup-nav-button:hover {
				background-color: #494949;
			}
			.nav-btn-section {
				width: 40px;
				height: 40px;
			}
			.nav-btn-section3 {
				margin-top: 5px;
				width: 30px;
				height: 30px;
			}
			.refresh-box {
			    position: absolute;
			    width: 35px;
			    height: 35px;
			    left: 87%;
			    top: 6%;
			    cursor: pointer;
			}
			#friends-refresh {
			    width: 100%;
			    height: 100%;
			    position: relative;
			    content: url(Images/loading.png);
			    border-radius: 20px;
			    cursor: pointer;
			}
			.refresh-box:hover #friends-refresh {
				content: url(Images/loading.gif);
			}
			#friend-list {
			    width: 100%;
    			height: 100%;
				-webkit-mask: url("data:image/svg+xml,%3Csvg fill='none' height='40' viewBox='0 0 48 48' width='40' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23333'%3E%3Cpath d='m17 24c3.8675 0 7-3.1325 7-7s-3.1325-7-7-7-7 3.1325-7 7 3.1325 7 7 7z'/%3E%3Cpath d='m39 20.5c0 3.0387-2.4613 5.5-5.5 5.5s-5.5-2.4613-5.5-5.5c0-3.0388 2.4613-5.5 5.5-5.5s5.5 2.4612 5.5 5.5z'/%3E%3Cpath d='m17 26c2.7336 0 7.183.8511 10.1011 2.5452 1.1919 1.2133 1.8989 2.5362 1.8989 3.8548v5.6h-25v-5.6c0-4.256 8.6612-6.4 13-6.4z'/%3E%3Cpath d='m44 38h-13v-5.6c0-1.4163-.5114-2.7199-1.3236-3.8834 1.5409-.3441 3.0579-.5166 4.2163-.5166 3.7284 0 10.1073 1.7867 10.1073 5.3333z'/%3E%3C/g%3E%3C/svg%3E");
				-webkit-mask-repeat: no-repeat;
				-webkit-mask-position: center;
				-webkit-mask-size: cover;
				background-color: #FFFFFF;
			}
			.add-friend {
				width: 100%;
				height: 100%;
				-webkit-mask: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='40' height='40' viewBox='0 0 24 24'%3E%3Cpath d='M15 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm-9-2V7H4v3H1v2h3v3h2v-3h3v-2H6zm9 4c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z'/%3E%3C/svg%3E");
				-webkit-mask-repeat: no-repeat;
				-webkit-mask-position: center;
				background-color: #FFFFFF;
				-webkit-mask-size: cover;
			}
			#friend-setting {
				width: 100%;
				height: 100%;
				-webkit-mask-repeat: no-repeat;
				-webkit-mask-size: cover;
				-webkit-mask-position: center;
				background-color: #FFFFFF;
				-webkit-mask: url("data:image/svg+xml,%3Csvg viewBox='0 0 512 512' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='m487.4 315.7-42.6-24.6c4.3-23.2 4.3-47 0-70.2l42.6-24.6c4.9-2.8 7.1-8.6 5.5-14-11.1-35.6-30-67.8-54.7-94.6-3.8-4.1-10-5.1-14.8-2.3l-42.6 24.6c-17.9-15.4-38.5-27.3-60.8-35.1v-49.1c0-5.6-3.9-10.5-9.4-11.7-36.7-8.2-74.3-7.8-109.2 0-5.5 1.2-9.4 6.1-9.4 11.7v49.2c-22.2 7.9-42.8 19.8-60.8 35.1l-42.5-24.6c-4.9-2.8-11-1.9-14.8 2.3-24.7 26.7-43.6 58.9-54.7 94.6-1.7 5.4.6 11.2 5.5 14l42.6 24.6c-4.3 23.2-4.3 47 0 70.2l-42.6 24.6c-4.9 2.8-7.1 8.6-5.5 14 11.1 35.6 30 67.8 54.7 94.6 3.8 4.1 10 5.1 14.8 2.3l42.6-24.6c17.9 15.4 38.5 27.3 60.8 35.1v49.2c0 5.6 3.9 10.5 9.4 11.7 36.7 8.2 74.3 7.8 109.2 0 5.5-1.2 9.4-6.1 9.4-11.7v-49.2c22.2-7.9 42.8-19.8 60.8-35.1l42.6 24.6c4.9 2.8 11 1.9 14.8-2.3 24.7-26.7 43.6-58.9 54.7-94.6 1.5-5.5-.7-11.3-5.6-14.1zm-231.4 20.3c-44.1 0-80-35.9-80-80s35.9-80 80-80 80 35.9 80 80-35.9 80-80 80z'/%3E%3C/svg%3E");
			}
			.friends-popup-main {
				padding: 10px 20px;
				position: absolute;
			    width: 100%;
			    height: 86%;
			}
			.popup-main-header {
		    	font-size: 20px;
    			font-weight: bold;
			}
			.friends-popup-search {
				margin-top: 15px;
			    color: white;
			    border: 1px solid #5a5a5a;
			    background: transparent;
			    border-radius: 5px;
			    height: 40px;
			    width: 100%;
			    padding: 10px;
			    font-size: 15px;
			    padding-left: 30px;
    			padding-right: 33px;
			}
			.friend-search {
			    margin-bottom: 5px;
			}
			.friend-search-icon {
			    -webkit-mask: url("data:image/svg+xml,%3Csvg height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='m0 0h24v24h-24z' fill='none'/%3E%3Cpath d='m15.5 14h-.79l-.28-.27c1.2-1.4 1.82-3.31 1.48-5.34-.47-2.78-2.79-5-5.59-5.34-4.23-.52-7.79 3.04-7.27 7.27.34 2.8 2.56 5.12 5.34 5.59 2.03.34 3.94-.28 5.34-1.48l.27.28v.79l4.25 4.25c.41.41 1.08.41 1.49 0s.41-1.08 0-1.49zm-6 0c-2.49 0-4.5-2.01-4.5-4.5s2.01-4.5 4.5-4.5 4.5 2.01 4.5 4.5-2.01 4.5-4.5 4.5z'/%3E%3C/svg%3E");
			    width: 24px;
			    height: 24px;
			    position: absolute;
			    top: 53px;
			    left: 25px;
			    background: #5a5a5a;
			}
			.friend-list-box {
				position: absolute;
			    width: 89%;
			}
			.friend-text {
				margin-top: 5px;
				font-size: 12px;
				color: #A0A0A0;
			}
			.friend-list-section {
				display: flex;
			}
			.friend-list {
				padding: 13px 15px;
			    border-radius: 5px;
			    display: flex;
			    align-items: flex-end;
			    height: 50px;
			}
			.friend-list:hover {
				background-color: #494949;
			}
			.friend-dot-box {
			    width: 7px;
			    height: 7px;
		        left: -0.5%;
    			position: relative;
			}
			.online-dot {
				-webkit-mask-image: url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3C!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'%3E%3Csvg xmlns='http://www.w3.org/2000/svg' version='1.1' width='136px' height='136px' style='shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Cg%3E%3Cpath style='opacity:0.983' fill='%23000000' d='M 57.5,0.5 C 88.8739,-1.73361 112.374,10.5997 128,37.5C 141.572,72.3933 133.739,101.227 104.5,124C 75.2119,139.954 47.5452,137.621 21.5,117C 0.946367,95.5714 -4.55363,70.738 5,42.5C 15.2884,19.3682 32.7884,5.36817 57.5,0.5 Z'/%3E%3C/g%3E%3C/svg%3E%0A");
			    background: green;
			    -webkit-mask-size: cover;
			    width: 100%;
			    height: 100%;
			}
			.off {
				background: gray;
			}
			.none {
				background: transparent;
			}
			.relationship {
			    position: relative;
    			left: 5%;
   			    background: #262626;
			    border-radius: 5px;
			    padding: 0px 5px;
		        height: 24px;
			}
			.accept-section {
				display: flex;
			}
			.friend-accept {
				position: relative;
			    left: 5%;
			    background: #262626;
			    border-radius: 5px;
			    padding: 0px 5px;
			    cursor: pointer;
			}
			.friend-accept:hover {
				background: green;
			}
			.friend-decline {
				position: relative;
			    left: 15%;
			    background: #262626;
			    border-radius: 5px;
			    padding: 0px 5px;
			    cursor: pointer;
			}
			.friend-decline:hover {
				background: red;
			}
			.hidden {
				display: none;
			}
			.add-friend-box {
				width: 24px;
				height: 24px;
			    padding: 2px;
			    background: #262626;
			    border-radius: 5px;
			    background: #CCCCCC;	
			}
			.add-friend-box:hover {
				background: #FFFFFF;
			}
			.add-friend-box:active {
				background: #262626;
			}
			.add-friend-section:active {
				background: #FFFFFF;
			}
			.add-friend-section {
				cursor: pointer;
			}
			.friend-dot-section {
			    height: -webkit-fill-available;
			    align-items: flex-end;
			    display: flex;
			}
			.nickname {
			    height: 24px;
			    display: flex;
			    align-items: center;
			}
			.friend-list p {
			    margin: 0px;
			    height: 24px;
			    display: flex;
			    align-content: center;
			    flex-wrap: wrap;
			}
			.add-friend-section:hover {
				border: 1px solid #FFFFFF;
				border-radius: 3px;
			}
			.add-friend-section:hover .add-friend-box {
				width: 23px;
				height: 23px;
				padding: 1px;
			}
			.reset-button-box {
				position: absolute;
			    width: 20px;
			    height: 20px;
			    top: 55px;
			    right: 30px;
			}
			.reset-button {
				-webkit-mask: url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='utf-8'%3F%3E%3C!-- Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools --%3E%3Csvg width='800px' height='800px' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M6.30958 3.54424C7.06741 2.56989 8.23263 2 9.46699 2H20.9997C21.8359 2 22.6103 2.37473 23.1614 2.99465C23.709 3.61073 23.9997 4.42358 23.9997 5.25V18.75C23.9997 19.5764 23.709 20.3893 23.1614 21.0054C22.6103 21.6253 21.8359 22 20.9997 22H9.46699C8.23263 22 7.06741 21.4301 6.30958 20.4558L0.687897 13.2279C0.126171 12.5057 0.126169 11.4943 0.687897 10.7721L6.30958 3.54424ZM10.2498 7.04289C10.6403 6.65237 11.2734 6.65237 11.664 7.04289L14.4924 9.87132L17.3208 7.04289C17.7113 6.65237 18.3445 6.65237 18.735 7.04289L19.4421 7.75C19.8327 8.14052 19.8327 8.77369 19.4421 9.16421L16.6137 11.9926L19.4421 14.8211C19.8327 15.2116 19.8327 15.8448 19.4421 16.2353L18.735 16.9424C18.3445 17.3329 17.7113 17.3329 17.3208 16.9424L14.4924 14.114L11.664 16.9424C11.2734 17.3329 10.6403 17.3329 10.2498 16.9424L9.54265 16.2353C9.15212 15.8448 9.15212 15.2116 9.54265 14.8211L12.3711 11.9926L9.54265 9.16421C9.15212 8.77369 9.15212 8.14052 9.54265 7.75L10.2498 7.04289Z' fill='%23000000'/%3E%3C/svg%3E");
				-webkit-mask-repeat: no-repeat;
				-webkit-mask-position: center;
				-webkit-mask-size: cover;
			    width: 100%;
    			height: 100%;
			}
		</style>
	</head>
	<body>
		<div class="friends-popup-layer ui-draggable" id="friends-popup">
			<div class="drag-section"></div>
			<div class="popup-nav-section">
				<div class="popup-nav-box">
					<div class="popup-nav-box-in">
						<div role="button" class="popup-nav-button" id="friend-list-btn">
							<div class="nav-btn-section">
								<div id="friend-list"></div>
							</div>
						</div>
						<div role="button" class="popup-nav-button" id="add-friend-btn">
							<div class="nav-btn-section">
								<div class="add-friend"></div>
							</div>
						</div>
						<div role="button" class="popup-nav-button" id="friend-setting-btn">
							<div class="nav-btn-section3">
								<div id="friend-setting"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="refresh-box">
					<div role="button" id="friends-refresh">새로고침</div>
				</div>
			</div>
			<div class="friends-popup-main" id="list" style="display: block; overflow: auto;">
			    <div class="popup-main-header">친구</div>
			    <div class="friend-search">
			        <div class="friend-search-icon"></div>
			        <form>
			            <input class="friends-popup-search" id="myfriend-search" placeholder="친구를 검색하세요..." spellcheck="false" onkeyup="filter1()">
			            <div class="reset-button-box">
			                <button type="reset" class="reset-button" onclick="resetFilter()"></button>
			            </div>
			        </form>
			    </div>
			    <div class="friend-list-box" id="all-my-friends">
			        <div class="friend-online">
			            <div class="friend-text">온라인</div>
			            <% for(int i=0; i<f1.size(); i++) {
			                if(f1.get(i).getConnecting()==1) { %>
			                    <div class="friend-list" id="friend-list-<%=f1.get(i).getReg_no() %>" role="button" onclick="registerFriendListClickEvent(<%=f1.get(i).getReg_no() %>);">
			                        <%=f1.get(i).getNickname()%>
			                        <div class="friend-dot-section">
			                            <div class="friend-dot-box">
			                                <div class="online-dot"></div>
			                            </div>
			                        </div>
			                    </div>
			            <%  }
			            } %>
			        </div>
			        <div class="friend-offline">
			            <div class="friend-text">오프라인</div>
			            <% for(int i=0; i<f1.size(); i++) {
			                if(f1.get(i).getConnecting()==0) { %>
	                    <div class="friend-list" role="button" id="friend-list-<%=f1.get(i).getReg_no() %>" onclick="registerFriendListClickEvent(<%=f1.get(i).getReg_no() %>);">
	                        <%=f1.get(i).getNickname()%>
	                        <div class="friend-dot-section">
	                            <div class="friend-dot-box">
	                                <div class="online-dot off"></div>
	                            </div>
	                        </div>
	                    </div>
			            <%  }
			            } %>
			        </div>
			    </div>
			    <script type="text/javascript">
			        function filter1() {
			            var input, filter, friendList, friendItems, i, txtValue;
			            input = document.getElementById("myfriend-search");
			            filter = input.value.toUpperCase();
			            friendList = document.getElementById("all-my-friends");
			            friendItems = friendList.getElementsByClassName("friend-list");
			
			            for (i = 0; i < friendItems.length; i++) {
			                txtValue = friendItems[i].innerText;
			                if (filter === null) {
			                    friendItems[i].style.display = "";
			                } else if (txtValue.toUpperCase().indexOf(filter) > -1) {
			                    friendItems[i].style.display = "";
			                } else {
			                    friendItems[i].style.display = "none";
			                }
			            }
			        }
			
			        function resetFilter() {
			            var input = document.getElementById("myfriend-search");
			            input.value = ""; // 필터 입력값을 비움
			            filter1(); // 필터링 함수 호출하여 모든 친구 항목을 표시
			        }
			
			        function registerFriendListClickEvent(regNo) {
			            var friendList = document.getElementById("friend-list-" + regNo);
			            if (friendList) {
			                friendList.addEventListener("click", function() {
			                    if (friendList.classList.contains("processed")) {
			                    	friendList.classList.remove("processed");
			                        return false;
			                    }
			                    friendList.classList.add("processed");
			
			                    $.ajax({
			                        url: "ajaxMyRoom.jsp",
			                        type: "POST",
			                        data: { rno: regNo },
			                        success: function(data) {
			                            $("#body").val("");
			                            $("#body").html(data);
			                        },
			                        error: function(e) {
			                            alert("서버 오류: " + e.status);
			                        }
			                    });
			                    return false;
			                });
			            }
			        }
			    </script>
			</div>
			<div class="friends-popup-main" id="add" style="display: none; overflow: auto;">
				<div class="popup-main-header">친구추가</div>
				<div class="friend-search">
					<div class="friend-search-icon"></div>
					<form>
						<input id="add-friend-search" class="friends-popup-search" placeholder="유저 검색..." spellcheck="false" onkeyup="filter2()">
						<div class="reset-button-box">
							<button type="reset" class="reset-button" onclick="resetFilter2()"></button>
						</div>
					</form>
				</div>
				<div class="friend-list-box" id="add-to-friends">
					<%
					for (int i = 0; i < f2.size(); i++) {
					%>
					    <div class="friend-list" role="button" id="friend-list2-<%=f2.get(i).getReg_no() %>" onclick="registerFriendAddListClickEvent(<%=f2.get(i).getReg_no()%>)">
					        <div class="reg_no" style="display: none;"><%=f2.get(i).getReg_no()%></div>
					        <div class="nickname"><%=f2.get(i).getNickname()%></div>
					        <div class="friend-dot-section">
					            <div class="friend-dot-box">
					                <div class="online-dot
					                    <% if (f2.get(i).getRelationship() != 1 && f2.get(i).getRelationship() != 2) { %>
					                        none
					                    <% } else if ((f2.get(i).getRelationship() == 1 || f2.get(i).getRelationship() == 2) && f2.get(i).getConnecting() == 0) { %>
					                        off
					                    <% } %>
					                "></div>
					            </div>
					        </div>
					        <% if (f2.get(i).getRelationship() == 2 || f2.get(i).getRelationship() == 1) {
					            if (f2.get(i).getRelationship() == 2) { %>
					                <div class="relationship">나</div>
					            <% } else { %>
					                <div class="relationship">친구</div>
					            <% }
					        } else if (f2.get(i).getRelationship() == 4) { %>
					            <div class="accept-section">
					                <div role="button" class="friend-accept">수락</div>
					                <div role="button" class="friend-decline">거절</div>
					                <p class="message hidden"></p>
					            </div>
					        <% } else if (f2.get(i).getRelationship() == 3) { %>
					            <div class="relationship">수락 대기 중</div>
					        <% } else if (f2.get(i).getRelationship() == 0) { %>
					        	<div class="add-friend-section">
						            <div role="button" class="add-friend-box add-friend" id="add-friend-box-<%= i %>" data-reg-no="<%= f2.get(i).getReg_no() %>">
						                <div id="add-friend"></div>
						            </div>
					            </div>
					            <script>
					                $(function() {
					                    $("#add-friend-box-<%= i %>").click(function() {
					                        var reg_no = <%= f2.get(i).getReg_no() %>;
					                        var $addFriendBox = $(this);
					                        var $addMessage = $addFriendBox.siblings(".addmessage");
					                        if ($addFriendBox.hasClass("processed")) {
					                        	$addFriendBox.removeClass("processed");
					                            return false;
					                        }
					                        $addFriendBox.addClass("processed");
					                        $.ajax({
					                            url: "AddFriendRequest.jsp",
					                            type: "POST",
					                            data: { reg_no: reg_no },
					                            success: function(data) {
					                                $addFriendBox.hide();
					                                $addMessage.html("친구 요청을 보냈습니다.");
					                                $addMessage.removeClass("hidden");
					                            },
					                            error: function(e) {
					                                alert("서버 오류: " + e.status);
					                            }
					                        });
					                        return false;
					                    });
					                });
					            </script>
					            <p class="addmessage hidden"></p>
					        <% } %>
					    </div>
						<script>
							function registerFriendAddListClickEvent(regNo) {
					            var friendList = document.getElementById("friend-list2-" + regNo);
					            if (friendList) {
					                friendList.addEventListener("click", function() {
					                    if (friendList.classList.contains("processed")) {
					                    	friendList.classList.remove("processed");
					                        return false;
					                    }
					                    friendList.classList.add("processed");
					
					                    $.ajax({
					                        url: "ajaxMyRoom.jsp",
					                        type: "POST",
					                        data: { rno: regNo },
					                        success: function(data) {
					                            $("#body").val("");
					                            $("#body").html(data);
					                        },
					                        error: function(e) {
					                            alert("서버 오류: " + e.status);
					                        }
					                    });
					                    return false;
					                });
					            }
					        }
						</script>
					<% } %>
				</div>
			</div>
			<div class="friends-popup-main" id="set" style="display: none;">
				<div class="popup-main-header">설정</div>
			</div>
		</div>
		<script type="text/javascript">
			$("#friends-popup").draggable({
				handle: ".drag-section"
			});
		</script>
		<script>
			var list = document.getElementById("friend-list-btn");
			var add = document.getElementById("add-friend-btn");
			var set = document.getElementById("friend-setting-btn");
			var popup = document.getElementById("friends-popup");
		
			// 초기화: 로컬 스토리지에서 이전에 선택한 팝업 창 상태와 위치 정보를 가져와서 적용합니다.
			var activePopup = localStorage.getItem("activePopup");
			var savedPosition = localStorage.getItem("popupPosition");
			
			if (activePopup === "list") {
				showPopup("list");
			} else if (activePopup === "add") {
				showPopup("add");
			} else if (activePopup === "set") {
				showPopup("set");
			} else {
				// 로컬 스토리지에 저장된 위치 정보가 없을 경우 초기 위치로 설정합니다.
				setPopupPosition(478.237, 102.238);
			}
			
			// 드래그 이벤트 처리
			$(function() {
				$(popup).draggable({
					stop : function(event, ui) {
						// 드래그가 멈춘 후의 위치 정보를 로컬 스토리지에 저장하고 팝업 창에 적용합니다.
						setPopupPosition(ui.position.left, ui.position.top);
					},
				});
			});
		
			list.onclick = function() {
				showPopup("list");
			};
		
			add.onclick = function() {
				showPopup("add");
			};
		
			set.onclick = function() {
				showPopup("set");
			};
			
			function showPopup(popupId) {
				list.style.backgroundColor = "";
				add.style.backgroundColor = "";
				set.style.backgroundColor = "";
				document.getElementById("list").style.display = "none";
				document.getElementById("add").style.display = "none";
				document.getElementById("set").style.display = "none";
		
				// 선택한 팝업 창을 보여주고, 로컬 스토리지에 상태를 저장합니다.
				if (popupId === "list") {
					list.style.backgroundColor = "#5a5a5a";
					document.getElementById("list").style.display = "block";
					localStorage.setItem("activePopup", "list");
					localStorage.setItem("list_display", "block");
					localStorage.setItem("add_display", "none");
				} else if (popupId === "add") {
					add.style.backgroundColor = "#5a5a5a";
					document.getElementById("add").style.display = "block";
					localStorage.setItem("activePopup", "add");
					localStorage.setItem("list_display", "none");
					localStorage.setItem("add_display", "block");
				} else if (popupId === "set") {
					set.style.backgroundColor = "#5a5a5a";
					document.getElementById("set").style.display = "block";
					localStorage.setItem("activePopup", "set");
				}
			}
		
			function setPopupPosition(left, top) {
				// 팝업 창의 위치를 설정하고, 로컬 스토리지에 위치 정보를 저장합니다.
				$(popup).css({
					left : left + "px",
					top : top + "px"
				});
				localStorage.setItem("popupPosition", JSON.stringify({
					left : left,
					top : top
				}));
			}
		
			// 초기 위치로 팝업 창 위치를 설정합니다.
			var initialPosition = JSON.parse(savedPosition);
			if (initialPosition) {
				setPopupPosition(initialPosition.left, initialPosition.top);
			}
		</script>
		<script type="text/javascript">
	    	function filter2() {
		        var input, filter, friendList, friendItems, i, txtValue;
		        input = document.getElementById("add-friend-search");
		        filter = input.value.toUpperCase();
		        friendList = document.getElementById("add-to-friends");
		        friendItems = friendList.getElementsByClassName("friend-list");
		
		        for (i = 0; i < friendItems.length; i++) {
		            txtValue = friendItems[i].innerText;
		            if (filter === "") {
		                friendItems[i].style.display = "";
		            } else if (txtValue.toUpperCase().indexOf(filter) > -1) {
		                friendItems[i].style.display = "";
		            } else {
		                friendItems[i].style.display = "none";
		            }
		        }
		    }
	    	function resetFilter2() {
		        var input = document.getElementById("add-friend-search");
		        input.value = ""; // 필터 입력값을 비움
		        filter2(); // 필터링 함수 호출하여 모든 친구 항목을 표시
		    }
		</script>
	</body>
</html>