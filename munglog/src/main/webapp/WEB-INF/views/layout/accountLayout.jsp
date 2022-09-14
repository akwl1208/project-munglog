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
<!-- validate -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<style type="text/css">
</style>
</head>
<body>
	<tiles:insertAttribute name="body" />                                                         
</body>
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
</html>