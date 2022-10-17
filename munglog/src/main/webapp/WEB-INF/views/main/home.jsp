<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>main - 메인홈</title>
</head>
<style>
	.main .box-challenge,
	.main .box-challenge .link-challenge{
		display:block; width: 760px; height: 285px; border-radius: 10px;
	}
	.main>div .box-header .title{
		font-size: 20px; font-weight: 900;
	}
	.main>div .box-header .link:hover small{color: #fb9600;}
	.main .box-log .list-log,
	.main .box-goods .list-goods{
		display: table; width: 100%; height: 300px; margin-top: 5px;
	}
	.main .box-log .list-log .item-log,
	.main .box-goods .list-goods .item-goods{
		display: inline-block; width: calc(20% - 10px); height: 148px;
		position: relative; overflow: hidden; margin: 5px;
	}
	.main .box-log .list-log .item-log .link-log,
	.main .box-goods .list-goods .item-goods .link-goods{
		width: 100%; height: 100%; display: block; background-position: center center; 
		background-size: cover; border: 1px solid #ececec;
	}
	.main .box-log .list-log .item-log .link-log:hover,
	.main .box-goods .list-goods .item-goods .link-goods:hover{transform: scale(0.9);}
	.main .box-goods .list-goods{height: 150px;}
</style>
<body>
<div class="box-challenge mb-5">
	<a href="<c:url value="/log/challenge"></c:url>" class="link-challenge" style="background-image: url(<c:url value="${challenge.cl_banner_url}"></c:url>)"></a>
</div>
<div class="box-log mb-5">
	<div class="box-header">
		<span class="title mr-3"><i class="fa-solid fa-paw mr-2"></i>월간 인기 일지</span>
		<a href="<c:url value="/log/feed"></c:url>" class="link link-feed"><small>더보기</small></a> 
	</div>
	<ul class="list-log">
		<c:forEach items="${logList}" var="log">
			<li class="item-log">
				<a href="<c:if test="${user != null && (log.lg_mb_num == user.mb_num)}"><c:url value="/log/mylog/${user.mb_num}"></c:url></c:if>
					<c:if test="${user == null || log.lg_mb_num != user.mb_num}"><c:url value="/log/friendlog/${log.lg_mb_num}"></c:url></c:if>" 
				class="link-log" style="background-image: url(<c:url value="${log.lg_image_url}"></c:url>)"></a>
			</li>
		</c:forEach>
	</ul>
</div>
<div class="box-goods">
	<div class="box-header">
		<span class="title mr-4"><i class="fa-solid fa-paw mr-2"></i>인기 굿즈 상품</span>
		<a href="<c:url value="/goods"></c:url>" class="link link-goods"><small>더보기</small></a> 
	</div>
	<ul class="list-goods">
		<c:forEach items="${goodsList}" var="goods">
			<li class="item-goods">
				<a href="<c:url value="/goods/goodsDetail/${goods.gs_num}"></c:url>" class="link-goods" style="background-image: url(<c:url value="${goods.gs_thumb_url}"></c:url>)")"></a>
			</li>
		</c:forEach>
	</ul>
</div>
</body>
</html>
