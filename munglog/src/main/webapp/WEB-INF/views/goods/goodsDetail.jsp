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
	.main .box-content .nav-tabs .nav-item{
		width: 25%; text-align: center; font-weight: bold;
	}
	.main .box-content .nav-tabs .nav-item .nav-link.active{color: #fb9600;}
	.main .box-content .tab-content .tab-pane{
		padding: 30px 60px; text-align: center;
	}
	.main .box-content .tab-content .tab-pane table{margin: 0 auto;}
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
	<div class="clearfix">
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
					<small class="ml-2">(최소 1개 이상 선택해주세요.)</small>	
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
				<button type="button" class="btn-buy col-5 mr-2">바로 구매</button>
				<button type="button" class="btn-basket col-5">장바구니</button>
			</div>
		</div>			
	</div>
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
		<div id="review" class="container tab-pane fade">
		</div>
		<div id="qna" class="container tab-pane fade">
		</div>
	</div>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let gsName = '${goods.gs_name}';
/* 이벤트 *********************************************************************************************************** */
	$(function(){	
		// 옵션 선택 ============================================================================================
		$('.main .box-content .box-option select').change(function(){
			//값 가져오기
			let otNum = $(this).val();
			let otName = $(this).children("option:selected").data('name');
			let otAmount = $(this).children("option:selected").data('amount');
			let otPrice = $(this).children("option:selected").data('price');
			let otPriceStr = NumberToCurrency(otPrice);
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
			})
			if(!isSelected){
				alert('이미 선택한 상품입니다.')
				return;
			}
			//화면 구성
			let html = '';
			html += '<tr class="row-select" data-value="'+otNum+'">';
			html += 	'<th class="item-title" width="50%">';
			html += 		'<p class="title m-0">';
			html += 			'<strong class="gs_name">'+gsName+'</strong><br>';
			html += 			'<span class="ot_name ml-2">- '+otName+'</span>';
			html += 		'</p>';
			html += 	'</th>';
			html += 	'<td class="item-quantity" width="20%">';
			html += 		'<div class="quantity">';
			html += 			'<input type="text" class="bs_amount" value="1">';
			html += 			'<a href="#" class="up"><i class="fa-solid fa-caret-up"></i></a>';
			html += 			'<a href="#" class="down"><i class="fa-solid fa-caret-down"></i></a>';
			html += 		'</div>';
			html += 	'</td>';
			html += 	'<td width="25%">';
			html += 		'<span class="price" data-value="'+otPrice+'">'+otPriceStr+'</span>';
			html += 	'</td>';
			html += 	'<td width="5%">';
			html += 		'<div class="btn-delete"><i class="fa-solid fa-xmark"></i></div>';
			html += 	'</td>';
			html += '</tr>';
			$('.main .box-content .box-select table tbody').append(html);
			//총 금액 수정
			editTotal();
		})
	});	

/* 함수 *********************************************************************************************************** */
	//NumberToCurrency : 숫자를 통화로 ============================================================================
	function NumberTocurrency(price){
		return new Intl.NumberFormat('en-KR').format(price) +'원'
	}
	
	//editTotal : 총금액 수정 =====================================================================================
	function editTotal(){
		let totalCount = 0;
		let totalPrice = 0;
		$('.main .box-content .box-select table tbody tr').each(function(){
			let count = $(this).find('.bs_amount').val();
			let price = $(this).find('.price').data('value');
			totalCount += Number(count);
			totalPrice += price;
		})
		$('.main .box-content .box-total .total-price').text(NumberToCurrency(totalPrice));
		$('.main .box-content .box-total .total-quantity').text('('+totalCount+'개)');
	}
</script>
</html>