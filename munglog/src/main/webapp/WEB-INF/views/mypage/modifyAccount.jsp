<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정</title>
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
	.main .box-content .box-check .btn-check,
	.main .box-content .box-account-info .btn-modify{
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-top: 20px;
	}
	.main .box-content .box-check .btn-check:hover,
	.main .box-content .box-account-info .btn-modify:hover{color:#fff7ed;}
	.main .box-content .box-account-info .error{color: #fb9600; font-size: 12px;}
</style>
</head>
<!-- html ***************************************************************************************** -->
<body>
<!-- 제목 ------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>회원정보 수정</span>
	<div class="box-message">회원 정보를 수정하세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------- -->	
<div class="box-content">
	<!-- box-check ------------------------------------------------------------------------------------ -->
	<div class="box-check" >
		<div class="form-group">
			<label>이메일</label>
			<input type="text" class="form-control" value="${member.mb_email}" readonly>
		</div>
		<div class="form-group">
			<label>비밀번호</label>
			<input type="password" class="form-control password">
		</div>
		<span class="error"></span>
		<button type="button" class="btn-check col-12">비밀번호 확인</button>
	</div>
	<!-- box-account-info ------------------------------------------------------------------------------------ -->
	<div class="box-account-info" style="display: none;">
		<form method="post">
			<div class="mb-2 text-right">
				<small>비밀번호 수정을 원하지 않으면 입력하지 않고 회원정보 수정을 눌러주세요.</small>
			</div>
			<input type="text" name="mb_num" style="display:none;" value="${member.mb_num}"> 
			<div class="form-group">
				<label>이메일</label>
				<input type="text" class="form-control" name="mb_email" value="${member.mb_email}" readonly>
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" class="form-control" name="mb_pw" id="mb_pw">
				<label class="error" for="mb_pw"></label>
			</div>
			<div class="form-group">
				<label>비밀번호 확인</label>
				<input type="password" class="form-control" name="pwCheck" id="pwCheck">
				<label class="error" for="pwCheck"></label>
			</div>
			<div class="form-group">
				<label for="mb_name">이름</label>
				<input type="text" class="form-control" value="${member.mb_name}" name="mb_name" id="mb_name">
				<label class="error" for="mb_name"></label>
			</div>
			<div class="form-group">
				<label for="mb_phone">핸드폰번호</label>
				<input type="text" class="form-control" value="${member.mb_phone}" name="mb_phone" id="mb_phone">
				<label class="error" for="mb_phone"></label>
			</div>
			<button class="btn-modify col-12">회원정보 수정</button>
		</form>
	</div>
</div>
</body>
<!-- script *************************************************************************************** -->
<script>
	let mbEmail = '${member.mb_email}';
	let checkPw = false;
	<!-- validate -------------------------------------------------------- -->
	$(function(){
		$("form").validate({
			rules: {
				mb_pw: {
					regex: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,20}$/
				},
				pwCheck: {
					equalTo : mb_pw
				},
				mb_name: {
					required : true,
					regex: /^([가-힣]{2,20})|([a-zA-Z]{2,20})$/
				},
				mb_phone: {
					required : true,
					regex: /^(010)-(\d{4})-(\d{4})$/
				}
			},
			//규칙체크 실패시 출력될 메시지
			messages : {
				mb_pw: {
					regex : "영어, 숫자, 특수문자(!@#$%^&*)를 혼합한 8글자 이상 20자 이하로 입력해주세요."
				},
				pwCheck: {
					equalTo : "비밀번호가 일치하지 않습니다."
				},
				mb_name: {
					required : "필수항목입니다.",
					regex: "띄어쓰기 없이 2글자 이상 20자 이하로 입력해주세요."
				},
				mb_phone: {
					required : "필수항목입니다.",
					regex: "010-0000-0000 형식으로 입력해주세요."
				}
			},
      submitHandler : function(form){
  			if(userMbEmail == '')
					return false;
				if(!checkPw){
					alert('잘못된 접근입니다.');
					return false;
				}
				if(!confirm('회원정보를 수정하겠습니까?'))
					return false;
				return true;			
	    }
		});
	});
	$.validator.addMethod(
		"regex",
		function(value, element, regexp) {
			var re = new RegExp(regexp);
			return this.optional(element) || re.test(value);
		},
		"Please check your input."
	);
<!-- 이벤트 **************************************************************************************************** -->
$(function(){
	//비밀번호 확인 클릭 ==================================================================================
	$('.main .box-content .box-check .btn-check').click(function(){
		//로그인 안했으면
		if(userMbEmail == ''){
			if(confirm('회원정보 수정은 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		//비밀번호 입력 안했으면
		let password = $('.main .box-content .box-check .password').val();
		if(password == ''){
			alert('비밀번호를 입력해주세요.');
			$('.main .box-content .box-check .password').focus();
			return;
		}
		//비밀번호 확인
		checkPassword(password);
	})//
	
	// 엔터키 눌렀을 때 ====================================================================================
	$(document).keyup(function(e) {
    if (e.which === 13) {
    	if(checkPw == false)
    		$('.main .box-content .box-check .btn-check').click();
    	else
    		$('.main .box-content .box-account-info .btn-modify').click();
    }
	})//
});
<!-- 함수 ***************************************************************************************************** -->	
	//checkPassword : 비밀번호 확인 =========================================================================
	function checkPassword(password){
		let obj = {
			mb_email : mbEmail,
			mb_pw : password
		};
		ajaxPost(false, obj, '/check/member', function(data){
			let html = '';
			if(data.res){
				checkPw = true;
				alert('확인했습니다. 회원정보를 수정해주세요.');
				$('.main .box-content .box-check').hide();
				$('.main .box-content .box-account-info').show();
			}else{
				checkPw = false;
				alert('회원정보와 다릅니다. 확인해주세요.');
				$('.main .box-content .box-check').show();
				$('.main .box-content .box-account-info').hide();
			}
		});
	}//
</script>
</html>