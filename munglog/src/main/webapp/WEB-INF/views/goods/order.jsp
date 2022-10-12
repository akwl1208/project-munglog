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
	.main .box-content .box-delivery .btn-postcode,
	.main .box-content .box-point .btn-useAll{
		padding: 0 5px; background-color: #a04c00;
		border: none; color: #fff7ed; border-radius: 3px;
		display: inline-block;
	}
	.main .box-content .box-delivery .btn-postcode:hover,
	.main .box-content .box-point .btn-useAll:hover{box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);}
	.main .box-content .box-point .availablePoint{color: #fb9600; font-weight: bold;}
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
					<tr data-value="${order.otNum}">
						<td class="item-thumb">
							<a class="link-goods" href="<c:url value="/goods/goodsDetail/${order.gs_num}"></c:url>">
								<img class="gs_thumb" src="<c:url value="${order.gs_thumb_url}"></c:url>">	
							</a>
						</td>
						<td class="item-name text-left pl-4">
							<a class="link-goods" href="<c:url value="/goods/goodsDetail/${order.gs_num}"></c:url>">
								<strong class="gs_name">${order.gs_name}</strong>							
							</a>	
							<div class="box-option mt-2">
								<span class="mr-2">-</span><span class="ot_name">${order.ot_name}</span>
							</div>
						</td>
						<td class="item-price"><span class="ot_price" data-value="${order.ot_price}">${order.ot_price_str}</span></td>
						<td class="item-amount"><span class="or_amount" data-value="${order.orAmount}">${order.orAmount}</span></td>
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
	<!-- box-delivery --------------------------------------------------------------------------------------------- -->
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
								<input type="radio" class="form-check-input" name="address" value="${address.ad_num}" checked>회원 정보와 동일
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="address" value="0">새로운 배송지
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
							<input type="text" class="form-control" id="ad_recipient" value="${address.ad_recipient}">
						</div>
					</td>
				</tr>
				<!-- 주소 -------------------------------------------------------------------------------------------------- -->
				<tr>
					<th>주소(필수)</th>
					<td>
						<div class="form-group m-0">
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="ad_post_code" placeholder="우편번호" value="${address.ad_post_code}">
								<input type="button" class="btn-postcode" onclick="execDaumPostcode()" value="우편번호 찾기">
							</div>
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="ad_address" placeholder="주소" value="${address.ad_address}"><br>
							</div>
							<div class="input-group">
								<input type="text" class="form-control" id="ad_detail" placeholder="상세주소" value="${address.ad_detail}">
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
								<input type="text" class="form-control" id="ad_phone_first" value="${address.ad_phone_first}">
							</div>
							<span>-</span>
							<div class="col">
								<input type="text" class="form-control" id="ad_phone_middle" value="${address.ad_phone_middle}">
							</div>
							<span>-</span>
							<div class="col" >
								<input type="text" class="form-control" id="ad_phone_last" value="${address.ad_phone_last}">
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
								<input type="text" class="form-control" id="mb_email_id" value="${user.mb_email_id}">
							</div>
							<span>@</span>
							<div class="col">
								<input type="text" class="form-control" id="mb_email_domain" value="${user.mb_email_domain}">
							</div>
						</div>
						<div class="text-left mt-2">
							<small><i class="fa-solid fa-paw mr-2"></i>메일로 배송 현황을 알려드립니다. 메일 수신이 가능한 메일을 작성해주세요.</small>
						</div>
					</td>
				</tr>
				<!-- 배송메시지 ---------------------------------------------------------------------------------------------- -->
				<tr>
					<th>배송메시지</th>
					<td>
						<div class="form-group m-0">
							<textarea class="form-control" id="ad_request" rows="3" style="resize: none;">${address.ad_request}</textarea>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div><small class="error"></small></div>
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
								<input type="text" class="form-control usePoint" value="0">
								<div class="input-group-append">
							    <button class="btn-useAll" type="button">포인트 모두 사용</button>
							  </div>
							</div>
							<div class="text-left">(사용가능한 포인트 : <span class="availablePoint mr-1">${user.availablePoint}</span>P)</div>
						</div>
						<div class="message mt-3 text-left">
							<small>
								<i class="fa-solid fa-paw mr-2"></i>포인트는 최소 1000P 이상일 때 사용 가능합니다.
							</small><br>
							<small>
								<i class="fa-solid fa-paw mr-2"></i>최대 사용 가능한 포인트는 제한이 없습니다.
							</small><br>
							<small>
								<i class="fa-solid fa-paw mr-2"></i>포인트으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.
							</small>
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
					<td class="totalPrice"></td>
					<td class="usePoint"></td>
					<td class="paymentPrice"></td>				
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
	let recipientRegex = /^([가-힣]{1,10})|([a-zA-Z]{1,10})$/;
	let phoneRegex = /^(\d{3,4})$/;
	let postcodeRegex = /^(\d{5})$/;
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		editTotal();
		editPayment()
	})//
	
	//배송지 라디오 값이 바뀌면 ======================================================================================
	$('.main .box-content .box-delivery input[name=address]:radio').change(function(){
		let value = $(this).val();
		//새로운 배송지 선택하면
		if(value == 0){
			//값 비우기
			$('.main .box-content .box-delivery input:text').val('');
			$('.main .box-content .box-delivery textarea#ad_request').val('');
		}
		//회원 정보와 동일 선택(기본배송지)
		else{
			$('.main .box-content .box-delivery #ad_recipient').val('${address.ad_recipient}');
			$('.main .box-content .box-delivery #ad_post_code').val('${address.ad_post_code}');
			$('.main .box-content .box-delivery #ad_address').val('${address.ad_address}');
			$('.main .box-content .box-delivery #ad_detail').val('${address.ad_detail}');
			$('.main .box-content .box-delivery #ad_phone_first').val('${address.ad_phone_first}');
			$('.main .box-content .box-delivery #ad_phone_middle').val('${address.ad_phone_middle}');
			$('.main .box-content .box-delivery #ad_phone_last').val('${address.ad_phone_last}');
			$('.main .box-content .box-delivery #mb_email_id').val('${user.mb_email_id}');
			$('.main .box-content .box-delivery #mb_email_domain').val('${user.mb_email_domain}');
			$('.main .box-content .box-delivery #ad_request').val('${address.ad_request}');
		}
	})//
	
	// input:text 글자 제한 이벤트 =================================================================================
   $('.main .box-content .box-delivery input:text').keyup(function() {
	   let thisId = $(this).attr('id');
	   //수령인은 10글자
	   if(thisId == 'ad_recipient')
	   	wordLimit(this, 10);
	   //핸드폰 번호 4글자
	   if(thisId == 'ad_phone_middle' || thisId == 'ad_phone_last')
	   	wordLimit(this, 4);
	   //우편번호 5글자
	   if(thisId == 'ad_post_code')
	   	wordLimit(this, 5);
	   //주소 100글자
	   if(thisId == 'ad_address' || thisId == 'ad_detail')
		 	wordLimit(this, 100);
   })//

   // textarea 글자 제한 이벤트 =================================================================================
   $('.main .box-content .box-delivery #ad_request').keyup(function() {
	   wordLimit(this, 255);
   })//
   
	 // input:text 값 바뀌면 이벤트 =================================================================================
   $('.main .box-content .box-delivery input:text').change(function() {
	   $('.main .box-content .box-delivery .error').text('').hide();
	   if(!validateInputs())
		   return;
   })//
   
   //포인트 모두 사용 클릭 =================================================================================
   $('.main .box-content .box-point .btn-useAll').click(function() {
	   let point = '${user.availablePoint}';
	   let totalPrice = $('.main .box-content .box-orderList tfoot .totalPrice').data('value');
	   if(point < 1000){
		   alert('포인트는 최소 1000P 이상일 때 사용가능합니다.')
		   return;
	   }
	   //전체금액보다 보유 포인트가 많은 경우
	   if(point > totalPrice){
		   $('.main .box-content .box-point .usePoint').val(totalPrice);
	   }
	   else
	   	$('.main .box-content .box-point .usePoint').val(point);
	   editPayment();
   })//
   
   //포인트 입력 제한 =================================================================================
   $('.main .box-content .box-point .usePoint').keyup(function() {
	   //첫자리가 0이면 0으로 입력되게 함
	   if($(this).val().indexOf(0) == 0){
		   $(this).val('0');
	   }
	   //숫자 이외의 값 입력 못하게 막음
		 $(this).val($(this).val().replace(/[^0-9]/g, ''));
   })//
   
   //포인트 입력이 바뀌면 ================================================================================
   $('.main .box-content .box-point .usePoint').change(function() {
		 //0이 아니고 1000이상만
		 let value = $(this).val();
		 if(value.length == 0){
			 $(this).val('0');
			 editPayment();
			 return;
		 }
		 if((value != 0 && value < 1000)){
		   alert('포인트는 최소 1000P 이상일 때 사용가능합니다.')
		   $(this).val('0');
			 editPayment();
			 return;
	   }
		 //보유 금액보다 많으면
		 let point = '${user.availablePoint}';
		 if(Number(value) > Number(point)){
			 alert('보유 포인트를 넘는 포인트를 사용할 수 없습니다.');
			 $(this).val('0');
			 editPayment();
			 return;
		 }
		 //상품 금액보다 많으면
		 let totalPrice = $('.main .box-content .box-orderList tfoot .totalPrice').data('value');
		 if(Number(value) > Number(totalPrice)){
			 alert('전체 금액를 넘는 포인트를 사용할 수 없습니다.');
			 $(this).val('0');
			 editPayment();
			 return;
		 }
		 editPayment();
   })//
   
   //결제하기(btn-pay) 클릭 ================================================================================
   $('.main .box-content .btn-pay').click(function(){
	   //로그인 안했으면
	   if('${user.mb_num}' < 1){
		   alert('로그인 후 결제 가능합니다.');
		   location.href = '<%=request.getContextPath()%>/account/login';
		   return;
	   }
	   //주문서에 담긴 상품이 없으면
	   let trLength = $('.main .box-content .box-orderList table tbody tr').length;
	   if(trLength == 0){
		   alert('주문할 굿즈가 없습니다.');
		   location.href = '<%=request.getContextPath()%>/goods';
		   return;
	   }
	   //입력 안했으면
	   if(!validateInputs())
		   return;
		 //우편번호
		 let postcode = $('.main .box-content .box-delivery #ad_post_code').val();
		 //주소
		 let address = $('.main .box-content .box-delivery #ad_address').val();
		 let detail = $('.main .box-content .box-delivery #ad_detail').val();
		 //전체 금액
		 let totalPrice = $('.main .box-content .box-orderList tfoot .totalPrice').data('value');
		 //결제 금액
		 let amount = $('.main .box-content .box-summary table .paymentPrice').attr('data-value');
		 //주문코드
		 let merchant_uid = makeOrderCode();
		 //사용포인트
		 let pointAmount = $('.main .box-content .box-point .usePoint').val();
		 if(pointAmount > ${user.availablePoint}){
			 alert('사용 포인트는 보유 포인트보다 많을 수 없습니다.')			
			 return;
		 }
		 //포인트 전액 결제
		 if(pointAmount != 0 && amount == 0 && (totalPrice == pointAmount)){
			 completePayment(postcode, address, detail, amount, pointAmount, "포인트전액결제", merchant_uid);
			 return;
		 }
		 //포인트 전액 결제 아님
	   payment(postcode, address, detail, amount, pointAmount, merchant_uid);
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
	function numberToCurrency(price, str){
		return new Intl.NumberFormat('en-KR').format(price) + str;
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
		$('.main .box-content .box-orderList tfoot .goodsPrice').text(numberToCurrency(goodsPrice,'원'));
		$('.main .box-content .box-orderList tfoot .deliveryFee').text(numberToCurrency(deliveryFee,'원'));
		$('.main .box-content .box-orderList .item-delivery .deliveryFee').text(numberToCurrency(deliveryFee,'원'));
		$('.main .box-content .box-orderList tfoot .totalPrice').text(numberToCurrency(totalPrice,'원'));
		$('.main .box-content .box-orderList tfoot .totalPrice').attr('data-value',totalPrice);
	}//
	
	//editPayment : 결제 금액 수정 =====================================================================================
	function editPayment(){
		let totalPrice = $('.main .box-content .box-orderList tfoot .totalPrice').data('value');
		let usePoint = $('.main .box-content .box-point .usePoint').val();
		let paymentPrice = totalPrice - usePoint;
		$('.main .box-content .box-summary table .totalPrice').text(numberToCurrency(totalPrice,'원'));
		$('.main .box-content .box-summary table .usePoint').text(numberToCurrency(usePoint,'P'));
		$('.main .box-content .box-summary table .paymentPrice').text(numberToCurrency(paymentPrice,'원'));
		$('.main .box-content .box-summary table .paymentPrice').attr('data-value',paymentPrice);
	}//
	
	//wordLimit : 글자수 제한 =====================================================================================
	function wordLimit(selector, limit){
	  if($(selector).val().length > limit)
	  	$(selector).val($(selector).val().substring(0, limit));
	}//
	
	//validateInputs : 입력값 검사 =====================================================================================
	function validateInputs(){
		//수령인 ---------------------------------------------------------------------------------
		let recipient = $('.main .box-content .box-delivery #ad_recipient').val();
		if(recipient == ''){
			$('.main .box-content .box-delivery .error').text('받는 사람을 입력해주세요.').show();
			$('.main .box-content .box-delivery #ad_recipient').focus();
			return false;
		}
		if(!recipientRegex.test(recipient)){
			$('.main .box-content .box-delivery .error').text('한글이나 영어로 최대 10글자 입력해주세요.').show();		
			$('.main .box-content .box-delivery #ad_recipient').focus();
			return false;
		}
		//우편번호 ---------------------------------------------------------------------------------
		let postcode = $('.main .box-content .box-delivery #ad_post_code').val();
		if(postcode == ''){
			$('.main .box-content .box-delivery .error').text('우편번호를 입력해주세요.').show();
			$('.main .box-content .box-delivery #ad_post_code').focus();
			return false;
		}
		if(!postcodeRegex.test(postcode)){
			$('.main .box-content .box-delivery .error').text('숫자만 5자 입력해주세요.').show();			
			$('.main .box-content .box-delivery #ad_post_code').focus();
			return false;
		}
		//주소 ---------------------------------------------------------------------------------------
		let address = $('.main .box-content .box-delivery #ad_address').val();
		if(address == ''){
			$('.main .box-content .box-delivery .error').text('주소를 입력해주세요.').show();
			$('.main .box-content .box-delivery #ad_address').focus();
			return false;
		}
		if(address.length > 100){
			$('.main .box-content .box-delivery .error').text('주소는 최대 100글자입니다.').show();			
			$('.main .box-content .box-delivery #ad_address').focus();
			return false;
		}
		//주소 상세 ---------------------------------------------------------------------------------------
		let detail = $('.main .box-content .box-delivery #ad_detail').val();
		if(detail.length > 100){
			$('.main .box-content .box-delivery .error').text('주소상세는 최대 100글자입니다.').show();
			$('.main .box-content .box-delivery #ad_detail').focus();
			return false;
		}
		//핸드폰 번호 --------------------------------------------------------------------------------------
		let phoneFirst = $('.main .box-content .box-delivery #ad_phone_first').val();
		let phoneMiddle = $('.main .box-content .box-delivery #ad_phone_middle').val();
		let phoneLast = $('.main .box-content .box-delivery #ad_phone_last').val();
		if(phoneFirst == '' || phoneMiddle == '' || phoneLast == ''){
			$('.main .box-content .box-delivery .error').text('핸드폰 번호를 입력해주세요.').show();
			$('.main .box-content .box-delivery #phoneFirst').focus();
			return false;
		}
		if(!phoneRegex.test(phoneFirst) || !phoneRegex.test(phoneMiddle) || !phoneRegex.test(phoneLast)){
			$('.main .box-content .box-delivery .error').text('숫자만 3-4자 입력해주세요.').show();			
			$('.main .box-content .box-delivery #phoneFirst').focus();
			return false;
		}
		//이메일 ------------------------------------------------------------------------------------------
		let emailId = $('.main .box-content .box-delivery #mb_email_id').val();
		let emailDomain = $('.main .box-content .box-delivery #mb_email_domain').val();
		if(emailId == '' || emailDomain == ''){
			$('.main .box-content .box-delivery .error').text('이메일을 입력해주세요.').show();
			$('.main .box-content .box-delivery #mb_email_id').focus();
			return false;
		}
		//요청사항
		let request = $('.main .box-content .box-delivery #ad_request').val();
		if(request.length > 255){
			$('.main .box-content .box-delivery .error').text('상세 주소는 최대 255글자입니다.').show();			
			$('.main .box-content .box-delivery #ad_address').focus();
			return false;
		}
		//포인트
		let pointAmount = $('.main .box-content .box-point .usePoint').val();
		if(pointAmount > ${user.availablePoint}){
			alert('사용 포인트는 보유 포인트보다 많을 수 없습니다.')			
			return false;
		}
		return true;
	}//
	
	//payment : 결제하기 =======================================================================================
	function payment(postcode, address, detail, amount, pointAmount, merchant_uid){
		//값 가져오기 -------------------------------------------------------------------------------------------
		//주문명
		let gsName = $('.main .box-content .box-orderList tbody tr').eq(0).find('.gs_name').text()
		let otName = $('.main .box-content .box-orderList tbody tr').eq(0).find('.ot_name').text();
		let orCount = $('.main .box-content .box-orderList tbody tr').length - 1;
		let name = gsName + '(' + otName + ')';
		if(orCount > 0)
			name += ' 외 ' + orCount + '개'
		//이메일
		let buyer_email = '${user.mb_email}';
		//구매자 이름
		let buyer_name = '${user.mb_name}';
		//핸드폰 번호
		let buyer_tel = '${user.mb_phone}';
		//주소
		let buyer_addr = address + ' ' +detail;
		//우편번호
		let buyer_postcode = postcode;
		//주문하기 -------------------------------------------------------------------------------------------
		IMP.init('');

		IMP.request_pay({
	    pg : 'html5_inicis.INIpayTest',
	    pay_method : 'card',
	    merchant_uid : merchant_uid,
	    name : name,
	    amount : amount,
	    buyer_email : buyer_email,
	    buyer_name : buyer_name,
	    buyer_tel : buyer_tel,
	    buyer_addr : buyer_addr,
	    buyer_postcode : buyer_postcode
		}, 
		function(rsp) {
	    if (rsp.success) { // 결제 성공 시
	      jQuery.ajax({
	        url: '<%=request.getContextPath()%>/verify/payment',
	        method: 'POST',
	        headers: { "Content-Type": "application/json" }, 
	        data: {
	          imp_uid: rsp.imp_uid,
	          paid_amount: rsp.paid_amount
	        },
	        success: function(data){
	        	if(data.res){
	        		let payAmount = rsp.paid_amount;
	        		let imp_uid = rsp.imp_uid;
	        		let merchant_uid =rsp.merchant_uid;
	        		completePayment(buyer_postcode, address, detail, payAmount, pointAmount, imp_uid, merchant_uid);
	        	} else
	        		alert('결제에 실패했습니다.');
	        }
	      });
	    } else{
	    	alert('결제에 실패했습니다.' +  rsp.error_msg);
	    }
		});
	}//
	
	//completePayment : 결제 완료 =====================================================================================
	function completePayment(postcode, address, detail, payAmount, pointAmount, imp_uid, merchant_uid){
		//값 가져오기 ----------------------------------------------------------------------------------
		//배송 번호
		let adNum = $('.main .box-content .box-delivery input[name=address]:radio').val();
		let mbNum = '${user.mb_num}'
		//수령인
		let recipient = $('.main .box-content .box-delivery #ad_recipient').val();
		//전화번호
		let phoneFirst = $('.main .box-content .box-delivery #ad_phone_first').val();
		let phoneMiddle = $('.main .box-content .box-delivery #ad_phone_middle').val();
		let phoneLast = $('.main .box-content .box-delivery #ad_phone_last').val();
		let phone = phoneFirst + '-' + phoneMiddle + '-' + phoneLast;
		//배송요구사항
		let request = $('.main .box-content .box-delivery #ad_request').val();
		//이메일
		let emailId = $('.main .box-content .box-delivery #mb_email_id').val();
		let emailDomain = $('.main .box-content .box-delivery #mb_email_domain').val();
		let email = emailId + '@' + emailDomain;
		//주문 상품
		let orderList = [];
		$('.main .box-content .box-orderList table tbody tr').each(function(){
			//값 설정
			let order = {};
			let otNum = $(this).data('value');
			let orAmount = $(this).find('.or_amount').data('value');
			let ot_price = $(this).find('.ot_price').data('value');
			order.otNum = otNum;
			order.orAmount = orAmount;
			order.ot_price = ot_price;
			orderList.push(order);
		});
		let obj = {
			mbNum,
			adNum,
			recipient,
			postcode,
			address,
			detail,
			phone,
			request,
			pointAmount,
			payAmount,
			email,
			orderList,
			imp_uid,
			orCode : merchant_uid
		}
		ajaxPost(false, obj, '/complete/payment', function(data){
			if(data.res){
				alert('결제에 성공했습니다.');
				location.href = '<%=request.getContextPath()%>';
			}else
				alert('결제에 실패했습니다.')
		});
	}//
	
	//makeOrderCode : 주문코드 만들기 =============================================================
	function makeOrderCode(){
		let today = new Date();   
		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월
		let date = today.getDate();  // 날짜
		let mbNum = '${user.mb_num}';
		let time = today.getTime();
		return year + ''+ month + '' + date + mbNum + time;
	}
</script>
</html>