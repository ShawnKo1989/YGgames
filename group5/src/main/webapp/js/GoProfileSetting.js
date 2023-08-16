$(function() {
	$("#profile-edit").click(function(){
		$.ajax({
			url : "profileSetting.jsp",
			success: function(data) {
				$("#body").val();
				$("#body").html(data);
			},
			error : function(e) { 
				alert("서버 오류 :" + e.status);
			}
		})
		return false; //기본이벤트 기능 취소. submit 버튼의 기본 기능 제거
	})
})