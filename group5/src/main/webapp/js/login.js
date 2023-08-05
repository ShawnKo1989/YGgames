$(function() {
	$("#submit").click(function(){
		let param = {email:$("#email").val(),pw:$("#pw").val()} //json 형태 (가독성이 좋음)
		$.ajax({
			url : "Login.jsp",
			type : "POST",
			data : param,
			success: function(data) {
				startSessionTimer();
				$("#nav-login").val("");
				$("#nav-login").html(data)
			},
			error : function(e) { 
				alert("서버 오류 :" + e.status)
			}
		})
		return false; //기본이벤트 기능 취소. submit 버튼의 기본 기능 제거
	})
})