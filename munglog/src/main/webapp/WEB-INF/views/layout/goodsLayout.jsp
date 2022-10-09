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
<!-- 우편번호 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 아임포트 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">
*{padding:0; margin: 0;}
.main{
	width:100%; padding: 50px; display: block; min-width: 1100px;
}
</style>
</head>
<body>
	<tiles:insertAttribute name="header"/>
	<div class="container" style="margin-top:136px; min-height:100vh;">
		<div class="main">
		 	<tiles:insertAttribute name="body" />
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
</script>
</body>
</html>