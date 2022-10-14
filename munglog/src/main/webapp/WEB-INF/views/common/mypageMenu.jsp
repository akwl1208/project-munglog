<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 메뉴</title>
<!-- css ************************************************************************************************************* -->
<style>
	.side-main .menu-admin{
		border: 1px solid #52443b; border-radius: 5px;
		padding: 20px 10px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
	}
	.side-main .menu-admin .box-title{
		color: #402E32; font-size: 18px; font-weight: bold;
		margin: 0 auto; text-align:center;
	}
	.side-main .menu-admin .list-group{text-align: center;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
	<!-- box-profile -------------------------------------------------------- -->
	<div class="menu-admin" style="width: 260px;">
		<div class="box-title mb-3">
			<i class="fa-solid fa-screwdriver-wrench mr-2"></i><span>마이페이지 메뉴</span>
		</div>
		<div class="list-group">
			<h5>일지</h5>
		  <h5 class="mt-2">굿즈</h5>
		  <a href="<c:url value="/mypage/order"></c:url>" class="list-group-item list-group-item-action">주문/배송 조회</a>
		</div>
	</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

</script>
</html>