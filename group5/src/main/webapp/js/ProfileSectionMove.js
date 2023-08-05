$(function() {
	$("#mytitle").click(function(){
		$.ajax({
			url : "MyTitle.jsp",
			success: function(data) {
				$("#profile-main").val("");
				$("#profile-main").html(data)
			},
			error : function(e) { 
				alert("서버 오류 :" + e.status)
			}
		})
		return false; //기본이벤트 기능 취소. submit 버튼의 기본 기능 제거
	})
	$("#community").click(function(){
		$.ajax({
			url : "Community.jsp",
			success: function(data) {
				$("#profile-main").val("");
				$("#profile-main").html(data)
			},
			error : function(e) { 
				alert("서버 오류 :" + e.status)
			}
		})
		return false; //기본이벤트 기능 취소. submit 버튼의 기본 기능 제거
	})
	$("#reward").click(function(){
		let rno = {rno:$("#my-room-rno").text()}
		$.ajax({
			url : "Reward.jsp",
			type : "POST",
			data : rno,
			success: function(data) {
				$("#profile-main").val("");
				$("#profile-main").html(data)
			},
			error : function(e) { 
				alert("서버 오류 :" + e.status)
			}
		})
		return false; //기본이벤트 기능 취소. submit 버튼의 기본 기능 제거
	})
	$(document).on("click", "#friends", function (e){
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