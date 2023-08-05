<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.7.0.min.js"></script>
<style>
*{margin:0; padding:0;}
a{text-decoration:none;}
.wrap{padding:10px;}

.btn_open{
font-weight:bold; 
margin:5px; 
padding:4px 6px; 
background:#000; 
color:#fff;
}
.pop_wrap{
position:fixed; 
top:0; left:0; right:0; bottom:0; 
background:rgba(0,0,0,.5); 
font-size:0; 
text-align:center;
}
.pop_wrap:after{
display:inline-block; 
height:100%; 
vertical-align:middle; 
content:'';
}
.pop_wrap .pop_inner{
display:inline-block; 
padding:20px 30px; 
background:#fff; 
width:200px; 
vertical-align:middle; 
font-size:15px;
}
</style>
<script>
var target = document.querySelectorAll('.btn_open');
var btnPopClose = document.querySelectorAll('.pop_wrap .btn_close');
var targetID;

// 팝업 열기
for(var i = 0; i < target.length; i++){
  target[i].addEventListener('click', function(){
    targetID = this.getAttribute('href');
    document.querySelector(targetID).style.display = 'block';
  });
}

// 팝업 닫기
for(var j = 0; j < target.length; j++){
  btnPopClose[j].addEventListener('click', function(){
    this.parentNode.parentNode.style.display = 'none';
  });
}
</script>
</head>
<body>
<div class="wrap">
  <a href="#pop_info_1" class="btn_open">팝업 열기1</a>
  <a href="#pop_info_2" class="btn_open">팝업 열기2</a>


  <div id="pop_info_1" class="pop_wrap" style="display:none;">
    <div class="pop_inner">
      <p class="dsc">팝업 안내문구 입니다.</p>
      <button type="button" class="btn_close">닫기</button>
    </div>
  </div>

  <div id="pop_info_2" class="pop_wrap" style="display:none;">
    <div class="pop_inner">
      <p class="dsc">팝업 안내문구 입니다222.</p>
      <button type="button" class="btn_close">닫기</button>
    </div>
  </div>
</div>

</body>
</html>