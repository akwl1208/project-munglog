<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 포인트 내역</title>
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
	.main .box-content .box-total-point{
		border: 3px solid #b9ab9a; padding: 20px; border-radius: 10px;
	}
	.main .box-content .box-total-point .title{font-size: 18px;}
	.main .box-content .box-filter span:hover{color: #ff9e54; cursor: pointer;}
	.main .box-content .box-filter span.select{color: #fb9600; font-weight: bold;}
	.main .box-content .box-filter span+span::before{
		display: inline-block; content: ''; margin: 0 6px;
		width: 1px; height: 16px; background-color: #b9ab9a;
		vertical-align: middle;
	}
	.main .box-content .list-point{
		table-layout: fixed; border-top: 2px solid #d8d8d8; border-bottom: 2px solid #d8d8d8;
	}
	.main .box-content .list-point tbody .item-history{
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
	<i class="fa-solid fa-paw"></i><span>내 멍멍포인트 내역</span>
	<div class="box-message">적립, 사용한 포인트 내역을 확인하세요.</div>
</div>
<!-- box-content ------------------------------------------------------------------------------------------------- -->	
<div class="box-content">
	<!-- box-total-point ------------------------------------------------------------------------------------------------- -->	
	<div class="box-total-point mb-4 clearfix font-weight-bold">
		<span class="title float-left">현재 사용 가능한 멍멍포인트</span>
		<strong class="float-right"><span class="availablePoint mr-2"></span><span>P</span></strong>
	</div>
	<!-- box-filter ------------------------------------------------------------------------------------------------- -->	
	<div class="box-filter text-right mb-3">
		<span class="filter all select">전체</span>
		<span class="filter save">적립</span>
		<span class="filter use">사용</span>
	</div>
	<!-- box-point ------------------------------------------------------------------------------------------------- -->
	<div class="box-point">
		<!-- list-point ------------------------------------------------------------------------------------------------- -->
		<table class="list-point table">
			<thead class="thead-light">
				<tr class="text-center">
					<th width="20%">날짜</th>
					<th width="10%">구분</th>
					<th>내역</th>
					<th width="15%">포인트</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<!-- 페이지네이션 ------------------------------------------------------------------------------------------------- -->
		<ul class="pagination justify-content-center mt-5"></ul>
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
		perPageNum : 15,
		mb_num : user,
		searchType : '',
		keyword : ''
	};
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		calcAvailablePoint(user)
		getMyPointList(cri);
	})//
	
	//페이지네이션(page-link) 클릭 ====================================================================================
	$(document).on('click','.main .box-content .box-point .pagination .page-link',function(e){
		e.preventDefault();
		cri.page = $(this).data('page');
		getMyPointList(cri);
	})//
	
	$('.main .box-content .box-filter .filter').click(function(){
		//버튼 색 바꾸기
		$('.main .box-content .box-filter .filter').removeClass('select');
		$(this).addClass('select');
		//리스트 가져오기
		let filterKeyword = $(this).text();
		console.log(filterKeyword);
		if(filterKeyword == '전체'){
			cri.searchType = '';
			cri.keyword = '';
		} else if(filterKeyword == '적립'){
			cri.searchType = 'pi_process';
			cri.keyword = filterKeyword;
		} else if(filterKeyword == '사용'){
			cri.searchType = 'pi_process';
			cri.keyword = filterKeyword;
		}
		getMyPointList(cri);
	})//
});
   
/* 함수 *********************************************************************************************************** */
 	//getMyPointList : 나의 포인트 내역 가져오기 ======================================================================
	function getMyPointList(obj){
		ajaxPost(false, obj, '/get/myPointList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			//리스트 구현-----------------------------------------------------------------------------------
			for(point of data.pointList){
				html += '<tr class="text-center">';
				html += 	'<td>';
				html += 		'<span class="pi_date">'+point.pi_date_str+'</span>';
				html += 	'</td>';
				html += 	'<td>';
				html += 		'<span class="pi_process">'+point.pi_process+'</span>';
				html += 	'</td>';
				html += 	'<td class="item-history text-left pl-3">';
				html += 		'<span class="pi_history">'+point.pi_history+'</span>';
				html += 	'</td>';
				html += 	'<td>';
				html += 		'<span class="pi_amount">'+point.pi_amount+'</span>';
				html += 	'</td>';
				html += '</tr>';
			}	
			$('.main .box-content .box-point .list-point tbody').html(html);
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
			$('.main .box-content .box-point .pagination').html(html);
		});
	}//
	
 	//calcAvailablePoint : 나의 사용 가능한 포인트 가져오기 ======================================================================
	function calcAvailablePoint(mb_num){
		let obj = {mb_num};
		ajaxPost(false, obj, '/calculate/availablePoint', function(data){
			$('.main .box-content .box-total-point .availablePoint').text(data.availablePoint);
		});
	}//
</script>
</html>