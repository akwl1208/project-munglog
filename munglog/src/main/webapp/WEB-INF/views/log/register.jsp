<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main-강아지 정보 등록</title>
<!-- css ************************************************************ -->
<style>
	.main .box-title{
		background-color: #ae8a68; border-radius: 5px;
		padding: 20px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
		margin-bottom: 33px; font-size: 18px; font-weight: bold;
	}
	.main .box-title .fa-paw{margin-right: 6px;}
	.main .box-title .box-message{
		font-size: 12px; margin: 5px 0; padding-left: 24px;
	}
	.main .box-content{padding: 20px 44px;}
	.main .box-content .box-message{
		padding: 5px 0; text-align: right; font-size: 12px; font-weight: bold;
	}
	.main .box-content .box-input{position : relative;}
	.main .box-content .box-close{
		position: absolute; top: 5px; right: 5px;
	}
	.main .box-content .box-input .error{
		color: #fb9600; font-size: 12px;
	}
	.main .box-content hr{margin-bottom: 34px;}
	.main .box-content .box-more{
		text-align: center; color: #a04c00; margin-top: -18px;
	}
	.main .box-content .box-close .btn-close:hover{color: #fb9600;}
	.main .box-content .btn{
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-bottom: 10px;
		margin: 34px 0;
	}
	.main .box-content .btn:hover{color:#fff7ed;}
</style>
</head>
<!-- html ************************************************************ -->
<body>
	<!-- box-title -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>강아지 정보 등록</span>
		<div class="box-message">일지를 시작하기 위해 강아지 정보를 입력해주세요.</div>
	</div>
	<!-- box-content -------------------------------------------------------- -->
	<form class="box-content" method="post">
		<!-- 안내문구 -------------------------------------------------------- -->
		<div class="box-message">최대 3마리 등록할 수 있습니다.</div>
		<!-- box-input(강아지 정보 입력) -------------------------------------------------------- -->
		<div class="box-input">
			<!-- 강아지 이름 입력 -------------------------------------------------------- -->
			<div class="form-group">
				<label>강아지 이름 (필수)</label>
				<input type="text" class="form-control dg_name" name="dlist[0].dg_name" id="dg_name">
				<label class="error"></label>
			</div>
			<!-- 강아지 등록번호 입력 -------------------------------------------------------- -->
			<div class="form-group">
				<label>강아지 등록번호 (선택)</label>
				<input type="text" class="form-control dg_reg_num" name="dlist[0].dg_reg_num" id="dg_reg_num">
				<label class="error"></label>
			</div>
			<!-- 강아지 생일 입력 -------------------------------------------------------- -->
			<div class="form-group">
				<label>강아지 생일 (선택)</label>
				<input type="text" class="form-control dg_birth" name="dlist[0].dg_birth" id="dg_birth">
				<label class="error"></label>
			</div>
			<hr>
			<!-- 강아지 추가 버튼 -------------------------------------------------------- -->
			<div class="box-more">
				<i class="fa-solid fa-circle-plus btn-more"></i>
			</div>
		</div>
		<!-- 강아지 등록 입력 -------------------------------------------------------- -->
		<button type="submit" class="btn btn-registration col-12">강아지 정보 등록</button>
	</form>
</body>
<!-- script **************************************************************************** -->
<script>
	$(function(){
		let nameRegex = /^([가-힣]{1,10})|([a-zA-Z]{1,10})$/;
		let regNumRegex = /^(\d{15})$/;
		let birthRegex = /^(\d{4})-(\d{2})-(\d{2})$/;
	/* 이벤트 **************************************************************************** */
		//유효성 검사 ------------------------------------------------------- 
		//이름 입력창 바뀌면 ------------------------------------------------------- 
		$(document).on('change','.box-content .box-input .dg_name', function(){
			let dg_name = $(this).val();
			if(dg_name == ''){
				$(this).siblings('.error').text('필수항목입니다.').show();
				$(this).focus();
				return;
			}
			//이름 형식에 안맞으면
			if(!regex(nameRegex,dg_name,this,'영어 또는 한글로 1글자 이상 20자 이하로 입력해주세요.'))
				return;
			else
				$(this).siblings('.error').hide();
		})
		//등록번호 입력창 바뀌면 -------------------------------------------------------
		$(document).on('change','.box-content .box-input .dg_reg_num', function(){
			let dg_reg_num = $(this).val();
			//등록번호 형식에 안맞으면
			if(!regex(regNumRegex,dg_reg_num,this,'숫자 15글자 입력해주세요.'))
				return;			
			else
				$(this).siblings('.error').hide();
		})
		//생일 입력창 바뀌면 ------------------------------------------------------- 
		$(document).on('change','.box-content .box-input .dg_birth', function(){
			let dg_birth = $(this).val();
			//생일 형식에 안맞으면
			if(!regex(birthRegex,dg_birth,this,'2000-01-01 형식으로 입력해주세요.'))
				return false;	
			else
				$(this).siblings('.error').hide();
		})
		
		//강아지 추가 버튼클릭-------------------------------------------------------
		$(document).on('click','.box-content .box-more .btn-more', function(){
			//이전 버튼 삭제
			$('.box-more').remove();
			$('.box-close').remove();
			//화면 재구성
			let count = $('.main .box-content .box-input').length; 
			let html = '';
			html += '<div class="box-input">';
			html += 	'<div class="box-close">';
			html += 		'<i class="fa-solid fa-xmark btn-close"></i>';
			html += 	'</div>';
			html += 	'<div class="form-group">';
			html += 		'<label>강아지 이름 (필수)</label>';
			html += 		'<input type="text" class="form-control dg_name" name="dlist['+count+'].dg_name" id="dg_name'+count+'">';
			html +=			'<label class="error"></label>';
			html +=		'</div>';
			html +=		'<div class="form-group">';
			html +=			'<label>강아지 등록번호 (선택)</label>';
			html +=			'<input type="text" class="form-control dg_reg_num" name="dlist['+count+'].dg_reg_num" id="dg_reg_num'+count+'">';
			html +=			'<label class="error"></label>';
			html +=		'</div>';
			html +=		'<div class="form-group">';
			html +=			'<label>강아지 생일 (선택)</label>';
			html +=			'<input type="text" class="form-control dg_birth" name="dlist['+count+'].dg_birth" id="dg_birth'+count+'">';
			html +=			'<label class="error"></label>';
			html +=		'</div>';
			html +=		'<hr>';
			html +=		'<div class="box-more">';
			html +=			'<i class="fa-solid fa-circle-plus btn-more"></i>';
			html +=		'</div>';
			html +=	'</div>';
			//버튼 앞에 붙임
			$('.main .box-content .btn-registration').before(html);
			count = $('.main .box-content .box-input').length;
			//3개 생기면 더이상 박스 생성 막음
			if(count == 3){
				//화면 재구성
				$('.main .box-content .box-input hr').last().remove(); //마지막 구분선 삭제
				$('.main .box-content .box-input .box-more').remove(); //버튼 삭제
			}
		})
		
		//닫기 버튼(btn-close)클릭-------------------------------------------------------
		$(document).on('click','.box-content .box-close .btn-close', function(){
			let parent = $(this).parents('.box-input');
			//화면 재구성
			//입력박스 제거
			parent.remove();
			//더보기 버튼 추가
			let html = '';
			html +=	'<div class="box-more">';
			html +=		'<i class="fa-solid fa-circle-plus btn-more"></i>';
			html +=	'</div>';
			//버튼 앞에 있는 input 뒤에 더보기 추가
			$('.main .box-content .btn-registration').prev('.box-input').append(html);
			//닫기 버튼 추가
			if($('.main .box-content .box-input').length < 2)
				return;
			html = '';
			html +=	'<div class="box-close">';
			html +=		'<i class="fa-solid fa-xmark btn-close"></i>';
			html +=	'</div>';
			//input 박스 마지막의 앞에 닫기 버튼 추가
			$('.main .box-content .box-input').last().prepend(html);
		})
		
		//form 보내기 전-------------------------------------------------------
		$('form').submit(function(){
			//강아지 1마리 입력 --------------------------------------------------------------------------------
			let name1 = $('#dg_name').val();
			let name2 = '';
			let name3 =	'';
			//첫번째 입력칸 이름 작성했는지
			if(name1 == ''){
				$('#dg_name').siblings('.error').text('필수항목입니다.').show();
				$('#dg_name').focus();
				return false;
			}
			//이름 형식에 맞는지 확인
			if(!regex(nameRegex,name1,'#dg_name','영어 또는 한글로 1글자 이상 20자 이하로 입력해주세요.'))
				return false;
			//등록번호 입력했으면 형식에 안맞으면
			let regNum1 = $('#dg_reg_num').val();
			if(regNum1 != ''){
				if(!regex(regNumRegex,regNum1,'#dg_reg_num','숫자 15글자 입력해주세요.'))
					return false;			
			}
			let birth1 = $('#dg_birth').val();
			if(birth1 != ''){
				if(!regex(birthRegex,birth1,'#dg_birth','2000-01-01 형식으로 입력해주세요.'))
					return false;		
			}
			//강아지 2마리 입력 -> 두번째 입력칸 이름 작성했는지 --------------------------------------------------------
			if($('.main .box-content .box-input').length >= 2){
				name2 = $('#dg_name1').val();
				//입력했는지
				if(name2 == ''){
					$('#dg_name1').siblings('.error').text('필수항목입니다.').show();
					$('#dg_name1').focus();
					return false;
				}	
				//이름이 같으면
				if(name1 == name2){
					$('#dg_name1').siblings('.error').text('같은 이름입니다.').show();
					$('#dg_name1').focus();
					return false;
				}
				//이름 형식에 맞는지 확인
				if(!regex(nameRegex,name2,'#dg_name1','영어 또는 한글로 1글자 이상 20자 이하로 입력해주세요.'))
					return false;
				//등록번호 입력했으면 형식에 안맞으면
				let regNum2 = $('#dg_reg_num1').val();
				if(regNum2 != ''){
					if(!regex(regNumRegex,regNum2,'#dg_reg_num1','숫자 15글자 입력해주세요.'))
						return false;			
				}
				//생일 형식에 맞는지 확인
				let birth2 = $('#dg_birth1').val();
				if(birth2 != ''){
					if(!regex(birthRegex,birth2,'#dg_birth1','2000-01-01 형식으로 입력해주세요.'))
						return false;		
				}
			}
			//강아지 3마리 입력 -> 세번째 입력칸 이름 작성했는지 --------------------------------------------------------
			if($('.main .box-content .box-input').length == 3){
				name3 = $('#dg_name2').val();
				if(name3 == ''){
					$('#dg_name2').siblings('.error').text('필수항목입니다.').show();
					$('#dg_name2').focus();
					return false;
				}
				//이름이 같으면
				if(name3 == name2 || name3 == name1){
					$('#dg_name2').siblings('.error').text('같은 이름입니다.').show();
					$('#dg_name2').focus();
					return false;
				}
				//이름 형식에 맞는지 확인
				if(!regex(nameRegex,name3,'#dg_name2','영어 또는 한글로 1글자 이상 20자 이하로 입력해주세요.'))
					return false;
				//등록번호 입력했으면 형식에 안맞으면
				let regNum3 = $('#dg_reg_num2').val();
				if(regNum3 != ''){
					if(!regex(regNumRegex,regNum3,'#dg_reg_num2','숫자 15글자 입력해주세요.'))
						return false;			
				}
				//생일 형식에 맞는지 확인
				let birth3 = $('#dg_birth2').val();
				if(birth3 != ''){
					if(!regex(birthRegex,birth3,'#dg_birth2','2000-01-01 형식으로 입력해주세요.'))
						return false;		
				}
			}
			return true;
		})
	})
	/* 함수 **************************************************************************** */
	// 유효성 검사 후 메세지 반환 ------------------------------------------------
	function regex(regex, str, selector, message){
		if(!regex.test(str)){
			$(selector).siblings('.error').text(message).show();
			$(selector).focus();
			return false;
		}
		return true;
	}
</script> 
</html>