<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="/group5/js/jquery-3.7.0.min.js"></script>
		<meta charset="UTF-8">
		<title>매출조회</title>
		<script>
		//각 라디오 버튼에 따른 input type호출
			$(document).ready(function() {
				$('#weeks').hide();
				$('#months').hide();

				$("input[name=radio]").change(function() {
					if ($("input[name='radio']:checked").val() == 'inq') {
						$('#cale').show();
						$('#weeks').hide();
						$('#months').hide();
					} else if ($("input[name='radio']:checked").val() == 'week') {
						$('#cale').hide();
						$('#weeks').show();
						$('#months').hide();
					} else if ($("input[name='radio']:checked").val() == 'month') {
						$('#cale').hide();
						$('#weeks').hide();
						$('#months').show();
					}
				});
			});
		</script>
		<script>		//각 input에 따른 정보를 PaymentSelectDate.jsp로 Controller를 통해 정보 전달
			function SB() {
				if ($("input[name='radio']:checked").val() == 'month') {
					const selectedMonth = document.querySelector('#selectMonth').value;
					if (selectedMonth == '') {
						alert("날짜를 입력해주세요");
						return;
					} else {
						$("#search1").attr("href",
								"Controller?command=paymentSelect&selectedMonth=" + selectedMonth);
					}
				} else if ($("input[name='radio']:checked").val() == 'inq') {
					const selectedDate = document.querySelector('#selectDay').value;
					if (selectedDate == '') {
						alert("날짜를 입력해주세요");
						return;
					} else {
						$("#search1").attr("href",
								"Controller?command=paymentSelect&selectedDate=" + selectedDate);
					}
				} else if ($("input[name='radio']:checked").val() == 'week') {
					const firstDate = document.querySelector('#selectFirstDay').value;
					const lastDate = document.querySelector('#selectLastDay').value;
					if (firstDate == '' || lastDate == '') {
						alert("날짜를 입력해주세요");
						return;
					} else {
						$("#search1").attr(
								"href",
								"Controller?command=paymentSelect&selectedSectionDate="
										+ firstDate + "-" + lastDate);
					}
				}
			};
		</script>
		<link rel="stylesheet" href="css/PayMent_inquiry.css" />
	</head>
	<body>
		<div class="top">
			<span>매장분석 조회</span>
		</div>
		<form id="searchB">
			<div class=radioButton>
				<br><input type="radio" name="radio" id="inq" value="inq" style="margin-top: 15px;"> 날짜 지정 <br><br><input type="radio" name="radio" id="week" value="week">구간 지정 <br><br><input type="radio" name="radio" id="month" value="month">월별 매출
			</div>
			<div id="cale">
				<br><input type="date" name="Date" id="selectDay" min="2023-03-01">
			</div>
			<div id="weeks">
				<input type="date" name="Date" id="selectFirstDay" min="2023-03-01"><br><br><input type="date" name="Date" id="selectLastDay" value="" min="2023-03-01">
			</div>
			<div id="months">
				<br><input type="month" name="Date" id="selectMonth" min="2023-03">
			</div>
			<div id=bottomButton>
				<a id="search1" href=""><input type="button" value="조회" id=searchBtn onclick="SB()"></a>
			</div>
		</form>
	</body>
</html>
