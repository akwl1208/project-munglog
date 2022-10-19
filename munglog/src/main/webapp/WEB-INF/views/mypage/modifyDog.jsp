<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main-강아지 정보 수정</title>
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
	.main .box-content .box-more .btn-more:hover{cursor:pointer;}
	.main .box-content .box-close .btn-close:hover{color: #fb9600; cursor:pointer;}
	.main .box-content .btn-modify{
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600;
	}
	.main .box-content .btn-modify:hover{color:#fff7ed;}
</style>
</head>
<!-- html ************************************************************ -->
<body>
	<!-- box-title -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>강아지 정보 수정</span>
		<div class="box-message">강아지 정보를 수정해주세요.</div>
	</div>
	<!-- box-content -------------------------------------------------------- -->
	<form class="box-content" method="post">
		<!-- 안내문구 -------------------------------------------------------- -->
		<p class="box-message">최대 3마리 등록할 수 있습니다.</p>
		<!-- box-input(강아지 정보 입력) -------------------------------------------------------- -->
		<c:forEach items="${dogList}" var="dog" varStatus="vs">
			<div class="box-input">
				<div class="box-close">
					<i class="fa-solid fa-xmark btn-close"></i>
				</div>				
				<input type="text" class="dg_num" name="dlist[${vs.index}].dg_num" value="${dog.dg_num}" style="display:none;">
				<div class="form-group">
					<label>강아지 이름 (필수)</label>
					<input type="text" class="form-control dg_name" name="dlist[${vs.index}].dg_name" id="dgName${vs.index}" value="${dog.dg_name}">
					<label class="error nameError mt-1"></label>
				</div>
				<div class="form-group">
					<label>강아지 등록번호 (선택)</label>
					<input type="text" class="form-control dg_reg_num" name="dlist[${vs.index}].dg_reg_num" 
						id="dgRegNum${vs.index}" value="${dog.dg_reg_num}" <c:if test="${dog.dg_reg_num != ''}">readonly</c:if>>
					<label class="error regNumError mt-1"></label>
				</div>
				<div class="form-group">
					<label>강아지 생일 (선택)</label>
					<input type="text" class="form-control dg_birth" name="dlist[${vs.index}].dg_birth"
						 id="dgBirth${vs.index}" <c:if test="${dog.dg_birth != null}">value="${dog.dg_birth_str}" readonly</c:if>>
					<label class="error birthError mt-1"></label>
				</div>
			</div>
			<hr>
			<c:if test="${vs.index < 3 && dogList.size() < 3}">
				<div class="box-more">
					<i class="fa-solid fa-circle-plus btn-more"></i>
				</div>
			</c:if>
		</c:forEach>
		<button type="submit" class="btn btn-modify col-12 mt-4">강아지 정보 수정</button>
	</form>
</body>
<!-- script **************************************************************************** -->
<script>
$(function(){
/* 변수 ***************************************************************************************************** */ 
	let nameRegex = /^[가-힣]{1,10}|[a-zA-Z]{1,10}$/;
	let regNumRegex = /^(\d{15})$/;
	let birthRegex = /^(\d{4})-(\d{2})-(\d{2})$/;
	let index = $('.main .box-content .box-input').length;
	const now = new Date();
	const thisYear = now.getFullYear();
	const thisMonth = now.getMonth()+1;
	const thisDate = now.getDate();
/* 이벤트 ***************************************************************************************************** */ 
	//이름 입력하면 ================================================================================================ 
	$(document).on('keyup','.box-content .box-input .dg_name', function(){
		$(this).siblings('.error').hide();
		let dg_name = $(this).val();
		if(dg_name == ''){
			$(this).siblings('.error').text('필수항목입니다.').show();
			$(this).focus();
			return;
		}
		//이름 형식에 안맞으면
		if(!regex(nameRegex,dg_name,this,'영어 또는 한글로 1글자 이상 10자 이하로 입력해주세요.'))
			return;		
	})//
	
	//등록번호 입력하면 ================================================================================================
	$(document).on('keyup','.box-content .box-input .dg_reg_num', function(){
		$(this).siblings('.error').hide();
		let dg_reg_num = $(this).val();
		//등록번호 형식에 안맞으면
		if(!regex(regNumRegex,dg_reg_num,this,'숫자 15글자 입력해주세요.'))
			return;
	})//
	
	//생일 입력하면 ================================================================================================ 
	$(document).on('keyup','.box-content .box-input .dg_birth', function(){
		$(this).siblings('.error').hide();
		let dg_birth = $(this).val();
		//생일 형식에 안맞으면
		if(!regex(birthRegex,dg_birth,this,'2000-01-01 형식으로 입력해주세요.'))
			return;
		//오늘 이후 날짜 입력했으면
		if(!compareDate(dg_birth, thisYear, thisMonth, thisDate)){
			$(this).siblings('.error').text('오늘보다 이후는 입력할 수 없습니다.').show();
			$(this).focus();
			return;
		}
	})//
	
	//강아지 추가 버튼클릭 ================================================================================================
	$(document).on('click','.box-content .box-more .btn-more', function(){
		//이전 버튼 삭제
		$('.box-more').remove();
		//화면 재구성 
		let html = '';
		html += '<div class="box-input">';
		html += 	'<div class="box-close">';
		html += 		'<i class="fa-solid fa-xmark btn-close"></i>';
		html += 	'</div>';
		html += 	'<input type="text" class="dg_num" name="dlist['+index+'].dg_num" value="0" style="display:none;">';
		html += 	'<div class="form-group">';
		html += 		'<label>강아지 이름 (필수)</label>';
		html += 		'<input type="text" class="form-control dg_name" name="dlist['+index+'].dg_name" id="dgName'+index+'">';
		html +=			'<label class="error nameError mt-1"></label>';
		html +=		'</div>';
		html +=		'<div class="form-group">';
		html +=			'<label>강아지 등록번호 (선택)</label>';
		html +=			'<input type="text" class="form-control dg_reg_num" name="dlist['+index+'].dg_reg_num" id="dgReg_num'+index+'">';
		html +=			'<label class="error regNumError mt-1"></label>';
		html +=		'</div>';
		html +=		'<div class="form-group">';
		html +=			'<label>강아지 생일 (선택)</label>';
		html +=			'<input type="text" class="form-control dg_birth" name="dlist['+index+'].dg_birth" id="dgBirth'+index+'">';
		html +=			'<label class="error birthError mt-1"></label>';
		html +=		'</div>';
		html +=	'</div>';
		html +=	'<hr>';
		html +=	'<div class="box-more">';
		html +=		'<i class="fa-solid fa-circle-plus btn-more"></i>';
		html +=	'</div>';
		//버튼 앞에 붙임
		$('.main .box-content .btn-modify').before(html);
		index++;
		let inputLength = $('.main .box-content .box-input').length;
		//3개 생기면 더이상 박스 생성 막음
		if(inputLength == 3)
			$('.main .box-content .box-more').remove(); //버튼 삭제
	})//
	
	//닫기 버튼(btn-close)클릭 =============================================================================
	$(document).on('click','.box-content .box-close .btn-close', function(){
		if(!confirm('강아지 정보를 삭제하겠습니까?정보를 삭제해도 사진은 삭제되지 않습니다.'))
			return;
		let parent = $(this).parents('.box-input');
		//화면 재구성
		parent.next().remove(); //구분선 삭제 
		parent.remove(); //입력박스 제거
		//더보기 버튼 추가
		let html = '';
		html +=	'<div class="box-more">';
		html +=		'<i class="fa-solid fa-circle-plus btn-more"></i>';
		html +=	'</div>';
		//버튼 앞에 있는 input 뒤에 더보기 추가
		$('.main .box-content .btn-modify').before(html);
		//강아지가 한마리면 삭제 버튼 없앰
		let inputLength = $('.main .box-content .box-input').length;
		if(inputLength == 1)
			$('.main .box-content .box-input .box-close').remove();
		//강아지 삭제 담기
		let dgNum = parent.find('.dg_num').val();
		html = '<input type="hidden" name="delNums" value="'+dgNum+'">';
		//버튼 앞에 있는 input 뒤에 더보기 추가
		$('.main .box-content .btn-modify').before(html);
	})//
	
	//form 보내기 전 ====================================================================================
	$('form').submit(function(){
		$('.error').hide();
		let pass = true;
		let inputLength = $('.main .box-content .box-input').length;
		//3개 생기면 더이상 박스 생성 막음
		if(inputLength > 3){
			alert('최대 3마리 등록가능합니다.');
			return false;
		}
		$('.main .box-content .box-input').each(function(){
			let name = $(this).find('.dg_name').val();
			//이름 입력 안했으면 ----------------------------------------------------------------------------
			if(name == ''){
				$(this).find('.nameError').text('필수항목입니다.').show();
				$(this).find('.dg_name').focus();
				pass = false;
				return false;
			}
			//이름 형식에 맞는지 확인 ----------------------------------------------------------------------------
			let nameId = $(this).find('.dg_name').attr('id');
			let selector = '#' + nameId;
			if(!regex(nameRegex, name, selector, '영어 또는 한글로 1글자 이상 10자 이하로 입력해주세요.')){
				pass = false;
				return false;
			}
			//내 강아지 중 이름이 같은 강아지 있으면 안됨
			let checkName = true;
			$(this).siblings().find('.dg_name').each(function(){
				if(name == $(this).val()){
					$(this).siblings('.error').text('같은 이름입니다.').show();
					checkName = false
					return false;
				}
			});
			if(!checkName){
				pass = false;
				return false;
			}
			//등록번호 입력했으면 형식에 맞는지 ----------------------------------------------------------------------------
			let regNum = $(this).find('.dg_reg_num').val();
			let regNumId = $(this).find('.dg_reg_num').attr('id');
			selector = '#' + regNumId;
			if(regNum != '' && !regex(regNumRegex ,regNum, selector,'숫자 15글자 입력해주세요.')){
				pass = false;
				return false;			
			}
			//생일 입력했으면 형식에 맞는지 ----------------------------------------------------------------------------
			let birth = $(this).find('.dg_birth').val();
			let birthId = $(this).find('.dg_birth').attr('id');
			selector = '#' + birthId;
			if(birth != '' && !regex(birthRegex, birth, selector,'2000-01-01 형식으로 입력해주세요.')){
				pass = false;
				return false;			
			}
			//오늘 이후 날짜 입력
			if(!compareDate(birth, thisYear, thisMonth, thisDate)){
				$(selector).siblings('.error').text('오늘보다 이후는 입력할 수 없습니다.').show();
				$(selector).focus();
				pass = false;
				return false;
			}
		});
		if(!pass)
			return false;
		if(!confirm('강아지 정보를 수정하겠습니까?'))
			return false;
	})//
});
/* 함수 ************************************************************************************************************* */
// 유효성 검사 후 메세지 반환 =====================================================================================
function regex(regex, str, selector, message){
	if(!regex.test(str)){
		$(selector).siblings('.error').text(message).show();
		$(selector).focus();
		return false;
	}
	return true;
}//

//날짜 비교 =====================================================================================
function compareDate(birth, thisYear, thisMonth, thisDate){
	let birthYear = birth.substring(0,4);
	let birthMonth = birth.substring(5,7);
	let birthDate = birth.substring(8,10);
	if(birthYear >= thisYear && birthMonth >= thisMonth && birthDate > thisDate)
		return false;
	return true;
}//
</script> 
</html>