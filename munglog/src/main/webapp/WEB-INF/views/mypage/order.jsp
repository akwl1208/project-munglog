<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 주문/배송</title>
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
	/* box-search ------------------------------------------------------------ */
	.main .box-content .box-search{
		background-color: #fff7ed; border: 1px solid #d7d5d5;
		padding: 10px;
	}
	.main .box-content .box-search table td{border: 0;}
	.main .box-content .box-search .btn-search{
		padding: 0 15px; background-color: #a04c00;
		border: none;border-radius: 3px;
		display: inline-block; height: 38px;
	}
	.main .box-content .box-search .btn-search .fa-solid{
		color: #fff7ed; line-height: 38px;
	}
	/* box-pay ------------------------------------------------------------ */
	.main .box-content .box-pay .list-goods{
		border-top: 2px solid #ae8a68;
		border-bottom: 2px solid #ae8a68;
	}
	.main .box-content .box-pay .item-goods{
		display: table; width: 100%; min-height: 161px;
	  	padding: 23px 0; table-layout: fixed;
	}
	.main .box-content .box-pay .item-goods+.item-goods{
		border-top: 1px solid #d7d5d5;
	}
	.main .box-content .box-pay .item-goods .box-goods{
		position: relative; padding-left: 120px;
	}
	.main .box-content .box-pay .item-goods>div{
		display: table-cell; vertical-align: middle;
	}
	.main .box-content .box-pay .item-goods .box-goods .link-goods,
	.main .box-content .box-pay .item-goods .modal-body .goodsThumb{
		position: absolute; left: 9px; top: 50%;
		width: 90px; height: 90px;
	  margin-top: -45px; text-align: center; overflow: hidden;
	}
	.main .box-content .box-pay .item-goods .box-goods .link-goods .gs_thumb,
	.main .box-content .box-pay .item-goods .modal-body .goodsThumb .gs_thumb{
		vertical-align: top; width: 90px; height: 90px;
	}
	.main .box-content .box-pay .item-goods .box-goods-info .gs_name{
		max-width: 100%; 
		overflow: hidden; white-space: nowrap; text-overflow: ellipsis;
	}
	.main .box-content .box-pay .item-goods .box-goods-info .link-orderDetail .gs_name:hover{color:#fb9600}
	.main .box-content .box-pay .item-goods .box-goods-info .goods-info{margin: 8px 0px 12px;}
	.main .box-content .box-pay .item-goods .box-goods-info .goods-info li{
		display: inline-block; line-height: 18px; position: relative;
	}
	.main .box-content .box-pay .item-goods .box-goods-info .goods-info li+li::before{
		position: absolute; left: 0; top: 50%;
	  width: 1px; height: 17px; margin-top: -8px;
	  background-color: #d7d5d5; content: '';
	}
	.main .box-content .box-pay .item-goods .box-button .btn-request{
		width: 90%; padding: 2px 0; line-height: 27px;
	  font-size: 12px; color: #a04c00; font-weight: bold; 
		background-color: white; border: 1px solid #a04c00;  border-radius: 3px;
	}
	.main .box-content .box-pay .item-goods .box-button .btn-request+.btn-request{margin-top: 4px;}
	.main .box-content .box-pay .item-goods .box-button .btn-request:hover{
		background-color: #a04c00; color: #fff7ed;
	}
	.main .box-content .box-pay .item-goods .modal-body .box-review{
		padding: 15px 9px 0; border-top: 1px solid #d7d5d5;
		margin-top: 30px;
	}
	.main .box-content .box-pay .item-goods .modal-body .rv_rating{font-size: 36px;}
	.main .box-content .box-pay .item-goods .modal-body .rv_rating .fa-solid{color: #a04c00;}
	.main .box-content .box-pay .item-goods .modal-body .box-image .btn{
		padding: 5px; background-color: #a04c00;
		border: none; color: #fff7ed; border-radius: 3px;
		display: inline-block; margin-top: 5px;
	}
	.main .box-content .box-pay .item-goods .modal-body .box-image .preview,
	.main .box-content .box-pay .item-goods .modal-body .box-image .modiPreview{
		max-width: 150px; max-height: 150px;
	}
	.main .box-content .box-pay .item-goods .modal-footer .btn{
		display: inline-block; border: 1px solid #dfe0df; padding: 10px 20px;
		font-weight: bold; width: 48%;
	}
	.main .box-content .box-pay .item-goods .modal-footer .btn-register,
	.main .box-content .box-pay .item-goods .modal-footer .btn-modify{
		background-color: #fb9600; color: #fff7ed;
	}
	.main .box-content .box-pay .item-goods .modal-footer .btn-cancel,
	.main .box-content .box-pay .item-goods .modal-footer .btn-modi-cancel{background-color: #fff7ed; margin-left: 1%;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>주문/배송 조회</span>
	<div class="box-message">주문한 굿즈의 주문 및 배송 현황을 확인하고, 관리하세요.</div>
</div>		
<!-- box-content ------------------------------------------------------------------------------------------------- -->	
<div class="box-content">
	<!-- box-search) --------------------------------------------------------------------------------------------- -->
	<div class="box-search mb-5">
		<table class="table border-0 m-0">
			<tbody>
				<!-- 날짜 검색 --------------------------------------------------------------------------------- -->
				<td>
					<div class="input-group">
						<input type="text" class="fromDate form-control" id="fromDate">
						<span class="ml-2 mr-2">-</span>
						<input type="text" class="toDate form-control" id="toDate">
					</div>
				</td>
				<!-- 주문 현황 검색 ------------------------------------------------------------------------------ -->
				<td>
					<div class="box-select form-group m-0">
						<select class="form-control" id="sel1">
							<option>전체 상태</option>
							<option>입금전</option>
							<option>배송준비중</option>
							<option>배송완료</option>
							<option>구매확정</option>
							<option>취소</option>
							<option>교환</option>
						</select>
					</div>
				</td>
				<!-- 검색 버튼 ---------------------------------------------------------------------------- -->
				<td>
					<div class="box-btn">
						<a href="#" class="btn-search"><i class="fa-solid fa-magnifying-glass"></i></a>
					</div>
				</td>
			</tbody>
		</table>
	</div>
	<!-- box-pay(제목) ------------------------------------------------------------------------------------------------- -->
	<div class="box-pay">
		<div class="box-goods-pay"></div>
	</div>
</div>

</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let user = '${user.mb_num}';
	let page = 1;
	let cri = {
		page,
		perPageNum : 5,
	};
	let modiStar;
	let modiContent;
	let delModiImage = true; //수정이미지 삭제
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		getMyOrderList(cri);
	})//
	
	//datepicker ===============================================================================================
	let dateFormat = 'yy-mm-dd';
  $('#fromDate, #toDate').datepicker({
		changeMonth: true,
	  	changeYear: true,
		maxDate: 0,
		dateFormat
	  })//
	  $('#toDate').datepicker({
		changeMonth: true,
		changeYear: true,
		maxDate: 0,
		dateFormat
	})//
   
	//별 클릭 ===============================================================================================
  $(document).on('click', '.main .box-content .box-pay .modal-body .box-review .box-rating .rv_rating .fa-star', function(){
  	let index = $(this).index();
  	let modalId = $(this).parents('.modal').attr('id');
  	$('.main .box-content #'+modalId+' .rv_rating .fa-star').each(function(i){
  		if(i <= index){
			let star = '<i class="star fa-solid fa-star"></i>';
   		$(this).before(star);
  		}else{
			let blankStar = '<i class="fa-regular fa-star"></i>';
  			$(this).before(blankStar);
  		}
  		$(this).remove(); 
  	});
  })//
   
	//모달 닫기 클릭 ===============================================================================================
  $(document).on('click', '.main .modal .btn-close, .main .modal .btn-cancel', function(){
  	let modalId = $(this).parents('.modal').attr('id');
  	//별점 초기화
  	$('.main .box-content #'+modalId+' .rv_rating .fa-star').each(function(i){
		let blankStar = '<i class="fa-regular fa-star"></i>';
 			$(this).before(blankStar);
  		$(this).remove(); 
  	});
  	//사용 후기 초기화
  	$('.main .box-content #'+modalId+' .box-review-content .rv_content').val('');
  	//사진 초기화
  	$('.main .box-content #'+modalId+' .box-image input:file').val(''); //파일 비우기
  	$('.main .box-content  #'+modalId+' .box-image .preview').hide();
  })//
   
	//사진 선택 클릭 ===============================================================================================
  $(document).on('click', '.main .box-content .box-pay .modal-body .box-image .btn-image', function(){
  	let modalId = $(this).parents('.modal').attr('id');
  	$('.main .box-content #'+modalId+' .box-image input:file').click();
  })//
   
	//파일 선택하면 ===============================================================================================
	$(document).on('change','.main .box-content .box-pay .modal-body .box-image input:file',function(event) {
		let modalId = $(this).parents('.modal').attr('id');
		//미리보기 화면 구성
		if(event.target.files.length == 0 && !delModiImage){
			$('.main .box-content #'+modalId+' .box-image .modiPreview').show();
			$('.main .box-content #'+modalId+' .box-image .preview').hide();
			$('.main .box-content #'+modalId+' .box-image .btn-del-image').show();
			return;
		} else if(event.target.files.length != 0 && !delModiImage){
			$('.main .box-content #'+modalId+' .box-image .modiPreview').hide();
			$('.main .box-content #'+modalId+' .box-image .preview').show(); 
			$('.main .box-content #'+modalId+' .box-image .btn-del-image').hide();
		} else if(event.target.files.length == 0 && delModiImage){
			$('.main .box-content #'+modalId+' .box-image .preview').hide();
			$('.main .box-content #'+modalId+' .box-image .btn-del-image').hide();
			return;
		} else if(event.target.files.length != 0 && delModiImage){
			$('.main .box-content #'+modalId+' .box-image .preview').show();
			$('.main .box-content #'+modalId+'  .box-image .btn-del-image').hide();
		}
		
	  let file = event.target.files[0];
	  let reader = new FileReader(); 
	  
	  reader.onload = function(e) {
	  	$('.main .box-content  #'+modalId+' .box-image .preview').attr('src', e.target.result);
	  }
	  reader.readAsDataURL(file);
	})//
	
	//리뷰 등록 클릭 ===============================================================================================
  $(document).on('click', '.main .box-content .box-pay .modal-footer .btn-register', function(){
	  let modalId = $(this).parents('.modal').attr('id');
	  let rv_rating = $('.main .box-content #'+modalId+' .rv_rating .star').length;
	  let rv_content = $('.main .box-content #'+modalId+' .box-review-content .rv_content').val();
	  //정보 입력 제대로 했는지 확인
	  if(!validateReviewInfo(modalId, rv_rating, rv_content))
		  return;
		if(!confirm('리뷰는 삭제할 수 없습니다. 리뷰를 등록하겠습니까?'))
			return;
		//주문상세 번호 가져오기
		let rv_od_num = $('.main .box-content #'+modalId).data('value');
		//리뷰 등록
		let data = new FormData();
		data.append('rv_od_num', rv_od_num);
		data.append('rv_rating', rv_rating);
		data.append('rv_content', rv_content);
		data.append('file', $('.main .box-content #'+modalId+' .box-image input:file')[0].files[0]);
		registerReview(data, modalId);
  })//
  
	//리뷰 수정 클릭 ===============================================================================================
  $(document).on('click', '.main .box-content .box-pay .box-button .btn-request.btn-modify', function(){
		let modalId = $(this).data('target');
		modiStar = $('.main .box-content '+modalId+' .rv_rating .star').length;
		modiContent = $('.main .box-content '+modalId+' .box-review-content .rv_content').val(); 
		let hasModiImg = $('.main .box-content '+modalId+' .box-image .modiPreview').attr('src');
		if(hasModiImg == '')
			delModiImage = true;
		else
			delModiImage = false;
  })//
  
	//수정 모달 닫기 클릭 ===============================================================================================
  $(document).on('click', '.main .modal .btn-modi-close, .main .modal .btn-modi-cancel', function(){
  	let modalId = $(this).parents('.modal').attr('id');
  	let html = '';
  	//별점 초기화
		for(let i = 1; i <= modiStar; i++){
			html += '<i class="star fa-solid fa-star"></i>';
		}
		for(let i = modiStar + 1 ; i <= 5; i++){
			html += '<i class="fa-regular fa-star"></i>';
		}
		$('.main .box-content #'+modalId+' .box-rating .rv_rating').html(html);
  	//사용 후기 초기화
  	$('.main .box-content #'+modalId+' .box-review-content .rv_content').val(modiContent);
  	//사진 초기화
  	$('.main .box-content #'+modalId+' .box-image input:file').val(''); //파일 비우기
  	$('.main .box-content  #'+modalId+' .box-image .preview').hide();
  	$('.main .box-content  #'+modalId+' .box-image .modiPreview').show();
  	//버튼 초기화
  	let hasModiImg = $('.main .box-content #'+modalId+' .box-image .modiPreview').attr('src');
		if(hasModiImg != ''){
			delModiImage = false;			
			$('.main .box-content #'+modalId+' .box-image .btn-del-image').show();
		}
		else{
			delModiImage = true;
			$('.main .box-content #'+modalId+' .box-image .btn-del-image').hide();
		}
  })//
  
	//리뷰 수정 클릭 ===============================================================================================
  $(document).on('click', '.main .box-content .box-pay .modal-footer .btn-modify', function(){
	  let modalId = $(this).parents('.modal').attr('id');
	  let rv_rating = $('.main .box-content #'+modalId+' .rv_rating .star').length;
	  let rv_content = $('.main .box-content #'+modalId+' .box-review-content .rv_content').val();
	  //정보 입력 제대로 했는지 확인
	  if(!validateReviewInfo(modalId, rv_rating, rv_content))
		  return;
		if(!confirm('리뷰를 수정하겠습니까?'))
			return;
		//주문상세 번호 가져오기
		let rv_od_num = $('.main .box-content #'+modalId).data('odnum');
		let rv_num = $('.main .box-content #'+modalId).data('rvnum');
		//리뷰 등록
		let data = new FormData();
		data.append('rv_num', rv_num);
		data.append('rv_od_num', rv_od_num);
		data.append('rv_rating', rv_rating);
		data.append('rv_content', rv_content);
		data.append('file', $('.main .box-content #'+modalId+' .box-image input:file')[0].files[0]);
		data.append('delModiImage', delModiImage);
		modifyReview(data, modalId);
  })//
  
	//리뷰 수정에서 사진 삭제 클릭 ===============================================================================================
  $(document).on('click', '.main .box-content .box-pay .modal-body .box-image .btn-del-image', function(){
	  let modalId = $(this).parents('.modal').attr('id');
	  delModiImage = true;
	  $('.main .box-content  #'+modalId+' .box-image .modiPreview').hide();
	  $(this).hide();
  })//
});
	
