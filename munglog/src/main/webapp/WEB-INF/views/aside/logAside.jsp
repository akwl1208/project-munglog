<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aside-강아지 정보 등록</title>
<!-- css ************************************************************************************************************* -->
<style>
	.side-main .box-profile,
	.side-main .box-friend{
		border: 1px solid #52443b; border-radius: 5px;
		padding: 20px 10px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
		margin-bottom: 50px;
	}
	/* box-profile -------------------------------------------------------------------------------- */
	.side-main .box-profile .box-user .thumb{float: left;}
	.side-main .box-profile .box-user .thumb img{
		border-radius: 50px; width: 60px; height: 60px;
	}
	.side-main .box-profile .box-user .nickname{
		float: left; width: 178px; height: 60px;
		line-height: 60px; padding-left: 10px;
		font-weight: bold; overflow: hidden; text-overflow: ellipsis;
	}
	.side-main .box-profile .box-greeting{
		margin-top: 20px; border-radius: 5px; background-color: #fff7ed;
		font-size: 12px; padding: 10px;
	}
	.side-main .box-profile .box-follow{
		margin-top: 10px; text-align: right; font-size: 12px; cursor: pointer;
	}
	.side-main .box-profile .box-follow:hover{color: #fb9600;}
	.side-main .box-profile .box-follow .icon-follow.select{color: #fb9600;}
	/* box-friend -------------------------------------------------------------------------------- */
	.side-main .box-friend .box-title{
		text-align: center; font-weight: bold; font-size: 18px;
		margin-bottom: 20px;
	}
	.side-main .box-friend .box-title .fa-dog{
		margin-right: 6px; color: #fb9600;
	}
	.side-main .box-friend .friend-list{
		margin: 0px; height: 180px;
		overflow-y: scroll; 
	}
	.side-main .box-friend .friend-list .friend-item{
		background-color: #fff7ed; margin-bottom: 10px;
		padding: 5px 0 5px 5px;
	}
	.side-main .box-friend .friend-item .thumb{float: left;}
	.side-main .box-friend .friend-item .thumb img{
		border-radius: 50px; width: 40px; height: 40px;
	}
	.side-main .box-friend .friend-item .nickname{
		float: left; width: 150px;
		line-height: 40px; padding-left: 10px;
		font-weight: bold; overflow: hidden; text-overflow: ellipsis;
	}
	.side-main .box-friend .friend-item .btn-delete{
		float: left; width: 20px; line-height: 40px;
		text-align: center;
	}
	.side-main .box-friend .friend-item .fa-xmark:hover{
		color: #fb9600;
	}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
	<!-- box-profile -------------------------------------------------------- -->
	<div class="box-profile " style="width: 260px;">
		<!-- box-user(프로필사진,닉네임) -------------------------------------------------------- -->
		<a class="box-user clearfix" href="#">
			<span class="thumb"><img src="https://ssl.pstatic.net/static/common/myarea/myInfo.gif" alt="프로필사진"></span>
			<span class="nickname">${member.mb_nickname}</span>
		</a>
		<!-- box-greeting(소개글) -------------------------------------------------------- -->
		<div class="box-greeting">
			<span>${member.mb_greeting}</span>
		</div>
		<c:if test="${user == null or user.mb_num != member.mb_num}">
			<div class="box-follow">
				<div class="btn-follow">
					<i class="icon-follow fa-solid fa-shield-dog"></i>
					<span class="follow">친구 맺기</span>
					<span class="unfollow" style="display:none;">친구 맺기 취소</span>
				</div>
			</div>
		</c:if>
	</div>
	<!-- box-friend -------------------------------------------------------- -->
	<div class="box-friend" style="width: 260px;">
		<!-- box-title -------------------------------------------------------- -->
		<div class="box-title">
			<a href="#"><i class="fa-solid fa-dog mr-1"></i><span>멍멍친구들</span></a>
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
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let userNum = '${user.mb_num}';
	let friendNum = '${member.mb_num}';
	let friend = {
		fr_mb_num : userNum,
		fr_friend : friendNum
	}
	$(function(){
/* 이벤트 *********************************************************************************************************** */	
		$(document).ready(function(){
			//친구인지 확인하고 화면 구성 ----------------------------------------------------------------------------------------
			getFriend(friend);
		})//
		
		//친구 맺기(box-follow) 클릭------------------------------------------------------------------------------------------
		$(document).on('click', '.side-main .box-profile .box-follow', function(){
			//로그인 안했으면 로그인 화면으로
			if(userNum == ''){
				if(confirm('친구를 맺으려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?')){
					location.href = '<%=request.getContextPath()%>/account/login';
					return;
				}
			}
			//본인에게 친구맺기 누르면
			if(userNum == friendNum){
				return;					
			}
			//친구 맺기/취소
			makeFriend(friend);
		})
	})//
/* 함수 *********************************************************************************************************** */
	// makeFriend : 친구 추가/취소하기 -----------------------------------------------------------------------------------
	function makeFriend(obj){
		ajaxPost(false, obj, '/make/friend', function(data){
			//결과에 따라 화면구성 다르게
    	if(data.res == 1){
    		$('.side-main .box-profile .box-follow .icon-follow').addClass('select'); //색
    		$('.side-main .box-profile .box-follow .follow').hide(); //친구 맺기 감춤
    		$('.side-main .box-profile .box-follow .unfollow').show(); //친구 맺기 취소 보임
    	}
    	else if(data.res == 0){
    		$('.side-main .box-profile .box-follow .icon-follow').removeClass('select'); //색
    		$('.side-main .box-profile .box-follow .follow').show(); //친구 맺기 보임
    		$('.side-main .box-profile .box-follow .unfollow').hide(); //친구 맺기 취소 감춤
    	}
    	else if(data.res == -1)
    		alert('로그인하거나 다시 시도해주세요.')
		});
	}//
	
	// getFriend : 친구인지 확인 -----------------------------------------------------------------------------------
	function getFriend(obj){
		ajaxPost(false, obj, '/get/friend', function(data){
			//결과에 따라 화면구성 다르게
    	if(data.friend != null){
    		$('.side-main .box-profile .box-follow .icon-follow').addClass('select'); //색
    		$('.side-main .box-profile .box-follow .follow').hide(); //친구 맺기 감춤
    		$('.side-main .box-profile .box-follow .unfollow').show(); //친구 맺기 취소 보임
    	}
    	else{
    		$('.side-main .box-profile .box-follow .icon-follow').removeClass('select'); //색
    		$('.side-main .box-profile .box-follow .follow').show(); //친구 맺기 보임
    		$('.side-main .box-profile .box-follow .unfollow').hide(); //친구 맺기 취소 감춤
    	}
		});
	}//
</script>
</html>