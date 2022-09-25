<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
<!-- css ************************************************************ -->
	<style>
		*{padding: 0; margin: 0; color: #52443b;}
		a{text-decoration: none;}
		a:hover{text-decoration: none;}
		.container{
			border: 2px solid #52443b; border-radius: 10px;
			box-shadow: 3px 3px 10px 0 rgba(73, 67, 60, 0.2);
			padding: 0 30px; width: 500px; min-width: 500px;
		}
		.box-signup{margin: 0 auto; padding: 54px 0;}
		.box-logo{
			text-align: center; font-weight: 900; font-size: 24px;
			padding: 10px 0;
		}
		.box-logo .fa-paw{margin-right: 6px;}
		.box-message{
			font-size: 12px; text-align: center;
		}
		.box-input{padding: 36px 0 20px;}
		.btn-verification,
		.btn-signup{
			font-size: 18px; font-weight: bold; padding: 5px 0;
			border: none; background-color: #fb9600; margin-bottom: 10px;
		}
		.btn-verification:hover,
		.btn-signup:hover{color:#fff7ed;}
		.error{color: #fb9600; font-size: 12px;}
		.btn-check,
		.btn-send,
		.btn-resend{
			padding: 0 10px; background-color: #a04c00; 
			border: none; color: #fff7ed;
		}
	</style>
</head>
<!-- html ************************************************************ -->
<body>
	<div style="display: flex; align-items: center; justify-content: center; min-height: 100vh;">
		<form class="container" action="<%=request.getContextPath()%>/account/signup" method="post">
			<!-- box-signup -------------------------------------------------------- -->
			<div class="box-signup">
				<!-- box-title -------------------------------------------------------- -->
				<div class="box-title">
					<!-- 로고 -------------------------------------------------------- -->
					<div class="box-logo">
						<a href="<c:url value="/"></c:url>"><i class="fa-solid fa-paw"></i><span>멍멍일지</span></a>
					</div>
					<!-- 안내문구 -------------------------------------------------------- -->
					<div class="box-message">회원가입을 위해 개인정보 입력 및 본인인증 해주세요. </div>
				</div>
				<!-- box-input -------------------------------------------------------- -->
				<div class="box-input">
					<!-- 이메일 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label>이메일</label>
						<div class="input-group">
							<input type="text" class="form-control" name="mb_email" id="mb_email">
							<div class="input-group-append">
								<button type="button" class="btn-send">전송</button>
								<button type="button" class="btn-validate" style="display:none"></button>
							</div>
						</div>
						<label class="error emailError" for="mb_email"></label>
					</div>
					<!-- 본인인증번호 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label>본인인증코드</label>
						<div class="input-group">
							<input type="text" class="form-control" name="vr_code" id="vr_code" readonly>
							<div class="input-group-append">
								<button type="button" class="btn-check">확인</button>
							</div>
						</div>
						<label class="error codeError" for="vr_code"></label>
					</div>
					<!-- 비밀번호 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label>비밀번호</label>
						<input type="password" class="form-control" name="mb_pw" id="mb_pw">
						<label class="error" for="mb_pw"></label>
					</div>
					<!-- 비밀번호 확인 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label>비밀번호 확인</label>
						<input type="password" class="form-control" name="pwCheck" id="pwCheck">
						<label class="error" for="pwCheck"></label>
					</div>
					<!-- 이름 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label for="mb_name">이름</label>
						<input type="text" class="form-control" name="mb_name" id="mb_name">
						<label class="error" for="mb_name"></label>
					</div>
					<!-- 핸드폰번호 입력 -------------------------------------------------------- -->
					<div class="form-group">
						<label for="mb_phone">핸드폰번호</label>
						<input type="text" class="form-control" name="mb_phone" id="mb_phone">
						<label class="error" for="mb_phone"></label>
					</div>
				</div>
				<!-- button -------------------------------------------------------- -->
				<button class="btn-signup col-12">회원가입</button>
			</div>
		</form>
	</div>
<!-- script ************************************************************ -->
	<script>
	let sendCheck = false; //이메일 보냈는지 판별
	let mb_email = ''; 
	let codeCheck = false; //코드인증확인 했는지 판별
	let count = 0; //실패 횟수
	let emailRegex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		<!-- validate -------------------------------------------------------- -->
		$(function(){
			$("form").validate({
				rules: {
					mb_email: {
						required : true,
						email: true
					},
					vr_code: {
						required : true,
					},
					mb_pw: {
						required : true,
						regex: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,20}$/
					},
					pwCheck: {
						required : true,
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
				mb_email: {
					required : "필수항목입니다.",
					email : "이메일 형식에 맞게 작성해주세요."
				},
				vr_code: {
					required : "필수항목입니다.",
				},
				mb_pw: {
					required : "필수항목입니다.",
					regex : "영어, 숫자, 특수문자(!@#$%^&*)를 혼합한 8글자 이상 20자 이하로 입력해주세요."
				},
				pwCheck: {
					required : "필수항목입니다.",
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
    	  //본인인증 했는지
				if(!codeCheck){
					$('.codeError').text('본인인증을 완료해주세요.').show();
					$('#vr_code').focus();
					return false;
				}
				return true;			
	    }
		});
	})
	$.validator.addMethod(
		"regex",
		function(value, element, regexp) {
			var re = new RegExp(regexp);
			return this.optional(element) || re.test(value);
		},
		"Please check your input."
	);
	<!-- 이벤트 -------------------------------------------------------- -->
	$(function(){
		//이메일 입력창에 change-----------------------------------------------------
		$('#mb_email').change(function(){
			//sendCheck가 true : 이미 메일을 보냈는데 값을 수정한 경우
			if(sendCheck){
				//이전에 작성한 메일을 삭제하고
				deleteVerification(mb_email);
				//sendCheck false로 하고
				sendCheck = false;
				//본인인증 readonly로
				$('#vr_code').attr('readonly',true);
			}
		})
		
		//전송버튼 클릭-----------------------------------------------------------------
		$('.btn-send').click(function(){
			//이미 본인인증을 완료했으면
			if(codeCheck)
				return;
			mb_email = $('#mb_email').val();
			//이미 메일이 전송된 경우(이메일 재전송하는 경우) 
			if(sendCheck){
				if(confirm('이미 코드가 전송되었습니다. 본인인증코드를 다시 전송하겠습니까?'))
					sendEmail(mb_email);
				return;					
			}
			//이메일이 형식에 맞을 때 이메일 중복확인 
			//이메일을 작성하지 않고 전송버튼 눌렀을 때
			if(mb_email == '' || mb_email.length == 0){
				$('.emailError').text('필수항목입니다.').show();
				$('#mb_email').focus();
				return;
			}
			//이메일 형식에 맞지 않을 때 
			if(!emailRegex.test(mb_email)){
				$('.emailError').text('이메일 형식에 맞게 작성해주세요.').show();
				$('#mb_email').focus();
				return;
			}
			//이메일 중복된 아이디일 때
			if(!checkDuplication(mb_email))
				return;
			//중복된 아이디가 아니면 이메일 보내기
			//이메일 못보냈으면
			if(!sendEmail(mb_email)){
				alert('이메일 전송에 실패했습니다.');
				return;
			}
			//메일 보내기 성공하면 화면 재구성
			$('#vr_code').attr('readonly',false); //본인인증입력칸 입력 가능
		})
		
		//확인 버튼 클릭-----------------------------------------------------------------
		$('.btn-check').click(function(){
			//이미 본인인증을 완료했으면
			if(codeCheck)
				return;
			let vr_email = $('#mb_email').val();
			//이메일 입력 안하고
			if(vr_email == '' || vr_email.length == 0){
				$('.emailError').text('필수항목입니다.').show();
				$('#mb_email').focus();
				return;
			}
			//이메일 형식에 맞지 않을 때 
			if(!emailRegex.test(vr_email)){
				$('.emailError').text('이메일 형식에 맞게 작성해주세요.').show();
				$('#mb_email').focus();
				return;
			}
			//이메일 중복된 아이디일 때
			if(!checkDuplication(vr_email))
				return false;
			//인증번호를 보내지 않고 확인버튼 누름
			if(!sendCheck){
				alert('전송버튼을 눌러주세요.');
				return;
			}
			let vr_code = $('#vr_code').val();
			//인증번호를 입력하지 않고 확인버튼 누름
			if(vr_code == '' || vr_code.length == 0){
				$('.codeError').text('필수항목입니다.').show();
				$('#vr_code').focus();
				return;
			}
			//본인인증코드 일치하는지 확인
			if(!checkCode(mb_email,vr_code)){
				$('.codeError').text('인증코드가 일치하지 않습니다').show();
				$('#vr_code').focus();
				//실패횟수가 5번 초과한 경우
				if(count > 5){
					//이메일로 인증번호 재전송
					alert('인증실패횟수가 5번 초과했습니다. 이메일로 본인인증코드를 재전송합니다.');
					sendEmail(mb_email);
				}
				return;
			}
			//화면 재구성
			$('#mb_email').attr('readonly',true);
			$('.emailError').text('본인인증이 완료되었습니다.').show();
			$('#vr_code').attr('readonly',true);
		})
		let emailCheck = false;
	})
	<!-- 함수 -------------------------------------------------------- -->
	//이메일 중복검사----------------------------------------------------
	function checkDuplication(mb_email){
		emailCheck = false;
		let obj= {
			mb_email
		}
		ajaxPost(false, obj, '/check/email',function(data){
			emailCheck = data.res;
			if(!emailCheck){
				$('.emailError').text('이미 사용 중인 이메일입니다.').show();
				$('#mb_email').focus();
			}
		})
		return emailCheck;
	}
	
	//이메일 보내기----------------------------------------------------
	function sendEmail(mb_email){
		//아이디 중복검사 안하거나 중복된 아이디면 메일 안보냄
		if(!emailCheck)
			return false;
		let obj= {
			mb_email
		}
		ajaxPost(false, obj, '/send/code',function(data){
			sendCheck = data.res;
			//메일전송에 실패했으면 다시 전송버튼 누르라고 알려줌
			if(!data.res){
				alert('이미 코드가 전송되었습니다. 이메일을 확인해주세요.');
			}
			else{
				alert('본인인증코드 전송했습니다. 이메일을 확인해주세요.');
			}
		})
		return sendCheck;
	}
	
	//본인인증 삭제----------------------------------------------------
	function deleteVerification(mb_email){
		if(!sendCheck)
			return false;
		let obj= {
			mb_email
		}
		ajaxPost(false, obj, '/delete/verification',function(data){
			if(!data.res)
				return;
		})
	}
	
	//인증번호 확인----------------------------------------------------
	function checkCode(vr_email, vr_code){
		//이메일이나 코드가 없는 경우
		if(vr_email == '' || vr_code == '')
			return false;
		let obj= {
			vr_email,
			vr_code,
		}
		ajaxPost(false, obj, '/check/code',function(data){
			//일치하지 않으면
			if(!data.res){
				$('.codeError').text('인증번호가 일치하지 않습니다.').show();
				$('#mb_email').focus();
				//실패횟수 증가
				count = countFailure(mb_email);
			}
			codeCheck = data.res;
		})
		return codeCheck;
	}
	//실패횟수 증가----------------------------------------------------
	function countFailure(vr_email){
		//이메일이나 코드가 없는 경우
		if(vr_email == '')
			return -1;
		let obj= {
			vr_email
		}
		ajaxPost(false, obj, '/count/failure',function(data){
			count = data.count;
		})
		return count;
	}
	</script>
</body>
</html>