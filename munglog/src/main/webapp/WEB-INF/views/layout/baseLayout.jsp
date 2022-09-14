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
<style type="text/css">
*{padding:0; margin: 0;}
.main{
	width:830px; padding: 20px; display: block;
	}
.side-main{
	width:280px; padding: 20px; display: block;
	}
</style>
</head>
<body>
	<tiles:insertAttribute name="header"/>
	<div class="container clearfix" style="margin-top:101px;">
		<div style="display:flex; min-width:1110px;">
			<div class="main" style="min-height:1000px;">
			 	<tiles:insertAttribute name="body" />
			</div>
			<div class="side-main">
				<tiles:insertAttribute name="aside" />
			</div>
		</div>
  </div>                                                          
	<tiles:insertAttribute name="footer" />
</body>
</html>