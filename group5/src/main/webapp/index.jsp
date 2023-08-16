<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String messageType = (String)request.getAttribute("messageType");
	String messageContent = (String)request.getAttribute("messageContent");
%>
<!DOCTYPE html>
<html>
<head>
	<script>
	let messageType = '<%=messageType%>';
	let messageContent = '<%=messageContent%>';
	if(messageType != 'null' && messageContent != 'null'){
		alert(messageType + " : " + messageContent);
		<%
		request.setAttribute("messageType", null);
		request.setAttribute("messageContent", null);
	%>
	}
	</script>
	<meta charset="UTF-8">
	<title>QKYG게임즈 | 홈페이지</title>
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	
	<script>
	  $(function(){
		    $('.jhSlider').bxSlider({
		    	mode:'horizontal',
		    	controls:true,
		    	captions: true,
				minSlides:3,
			    maxSlides:3,
			    slideWidth:640,
			    ticker:true,
			    tickerHover:true,
			    speed:30000
		    });
		  });
	</script>
<link rel= "stylesheet" href ="css/QkHome.css"/>

</head>
<body>
	<div id = "잠시네비"></div>
	<div class="jhSlider">
		<div id = "robot" class="sliderTransition">
			<div class = "whatMenu">
				<span>SUPPORT</span><br/>
				<a href="/group5/help">
				<button class=aBtn>알아보기</button>
				</a>
			</div>
		</div>
		<div id = "storeImg" class="sliderTransition">
			<div class = "whatMenu">
				<span>STORE</span><br/>
				<a href="../group5/storepage/main.jsp">
					<button class=aBtn>알아보기</button>
				</a>
			</div>
		</div>
		<div id = "twoPeople" class="sliderTransition">
			<div class = "whatMenu">
				<span>REGISTER</span><br/>
				<a href="/group5/signuppage/socialRegister.jsp">
					<button class=aBtn>알아보기</button>
				</a>
			</div>
		</div>
		<div id = "greenMan" class="sliderTransition">
			<div class = "whatMenu">
				<span>COMMUNITY</span><br/>
				<form action="/group5/Controller">
                    <input type="hidden" name="command" value="community"/>
                    <button class=aBtn>알아보기</button>
                </form>
			</div>
		</div>
		<div id = "carImg" class="sliderTransition">
			<div class = "whatMenu">
				<span>LOGIN</span><br/>
				<a href="/group5/signinpage/socialSignin.jsp">
					<button class=aBtn>알아보기</button>
				</a>
			</div>
		</div>
		<div id = "carFight" class="sliderTransition">
			<div class = "whatMenu">
				<span>PC CAFE</span><br/>
				<form action="/group5/Controller">
                    <input type="hidden" name="command" value="pcCafe"/>
<!--                 <a href="CafeSeatsTileArray.jsp"> -->
                    <button class="aBtn">알아보기</button>
<!--                 </a> -->
                </form>
			</div>
		</div>
	</div>
	 <jsp:include page="outframe/BottomFooter.jsp" />
</body>
</html>