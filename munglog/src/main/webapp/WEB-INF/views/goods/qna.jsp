<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 Q&A</title>
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
	.main .box-content .box-qna table{
		table-layout: fixed; text-align: center; 
	}
	.main .box-content .box-qna table thead{background-color: #d7d5d5;}
	.main .box-content .box-qna table tbody td{vertical-align: middle;}
	.main .box-content .box-qna table tbody .item-thumb .gs_thumb{
		max-width: 100%; width: 100%;
	}
	.main .box-content .box-qna table tbody .item-nickname{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap; 
	}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 Q&A</span>
	<div class="box-message">Q&A를 등록하고 확인하세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
	<!-- box-register(등록) ------------------------------------------------------------------------------------------------- -->
	<div class="box-register clearfix">
		<a href="<c:url value="/goods/registerQna"></c:url>" class="btn-register mb-4">Q&A 등록</a>
	</div>
	<!-- box-qna ------------------------------------------------------------------------------------------------- -->
	<div class="box-qna">
		<table class="table table-bordered list-gna mt-2">
			<thead>
				<tr class="text-center">
					<th width="11%">답변 상태</th>
					<th width="110px">상품 이미지</th>
					<th>제목</th>
					<th width="20%">작성자</th>
					<th width="15%">작성일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="item-state">
						<span class="">답변 상태</span>
					</td>
					<td class="item-thumb p-0">
						<a class="link-goods" href="#">
							<img class="gs_thumb" src="/akwl.jpg">
						</a>
					</td>
					<td class="item-title text-left">
						<a class="link-qna" href="#">
							<strong class="bd_title">제목</strong>
						</a>
					</td>
					<td class="item-nickname">
						<span class="mb_nickname">아지짱짱아지짱짱아지</span>
					</td>
					<td class="item-date">
						<span class="bd_reg_date">2022-10-12</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
	<ul class="pagination justify-content-center mt-5">
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">이전</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">1</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">2</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">다음</a></li>
	</ul>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

/* 이벤트 *********************************************************************************************************** */
	$(function(){
		//QNA 등록(btn-register) 클릭 =================================================================
		$('.main .box-content .box-register .btn-register').click(function(){
			if('${user.mb_num}' == ''){
				if(confirm('Q&A를 등록하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				return;
			}
		})//
	})//	
	
/* 함수 *********************************************************************************************************** */
	//  :  =============================================================================

</script>
</html>