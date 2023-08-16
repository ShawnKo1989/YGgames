// WebSocket 연결 설정
const socket = new WebSocket("ws://210.114.1.134:9090/team5/serverHelp");

// 이벤트 리스너 등록
$(window).on("beforeunload", function() {
	// WebSocket 연결 닫기
	socket.close();
});

// 이전 선택된 dateValue와 timeValue 초기화
let previousDateValue = "";
let previousTimeValue = "";

// datePick 값과 timepicker 값 변경 이벤트 리스너 등록
$(document).on("change", "#datePick, .timepicker input", function() {
	sendScheduleToServer();
});

// WebSocket 메시지 수신 이벤트 핸들러 등록
socket.onmessage = function(event) {
	// 서버로부터 받은 메시지 처리
	const sptsString = event.data;
	console.log(sptsString);

	// 문자열을 int[]로 변환
	const spts = sptsString.substring(1, sptsString.length - 1).split(", ").map(Number);
	console.log(spts);

	// 받은 spts를 활용하여 화면 업데이트 작업 수행
	updateScreenWithSpts(spts);
};

// 화면 업데이트 함수
function updateScreenWithSpts(spts) {
	// spts 배열을 활용하여 화면 업데이트 로직 구현
	$("#supporterPicker .supporterpicker").remove();
	let div = document.createElement("div");
	div.className = "supporterpicker";
	for (let i = 1; i <= 4; i++) {
		let label = document.createElement("label");
		let input = document.createElement("input");
		input.setAttribute("name", "supporter");
		input.setAttribute("value", i);
		input.setAttribute("type", "radio");
		input.setAttribute("required", "required");
		if (spts[i - 1] == 1) {
			input.setAttribute("disabled", "disabled");
			label.setAttribute("class", "inactive");
		} else {
			label.setAttribute("class", "clickable");
		}
		label.append(input);
		let img = document.createElement("img");
		img.src = `/team5/media/images/직원사진_${i}.jpeg`;
		label.append(img);
		label.append(`직원${i}`);
		div.append(label);
	}

	$("#supporterPicker").append(div);
}

function showRsvInfo() {
	let rsvno = $("#rsvSearch").val();
	if (rsvno === "") {
		alert("예약번호를 입력하세요");
		return false;
	}
	let address = "rsvChk.jsp";
	let options = "width=600, height=300, top=300, left=600, scrollbars=no, toolbar=no, status=no, menubar=no;";
	window.open(address, "rsvChkForm", options);

	let frm = document.querySelector("#rsvChk");
	frm.action = address;
	frm.target = "rsvChkForm";
	frm.method = "get";
	frm.submit();
}

function sendScheduleToServer() {
	// datePick 값과 timepicker 값 가져오기
	const dateValue = $("#datePick").val();
	const timeValue = $(".timepicker input:checked").val();
	const schedule = dateValue + " " + timeValue;

	// 이전 값과 비교하여 이벤트 실행
	if ((dateValue !== previousDateValue || timeValue !== previousTimeValue)) {
		// 메시지 생성
		const message = {
			schedule
		};
			
		if (scheduleValidChk(schedule)) {
			// WebSocket 서버에 메시지 전송
			socket.send(JSON.stringify(message));
		}

		// 이전 값 업데이트
		previousDateValue = dateValue;
		previousTimeValue = timeValue;
	}
}

function scheduleValidChk(schedule) {
	let pattern = /\d{4}-\d{2}-\d{2} \d{2}/gm;
	return pattern.test(schedule);
}

$(document).on("click", ".picker label", function() {
	if ($(this).find("input").attr("disabled") === "disabled") {
		return false;
	}
	try {
		$(this).parent().parent().find(".checked").removeClass("checked").addClass("clickable");
	} catch (e) {
		console.log(e);
	} finally {
		$(this).addClass("checked").removeClass("clickable");
	}
});
