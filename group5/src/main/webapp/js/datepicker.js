$(function() {
	$("#datepicker").datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		showButtonPanel: true,
		changeMonth: true,
		changeYear: true,
		minDate: 1,
		maxDate: "+1Y",
		autoSize: true,
		dateFormat: "yyyy-mm-dd",
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 요일의 한글 형식.
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월',
			'7월', '8월', '9월', '10월', '11월', '12월'],
		onSelect: function(date) {
			date = date.slice(4);
			$("#datePick").val(date);
			sendScheduleToServer();
		},
		showMonthAfterYear: true
	});
});
$(document).ready(function() {
	let tomorrow = new Date();
	tomorrow.setDate(tomorrow.getDate() + 1);

	let year = tomorrow.getFullYear();
	let month = (tomorrow.getMonth() + 1).toString().padStart(2, "0");
	let day = tomorrow.getDate().toString().padStart(2, "0");

	let tomorrowDateString = `${year}-${month}-${day}`;

	$("#datePick").val(tomorrowDateString);
});