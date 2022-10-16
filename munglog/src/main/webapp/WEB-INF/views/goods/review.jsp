<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 리뷰</title>
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
	.main .box-content .box-review .item-review{
		padding: 30px; margin-bottom: 20px;
  	border: 2px solid #ae8a68; border-radius: 5px;
	}
	.main .box-content .box-review .item-review .box-review-detail{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
  	line-height: 20px;
	}
	.main .box-content .box-review .item-review .box-review-detail .mb_nickname::before,
	.main .box-content .box-review .item-review .box-review-detail .rv_reg_date::before{
		display: inline-block; width: 2px; height: 2px;
   	margin: 0 6px; content: ""; vertical-align: 3px;
   	background-color: #d8d8d8;
	}
	.main .box-content .box-review .item-review .box-review-content{
		display: table; width: 100%; table-layout: fixed;
	}
	.main .box-content .box-review .item-review .box-review-content>div{
		display: table-cell; vertical-align: top;
	}
	.main .box-content .box-review .item-review .box-review-content.more>div{display: block;}
	.main .box-content .box-review .item-review .box-review-content .box-review-text .rv_content{
		overflow: hidden; min-height: 22px;	max-height: 100px;
  	font-size: 14px; line-height: 22px; word-break: break-all;
	}
	.main .box-content .box-review .item-review .box-review-content .box-review-text .rv_content.more{max-height: none;}
	.main .box-content .box-review .item-review .box-review-content .box-review-image{
   	width: 100px; height: 100px; padding-left: 10px; overflow: hidden;
	}
	.main .box-content .box-review .item-review .box-review-content .box-review-image.more{
		width: 200px; height: 200px; margin: 10px auto;
	}
	.main .box-content .box-review .item-review .box-review-content .box-review-image .rv_image{
		width: 100%; height: 100%; border: 1px solid #d8d8d8;
	}
	.main .box-content .box-review .item-review .box-button a:hover>small,
	.main .box-content .box-review .item-review .box-button a:hover .fa-solid{color: #fb9600;}
	.main .box-content .pagination .page-item.active .page-link{
		z-index: 1; color: #fb9600; font-weight:bold;
	 	background : #fff; border-color: #DFE0DF;	 
	}	
	.main .box-content .pagination .page-link:focus,
	.main .box-content .pagination .page-link:hover{
	  color: #000; background-color: #DFE0DF; border-color: #ccc;
	}
	.main .box-content .box-search{
		width: 50%; float: right;
	}
	.main .box-content .box-search .btn-search{
		padding: 0 10px; background-color: #a04c00;
		border: none; border-radius: 3px;
	}
	.main .box-content .box-search .btn-search .fa-solid{color: #fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 리뷰</span>
	<div class="box-message">멍친들이 작성한 굿즈 리뷰를 보고 구매에 참고하세요.</div>
</div>		
<!-- box-content ------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
	<div class="clearfix">
		<!-- box-search --------------------------------------------------------------------------------------- -->
		<div class="box-search mb-3">
			<div class="input-group">
				<select class="gs_name form-control">
					<option value="0">굿즈명 선택</option>
					<c:forEach items="${goodsList}" var="goods">
						<option value="${goods.gs_num}">${goods.gs_name}</option>
					</c:forEach>
				</select>
				<div class="input-group-append">
					<button class="btn btn-search" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
			</div>
		</div>
	</div>
	<!-- box-review(리뷰) ------------------------------------------------------------------------------------------------- -->
	<div class="box-review">
		<ul class="list-review"></ul>
	</div>
	<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
	<ul class="pagination justify-content-center mt-5"></ul>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let page = 1;
	let cri = {
		page,
		perPageNum : 10,
		gs_num : 0
	};  
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		getReviewList(cri);
	})//
	
	//페이지네이션(page-link) 클릭 ====================================================================================
	$(document).on('click','.main .box-content .pagination .page-link',function(e){
		e.preventDefault();
		cri.page = $(this).data('page');
		getReviewList(cri);
	})//
	
	//리뷰 더보기(btn-more) 클릭 ====================================================================================
	$(document).on('click', '.main .box-content .box-review .item-review .box-button .btn-more', function(){
		$(this).hide();
		$(this).parents('.item-review').find('.btn-fold').show();
		$(this).parents('.item-review').find('.box-review-image').addClass('more');
		$(this).parents('.item-review').find('.box-review-content').addClass('more');
		$(this).parents('.item-review').find('.rv_content').addClass('more');
	})//
	
	//리뷰 접기(btn-fold) 클릭 ====================================================================================
	$(document).on('click', '.main .box-content .box-review .item-review .box-button .btn-fold', function(){
		$(this).hide();
		$(this).parents('.item-review').find('.btn-more').show();
		$(this).parents('.item-review').find('.box-review-image').removeClass('more');
		$(this).parents('.item-review').find('.box-review-content').removeClass('more');
		$(this).parents('.item-review').find('.rv_content').removeClass('more');
	})//
	
	//검색 버튼(btn-search) 클릭 ====================================================================================
	$('.main .box-content .box-search .btn-search').click(function(){
		let gs_num = $('.main .box-content .box-search .gs_name').val();
		cri.gs_num = gs_num;
		getReviewList(cri);
	})//
});	
	
