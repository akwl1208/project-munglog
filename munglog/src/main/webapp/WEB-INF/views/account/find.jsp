<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 비번 찾기</title>
<!-- css ************************************************************ -->
	<style>
		*{padding: 0; margin: 0; color: #52443b;}
		a{text-decoration: none; color: #52443b;}
		a:hover{text-decoration: none; color: #a04c00; font-weight: bold;}
		.container{
			border: 2px solid #52443b; border-radius: 10px;
			box-shadow: 3px 3px 10px 0 rgba(73, 67, 60, 0.2);
			padding: 0 30px; width: 500px; min-width: 500px;
		}
		.box-find{margin: 0 auto; padding: 54px 0;}
		.box-logo{
			text-align: center; font-weight: 900; font-size: 24px;
			padding: 10px 0;
		}
		.box-logo .fa-paw{margin-right: 6px;}
		.box-message{
			font-size: 12px; text-align: center;
		}
		.box-tab{margin: 30px 0 0;}
		.box-tab .nav-item{
			width: 218px; text-align: center;
		}
		.box-tab .nav-item .nav-link.active{
			background-color: #a04c00; font-weight: bold; color: #fff7ed;
		}
		.box-input,
		.box-result{padding: 34px 0 0;}
		.box-input .form-group{margin-bottom: 34px;}
		.box-inform{
			background-color: #fff7ed;; text-align: center; margin: 0 0 34px;
			padding: 20px; border-radius: 5px;
		}
		.error{
			color: #fb9600; font-size: 12px;
		}
		.btn{
			font-size: 18px; font-weight: bold; padding: 5px 0;
			border: none; background-color: #fb9600; margin-bottom: 10px;
		}
		.btn:hover{color:#fff7ed;}
	</style>
</head>
<!-- html ************************************************************ -->
<body>
	<div style="display: flex; align-items: center; justify-content: center; min-height: 100vh;">
		<div class="container">
			<!-- box-find -------------------------------------------------------- -->
			<div class="box-find">
				<!-- box-title -------------------------------------------------------- -->
				<div class="box-title">
					<!-- 로고 -------------------------------------------------------- -->
					<div class="box-logo">
						<a href="<c:url value="/"></c:url>"><i class="fa-solid fa-paw"></i><span>멍멍일지</span></a>
					</div>
					<!-- 안내문구 -------------------------------------------------------- -->
					<div class="box-message">회원가입 시 입력한 정보로 아이디/비밀번호를 찾으세요.</div>
				</div>
				<!-- box-tab -------------------------------------------------------- -->
				<div class="box-tab" >
					<!-- 탭 메뉴 -------------------------------------------------------- -->
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#id">아이디 찾기</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#pw">비밀번호 찾기</a>
						</li>
					</ul>
					<!-- 탭 내용 -------------------------------------------------------- -->
					<div class="tab-content">
						<!-- 아이디 찾기 -------------------------------------------------------- -->
						<div id="id" class="tab-pane active">
							<!-- box-input -------------------------------------------------------- -->
							<div class="box-input">
								<!-- 이름 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>이름</label>
									<input type="text" class="form-control" name="mb_name" id="mb_name">
								</div>
								<!-- 핸드폰번호 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>핸드폰번호</label>
									<input type="text" class="form-control" name="mb_phone" id="mb_phone">
									<label class="error phoneError"></label>
								</div>
								<!-- 아이디찾기 버튼 -------------------------------------------------------- -->
								<button type="button" class="btn btn-id col-12">아이디 찾기</button>
							</div>
							<!-- box-result -------------------------------------------------------- -->	
							<div class="box-result" style="display: none;"></div>
						</div>
						<!-- 비밀번호 찾기 -------------------------------------------------------- -->
						<div id="pw" class="tab-pane fade">
							<!-- box-input -------------------------------------------------------- -->
							<div class="box-input">
								<!-- 이메일 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>이메일</label>
									<input type="text" class="form-control" name="mb_email" id="mb_email">
									<label class="error emailError"></label>
								</div>
								<!-- 이름 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>이름</label>
									<input type="text" class="form-control" name="mb_name" id="mb_name">
								</div>
								<!-- 핸드폰번호 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>핸드폰번호</label>
									<input type="text" class="form-control" name="mb_phone" id="mb_phone">
									<label class="error phoneError"></label>
								</div>
								<!-- 비밀번호 찾기 -------------------------------------------------------- -->
								<button type="button" class="btn btn-pw col-12">비밀번호 찾기</button>
							</div>
							<!-- box-result -------------------------------------------------------- -->	
							<div class="box-result" style="display: none;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- script **************************************************************************** -->
<script>
	$(function(){
		/* 이벤트 **************************************************************************** */	
		let type = '${type}';
		$('[href="#'+type+'"]').click();
		
		let emailRegex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		let phoneRegex = /^(010)-(\d{4})-(\d{4})$/;
		
		//유효성 검사----------------------------------------------------------------------
		//아이디 찾기 핸드폰 입력창 바뀌면 ------------------------------------------------------- 
		$('#id #mb_phone').change(function(){
			let mb_phone = $('#id #mb_phone').val();
			//전화번호 형식에 안맞으면
			if(!phoneRegex.test(mb_phone)){
				$('#id .phoneError').text('010-0000-0000 형식으로 입력해주세요.').show();
				$('#id #mb_phone').focus();
				return;
			}else
				$('#id .phoneError').hide();
		})
		//비밀번호 찾기 이메일 입력창 바뀌면 -------------------------------------------------------
		$('#pw #mb_email').change(function(){
			let mb_email = $('#pw #mb_email').val();
			//전화번호 형식에 안맞으면
			//이메일 형식에 안맞으면
			if(!emailRegex.test(mb_email)){
				$('#pw .emailError').text('이메일 형식에 맞게 작성해주세요.').show();
				$('#pw #mb_email').focus();
				return;
			}else
				$('#pw .emailError').hide();
		})
		//비밀번호 찾기 핸드폰 입력창 바뀌면 ------------------------------------------------------- 
		$('#pw #mb_phone').change(function(){
			let mb_phone = $('#pw #mb_phone').val();
			//전화번호 형식에 안맞으면
			if(!phoneRegex.test(mb_phone)){
				$('#pw .phoneError').text('010-0000-0000 형식으로 입력해주세요.').show();
				$('#pw #mb_phone').focus();
				return;
			}else
				$('#pw .phoneError').hide();
		})
		//아이디 찾기 클릭 -------------------------------------------------------
		$('.btn-id').click(function(){
			let mb_name = $('#id #mb_name').val();
			let mb_phone = $('#id #mb_phone').val();	
			//이름을 입력 안했으면
			if(mb_name == '' || mb_name.length == 0){
				$('#id #mb_name').focus();
				return;
			}
			//전화번호 입력 안했으면
			if(mb_phone == '' || mb_phone.length == 0){
				$('#id #mb_phone').focus();
				return;
			}
			//전화번호 형식에 안맞으면
			if(!phoneRegex.test(mb_phone)){
				$('#id .phoneError').text('010-0000-0000 형식으로 입력해주세요.').show();
				$('#id #mb_phone').focus();
				return;
			}
			//이메일 찾기
			let obj= {
				mb_name,
				mb_phone
			}
			ajaxPost(false, obj, '/find/email',function(data){
				//화면 재구성
				$('#id .box-input').hide(); //입력박스 사라짐
				$('#id .box-result').show(); //결과박스 보임
				let email = data.email;
				let html = '';
				//이메일 정보가 있으면
				if(email != null){
					//아이디 블라인드 처리
					email = blindEmail(email);
					//이메일 알려주고 로그인 버튼 보임
					html += '<div class="box-inform">';
					html += 	'<span>회원님의 아이디는 다음과 같습니다.</span><br>';
					html += 	'<b>'+email+'</b>';
					html += '</div>';
					html += '<a class="btn btn-login col-12" href="<c:url value="/account/login"></c:url>">로그인</a>';
					$('#id .box-result').append(html);
				}
				//이메일 정보가 없으면
				else{
					//일치하는 회원정보가 없다고 알려주고 회원가입 버튼 보임
					html += '<div class="box-inform">';
					html += 	'<span>일치하는 회원정보가 없습니다. 회원가입해주세요.</span>';
					html += '</div>';
					html += '<a class="btn btn-signup col-12" href="<c:url value="/account/signup"></c:url>">회원가입</a>';
					$('#id .box-result').append(html);
				}
			})
		})
		//비밀번호 찾기 클릭 -------------------------------------------------------
		$('.btn-pw').click(function(){
			let mb_email = $('#pw #mb_email').val();
			let mb_name = $('#pw #mb_name').val();
			let mb_phone = $('#pw #mb_phone').val();
			//이메일 입력 안했으면
			if(mb_email == '' || mb_email.length == 0){
				$('#pw #mb_email').focus();
				return;
			}
			//이메일 형식에 안맞으면
			if(!emailRegex.test(mb_email)){
				$('#pw .emailError').text('이메일 형식에 맞게 작성해주세요.').show();
				$('#pw #mb_email').focus();
				return;
			}
			//이름을 입력 안했으면
			if(mb_name == '' || mb_name.length == 0){
				$('#pw #mb_name').focus();
				return;
			}
			//전화번호 입력 안했으면
			if(mb_phone == '' || mb_phone.length == 0){
				$('#pw #mb_phone').focus();
				return;
			}
			//전화번호 형식에 안맞으면
			if(!phoneRegex.test(mb_phone)){
				$('#pw .phoneError').text('010-0000-0000 형식으로 입력해주세요.').show();
				$('#pw #mb_phone').focus();
				return;
			}
			//비밀번호 재설정
			let obj= {
				mb_email,
				mb_name,
				mb_phone
			}
			ajaxPost(false, obj, '/find/pw',function(data){
				//임시비밀번호 전송에 실패
				if(data.res == 0){
					alert('임시비밀번호 전송에 실패했습니다. 다시 시도해주세요.');
					return;
				}
				//화면 재구성
				$('#pw .box-input').hide(); //입력박스 사라짐
				$('#pw .box-result').show(); //결과박스 보임
				let html = '';
				//임시비밀번호 전송에 성공했으면
				if(data.res == 1){
					//임시비밀번호를 보냈다고 알려주고, 로그인 버튼 보임
					html += '<div class="box-inform">';
					html += 	'<span>메일로 임시비밀번호를 보냈습니다.<br> 이메일을 확인해주세요.</span>';
					html += '</div>';
					html += '<a class="btn btn-login col-12" href="<c:url value="/account/login"></c:url>">로그인</a>';
					$('#pw .box-result').append(html);
				}
				//일치하는 회원이 없으면
				if(data.res == -1){
					//일치하는 회원정보가 없다고 알려주고 회원가입 버튼 보임
					html += '<div class="box-inform">';
					html += 	'<span>일치하는 회원정보가 없습니다. 회원가입해주세요.</span>';
					html += '</div>';
					html += '<a class="btn btn-signup col-12" href="<c:url value="/account/signup"></c:url>">회원가입</a>';
					$('#pw .box-result').append(html);
				}
			})
		})
		//탭메뉴 클릭 -------------------------------------------------------
		$('.nav-link').click(function(){
			//입력칸이 보이고
			$('.box-input').show();
			$('.box-result').hide();
			//값 초기화
			$('input').val('');
			$('.error').hide();
		})
	})
/* 함수 **************************************************************************** */	
	//이메일 아이디 4글자 치환 ----------------------------------------------------------
	function blindEmail(email){
		if(email == '')
			return '';
		//이메일 아이디 4글자 ****로 치환
		//아이디 추출하기
		let atIndex = email.indexOf('@');
		let emailId = email.slice(0, atIndex);
		//이메일 블라인드 처리
		let remainEmail = ''; //앞에 블라인드 자르고 남은 이메일
		let blindEmail = ''; //일부 블라인드 처리한 이메일
		//아이디 길이가 5글자 이하이면
		if(emailId.length <= 5){
			remainEmail = email.slice(2);
			blindEmail = '**' + remainEmail;
		} 
		//아이디 길이가 5글자 초과이면
		else{
			remainEmail = email.slice(4);
			blindEmail = '****' + remainEmail;
		}
		return blindEmail;
	}
</script>
</body>
</html>