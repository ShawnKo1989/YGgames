<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int seatNum = (int)request.getAttribute("seatNumber");

	String nickname = "";
	
	if((String)session.getAttribute("userNickname")!=null)
	    nickname = (String)session.getAttribute("userNickname");
	int reg_no = 0;
	if (session.getAttribute("reg_no") != null) {
        reg_no = (Integer)session.getAttribute("reg_no");
    } else{
    	reg_no=0;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <script src="jq/jquery-3.7.0.min.js"></script>
    <meta charset="UTF-8">
    <title>PC방 좌석예약 결제시스템</title>

    <script>		//각 버튼 클릭 시 라디오버튼같은 효과로 중복체크 X
        function likeRadio(button) {
            let isActive = button.classList.contains("active");
            let activeButtons = document.getElementsByClassName("rateInfo active");
            let feeValueText = button.querySelector(".rateInfoBottom").textContent;
            let feeValue = parseInt(feeValueText.replace(/[^0-9]/g, ""));
            document.getElementById("showFeeValue").textContent = feeValue + "원";
            for (let i = 0; i < activeButtons.length; i++) {
                activeButtons[i].classList.remove("active");
            }
            if (!isActive) {
                button.classList.add("active");
            } else {
                document.getElementById("showFeeValue").textContent = "0원";
            }
        }
    </script>

    <script>	//좌석예약 시스템
        $(document).ready(function () {
            $('#payBtn').click(function () {
                let feeVal = parseInt($('#showFeeValue').text().replace(/[^0-9]/g, ""));
                let reg_no = <%=reg_no%>
                let seat_num = <%=seatNum%>
                if (feeVal === 0) {
                    alert("금액권을 선택해 주세요.");
                } else {
                    alert("선택하신 금액권은 " + feeVal + "원 요금제 입니다!");

                    $.ajax({
                        type: "POST",
                        url: "UpdateCafeUser",
                        data: {
                            feeValue: feeVal,
                            reg_no: reg_no,
                            seatNum: seat_num
                        },
                        success: function () {
                            alert("등록되었습니다!");
                            location.href = "Controller?command=pcCafe";
                        },
                        error: function (request, status, error) {
                            alert("오류가 발생했습니다.");
                            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }
                    });
                }
            });
        });

    </script>

    <link rel="stylesheet" href="css/CafeSeatsReservePay.css">
</head>
<body>
<jsp:include page="NavBar2.jsp" />
<div id="topBar">
    <div id="info">
        <span>안녕하세요. 사용할 요금제를 선택하세요.</span>
    </div>
    <div id="showSeatNum">
        <span style="float:left;"><%=nickname %>님</span>
        <span style="float:right;"><%=seatNum %>번 좌석</span>
    </div>
</div>
<div id="mainBox">

    <div id="showFee">
        <div id="radioBox">
            <label>
                <input type="radio" id="memberFee" name="fee_kind" value="회원" checked/>
                <span class="radioSpan" style="padding-right:100px;">회원요금</span>
            </label>
            <label>
                <input type="radio" id="nonMemberFee" name="fee_kind" value="비회원"/>
                <span class="radioSpan">회원요금</span>
            </label>
        </div>
        <div id="feeGather">
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">1,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(01:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">1,000원</span>
            </button>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">2,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(02:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">2,000원</span>
            </button>
            <br/>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">3,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(03:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">3,000원</span>
            </button>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">4,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(04:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">4,000원</span>
            </button>
            <br/>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">5,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(5:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">5,000원</span>
            </button>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">6,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(6:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">6,000원</span>
            </button>
            <br/>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">8,000원 요금</span><br/><br/>
                <span class="rateInfoMiddle">(8:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">8,000원</span>
            </button>
            <button class="rateInfo" onclick="likeRadio(this)">
                <span class="rateInfoTop">10000원요금</span><br/><br/>
                <span class="rateInfoMiddle">(10:00)</span><br/><br/><br/>
                <span class="rateInfoBottom">10,000원</span>
            </button>
        </div>
    </div>
    <div id="choosePayTool">
        <p id="TagQKYG">Q K Y G</p>
        <img src="images/쿼카.jpg" class="qkImg"style="width:450px"/>
        <p id="showFeeValue">0원</p>
        <button id="payBtn">결제</button>
    </div>
</div>
<jsp:include page="BottomFooter.jsp" />
</body>
</html>