/* 함수 *********************************************************************************************************** */
	// getReviewList : 리뷰 리스트 가져오기 =============================================================================
	function getReviewList(obj){
		ajaxPost(false, obj, '/get/reviewList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			//리스트 구현-----------------------------------------------------------------------------------
			for(review of data.reviewList){
				html += '<li class="item-review">';
				html += 	'<div class="box-review-detail">';
				html += 		'<a class="link-goods" href="'+contextPath+'/goods/goodsDetail/'+review.gs_num+'">';
				html += 			'<strong class="gs_name mr-1">'+review.gs_name+'</strong>';
				html += 			'<small class="ot_name mr-2">'+review.ot_name+'</small>';
				html += 		'</a>';
				html += 		'<small class="mb_nickname">'+review.mb_nickname+'</small>';
				html += 		'<small class="rv_reg_date">'+review.rv_reg_date_str+'</small>';
				html += 		'<div class="box-rating ml-3" style="display: inline-block;">';
				let maxIndex =  Number(review.rv_rating);
				for(let i = 1; i <= maxIndex; i++){
					html += 		'<i class="star fa-solid fa-star"></i>';
				}
				for(let i = maxIndex + 1 ; i <= 5; i++){
					html += 		'<i class="fa-regular fa-star"></i>';
				}
				html += 			'<strong class="rv_rating ml-1">'+review.rv_rating+'</strong>';
				html += 		'</div>';
				html += 		'<div class="box-report float-right" style="display: inline-block;">';
				html += 			'<i class="fa-solid fa-ellipsis"></i>';
				html += 		'</div>';
				html += 	'</div>';
				html += 	'<div class="box-review-content mt-2">';
				html += 		'<div class="box-review-text">';
				html += 			'<p class="rv_content m-0">'+review.rv_content+'</p>';
				html += 		'</div>';
				if(review.rv_image != ''){
					html += 	'<div class="box-review-image">';
					html += 		'<img class="rv_image" src="'+contextPath+review.rv_image_url+'">';
					html += 	'</div>';					
				}
				html += 	'</div>';
				html += 	'<div class="box-button mt-2 text-right" style="height: 26px;">';
				html += 		'<a class="btn-more" href="javascript:0;">';
				html += 			'<small>리뷰 더보기<i class="fa-solid fa-chevron-down ml-1"></i></small>';
				html += 		'</a>';
				html += 		'<a class="btn-fold" href="javascript:0;" style="display: none;">';
				html += 			'<small>리뷰 접기<i class="fa-solid fa-chevron-up ml-1"></i></small>';
				html += 		'</a>';
				html += 	'</div>';
				html += '</li>';
			}
			$('.main .box-content .box-review .list-review').html(html);
			//페이지네이션 구현--------------------------------------------------------------------------
			html = '';
			let pm = data.pm;
			//이전
			html += 	'<li class="page-item';
			if(!pm.prev)
				html += 	' disabled';
			html += 	'">';
			html += 		'<a class="page-link text-muted" href="#" data-page="'+(pm.startPage-1)+'">이전</a>';
			html += 	'</li>';
			//페이지 숫자
			for(let i = pm.startPage; i <= pm.endPage; i++){
				html += '<li class="page-item';
				if(pm.cri.page == i)
					html += ' active';
				html += '">';
				html += 	'<a class="page-link text-muted" href="#" data-page="'+i+'">'+i+'</a>';
				html += '</li>';				
			}
			//다음
			html += 	'<li class="page-item';
			if(!pm.next)
				html += 	' disabled';
			html += 	'">';
			html += 		'<a class="page-link text-muted" href="#" data-page="'+(pm.endPage+1)+'">다음</a>';
			html += 	'</li>';
			$('.main .box-content .pagination').html(html);
		})
	}//

</script>
</html>