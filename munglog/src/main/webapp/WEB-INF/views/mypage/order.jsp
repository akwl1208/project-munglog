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
	.main .box-content .box-pay .item-goods .box-goods .link-goods{
			position: absolute; left: 9px; top: 50%;
		width: 90px; height: 90px;
	  	margin-top: -45px; text-align: center; overflow: hidden;
	}
	.main .box-content .box-pay .item-goods .box-goods .link-goods .gs_thumb{
		vertical-align: top; width: 90px; height: 90px;
	}
	.main .box-content .box-pay .item-goods .box-goods-info .gs_name{
		max-width: 100%; 
		overflow: hidden; white-space: nowrap; text-overflow: ellipsis;
	}
	.main .box-content .box-pay .item-goods .box-goods-info .gs_name:hover{color:#fb9600}
	.main .box-content .box-pay .item-goods .box-goods-info .goods-info{margin: 8px 0px 12px;}
	.main .box-content .box-pay .item-goods .box-goods-info .goods-info li{
		display: inline-block; line-height: 18px; position: relative;
	}
	.main .box-content .box-pay .item-goods .box-goods-info .goods-info li+li::before{
		position: absolute; left: 0; top: 50%;
	  	width: 1px; height: 17px; margin-top: -8px;
	  	background-color: #d7d5d5; content: '';
	}
	.main .box-content .box-pay .item-goods .box-button .btn{
		width: 100%; padding: 2px 0; line-height: 27px;
	  	font-size: 12px; color: #a04c00; font-weight: bold; 
		background-color: white; border: 1px solid #a04c00;  border-radius: 3px;
	}
	.main .box-content .box-pay .item-goods .box-button .btn+.btn{margin-top: 4px;}
	.main .box-content .box-pay .item-goods .box-button .btn:hover{
		background-color: #a04c00; color: #fff7ed;
	}
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
/* 이벤트 *********************************************************************************************************** */
	$(function(){
		$(document).ready(function(){
			getMyOrderList(cri);
		})//
		
		//datepicker ===============================================================================================
		let dateFormat = 'yy-mm-dd';
    $('#fromDate')
      .datepicker({
			changeMonth: true,
    		changeYear: true,
			maxDate: 0,
			dateFormat
    });

    $('#toDate').datepicker({
		changeMonth: true,
   		changeYear: true,
		maxDate: 0,
		dateFormat
    });
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
						if(orderDetail.od_state == '입금전' || orderDetail.od_state == '배송준비중')
							html += 	'<a href="#" class="btn btn-cancel">주문 취소</a>';
						else if(orderDetail.od_state == '배송완료'){
							html += 	'<a href="#" class="btn btn-decision">구매 확정</a>';
							html += 	'<a href="#" class="btn btn-exchange">교환 요청</a>';
							html += 	'<a href="#" class="btn btn-refund">반품 요청</a>';								
						}
						else if(orderDetail.od_state == '구매확정')				
							html += 	'<a href="#" class="btn btn-review">리뷰 작성</a>';
						html += 	'</div>';
						html += '</li>';
					}//if
				}//for:orderDetail
				html += '</ul>';
			}//for:order	
			$('.main .box-content .box-pay .box-goods-pay').html(html);
		});
	}
</script>
</html>