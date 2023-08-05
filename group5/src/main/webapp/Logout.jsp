<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
   	try{
	    request.setCharacterEncoding("utf-8");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","temp","1234");
   		Statement stmt = conn.createStatement();
   		String sql2 = "UPDATE member SET connecting = 0 WHERE reg_no = " + session.getAttribute("reg_no");
		stmt.executeUpdate(sql2);
		stmt.close();
		conn.close();
		session = request.getSession(false);
		if (session != null) {
		    session.invalidate();
		%>
		
		<script>
			console.log('세션 종료.');
		</script>
		<%
	  	}
	  	response.setStatus(HttpServletResponse.SC_OK);
   	} catch(Exception e) {
   		e.printStackTrace();
   	}
%>
<div role="button" id="loginBtn" class="nav-login-box" title="로그인">
    <div class="QKYG-icon-user" id="QKYG-icon-user"></div>
    <span class="user-label" id="user-label">로그인</span>
</div>
<div id="login-dropdown" class="login-dropdown" style="display: none;">
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
  	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script defer src="js/login.js"></script>
  	<script defer type="text/javascript">
	var loginBtn = document.getElementById("loginBtn");
	
	loginBtn.onclick = function() {
		location.href = "signin.jsp";
	};
	</script>