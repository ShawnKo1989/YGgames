
$(function() {
	$(document).on("change", "#tmpDrop", function() {
		const tmpDrop = document.querySelector("#tmpDrop");
		const attFiles = tmpDrop.files;

		let attachments = document.querySelector("#attachments");

		let newFiles = new DataTransfer();
		for (let existenceFiles of attachments.files) {
			newFiles.items.add(existenceFiles);
		}
		for (let tmpF of attFiles) {
			newFiles.items.add(tmpF);
		}
		attachments.files = newFiles.files;

		// 이미지 미리보기 초기화
		for (let f of document.querySelectorAll("#attachList .attachListItem img")) {
			URL.revokeObjectURL(f.src);
		}
		$("#attachList").empty();

		for (let f of attachments.files) {
			let li = document.createElement("li");
			li.className = "attachListItem";

			// 파일 이름 표시
			let fileName = document.createElement("span");
			fileName.textContent = f.name;
			li.append(fileName);

			// 이미지 파일의 경우 링크 생성
			if (f.type.startsWith("image/")) {
				const src = URL.createObjectURL(f);
				let img = document.createElement("img");
				img.src = src;
				li.append(img);
			} else if (f.type.startsWith("video/")) {
				const src = URL.createObjectURL(f);
				let video = document.createElement("video");
				video.src = src;
				video.setAttribute("muted", "muted");
				video.setAttribute("loop", "loop");
				video.setAttribute("autoplay", "autoplay");
				video.setAttribute("controls", "controls");
				li.append(video);
			}

			$("#attachList").append(li);
		}
	});
	$(document).on("click", ".attachListItem", function() {
		const index = $(this).index();
		const fileName = $(this).find("span").text();
		if(!confirm(`${index} 번째 첨부파일 '${fileName}'의 첨부를 취소하시겠습니까?`)){
			return false;
		}

		// #attachments.files에서 해당 파일을 제거
		let updatedFiles = new DataTransfer();
		let attachments = document.querySelector("#attachments");
		let tmpI = 0;
		for (let f of attachments.files) {
			if (tmpI === index) {
				tmpI++;
				continue;
			}
			updatedFiles.items.add(f);
			tmpI++;
		}
		attachments.files = updatedFiles.files;

		$(this).remove(); // 해당 목록 항목을 제거
	});

});
function popUpChat() {
	let address = `chat/?room=${id}`;
	let options = "width=450, height=650, top=100, left=600, scrollbars=no, toolbar=no, status=no, menubar=no;";
	window.open(address, "chatCont", options);
}
function quit() {
	if (confirm(`진짜 취소하시겠습니까?`)) {
		goHelp();
	} else {
		return false;;
	}
}
