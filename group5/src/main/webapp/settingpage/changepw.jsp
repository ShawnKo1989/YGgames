<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="group5/js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<div class="loader"></div>
	<div id="changedbody">
	<form action="/group5/Controller" method="post">
	<input type="hidden" name="command" value="UserPwChangeAction">
		<h2 id="top_title">비밀번호 변경</h2>
		<div class="top_sub"><span>보안을 위해 비밀번호는 다른 온라인 계정에서 사용하지 않는 고유한 것을 사용하길 권장합니다.</span></div>
		<h6 class="nowuse_title">현재 비밀번호</h6>
		<div class="pwinput_box"><input type="password" class="pwinput" id="pwinput1" name="originalPw" required/><label for="pwinput1">현재 비밀번호</label><img src="/group5/images/showpw.png" id="show_btn1" class="show_btn" style="float:right;"/></div>
		<h6 class="newuse_title">새 비밀번호</h6>
		<div class="pwinput_box"><input type="password" class="pwinput" id="pwinput2" name="newUserPw1" required/><label for="pwinput2">새 비밀번호</label><img src="/group5/images/showpw.png" id="show_btn2" class="show_btn" style="float:right;"/></div>
		<ul class="pw_exp">
			<li>최근에 사용한 비밀번호 5개는 사용할 수 없습니다.</li>
			<li>7자 이상 사용</li>
			<li>최소 1개 이상의 문자 사용</li>
			<li>최소 1개 이상의 숫자 사용</li>
			<li>공백 금지</li>
		</ul>
		<div class="pwinput_box"><input type="password" class="pwinput" id="pwinput3" name="newUserPw2" required/><label for="pwinput3">새 비밀번호 재입력</label><img src="/group5/images/showpw.png"  id="show_btn3" class="show_btn" style="float:right;"/></div>
		<input type="submit" class="pwch_btn" value="변경사항 저장"/>
	</form>
		<div style="width: 795px; height: 50px; border-top: 1px solid rgba(20, 20, 20, 0.16)">
			<h3 class="logout_title">전체 로그아웃</h3>
		</div>
		<div class="logout_sub">
			<span>브라우저, 전화, 콘솔, 기타 기기 등 다른 곳에서 사용 중인 에픽게임즈 계정을 로그아웃하세요.</span>
		</div>
		<form action="/group5/Controller" method="post">
		<input type="hidden" name="command" value="AllSessionLogoutAction">
		<div style="margin-top: 40px;">
			<button id="logout_session">다른 세션에서 로그아웃</button>
		</div>
		</form>
		
	</div>
</body>
</html>