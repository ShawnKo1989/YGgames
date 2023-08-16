<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 입구</title>
    <script src="/group5/js/jquery-3.7.0.min.js"></script>
    <script defer src="/group5/js/common.js"></script>
    <script>
		function popUpRoom() {
			let room = document.querySelector('input[name="reservationNo"]').value;
			if(validChk(room)) {
				let address = "room/";
				let options = "width=1000, height=800, top=100, left=800, scrollbars=no, toolbar=no, status=no, menubar=no;";
				window.open(address, "videoChat", options);
				
				let frm = document.querySelector("body form");
				frm.action = address;
				frm.target = "videoChat";
				frm.method = "get";
				frm.submit();
			} else {
				alert("잘못된 입력입니다.");
			}
		}
		function validChk(room) {
			console.log(room);
			const regex = /^[^0-9]/;
			if(regex.test(room)) {
				return false;
			}
			return true;
		}
    </script>
</head>
<body>
    <form onsubmit="popUpRoom(); return false;">
        <input name="reservationNo" type="text" placeholder="예약번호를 입력하세요" required />
        <input type="submit" value="입장" />
    </form>
</body>
</html>
