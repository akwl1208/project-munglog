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
		<div class="item-goods">
			<div class="box-classification clearfix">
				<!-- 카테고리/제품명 ------------------------------------------------------------------------------------------------ -->
				<div class="title float-left">
					<span>카테고리</span><span> - </span><span>제품</span>
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
				<tbody>
					<tr>
						<td class="item-name"><span class="ot_name">옵션명</span></td>
						<td class="item-amount"><span class="ot_amount">100</span></td>
						<td class="item-price"><span class="ot_price">9000</span></td>
						<td class="item-modify"><i class="btn-modify fa-solid fa-pen-to-square"></i></td>
					</tr>
				</tbody>
			</table>
		</div>
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
	
	})	
	
/* 함수 *********************************************************************************************************** */

</script>
</html>