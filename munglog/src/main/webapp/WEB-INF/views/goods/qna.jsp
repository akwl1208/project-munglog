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
	.main .box-content .box-qna table tbody .item-title .link-qna:hover .bd_title{color: #FF9E54;}
	.main .box-content .box-qna table tbody .item-nickname{
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap; 
	}
	.main .box-content .pagination .page-item.active .page-link{
	 z-index: 1; color: #fb9600; font-weight:bold;
	 background : #fff; border-color: #DFE0DF;	 
	}	
	.main .box-content .pagination .page-link:focus,
	.main .box-content .pagination .page-link:hover {
	  color: #000; background-color: #DFE0DF; border-color: #ccc;
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
			<tbody></tbody>
		</table>
	</div>
	<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
	<ul class="pagination justify-content-center mt-5"></ul>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let userLevel = '${user.mb_level}';
	let page = 1;
	let cri = {
		page,
		perPageNum : 10
	};  
	let year = new Date().getFullYear(); // 년도
	let month = new Date().getMonth() + 1;  // 월
	let date = new Date().getDate();  // 날짜
	let today = year + '-' + month + '-' + date;
/* 이벤트 *********************************************************************************************************** */
	$(function(){
		$(document).ready(function(){
			getQnaList(cri);
		})//
		
		//QNA 등록(btn-register) 클릭 =================================================================
		$('.main .box-content .box-register .btn-register').click(function(){
			if('${user.mb_num}' == ''){
				if(confirm('Q&A를 등록하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				return;
			}
		})//
		
		//페이지네이션(page-link) 클릭 ====================================================================================
		$(document).on('click','.main .box-content .pagination .page-link',function(e){
			e.preventDefault();
			cri.page = $(this).data('page');
			getQnaList(cri);
		})//
		
		//QNA 제목(link-qna) 클릭 =================================================================
		$(document).on('click','.main .box-content .box-qna .link-qna',function(e){
			let userMbNum = '${user.mb_num}';
			//로그인 안했으면
			if(userMbNum == ''){
				if(confirm('Q&A을 보려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
					location.href = '<%=request.getContextPath()%>/account/login';
				e.preventDefault();
				return;
			}
			//관리자가 아닌 다른 회원이 보려고 하면
			let mbNum = $(this).parents('tr').data('value');
			if(userLevel != 'A' && userLevel != 'S' && (userMbNum != mbNum)){
				alert('Q&A를 작성한 회원만 볼 수 있습니다.')	
				e.preventDefault();	
				return;
			}
		})//
	})//	
	
/* 함수 *********************************************************************************************************** */
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
				html += 	'<td class="item-thumb p-0">';
				html += 		'<a class="link-goods" href="'+contextPath+'/goods/goodsDetail/'+qna.qn_gs_num+'">';
				html += 			'<img class="gs_thumb" src="'+ contextPath +qna.gs_thumb_url+'">';
				html += 		'</a>';
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
			$('.main .box-content .box-qna table tbody').html(html);
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