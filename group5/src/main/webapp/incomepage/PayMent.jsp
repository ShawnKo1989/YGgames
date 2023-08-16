<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String remainSeat = (String)request.getAttribute("remainSeat");
	String totalSeat = (String)request.getAttribute("totalSeat");
	String today = (String)request.getAttribute("today");
	String yesterday = (String)request.getAttribute("yesterday");
	String day2 = (String)request.getAttribute("day2");
	String day3 = (String)request.getAttribute("day3");
	int[] yesFee = (int[])request.getAttribute("yesFee");
	int[] secFee = (int[])request.getAttribute("secFee");
	int[] tirFee = (int[])request.getAttribute("tirFee");
	int fFee = (int)request.getAttribute("fFee");
	int[] feeArr = (int[])request.getAttribute("feeArr");
	
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
	<jsp:include page="../outframe/NavBar2.jsp" />
	<nav class="cafeNav1">
		<div class="cafeNavTop">
			<div class="cafeNavLeft">
				<span class="manager">매니저 #</span> <span class="showCafe">매장명 : </span>
			</div>
			<div class="cafeNavRight">
				<span style="font-size: 12px;"> &nbsp;&nbsp;QKYG PC방</span>
			</div>
		</div>
		<span id="dayPrint"><%=today %></span>		
	</nav>
	<nav class="cafeNav2">
	<!-- 현재 잔여 좌석 및 총좌석 -->
		<div class="cafeNavSec">
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
			<!-- 현재 제가 직접 구현한 기능은 당일매출 및 매출조회입니다. -->
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
	<!-- 각 결제방식에 따른 결제금액 호출 -->
	<div class="payment">
		<div class="totalNaverPay">
			<span class="whatPay">네이버 페이</span><br> <br> <span class="pay"> 
				<% 	out.println(feeArr[1] + "원"); %>
			</span>
		</div>
		<div class="totalKakaoPay">
			<span class="whatPay">카카오 페이</span><br> <br> <span class="pay"> 
				<% 	out.println(feeArr[2] + "원"); %>
			</span>
		</div>
		<div class="totalCard">
			<span class="whatPay">카드</span><br> <br> <span class="pay"> 
				<% 	out.println(feeArr[3] + "원"); %>
			</span>
		</div>
		<div class="totalfee">
			<span class="whatPay">총 금액</span><br> <br> <span class="pay"> 
				<% 	out.println((feeArr[0]) + "원"); %>
			</span>
		</div>
	</div>
	<!-- Chart.js호출 -->
	<div class="Chart">
		<div>
			<canvas id="LineChart" class="lineChart">
			</canvas>
		</div>
		<div class="Chart">
			<canvas id="Doughnut" class="doughnutChart">
			</canvas>
		</div>
	</div>
	<!-- 당일~3일전까지의 매출비교 -->
	<div class="dailyStatus">
		<table style="margin-bottom: 40px; margin-top: 20px;">
			<tr>
				<th class="thTop">날짜</th>
				<th class="thTop">네이버 페이</th>
				<th class="thTop">카카오 페이</th>
				<th class="thTop">카드</th>
				<th class="thTop">총매출</th>
				<th class="thTop">전일 대비</th>
			</tr>
			<tr>
				<td class="dateSet">
					<%
						out.println(today);
					%>
				</td>
				<td class="tdPay">
					<%=feeArr[1]	%>
				</td>
				<td class="tdPay">
					<%=feeArr[2]%>
				</td>
				<td class="tdPay">
					<%=feeArr[3]	%>
				</td>
				<td class="tdPay">
					<%=feeArr[0]%>
				</td>
				<td class="tdPay">
					<%
						if (Math.round((double) (feeArr[0] - yesFee[0]) / feeArr[0] * 100) < 0) {
					%> 
					<span style="color: blue; font-size: 15px;">▼
					<%
					 	out.print("\t");
						out.println((Math.round((double) (feeArr[0] - yesFee[0]) / feeArr[0] * 100 * 100) / 100.0) + "%");
 					%>
 					</span> 
 					<%} else {%> 
 					<span style="color: red; font-size: 15px;">▲
 					<%
					 	out.print("\t");
						out.println((Math.round((double) (feeArr[0] - yesFee[0]) / feeArr[0] * 100 * 100) / 100.0) + "%");
 					%>
 					</span> 
 					<%	} %>
				</td>
			</tr>
			<tr>
				<td class="dateSet">
					<%
						out.println(yesterday);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(yesFee[1]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(yesFee[2]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(yesFee[3]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(yesFee[0]);
					%>
				</td>
				<td class="tdPay">
					<%
						if (Math.round((double) (yesFee[0] - secFee[0]) / yesFee[0] * 100) < 0) {
					%> 
					<span style="color: blue; font-size: 15px;">▼
						<%
	 						out.print("\t");
						 out.println((Math.round((double) (yesFee[0] - secFee[0]) / yesFee[0] * 100 * 100) / 100.0) + "%");
						 %>
					 </span> 
					 <%} else { %> 
					 <span style="color: red; font-size: 15px;">▲
					 <%
							out.print("\t");
						 	out.println((Math.round((double) (yesFee[0] - secFee[0]) / yesFee[0] * 100 * 100) / 100.0) + "%");
					 %>
					 </span> 
 					 <%	} %>
				</td>
			</tr>
			<tr>
				<td class="dateSet">
					<%
						out.println(day2);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(secFee[1]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(secFee[2]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(secFee[3]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(secFee[0]);
					%>
				</td>
				<td class="tdPay">
					<%
						if (Math.round((double) (secFee[0] - tirFee[0]) / secFee[0] * 100) < 0) {
					%> 
					<span style="color: blue; font-size: 15px;">▼
					<%	
					 	out.print("\t");
						out.println((Math.round((double) (secFee[0] - tirFee[0]) / secFee[0] * 100 * 100) / 100.0) + "%");
 					%>
 					</span> 
 					<% 	} else { %> 
 					<span style="color: red; font-size: 15px;">▲
 					<%
					 	out.print("\t");
						out.println((Math.round((double) (secFee[0] - tirFee[0]) / secFee[0] * 100 * 100) / 100.0) + "%");
 					%>
 					</span> 
 					<% 	} %>
				</td>
			</tr>
			<tr>
				<td class="dateSet">
					<%
						out.println(day3);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(tirFee[1]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(tirFee[2]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(tirFee[3]);
					%>
				</td>
				<td class="tdPay">
					<%
						out.println(tirFee[0]);
					%>
				</td>
				<td class="tdPay">
					<%
						if (Math.round((double) (tirFee[0] - fFee) / tirFee[0] * 100) < 0) {
					%> 
					<span style="color: blue; font-size: 15px;">▼
					<%
 						out.println((Math.round((double) (tirFee[0] - fFee) / tirFee[0] * 100 * 100) / 100.0) + "%");
 					%>
 					</span> 
 					<%	} else { %> 
 					<span style="color: red; font-size: 15px;">▲
 					<%	
 						out.println((Math.round((double) (tirFee[0] - fFee) / tirFee[0] * 100 * 100) / 100.0) + "%");
 					%>
 					</span> 
 					<% 	} %>
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="/outframe/BottomFooter.jsp" />
	<!-- Chart.js스크립트 -->
	<script>
		const ctx = document.getElementById('LineChart');

		new Chart(ctx, {
			type : 'line',
			data : {

				backgroundColor : 'rgb(215,229,250)',
				borderColor : 'rgb(215,229,250)',
				labels : [ '3일전', '2일전', '1일전', '당일' ],
				datasets : [ {
					label : '일별 매출 추이',
					borderWidth : 2,
					fill : true,
					tension : 0.25,
					data : [
						<%out.println(tirFee[0]);%>
							,
						<%out.println(secFee[0]);%>
							,
						<%out.println(yesFee[0]);%>
							,
						<%out.println(feeArr[0]);%>
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
								<%out.print(feeArr[4]);%>
									,
								<%out.print(feeArr[5]);%>
									,
								<%out.print(feeArr[6]);%>
									,
								<%out.print(feeArr[7]);%>
							],
							backgroundColor : [ 
								'rgb(239,116,110)',
								'rgb(101,179,161)', 
								'rgb(88,133,201)',
								'rgb(246,194,95)' ]
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