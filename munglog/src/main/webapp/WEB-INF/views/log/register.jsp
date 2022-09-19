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
	<form class="box-content">
		<!-- 안내문구 -------------------------------------------------------- -->
		<div class="box-message">최대 3마리 등록할 수 있습니다.</div>
		<!-- box-input(강아지 정보 입력) -------------------------------------------------------- -->
		<div class="box-input">
			<!-- 강아지 이름 입력 -------------------------------------------------------- -->
			<div class="form-group">
				<label>강아지 이름</label>
				<input type="text" class="form-control" name="dg_name" id="dg_name">
				<label class="error" for="dg_name"></label>
			</div>
			<!-- 강아지 등록번호 입력 -------------------------------------------------------- -->
			<div class="form-group">
				<label>강아지 등록번호</label>
				<input type="text" class="form-control" name="dg_reg_number" id="dg_reg_number">
				<label class="error" for="dg_reg_number"></label>
			</div>
			<!-- 강아지 생일 입력 -------------------------------------------------------- -->
			<div class="form-group">
				<label>강아지 생일</label>
				<input type="text" class="form-control" name="dg_birth" id="dg_birth">
				<label class="error" for="dg_birth"></label>
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
		/* 이벤트 **************************************************************************** */
		//강아지 추가 버튼클릭-------------------------------------------------------
		$(document).on('click','.box-content .box-more .btn-more', function(){
			//이전 버튼 삭제
			$('.box-more').remove();
			//화면 재구성
			let html = '';
			html += '<div class="box-input">';
			html += 	'<div class="box-close">';
			html += 		'<i class="fa-solid fa-xmark btn-close"></i>';
			html += 	'</div>';
			html += 	'<div class="form-group">';
			html += 		'<label>강아지 이름</label>';
			html += 		'<input type="text" class="form-control" name="dg_name" id="dg_name">';
			html +=			'<label class="error" for="dg_name"></label>';
			html +=		'</div>';
			html += 	'<div class="form-group">';
			html +=			'<label>강아지 등록번호</label>';
			html +=			'<input type="text" class="form-control" name="dg_reg_number" id="dg_reg_number">';
			html +=			'<label class="error" for="dg_reg_number"></label>';
			html +=		'</div>';
			html +=		'<div class="form-group">';
			html +=			'<label>강아지 생일</label>';
			html +=			'<input type="text" class="form-control" name="dg_birth" id="dg_birth">';
			html +=			'<label class="error" for="dg_birth"></label>';
			html +=		'</div>';
			html +=		'<hr>';
			html +=		'<div class="box-more">';
			html +=			'<i class="fa-solid fa-circle-plus btn-more"></i>';
			html +=		'</div>';
			html +=	'</div>';
			//버튼 앞에 붙임
			$('.main .box-content .btn-registration').before(html);
			let count = $('.main .box-content .box-input').length;
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
		})
	})
</script> 
</html>