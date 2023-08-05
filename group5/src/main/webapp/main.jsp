<%@page import="DTO.RecentupdateDTO"%>
<%@page import="DTO.RewardgameDTO"%>
<%@page import="DTO.MostpopDTO"%>
<%@page import="DTO.WishgameDTO"%>
<%@page import="DTO.MostplayDTO"%>
<%@page import="DTO.BestsellerDTO"%>
<%@page import="DTO.FreegamesDTO"%>
<%@page import="DTO.FlowgamesDTO"%>
<%@page import="DTO.DisplayDTO"%>
<%@page import="DAO.StoreDAO"%>
<%@page import="DTO.DiscountDTO"%>
<%@page import="DTO.AdvertiseDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="database.Sql"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
	StoreDAO store = StoreDAO.getInstance();
	String messageType = (String)session.getAttribute("messageType");
	String messageContent = (String)session.getAttribute("messageContent");
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<script src="js/jquery-3.7.0.min.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>YG게임즈 메인화면</title>
<script>
let messageType = '<%=messageType%>';
let messageContent = '<%=messageContent%>';

if(messageType != 'null' && messageContent != 'null'){
	alert(messageType + " : " + messageContent);
	<%
	session.setAttribute("messageType",null);
	session.setAttribute("messageContent",null);
	%>
}
	$(document).ready(function(){
	    $(".display").bxSlider({
	    	auto: true,
	    	pager: false,
	    	controls: false,
	    	slideWidth: 1145,
	    	slideMargin: 200,
	    });
	  });
	$(function() {
		let i = 1;
	    var progressbar = $( "#progressbar"+i),
	      progressLabel = $( ".progress-label" );
	    
	    progressbar.progressbar({});
	    progressbar.progressbar( "value", 0 );
	 
	    function progress() {
		  progressbar.progressbar({});
	      var val = progressbar.progressbar( "value" ) || 0;
	      progressbar.progressbar( "value", val + 2 );
	 
	      if ( val < 99 ) {
	        setTimeout( progress, 70 );
	      } 
	      if(val >= 100){
	    	i++;
	    	if(i>5){i=1}
	    	progressbar.progressbar( "value", 0 );
	    	progressbar = $( "#progressbar"+i);
	       	setTimeout( progress, 70 );
	      }
	    }
	    setTimeout( progress, 1000 );
	  });
</script>
</HEAD>

