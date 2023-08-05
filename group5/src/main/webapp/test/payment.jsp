<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
    <script type="text/javascript" src="js/jquery-3.7.0.min.js" ></script>
    <!-- iamport.payment.js -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script>
        var IMP = window.IMP; 
        IMP.init("imp87610824"); 
    
        function requestPay() {
            IMP.request_pay({
                pg : 'kcp',
                pay_method : 'card',
                merchant_uid: "ORD20180332RS-0000011", 
                name : '당근 10kg',
                amount : 1004,
                buyer_email : 'Iamport@chai.finance',
                buyer_name : '포트원 기술지원팀',
                buyer_tel : '010-1234-5678',
                buyer_addr : '서울특별시 강남구 삼성동',
                buyer_postcode : '123-456'
            }, function (rsp) { // callback
            	if (rsp.success) {
                    alert("결제창 호출 성공");
                } else {
                    alert("뭔가 잘못됐음.");
                }
            });
        }
    </script>
</head>
<body>
	<button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->
</body>
</html>