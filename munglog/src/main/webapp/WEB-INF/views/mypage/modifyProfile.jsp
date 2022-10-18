<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>프로필 수정</title>
<!-- css **************************************************************************************** -->
<style>
	.main .box-title{
		background-color: #ae8a68; border-radius: 5px;
		padding: 20px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
		margin-bottom: 10px; font-size: 18px; font-weight: bold;
	}
	.main .box-title .fa-paw{margin-right: 6px;}
	.main .box-title .box-message{
		font-size: 12px; margin: 5px 0; padding-left: 24px;
	}
	.main .box-content{margin: 44px;}
	.main .box-content table{
		table-layout: fixed;
		border-top: 2px solid #ae8a68; border-bottom: 2px solid #ae8a68;
	}
	.main .box-content table tbody th{
		background-color: #d8d8d8; width: 180px; text-align: center;
	}
	.main .box-content table tbody th>div,
	.main .box-content table tbody td{padding: 30px;}
	.main .box-content table tbody td .box-profile{width: 150px; height: 150px;}
	.main .box-content table tbody td .box-profile img{
		width: 150px; height: 150px; border-radius: 50%;
	}
	.main .box-content table tbody td .box-button{margin-top: 20px;}
	.main .box-content table tbody td>div .btn{
		background-color: #a04c00; border-radius: 3px; font-size: 12px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
	}
	.main .box-content table tbody td .error{font-size: 12px; color: #fb9600;}
	.main .box-content .box-set .btn{
		display: inline-block; border: 1px solid #dfe0df; padding: 10px 20px;
		font-weight: bold; width: 49%;
	}
	.main .box-content .box-set .btn-modify{background-color: #fb9600;}
	.main .box-content .box-set .btn-modify:hover{color: #fff7ed;}
	.main .box-content .box-set .btn-cancel{background-color: #fff7ed; margin-left: 1%;}
</style>
</head>
<!-- html ***************************************************************************************** -->
<body>
<!-- 제목 ------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>프로필 수정</span>
	<div class="box-message">프로필 사진, 닉네임, 일지 소개글을 수정하세요.</div>
</div>	
<!-- box-content ------------------------------------------------------------------------------------------- -->	
<form class="box-content" method="post" enctype="multipart/form-data">
	<input type="text" name="mb_num" style="display: none;" value="${member.mb_num}">
	<table class="table border-0">
		<tbody>
			<tr>
				<th>
					<div>프로필 사진</div>
				</th>
				<td>
					<div class="box-profile">
						<div> 
							<img src="<c:url value="${member.mb_profile_url}"></c:url>" class="mb_profile">
							<img class="preview" style="display: none;">
							<img src="<c:url value="/profile/img/profile.png"></c:url>" class="profile" style="display: none;">
						</div>
					</div>
					<div class="box-button">
						<input type="file" style="display: none;" name="file" accept="image/jpg, image/jpeg, image/png, image/gif">
						<a href="javascript:0;" class="btn btn-file mr-2">사진 변경</a>
						<input type="text" name="delProfile" style="display: none;" value="true">
 						<a href="javascript:0;" class="btn btn-delete">사진 삭제</a>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<div>닉네임</div>
				</th>
				<td>
					<div class="box-nickname">
						<div class="input-group">
							<input type="text" class="form-control" name="mb_nickname" value="${member.mb_nickname}" placeholder="닉네임을 입력해주세요.">
							  <div class="input-group-append">
							    <button type="button" class="btn btn-check">중복 확인</button>
							  </div>
						</div>
						<div class="error mt-2"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<div>일지 소개글</div>
				</th>
				<td>
					<div class="box-greeting">
						<div class="form-group m-0">
							<textarea class="form-control" name="mb_greeting" rows="5" style="resize: none;" placeholder="일지 소개글을 작성해주세요.">${member.mb_greeting}</textarea>
							<div class="box-text-count text-right">
								<span class="count">0</span><span class="font-weight-bold"">/200</span>
							</div>
						</div>
						<div class="error mt-2"></div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="box-set mt-5">
		<button type="submit" class="btn btn-modify">수정</button>
		<a href="<c:url value="/mypage"></c:url>" class="btn btn-cancel">취소</a>
	</div>
</form>
</body>
<!-- script *************************************************************************************** -->
<script>
	let userMbNum = '${user.mb_num}';
	let userNickname = '${user.mb_nickname}';
	let checkNickname = true;
	let nicknameRegex = /^(?=.*[A-Za-z0-9가-힣])[\w가-힣-]{2,10}$/;
	let strictRegex = /^[M|m][U|u][N|n][G|g]\d+$/;
<!-- 이벤트 **************************************************************************************************** -->
$(function(){
	$(document).ready(function(){
		//글자수 표시 ===================================================================================================
		let greetingLength = $('.main .box-content table tbody td .box-greeting [name=mb_greeting]').val().length;
		$('.main .box-content table tbody td .box-greeting .box-text-count .count').text(greetingLength);
	})//
	
	//사진 변경 클릭(btn-file) ===========================================================================================
	$('.main .box-content table tbody td .box-button .btn-file').click(function(){
		$('.main .box-content table tbody td .box-button [name=file]').click();
	})//
	
	//사진 선택했으면(input:file) =================================================================================
	$('.main .box-content table tbody td .box-button [name=file]').on('change', function(event) {
		let delProfile = $('.main .box-content table tbody td .box-button [name=delProfile]').val();
		//미리보기 화면 구성
		if(delProfile == 'true' && event.target.files.length == 0){
			$('.main .box-content table tbody td .box-profile .mb_profile').hide();
			$('.main .box-content table tbody td .box-profile .preview').hide();
			$('.main .box-content table tbody td .box-profile .profile').show();
			return;
		}else if(delProfile == 'false' && event.target.files.length == 0){
			$('.main .box-content table tbody td .box-profile .mb_profile').show();
			$('.main .box-content table tbody td .box-profile .preview').hide();
			$('.main .box-content table tbody td .box-profile .profile').hide();
			return;
		}else{
			$('.main .box-content table tbody td .box-profile .mb_profile').hide();
			$('.main .box-content table tbody td .box-profile .preview').show();
			$('.main .box-content table tbody td .box-profile .profile').hide();
		}
		
	  let file = event.target.files[0];
	  let reader = new FileReader(); 
	  
	  reader.onload = function(e) {
	  	$('.main .box-content table tbody td .box-profile .preview').attr('src', e.target.result);
	  }
	  reader.readAsDataURL(file);
	})//
	
	//사진 삭제 클릭(btn-delete) ===========================================================================================
	$('.main .box-content table tbody td .box-button .btn-delete').click(function(){
		//값 변경
		$('.main .box-content table tbody td .box-button [name=delProfile]').val('false');
		//이미지 변경
		$('.main .box-content table tbody td .box-profile .mb_profile').hide();
		$('.main .box-content table tbody td .box-profile .preview').hide();
		$('.main .box-content table tbody td .box-profile .profile').show();
		//파일 비우기
		$('.main .box-content table tbody td .box-button [name=file]').val('');
	})//
	
	//닉네임 값 바뀜(btn-delete) ===========================================================================================
	$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').keyup(function(){
		$('.main .box-content table tbody td .box-nickname .error').hide();
		let nickname = $('.main .box-content table tbody td .box-nickname [name=mb_nickname]').val();
		if(nickname != userNickname)
			checkNickname = false;
		else
			checkNickname = true;
	})//
	
	//닉네임 중복 확인 클릭(btn-delete) ===========================================================================================
	$('.main .box-content table tbody td .box-nickname .btn-check').click(function(){
		let nickname = $('.main .box-content table tbody td .box-nickname [name=mb_nickname]').val();
		if(nickname == ''){
			$('.main .box-content table tbody td .box-nickname .error').text('닉네임을 입력해주세요.').show();
			$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').focus();
			checkNickname = false;
			return;
		}
		//닉네임 정규식 통과
		if(!nicknameRegex.test(nickname)){
			$('.main .box-content table tbody td .box-nickname .error').text('띄어쓰기 없이 한글, 영문 대소문자, 숫자, - 또는 _로 2자 이상 10자 이하로 만들어주세요.').show();
			$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').focus();
			checkNickname = false;
			return;
		}
		//MUNG+숫자 닉네임이 아님
		if(nickname != userNickname && strictRegex.test(nickname)){
			$('.main .box-content table tbody td .box-nickname .error').text('MUNG+숫자 닉네임은 사용할 수 없습니다.').show();
			$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').focus();
			checkNickname = false;
			return;
		}
		checkNicknameDuplication(nickname);
	})//
	
	//소개글 입력 이벤트===========================================================================================
	$('.main .box-content table tbody td .box-greeting [name=mb_greeting]').keyup(function(){
		//200자 이상 입력 안됨
	  if($(this).val().length > 200)
	      $(this).val($(this).val().substring(0, 200));
		//글자수 표시
		let greetingLength = $(this).val().length;
		$('.main .box-content table tbody td .box-greeting .box-text-count .count').text(greetingLength);
	})//
	
	//form 보내기 전 ============================================================================================
	$('form').submit(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A을 보려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return false;
		}
		//닉네임 형식 검사와 중복검사 안했으면
		if(!checkNickname){
			alert('닉네임 중복검사해주세요.');
			$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').focus();
			return false;
		}
		if(!confirm('프로필을 수정하겠습니까?'))
			return false;
	})//
	
	// 엔터키 눌렀을 때 ====================================================================================
	$(document).keyup(function(e) {
    if (e.which === 13)
    	$('.main .box-content .box-set .btn-modify').click();
	})//
});
<!-- 함수 ***************************************************************************************************** -->	
	//checkNicknameDuplication : 닉네임 중복 확인 ================================================================
	function checkNicknameDuplication(mb_nickname){
		let obj = {mb_nickname};
		ajaxPost(false, obj, '/check/nickname',function(data){
			if(data.res == 0){
				$('.main .box-content table tbody td .box-nickname .error').text('띄어쓰기 없이 한글, 영문 대소문자, 숫자, - 또는 _로 2자 이상 10자 이하로 만들어주세요.').show();
				$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').focus();			
				checkNickname = false;
			} else if(data.res == 1){
				$('.main .box-content table tbody td .box-nickname .error').text('MUNG+숫자 닉네임은 사용할 수 없습니다.').show();
				$('.main .box-content table tbody td .box-nickname [name=mb_nickname]').focus();				
				checkNickname = false;
			} else if(data.res == 2){
				$('.main .box-content table tbody td .box-nickname .error').text('이미 사용중인 닉네임입니다.').show();
				checkNickname = false;
			} else if(data.res == 3){
				$('.main .box-content table tbody td .box-nickname .error').text('사용 가능한 닉네임입니다.').show();
				checkNickname = true;
			}
		});
	}//
</script>
</html>