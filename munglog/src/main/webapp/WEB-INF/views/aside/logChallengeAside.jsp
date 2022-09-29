<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>side-챌린지</title>
<!-- css ************************************************************ -->
<style>
	.side-main .box-challenge,
	.side-main .box-previous{
		border: 1px solid #52443b; border-radius: 5px; margin-bottom: 50px;
		padding: 20px 10px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
	}
	.side-main .box-challenge .box-period{
		font-size: 24px; font-weight: bold; text-shadow: 2px 2px 3px rgba(73, 67, 60, 0.5);
		margin-bottom: 10px; color: #b86000;
	}
	.side-main .box-challenge .cl_thumb{
		height: 150px; width: 100%; 
		background-size: contain; background-position: center; background-repeat: no-repeat; 
	}
	.side-main .box-previous .title{
		font-size: 18px; font-weight: bold;
		display: inline-block; margin-bottom: 10px;
	}
	.side-main .box-previous .title .fa-paw{}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<div class="box-challenge" style="width: 260px;">
		<div class="box-period mb-2 ml-1">
			<span class="cl_year">${challenge.cl_year}</span>
			<span>.</span>
			<span class="cl_month">${challenge.cl_month}</span>
		</div>
		<div class="cl_thumb mb-2" style="background-image: url('<c:url value="${challenge.cl_thumb_url}"></c:url>')"></div>
		<div class="box-theme p-2">
			<span class="cl_theme">${challenge.cl_theme}</span>
		</div>
	</div>
	<div class="box-previous">
		<div class="form-group m-0">
			<span class="title"><i class="fa-solid fa-paw ml-1 mr-2"></i>지난 챌린지 보기</span>
			<select class="form-control">
				<c:forEach items="${challengeList}" var="challenge">
					<option value="${challenge.cl_num}">${challenge.cl_year}년 ${challenge.cl_month}월</option>
				</c:forEach>
			</select>
		</div>
	</div>
</body>
<!-- script ******************************************************************************************************* -->
<script>

	
/* 함수 *********************************************************************************************************** */
	//  -----------------------------------------------------------------------------------------------------

</script>
</html>