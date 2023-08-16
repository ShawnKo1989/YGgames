<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	try{
		int rsvno = (int)request.getAttribute("rsvno");
		if(rsvno!=0){
			openRsvChk(out, rsvno);
		} else {
			openRefused(out);
		}
	} catch(Exception e) {
	}
%>
<%! 
	private void openRsvChk(JspWriter out, int rsvno) throws Exception {
		String address = "/group5/help/rsvChk.jsp?rsvNo=" + rsvno;
		String options = "width=600, height=300, top=300, left=600, scrollbars=no, toolbar=no, status=no, menubar=no;";
		String script = "<script>"
				+ "window.open('" + address + "', 'rsvChkForm', '" + options + "');"
				+ "</script>";
		out.println(script);
	}
	
	private void openRefused(JspWriter out) throws Exception {
		String address = "/group5/help/refused.jsp";
		String options = "width=600, height=300, top=300, left=600, scrollbars=no, toolbar=no, status=no, menubar=no;";
		String script = "<script>"
				+ "window.open('" + address + "', 'refused', '" + options + "');"
				+ "</script>";
		out.println(script);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>QKYG 지원센터</title>
	<link rel="stylesheet" href="/group5/css/public/common.css" />
	<link rel="stylesheet" href="/group5/css/layout/help.css" />
	<link rel="stylesheet" href="/group5/css/elements/searchBar.css" />
	<link rel="stylesheet" href="/group5/css/elements/map.css" />
	<link rel="stylesheet" href="/group5/css/elements/datepicker.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=02b192bebf731de24de2403b730e32fe&libraries=services,clusterer,drawing"></script>
	<script defer src="/group5/js/map.js"></script>
	<script defer src="/group5/js/datepicker.js"></script>
	<script defer src="/group5/js/common.js"></script>
	<script defer src="/group5/js/help.js"></script>
	<script>
		function popUp(event) {
			let address;
			let options;
			if(event==="vChat") {
				address = "videoChat/";
				options = "width=300, height=100, top=300, left=600, scrollbars=no, toolbar=no, status=no, menubar=no;";
			}
			window.open(address, event, options);
		}
	</script>
</head>
<body>
	<header>
		<jsp:include page="/outframe/NavBar2.jsp"></jsp:include>
	</header>
	<main>
		<div class="header">
			<h1>QKYG게임즈 지원센터에 오신 것을 환영합니다.</h1>
			<form action="/group5/help/" class="searchBarForm">
				<input name="command" value="search" type="hidden" />
				<input class="searchBar" name="search" type="text" placeholder="지원센터 겁색" />
			</form>
			<div class="navRow">
				<a href="#rsvNav">
					<img src="/group5/media/icon/상담예약icon.jpeg" />상담 에약
				</a>
				<a href="#rsvChkNav">
					<img src="/group5/media/icon/예약확인icon.jpeg" />예약 확인
				</a>
				<a href="#mapNav">
					<img src="/group5/media/icon/오시는길icon.jpeg" />찾아오시는 길
				</a>
			</div>
		</div>
		<div id="rsvNav"></div>
		<form action="/group5/help/" class="rsvArea" method="post">
			<input type="hidden" name="command" value="reservation" />
			<h2>상담 예약</h2>
			<div class="pickers">
				<div class="picker">
					<h3>날짜 선택</h3>
					<div class="calendar">
						<input id="datePick" name="date" type="hidden" reguired />
						<div id="datepicker"></div>
					</div>
				</div>
				<div class="picker">
					<h3>시간 선택</h3>
					<div class="timetable">
						<h4>오전</h4>
						<div class="timepicker">
							<%
								for (int i = 10; i <= 11; i++) {
							%>
							<label class="clickable">
								<input name="time" value="<%=i%>" type="radio" required /><%=i%>:00
							</label>
							<%
								}
							%>
						</div>
						<h4>오후</h4>
						<div class="timepicker">
							<%
								for (int i = 12; i <= 17; i++) {
								if (i == 13) {
									continue;
								}
							%>
							<label class="clickable">
								<input name="time" value="<%=i%>" type="radio" required /><%=i%>:00
							</label>
							<%
								}
							%>
						</div>
					</div>
				</div>
				<div id="supportPicker" class="picker">
					<div id="supporterPicker">
						<h3>상담사 선택</h3>
						<div class="supporterpicker">
							<%
								for (int i = 1; i <= 4; i++) {
							%>
							<label class="clickable">
								<input name="supporter" value="<%=i%>" type="radio" required /> <img src="/group5/media/images/직원사진_<%=i%>.jpeg" />직원<%=i%>
							</label>
							<%
								}
							%>
						</div>
					</div>
					<div>
						<h3>상담 유형</h3>
						<div class="contactpicker">
							<label class="clickable">
								<input name="supportType" value="0" type="radio" required />방문상담
							</label>
							<label class="clickable">
								<input name="supportType" value="1" type="radio" required />화상상담
							</label>
						</div>
					</div>
				</div>
				<div class="visitor">
					<input name="name" type="text" placeholder="이름" required /> <input name="phone" type="tel" placeholder="연락처" required /> <input name="email" type="email" placeholder="이메일" required />
				</div>
				<textarea name="description" placeholder="상담 목적을 입력해주세요." required></textarea>
			</div>
			<div class="btnRow">
				<input type="submit" value="예약하기" id="btnRsv" class="clickable redBtn" />
				<input type="button" value="상담" onclick="popUp('vChat');" class="clickable redBtn" />
			</div>
		</form>
		<div id="rsvChkNav"></div>
		<div class="rsvChkArea">
		<h2>예약확인</h2>
			<div class="rsvChk">
				<form onsubmit="showRsvInfo(); return false;" name="rsvChkForm" id="rsvChk">
					<input id="rsvSearch" type="text" name="rsvNo" placeholder="예약번호를 입력하세요." required /> <input type="button" onclick="showRsvInfo();" value="예약확인" class="clickable" />
				</form>
			</div>
		</div>
		<div id="mapNav"></div>
		<div class="mapArea">
		<h2>찾아오시는 길</h2>
			<div id="map"></div>
			<button id="btnDragMap" onclick="setDraggable()" class="clickable">지도 드래그</button>
		</div>
	</main>
	<footer>
		<jsp:include page="/outframe/BottomFooter.jsp"></jsp:include>
	</footer>
</body>
</html>