<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title></title>
<!-- style ****************************************************************************************************** -->
	<style>
		*{padding: 0; margin: 0;}
		a{text-decoration: none; color: #52443b;}
		a:hover{text-decoration: none; color: #52443b;}
		ul,li{list-style-type: none; color: #52443b;}
		.fixed-top.header{
			background-color: white; box-shadow: 0 1px 3px 0 rgba(73, 67, 60, 0.2);
			min-width : 500px;
		}
		.header .box-menu{display: flex; text-align: right; padding: 10px 0 20px;}
		.header .box-account .account-list{
			text-align: right; margin-top: 20px;
		}
		.header .box-account .account-list>li{
			display: inline-block; font-size: 12px; height: 24px;
		}
		.header .box-account .account-list li a{line-height: 24px;}
		.header .box-account .account-list>li:nth-child(n+2):not(:last-of-type)::after{
			display: inline-block; content: ''; margin: 0 6px 3px;
			width: 1px; height: 12px; background-color: #b9ab9a; 
			vertical-align: middle; line-height: 24px;
		}		
		.header .box-account .account-list .nickname::after{
			display: inline-block; content: ''; margin: 0 6px 6px;
    	width: 3px; height: 3px; border-radius: 50%; background-color: #b9ab9a;
    	vertical-align: middle; line-height: 24px;
		}
		.header .box-account .nickname{line-height: 24px;}
		.header .box-account .nickname .fa-dog{color: #fb9600; margin-right: 6px;}
		.header .box-menu .logo{
			font-size: 24px; font-weight: 900; text-align: left;
			line-height: 45px; padding-left: 20px;
		}
		.header .box-menu .logo .fa-paw{margin-right: 6px;}
		.header .box-menu .menu-list{margin: auto;}
		.header .box-menu .menu-list>li{
			display: inline-block; font-size: 18px; font-weight: bold;
			margin-left: 40px;
		}
		.header .box-menu .menu-list a:hover{color: #fb9600;}
		.header .box-menu .dropdown{margin: 9px 0; height: 27px; padding: 4.5px 0;}
		.header .box-menu .all-menu{
			display: inline-block; font-weight: bold; margin-left: 40px;
		}
		.header .box-menu .all-menu .fa-bar{line-height: 27px; font-size: 18px;}
		.header .box-menu .dropdown-menu{
			margin-top: 37px; padding: 0;
		} 
		.header .box-menu .dropdown-menu .dropdown-header{background-color: #fff7ed;}
	</style>
</head>
<!-- body ****************************************************************************************************** -->
<body>
	<nav class="fixed-top header">
		<div class="container">
			<!-- box-account ------------------------------------------------------------------------------------------- -->
			<div class="box-account">
				<ul class="account-list">
					<!-- 비회원일 때 ------------------------------------------------------------------------------------------ -->
					<c:if test="${user == null}">
						<li class="account-item">
							<a href="<c:url value="/account/signup"></c:url>" class="account-link">회원가입</a>
						</li>
						<li class="account-item">
							<a href="<c:url value="/account/login"></c:url>" class="account-link">로그인</a>
						</li>
					</c:if>
					<!-- 회원일 때 --------------------------------------------------------------------------------------------- -->
					<c:if test="${user != null}">
						<li class="account-item nickname">
							<span><i class="fa-solid fa-dog"></i>${user.mb_nickname}님</span>
						</li>
						<c:if test="${user.mb_level == 'A' ||	user.mb_level == 'S'}">
							<li class="account-item">
								<a href="<c:url value="/admin"></c:url>" class="account-link">관리자페이지</a>
							</li>						
						</c:if>
						<li class="account-item">
							<a href="<c:url value="/"></c:url>" class="account-link">마이페이지</a>
						</li>
						<li class="account-item">
							<a href="<c:url value="/logout"></c:url>" class="account-link">로그아웃</a>
						</li>
					</c:if>
				</ul>
			</div>
			<!-- box-menu ---------------------------------------------------------------------------------------------- -->
			<div class="box-menu">
				<!-- 로고 -------------------------------------------------------------------------------------------------- -->
				<div class="logo" style="width:40%;">
					<a href="<c:url value="/"></c:url>"><i class="fa-solid fa-paw"></i><span>멍멍일지</span></a>
				</div>
				<!-- 메뉴 -------------------------------------------------------------------------------------------------- -->
				<ul class="menu-list" style="width:60%;">
					<li class="menu-item">
						<a href="<c:url value="/log/feed"></c:url>" class="menu-link">일지</a>
					</li>
					<li class="menu-item">
						<a href="#" class="menu-link">굿즈</a>
					</li>
					<li class="menu-item">
						<a href="#" class="menu-link">후원</a>
					</li>
				</ul>
				<!-- 드랍 메뉴 ------------------------------------------------------------------------------------------ -->
				<div class="dropdown">
					<a href="#" class="all-menu" data-toggle="dropdown"><i class="fa-solid fa-bars"></i></a>
					<div class="dropdown-menu dropdown-menu-right border-0" style="width:270px;">
						<h5 class="dropdown-header">일지</h5>
						<a class="dropdown-item" href="<c:url value="/log/feed"></c:url>">멍멍피드</a>
						<a class="dropdown-item" 
							href="<c:if test="${user != null}"><c:url value="/log/mylog/${user.mb_num}"></c:url></c:if>">	
							나의 일지	
						</a>
						<a class="dropdown-item" href="<c:url value="/log/challenge"></c:url>">챌린지</a>
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
