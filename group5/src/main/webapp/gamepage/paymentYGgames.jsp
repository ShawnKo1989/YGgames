<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YG games payment process</title>
<script src="/group5/js/jquery-3.7.0.min.js"></script>
<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
<script src="https://pay.nicepay.co.kr/v1/js/"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js" integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC" crossorigin="anonymous"></script>
<style>
body{
	font: Inter, "sans-serif", OpenSans, "system-ui";
}
/*   div{   */
/*  	border: 1px solid black;   */
/*   }   */
.loader {
  border: 16px solid rgb(180, 180, 180); /* Light grey */
  border-top: 16px solid #969696; /* Blue */
  border-radius: 50%;
  width: 120px;
  height: 120px;
  animation: spin 2s linear infinite;
  position: fixed;
  top: 50%;
  left: 50%;
  transform:translate(-50%,-50%);
}
.loader_background{
	position:fixed; 
	top:0; 
	left:0; 
	right:0; 
	bottom:0; 
	background:rgba(240,240,240,.4); 
	font-size:0; 
	text-align:center;
	z-index: 10;
	height: 100%;
}

@keyframes spin {
  0% { transform: translate(-50%, -50%) rotate(0deg); }
  100% { transform: translate(-50%, -50%) rotate(360deg); }
}
.payment_pop_inner {
	margin-top: 55px;
    width: 1197px;
    height: 830px;
	display:inline-block; 
	padding:20px 30px; 
	background:#fff; 
	vertical-align:middle;
	font-size:15px;
	border-radius: 4px;
	z-index: 20;
}
.pop_wrap_payment{
	position:fixed; 
	top:0; 
	left:0; 
	right:0; 
	bottom:0; 
	background:rgba(0,0,0,.5); 
	font-size:0; 
	text-align:center;
	z-index: 10;
}
.pop_wrap_payment:after {
	display:inline-block; 
	height:100%; 
	vertical-align:middle; 
	content:'';
}
.payment_pop_left{
	width: 862px;
	height: 933px;
	float: left;
}
.payment_pop_right {
	width: 278px;
	height: 100%px;
	float: right;
	padding: 0px 15px;
	background: rgb(242, 242, 242);
}
.top_title{
	display: flex;
	width: 821px;
	height: 72px;
	border-bottom: 2px solid rgba(20, 20, 20, 0.16);
}
.top_title-left {
    margin-top: 15px;
    border-bottom: 4px solid rgb(0, 120, 242);
	text-align: left;
	width: 412.58px;
	height: 58px;
	float: left
}
.top_title-left span {
	letter-spacing: 0.14px;
	font-size: 16px;
	left: 1px;
	top: 1px;
}
.top_title-right {
	font-weight: 500;
	font-size: 10px;
	letter-spacing: 0.14px;
    text-align: right;
	width: 412.58px;
	height: 74px;
	float: right;
}
.top_title-right{
	color: rgb(0, 120, 242);
}
.top_title-right img {
	width: 10px;
	height: 10px;
}
.pay_subtitle_div {
	margin-top: 15px; 
	width: 109px;
	font-size: 16px;
	font-weight: 400;
	letter-spacing: 0.14px;
}
.payment_method {
	cursor: pointer;
	display: flex;
	border-radius: 4px;
	opacity: 0.6px;
	background: rgb(242, 242, 242);
	margin-left: 8px;
	margin-top: 16px;
	margin-bottom: 25px;
	width: 845px;
	height: 68px;
}
.payment_method:hover {
	background: #b4b4b4;
	transition: .3s;
}
.payment_method img {
	width: 42px;
}
.payment_method input {
	margin-left: 22px;
}
.method_img_box {
	height: 36px;
	margin-top: 14px;
	margin-left: 25px;
}
.innerMethodName{
	height: 20px;
    margin-top: 22px;
    margin-left: 34px;
    font-size: 16px;
    font-weight: 600;
}
.inner_right_area {
	width: 43%;
	height: 100%;
	float: right;
	margin-left: auto;
}
.btn_close {
	float: right;
	border:0;
	align-items: center;
	background: rgb(242, 242, 242);
	float: right;
	width: 30px;
	height: 30px;
}
.btn_close img {
	width: 20px;
	height: 20px;
}
.game_img_box {
	width: 261px;
	height: 348px;
	margin: 0 auto;
}
.game_img_box img {
	width: 261px;
	height: 348px;
}
.inner_game_summary{ 
	color: rgba(20, 20, 20, 0.72);
 	display: flex; 
} 
.game_summary_co1{
	float: left;
}
.game_summary_col2{
	margin-left: auto;
}
.payment_order_btn {
	background: rgb(0, 120, 242); 
	width: 276px; height: 61px; 
	border-radius: 4px; 
	border: 0; color: white; 
	margin-top: 10px; 
	cursor: pointer;
}
.payment_order_btn:hover {
	background: #3CB4FF;
	transition: .3s;
}
</style>
</head>
<body>
	<button onclick="paymentBtn()">결제창 호출</button>
	<div id="payment_pop" class="pop_wrap_payment" style="display: none;">
	<div class="loader_background"></div>
	<div class="loader"></div>
		<div class="payment_pop_inner">
			<div class="payment_pop_left">
				<div class="top_title">
					<div class="top_title-left">
						<div style="margin-top: 27px;"><span>결제</span></div>
					</div>
					<div class="top_title-right">
						<div style="margin-top: 52px;"><img src="https://cdn.pixabay.com/photo/2017/02/25/22/04/user-icon-2098873_1280.png"/><span>유저닉네임</span></div>
					</div>
				</div>
			<div class="pay_subtitle_div" style="margin-top: 50px;"><span>에픽리워드</span></div>
			<div class = "payment_method">
				<input type="radio" id="method_select1" name="clickMethodBtn" value="epicReward"/>
				<div class="method_img_box">
					<img src="https://w7.pngwing.com/pngs/797/207/png-transparent-wm-fashion-ab-menu-wallet-icon-angle-text-rectangle.png"/>
				</div>
				<div class="innerMethodName">
					<span>에픽 리워드</span>
				</div>
				<div class="innerMethodName" style="font-weight: 700; margin-left: 30px;">
					<span>(유저가 가진 exp총량을 표시)</span>
				</div>
				<div class="inner_right_area"></div>
			</div>
			<div class="pay_subtitle_div"><span>카카오 페이</span></div>
			<div class = "payment_method">
				<input type="radio" id="method_select2" class="method_select" name="clickMethodBtn" value="kakaoPay"/>
				<div class="method_img_box">
					<img src="https://blog.kakaocdn.net/dn/pJXrd/btqCD8tZlzS/yRq37KkOmDidhk6hytKSIK/img.jpg"/>
				</div>
				<div class="innerMethodName">
					<span>카카오페이</span>
				</div>
				<div class="inner_right_area"></div>
			</div>
			<div class="pay_subtitle_div"><span>네이버 페이</span></div>
			<div class = "payment_method">
				<input type="radio" id="method_select3" class="method_select" name="clickMethodBtn" value="naverPay"/>
				<div class="method_img_box">
					<img src="data:image/png;base64,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" style="width:84px;"/>
				</div>
				<div class="innerMethodName">
					<span>네이버페이</span>
				</div>
				<div class="inner_right_area"></div>
			</div>
			<div class="pay_subtitle_div"><span>나이스 페이</span></div>
			<div class = "payment_method">
				<input type="radio" id="method_select4" class="method_select" name="clickMethodBtn" value="nicePay"/>
				<div class="method_img_box">
					<img src="https://start.nicepay.co.kr/images/homepage/main/nicepay-logo_for_startup.svg" style="width:84px; margin-top: 9px;"/>
				</div>
				<div class="innerMethodName">
					<span>나이스페이</span>
				</div>
				<div class="inner_right_area"></div>
			</div>
			
			</div>
			<div class="payment_pop_right">
				<button type="button" class="btn_close">
					<img src="https://cdn.icon-icons.com/icons2/2066/PNG/512/close_icon_125331.png" style="margin-top: 11px;"/>				
				</button>
				<div style="margin-top: 68px; width: 70px; margin-bottom: 10px;"><span>주문요약</span></div>
				<div style="width: 280px; height: 557px; overflow-y: auto;">
					<div class="game_img_box">
						<img src="https://www.consumernews.co.kr/news/photo/202107/630666_224613_542.png" />
					</div>
					<div style="text-align: left;"><h2 style="font-size: 16px; font-weight: 700;">게임 타이틀</h2></div>
					<div style="text-align: left; margin-bottom: 15px; color:rgba(20, 20, 20, 0.72);"><span>게임제작사</span></div>
					<div class="inner_game_summary">
						<div class="game_summary_col1"><span>가격</span></div>
						<div class="game_summary_col2"><span>게임원래금액</span></div>
					</div>
					<div class="inner_game_summary" style="border-bottom: 2px solid rgb(20, 20, 20); height: 35px;">
						<div class="game_summary_col1"><span>할인 금액</span></div>
						<div class="game_summary_col2"><span>게임할인금액</span></div>
					</div>
					<div class="inner_game_summary" style="margin-top: 10px; font-weight: 700; font-size: 14px;">
						<div class="game_summary_col1"><b>합계</b></div>
						<div class="game_summary_col2"><b>게임합계금액</b></div>
					</div>
					<div style="width: 255px; height: 142.11px; display: flex; margin-top: 20px; color: rgba(20, 20, 20, 0.72);">
						<div><input type="checkbox"/></div>
						<div style="text-align: left;">
						<span>여기를 클릭하여 </span>
						<strong>개발사이름</strong>
						<span>과(와) 이메일 주소 공유에 동의하세요. </span>
						<strong>개발사이름</strong>
						<span>은(는) 마케팅 및 그 밖의 </span>
						<a href="">개인정보처리방침</a>
						<span>에 따른 목적을 위해 회원님의 이메일 주소를 사용하므로 개인정보처리방침을 읽어보실 것을 권장합니다.</span>
						</div>
					</div>
					<div style="margin-top: 10px; color: rgba(20, 20, 20, 0.72); margin-bottom: 30px;">
					<span>도움이 필요하신가요?</span><a href="">문의하기</a>
					</div>
				</div>
				<div style="width: 278px; height: 126px; padding: 20px 15px; font-size: 12px; font-weight: 400; letter-spacing: 0.14px; text-align: left;">'
					<span>아래 "주문하기"을(를) 클릭하면 본인은 만 18세가 넘는 성인이자 해당 결제 수단을 사용할 권리가 있으며 </span>
					<a href="">최종 사용자 라이선스 계약</a><span>에 동의한다는 뜻입니다.</span><br/>
				<button id="paymentOrderBtn" class="payment_order_btn" >주문하기</button>
				</div>
			</div>
		</div>
	</div>
	<script>
	let btnValue = "";
	$("#method_select1").click(function(){
		btnValue = document.getElementsByName("clickMethodBtn")[0].value;
	});
	$("#method_select2").click(function(){
		btnValue = document.getElementsByName("clickMethodBtn")[1].value;
	});
	$("#method_select3").click(function(){
		btnValue = document.getElementsByName("clickMethodBtn")[2].value;
	});
	$("#method_select4").click(function(){
		btnValue = document.getElementsByName("clickMethodBtn")[3].value;
	});
		
		//페이먼트 방식 클릭후 구매버튼 누르면 작동
		$(function(){
			$('.payment_order_btn').click(function(){
				if(btnValue=="epicReward"){
					alert("아직 준비되지 않은 서비스");
				}
				if(btnValue=="kakaoPay"){
						//카카오페이 구현 연습 -작동
						$.ajax({
							method: "POST",
							url: "https://kapi.kakao.com/v1/payment/ready",
							data: {
								cid: "TC0ONETIME", 
								partner_order_id: "g_no가 들어갈자리",
								partner_user_id: "user nickname이 들어갈자리",
								item_name: "YG게임즈 정처산기온라인",
								quantity: 1,
								total_amount: 1004,
								tax_free_amount: 0,
								approval_url : "http://210.114.1.134:9090/group5/main.jsp",
								cancel_url: "http://210.114.1.134:9090/group5/paymentYGgames.jsp",
								fail_url: "http://210.114.1.134:9090/group5/paymentYGgames.jsp",
								},
							headers: {Authorization: "KakaoAK 575195742ae8fad59fa60876c528a516"}
						})
						.done(function(msg){
							window.open(msg.next_redirect_pc_url,'카카오페이QR결제','width: 100px, height: 200px; scrollbars=yes');
						});
					}
				if(btnValue=="naverPay"){
					//네이버 페이 구현 연습 - 미완성
					var oPay = Naver.Pay.create({
			          "mode" : "development", // development or production
			          "clientId": "u86j4ripEt8LRfPGzQ8", // clientId
			          "chainId": "Test" // chainId
			    	});
					oPay.open({
				          "merchantUserKey": "test",
				          "merchantPayKey": "DB의 reg_no 값",
				          "productName": "YG게임즈의 무작위게임",
				          "totalPayAmount": "1000",
				          "taxScopeAmount": "1000",
				          "taxExScopeAmount": "0",
				          "returnUrl": "http://210.114.1.134:9090/group5/main.jsp"
				    });
				}
				if(btnValue=="nicePay"){
					AUTHNICE.requestPay({
					    clientId: 'S2_0f7873bce9a64b3a9f8991243d9ddbec',
					    method: 'card',
					    orderId: '42uh39u43h',
					    amount: 1004,
					    goodsName: '나이스페이-상품',
					    returnUrl: 'http://210.114.1.134:9090/group5/main.jsp',
					    fnError: function (result) {
					      alert(result.errorMsg)
					    }
					  });
					const random = (length = 8) => {
						  return Math.random().toString(16).substr(2, length);
						};	
				 }
				});
			});
				
	//버튼 div 아무데나 찍어도 input이 클릭되게 만듬
	$(".innerMethodName, .inner_right_area").click(function(){
		$(this).parent().children('input').click();
	});
	
	$(window).on("load", function() { // 로딩바 윈도우 로딩 완료시 페이드 아웃
		$(".loader").fadeOut();
		$(".loader_background").fadeOut();
	});
	// 팝업창을 열고 닫는 기능
	function paymentBtn() {
		$(function() {
			$("#payment_pop").css({
				"display" : "inline-block",
				"height" : "100%"
			});
		});
	}
	$(".btn_close").click(function() {
		$(".pop_wrap_payment").css({
			"display" : "none",
		});
	});
	</script>
</body>
</html>