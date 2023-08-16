$(function() {
	$(".goHelp").click(function() {
		goHelp();
	});
});

function unrealized() {
	alert("아직 준비중입니다.");
	return false;
}
function goHelp() {
	location.href = "/team5/help";
}