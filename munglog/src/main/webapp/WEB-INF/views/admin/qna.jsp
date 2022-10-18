<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 Q&A 관리</title>
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
	.main .box-content .box-state span:nth-child(n+1):not(:last-of-type)::after{
		display: inline-block; content: ''; margin: 0 6px 3px;
		width: 1px; height: 12px; background-color: #b9ab9a; 
		vertical-align: middle; line-height: 24px;
	}
	.main .box-content .box-state span:hover{color:#fb9600; cursor:pointer;}
	.main .box-content .box-state .select{color:#fb9600; font-weight:bold;}
	.main .box-content .box-qna table{
		table-layout: fixed; text-align: center; 
	}
	.main .box-content .box-qna table thead{background-color: #d7d5d5;}
	.main .box-content .box-qna table thead th,
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
		.main .box-content .box-search{
		width: 50%; margin: 0 auto;
	}
	.main .box-content .box-search .btn-search{
		padding: 0 10px; background-color: #a04c00;
		border: none; border-radius: 3px;
	}
	.main .box-content .box-search .btn-search .fa-solid{color: #fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 Q&A 관리</span>
	<div class="box-message">답변 대기 중인 Q&A를 확인하고, 관리하세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
	<div class="box-state text-right">
		<span class="wait select">답변 대기</span>
		<span class="complete">답변 완료</span>
		<span class="all">전체</span>
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
					<th width="17%">작성일</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
	<ul class="pagination justify-content-center mt-5"></ul>
	<!-- box-search --------------------------------------------------------------------------------------- -->
	<div class="box-search">
		<div class="input-group mt-5">
			<div class="input-group-prepend">
				<select class="searchType form-control">
					<option value="gs_num">굿즈명</option>
					<option value="bd_title">제목</option>
					<option value="mb_nickname">작성자</option>
				</select>
			</div>
			<!-- 굿즈 선택 --------------------------------------------------------------------------------------- -->
			<select class="keyword gs_keyword form-control">
				<option value="0">굿즈 선택</option>
				<c:forEach items="${goodsList}" var="goods">
					<option value="${goods.gs_num}">${goods.gs_name}</option>
				</c:forEach>
			</select>
			<!-- 제목 선택 --------------------------------------------------------------------------------------- -->
			<select class="keyword bd_keyword form-control" style="display: none;">
				<option value="">제목 선택</option>
				<option>상품 문의</option>
				<option>배송 문의</option>
				<option>교환 및 환불 문의</option>
				<option>결제 문의</option>
				<option>기타 문의</option>
			</select>
			<!-- 작성자 선택 --------------------------------------------------------------------------------------- -->
			<input type="text" class="keyword mb_keyword form-control" placeholder="검색어를 입력하세요." style="display: none;">
			<div class="input-group-append">
				<button class="btn btn-search" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
			</div>
		</div>
	</div>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let userMbNum = '${user.mb_num}';
	let userLevel = '${user.mb_level}';
	let page = 1;
	let cri = {
		page,
		perPageNum : 10,
		qn_state : '답변 대기',
		gs_num : 0,
		searchType : '',
		keyword : ''
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
		
		//페이지네이션(page-link) 클릭 ====================================================================================
		$(document).on('click','.main .box-content .pagination .page-link',function(e){
			e.preventDefault();
			cri.page = $(this).data('page');
			getQnaList(cri);
		})//
		
		//QNA 제목(link-qna) 클릭 =================================================================
		$(document).on('click','.main .box-content .box-qna .link-qna',function(e){
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
		
		// 검색타입 값 바뀜====================================================================================
		$('.main .box-content .box-search .searchType').change(function(){
			let searchType = $(this).val();
			if(searchType == 'gs_num'){
				$('.main .box-content .box-search .gs_keyword').show();
				$('.main .box-content .box-search .bd_keyword').hide();
				$('.main .box-content .box-search .mb_keyword').hide();
			}
			else if(searchType == 'bd_title'){
				$('.main .box-content .box-search .gs_keyword').hide();
				$('.main .box-content .box-search .bd_keyword').show();
				$('.main .box-content .box-search .mb_keyword').hide();
			}
			else if(searchType == 'mb_nickname'){
				$('.main .box-content .box-search .gs_keyword').hide();
				$('.main .box-content .box-search .bd_keyword').hide();
				$('.main .box-content .box-search .mb_keyword').show();
			}
		})//
		
		//검색 버튼(btn-search) 클릭 ====================================================================================
		$('.main .box-content .box-search .btn-search').click(function(){
			let searchType = $('.main .box-content .box-search .searchType').val();
			let gs_num = 0;
			let keyword = '';
			//searchType에 따라 검색어 받는 곳이 다름
			if(searchType == 'gs_num'){
				searchType = '';				
				gs_num = $('.main .box-content .box-search .gs_keyword').val();
			}
			else if(searchType == 'bd_title')
				keyword = $('.main .box-content .box-search .bd_keyword').val();
			else if(searchType == 'mb_nickname')
				keyword = $('.main .box-content .box-search .mb_keyword').val();
			//키워드를 입력 안하면 전체 검색되도록
			if(keyword == '' && gs_num == 0){
				cri.searchType = '';
				cri.gs_num = 0;
				cri.keyword = '';
			} 
			else{
				cri.searchType = searchType;
				cri.gs_num = gs_num;
				cri.keyword = keyword;			
			}
			getQnaList(cri);
		})//
		
		//상태 변경 클릭 ====================================================================================
		$('.main .box-content .box-state span').click(function(){
			//글자색 변경
			$('.main .box-content .box-state span').removeClass('select');
			$(this).addClass('select');
			//리스트 변경
			let qn_state = $(this).text();
			if(qn_state == '전체')
				qn_state = '';
			cri.qn_state = qn_state;
			getQnaList(cri);
		})//
	});	
	
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