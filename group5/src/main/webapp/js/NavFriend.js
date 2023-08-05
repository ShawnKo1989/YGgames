$(function(){
	$(document).on("click", "#nav-login-friend", function (e){
	  $("#friends-popup").addClass("show");
	});
	
	// 외부영역 클릭 시 팝업 닫기
	$(document).mouseup(function (e){
		var LayerPopup = $("#friends-popup");
		if(!LayerPopup.is(e.target) && LayerPopup.has(e.target).length === 0){
			LayerPopup.removeClass("show");
		}
	});
})