/* 함수 *********************************************************************************************************** */
 	//getMyOrderList : 나의 주문 내역 가져오기 ======================================================================
	function getMyOrderList(obj){
		ajaxPost(false, obj, '/get/myOrderList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			//리스트 구현-----------------------------------------------------------------------------------
			for(order of data.orderList){
				html += '<h6 class="or_code font-weight-bold">'+order.or_code+'</h6>';
				html += 	'<ul class="list-goods">';
				for(orderDetail of data.orderDetailList){
					if(order.or_code == orderDetail.or_code){
						html += '<li class="item-goods">';
						html += 	'<div class="box-goods">';
						html += 		'<a href="'+contextPath+'/goods/goodsDetail/'+orderDetail.gs_num+'" class="link-goods">';
						html += 			'<img class="gs_thumb" src="'+contextPath+orderDetail.gs_thumb_url+'">';
						html += 		'</a>';
						html += 		'<div class="box-goods-info">';
						html += 			'<a href="#" class="link-orderDetail" style="display: block;">';
						html += 				'<p class="gs_name font-weight-bold">'+orderDetail.gs_name+'</p>';
						html += 				'<ul class="goods-info">';
						html += 					'<li class="price font-weight-bold pr-2">';
						html += 						'<span class="od_total_price">'+orderDetail.od_total_price_str+'</span>';
						html += 					'</li>';
						html += 					'<li class="amount pl-2 pr-2">';
						html += 						'<span class="od_amount">'+orderDetail.od_amount_str+'</span>';
						html += 					'</li>';
						html += 					'<li class="date pl-2">';
						html += 						'<span class="or_date">'+orderDetail.or_date_str+'</span>';
						html += 					'</li>';
						html += 				'</ul>';
						html += 			'</a>';
						html += 		'</div>';
						html += 	'</div>';
						html += 	'<div class="box-state text-center" style="width: 150px;">';
						html += 		'<a href="#" class="link-delivery">';
						html += 			'<span class="od_state">'+orderDetail.od_state+'</span>';
						html += 		'</a>';
						html += 	'</div>';
						html += 	'<div class="box-button" style="width: 110px;">';
						let review = getMyReview(orderDetail.od_num);
						if(orderDetail.od_state == '입금전' || orderDetail.od_state == '배송준비중')
							html += 	'<a href="#" class="btn btn-request btn-cancel">주문 취소</a>';
						else if(orderDetail.od_state == '배송완료'){
							html += 	'<a href="#" class="btn btn-request btn-decision">구매 확정</a>';
							html += 	'<a href="#" class="btn btn-request btn-exchange">교환 요청</a>';
							html += 	'<a href="#" class="btn btn-request btn-refund">반품 요청</a>';								
						}
						else if(orderDetail.od_state == '구매확정' && review == null){
							html += 	'<a href="#" class="btn btn-request btn-review" data-toggle="modal" data-target="#review'+orderDetail.od_num+'">리뷰 작성</a>';
							html += 	'<div class="modal fade" id="review'+orderDetail.od_num+'" data-value="'+orderDetail.od_num+'">';
							html += 		'<div class="modal-dialog modal-dialog-centered">';
							html += 			'<div class="modal-content">';
							html += 				'<div class="modal-header">';
							html += 					'<h4 class="modal-title font-weight-bold d-block">';
							html += 						'<i class="fa-solid fa-paw mr-2"></i>리뷰 작성';
							html += 					'</h4>';
							html += 					'<div class="box-message" style="line-height: 38px;">';
							html += 						'<small>리뷰를 작성하고 포인트 적립하세요.</small>';
							html += 					'</div>';
							html += 					'<button type="button" class="btn btn-close" data-dismiss="modal">';
							html += 						'<i class="fa-solid fa-xmark"></i>';
							html += 					'</button>';
							html += 				'</div>';
							html += 				'<div class="modal-body">';
							html += 					'<div class="box-goods mt-3">';
							html += 						'<div class="goodsThumb">';
							html += 							'<img class="gs_thumb" src="'+contextPath+orderDetail.gs_thumb_url+'">';
							html += 						'</div>';
							html += 						'<div class="box-goods-info">';
							html += 							'<p class="gs_name font-weight-bold">'+orderDetail.gs_name+'</p>';
							html += 							'<ul class="goods-info">';
							html += 								'<li class="price font-weight-bold pr-2">';
							html += 									'<span class="od_total_price">'+orderDetail.od_total_price_str+'</span>';
							html += 								'</li>';
							html += 								'<li class="amount pl-2 pr-2">';
							html += 									'<span class="od_amount">'+orderDetail.od_amount_str+'</span>';
							html += 								'</li>';
							html += 								'<li class="date pl-2">';
							html += 									'<span class="or_date">'+orderDetail.or_date_str+'</span>';
							html += 								'</li>';
							html += 							'</ul>';
							html += 						'</div>';
							html += 					'</div>';
							html += 					'<div class="box-review">';
							html += 						'<div class="box-rating mb-3">';
							html += 							'<strong>별점</strong>';
							html += 							'<div class="rv_rating d-flex justify-content-center" >';
							html += 								'<i class="fa-regular fa-star"></i>';
							html += 								'<i class="fa-regular fa-star"></i>';
							html += 								'<i class="fa-regular fa-star"></i>';
							html += 								'<i class="fa-regular fa-star"></i>';
							html += 								'<i class="fa-regular fa-star"></i>';
							html += 							'</div>';
							html += 						'</div>';
							html += 						'<div class="box-review-content">';
							html += 							'<strong>사용 후기</strong>';
							html += 							'<div class="mt-2">';
							html += 								'<textarea class="rv_content" rows="5" style="resize: none; width: 100%;" placeholder="10자 이상 작성해주세요"></textarea>';
							html += 							'</div>';
							html += 						'</div>';
							html += 						'<div class="box-image text-right">';
							html += 							'<a href="javascript:0;" class="btn btn-image">사진 선택</a>';
							html += 							'<input type="file" style="display: none;" accept="image/jpg, image/jpeg, image/png, image/gif">';
							html += 							'<div class="box-preview text-center mt-2">';
							html += 								'<img class="preview" style="display: none;">';
							html += 							'</div>';
							html += 						'</div>';
							html += 					'</div>';
							html += 				'</div>';  
							html += 				'<div class="modal-footer">';
							html += 					'<button type="button" class="btn btn-register">리뷰 작성</button>';
							html += 					'<button type="button" class="btn btn-cancel" data-dismiss="modal">취소</button>';
							html += 				'</div>';       
							html += 			'</div>';
							html += 		'</div>';
							html += 	'</div>';
						}
						else if(orderDetail.od_state == '구매확정' && review != null){
							html += 	'<a href="#" class="btn btn-request btn-modify" data-toggle="modal" data-target="#review'+orderDetail.od_num+'">리뷰 수정</a>';
							html += 	'<div class="modal fade" id="review'+orderDetail.od_num+'" data-odnum="'+orderDetail.od_num+'" data-rvnum="'+review.rv_num+'">';
							html += 		'<div class="modal-dialog modal-dialog-centered">';
							html += 			'<div class="modal-content">';
							html += 				'<div class="modal-header">';
							html += 					'<h4 class="modal-title font-weight-bold d-block">';
							html += 						'<i class="fa-solid fa-paw mr-2"></i>리뷰 수정';
							html += 					'</h4>';
							html += 					'<div class="box-message" style="line-height: 38px;">';
							html += 						'<small>리뷰를 수정하세요.</small>';
							html += 					'</div>';
							html += 					'<button type="button" class="btn btn-modi-close" data-dismiss="modal">';
							html += 						'<i class="fa-solid fa-xmark"></i>';
							html += 					'</button>';
							html += 				'</div>';
							html += 				'<div class="modal-body">';
							html += 					'<div class="box-goods mt-3">';
							html += 						'<div class="goodsThumb">';
							html += 							'<img class="gs_thumb" src="'+contextPath+orderDetail.gs_thumb_url+'">';
							html += 						'</div>';
							html += 						'<div class="box-goods-info">';
							html += 							'<p class="gs_name font-weight-bold">'+orderDetail.gs_name+'</p>';
							html += 							'<ul class="goods-info">';
							html += 								'<li class="price font-weight-bold pr-2">';
							html += 									'<span class="od_total_price">'+orderDetail.od_total_price_str+'</span>';
							html += 								'</li>';
							html += 								'<li class="amount pl-2 pr-2">';
							html += 									'<span class="od_amount">'+orderDetail.od_amount_str+'</span>';
							html += 								'</li>';
							html += 								'<li class="date pl-2">';
							html += 									'<span class="or_date">'+orderDetail.or_date_str+'</span>';
							html += 								'</li>';
							html += 							'</ul>';
							html += 						'</div>';
							html += 					'</div>';
							html += 					'<div class="box-review">';
							html += 						'<div class="box-rating mb-3">';
							html += 							'<strong>별점</strong>';
							html += 							'<div class="rv_rating d-flex justify-content-center" >';
							let maxIndex =  Number(review.rv_rating);
							for(let i = 1; i <= maxIndex; i++){
								html += 							'<i class="star fa-solid fa-star"></i>';
							}
							for(let i = maxIndex + 1 ; i <= 5; i++){
								html += 							'<i class="fa-regular fa-star"></i>';
							}
							html += 							'</div>';
							html += 						'</div>';
							html += 						'<div class="box-review-content">';
							html += 							'<strong>사용 후기</strong>';
							html += 							'<div class="mt-2">';
							html += 								'<textarea class="rv_content" rows="5" style="resize: none; width: 100%;" placeholder="10자 이상 작성해주세요">';
							html += 									review.rv_content
							html += 								'</textarea>';
							html += 							'</div>';
							html += 						'</div>';
							html += 						'<div class="box-image text-right">';
							html += 							'<a href="javascript:0;" class="btn btn-image">사진 선택</a>';
							if(review.rv_image != '')
								html += 						'<a href="javascript:0;" class="btn btn-del-image ml-2">사진 삭제</a>';
							html += 							'<input type="file" style="display: none;" accept="image/jpg, image/jpeg, image/png, image/gif">';
							html += 							'<div class="box-preview text-center mt-2">';
							html += 								'<img class="preview" style="display: none;">';
							if(review.rv_image != '')
								html += 							'<img class="modiPreview" src="'+contextPath+review.rv_image_url+'">';
							html += 							'</div>';
							html += 						'</div>';
							html += 					'</div>';
							html += 				'</div>';  
							html += 				'<div class="modal-footer">';
							html += 					'<button type="button" class="btn btn-modify">리뷰 수정</button>';
							html += 					'<button type="button" class="btn btn-modi-cancel" data-dismiss="modal">취소</button>';
							html += 				'</div>';       
							html += 			'</div>';
							html += 		'</div>';
							html += 	'</div>';
						}
						html += 	'</div>';
						html += '</li>';
					}//if
				}//for:orderDetail
				html += '</ul>';
			}//for:order	
			$('.main .box-content .box-pay .box-goods-pay').html(html);
		});
	}//
	
 	//getMyReview : 나의 리뷰 가져오기 ======================================================================
	function getMyReview(rv_od_num){
 		let obj = {
 			rv_od_num
 		};
 		let review = null;
		ajaxPost(false, obj, '/get/myReview', function(data){
			if(data.review != null)
				review = data.review;
		});
		return review;
	}//	
	
 	//registerReview : 리뷰 등록하기 ======================================================================
	function registerReview(data, modalId){
		ajaxPostData(data, '/register/review', function(data){
			if(data.res){
				$('.main .modal #'+modalId+' .btn-close').click();
				alert('리뷰를 등록했습니다.');
				location.reload();
			}
			else
				alert('리뷰 등록에 실패했습니다.');
		});
	}//	
	
	//validateReviewInfo : 리뷰 정보 입력했는지 확인 ======================================================================
	function validateReviewInfo(modalId, rv_rating, rv_content){
	  //로그인 안했으면
		if(user == ''){
			if(confirm('Q&A를 수정하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return false;
		}
		//별점 선택 안했으면
		if(rv_rating == 0){
			alert('별점을 선택해주세요.')
			return false;
		}
		if(rv_rating < 0 || rv_rating > 5){
			alert('별점 1~5 사이에서 선택해주세요.')
			return false;
		}
		//사용 후기 작성 안했으면
		if(rv_content == '' || rv_content.length == 0){
			alert('사용 후기를 작성해주세요.')
			return false;
		}
		if(rv_content.length < 10){
			alert('사용 후기는 최소 10자 이상 작성해주세요.')
			return false;
		}
		return true;
	}//
	
 	//modifyReview : 리뷰 수정하기 ======================================================================
	function modifyReview(data, modalId){
		ajaxPostData(data, '/modify/review', function(data){
			if(data.res){
				$('.main .modal #'+modalId+' .btn-modi-close').click();
				alert('리뷰를 수정했습니다.');
				location.reload();
			}
			else
				alert('리뷰 수정에 실패했습니다.');
		});
	}//
</script>
</html>