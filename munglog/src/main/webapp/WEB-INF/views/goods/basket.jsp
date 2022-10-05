<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 장바구니</title>
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
	.main .box-content .box-basket table,
	.main .box-content .box-summary table{
		border-top: 2px solid #d7d5d5; border-bottom: 2px solid #d7d5d5;
		table-layout: fixed; font-size: 14px; text-align: center; 
	}
	.main .box-content .box-basket table thead th{padding: 12px 0;}
	.main .box-content .box-basket table tbody td{
		padding: 7px 0; vertical-align: middle;
	}
	.main .box-content .box-basket table tbody .item-thumb .gs_thumb{
		max-width: 92px; width: 92px;
	}
	.main .box-content .box-basket table tbody .item-name{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap; 
	}
	.main .box-content .box-basket table tbody .item-name .btn-change-option,
	.main .box-content .box-basket table tbody .item-amount .btn-chage-amount{
		padding: 5px; background-color: #a04c00;
		border: none; color: #fff7ed; border-radius: 3px;
		display: inline-block; margin-top: 5px;
	}
	.main .box-content .box-basket table tbody .item-amount input{
		border: 1px solid #dfe0df; text-align: center; width: 50px;
	}
	.main .box-content .box-basket table tbody .item-btn .btn{
		padding: 5px; display: inline-block;
	}
	.main .box-content .box-basket table tbody .item-btn .btn:hover .icon{color: #FF9E54; cursor: pointer;}
	.main .box-content .box-basket .box-set .btn{
		padding: 2px 5px; background-color: white; 
		font-weight: bold; font-size: 12px; color: #a04c00;
		border: 1px solid #a04c00;  border-radius: 3px;
		display: inline-block; margin-bottom: 50px;
	}
	.main .box-content .box-basket .box-set .btn:hover{
		background-color: #a04c00; color: #fff7ed;
	}
	.main .box-content .box-summary table{font-size: 18px;}
	.main .box-content .box-btn button{
		display: inline-block; border: 1px solid #dfe0df; padding: 10px 20px;
		font-weight: bold; margin-top: 50px; width: 458px;
	}
	.main .box-content .box-btn button:hover{box-shadow: 2px 2px 3px #dfe0df;}
	.main .box-content .box-btn .btn-order-all{
		background-color: #fb9600; color: #fff7ed;
	}
	.main .box-content .box-btn .btn-order-select{background-color: #fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- 제목 --------------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 장바구니</span>
	<div class="box-message">장바구니에 담은 굿즈를 확인하고, 구매하세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
	<!-- box-basket ------------------------------------------------------------------------------------------------ -->
	<div class="box-basket">
		<table class="table list-basket">
			<!-- thead ----------------------------------------------------------------------------------------------------- -->
			<thead>
				<tr>
					<th width="27px">
						<input type="checkbox" class="checkAll">
					</th>
					<th width="92px">이미지</th>
					<th>상품정보</th>
					<th width="98px">판매가</th>
					<th width="75px">수량</th>
					<th width="85px">배송비</th>
					<th width="98px">합계</th>
					<th width="75px"></th>
				</tr>
			</thead>
			<!-- tbody ---------------------------------------------------------------------------------------------------- -->
			<tbody>
				<c:forEach items="${basketList}" var="basket">
					<tr>
						<td class="item-check" data-value="${basket.bs_num}">
							<input type="checkbox" class="check">
						</td>
						<td class="item-thumb">
							<a class="link-goods" href="<c:url value="/goods/goodsDetail/${basket.gs_num}"></c:url>">
								<img class="gs_thumb" src="<c:url value="${basket.gs_thumb_url}"></c:url>">
							</a>
						</td>
						<td class="item-name text-left pl-4">
							<a class="link-goods" href="<c:url value="/goods/goodsDetail/${basket.gs_num}"></c:url>">
								<strong class="gs_name">${basket.gs_name}</strong>
							</a>			
							<div class="box-option mt-2">
								<span class="ot_name">- ${basket.ot_name}</span><br>
								<a class="btn-change-option" href="#">옵션 변경</a>
							</div>
						</td>
						<td class="item-price">
							<span class="ot_price" data-value="${basket.ot_price}">${basket.ot_price_str}</span>
						</td>
						<td class="item-amount">
							<input type="number" class="bs_amount" min="1" 
								max="<c:if test="${basket.ot_amount < 10}">${basket.ot_amount}</c:if><c:if test="${basket.ot_amount >= 10}">10</c:if>" 
								value="${basket.bs_amount}" data-amount="${basket.bs_amount}">
							<button type="button" class="btn-chage-amount">변경</button>
						</td>
						<td class="item-delivery"><span class="deliveryFee"></span></td>
						<td class="item-total"><span class="totalPrice">${basket.ot_price_total}</span></td>
						<td class="item-btn">
							<span class="btn btn-buy"><i class="icon fa-regular fa-credit-card"></i></span><br>
							<span class="btn btn-delete"><i class="icon fa-solid fa-trash"></i></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- box-set ---------------------------------------------------------------------------------------------------- -->
		<div class="clearfix">
			<div class="box-set float-right">
				<a class="btn btn-select-delete mr-2" href="#">선택상품 삭제</a>
				<a class="btn btn-clearAll" href="#">장바구니 비우기</a>
			</div>
		</div>
	</div>
	<!-- box-summary ---------------------------------------------------------------------------------------------------- -->	
	<div class="box-summary">
		<table class="table">
			<!-- thead ----------------------------------------------------------------------------------------------------- -->
			<thead>
				<tr>
					<th>총 상품금액</th>
					<th>배송비</th>
					<th>결제예정금액</th>
				</tr>
			</thead>
			<!-- tbody ----------------------------------------------------------------------------------------------------- -->
			<tbody>
				<tr>
					<td><span class="goodsPrice">95000</span></td>
					<td><span class="deliveryFee">95000</span></td>
					<td><span class="totalPrice">95000</span></td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- box-btn ------------------------------------------------------------------------------------------------------- -->
	<div class="box-btn">
		<button type="button" class="btn-order-all">전체상품주문</button>
		<button type="button" class="btn-order-select">선택상품주문</button>
	</div>	
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		editSummary();
	})//
	
	//체크박스 클릭하면(checkAll) ==================================================================================
	$('.main .box-content .box-basket table thead .checkAll').click(function () {
		//클릭된 체크박스의 체크 여부 확인
		let isChecked = $(this).prop('checked');
		//모든 체크박스에 적용
		$('input:checkbox').prop('checked', isChecked);
	})//
	
	//체크박스 클릭하면(check) ==================================================================================
	$('.main .box-content .box-basket table tbody .check').click(function () {
		// 클릭된 체크박스가 체크된 상태이면
		if($(this).is(':checked')){
			// 전체가 체크된 상태인지 확인
			let count = $('.main .box-content .box-basket table tbody .check').filter(':checked').length;
			let totalcount = $('.main .box-content .box-basket table tbody .check').length;
			// 전체가 체크됬으면 
			if(totalcount == count)
				$('.main .box-content .box-basket table thead .checkAll').prop('checked', true);
		}
		// 체크가 해제된 상태이면 
		else
			$('.main .box-content .box-basket table thead .checkAll').prop('checked', false);				
	})
});	
	
/* 함수 *********************************************************************************************************** */
	//numberToCurrency : 숫자를 통화로 ============================================================================
	function numberToCurrency(price){
		return new Intl.NumberFormat('en-KR').format(price) +'원';
	}//
	
	//editTotal : 총금액 수정 =====================================================================================
	function editSummary(){
		//상품 총 금액
		let goodsPrice = 0;
		$('.main .box-content .box-basket table tbody tr').each(function(){
			let count = $(this).find('.bs_amount').val();
			let price = $(this).find('.ot_price').data('value') * count;
			goodsPrice += price;
		});
		//배송비
		let deliveryFee = 3000;
		if(goodsPrice >= 50000)
			deliveryFee = 0;
		//결제 예정 금액
		let totalPrice = goodsPrice + deliveryFee;
		$('.main .box-content .box-summary .goodsPrice').text(numberToCurrency(goodsPrice));
		$('.main .box-content .box-summary .deliveryFee').text(numberToCurrency(deliveryFee));
		$('.main .box-content .box-basket .deliveryFee').text(numberToCurrency(deliveryFee));
		$('.main .box-content .box-summary .totalPrice').text(numberToCurrency(totalPrice));
	}//
</script>
</html>