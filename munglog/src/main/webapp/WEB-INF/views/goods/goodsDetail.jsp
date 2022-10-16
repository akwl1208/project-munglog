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
	/* box-content =====================================================================*/
	.main .box-content{margin: 44px;}
	.main .box-content .goToGoods:hover .fa-list{color:#fb9600;}
	.main .box-content .box-thumb{
		border: 1px solid #dfe0df;
		width: 430px; height: 430px;
	}
	.main .box-content .box-detail .title{font-weight: bold;}
	.main .box-content .box-select table{
		table-layout: fixed;
		border-top: 2px solid #dfe0df; border-bottom: 2px solid #dfe0df;
	}
	.main .box-content .box-select table th,
	.main .box-content .box-select table td{
		vertical-align: middle; padding: 20px 10px;
	}
	.main .box-content .box-select table td{text-align: center;}
	.main .box-content .box-select .title{font-size: 12px;}
	.main .box-content .box-select .title .gs_name{
		display: inline-block; width: 100%; margin-bottom: 5px;
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
	}
	.main .box-content .box-select .title .ot_name{
		font-weight: 200; display: inline-block; width: 95%; 
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
	}
	.main .box-content .box-select .quantity{
		width: 65px; display: inline-block; position: relative;
	}
	.main .box-content .box-select .quantity input{
		width: 30px; border: 1px solid #dfe0df; text-align: center;
	}
	.main .box-content .box-select .quantity .up{
		position: absolute; top: 0; left: 50px; height: 16px;
	}
	.main .box-content .box-select .quantity .down{
		position: absolute;	bottom: 0; left: 50px; height: 16px;
	}
	.main .box-content .box-select .quantity .fa-solid{vertical-align: top;}
	.main .box-content .box-select .quantity .up:hover .fa-solid,
	.main .box-content .box-select .quantity .down:hover .fa-solid,
	.main .box-content .box-select .btn-delete:hover .fa-solid{color:#fb9600; cursor: pointer;}
	.main .box-content .box-total{font-size: 18px; padding: 5px 20px;}
	.main .box-content .box-btn button{
		display: inline-block; border: 1px solid #dfe0df; padding: 10px 20px;
		font-weight: bold;
	}
	.main .box-content .box-btn button:hover{box-shadow: 3px 3px 3px #dfe0df;}
	.main .box-content .box-btn .btn-buy{
		background-color: #fb9600; color: #fff7ed;
	}
	.main .box-content .box-btn .btn-basket{background-color: #fff7ed;}
	/* 탭 내용 =====================================================================*/
	.main .box-content .nav-tabs .nav-item{
		width: 25%; text-align: center; font-weight: bold;
	}
	.main .box-content .nav-tabs .nav-item .nav-link.active{color: #fb9600;}
	.main .box-content .tab-content .tab-pane{
		padding: 60px; text-align: center;
	}
	.main .box-content .tab-content .tab-pane table{margin: 0 auto;}
	/* review =====================================================================*/
	.main .box-content .tab-content #review{text-align:start;}
	.main .box-content .tab-content #review .box-review .item-review{
		padding: 30px; margin-bottom: 20px;
  	border: 2px solid #ae8a68; border-radius: 5px;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-detail{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
  	line-height: 20px;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-detail .mb_nickname::before,
	.main .box-content .tab-content #review .box-review .item-review .box-review-detail .rv_reg_date::before{
		display: inline-block; width: 2px; height: 2px;
   	margin: 0 6px; content: ""; vertical-align: 3px;
   	background-color: #d8d8d8;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content{
		display: table; width: 100%; table-layout: fixed;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content>div{
		display: table-cell; vertical-align: top;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content.more>div{display: block;}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content .box-review-text .rv_content{
		overflow: hidden; min-height: 22px;	max-height: 100px;
  	font-size: 14px; line-height: 22px; word-break: break-all;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content .box-review-text .rv_content.more{max-height: none;}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content .box-review-image{
   	width: 100px; height: 100px; padding-left: 10px; overflow: hidden;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content .box-review-image.more{
		width: 200px; height: 200px; margin: 10px auto;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-review-content .box-review-image .rv_image{
		width: 100%; height: 100%; border: 1px solid #d8d8d8;
	}
	.main .box-content .tab-content #review .box-review .item-review .box-button a:hover>small,
	.main .box-content .tab-content #review .box-review .item-review .box-button a:hover .fa-solid{color: #fb9600;}
	/* qna =====================================================================*/
	.main .box-content .tab-content .box-qna table{
		table-layout: fixed; text-align: center; 
	}
	.main .box-content .tab-content #qna .box-qna table thead{background-color: #d7d5d5;}
	.main .box-content .tab-content #qna .box-qna table tbody td{vertical-align: middle;}
	.main .box-content .tab-content #qna .box-qna table tbody .item-title .link-qna:hover .bd_title{color: #FF9E54;}
	.main .box-content .tab-content #qna .box-qna table tbody .item-nickname{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap; 
	}
	/* 페이지네이션 =====================================================================*/
	.main .box-content .tab-content .pagination .page-item.active .page-link{
	 z-index: 1; color: #fb9600; font-weight:bold;
	 background : #fff; border-color: #DFE0DF;	 
	}	
	.main .box-content .tab-content .pagination .page-link:focus,
	.main .box-content .tab-content .pagination .page-link:hover {
	  color: #000; background-color: #DFE0DF; border-color: #ccc;
	}
	.main .box-content .tab-content .box-btn a{
		background-color: #a04c00; border-radius: 3px; padding: 5px 10px;
		border: none; color: #fff7ed; box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
	}
	.main .btn-scrollTop{
    font-weight: bold; color: #444; font-size:24px;
    position:fixed; bottom:50px; right:400px; display:none;
	}
	.main .btn-scrollTop:hover{color: #fb9600;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 상세보기</span>
	<div class="box-message">굿즈의 상세보기를 보고, 장바구니에 담아보세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------------- -->		
<div class="box-content">
	<a class="goToGoods float-right" href="<c:url value="/goods"></c:url>" data-toggle="tooltip" data-placement="right" title="굿즈 목록으로">
		<i class="fa-solid fa-list"></i>
	</a>	
	<form class="clearfix" action="<%=request.getContextPath()%>/goods/order/${user.mb_num}" method="get">
		<!-- box-thumb(썸네일) ----------------------------------------------------------------------------------------- -->		
		<div class="box-thumb float-left">				
			<img class="gs_thumb" width="100%" height="100%" src="<c:url value="${goods.gs_thumb_url}"></c:url>">
		</div>						
		<!-- box-detail ---------------------------------------------------------------------------------------------- -->
		<div class="box-detail float-right" style="width:calc(100% - 430px - 40px)">
			<h3 class="gs_name mt-2">${goods.gs_name}</h3>
			<table class="box-summary border-0 mt-3" style="width: 100%;">
				<tbody>
					<tr class="row-price">
						<th class="pt-2 pr-2 pb-2">판매가</th>
						<td><span class="gs_price">${goods.gs_price_str}</span></td>
					</tr>
					<tr class="row-delivery">
						<th class="pt-2 pr-2 pb-2">배송비</th>
						<td>
							<span>3,000원</span>
							<small>(50,000원 이상 구매시 배송비 무료)</small>
						</td>
					</tr>
				</tbody>	
			</table>
			<hr>
			<!-- box-option(옵션 선택) ------------------------------------------------------------------------------------ -->
			<div class="box-option">
				<div class="form-group">
					<label class="title">옵션</label>
					<select class="form-control mb-2">
						<option value="0">[필수] 옵션을 선택해주세요.</option>
						<c:forEach items="${optionList}" var="option">
							<option value="${option.ot_num}" data-name="${option.ot_name}" data-amount="${option.ot_amount}" data-price="${option.ot_price}">
								${option.ot_name}
								<c:if test="${option.ot_price != goods.gs_price}"> (+ ${option.ot_price - goods.gs_price}원)</c:if>
								<c:if test="${option.ot_amount == 0}">/품절</c:if>
							</option>					
						</c:forEach>
					</select>
					<small class="ml-2">(옵션 하나당 최소 1개 이상 최대 10개 이하로 선택해주세요.)</small>	
				</div>
			</div>
			<!-- box-select ------------------------------------------------------------------------------------------------- -->
			<div class="box-select">
				<small class="ml-2" style="color: #b86000;">
					<i class="fa-solid fa-paw"></i> 위 선택 박스에서 옵션을 선택하면 아래에 상품이 추가됩니다.
				</small>
				<table class="table mt-2">
					<tbody></tbody>
				</table>
			</div>
			<hr>
			<!-- box-totalPrice ---------------------------------------------------------------------------------- -->
			<div class="box-total">
				<strong>총 금액 : </strong>
				<strong class="total-price">0원</strong>
				<span class="total-quantity">(0개)</span>
			</div>
			<hr>
			<!-- box-btn ---------------------------------------------------------------------------------- -->
			<div class="box-btn">
				<button type="submit" class="btn-buy col-5 mr-2">바로 구매</button>
				<button type="button" class="btn-basket col-5">장바구니</button>
			</div>
		</div>			
	</form>
	<!-- 탭메뉴 ---------------------------------------------------------------------------------- -->
	<ul class="nav nav-tabs mt-5" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" data-toggle="tab" href="#gs_description">상세 정보</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#gs_guidance">구매 가이드</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#review">리뷰</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#qna">Q&A</a>
		</li>
	</ul>
	<!-- tab-content(탭 내용) ---------------------------------------------------------------------------------- -->
	<div class="tab-content">
		<div id="gs_description" class="container tab-pane active">${goods.gs_description}</div>
		<div id="gs_guidance" class="container tab-pane fade">${goods.gs_guidance}</div>
		<!-- 리뷰 ---------------------------------------------------------------------------------- -->
		<div id="review" class="container tab-pane fade">
			<!-- box-btn ------------------------------------------------------------------------------------------------- -->
			<div class="box-btn text-right mb-4">
				<a href="<c:url value="/goods/review"></c:url>" class="btn-goToReview">굿즈 리뷰 목록</a>
			</div>
			<!-- box-review(리뷰) -------------------------------------------------------------------------------------- -->
			<div class="box-review">
				<ul class="list-review"></ul>
			</div>
			<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
			<ul class="pagination justify-content-center mt-5"></ul>
		</div>
		<!-- qna ---------------------------------------------------------------------------------- -->
		<div id="qna" class="container tab-pane fade">
			<!-- box-btn ------------------------------------------------------------------------------------------------- -->
			<div class="box-btn text-right mb-4">
				<a href="<c:url value="/goods/qna"></c:url>" class="btn-goToQna mr-3">Q&A 목록</a>
				<a href="<c:url value="/goods/registerQna"></c:url>" class="btn-register">Q&A 등록</a>
			</div>
			<!-- box-qna ------------------------------------------------------------------------------------------------- -->
			<div class="box-qna">
				<table class="table table-bordered">
					<thead>
						<tr class="text-center">
							<th width="15%">답변 상태</th>
							<th>제목</th>
							<th width="20%">작성자</th>
							<th width="15%">작성일</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
			<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
			<ul class="pagination justify-content-center mt-4"></ul>
		</div>
	</div>
	<a class="btn-scrollTop" href="javascript:0;" onclick="scrollTop()"><i class="fa-regular fa-circle-up"></i></a>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let gsName = '${goods.gs_name}';
	let user = '${user.mb_num}';
	let index = 0;
	let page = 1;
	let cri = {
		page,
		perPageNum : 10,
		gs_num : '${goods.gs_num}'
	};  
	let year = new Date().getFullYear(); // 년도
	let month = new Date().getMonth() + 1;  // 월
	let date = new Date().getDate();  // 날짜
	let today = year + '-' + month + '-' + date;
/* 이벤트 *********************************************************************************************************** */
	$(function(){	
		$(document).ready(function(){
			//Qna 리스트 가져오기
			getQnaList(cri);
			//리뷰 리스트 가져오기
			getReviewList(cri);
			//목록 호버하면 tooltip
		  $('[data-toggle="tooltip"]').tooltip();
			//스크롤 내리면 상단으로 버튼 나옴
	    $(window).scroll(function(){
	      if ($(this).scrollTop() > 100)
     			$('.btn-scrollTop').fadeIn();
	      else
	      	$('.btn-scrollTop').fadeOut();
	    });
	    //상단으로 클릭하면 상단으로
	    $('.btn-scrollTop').click(function(){
	    	$('body').scrollTop(0);
	      return false;
	    });
		})//
		
		//옵션 삭제(btn-delete) 클릭 =============================================================================
		$(document).on('click','.main .box-content .box-select .btn-delete', function(){
			if(!confirm('옵션을 삭제하겠습니까?'))
				return;
			$(this).parents('tr').remove();
			editTotal();
		})//
		
		// input 입력 이벤트 ======================================================================================
    $(document).on('input', '.main .box-content .box-select .quantity input', function() {
      //숫자 이외의 값 입력 못하게 막음
      $(this).val($(this).val().replace(/[^0-9]/g, ''));
      let value = $(this).val();
      let maxAmount = $(this).parents('.quantity').data('value');
      //재고량 초과하여 주문할 수 없다.
      if(value > maxAmount){
    	  alert('현재 주문 가능한 수량은'+maxAmount+'개 입니다.');
    	  $(this).val(maxAmount);
      }
      //최소 1개 이상 최대 10 이하로 입력
      if(value.length != 0 && (value > 10 || value < 1)){
    	  alert('최소 1개 이상 최대 10개 이하로 입력할 수 있습니다.');
    	  $(this).val(1);
      }
      editOptionPrice(this);
      editTotal();
    })//
    
		// up 클릭 이벤트 =========================================================================================
    $(document).on('click', '.main .box-content .box-select .quantity .up', function() {
    	let value = $(this).siblings('input').val();
      let maxAmount = $(this).parents('.quantity').data('value');
      //재고량 초과하여 주문할 수 없다.
      if(value >= maxAmount){
    	  alert('현재 주문 가능한 수량은'+maxAmount+'개 입니다.');
    	  $(this).val(maxAmount);
    	  return;
      }
    	//최대 10개까지 입력 가능
    	if(value == 10){
      	alert('최소 1개 이상 최대 10개 이하로 입력할 수 있습니다.');
      	return;
    	}
			$(this).siblings('input').val(Number(value) + 1);
			editOptionPrice(this);
			editTotal();
    })//
    
		// down 클릭 이벤트 =====================================================================================
    $(document).on('click', '.main .box-content .box-select .quantity .down', function() {
    	let value = $(this).siblings('input').val();
    	//최소 1개까지 입력 가능
    	if(value == 1){
      	alert('최소 1개 이상 최대 10개 이하로 입력할 수 있습니다.');
      	return;
    	}
			$(this).siblings('input').val(Number(value) - 1);	
			editOptionPrice(this);
			editTotal();
    })//
		
		// 옵션 선택 ============================================================================================
		$('.main .box-content .box-option select').change(function(){
			//값 가져오기
			let otNum = $(this).val();
			let otName = $(this).children("option:selected").data('name');
			let otAmount = $(this).children("option:selected").data('amount');
			let otPrice = $(this).children("option:selected").data('price');
			let otPriceStr = numberToCurrency(otPrice);
			//제목 클릭하면
			if($(this).val() == 0)
				return;
			//품절이면 선택 못함
			if(otAmount == 0)
				return;
			//이미 선택했던 상품이면
			let isSelected = true;
			$('.main .box-content .box-select table tbody tr').each(function(){
				let selectOtNum = $(this).data('value');
				if(selectOtNum == otNum){
					isSelected = false;
					return false;
				}
			});
			if(!isSelected){
				alert('이미 선택한 상품입니다.')
				return;
			}		
			//화면 구성
			let html = '';
			html += '<tr class="row-select" data-value="'+otNum+'">';
			html += 	'<input type="hidden" name="orderList['+index+'].otNum" value="'+otNum+'">';
			html += 	'<th class="item-title" width="50%">';
			html += 		'<p class="title m-0">';
			html += 			'<strong class="gs_name">'+gsName+'</strong><br>';
			html += 			'<span class="ot_name ml-2">- '+otName+'</span>';
			html += 		'</p>';
			html += 	'</th>';
			html += 	'<td class="item-quantity" width="20%">';
			html += 		'<div class="quantity" data-value="'+otAmount+'">';
			html += 			'<input type="text" class="bs_amount" name="orderList['+index+'].orAmount" min="1" max="10" value="1">';
			html += 			'<a href="javascript:0;" class="up"><i class="fa-solid fa-caret-up"></i></a>';
			html += 			'<a href="javascript:0;" class="down"><i class="fa-solid fa-caret-down"></i></a>';
			html += 		'</div>';
			html += 	'</td>';
			html += 	'<td width="25%">';
			html += 		'<span class="price" data-value="'+otPrice+'">'+otPriceStr+'</span>';
			html += 	'</td>';
			html += 	'<td width="5%">';
			html += 		'<div class="btn-delete"><i class="fa-solid fa-xmark"></i></div>';
			html += 	'</td>';
			html += '</tr>';
			index++;
			$('.main .box-content .box-select table tbody').append(html);
			//총 금액 수정
			editTotal();
		})//
		
		// 장바구니 클릭 ============================================================================================
		$('.main .box-content .box-btn .btn-basket').click(function(){
			//로그인 안했으면 로그인화면으로
			if(user == ''){
				if(confirm('장바구니에 담으려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				return;
			}
			//옵션을 선택 안했으면
			let trLength = $('.main .box-content .box-select table tbody tr').length;
			if(trLength == 0){
				alert('옵션을 선택해주세요.');
				$('.main .box-content .box-option select').focus();
				return;
			}
			//수량이 입력 안했으면
			let isInput = true;
			$('.main .box-content .box-select input').each(function(){
				let value = $(this).val();
				if(value == ''){
					alert('수량을 입력해주세요.')
					$(this).focus();
					isInput = false;
					return false;
				}
			});
			if(isInput == false)
				return;		
			//장바구니에 담기
			let optionList = [];
			$('.main .box-content .box-select table tbody tr').each(function(){
				//값 설정
				let option = {};
				let bs_ot_num = $(this).data('value');
				let bs_amount = $(this).find('.bs_amount').val();
				option.ot_num = bs_ot_num;
				option.ot_amount = bs_amount;
				optionList.push(option);
			});
			let obj = {
				bs_mb_num : user,
				optionList
			}
			//장바구니에 담기
			putBasket(obj);
		})//
		
		//form 보내기 전에 ============================================================================
		$('form').submit(function(){
			//로그인 안했으면 로그인화면으로
			if(user == ''){
				if(confirm('바로 결제하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				return false;
			}
			//옵션을 선택 안했으면
			let trLength = $('.main .box-content .box-select table tbody tr').length;
			if(trLength == 0){
				alert('옵션을 선택해주세요.');
				$('.main .box-content .box-option select').focus();
				return false;
			}
			//수량이 입력 안했으면
			let isInput = true;
			$('.main .box-content .box-select input').each(function(){
				let value = $(this).val();
				if(value == ''){
					alert('수량을 입력해주세요.')
					$(this).focus();
					isInput = false;
					return false;
				}
			});
			if(isInput == false)
				return false;			
		})//
		
		//qna 페이지네이션(page-link) 클릭 ====================================================================================
		$(document).on('click','.main .box-content #qna .pagination .page-link',function(e){
			e.preventDefault();
			cri.page = $(this).data('page');
			getQnaList(cri);
		})//
		
		//QNA 등록(btn-register) 클릭 =================================================================
		$('.main .box-content .tab-content #qna .box-btn .btn-register').click(function(){
			if(user == ''){
				if(confirm('Q&A를 등록하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				return;
			}
		})//
		
		//QNA 제목(link-qna) 클릭 =================================================================
		$(document).on('click','.main .box-content .tab-content #qna .box-qna .link-qna',function(e){
			//로그인 안했으면
			if(user == ''){
				if(confirm('Q&A을 보려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				e.preventDefault();
				return;
			}
			//다른 회원이 보려고 하면
			let mbNum = $(this).parents('tr').data('value');
			if(user != mbNum){
				alert('Q&A를 작성한 회원만 볼 수 있습니다.')	
				e.preventDefault();	
				return;
			}
		})//
		
		//리뷰 더보기(btn-more) 클릭 ====================================================================================
		$(document).on('click', '.main .box-content .tab-content #review .box-review .item-review .btn-more', function(){
			$(this).hide();
			$(this).parents('.item-review').find('.btn-fold').show();
			$(this).parents('.item-review').find('.box-review-image').addClass('more');
			$(this).parents('.item-review').find('.box-review-content').addClass('more');
			$(this).parents('.item-review').find('.rv_content').addClass('more');
		})//
		
		//리뷰 접기(btn-fold) 클릭 ====================================================================================
		$(document).on('click', '.main .box-content .tab-content #review .box-review .item-review .btn-fold', function(){
			$(this).hide();
			$(this).parents('.item-review').find('.btn-more').show();
			$(this).parents('.item-review').find('.box-review-image').removeClass('more');
			$(this).parents('.item-review').find('.box-review-content').removeClass('more');
			$(this).parents('.item-review').find('.rv_content').removeClass('more');
		})//
	});	

/* 함수 *********************************************************************************************************** */
	//numberToCurrency : 숫자를 통화로 ============================================================================
	function numberToCurrency(price){
		return new Intl.NumberFormat('en-KR').format(price) +'원';
	}//
	
	//editOptionPrice : 옵션총금액 수정 =====================================================================================
	function editOptionPrice(selector){
		let bsAmount = $(selector).parents('tr').find('.bs_amount').val();
		let otPrice = $(selector).parents('tr').find('.price').data('value');
		let totalPrice = otPrice * bsAmount;
		$(selector).parents('tr').find('.price').text(numberToCurrency(totalPrice));
	}//
	
	//editTotal : 총금액 수정 =====================================================================================
	function editTotal(){
		let totalCount = 0;
		let totalPrice = 0;
		$('.main .box-content .box-select table tbody tr').each(function(){
			let count = $(this).find('.bs_amount').val();
			let price = $(this).find('.price').data('value') * count;
			totalCount += Number(count);
			totalPrice += price;
		});
		$('.main .box-content .box-total .total-price').text(numberToCurrency(totalPrice));
		$('.main .box-content .box-total .total-quantity').text('('+totalCount+'개)');
	}//
	
	//putBasket : 장바구니에 담기 =====================================================================================
	function putBasket(obj){
		ajaxPost(false, obj, '/put/basket', function(data){
			if(data.res == 1){
				if(confirm('장바구니에 담았습니다. 장바구니를 확인하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/goods/basket';
			}
			else if(data.res == 0){
				if(confirm('이미 장바구니에 담긴 상품이 있습니다. 장바구니를 확인하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/goods/basket';
			}		
			else
				alert('장바구니 담기에 실패했습니다. 다시 시도해주세요.')
		});
	}//
	
	// getQnaList : QNA 리스트 가져오기 =============================================================================
	function getQnaList(obj){
		ajaxPost(false, obj, '/get/qnaList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			//리스트 구현-----------------------------------------------------------------------------------
			for(qna of data.qnaList){
				html += '<tr data-value="'+qna.bd_mb_num+'">';
				html += 	'<td class="item-state">';
				html += 		'<span class="qn_state">'+qna.qn_state+'</span>';
				html += 	'</td>';
				html += 	'<td class="item-title text-left">';
				html += 		'<a class="link-qna" href="'+contextPath+'/goods/qnaDetail/'+qna.qn_num+'">';
				if(qna.bd_reg_date_str == today)
					html +=			'<span class="badge badge-warning mr-2">NEW</span>';
				html += 			'<strong class="bd_title">'+qna.bd_title+'</strong>';
				html += 		'</a>';
				html += 	'</td>';
				html += 	'<td class="item-nickname">';
				html += 		'<span class="mb_nickname">'+qna.mb_nickname+'</span>';
				html += 	'</td>';
				html += 	'<td class="item-date">';
				html += 		'<span class="bd_reg_date">'+qna.bd_reg_date_str+'</span>';
				html += 	'</td>';
				html += '</tr>';
			}
			$('.main .box-content .tab-content #qna .box-qna table tbody').html(html);
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
			$('.main .box-content .tab-content #qna .pagination').html(html);
		})
	}//
	
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
			$('.main .box-content .tab-content #review .box-review .list-review').html(html);
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
			$('.main .box-content .tab-content #review .pagination').html(html);
		})
	}//
</script>
</html>