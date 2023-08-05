
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="button" id="naverPayBtn" value="네이버페이 결제 버튼">
<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
<script>

    var oPay = Naver.Pay.create({ //SDK Parameters를 참고 바랍니다.
          "mode" : "{#_mode}",
          "clientId": "{#_clientId}",
          "chainId" : "{#_chainId}"
    });

    //직접 만드신 네이버페이 결제버튼에 click Event를 할당하세요
    var elNaverPayBtn = document.getElementById("naverPayBtn");

    elNaverPayBtn.addEventListener("click", function() {
        oPay.open({ // Pay Reserve Parameters를 참고 바랍니다.
          "merchantUserKey": "{#_merchantUserKey}",
          "merchantPayKey": "{#_merchantPayKey}",
          "productName": "{#_productName}",
          "totalPayAmount": "10000",
          "taxScopeAmount": "100000",
          "taxExScopeAmount": "100000",
          "returnUrl": "{#_returnUrl}"
        });
    });

</script>
</body>
</html>