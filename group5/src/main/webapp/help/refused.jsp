<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동작 거절</title>
</head>
<body style="text-align: center;">
	<h1>요청이 거절되었습니다.</h1>
	<h3>5초 뒤 창이 닫힙니다.</h3>
	<script>
		setTimeout(function() {
			window.close();
		}, 5000);
	</script>
</body>
</html>