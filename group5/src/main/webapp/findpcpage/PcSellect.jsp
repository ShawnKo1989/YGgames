<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pc방 찾기</title>
<script src="/group5/js/jquery-3.7.0.min.js"></script>
<link href="/group5/css/PcSellect.css" rel="stylesheet" type="text/css" />
</head>
<body>
<jsp:include page="../outframe/NavBar2.jsp" />
	<div class="outline">
		<div class="selectbar" onclick="location.href='FindGoogle.jsp'">
			<div class="selectLabel">구글 맵(Google map)으로 찾기</div>
		</div>
		<div class="selectbar" onclick="location.href='FindKakao.jsp'">
			<div class="selectLabel">카카오 맵(Kakao map)으로 찾기</div>
		</div>
	</div>
<jsp:include page="../outframe/BottomFooter.jsp" />
</body>
</html>