<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>로그인</title>
<!-- css ************************************************************ -->
	<style>
		*{padding: 0; margin: 0; color: #52443b;}
		a{
			text-decoration: none; color: #52443b;
		}
		a:hover{text-decoration: none; color: #fb9600;}
		.container{
			border: 2px solid #52443b; border-radius: 10px;
			box-shadow: 3px 3px 10px 0 rgba(73, 67, 60, 0.2);
			padding: 0 30px; width: 500px; min-width: 500px;
		}
		.box-login{margin: 0 auto; padding: 54px 0;}
		.box-logo{
			text-align: center; font-weight: 900; font-size: 24px;
			padding: 10px 0;
		}
		.box-logo .fa-paw{margin-right: 6px;}
		.box-message{
			font-size: 12px; text-align: center;
		}
		.box-input{
			padding: 30px 0 0;
		}
		.error{
			color: #fb9600; font-size: 12px;
		}
		.box-service{padding-bottom: 30px; font-size: 12px;}
		.find-id::before,
		.find-id::after{
			display: inline-block; content: ''; margin: 0 6px;
			width: 1px; height: 12px; background-color: #b9ab9a;
			vertical-align: middle;
		}
		.btn-login{
			font-size: 18px; font-weight: bold; padding: 5px 0;
			border: none; background-color: #fb9600; margin-bottom: 10px;
		}
		.btn-login:hover{color:#fff7ed;}
	</style>
</head>
<!-- html ************************************************************ -->
<body>
	<div style="display: flex; align-items: center; justify-content: center; min-height: 100vh;">
		<form class="container" method="post">
			<!-- box-login -------------------------------------------------------- -->
			<div class="box-login">
				<!-- box-title -------------------------------------------------------- -->
				<div class="box-title">
					<!-- 로고 -------------------------------------------------------- -->
					<div class="box-logo">
						<a href="<c:url value="/"></c:url>"><i class="fa-solid fa-paw"></i><span>멍멍일지</span></a>
					</div>
					<!-- 안내문구 -------------------------------------------------------- -->
					<div class="box-message">이메일과 비밀번호를 입력하여 로그인해주세요.</div>
				</div>
				<!-- box-input -------------------------------------------------------- -->
				<div class="box-input">
					<!-- 이메일 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label>이메일</label>
						<input type="text" class="form-control" name="mb_email" id="mb_email">
					</div>
					<!-- 비밀번호 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label>비밀번호</label>
						<input type="password" class="form-control" name="mb_pw" id="mb_pw">
						<label class="error"></label>
					</div>
				</div>
				<!-- box-service -------------------------------------------------------- -->
				<div class="box-service clearfix">
					<!-- 아이디 저장 -------------------------------------------------------- -->
					<div class="box-save">
						<div class="form-check-inline float-left">
							<label class="form-check-label">
								<input type="checkbox" class="form-check-input save-id" name="saveId" value="true"><span>이메일 저장</span>
							</label>
						</div>
					</div>
					<!-- 계정 관련 링크 -------------------------------------------------------- -->
					<div class="box-account float-right">
						<a href="<c:url value="/account/signup"></c:url>" class="signup">회원가입</a>
						<a href="<c:url value="/account/find?type=id"></c:url>" class="find-id">아이디찾기</a>
						<a href="<c:url value="/account/find?type=pw"></c:url>" class="find-pw">비밀번호찾기</a>
					</div>
				</div>
				<!-- button -------------------------------------------------------- -->
				<button type="button" class="btn-login col-12">로그인</button>
			</div>
		</form>
	</div>
</body>
<!-- script **************************************************************************** -->
<script>
	$(function(){
	/* 이벤트 **************************************************************************** */
		//로그인 버튼 클릭-------------------------------------------------------
		$('.btn-login').click(function(){
			let saveId = $('[name=saveId]').val();
			console.log('saveId : ' + saveId);
			let mb_email = $('#mb_email').val();
			let mb_pw = $('#mb_pw').val();
			//이메일 작성 안하면
			if(mb_email == '' || mb_email.length == 0){
				$('#mb_email').focus();
				return false;
			}
			//비밀번호 작성 안하면
			if(mb_pw == '' || mb_pw.length == 0){
				$('#mb_pw').focus();
				return false;
			}
			//회원정보 일치하는지 확인
			let obj = {
				mb_email,
				mb_pw
			}
			ajaxPost(false, obj, '/check/member',function(data){
				//일치하지 않으면
				if(!data.res){
					//에러 메시지
					$('.error').text('이메일이나 비밀번호를 잘못입력했습니다. 확인해주세요.').show();
					//비밀번호 입력칸 비우기
					$('#mb_pw').val('');
				} else{ //성공하면
					//submit
					$('form').submit();
				}
			})
		})
		//아이디 저장-------------------------------------------------------
		$(document).ready(function(){
			//쿠키에서 세션 아이디 가져오기
			let mb_session_id = getCookie('saveId');
			//세션 아이디가 없으면
			if(mb_session_id == null || mb_session_id.length == 0)
				return;
			//세션아이디로 이메일 가져오기
			let obj = {
				mb_session_id
			}
			ajaxPost(false, obj, '/get/email',function(data){
				//이메일 정보가 있으면
				if(data.email != '' || data.email != null){
					//이메일 저장 체크
					$('.save-id').attr('checked', true);
					//이메일에 값 넣기
					$('#mb_email').val(data.email)
				}
			}) 
		})
		// 엔터키 눌렀을 때-------------------------------------------------------
		$(document).keyup(function(e) {
	    if (e.which === 13) {
	    	$('.btn-login').click();
	    }
		});
	})
	/* 함수 **************************************************************************** */
	// 쿠키 가져오기 ------------------------------------------------------
	function getCookie(cookieName){
	  cookieName = cookieName + '=';
	  let cookie = document.cookie;
		let startIndex = cookie.indexOf(cookieName);
	  //쿠키가 없으면
	  if(startIndex == -1)
		  return '';
		//쿠키가 있으면
		startIndex += cookieName.length;
		let endIndex = cookie.indexOf(';',startIndex);
	  //;를 못찾았으면 쿠키길이로 설정
	  if(endIndex == -1)
		  endIndex = cookie.length;
	  //값 추출
	  let value = cookie.substring(startIndex, endIndex);
		return unescape(value);   
	}
</script>
</html>