<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DTO.PayMentDTO"%>
<%@ page import="java.util.ArrayList"%>


<%
	String remainSeat = (String)request.getAttribute("remainSeat");
	String totalSeat = (String)request.getAttribute("totalSeat");
	String today = (String)request.getAttribute("today");

	int totalNaverPay=0;
	int totalKakaoPay=0;
	int totalCard=0;
	int totalPc=0;
	int totalFood=0;
	int totalVou=0;
	int totalEtc=0;

	ArrayList<PayMentDTO> payList;
	PayMentDTO payDto = null;

	payList = (ArrayList<PayMentDTO>)request.getAttribute("payList");
	for(int i=0 ; i < payList.size() ; i++){
		payDto = payList.get(i);
		totalNaverPay += payDto.getTotalNaverPay();
		totalKakaoPay += payDto.getTotalKakaoPay();
		totalCard += payDto.getTotalCard();
		totalPc += payDto.getTotalPc();
		totalFood += payDto.getTotalFood();
		totalVou += payDto.getTotalVou();
		totalEtc += payDto.getTotalEtc();
	}

	int totalFee = totalNaverPay + totalKakaoPay + totalCard;

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>매출관리</title>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js" integrity="sha512-ElRFoEQdI5Ht6kZvyzXhYG9NqjtkmlkfYk0wr6wHxU9JEHakS7UJZNeml5ALk+8IKlU6jDgMabC3vkumRokgJA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="css/Payment.css" />
</head>
<body>
	<jsp:include page="NavBar2.jsp" />
	<nav class="cafeNav1">
		<div class="cafeNavTop">
			<div class="cafeNavLeft">
				<span class="Manager">매니저 #</span> 
				<span class="showCafe">매장명 : </span>
			</div>
			<div class="cafeNavRight">
				<span style="font-size: 12px;"> &nbsp;&nbsp;QKYG PC방</span>
			</div>
		</div>
			<!-- 각 정보에 따른 날짜정보 출력 -->
			<%if(request.getParameter("selectedSectionDate")!=null){
					out.print("<span id="+'"'+"daySectionPrint"+'"'+">"+request.getParameter("selectedSectionDate")+"</span>");
			  }else if(request.getParameter("selectedDate")!=null){
				  out.print("<span id="+'"'+"dayPrint"+'"'+">"+request.getParameter("selectedDate")+"</span>");
			  } else if(request.getParameter("selectedMonth")!=null){
				  out.print("<span id="+'"'+"dayPrint"+'"'+">"+request.getParameter("selectedMonth")+"</span>");
			  } %>
 		
		
	</nav>
	<nav class="cafeNav2">
		<div class="cafeNavSec">
		<!-- 현재 잔여좌석 및 총좌석 출력 -->
			<div class="cafeSeats">
				<span class="firCafeNavSec">사용현황</span>
				<div class="seats">
					<div class="cafeNavSeatsItems" style="color: rgba(255, 255, 255, 0.4)">
						<%
							out.println(totalSeat.charAt(0));
						%>
					</div>
					<div class="cafeNavSeatsItems" style="color: rgba(255, 255, 255, 0.4)">
						<%
							out.println(totalSeat.charAt(1));
						%>
					</div>
					<div class="cafeNavSeatsItems" style="color: rgba(255, 255, 255, 0.4)">
						<%
							out.println(totalSeat.charAt(2));
						%>
					</div>
				</div>
				<div class="seats">
					<div class="cafeNavSeatsItems">
						<%
							out.println(remainSeat.charAt(0));
						%>
					</div>
					<div class="cafeNavSeatsItems">
						<%
							out.println(remainSeat.charAt(1));
						%>
					</div>
					<div class="cafeNavSeatsItems">
						<%
							out.println(remainSeat.charAt(2));
						%>
					</div>
				</div>
			</div>
					<div class="btnItem">
				<a href="Controller?command=payment">
					<button class="secCafeNavBtn">당일매출</button>
				</a>
				<a href="Controller?command=inquiry">
					<button class="secCafeNavBtn">매출조회</button>
				</a> 
				<a href="Controller?command=payment">
					<button class="secCafeNavBtn">상품관리</button>
				</a>
				<a href="Controller?command=payment">
					<button class="secCafeNavBtn">주문내역</button>
				</a>
			</div>
		</div>
	</nav>
	<!-- 선택한 날짜정보에 따른 각 페이툴의 결제정보 출력 -->
	<div class="payment">
		<div class="totalNaverPay">
			<span class="whatPay">네이버 페이</span><br> <br> <span class="pay"> 
				<%
				 	out.println(totalNaverPay + "원");
				 %>
			</span>
		</div>
		<div class="totalKakaoPay">
			<span class="whatPay">카카오 페이</span><br> <br> <span class="pay"> 
				<%
				 	out.println(totalKakaoPay + "원");
				 %>
			</span>
		</div>
		<div class="totalCard">
			<span class="whatPay">카드</span><br> <br> <span class="pay"> 
				<%
				 	out.println(totalCard + "원");
				 %>
			</span>
		</div>
		<div class="totalfee">
			<span class="whatPay">총 금액</span><br> <br> <span class="pay"> 
				<%
				 	out.println((totalFee) + "원");
				 %>
			</span>
		</div>
	</div>
	<!-- Chart.js -->
	<div class="Chart">
		<div>
			<canvas id="LineChart" class="lineChart">
			</canvas>
		</div>
		<div class="Chart" style="margin-bottom: 80px;">
			<canvas id="Doughnut" class="doughnutChart">
			</canvas>
		</div>
	</div>
	<jsp:include page="BottomFooter.jsp" />
	<script>		//Chart.js 자바스크립트
		const ctx = document.getElementById('LineChart');

		new Chart(ctx, {
			type : 'line',
			data : {

				backgroundColor : [ '#22CE6F', '#FAE100', '#F5FAFE' ],
				borderColor : [ '#22CE6F', '#FAE100', '#F5FAFE' ],
				labels : [ '네이버 페이', '카카오 페이', '카드' ],
				datasets : [ {
					label : '월간 매출',
					borderWidth : 2,
					fill : true,
					tension : 0.4,
					data : [
						<%out.println(totalNaverPay);%>
							,
						<%out.println(totalKakaoPay);%>
							,
						<%out.println(totalCard);%>
					],
					backgroundColor : [ 'rgb(215,229,250)' ],
				} ]
			},
			options : {
				scales : {
					y : {
						beginAtZero : true
					}
				}
			}
		});
	</script>
	<script>
		const ctd = document.getElementById('Doughnut');

		new Chart(ctd,
				{
					type : 'doughnut',

					label : '항목별 매출액',
					data : {
						labels : [ 'PC사용', '상품(먹거리)', '상품권', '기타수입' ],
						datasets : [ {
							data : [
								<%out.print(totalPc);%>
									,
								<%out.print(totalFood);%>
									,
								<%out.print(totalVou);%>
									,
								<%out.print(totalEtc);%>
							],
							backgroundColor : [ 
								'rgb(239,116,110)',
								'rgb(101,179,161)', 
								'rgb(88,133,201)',
								'rgb(246,194,95)' 
							]
						} ]
					},
					options : {

						scales : {

						}
					}
				});
	</script>
</body>
</html>
