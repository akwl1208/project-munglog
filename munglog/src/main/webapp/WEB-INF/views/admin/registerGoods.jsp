<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 등록</title>
<!-- css ************************************************************************************************************* -->
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
	.main .box-content .box-register label{font-weight: bold;}
	.main .box-content .box-register .box-thumb{
		border: 1px solid #dfe0df;
		width: 170px; height: 170px; text-align: center;
	}
	.main .box-content .box-register .box-thumb .fa-solid{line-height: 170px;}
	.main .box-content .box-register .box-thumb:hover,
	.main .box-content .box-register .item-delete:hover{color: #fb9600; cursor:pointer}
	.main .box-content .box-register .error{font-size: 12px; color: #fb9600;}
	.main .box-content .box-option .btn-add{
		background-color: #a04c00; border-radius: 3px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
	}
	.main .box-content .box-option thead{background-color: #dfe0df;}
	.main .box-content .box-option td, 
	.main .box-content .box-option tr{text-align: center;}
	.main .box-content .box-option td{vertical-align: middle;}
	.main .box-content .box-register .btn-register{
		box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-bottom: 10px;
	}
	.main .box-content .box-register .btn-register:hover{color:#fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 등록</span>
	<div class="box-message">굿즈를 등록하기 위해 상품 관련 정보를 입력해주세요..</div>
</div>	
<!-- box-content ----------------------------------------------------------------------------------------------------- -->			
<form class="box-content" enctype="multipart/form-data" method="post">
	<!-- box-register -------------------------------------------------------------------------------------------------- -->
	<div class="box-register">			
		<div class="clearfix">
		 	<!-- box-thumb ------------------------------------------------------------------------------------------------- -->			
			<div class="box-thumb float-left">				
				<div class="btn-file" style="width: 100%; height: 100%;"><i class="fa-solid fa-square-plus"></i></div>
				<input type="file" name="file" style="display: none;" accept="image/jpg, image/jpeg, image/png, image/gif">
				<img class="preview" width="100%" height="100%" style="display: none;">
			</div>
			<!-- 카테고리/제품명 ------------------------------------------------------------------------------------------------ -->						
			<div class="box-classification float-right" style="width:calc(100% - 170px - 20px)">
				<!-- 카테고리 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group">
					<label>카테고리</label>
					<select class="form-control" name="gs_ct_name">
						<option value="0">카테고리 선택</option>
						<c:forEach items="${categoryList}" var="category">
							<option value="${category.ct_name}">
								${category.ct_name}			
							</option>
						</c:forEach>
					</select>		
				</div>
				<!-- 상품명 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group mt-4">
					<label>상품명</label>
					<input type="text" class="form-control" name="gs_name" placeholder="상품명">			
				</div>
				<div class="error"></div>
			</div>
		</div>
		<!-- box-detail ----------------------------------------------------------------------------------------------------- -->				
		<div class="box-detail mt-4">
			<!-- box-option ----------------------------------------------------------------------------------------------------- -->
			<div class="box-option">
				<button type="button" class="btn-add mb-2 float-right p-1">옵션 추가</button>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th width="50%">옵션명</th>
							<th width="20%">수량</th>
							<th width="20%">가격</th>
							<th width="10%"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="item-name">
								<input type="text" class="ot_name form-control" name="optionList[0].ot_name" id="ot_name" placeholder="옵션명">			
							</td>
							<td class="item-amount">
								<input type="text" class="ot_amount form-control" name="optionList[0].ot_amount" id="ot_amount" placeholder="수량">
							</td>
							<td class="item-price">
								<input type="text" class="ot_price form-control" name="optionList[0].ot_price" id="ot_price" placeholder="가격">
							</td>
							<td class="item-delete"></td>
						</tr>
					</tbody>
				</table>
				<div class="error"></div>
			</div>
			<!-- box-description -------------------------------------------------------------------------------------- -->
			<div class="box-description mt-4">
				<div class="form-group">
					<label>상품 상세 정보</label>
					<textarea class="form-control" name="gs_description"></textarea>
				</div>
				<div class="form-group mt-4">
					<label>구매 가이드</label>
					<textarea class="form-control" name="gs_guidance"></textarea>
				</div>
			</div>
		</div>
		<!-- 굿즈 등록 버튼 ----------------------------------------------------------------------------------------------------- -->
		<button type="submit" class="btn-register col-12 mt-4">굿즈 등록</button>
	</div>
</form>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let count = 1;
	let optionRegex = /^[0-9]\d*$/;
/* 이벤트 *********************************************************************************************************** */
	$(function(){
		$(document).ready(function(){
			$('.main .box-content .box-register .error').hide();
			//썸머노트 ==============================================================================================
			$('[name=gs_description]').summernote({
				placeholder: '제품 설명을 입력하세요.',
				tabsize: 2,
				height: 400,
				minHeight: 400,
				lang: 'ko-KR',
				toolbar: [
				  ['style', ['style']],
				  ['font', ['bold', 'underline', 'clear']],
				  ['fontname', ['fontname']],
				  ['color', ['color']],
				  ['para', ['ul', 'ol', 'paragraph']],
				  ['table', ['table']],
				  ['insert', ['link', 'picture', 'video']]
				],
				callbacks: {
	  	   onImageUpload: function(files) {	
	  	  	if(files == null || files.length ==0)
	  	  		return;
	  			for(file of files){
		   	  	let data = new FormData();
		 	    	data.append('file',files[0]);
		 	    	let thisObj = $(this);
						ajaxPostData(data, '/upload/goodsImg', function(data){
	 	    			let url = '<%=request.getContextPath()%>/goods/img' + data.url;
	 	    			thisObj.summernote('insertImage', url);
	 	    		});
	  			}
	  	   }
	  	 }
			})//
			
			$('[name=gs_guidance]').summernote({
				placeholder: '구매 가이드 라인을 입력하세요.',
				tabsize: 2,
				height: 300,
				minHeight: 300,
				lang: 'ko-KR',
				toolbar: [
				  ['style', ['style']],
				  ['font', ['bold', 'underline', 'clear']],
				  ['fontname', ['fontname']],
				  ['color', ['color']],
				  ['para', ['ul', 'ol', 'paragraph']],
				  ['table', ['table']],
				]
			})//
			// 구매 가이드 양식 추가
			insertGuidance();
		})//
		
		// 사진 선택(btn-file), 미리보기(preview) =====================================================================
		$('.main .box-content .box-register .btn-file, .main .box-content .box-register .preview').click(function(){
			$('.main .box-content .box-register .box-thumb [name=file]').click();
		})//
		
		//사진 선택했으면(input:file) =================================================================================
		$('.main .box-content .box-register .box-thumb [name=file]').on('change', function(event) {
			//미리보기 화면 구성
			if(event.target.files.length == 0){
				$('.main .box-content .box-register .box-thumb .btn-file').show();
				$('.main .box-content .box-register .box-thumb .preview').hide();
				return;
			} else{
				$('.main .box-content .box-register .box-thumb .btn-file').hide();
				$('.main .box-content .box-register .box-thumb .preview').show();
			}
		  let file = event.target.files[0];
		  let reader = new FileReader(); 
		  
		  reader.onload = function(e) {
		  	$('.main .box-content .box-register .box-thumb .preview').attr('src', e.target.result);
		  }
		  reader.readAsDataURL(file);
		})//
		
		// 상품명 글자수 제한 이벤트 ==============================================================================
    $('.main .box-content .box-register [name=gs_name]').on('keyup', function() {	 
      if($(this).val().length > 30)
        $(this).val($(this).val().substring(0, 30));
    })//
    
		//옵션 추가 클릭(btn-add) ==============================================================================
    $('.main .box-content .box-register .box-option .btn-add').click(function() {	
    	//테이블 추가
			let html = '';
			html += '<tr>';
			html +=  '<td class="item-name">';
			html +=   '<input type="text" class="ot_name form-control" name="optionList['+count+'].ot_name" id="ot_name" placeholder="옵션명">';			
			html +=  '</td>';
			html +=  '<td class="item-amount">';
			html += 		'<input type="text" class="ot_amount form-control" name="optionList['+count+'].ot_amount" id="ot_amount" placeholder="수량">';
			html += 	'</td>';
			html += 	'<td class="item-price">';
			html += 		'<input type="text" class="ot_price form-control" name="optionList['+count+'].ot_price" id="ot_price" placeholder="가격">';
			html += 	'</td>';
			html += 	'<td class="item-delete"><i class="btn-delete fa-solid fa-trash"></i></td>';
			html += '</tr>';
			//버튼 앞에 붙임
			$('.main .box-content .box-option tbody').append(html);
			count++;
    })//

		//옵션 삭제 클릭(btn-delete) ==============================================================================
    $(document).on('click', '.main .box-content .box-register .box-option .btn-delete', function() {
    	if(!confirm('다음 옵션을 삭제하시겠습니까?'))
    		return;
    	$(this).parents('tr').remove();
    	//옵션 추가한 걸 모두 삭제했으면 count를 1로 되돌림
			let optionTr = $('.main .box-content .box-register .box-option tbody tr');
			let length = optionTr.length;
			if(length == 1)
				count = 1;
    })//
    
		//form 보내기 전 ==========================================================================================
		$('form').submit(function(){
			$('.main .box-content .box-register .error').hide();
			//카테고리 선택했는지 ---------------------------------------------------------------------
			let gs_ct_name = $('.main .box-content .box-register [name=gs_ct_name]').val();
			if(gs_ct_name == 0){
				$('.main .box-content .box-register .box-classification .error').text('카테고리를 선택해주세요.').show();
				$('.main .box-content .box-register [name=gs_ct_name]').focus();
				return false;
			}
			//상품명 입력했는지 -------------------------------------------------------------------------
			let gs_name = $('.main .box-content .box-register [name=gs_name]').val();
			if(gs_name == ''){
				$('.main .box-content .box-register .box-classification .error').text('상품명을 입력해주세요.').show();
				$('.main .box-content .box-register [name=gs_name]').focus();
				return false;
			}
			if(gs_name.length > 30){
				$('.main .box-content .box-register .box-classification .error').text('30자 이하로 작성해주세요.').show();
				$('.main .box-content .box-register [name=gs_name]').focus();
				return false;
			}
			//옵션 입력했는지 -------------------------------------------------------------------------
			let optionTr = $('.main .box-content .box-register .box-option tbody tr');
			let length = optionTr.length;
			for(let i = 0; i < length; i++){
				//옵션명
				let ot_name = optionTr.eq(i).find('#ot_name').val();
				if(ot_name == ''){
					$('.main .box-content .box-register .box-option .error').text('옵션명을 입력해주세요.').show();
					optionTr.eq(i).find('#ot_name').focus();
					return false;
				}
				if(ot_name.length > 10){
					$('.main .box-content .box-register .box-option .error').text('옵션명을 10자 이하로 작성해주세요.').show();
					optionTr.eq(i).find('#ot_name').focus();
					return false;
				}		
				//수량
				let ot_amount = optionTr.eq(i).find('#ot_amount').val();
				if(ot_amount == ''){
					$('.main .box-content .box-register .box-option .error').text('옵션 수량을 입력해주세요.').show();
					optionTr.eq(i).find('#ot_amount').focus();
					return false;
				}
				if(!optionRegex.test(Number(ot_amount))){
					$('.main .box-content .box-register .box-option .error').text('수량을 0개 이상 숫자로 입력해주세요.').show();
					optionTr.eq(i).find('#ot_amount').focus();
					return false;
				}
				//가격
				let ot_price = optionTr.eq(i).find('#ot_price').val();
				if(ot_price == ''){
					$('.main .box-content .box-register .box-option .error').text('옵션 가격을 입력해주세요.').show();
					optionTr.eq(i).find('#ot_price').focus();
					return false;
				}
				if(!optionRegex.test(Number(ot_price))){
					$('.main .box-content .box-register .box-option .error').text('가격을 0원 이상 숫자로 입력해주세요.').show();
					optionTr.eq(i).find('#ot_price').focus();
					return false;
				}
			}
			//등록할건지 묻기
			if(!confirm('굿즈를 등록하겠습니까?'))
				return false;
		})//
	});	

/* 함수 *********************************************************************************************************** */
	//insertGuidance : 구매 가이드에 양식 넣기 ======================================================================== 
	function insertGuidance(){
		let html = '';
		html += '<table class="table table-bordered" style="width: 663px;">';
		html += 	'<tbody>';
		html += 		'<tr>';
		html += 			'<td>';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px; text-align: center;">';
		html += 					'상품결제안내';
		html += 				'</span>';
		html += 			'</td>';
		html += 			'<td>';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.';
		html += 					'확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. &nbsp;';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. &nbsp;';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'주문시 입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며&nbsp;입금되지 않은 주문은 자동취소 됩니다.';
		html += 				'</span>';
		html += 			'</td>';
		html += 		'</tr>';
		html += 		'<tr>';
		html += 			'<td>';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px; text-align: center;">';
		html += 					'교환/환불';
		html += 				'</span>';
		html += 			'</td>';
		html += 			'<td>';
		html += 				'<span style="font-weight: bolder; color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'교환 및 반품 주소';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="font-weight: bolder; color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'<br><br>';
		html += 					'교환 및 반품이 가능한 경우';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 상품을 공급 받으신 날로부터 7일이내 단, 가전제품의';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;경우 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환/반품이 불가능합니다.';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;다르거나 다르게 이행된 경우에는 공급받은 날로부터 3월이내, 그사실을 알게 된 날로부터 30일이내';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="font-weight: bolder; color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'교환 및 반품이 불가능한 경우';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;포장 등을 훼손한 경우는 제외';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;(예 : 가전제품, 식품, 음반 등, 단 액정화면이 부착된 노트북, LCD모니터, 디지털 카메라 등의 불량화소에';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;따른 반품/교환은 제조사 기준에 따릅니다.)';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 단, 화장품등의 경우 시용제품을';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;제공한 경우에 한 합니다.';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'- 복제가 가능한 상품등의 포장을 훼손한 경우';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다.';
		html += 				'</span>';
		html += 				'<br style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'&nbsp;&nbsp;(색상 교환, 사이즈 교환 등 포함)';
		html += 				'</span>';
		html += 			'</td>';
		html += 		'</tr>';
		html += 		'<tr>';
		html += 			'<td>';
		html += 				'<span style="color: rgb(53, 53, 53); font-family: Pretendard-Regular, sans-serif; font-size: 12px; text-align: center;">';
		html += 					'배송안내';
		html += 				'</span>';
		html += 			'</td>';
		html += 			'<td>';
		html += 				'<ul class="delivery" style="margin-bottom: 0px; margin-left: -10px; font-family: Pretendard-Regular, sans-serif; font-size: 12px;">';
		html += 					'<li style="padding-left: 15px; list-style-position: initial; list-style-image: initial; line-height: 20px;">';
		html += 						'배송 방법 : 택배';
		html += 					'</li>';
		html += 					'<li style="padding-left: 15px; list-style-position: initial; list-style-image: initial; line-height: 20px;">';
		html += 						'배송 지역 : 전국지역';
		html += 					'</li>';
		html += 					'<li style="padding-left: 15px; list-style-position: initial; list-style-image: initial; line-height: 20px;">';
		html += 					'배송 비용 : 무료';
		html += 					'</li>';
		html += 					'<li style="padding-left: 15px; list-style-position: initial; list-style-image: initial; line-height: 20px;">';
		html += 						'배송 기간 : 3일 ~ 7일';
		html += 					'</li>';
		html += 					'<li style="padding-left: 15px; list-style-position: initial; list-style-image: initial; line-height: 20px;">';
		html += 						'배송 안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br>';
		html += 						'고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.';
		html += 					'</li>';
		html += 				'</ul>';
		html += 			'</td>';
		html += 		'</tr>';
		html += 	'</tbody>';
		html += '</table>';
		$('.main .box-content .box-register [name=gs_guidance]').summernote('pasteHTML', html);
	}//
</script>
</html>