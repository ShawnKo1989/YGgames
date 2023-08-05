<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="withdrawal.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<div class="loader"></div>
	<div id="changedbody">
	<div>
		<h3 class="delete_acc_title">계정 삭제</h3>
	</div>
	<div>
		<span>계정 삭제 요청을 클릭하여 모든 개인 정보, 구매 내역, 게임 진행 상황, 인게임 콘텐츠, 언리얼 프로젝트 및 에픽게임즈 지갑 계정을 포함한 에픽게임즈 계정을 영구 삭제하는 절차를 시작합니다. 에픽게임즈 계정이 삭제되고 나면 지갑 잔액도 영구 삭제됩니다. </span>
		<br/>
		<br/>
		<span>계정 삭제를 요청하면 14일 후에 계정이 삭제됩니다. 이 기간 동안 계정에 로그인하여 재활성화할 수 있으며, 이렇게 하면 삭제 요청은 취소됩니다. 14일이 지나면 삭제된 계정을 복구할 수 없습니다.</span>
	</div>
		<div style="margin-top: 30px;">
			<button id="delete_btn" class="delete_btn" onclick="confirm()" >계정 삭제 요청</button>
		</div>
	</div>
</body>
</html>