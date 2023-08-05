<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%!// 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String uid = "temp";
	String pwd = "1234";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String sql = "SELECT *" + " FROM game_list ";%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
a {
	text-decoration: none;
}

a:hover {
	color: white;
}

.ka {
	top: 0;
	background-color: transparent;
	width: 100%;
	z-index: 9999;
	display: flex;
	margin-left: 175px;
	width: 100%;
	height: 80px;
}

.category {
	display: inline-block;
	padding: 10px 20px;
	color: gray;
	font-weight: bold;
	transition: background-color 0.3s; /* 배경색 변경에 대한 트랜지션 효과 설정 */
}

#post_searchBox {
	display: flex;
	margin-top: 22px;
}

.category:hover {
	color: white;
}

#post_searchGlass {
	height: 41px;
	background-color: rgb(32, 32, 32);
	width: 38px;
	text-align: center;
	padding-top: 22px;
	border-radius: 20px;
	position: relative;
	right: -135px;
	bottom: 10px;
	width: 75px;
}

.search-item img {
	max-width: 100px; /* 이미지의 최대 너비 설정 */
	max-height: 100px; /* 이미지의 최대 높이 설정 */
}

.categorySpan {
	color: gray;
}

.categorySpan:hover {
	color: white;
}

#dodImg {
	background-color: #202020;
	border-radius: 20px 0 0 20px;
	height: 40px;
	width: 40px;
}

#searchResults {
	position: relative;
	top: -245px;
	left: 138px;
}

#searchInput {
	background-color: #202020;
	border: none;
	color: white;
	height: 40px;
	border-radius: 0 20px 20px 0;
	
}
</style>
</head>
<body>
	<%
		try {
		// 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
		// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection(url, uid, pwd);
		// 쿼리를 생성하는 객체 생성
		stmt = conn.createStatement();
		// 쿼리 실행
		rs = stmt.executeQuery(sql);
	%>

<body>
	<div class="ka">
		<br>
		<div id="post_searchBox">
			<div id="dodImg">
				<img src="images/search.png" alt="돋보기" id="dod" style="margin:8px;"> 
			</div>
			<input type="text" id="searchInput" name="Commu_Search" placeholder="스토어 검색" spellcheck="false" autocomplete="off" class="-input">
		</div>
		<div id="searchResults" class="search-results"></div>
		<div class="category">
			<br>
				<a href = "main.jsp">
					<span class="categorySpan">
						탐색
					</span>
				</a>
		</div>
		<div class="category">
			<br>
			<a href = "NewsMain.jsp">
				<span class="categorySpan">
					찾아보기
				</span>
			</a>
		</div>
		<div class="category">
			<br>
			<a href="Controller?command=news" class="nav-item-links nav-txt-links" tabindex="-1">
                                    새소식
            </a>
		</div>
	</div>
	<script>
		let searchInput = document.getElementById('searchInput');
		let searchResults = document.getElementById('searchResults');
		let visibleResults = 4; // 보여지는 검색 결과 개수

		// 검색어 입력 이벤트 핸들러
		searchInput.addEventListener('input', function() {
			let keyword = this.value;
			showSearchResults(keyword);
		});

		// 검색 결과 표시 함수
		function showSearchResults(keyword) {
			searchResults.innerHTML = '';

			if (keyword.length > 0) {
				// Ajax 요청을 통해 서버로 검색어 전송
				let xhr = new XMLHttpRequest();
				xhr.open('POST', 'SearchServlet.jsp', true);
				xhr.setRequestHeader('Content-Type',
						'application/x-www-form-urlencoded; charset=UTF-8');
				xhr.onreadystatechange = function() {
					if (xhr.readyState === 4 && xhr.status === 200) {
						let matchedResults = JSON.parse(xhr.responseText);
						let resultsCount = Math.min(matchedResults.length,
								visibleResults);

						if (resultsCount > 0) {
							for (let i = 0; i < resultsCount; i++) {
								let item = matchedResults[i];

								let resultElement = document
										.createElement('div');
								resultElement.classList.add('search-item');

								let thumbnail = document.createElement('img');
								thumbnail.src = item.thumbnailImg;
								resultElement.appendChild(thumbnail);

								let titleElement = document
										.createElement('span');
								titleElement.textContent = item.title;
								resultElement.appendChild(titleElement);

								resultElement.addEventListener('click',
										function() {
											searchInput.value = item.title;
											searchResults.innerHTML = '';
										});
								searchResults.appendChild(resultElement);
							}

							if (matchedResults.length > visibleResults) {
								let showMoreLink = document.createElement('a');
								showMoreLink.textContent = '더보기';
								showMoreLink.addEventListener('click',
										function() {
											showAllResults(matchedResults);
										});
								let showMoreDiv = document.createElement('div');
								showMoreDiv.classList.add('show-more');
								showMoreDiv.appendChild(showMoreLink);
								searchResults.appendChild(showMoreDiv);
							}
						} else {
							let noResultsElement = document
									.createElement('div');
							noResultsElement.classList.add('search-no-results');
							noResultsElement.textContent = '검색 결과 없음';
							searchResults.appendChild(noResultsElement);
						}

						searchResults.classList.add('show');
					}
				};
				xhr.send('keyword=' + encodeURIComponent(keyword));
			} else {
				searchResults.classList.remove('show');
			}
		}

		// 모든 검색 결과 표시 함수
		function showAllResults(matchedResults) {
			searchResults.innerHTML = '';

			matchedResults.forEach(function(item) {
				let resultElement = document.createElement('div');
				resultElement.classList.add('search-item');

				let thumbnail = document.createElement('img');
				thumbnail.src = item.thumbnailImg;
				resultElement.appendChild(thumbnail);

				let titleElement = document.createElement('span');
				titleElement.textContent = item.title;
				resultElement.appendChild(titleElement);

				resultElement.addEventListener('click', function() {
					searchInput.value = item.title;
					searchResults.innerHTML = '';
				});
				searchResults.appendChild(resultElement);
			});
		}
	</script>
	<%
		} catch (Exception e) {
	e.printStackTrace();
	} finally {
	// 연결된 객체들을 닫는 작업 수행
	if (rs != null)
		try {
			rs.close();
		} catch (Exception e) {
		}
	if (stmt != null)
		try {
			stmt.close();
		} catch (Exception e) {
		}
	if (conn != null)
		try {
			conn.close();
		} catch (Exception e) {
		}
	}
	%>
	<script>
		function searchGames() {
			let input = document.getElementById('searchInput');
			let filter = input.value;

			let xhr = new XMLHttpRequest();
			xhr.open('GET', 'searchGamesServlet?searchInput='
					+ encodeURIComponent(filter), true); // 서버 요청을 보내는 URL을 적절히 수정하세요
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					let gameItemsContainer = document
							.getElementById('gameItemsContainer');
					gameItemsContainer.innerHTML = xhr.responseText;
				}
			};
			xhr.send();
		}
	</script>
</body>
</html>