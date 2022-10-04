<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 관리</title>
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
	.main .box-content .btn-register{
		float: right; background-color: #a04c00;
		border: none; color: #fff7ed; box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
		border-radius: 3px; padding: 5px 10px;
	}
	.main .box-content .list-goods .box-classification{
		font-weight: bold; font-size: 18px;
	}
	.main .box-content .list-goods .box-classification .btn-view:hover,
	.main .box-content .box-option .btn-modify:hover{color:#fb9600; cursor: pointer;}
	.main .box-content .box-option thead{background-color: #dfe0df;}
	.main .box-content .box-option td, 
	.main .box-content .box-option tr{text-align: center;}
	.main .box-content .box-option{vertical-align: middle;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 관리</span>
	<div class="box-message">굿즈를 등록하고 관리하세요.</div>
</div>	
<!-- box-content ----------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
 	<!-- 굿즈 등록 버튼 ----------------------------------------------------------------------------------------------------- -->
	<div class="clearfix">
		<a href="<c:url value="/admin/registerGoods"></c:url>" class="btn-register mb-4">굿즈 등록</a>
	</div>
	<!-- list-goods ----------------------------------------------------------------------------------------------------- -->
	<div class="list-goods">
		<!-- item-good ----------------------------------------------------------------------------------------------------- -->
		<c:forEach items="${goodsList}" var="goods">
			<div class="item-goods mb-5" data-value="${goods.gs_num}">
				<div class="box-classification clearfix">
					<!-- 카테고리/제품명 ------------------------------------------------------------------------------------------------ -->
					<div class="title float-left">
						<span>${goods.gs_ct_name}</span><span> - </span><span>${goods.gs_name}</span>
					</div>
					<!-- 상세보기 버튼 -------------------------------------------------------------------------------------------------- -->
					<div class="float-right">
						<a href="#">
							<i class="btn-view fa-regular fa-eye mr-2"></i>
						</a>
					</div>
				</div>
				<!-- box-option ----------------------------------------------------------------------------------------------------- -->
				<table class="table table-bordered box-option mt-2">
					<thead>
						<tr>
							<th width="50%">옵션명</th>
							<th width="20%">수량</th>
							<th width="20%">가격</th>
							<th width="10%"></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</c:forEach>
	</div>
	<!-- 페이지네이션 ----------------------------------------------------------------------------------------------------- -->
	<ul class="pagination justify-content-center mt-5">
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">이전</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">1</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">다음</a></li>
	</ul>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

/* 이벤트 *********************************************************************************************************** */
	$(function(){
		$(document).ready(function(){
			let list = $('.main .box-content .list-goods .item-goods');
			let size = list.length;
			for(let i = 0; i < size; i++){
				//옵션 화면 구성 --------------------------------------------------------------------------------------------------
				let ot_gs_num = list.eq(i).data('value');
				let obj = {ot_gs_num};
				getOptionList(obj, i);
			}
		})
	})	
	
/* 함수 *********************************************************************************************************** */
	// getOptionList : 옵션 리스트 가져오기 =============================================================================
	function getOptionList(obj, i){
		ajaxPost(false, obj, '/get/optionList', function(data){
			let html = '';
			//리스트 구현-----------------------------------------------------------------------------------
			for(option of data.optionList){
				html += '<tr data-value="'+option.ot_num+'">';
				html += 	'<td class="item-name"><span class="ot_name">'+option.ot_name+'</span></td>';
				html += 	'<td class="item-amount"><span class="ot_amount">'+option.ot_amount+'</span></td>';
				html += 	'<td class="item-price"><span class="ot_price">'+option.ot_amount+'</span></td>';
				html += 	'<td class="item-modify"><i class="btn-modify fa-solid fa-pen-to-square"></i></td>';
				html += '</tr>';
			}
			$('.main .box-content .list-goods .item-goods').eq(i).find('tbody').html(html);	
		})
	}//
</script>
</html>