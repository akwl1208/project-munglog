<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<html>
<head>
<title>멍멍일지</title>
<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!-- fontawesome -->
<script src="https://kit.fontawesome.com/38e579569f.js" crossorigin="anonymous"></script>
<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<!--
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>  -->
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<style type="text/css">
*{padding:0; margin: 0;}
.main{
	width:830px; padding: 50px 20px; display: block;
	}
.side-main{
	width:280px; padding: 50px 10px; display: block;
	}
</style>
</head>
<body>
	<tiles:insertAttribute name="header"/>
	<div class="container clearfix" style="margin-top:136px; min-height:100vh;">
		<div style="display:flex; min-width:1110px;">
			<div class="main">
			 	<tiles:insertAttribute name="body" />
			</div>
			<div class="side-main">
				<tiles:insertAttribute name="mypageMenu" />
			</div>
		</div>
  </div>                                                          
	<tiles:insertAttribute name="footer" />
<script>
	function ajaxPost(async, dataObj, url, success){
		$.ajax({
			async: async,
			type:'POST',
			data: JSON.stringify(dataObj),
			url: "<%=request.getContextPath()%>" + url,
			contentType:"application/json; charset=UTF-8",
			success : function(data){
				success(data)
			}
		});
	}
	
	function ajaxPostData(data, url, func){
		$.ajax({
			async: false,
			type:'POST',
			data: data,
			url: "<%=request.getContextPath()%>" + url,
			processData : false,
			contentType : false,
			dataType: "json",
			success : function(data){
				func(data)
			}
		});		
	}//
</script>
</body>
</html>