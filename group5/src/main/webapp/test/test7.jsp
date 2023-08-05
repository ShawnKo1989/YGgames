<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Progressbar - Custom Label</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <style>
  .ui-progressbar {
    position: relative;
  	margin-top: 10px;
  	width: 222px;
  	height: 111px;
  }
  .progress-label {
    position: absolute;
    left: 50%;
    top: 4px;
    font-weight: bold;
    text-shadow: 1px 1px 0 #fff;
  }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
	  $(function() {
		let i = 1;
	    var progressbar = $( "#progressbar"+i),
	      progressLabel = $( ".progress-label" );
	 
	    function progress() {
		  progressbar.progressbar({});
	      var val = progressbar.progressbar( "value" ) || 0;
	      progressbar.progressbar( "value", val + 2 );
	 
	      if ( val < 99 ) {
	        setTimeout( progress, 50 );
	      } 
	      if(val >= 100){
	    	i++;
	    	if(i>5){i=1}
	    	progressbar.progressbar( "value", 0 );
	    	progressbar = $( "#progressbar"+i);
	       	setTimeout( progress, 50 );
	      }
	    }
	    setTimeout( progress, 1000 );
	  });
  </script>
</head>
<body>
 
<div id="progressbar1"><div class="progress-label"></div></div>
<div id="progressbar2"><div class="progress-label"></div></div>
<div id="progressbar3"><div class="progress-label"></div></div>
<div id="progressbar4"><div class="progress-label"></div></div>
<div id="progressbar5"><div class="progress-label"></div></div>
 
 
</body>
</html>