<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="jdbc.User" %>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- /jquery1/src/main/webapp/jqueryajax/ajax2-1.jsp -->
<%	
	String userNickname = (String)session.getAttribute("userNickname");
	User user = new User();
	user.setNickname(userNickname);
	request.setCharacterEncoding("utf-8");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","temp","1234");
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	session.setAttribute("email", email);
	String sql = "select * from member where email = ? and pw = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,email);
	pstmt.setString(2,pw);
	ResultSet rs = pstmt.executeQuery();
	if(session.getAttribute("reg_no")==null){
		if (rs.next()) {
			session.setAttribute("reg_no", rs.getInt("reg_no"));
			session.setAttribute("nickname", rs.getString("nickname"));
			session.setAttribute("userPw", rs.getString("pw"));
			String sql2 = "UPDATE member SET connecting = 1 WHERE reg_no = " + rs.getInt("reg_no");
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(sql2);
			stmt.close();
%>
<div class="dropdown">
<div role="button" id="loginBtn" class="nav-login-box" title="로그인">
    <span class="user-label" id="user-label"><%=user.getNickname()%>님</span>
</div>
	<ul role="menu">
		<li id="myroom-button">
			<a class="text-color-nonactive" role="menuitem" id="myroom" data-index="0">
				<span>마이룸</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/account/rewards?productName=epicgames&amp;lang=ko" role="menuitem" id="dropdown-link-epicRewards" data-index="1">
				<span>에픽 리워드</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/account/payments?productName=epicgames&amp;lang=ko" role="menuitem" id="dropdown-link-epicWallet" data-index="2">
				<span>에픽 지갑</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/inventory/coupons" role="menuitem" id="dropdown-link-coupons" data-index="3">
				<span>상품권</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/account?productName=epicgames&amp;lang=ko" role="menuitem" id="dropdown-link-accountInfo" data-index="4">
				<span>계정</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/redeem" role="menuitem" id="dropdown-link-redeem" data-index="5">
				<span>코드 사용</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/wishlist" role="menuitem" id="dropdown-link-wishlist" data-index="6">
				<span>위시리스트</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" role="menuitem" id="log-out">
				<span>로그아웃</span>
			</a>
		</li>
	</ul>
</div>
<script defer src="js/myroom.js"></script>
<script defer src="js/logout.js"></script>
<script>
	var friend = document.getElementById("nav-login-friend");
	friend.style.display = "block";
</script>
<%
		} else {
%>
<script>
alert('아이디 혹은 비밀번호가 일치하지 않습니다.');
</script>
<div role="button" id="loginBtn" class="nav-login-box" title="로그인">
    <div class="QKYG-icon-user" id="QKYG-icon-user"></div>
    <span class="user-label" id="user-label">로그인</span>
</div>
<div id="login-dropdown" class="login-dropdown" style="display: block;">
	<div class="form-box">
		<div style="opacity: 1; transform: none;">
			<div class="QKYG-login-logo">
				<div class="login-logo-box">
					<div class="QKYG-logo login" aria-label="QKYG Games"></div>
				</div>
			</div>
			<form class="login-form" method="post" id="login-form">
				<label class="login-label MuiFormLabel-root MuiInputLabel-root MuiInputLabel-formControl MuiInputLabel-animated MuiInputLabel-shrink MuiInputLabel-outlined Mui-error Mui-error MuiFormLabel-filled" id="email-label" for="email" data-shrink="true">이메일 주소</label>
				<div class="input-box">
			    	<input id="email" class="login-input" type="text" placeholder="이메일" name="email">
				</div>
				<label class="login-label MuiFormLabel-root MuiInputLabel-root MuiInputLabel-formControl MuiInputLabel-animated MuiInputLabel-shrink MuiInputLabel-outlined Mui-error Mui-error MuiFormLabel-filled" id="password-label" for="password" data-shrink="true">비밀번호</label>
				<div class="input-box">
		        	<input id="pw" class="login-input" type="password" placeholder="비밀번호" name="pw">
				</div>
      			<button class="login-submit" type="submit" id="submit">로그인</button>
		    </form>
	    </div>
	</div>
  	</div>
<script defer src="js/login.js"></script>
  	<script defer type="text/javascript">
	
	loginBtn.onclick = function() {
		location.href = "socialSignin.jsp";
	};
</script>
<%
		}
%>
<%
	} else {
%>
<script>
	var friend = document.getElementById("nav-login-friend");
	friend.style.display = "block";
</script>
<div class="dropdown">
<div role="button" id="loginBtn" class="nav-login-box" title="로그인">
    <span class="user-label" id="user-label"><%=user.getNickname() %>님</span>
</div>
	<ul role="menu">
		<li id="myroom-button">
			<a class="text-color-nonactive" role="menuitem" id="myroom" data-index="0">
				<span>마이룸</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/account/rewards?productName=epicgames&amp;lang=ko" role="menuitem" id="dropdown-link-epicRewards" data-index="1">
				<span>에픽 리워드</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/account/payments?productName=epicgames&amp;lang=ko" role="menuitem" id="dropdown-link-epicWallet" data-index="2">
				<span>에픽 지갑</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/inventory/coupons" role="menuitem" id="dropdown-link-coupons" data-index="3">
				<span>상품권</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/account?productName=epicgames&amp;lang=ko" role="menuitem" id="dropdown-link-accountInfo" data-index="4">
				<span>계정</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/redeem" role="menuitem" id="dropdown-link-redeem" data-index="5">
				<span>코드 사용</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" href="/ko/wishlist" role="menuitem" id="dropdown-link-wishlist" data-index="6">
				<span>위시리스트</span>
			</a>
		</li>
		<li>
			<a class="text-color-nonactive" role="menuitem" id="log-out">
				<span>로그아웃</span>
			</a>
		</li>
	</ul>
</div>
<script defer src="js/myroom.js"></script>
<script defer src="js/logout.js"></script>
<%
	}
	rs.close();
	pstmt.close();
	conn.close();
%>
