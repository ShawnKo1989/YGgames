<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.CafeSeatDTO" %>
<%@ page import = "dao.CafeSeatDAO" %>
<%@ page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<% 
	int[] loginMember = (int[])request.getAttribute("loginMember");
	int[] reserveId = (int[])request.getAttribute("reserveId");
    int[] totalFee = (int[])request.getAttribute("tileFee");
    String[] startTime = (String[])request.getAttribute("startTime");
    String[] endTime = (String[])request.getAttribute("endTime");
    CafeSeatDAO cafeSeatDao = CafeSeatDAO.getInstance();
    // 	List<CafeSeatDTO> seatArr = (List<CafeSeatDTO>)request.getAttribute("seatArr");		 ---> "Type safety"
    ArrayList<?> list1 = (ArrayList<?>)request.getAttribute("seatArr");
    ArrayList<CafeSeatDTO> seatArr = new ArrayList<CafeSeatDTO>();
    for(Object obj : list1){
    	if(obj instanceof CafeSeatDTO)
    		seatArr.add((CafeSeatDTO)obj);
    }
    
    
	int regNo = 0;
	try {
		regNo = (Integer) session.getAttribute("reg_no");
	} catch (NullPointerException e) {
		regNo=0;
	}
	String loginNickname="";
    try{
    	loginNickname=(String)session.getAttribute("nickname");
	} catch(NullPointerException e){
		loginNickname="";
	}
    
%>

<!DOCTYPE html> 
<html>
<head>
	<script src="/group5/js/jquery-3.7.0.min.js"></script>
	<meta charset="UTF-8">
	<title>바둑판식 좌석 배치</title>
	<script>
	let reloading = setInterval(reloadpage,30000);
	function reloadpage(){
		location.reload();
	}
	
	</script>
	
	<script>	//중복 ID의 예약 X 	중복예약 아닐 시 예약확인페이지이동
		$(document).ready(function() {
			$('.conditionTrue').click(function() {
				let seatNumber = $(this).val();
				let regNo = <%=regNo%>;
				if (regNo !== 0) {
					<%
					boolean b = false;
					for(int i=0;i<=loginMember.length-1;i++){
						if(regNo==loginMember[i]){
							b=true;
							break;
						}
					}
					if(b){
					%>
					alert("이미 예약된 ID입니다.");
					<%	
					} else {
					%>
					location.href = "Controller?command=reserveSeat&seatNumber=" + seatNumber;
					<%}%>
				} else {
					alert("로그인이 필요한 서비스입니다.");
				}
			});
		});
	</script>
	
	<link rel="stylesheet" href="/group5/css/CafeSeatsTileArray.css" />
</head>
<body>
	<jsp:include page="/outframe/NavBar2.jsp" />
	<div class="seat">
		<!-- 로그인 안된 좌석  -->
		<%
		for (int i = 0; i <= seatArr.size() - 1; i++) {
			CafeSeatDTO cafe = seatArr.get(i);
			if (cafe.getCondition() == 0) {
		%>
		<button class="conditionTrue" value="<%=i+1%>">
			<div class="seatTop" style="padding-top: 3px; padding-bottom: 3px;">
				&nbsp;<%
				out.println(i + 1);
				%>
			</div>
		</button>
		<%
		} else if (cafe.getCondition() == 1) {
			if (reserveId[i] == 0) {
		%>
		<!-- 비회원 좌석 -->
		<div class="conditionFalse0">
			<div class="seatTop">
				<div class="seatTopItems" style="padding-top: 3px; padding-bottom: 3px;">
					&nbsp;<%
					out.println(i + 1);
					%>
					<span style="float: right;"> 
						비회원
						&nbsp;
					</span> 
					<br/> <br/> 
					<span style="float: right; font-weight: 400;"> <%
					int hour = (int) (Math.random() * 20);
					out.print(hour + ":");
					int minute = (int) (Math.random() * 59);
					if (minute < 10) {
						out.print("0" + minute);
					} else {
						out.print(minute);
					}
					%> 까지&nbsp;
					</span> 
					<br/> 
					<span style="float: right; font-weight: 700;">&#8361; <%
					if (hour == 0) {
						out.print(1);
					} else {
						out.print(hour);
					}
					%>,<%
					if (minute >= 30) {
						out.print(5);
					} else {
						out.print(0);
					}
					%>00원&nbsp;
					</span>
				</div>
			</div>
		</div>
		<%
		} else {
		%>
		<!-- 회원예약 시 좌석 회원 예약정보 -->
		<div class="conditionFalse1">
			<div class="seatTop">
				<div class="seatTopItems" style="padding-top: 3px; padding-bottom: 3px;">
					&nbsp;<%
					out.println(i + 1);		//좌석넘버
					%>
					<span style="float: right;"> <%
					out.print(cafeSeatDao.nickname(reserveId[i]));
					%>&nbsp;
					</span> 
					<br/> <br/> 
					<span style="float: right; font-weight: 400;"> 
					<%=startTime[i]%> 시작&nbsp;
					</span> 
					<br/> 
					<span style="float: right; font-weight: 400; margin-top:10px;"> 
					<%=endTime[i]%> 종료&nbsp;
					<script>
						let seat_num<%=i+1%>=<%=i+1%>
						let endTime<%=i%>='<%=endTime[i]%>';
						let now<%=i%> = new Date();
						let hour<%=i%> = ('0' + now<%=i%>.getHours()).slice(-2);
						let minute<%=i%> = ('0' + now<%=i%>.getMinutes()).slice(-2);
						let nowtime<%=i%> = hour<%=i%> + ':' + minute<%=i%>;
						if(endTime<%=i%>===nowtime<%=i%>){
							$.ajax({
								type: "POST",
								url: "EndTimeCafeSeat",
								data: { 
									seatNum : seat_num<%=i+1%>
								},
								success: function() {
									location.reload();
								},
								error: function(error) {
									alert("오류가 발생했습니다.");
									console.log(error);
								}	
							});
						}
					</script>
					</span> 
					<br/> 
					<p style="font-weight: 700; margin-top:20px; margin-left: 90px;">&#8361; 
					<%=totalFee[i]%>원
					</p>
				</div>
			</div>
		</div>
		<%
		}
		}
		if (i % 10 == 9) {
		%><br>
		<%
		}
		}
		%>
	</div>
	<jsp:include page="/outframe/BottomFooter.jsp" />
</body>
</html>
