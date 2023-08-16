function searching(search, resultStyle, category, total, page) {
	location.href = "?command=search&category=" + category + "&search=" + search + "&resultStyle=" + resultStyle + "&total=" + total + "&page=" + page;
}

function request_one_page() {
	let resultStyle = 'getMoreList'
	page++;

	$.ajax({
		type: 'get',
		url: ("/team5/ControllerHelp?command=search&category=" + category + "&search=" + search + "&resultStyle=" + resultStyle + "&total=" + total + "&page=" + page),
		dataType: 'json',
		success: function(dataList) {
			for (let data of dataList) {
				let title = document.createElement("div");
				title.className = "link-title";
				title.append(data.title);

				let articleLink = document.createElement("a");
				articleLink.className = "articleList_item_link";
				articleLink.setAttribute("href", `/team5/	help/search/faqDetail/?command=viewFaq&fno=${data.fno}`);
				articleLink.append(title);

				let article = document.createElement("li");
				article.className = "articleList_item";
				article.append(articleLink);
				
				$("#article_list_wrap").find(`ul`).append(article);
			}
		},
		error: function(r, s, e) {
			alert('error!');
		}
	});
}

$(function() {
	$(document).on("click", ".btn_cat", function() {
		let category = $(this).val();
		searching(search, resultStyle, category, total, page);
	});
	$(document).on("change", "#resultFormType", function() {
		let page = 1;
		let resultStyle = $("#resultFormType").val();
		searching(search, resultStyle, category, total, page);
	});
	$(window).scroll(function() {
		if (resultStyle === `list`) {
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				request_one_page();
			}
		}
	});
});