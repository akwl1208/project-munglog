<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aside-강아지 정보 등록</title>
<!-- css ************************************************************ -->
<style>
	.box-profile,
	.box-friend{
		border: 1px solid #52443b; border-radius: 5px;
		padding: 20px 10px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
		margin-bottom: 50px;
	}
	.box-profile .box-user .thumb{float: left;}
	.box-profile .box-user .thumb img{
		border-radius: 50px; width: 60px; height: 60px;
	}
	.box-profile .box-user .nickname{
		float: left; width: 178px; height: 60px;
		line-height: 60px; padding-left: 10px;
		font-weight: bold; overflow: hidden; text-overflow: ellipsis;
	}
	.box-profile .box-greeting{
		margin-top: 20px; border-radius: 5px; background-color: #fff7ed;
		font-size: 12px; padding: 10px;
	}
	.box-friend .box-title{
		text-align: center; font-weight: bold; font-size: 18px;
		margin-bottom: 20px;
	}
	.box-friend .box-title .fa-dog{
		margin-right: 6px; color: #fb9600;
	}
	.box-friend .friend-list{
		margin: 0px; height: 180px;
		overflow-y: scroll; 
	}
	.box-friend .friend-list .friend-item{
		background-color: #fff7ed; margin-bottom: 10px;
		padding: 5px 0 5px 5px;
	}
	.box-friend .friend-item .thumb{float: left;}
	.box-friend .friend-item .thumb img{
		border-radius: 50px; width: 40px; height: 40px;
	}
	.box-friend .friend-item .nickname{
		float: left; width: 150px;
		line-height: 40px; padding-left: 10px;
		font-weight: bold; overflow: hidden; text-overflow: ellipsis;
	}
	.box-friend .friend-item .btn-delete{
		float: left; width: 20px; line-height: 40px;
		text-align: center;
	}
	.box-friend .friend-item .fa-xmark:hover{
		color: #fb9600;
	}
</style>
</head>
<!-- html ************************************************************ -->
<body>
	<!-- box-profile -------------------------------------------------------- -->
	<div class="box-profile " style="width: 260px;">
		<!-- box-user(프로필사진,닉네임) -------------------------------------------------------- -->
		<div class="box-user clearfix">
			<a href="#" class="thumb"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="프로필사진"></a>
			<a href="#" class="nickname">${user.mb_nickname}</a>
		</div>
		<!-- box-greeting(소개글) -------------------------------------------------------- -->
		<div class="box-greeting">
			<span>${user.mb_greeting}</span>
		</div>
	</div>
	<!-- box-friend -------------------------------------------------------- -->
	<div class="box-friend" style="width: 260px;">
		<!-- box-title -------------------------------------------------------- -->
		<div class="box-title">
			<a href="#"><i class="fa-solid fa-dog"></i><span>나의 멍멍친구들</span></a>
		</div>
		<!-- 친구목록 -------------------------------------------------------- -->
		<ul class="friend-list">
			<li class="friend-item clearfix">
				<a href="#" class="thumb"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="프로필사진"></a>
				<a href="#" class="nickname">MUNG2MUNG2MUNG2</a>
				<a href="#" class="btn-delete"><i class="fa-solid fa-xmark"></i></a>
			</li>
			<li class="friend-item clearfix">
				<a href="#" class="thumb"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="프로필사진"></a>
				<a href="#" class="nickname">MUNG2</a>
				<a href="#" class="btn-delete"><i class="fa-solid fa-xmark"></i></a>
			</li>
			<li class="friend-item clearfix">
				<a href="#" class="thumb"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="프로필사진"></a>
				<a href="#" class="nickname">MUNG2</a>
				<a href="#" class="btn-delete"><i class="fa-solid fa-xmark"></i></a>
			</li>
			<li class="friend-item clearfix">
				<a href="#" class="thumb"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="프로필사진"></a>
				<a href="#" class="nickname">MUNG2</a>
				<a href="#" class="btn-delete"><i class="fa-solid fa-xmark"></i></a>
			</li>
		</ul>
	</div>
</body>
</html>