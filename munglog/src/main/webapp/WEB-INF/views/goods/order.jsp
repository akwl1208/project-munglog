<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 주문하기</title>
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
	.main .box-content .box-orderList table,
	.main .box-content .box-delivery table,
	.main .box-content .box-point table,
	.main .box-content .box-summary table{
		border-top: 2px solid #d7d5d5; border-bottom: 2px solid #d7d5d5;
		table-layout: fixed; font-size: 14px; text-align: center; 
	}
	.main .box-content .box-orderList table thead th{padding: 12px 0;}
	.main .box-content .box-orderList table tbody td{
		padding: 7px 0; vertical-align: middle;
	}
	.main .box-content .box-orderList table tbody .item-thumb .gs_thumb{
		max-width: 92px; width: 92px;
	}
	.main .box-content .box-orderList table tbody .item-name{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap; 
	}
	.main .box-content .box-delivery table tbody th,
	.main .box-content .box-point table tbody th{
		padding: 11px 0 10px 18px; width: 200px;
		border-right: 1px solid #d7d5d5; background-color: #d7d5d5;
		text-align: left;
	}
	.main .box-content .box-delivery table tbody td .row span{line-height: 38px;}
	.main .box-content .btn-pay{ 
		padding: 10px 20px; font-weight: bold; 
		background-color: #fb9600; color: #fff7ed; border: 1px solid #dfe0df;
	}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- 제목 --------------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 주문</span>
	<div class="box-message">정보를 입력하고, 굿즈를 주문하세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
	<!-- box-orderList --------------------------------------------------------------------------------------------- -->
	<div class="box-orderList">
		<label class="font-weight-bold">굿즈 주문 내역</label>
		<table class="table m-0">
			<!-- thead ------------------------------------------------------------------------------------------------- -->
			<thead>
				<tr>
					<th width="92px">이미지</th>
					<th>상품정보</th>
					<th width="110px">판매가</th>
					<th width="75px">수량</th>
					<th width="85px">배송비</th>
					<th width="110px">합계</th>
				</tr>
			</thead>
			<!-- tbody ------------------------------------------------------------------------------------------------- -->
			<tbody>
				<c:forEach items="${oList}" var="order">
					<tr>
						<td class="item-thumb">
							<a class="link-goods" href="/goods/goodsDetail/${order.gs_num}">
								<img class="gs_thumb" src="<c:url value="${order.gs_thumb_url}"></c:url>">	
							</a>
						</td>
						<td class="item-name text-left pl-4">
							<a class="link-goods" href="<c:url value="/goods/goodsDetail/${order.gs_num}"></c:url>">
								<strong class="gs_name">${order.gs_name}</strong>							
							</a>	
							<div class="box-option mt-2">
								<span class="ot_name">- ${order.ot_name}</span>
							</div>
						</td>
						<td class="item-price"><span class="ot_price">${order.ot_price_str}</span></td>
						<td class="item-amount"><span class="or_amount">${order.orAmount}</span></td>
						<td class="item-delivery"><span class="deliveryFee"></span></td>
						<td class="item-total"><span class="totalPrice" data-value="${order.totalPrice}">${order.totalPrice_str}</span></td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot class="text-right">
				<tr>
					<td colspan="6">
						<span>상품구매금액 </span>
						<strong class="goodsPrice"></strong>
						<span>+ 배송비 </span>
						<strong class="deliveryFee"></strong>
						<span>= 합계</span>
						<strong class="totalPrice"></strong>
					</td>
				</tr>
			</tfoot>
		</table>
		<div class="mt-2">
			<small><i class="fa-solid fa-paw mr-2"></i>굿즈의 옵션 및 수량 변경은 굿즈 상세 또는 장바구니에서 가능합니다.</small>
		</div>
	</div>
	<br><hr><br>
	<!-- box-deliver --------------------------------------------------------------------------------------------- -->
	<div class="box-delivery">
		<label class="font-weight-bold">배송 정보</label>
		<table class="table">
			<tbody>
				<!-- 배송지 선택 ------------------------------------------------------------------------------------------ -->
				<tr>
					<th>배송지 선택</th>
					<td class="text-left">
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="address" id="basicAddr" checked>회원 정보와 동일
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="address" id="newAddr">새로운 배송지
							</label>
						</div>
						<a href="#">주소록 보기</a>
					</td>
				</tr>
				<!-- 받는 사람 ---------------------------------------------------------------------------------------------- -->
				<tr>
					<th>받는 사람(필수)</th>
					<td>
						<div class="form-group m-0" style="width: 300px;">
							<input type="text" class="form-control" id="ad_recipient">
						</div>
					</td>
				</tr>
				<!-- 주소 -------------------------------------------------------------------------------------------------- -->
				<tr>
					<th>주소(필수)</th>
					<td>
						<div class="form-group m-0">
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="ad_post_code" placeholder="우편번호">
								<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
							</div>
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="ad_address" placeholder="주소"><br>
							</div>
							<div class="input-group">
								<input type="text" class="form-control" id="ad_detail" placeholder="상세주소">
							</div>
						</div>
					</td>
				</tr>
				<!-- 핸드폰번호 ----------------------------------------------------------------------------------------------- -->
				<tr>
					<th>핸드폰번호(필수)</th>
					<td>
						<div class="row">
							<div class="col">
								<input type="text" class="form-control">
							</div>
							<span>-</span>
							<div class="col">
								<input type="text" class="form-control">
							</div>
							<span>-</span>
							<div class="col" >
								<input type="text" class="form-control">
							</div>
						</div>
					</td>
				</tr>
				<!-- 이메일 ------------------------------------------------------------------------------------------------ -->
				<tr>
					<th>이메일(필수)</th>
					<td>
						<div class="row">
							<div class="col">
								<input type="text" class="form-control">
							</div>
							<span>@</span>
							<div class="col">
								<input type="text" class="form-control">
							</div>
						</div>
					</td>
				</tr>
				<!-- 배송메시지 ---------------------------------------------------------------------------------------------- -->
				<tr>
					<th>배송메시지</th>
					<td>
						<div class="form-group m-0">
							<textarea class="form-control" id="ad_request" rows="3" style="resize: none;"></textarea>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br><hr><br>
	<!-- box-point --------------------------------------------------------------------------------------------------- -->
	<div class="box-point">
		<label class="font-weight-bold">포인트 사용</label>
		<table class="table">
			<tbody>
				<tr class="row-point">
					<th>포인트</th>
					<td>
						<div class="form-group m-0" style="width: 300px;">
							<div class="input-group">
								<input type="text" class="form-control">
								<input type="button" value="포인트 모두 사용">
								<div class="text-left">(사용가능한 포인트 : <span class="pi_pos_amount">2000</span>P)</div>
							</div>
						</div>
						<div class="message mt-3 text-left">
							<small>- 적립금은 최소 1000P 이상일 때 사용 가능합니다.&nbsp;</small><br>
							<small>-  최대 사용금액은 제한이 없습니다.&nbsp;</small><br>
							<small>-  적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</small>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<br><hr><br>
	<!-- box-summary ------------------------------------------------------------------------------------------------ -->
	<div class="box-summary">
		<label class="font-weight-bold">결제 예정 금액</label>
		<table class="table">
			<thead>
				<tr>
					<th>총 주문금액</th>
					<th>포인트 사용</th>
					<th>총 결제예정 금액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="totalPrice">95000</td>
					<td class="pointAmount">0원</td>
					<td class="paymentPrice">95000원</td>				
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 결제하기 버튼 --------------------------------------------------------------------------------------------------- -->
	<button type="button" class="btn-pay col-12 mt-5">결제하기</button>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		editTotal();
	})
});	
	
