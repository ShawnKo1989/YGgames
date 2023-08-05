$(function() {
		$("#submit").click(function(){
//			let param = "id=" + $("#id").val() + "&pass=" + $("#pass").val()
			let param = {email:$("#email").val(),pw:$("#pw").val()} //json 형태 (가독성이 좋음)
			$.ajax({
				url : "ajax2-1.jsp",
				type : "POST",
				data : param,
				success: function(data) {
					$("#nav-login").val("");
					$("#nav-login").html(data)
				},
				error : function(e) { 
					alert("서버 오류 :" + e.status)
				}
			})
			return false; //기본이벤트 기능 취소. submit 버튼의 기본 기능 제거
		})
		$("#btn").click(function(){
			$.ajax({
				url : "ajax2-2.jsp",
				type : "POST",
				data : {email:$("#email").val()},
				success: function(data) {
					$("#message").html(data)
					//h1태그의 class속성값이 find?
					if($("h1").is(".find")) {
						$("#email").val(""); //이메일 입력값을 내용을 지우기 (value값 초기화)
					}
				},
				error : function(e) { 
					alert("서버 오류 :" + e.status)
				}
			})
			return false;
		})
	})