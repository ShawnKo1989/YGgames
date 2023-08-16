$(function() {
	$("#mytitle").click(function() {
		$(this).css("color", "#FFFFFF");
		$("#community").css("color", "#A0A4B4");
		$("#reward").css("color", "#A0A4B4");
		$("#friends").css("color", "#A0A4B4");
	});

	$("#community").click(function() {
		$("#mytitle").css("color", "#A0A4B4");
		$(this).css("color", "#FFFFFF");
		$("#reward").css("color", "#A0A4B4");
		$("#friends").css("color", "#A0A4B4");
	});

	$("#reward").click(function() {
		$("#mytitle").css("color", "#A0A4B4");
		$("#community").css("color", "#A0A4B4");
		$(this).css("color", "#FFFFFF");
		$("#friends").css("color", "#A0A4B4");
	});
});
