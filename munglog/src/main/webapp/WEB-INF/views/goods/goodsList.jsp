<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 리스트</title>
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
	.main .box-sort{margin: 20px 0; padding-right: 20px;}
	.main .box-sort .sort:hover{color:#fb9600; cursor: pointer;}
	.main .box-sort .sort.select{color:#fb9600; font-weight: bold;}
	.main .box-sort .sort-latest::after{
		display: inline-block; content: ''; margin: 0 10px;
		width: 1px; height: 12px; background-color: #b9ab9a;
		line-height: 24px;
	}
	.main .box-content{margin: 20px 44px;}
	.main .box-content .log-list{
		display: table; width: 100%; min-width: 100%;
	}
	.main .box-content .goods-list .goods-item{
		display: inline-block; width: calc(25% - 4px);
		overflow: hidden; margin: 10px 0;
	}
	.main .box-content .goods-list .goods-item .box-thumb{
		border: 1px solid #dfe0df; margin: 10px; text-align: center;
	}
	.main .box-content .goods-list .goods-item .box-thumb .gs_thumb{
		width: 100%; max-width: 100%; height: 204.5px;
	}
	.main .box-content .goods-list .goods-item .box-thumb .gs_thumb:hover{transform: scale(1.1);}
	.main .box-content .goods-list .goods-item .box-description{margin: 10px;}
	.main .box-content .goods-list .goods-item .box-description .gs_name{
		display: inline-block; width: 100%; 
		overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
	}
	.main .box-content .goods-list .goods-item .box-description .gs_name:hover{color:#fb9600;}
	.main .box-content .pagination .page-item.active .page-link {
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
	.main .box-content .pagination .page-link {color: #402E32;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
	<!-- 제목 -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>굿즈</span>
		<div class="box-message">다양한 굿즈들을 구경하세요.</div>
	</div>
	<!-- box-sort -------------------------------------------------------- -->
	<div class="box-sort d-flex justify-content-end">
		<span class="sort sort-latest select">신상품순</span>
		<span class="sort sort-popularity">판매순</span>
	</div>
	<!-- box-content --------------------------------------------------------------------------------------- -->
	<div class="box-content">
		<!-- goods-list --------------------------------------------------------------------------------------- -->
		<ul class="goods-list"></ul>
		<!-- 페이지네이션 --------------------------------------------------------------------------------------- -->
		<ul class="pagination justify-content-center mt-5"></ul>
		<!-- box-search --------------------------------------------------------------------------------------- -->
		<div class="box-search">
			<div class="input-group mt-5">
				<div class="input-group-prepend">
					<select class="searchType form-control">
						<option value="gs_name">상품명</option>
						<option value="gs_ct_name">카테고리</option>
					</select>
				</div>
				<input type="text" class="keyword gs_keyword form-control" placeholder="검색어를 입력하세요.">
				<select class="keyword ct_keyword form-control" style="display: none;">
					<option value="">카테고리 선택</option>
					<c:forEach items="${categoryList}" var="category">
						<option value="${category.ct_name}">${category.ct_name}</option>
					</c:forEach>
				</select>
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
	let page = 1;
	let cri = {
		page,
		perPageNum : 20,
		order : 'desc',
		popularity : 0,
		searchType : '',
		keyword : ''
	};
/* 이벤트 *********************************************************************************************************** */
	$(function(){
		$(document).ready(function(){
			//굿즈 리스트 구현 ===========================================================================================
			getGoodsList(cri);
		})
		
		//페이지네이션(page-link) 클릭 ====================================================================================
		$(document).on('click','.main .box-content .pagination .page-link',function(e){
			e.preventDefault();
			cri.page = $(this).data('page');
			getGoodsList(cri);
		})//
		
		// 검색타입 값 바뀜====================================================================================
		$('.main .box-content .box-search .searchType').change(function(){
			let searchType = $(this).val();
			if(searchType == 'gs_name'){
				$('.main .box-content .box-search input.keyword').show();
				$('.main .box-content .box-search select.keyword').hide();
			}
			else if(searchType == 'gs_ct_name'){
				$('.main .box-content .box-search input.keyword').hide();
				$('.main .box-content .box-search select.keyword').show();
			}
		})//
		
		//검색 버튼(btn-search) 클릭 ====================================================================================
		$('.main .box-content .box-search .btn-search').click(function(){
			let searchType = $('.main .box-content .box-search .searchType').val();
			let keyword = '';
			//searchType에 따라 검색어 받는 곳이 다름
			if(searchType == 'gs_name')
				keyword = $('.main .box-content .box-search input.keyword').val();
			else if(searchType == 'gs_ct_name')
				keyword = $('.main .box-content .box-search select.keyword').val();
			//키워드를 입력 안하면 전체 검색되도록
			if(keyword == ''){
				cri.searchType = '';
				cri.keyword = '';
			} 
			else{
				cri.searchType = searchType;
				cri.keyword = keyword;			
			}
			getGoodsList(cri);
		})//
	});		
	
/* 함수 *********************************************************************************************************** */
	// getGoodsList =============================================================================================
	function getGoodsList(obj){
		ajaxPost(false, obj, '/get/goodsList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			//굿즈 목록 구현 -------------------------------------------------------------------------------
			for(goods of data.goodsList){
				html += '<li class="goods-item">';
				html += 	'<div class="box-thumb">';
				html += 		'<a href="'+contextPath+'/goods/goodsDetail/'+goods.gs_num+'" class="goods-link">';
				html += 			'<img class="gs_thumb" src="'+contextPath+goods.gs_thumb_url+'">';
				html += 		'</a>';
				html += 	'</div>';
				html += 	'<div class="box-description">';
				html += 		'<div class="name">';
				html += 			'<a class="goods-link" href="'+contextPath+'/goods/goodsDetail/'+goods.gs_num+'">';
				html += 				'<strong class="gs_name">'+goods.gs_name+'</strong>';
				html += 			'</a>';
				html += 		'</div>';
				html += 		'<div class="price">';
				html += 			'<span>판매가 : </span><span class="ot_price">'+goods.gs_price+'</span>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</li>';
			}
			$('.main .box-content .goods-list').html(html);		
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
		});
	}//
</script>
</html>