/* 함수 *********************************************************************************************************** */
	//execDaumPostcode : 다음 주소찾기 ============================================================================
	function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      let addr = '';
	
	      if (data.userSelectedType === 'R')
	       	addr = data.roadAddress;
				else 
	       	addr = data.jibunAddress;
	
	      document.getElementById('ad_post_code').value = data.zonecode;
	      document.getElementById("ad_address").value = addr;
	      document.getElementById("ad_detail").focus();
	    }
   }).open();
	}//
	
	//numberToCurrency : 숫자를 통화로 ============================================================================
	function numberToCurrency(price){
		return new Intl.NumberFormat('en-KR').format(price) +'원';
	}//
	
	//editTotal : 총금액 수정 =====================================================================================
	function editTotal(){
		//상품 총 금액
		let goodsPrice = 0;
		$('.main .box-content .box-orderList table tbody tr').each(function(){
			goodsPrice += $(this).find('.totalPrice').data('value');
		});
		//배송비
		let deliveryFee = 3000;
		let basketLength = $('.main .box-content .box-orderList table tbody tr').length;
		if(goodsPrice >= 50000 || basketLength == 0)
			deliveryFee = 0;
		//결제 예정 금액
		let totalPrice = goodsPrice + deliveryFee;
		$('.main .box-content .box-orderList tfoot .goodsPrice').text(numberToCurrency(goodsPrice));
		$('.main .box-content .box-orderList tfoot .deliveryFee').text(numberToCurrency(deliveryFee));
		$('.main .box-content .box-orderList .item-delivery .deliveryFee').text(numberToCurrency(deliveryFee));
		$('.main .box-content .box-orderList tfoot .totalPrice').text(numberToCurrency(totalPrice));
	}//
</script>
</html>