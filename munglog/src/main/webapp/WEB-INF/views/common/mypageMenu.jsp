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
	.side-main .menu-admin .box-title .fa-house{line-height:24px;}
	.side-main .menu-admin .list-group{text-align: center;}
	.side-main .menu-admin .list-group .list-group-item{padding: 0.5rem 1.25rem;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
	<!-- box-profile -------------------------------------------------------- -->
	<div class="menu-admin" style="width: 260px;">
		<div class="box-title mb-3">
			<a href="<c:url value="/mypage"></c:url>" class="link-mypage">
				<i class="fa-solid fa-house mr-2"></i><span>마이페이지</span>
			</a>
		</div>
		<div class="list-group">
			<strong class="mb-2">계정</strong>
			<a href="<c:url value="/mypage/modifyAccount"></c:url>" class="list-group-item list-group-item-action">회원정보 수정</a>
			<a href="<c:url value="/mypage/modifyProfile"></c:url>" class="list-group-item list-group-item-action">프로필 수정</a>
			<a href="<c:url value="/mypage/point"></c:url>" class="list-group-item list-group-item-action">포인트 내역</a>
			<strong class="mt-2 mb-2">일지</strong>
			<c:if test="${dogList.isEmpty()}">
				<a href="<c:url value="/mypage/registerDog"></c:url>" class="list-group-item list-group-item-action">강아지 정보 등록</a>
			</c:if>
			<c:if test="${!dogList.isEmpty()}">
				<a href="<c:url value="/mypage/modifyDog"></c:url>" class="list-group-item list-group-item-action">강아지 정보 수정</a>
			</c:if>
		  <strong class="mt-2 mb-2">굿즈</strong>
		  <a href="<c:url value="/mypage/order"></c:url>" class="list-group-item list-group-item-action">주문/배송 조회</a>
		</div>
	</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

</script>
</html>