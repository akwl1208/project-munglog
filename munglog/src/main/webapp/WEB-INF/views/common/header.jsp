<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title></title>
	<!-- style-------------------------------------------------------- -->
	<style>
		*{padding: 0; margin: 0;}
		a{text-decoration: none; color: #52443b;}
		a:hover{text-decoration: none; color: #52443b;}
		ul,li{list-style-type: none; color: #52443b;}
		.fixed-top{
			background-color: white; box-shadow: 0 1px 3px 0 rgba(73, 67, 60, 0.2);
			min-width : 500px;
		}
		.box-menu{display: flex;}
		.account-list{
			text-align: right; margin-top: 10px;
		}
		.account-list>li{
			display: inline-block; font-size: 12px;
		}
		.account-list>li:last-child::before{
			display: inline-block; content: ''; margin: 0 6px 3px;
			width: 1px; height: 12px; background-color: #b9ab9a;
			vertical-align: middle;
		}
		.nickname{line-height: 24px;}
		.nickname .fa-dog{color: #fb9600; margin-right: 6px;}
		.nickname::after{
			display: inline-block; content: ''; margin: 0 6px 6px;
    	width: 3px; height: 3px; border-radius: 50%; background-color: #b9ab9a;
    	vertical-align: middle;
		}
		.box-menu{text-align: right; padding: 10px 0 20px;}
		.logo{
			font-size: 24px; font-weight: 900; text-align: left;
			line-height: 45px; padding-left: 20px;
		}
		.logo .fa-paw{margin-right: 6px;}
		.menu-list{margin: auto;}
		.menu-list>li{
			display: inline-block; font-size: 18px; font-weight: bold;
			margin-left: 40px;
		}
		.menu-list a:hover{color: #fb9600;}
		.dropdown{margin: auto 0;}
		.all-menu{
			display: inline-block; font-size: 18px; font-weight: bold;
			margin-left: 40px;
		}
		.dropdown-menu{background-color: #fff7ed; margin-top: 34px}
	</style>
</head>
<body>
	<nav class="fixed-top">
		<div class="container">
			<!-- box-account -------------------------------------------------------- -->
			<div class="box-account">
				<ul class="account-list">
					<!-- 비회원일 때 -------------------------------------------------------- -->
					<c:if test="${user == null}">
						<li class="account-item">
							<a href="<c:url value="/account/signup"></c:url>" class="account-link">회원가입</a>
						</li>
						<li class="account-item">
							<a href="<c:url value="/account/login"></c:url>" class="account-link">로그인</a>
						</li>
					</c:if>
					<!-- 회원일 때 -------------------------------------------------------- -->
					<c:if test="${user != null}">
						<li class="account-item nickname">
							<span><i class="fa-solid fa-dog"></i>${user.mb_nickname}님</span>
						</li>
						<li class="account-item">
							<a href="<c:url value="/"></c:url>" class="account-link">마이페이지</a>
						</li>
						<li class="account-item">
							<a href="<c:url value="/logout"></c:url>" class="account-link">로그아웃</a>
						</li>
					</c:if>
				</ul>
			</div>
			<!-- box-menu -------------------------------------------------------- -->
			<div class="box-menu">
				<!-- 로고 -------------------------------------------------------- -->
				<div class="logo" style="width:40%;">
					<a href="<c:url value="/"></c:url>"><i class="fa-solid fa-paw"></i><span>멍멍일지</span></a>
				</div>
				<!-- 메뉴 -------------------------------------------------------- -->
				<ul class="menu-list" style="width:60%;">
					<li class="menu-item">
						<a href="#" class="menu-link">일지</a>
					</li>
					<li class="menu-item">
						<a href="#" class="menu-link">굿즈</a>
					</li>
					<li class="menu-item">
						<a href="#" class="menu-link">후원</a>
					</li>
				</ul>
				<!-- 드랍 메뉴 -------------------------------------------------------- -->
				<div class="dropdown">
					<a href="#" class="all-menu" data-toggle="dropdown"><i class="fa-solid fa-bars"></i></a>
					<div class="dropdown-menu dropdown-menu-right border-0" style="width:270px;">
						<h5 class="dropdown-header">일지</h5>
						<a class="dropdown-item" href="#">멍친일지</a>
						<a class="dropdown-item" href="#">나의 일지</a>
						<a class="dropdown-item" href="#">챌린지</a>
						<h5 class="dropdown-header">굿즈</h5>
						<a class="dropdown-item" href="#">굿즈 보기</a>
						<a class="dropdown-item" href="#">장바구니</a>
						<a class="dropdown-item" href="#">리뷰</a>
						<a class="dropdown-item" href="#">Q&A</a>
						<h5 class="dropdown-header">후원</h5>
						<a class="dropdown-item" href="#">진행중인 후원</a>
						<a class="dropdown-item" href="#">후원 후기</a>
						<h5 class="dropdown-header">고객센터</h5>
						<a class="dropdown-item" href="#">공지사항</a>
						<a class="dropdown-item" href="#">1:1 문의</a>
						<a class="dropdown-item" href="#">FAQ</a>
					</div>
				</div>
			</div>
		</div>		
	</nav>
</body>
