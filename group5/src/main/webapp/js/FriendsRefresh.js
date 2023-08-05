$(function() {
	// 스크립트 실행 여부 확인
	var scriptExecuted = localStorage.getItem("scriptExecuted");

	// 새로고침 버튼 클릭 이벤트 핸들링
	$(document).on("click", "#friends-refresh", function() {
		executeScript();
	});

	function executeScript() {
		$.ajax({
			url: "Friends.jsp",
			success: function(data) {
				//$("#friend").val("");
				$("#friend").html(data);
				$("#friends-popup").addClass("show");
			},
			error: function(e) {
				alert("서버 오류 :" + e.status);
			}
		});
	}

	// 페이지 새로고침 이벤트 핸들링
	$(window).on("beforeunload", function() {
		// friends-popup-main의 display 속성과 위치 속성 저장
		var popupMain = document.getElementById("friends-popup").getElementsByClassName("friends-popup-main");
		for (var i = 0; i < popupMain.length; i++) {
			var id = popupMain[i].id;
			var display = $("#" + id).css("display");
			var left = $("#" + id).css("left");
			var top = $("#" + id).css("top");
			localStorage.setItem(id + "_display", display);
			localStorage.setItem(id + "_left", left);
			localStorage.setItem(id + "_top", top);
		}

		localStorage.setItem("scriptExecuted", "true");
	});

	// 스크립트 실행 여부에 따라 코드 실행
	if (!scriptExecuted) {
		executeScript();
		localStorage.setItem("scriptExecuted", "true");
	}

	// friends-popup-main의 display 속성과 위치 속성 복원
	var popupMain = document.getElementById("friends-popup").getElementsByClassName("friends-popup-main");
	for (var i = 0; i < popupMain.length; i++) {
		var id = popupMain[i].id;
		var display = localStorage.getItem(id + "_display");
		var left = localStorage.getItem(id + "_left");
		var top = localStorage.getItem(id + "_top");
		$("#" + id).css("display", display);
		$("#" + id).css("left", left);
		$("#" + id).css("top", top);

		// 선택한 버튼에 따라 해당 섹션을 보이거나 숨김
		var buttonId = id + "-btn";
		$("#" + buttonId).on("click", function() {
			var sectionId = $(this).attr("id").replace("-btn", "");
			$(".friends-popup-main").hide();
			$("#" + sectionId).show();
			$(".popup-nav-button").css("background-color", "");
			$(this).css("background-color", "#5a5a5a");
		});
	}
});