<body>
	<jsp:include page="NavBar2.jsp" />
	<div id="body"> 
	<%
		//디스플레이되는 제일 큰 부분.
		ArrayList<DisplayDTO> dpList = new ArrayList<DisplayDTO>();
		dpList = store.getDisplaygames(dpList);
	%>
	<jsp:include page="SecondNav.jsp" />
	<div class="main">
		<div class="display">
		<% for(int i = 0; i<=4; i++){ %>
		<div class="bxslider">
			<div class="display-game">
				<img src=<%=dpList.get(i).getDisplayed_img()%> />
				<div id="inside-display">
					<div id="title_img">
						<img src=<%=dpList.get(i).getTitle_icon()%> />
					</div>
					<div id="dis_offer">
						<span><%=dpList.get(i).getDis_offer()%></span>
					</div>
					<div id="simple_text">
						<span><%=dpList.get(i).getSimple_text()%></span>
					</div>
					<div id="price">
						<span> <%=Integer.parseInt((dpList.get(i).getOri_prc()).replaceAll("[,]","")) > 0 ? "&#8361"+ " "+ dpList.get(i).getOri_prc()
		: Integer.parseInt((dpList.get(i).getOri_prc()).replaceAll("[,]","")) <0 ? "출시예정작" : "무료게임" %>
						</span>
					</div>
					<div id="buy_game">
						<form style="float: left;">
							<input id="buy_button" type='button' value='지금구매'
								onclick='test()'>
						</form>
						<div id="to_wish">
							<img src="https://w7.pngwing.com/pngs/972/334/png-transparent-computer-icons-add-logo-desktop-wallpaper-add-thumbnail.png"/>
							<input id="wish_button" type='button' value='장바구니로 이동'
								onclick='test()'>
						</div>
					</div>
				</div>
			</div>
			</div>
			<%} %>
			</div>
			<%
				//디스플레이 되는 부분의 바로 옆 목록 부분
				ArrayList<FlowgamesDTO> fgList = new ArrayList<FlowgamesDTO>();
				fgList = store.getFlowgames(fgList);
			%>
			<div class="flow-right-games">
			<div id="progressbar1" class="flow_game_outter" style="background: transparent; width: 265px; height: 130px; border: 0;">
				<div class="progress-label">
					<div class="flow-game">
						<div id="flow_img">
							<img src=<%=fgList.get(0).getThumnail_img()%> />
						</div>
						<div id="flow-game-title">
							<span><%=fgList.get(0).getTitle()%></span>
						</div>
					</div>
				</div>
			</div>
			<div id="progressbar2" class="flow_game_outter"style="background: transparent; width: 265px; height: 130px;border: 0;">
				<div class="progress-label">
					<div class="flow-game">
						<div id="flow_img">
							<img src=<%=fgList.get(1).getThumnail_img()%> />
						</div>
						<div id="flow-game-title">
							<span><%=fgList.get(1).getTitle()%></span>
						</div>
					</div>
				</div>
			</div>
			<div id="progressbar3" class="flow_game_outter"style="background: transparent; width: 265px; height: 130px;border: 0;">
				<div class="progress-label">
					<div class="flow-game">
						<div id="flow_img">
							<img src=<%=fgList.get(2).getThumnail_img()%> />
						</div>
						<div id="flow-game-title">
							<span><%=fgList.get(2).getTitle()%></span>
						</div>
					</div>
				</div>
			</div>
			<div id="progressbar4" class="flow_game_outter"style="background: transparent; width: 265px; height: 130px;border: 0;">
				<div class="progress-label">
					<div class="flow-game">
						<div id="flow_img">
							<img src=<%=fgList.get(3).getThumnail_img()%> />
						</div>
						<div id="flow-game-title">
							<span><%=fgList.get(3).getTitle()%></span>
						</div>
					</div>
				</div>
			</div>
			<div id="progressbar5" class="flow_game_outter"style="background: transparent; width: 265px; height: 130px;border: 0;">
				<div class="progress-label">
					<div class="flow-game">
						<div id="flow_img">
							<img src=<%=fgList.get(4).getThumnail_img()%> />
						</div>
						<div id="flow-game-title">
							<span><%=fgList.get(4).getTitle()%></span>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		<%
			//할인게임 목록
			ArrayList<DiscountDTO> dcList = new ArrayList<DiscountDTO>();
			dcList = store.getDiscountgames(dcList);
		%>
		<div id="game_genre_title">할인게임</div>
		<div class="game">
			<%
				for (int i = 0; i <= 5; i++) {
			%>
			<div class="game-item">
				<div id="gameImg">
					<img src=<%=dcList.get(i).getThumnail_img()%> />
				</div>
				<div class="gameGenre">
					<span>기본게임</span>
				</div>
				<div id="gameTitle">
					<span><%=dcList.get(i).getTitle()%></span>
				</div>
				<div class="gamePrice">
					<div class="rate">
						<span> <%=((int) ((dcList.get(i).getDc_rate()) * 100))%> %
						</span>
					</div>
					<% if(dcList.get(i).getOri_prc().equals("0")){ %>
					<div class="price">
						<span>무료게임</span>
					</div>
					<%} else if(dcList.get(i).getOri_prc().equals("-1")){%>
					<div class="price">
						<span>출시예정작</span>
					</div>
					<%} else{%>
					<% if(dcList.get(i).getDc_rate() !=0){ %>
					<div class="price" style="color: rgba(245, 245, 245, 0.6); 
					text-decoration-color: rgba(245, 245, 245, 0.6); 
					text-decoration: line-through;">
						<%
							out.print("&#8361");
						%><span><%=dcList.get(i).getOri_prc()%></span>
					</div>
					<% }else{ %>
					<div class="price">
						<%
							out.print("&#8361");
						%><span><%=dcList.get(i).getOri_prc()%></span>
					</div>
					<%} %>
					<%} %>
					<div class="dc_prc">
						<%
							out.print("&#8361");
						%><span><%=dcList.get(i).getDc_prc()%></span>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<%
			//광고게임이 나오는 부분 
			ArrayList<AdvertiseDTO> adList = new ArrayList<AdvertiseDTO>();
			adList = store.getAdvertise(adList);
		%>
		<div class="advertise">
			<%
				for (int i = 0; i <= 1; i++) {
			%>
			<div class="advertise-game">
				<div id="advertise_img">
					<img src="<%=adList.get(i).getMedia_url()%>" />
				</div>
				<div id="advertise_title">
					<span><%=adList.get(i).getTitle()%></span>
				</div>
				<div id="advertise_bottom_inner">
					<div id="advertise_dcrate">
						<span><%=(int) (adList.get(i).getDc_rate() * 100) + "%"%></span>
					</div>
					<%
						if (adList.get(i).getOri_prc().equals("0")) {
					%>
					<div id="advertise_price_soon">
						<span>무료게임</span>
					</div>
					<%
						} else if (adList.get(i).getOri_prc().equals("-1")) {
					%>
					<div id="advertise_price_soon">
						<span>출시예정작</span>
					</div>
					<%
						} else {
					%>
					<div id="advertise_price">
						<%
							out.print("&#8361");
						%><span><%=adList.get(i).getOri_prc()%></span>
					</div>
					<%
						}
					%>
					<% if(!adList.get(i).getDc_prc().equals("0")){ %>
					<div id="advertise_dc_price">
						<%
							out.print("&#8361");
						%><span><%=adList.get(i).getDc_prc()%></span>
					</div>
					<% } %>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<%
			//무료게임 리스트 출력
			ArrayList<FreegamesDTO> freeList = new ArrayList<FreegamesDTO>();
			freeList = store.getFreegames(freeList);
		%>
		<div id="outline_freegame">
			<div class="freetitle">
				<span>무료게임</span>
			</div>
			<div class="freegame">
				<%
					for (int i = 0; i <= 1; i++) {
				%>
				<div class="outer-freegame">
					<div class="freegame_img">
						<img src="<%=freeList.get(i).getMedia_url()%>" />
					</div>
					<div class="freegame_title">
						<span><%=freeList.get(i).getTitle()%></span>
					</div>
					<div class="freegame_prc">
						<span>무료게임</span>
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>
		<%
			// 베스트셀러, 가장많이 플레이된, 위시리스트에 가장 많이 추가된
			ArrayList<BestsellerDTO> bsList = new ArrayList<BestsellerDTO>();
			bsList = store.getBestsellergames(bsList);
			ArrayList<MostplayDTO> mpList = new ArrayList<MostplayDTO>();
			mpList = store.getMostplaygames(mpList);
			ArrayList<WishgameDTO> wgList = new ArrayList<WishgameDTO>();
			wgList = store.getWishgames(wgList);
		%>
		<div class="threekinds-games">
			<div class="threes-center">
				<div class="best-seller-left">
					<div id="best_inner_top">
						<div id="inner_title">
							<span>베스트 셀러</span>
						</div>
						<div id="best_inner_more">
							<span>더 보기</span>
						</div>
					</div>
					<%
						for (int i = 0; i <= 4; i++) {
					%>
					<div id="best_seller_games">
						<div class="best_seller_img">
							<img src="<%=bsList.get(i).getThumnail_img()%>" />
						</div>
						<div class="best_seller_inner">
							<div class="best_seller_title">
								<span><%=bsList.get(i).getTitle()%></span>
							</div>
							<div id="inner_bottom">
								<%
									if (bsList.get(i).getDc_rate() != 0) {
								%>
								<div class="best_seller_dcrate">
									<span><%=(int) (bsList.get(i).getDc_rate() * 100) + "%"%></span>
								</div>
								<%
									}
								%>
								<%
									if (!bsList.get(i).getOri_prc().equals("0")) {
									if (bsList.get(i).getDc_rate() != 0) {
								%>
								<div class="best_seller_prc"
									style="text-decoration: line-through; color: rgba(245, 245, 245, 0.6);
									text-decoration-color: rgba(245, 245, 245, 0.6);">
									<%
										out.print("&#8361");
									%><span><%=bsList.get(i).getOri_prc()%></span>
								</div>
								<%
									} else {
								%>
								<div class="best_seller_prc">
									<%
										out.print("&#8361");
									%><span><%=bsList.get(i).getOri_prc()%></span>
								</div>
								<%
									}
								%>
								<%
									} else if (bsList.get(i).getOri_prc().equals("-1")) {
								%>
								<div class="best_seller_prc_soon">
									<span>출시예정작</span>
								</div>
								<%
									}
								%>
								<%
									if (bsList.get(i).getDc_rate() != 0) {
								%>
								<div class="best_seller_dc_prc">
									<%
										out.print("&#8361");
									%><span><%=bsList.get(i).getDc_prc()%></span>
								</div>
								<%
									}
								%>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<div class="most-played-center">
					<div id="most_inner_top">
						<div id="inner_title">
							<span>가장 많이플레이된 게임</span>
						</div>
						<div id="most_inner_more">
							<span>더 보기</span>
						</div>
					</div>
					<%
						for (int i = 10; i <= 14; i++) {
					%>
					<div id="most_played_games">
						<div class="most_played_img">
							<img src="<%=mpList.get(i).getThumnail_img()%>" />
						</div>
						<div class="most_played_inner">
							<div class="most_played_title">
								<span><%=mpList.get(i).getTitle()%></span>
							</div>
							<div id="inner_bottom">
								<%
									if (!mpList.get(i).getDc_prc().equals("0")) {
								%>
								<div class="most_played_dcrate">
									<span><%=(int)(mpList.get(i).getDc_rate() * 100) + "%"%></span>
								</div>
								<%
									}
								%>
								<%
									if (!mpList.get(i).getOri_prc().equals("0")) {
									if (mpList.get(i).getDc_rate() != 0) {
								%>
								<div class="most_played_prc"
									style="text-decoration: line-through; color: rgba(245, 245, 245, 0.6);
									text-decoration-color: rgba(245, 245, 245, 0.6);">
									<%
										out.print("&#8361");
									%><span><%=mpList.get(i).getOri_prc()%></span>
								</div>
								<%
									} else {
								%>
								<div class="most_played_prc">
									<%
										out.print("&#8361");
									%><span><%=mpList.get(i).getOri_prc()%></span>
								</div>
								<%
									}
								%>
								<%
									} else if (mpList.get(i).getOri_prc().equals("-1")) {
								%>
								<div class="most_played_prc_soon">
									<span>출시예정작</span>
								</div>
								<%
									}
								%>
								<%
									if (mpList.get(i).getDc_rate() != 0) {
								%>
								<div class="most_played_dc_prc">
									<%
										out.print("&#8361");
									%><span><%=mpList.get(i).getDc_prc()%></span>
								</div>
								<%
									}
								%>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<div class="most-wishlist-right">
					<div id="wish_inner_top">
						<div id="inner_title">
							<span>위시리스트에 가장 많이 추가된 출시 예정작</span>
						</div>
						<div id="wish_inner_more">
							<span>더 보기</span>
						</div>
					</div>
					<%
						for (int i = 0; i <= 4; i++) {
					%>
					<div id="wish_comming_games">
						<div class="wish_comming_img">
							<img src=<%=wgList.get(i).getThumnail_img()%> />
						</div>
						<div class="wish_comming_inner">
							<div class="wish_comming_title">
								<span><%=wgList.get(i).getTitle()%></span>
							</div>
							<div class="wish_comming_available">
								<span><%=wgList.get(i).getAvailable() + "부터 이용가능."%></span>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<%
			ArrayList<MostpopDTO> popList = new ArrayList<MostpopDTO>();
			popList = store.getMostpopgames(popList);
		%>
		<div id="game_genre_title">
			<span>최고인기작</span>
		</div>
		<div class="game">
			<%
				for (int i = 6; i <= 11; i++) {
			%>
			<div class="game-item">
				<div id="gameImg">
					<img src=<%=popList.get(i).getThumnail_img()%> />
				</div>
				<div class="gameGenre">
					<span>기본게임</span>
				</div>
				<div id="gameTitle">
					<span><%=popList.get(i).getTitle()%></span>
				</div>
				<div class="gamePrice">
					<% if(popList.get(i).getDc_rate() != 0){ %>
					<div class="rate">
						<span> <%=((int) ((popList.get(i).getDc_rate()) * 100))+"%"%>
						</span>
					</div>
					<%} %>
					<% if(popList.get(i).getOri_prc().equals("0")){ %>
					<div class="price">
						<span>무료게임</span>
					</div>
					<%} else if(popList.get(i).getOri_prc().equals("-1")){%>
					<div class="price">
						<span>출시예정작</span>
					</div>
					<%} else{%>
					<% if(popList.get(i).getDc_rate() !=0){ %>
					<div class="price" style="color: rgba(245, 245, 245, 0.6); 
					text-decoration-color: rgba(245, 245, 245, 0.6); 
					text-decoration: line-through;">
						<%
							out.print("&#8361");
						%><span><%=popList.get(i).getOri_prc()%></span>
					</div>
					<% }else{ %>
					<div class="price">
						<%
							out.print("&#8361");
						%><span><%=popList.get(i).getOri_prc()%></span>
					</div>
					<%} %>
					<%} %>
					<% if(popList.get(i).getDc_rate() !=0){ %>
					<div class="dc_prc">
						<%
							out.print("&#8361");
						%><span><%=popList.get(i).getDc_prc()%></span>
					</div>
					<%} %>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div class="threekinds-games">
			<div class="threes-center">
				<div class="recent-publish-left">
					<div id="best_inner_top">
						<div id="inner_title">
							<span>신규출시</span>
						</div>
						<div id="best_inner_more">
							<span>더 보기</span>
						</div>
					</div>
					<%
						for (int i = 5; i <= 9; i++) {
					%>
					<div id="best_seller_games">
						<div class="best_seller_img">
							<img src="<%=bsList.get(i).getThumnail_img()%>" />
						</div>
						<div class="best_seller_inner">
							<div class="best_seller_title">
								<span><%=bsList.get(i).getTitle()%></span>
							</div>
							<div id="inner_bottom">
								<%
									if (!bsList.get(i).getDc_prc().equals("0")) {
								%>
								<div class="best_seller_dcrate">
									<span><%=(int) (bsList.get(i).getDc_rate() * 100) + "%"%></span>
								</div>
								<%
									}
								%>
								<%
									if (!bsList.get(i).getOri_prc().equals("0")) {
								%>
								<div class="best_seller_prc">
									<%
										out.print("&#8361");
									%><span><%=bsList.get(i).getOri_prc()%></span>
								</div>
								<%
									} else if (bsList.get(i).getOri_prc().equals("-1")) {
								%>
								<div class="best_seller_prc">
									<span>출시예정작</span>
								</div>
								<%
									}
								%>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<div class="most-scored-center">
					<div id="most_inner_top">
						<div id="inner_title">
							<span>플레이어가 높게 평가한 게임</span>
						</div>
						<div id="most_inner_more">
							<span>더 보기</span>
						</div>
					</div>
					<%
						for (int i = 5; i <= 9; i++) {
					%>
					<div id="most_played_games">
						<div class="most_played_img">
							<img src="<%=mpList.get(i).getThumnail_img()%>" />
						</div>
						<div class="most_played_inner">
							<div class="most_played_title">
								<span><%=mpList.get(i).getTitle()%></span>
							</div>
							<div id="inner_bottom">
								<%
									if (!mpList.get(i).getDc_prc().equals("0")) {
								%>
								<div class="most_played_dcrate">
									<span><%=(int) ((mpList.get(i).getDc_rate()) * 100) + "%"%></span>
								</div>
								<%
									}
								%>
								<%
									if (!mpList.get(i).getOri_prc().equals("0")) {
								%>
								<div class="best_seller_prc">
									<%
										out.print("&#8361");
									%><span><%=mpList.get(i).getOri_prc()%></span>
								</div>
								<%
									} else if (mpList.get(i).getOri_prc().equals("-1")) {
								%>
								<div class="best_seller_prc">
									<span>출시예정작</span>
								</div>
								<%
									}
								%>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<div class="published-right">
					<div id="wish_inner_top">
						<div id="inner_title">
							<span>출시 예정</span>
						</div>
						<div id="wish_inner_more">
							<span>더 보기</span>
						</div>
					</div>
					<%
						for (int i = 5; i <= 9; i++) {
					%>
					<div id="wish_comming_games">
						<div class="wish_comming_img">
							<img src="<%=wgList.get(i).getThumnail_img()%>" />
						</div>
						<div class="wish_comming_inner">
							<div class="wish_comming_title">
								<span><%=wgList.get(i).getTitle()%></span>
							</div>
							<div class="wish_comming_available">
								<span><%=wgList.get(i).getAvailable() + "부터 이용가능."%></span>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<div class="advertise">
			<%
				for (int i = 2; i <= 3; i++) {
			%>
			<div class="advertise-game">
				<div id="advertise_img">
					<img src="<%=adList.get(i).getMedia_url()%>" />
				</div>
				<div id="advertise_title">
					<span><%=adList.get(i).getTitle()%></span>
				</div>
				<div id="advertise_bottom_inner">
					<%
						if (!adList.get(i).getDc_prc().equals("0")) {
					%>
					<div id="advertise_dcrate">
						<span><%=(int) (adList.get(i).getDc_rate() * 100) + "%"%></span>
					</div>
					<%
						}
					%>
					<%
						if (adList.get(i).getOri_prc().equals("0")) {
					%>
					<div id="advertise_price_soon">
						<span>무료게임</span>
					</div>
					<%
						} else if (adList.get(i).getOri_prc().equals("-1")) {
					%>
					<div id="advertise_price_soon">
						<span>출시예정작</span>
					</div>
					<%
						} else {
					%>
					<div id="advertise_price">
						<%
							out.print("&#8361");
						%><span><%=adList.get(i).getOri_prc()%></span>
					</div>
					<%
						}
					%>
					<% if(!adList.get(i).getDc_prc().equals("0")){ %>
					<div id="advertise_dc_price">
						<%
							out.print("&#8361");
						%><span><%=adList.get(i).getDc_prc()%></span>
					</div>
					<% } %>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<%
			// 업적게임 목록
			ArrayList<RewardgameDTO> rewardList = new ArrayList<RewardgameDTO>();
			rewardList = store.getRewardgames(rewardList);
		%>
		<div id="game_genre_title">업적이 있는 게임</div>
		<div class="game">
			<%
				for (int i = 0; i <= 5; i++) {
			%>
			<div class="game-item">
				<div id="gameImg">
					<img src="<%=rewardList.get(i).getThumnail_img()%>" />
				</div>
				<div class="gameGenre">
					<span>기본게임</span>
				</div>
				<div class="gameTitle">
					<span><%=rewardList.get(i).getTitle()%></span>
				</div>
				<div class="gamePrice">
					<%
						if (rewardList.get(i).getDc_rate() != 0) {
					%>
					<div class="rate">
						<span> <%=((int) ((rewardList.get(i).getDc_rate()) * 100))%> +"%"
						</span>
					</div>
					<%
						}
					%>
					<%
						if (!rewardList.get(i).getOri_prc().equals("0")) {
					%>
					<div class="price">
						<%
							out.print("&#8361");
						%><span><%=rewardList.get(i).getOri_prc()%></span>
					</div>
					<%
						} else {
					%>
					<div class="price">
						<span>무료게임</span>
					</div>
					<%
						}
					%>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<%
			ArrayList<RecentupdateDTO> recentList = new ArrayList<RecentupdateDTO>();
			recentList = store.getRecentupdate(recentList);
		%>
		<div id="game_genre_title">최근업데이트</div>
		<div class="game" style="margin-bottom: 80px;">
			<%
				for (int i = 0; i <= 5; i++) {
			%>
			<div class="game-item">
				<div id="gameImg">
					<img src="<%=recentList.get(i).getThumnail_img()%>" />
				</div>
				<div class="gameGenre">
					<span>기본게임</span>
				</div>
				<div class="gameTitle">
					<span><%=recentList.get(i).getTitle()%></span>
				</div>
				<div class="gamePrice">
					<%
						if (recentList.get(i).getDc_rate() != 0) {
					%>
					<div class="rate">
						<span> <%=((int) ((recentList.get(i).getDc_rate()) * 100))%> %
						</span>
					</div>
					<%
						}
					%>
					<%
						if (recentList.get(i).getOri_prc().equals("0")) {
					%>
					<div class="price">
						<span>무료게임</span>
					</div>
					<%
						} else if (recentList.get(i).getOri_prc().equals("-1")) {
					%>
					<div class="price">
						<span>출시예정작</span>
					</div>
					<%
						} else {
					%>
					<div class="price">
						<%
							out.print("&#8361");
						%><span><%=recentList.get(i).getOri_prc()%></span>
					</div>
					<%
						}
					%>
				</div>
			</div>
			<%
				}
			%>
		</div>
		</div>
	<jsp:include page="BottomFooter.jsp" />
	<script src="script.js"></script>
</body>
</HTML>