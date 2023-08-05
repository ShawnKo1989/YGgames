<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	String messageType = (String)session.getAttribute("messageType");
	String messageContent = (String)session.getAttribute("messageContent");	
	String userNickName = (String)session.getAttribute("userNickname");	
	String userEmail = (String)session.getAttribute("userEmail");	
	String mobileOTPNum = (String)session.getAttribute("mobileOTPNum");
	String userPhoneNum = (String)session.getAttribute("userPhoneNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/profileSetting.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" href="css/lookforward.min.css" />
<script src="js/lookforward.js"></script>
<script src="js/jquery-3.7.0.min.js"></script>
<script defer src="js/jquery-lookforward.min.js"></script>
<script defer src="js/lookforward.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<title>YG게임즈 계정설정 페이지</title>
<script>
let userNickname = '<%=userNickName%>';
let userEmail = '<%=userEmail%>';
if(userNickName=='null'||userEmail=='null'){
	alert('로그인이 필요한서비스입니다.');
	location.href="socialSignin.jsp";
}

let messageType = "<%=messageType%>";
let messageContent = "<%=messageContent%>";

if(messageType != 'null' && messageContent != 'null'){
	alert(messageType + " : " + messageContent);
	<%
	session.setAttribute("messageType",null);
	session.setAttribute("messageContent",null);
	%>
}
</script>
<style>
body {
	background: white;
}
</style>
</head>
<body>
	<div class="loader_background"></div>
	<div class="loader"></div>
	<jsp:include page="NavBar2.jsp" />
	<div style="display: flex;">
		<div id="settingList">
			<button name="setting" id="accSetting" class="list_btn">
				<img src="images/setting.png"><span>&nbsp계정설정</span>
			</button>
			<button id="pwChange" name="pwchange" class="list_btn">
				<img src="images/pwchange.png"><span>&nbsp비밀번호 변경</span>
			</button>
			<button id="gameMoney" name="gamemoney" class="list_btn">
				<img src="images/gamemoney.png"><span>&nbsp회원탈퇴</span>
			</button>

		</div>
		<div id="here">
			<div id="changedbody">
				<!-- 		<div class="loader_background"></div> -->
				<!-- 		<div class="loader"></div> -->
				<span
					style="line-height: 33.9px; font-size: 30px; font-weight: 400; letter-spacing: -0.6px;">계정
					설정</span><br />
				<div style="margin-top: 15px;">
					<span
						style="color: rgba(20, 20, 20, 0.72); letter-spacing: 0.14px; font-size: 14px; font-weight: 400; margin-block-start: 15px;">계정
						상세 정보를 관리합니다.</span><br />
				</div>
				<div style="margin-top: 30px;">
					<span
						style="font-size: 18px; font-weight: 700; letter-spacing: -0.18px;"><b>계정정보</b></span>
				</div>
				<div style="display: inline-flex; height: 20px; margin-top: 20px;">
					<h6
						style="margin-top: 0px; box-sizing: border-box; height: 20px; font-size: 14px; font-weigth: 700; letter-spacing: 0.2px;">ID:</h6>
					<p
						style="margin-top: 0px; margin-top: 0px; height: 20px; font-size: 14px; font-weight: 400; letter-spacing: 0.14px;">rghe1dhg23224ndk32ljfkdd123fk</p>
				</div>
					<div id="account_info" style="margin-top: 20px;">
							<form action="Controller" method="post">
							<input type="hidden" name="command" value="NicknameChangeAction">
							<input type="hidden" name="userEmail" value="<%=userEmail%>">
							<input type="text" id="changednickname" name="userNickname" value="<%=userNickName%>" style="padding: 16px;"/>
							<button class="change_btn">
							<img
								src="https://cdn.icon-icons.com/icons2/2098/PNG/512/edit_icon_128873.png">
							</button>
							</form>
						<input type="text" id="changedemail" name="email" value="<%=userEmail%>" style="padding: 16px;"/>
						<button class="change_btn" onclick="emailFunction()">
							<img
								src="https://cdn.icon-icons.com/icons2/2098/PNG/512/edit_icon_128873.png">
						</button>
					</div>
				<h3>개인 세부 정보</h3>
				<div
					style="margin-top: 20px; font-size: 14px; font-wight: 400; letter-spacing: 0.14px; color: rgba(20, 20, 20, 0.72);">
					<span>이름, 연락처 정보 등 에픽게임즈에 공유된 정보를 관리합니다. 개인 정보는 비공개로 설정되어 다른
						사용자에게 표시되지 않습니다. </span> <a href="" onclick="f1()">개인정보처리방침</a><span>보기</span>
				</div>
				<form action="Controller" method="post">
				<input type="hidden" name="command" value="UserProfileUpdateAction">
				<div class="inner1">
					<div id="nameInput">
						<input type="text" name="userName" id="name" required/><label for="name"
							class="linput"><span>이름</span></label>
					</div>
					<div id="gender">
						<input type="radio" name="userGender" value="남자" required/><span>남자</span><input
							type="radio" name="userGender" value="여자" required/><span>여자</span>
					</div>
				</div>
					<div class="userType">
						<input type="radio" name="userType" value="유저" required/><span>일반유저</span><input
							type="radio" name="userType" value="사장" required/><span>PC방 사장님</span>
					</div>
					<div class="userBirth" style="margin-top: 35px;">
						<div style="font-size: 12px; font-weight: 700; margin-left: 21px;">생년월일(필수)</div>
						<div style="margin-left: 19px;"><input name="userBirth" class="userBirthInput" type="text" id="datepicker" autocomplete="off" required></div>
					</div>
					<div id="addreearea">
						<h3>주소</h3>
					</div>
					<div class="address_outline" style="display: flex;">
						<div class="address_outter" style="margin-left: 20px;">
							<input type="text" name="userAddress1" class="address" id="address1" required/><label
								for="address1"><span>주소입력란 1</span></label>
						</div>
						<div class="address_outter" style="margin-left: 20px;">
							<input type="text" name="userAddress2" class="address" id="address2" required/><label
								for="address2"><span>주소입력란 2</span></label>
						</div>
					</div>
					<div class="address_outline"
						style="display: flex; margin-top: 10px;">
						<div class="address_outter" style="margin-left: 20px;">
							<input type="text" name="userAddress3" class="address" id="address3" required/><label
								for="address3"><span>건물이름 외 기타주소</span></label>
						</div>
						<div class="postal_code">
							<input type="text" name="userPostalCode" class="post"
								id="postal_code" required/><label for="postal_code"><span>우편번호</span></label>
						</div>
					</div>
					<button id="save">
						<span>변경사항 저장</span>
					</button>
				</form>
				<h3>모바일 등록 및 2단계 인증</h3>
				<div
					style="margin-top: 30px; color: rgba(20, 20, 20, 0.72); font-size: 14px; font-weight: 400; letter-spacing: 0.14px;">
					<span>2단계 인증을 사용하여 무단 도용 위험으로부터 계정을 보호할 수 있습니다. 로그인할 때마다 보안
						코드를 입력해야 합니다.</span> <a href="" onclick="f1()">사용법 비디오</a><span>또는</span><a
						href="" onclick="f1()">도움말 문서</a><span>를 확인하세요.</span>
				</div>
				<div class="mobile_outline">
					<div class="mobile_inner">
						<img src="https://pic.onlinewebfonts.com/svg/img_340164.png" />
					</div>
					<div class="mobile_inner">
						<span
							style="letter-spacing: 0.0125rem; line-height: 1.57; font-size: 0.875rem; font-weight: bold;">2단계
							인증용 SMS코드</span><br />
						<div
							style="margin-top: 5px; font-weight: normal; color: rgba(20, 20, 20, 0.72); font-size: 14px;">
							<span>2단계 인증에 전화번호를 사용합니다. SMS 메시지를 통해 전송된 보안 코드를 입력해야
								합니다.</span>
						</div>
					</div>
					<div class="mobile_inner">
						<button class="mobile_btn" onclick="mobileBtn()">
							<span>설정</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 회원탈퇴 팝업창 -->
	<div id="withdraw_pop" class="pop_wrap" style="display: none;">
		<div class="pop_inner">
			<button type="button" class="btn_close">
				<img
					src="https://cdn.icon-icons.com/icons2/2066/PNG/512/close_icon_125331.png" />
			</button>
			<p class="dsc">계정 삭제</p>
			<div class="pop_sub">
				<span>에픽게임즈 계정을 삭제하시겠습니까? 문제가 있으면 </span><a href="" onclick="f1()">지원센터</a><span
					style="font-weight: bold;">에 문의하여 도움을 받으세요.</span>
			</div>
			<form action="Controller" method="post">
			<button class="btn_confirm_withdrawal">계정 삭제</button>
			<input type="hidden" name="command" value="UserWithdrawalAction">
			</form>
			<button class="btn_cancel_withdrawal">취소</button>
		</div>
	</div>
	<!-- 모바일 등록 팝업창 -->
	<div id="mobile_pop" class="pop_wrap" style="display: none;">
		<div class="pop_inner2">
			<button type="button" class="btn_close">
				<img
					src="https://cdn.icon-icons.com/icons2/2066/PNG/512/close_icon_125331.png" />
			</button>
			<div class="pop_title2"
				style="margin-top: 35px; margin-bottom: 20px;">
				<h2 class="dsc2">전화번호 추가</h2>
			</div>
			<div class="pop_sub2">
				<span>2단계 인증용 SMS 코드를 설정하려면 전화번호를 입력하세요.</span>
			</div>
			<form action="Controller" method="post">
			<input type="hidden" name="command" value="UserMobileOTPAction">
			<div class="pop_input_area">
				<img
					src="data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='-36 -24 72 48'%3e%3cpath fill='%23fff' d='M-36-24h72v48h-72z'/%3e%3cg transform='rotate(-56.31)'%3e%3cg id='b'%3e%3cpath id='a' d='M-6-25H6m-12 3H6m-12 3H6' stroke='%23000' stroke-width='2'/%3e%3cuse xlink:href='%23a' y='44'/%3e%3c/g%3e%3cpath stroke='%23fff' d='M0 17v10'/%3e%3ccircle fill='%23cd2e3a' r='12'/%3e%3cpath fill='%230047a0' d='M0-12A6 6 0 0 0 0 0a6 6 0 0 1 0 12 12 12 0 0 1 0-24z'/%3e%3c/g%3e%3cg transform='rotate(-123.69)'%3e%3cuse xlink:href='%23b'/%3e%3cpath stroke='%23fff' d='M0-23.5v3M0 17v3.5m0 3v3'/%3e%3c/g%3e%3c/svg%3e" />
				<p style="float: left; margin-top: 26px; margin-left: 14px;">+82
					:</p>
				<input type="tel" id="user_phone_num" name="userPhoneNum" required /><label
					for="user_phone_num">전화 번호</label>
			</div>
			<div class="pop_inner_bottom" style="margin-top: 32px;">
				<button onclick="mobileOtp()" id="continue_btn_mobile" class="otp_continue_btn"
					style="background: rgb(0, 116, 228); color: white;">계속</button>
			</div>
			</form>
			<div class="pop_inner_bottom" id="pop_mobile_cancel"
				style="margin-top: 10px;">
				<button>취소</button>
			</div>
			<div style="width: 350px; margin: 20px auto;">
				<span>참고: SMS 인증은 무료이지만, 통신사의 요금제에 따라 일반 문자 메시지 요금이 발생할 수
					있습니다.</span>
			</div>
		</div>
	</div>
	<!-- 모바일 otp 팝업 -->
	<div id="mobile_otp_pop" class="pop_wrap2" style="display: none;">
		<div class="pop_inner3">
			<button type="button" class="btn_close">
				<img
					src="https://cdn.icon-icons.com/icons2/2066/PNG/512/close_icon_125331.png" />
			</button>
			<h2 class="dsc" style="margin-top: 45px;">보안 코드 입력</h2>
			<div class="pop_sub" style="margin-bottom: 20px;">
				<span><%= userPhoneNum %>(으)로 전송된 6자리 보안 코드를 입력하여 확인을 완료하세요.</span>
			</div>
			<form action="Controller" method="post">
			<input type="hidden" name="command" value="UserMobileSettingAction">
			<div class="otp_write_area">
				<div class="single_digit_num">
					<input id="1" name="num1" type="number" autocomplete="off"
						maxlength="1" required oninput="maxLengthCheck(this)"
						class="digitnum" inputmode="numeric" />
				</div>
				<div class="single_digit_num">
					<input id="2" name="num2" type="number" autocomplete="off"
						maxlength="1" required oninput="maxLengthCheck(this)"
						class="digitnum" inputmode="numeric" />
				</div>
				<div class="single_digit_num">
					<input id="3" name="num3" type="number" autocomplete="off"
						maxlength="1" required oninput="maxLengthCheck(this)"
						class="digitnum" inputmode="numeric" />
				</div>
				<div class="single_digit_num">
					<input id="4" name="num4" type="number" autocomplete="off"
						maxlength="1" required oninput="maxLengthCheck(this)"
						class="digitnum" inputmode="numeric" />
				</div>
				<div class="single_digit_num">
					<input id="5" name="num5" type="number" autocomplete="off"
						maxlength="1" required oninput="maxLengthCheck(this)"
						class="digitnum" inputmode="numeric" />
				</div>
				<div class="single_digit_num">
					<input id="6" name="num6" type="number" autocomplete="off"
						maxlength="1" required oninput="maxLengthCheck(this)"
						class="digitnum" inputmode="numeric" />
				</div>
			</div>
			<button id="mobileOTPconfirmBtn" class="SMS_confirm_withdrawal">SMS 인증 활성화</button>
			</form>
			<button class="btn_cancel_withdrawal">취소</button>
		</div>
	</div>

	<!-- 	<iframe src="emailOTP.jsp" width="300px", height=200px></iframe> -->
	<jsp:include page="BottomFooter.jsp" />
	<script src="script.js"></script>
	<script>
		$(window).on("load", function() { // 로딩바 윈도우 로딩 완료시 페이드 아웃
			$(".loader").fadeOut();
			$(".loader_background").fadeOut();
		});

		$(function() { // 페이지 로드함수로 구현
			$("#accSetting").on("click", function() {
				$("#here").load("profileSetting.jsp #changedbody");
			});
			$("#pwChange").on("click", function() {
				$("#here").load("changepw.jsp #changedbody");
			});
			$("#gameMoney").on("click", function() {
				$("#here").load("withdrawal.jsp #changedbody");
			});
			// 패쓰워드 이미지가 보였다 안보였다 하는 기능
			$(document).on('click', '#show_btn1', function() {
				$('#show_btn1').toggleClass('active');
				if ($('#show_btn1').hasClass('active')) {
					$(this).attr('src', "images/showpw2.png");
					$('#pwinput1').attr('type', "text");
				} else {
					$(this).attr('src', "images/showpw.png");
					$('#pwinput1').attr('type', 'password');
				}
			});
			$(document).on('click', '#show_btn2', function() {
				$('#show_btn2').toggleClass('active');
				if ($('#show_btn2').hasClass('active')) {
					$(this).attr('src', "images/showpw2.png");
					$('#pwinput2').attr('type', "text");
				} else {
					$(this).attr('src', "images/showpw.png");
					$('#pwinput2').attr('type', 'password');
				}
			});
			$(document).on('click', '#show_btn3', function() {
				$('#show_btn3').toggleClass('active');
				if ($('#show_btn3').hasClass('active')) {
					$(this).attr('src', "images/showpw2.png");
					$('#pwinput3').attr('type', "text");
				} else {
					$(this).attr('src', "images/showpw.png");
					$('#pwinput3').attr('type', 'password');
				}
			});
		});
	</script>
</body>
<script>
	<%
		if(userPhoneNum != null && mobileOTPNum != null){
			%>
			$(function(){
				window.scrollTo({ left: 0, top: 500, behavior: "smooth" });
				$("#mobile_otp_pop").css({
					"display" : "inline-block",
					"height" : "100%"
				});
			});
			<%
		}
	%>
	// 생년월일 데이트피커 구현
	$( function() {
    $( "#datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true
    });
  } );
	//팝업창 열기와 닫기 버튼 동작
	function mobileBtn() {
		$(function() {
			$("#mobile_pop").css({
				"display" : "inline-block",
				"height" : "100%"
			});
		});
	}
	function mobileOtp() {
		$(function() {
			$("#mobile_pop").css({
				"display" : "none"
			});
			
		});
	}
	function confirm() {
		$(function() {
			$("#withdraw_pop").css({
				"display" : "inline-block",
				"height" : "100%"
			});
		});
	}
	$(".btn_close").click(function() {
		$(".pop_wrap").css({
			"display" : "none",
		});
		$("#mobile_otp_pop").css({
			"display" : "none",
		});
	});
	$(".btn_cancel_withdrawal").click(function() {
		$(".pop_wrap").css({
			"display" : "none",
		});
		$("#mobile_otp_pop").css({
			"display" : "none",
		});
	});
	$("#pop_mobile_cancel").click(function() {
		$(".pop_wrap").css({
			"display" : "none",
		});
	});
</script>
<script type="text/javascript">

	//otp 숫자 입력 란
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		} else if (object.value.length == object.maxLength) {
			let i = Number(object.id);
			switch (i) {
			case 1:
				let id = document.getElementById("2");
				id.focus();
				break;
			case 2:
				let id2 = document.getElementById("3");
				id2.focus();
				break;
			case 3:
				let id3 = document.getElementById("4");
				id3.focus();
				break;
			case 4:
				let id4 = document.getElementById("5");
				id4.focus();
				break;
			case 5:
				let id5 = document.getElementById("6");
				id5.focus();
				break;
			}
		}
		$(':input').keydown(function(event) {
			//백스페이스 키의 keyCode 는 8 입니다
			if (event.keyCode === 8) {
				if (object.value.length < object.maxLength) {
					let num = Number(this.id) - 1;
					let id2 = document.getElementById(num);
					id2.focus();
				}
			}
		});
	}
</script>

<script>
	// a태그는 준비처리
	function f1() {
		alert("아직 준비중입니다.");
	}
	function emailFunction(){
		alert("고객지원센터를 통해 문의해 주세요 ^^");
	}
</script>
</html>