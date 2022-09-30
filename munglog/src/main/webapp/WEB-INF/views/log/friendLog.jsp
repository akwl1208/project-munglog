<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-멍멍친구 일지</title>
<!-- css ************************************************************ -->
<style>
	/* main box-title --------------------------------------------------------------------- */
	.main .box-title{
		background-color: #ae8a68; border-radius: 5px;
		padding: 20px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
		margin-bottom: 10px; font-size: 18px; font-weight: bold;
	}
	.main .box-title .fa-paw{margin-right: 6px;}
	.main .box-title .box-message{
		font-size: 12px; margin: 5px 0; padding-left: 24px;
	}
	/* main box-nav --------------------------------------------------------------------- */
	.main .box-nav{margin-bottom: 10px; position: relative;}
	.main .box-nav .box-set .set{margin-left: 10px;}
	.main .box-nav .box-set .set .fa-solid.select{color:#fb9600;}
	.main .box-nav .box-set .set .fa-solid:hover{color:#fb9600;cursor:pointer;}
	.main .box-nav .box-drop{
		position: absolute; top: 40px; left: 0; right: 0; background-color: white;
		width: 100%; border-bottom: 3px solid rgba(73, 67, 60, 0.1);  z-index: 10;
	}
	.main .box-nav .box-drop .drop{padding: 20px 40px;}
	.main .box-drop .drop-upload .box-check .box-message,
	.main .box-drop .drop-filter .box-radio .box-message{margin: 5px 0;}
	.main .box-drop .drop-upload .box-file .btn-file,
	.main .box-drop .drop-upload .box-send .btn-send,
	.main .box-drop .drop-filter .box-btn .btn-reset,
	.main .box-drop .drop-filter .box-btn .btn-set{
		padding: 5px 10px; background-color: #a04c00; margin-left: 10px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
		border-radius: 3px;
	}
	.main .box-drop .drop-upload .box-send,
	.main .box-drop .drop-filter .box-year{margin-top: 20px;}
	.main .box-drop .drop-upload .box-send .box-preview{margin: 0 auto; cursor: pointer;}
	.main .box-drop .drop-filter .box-btn{text-align: right;}
	.main .box-drop .drop-sort .box-choose{text-align: right;}
	.main .box-drop .drop-sort .box-choose .sort-oldest::before,
	.main .box-drop .drop-sort .box-choose .sort-popularity::before{
		display: inline-block; content: ''; margin: 0 10px;
		width: 1px; height: 12px; background-color: #b9ab9a;
		line-height: 24px;
	}
	.main .box-drop .drop-sort .box-choose .sort.select{color:#fb9600; font-weight: bold;}
	.main .box-drop .drop-sort .box-choose .sort:hover{color:#fb9600;cursor:pointer;}
	/* main box-content --------------------------------------------------------------------- */
	.main .box-content{margin: 30px 44px;}
	.main .box-content .log-list{
		display: table; width: 100%; min-width: 100%;
	}
	.main .box-content .log-list .log-item{
		display: inline-block; width: calc(25% - 10px); height: calc(702px / 4);
		overflow: hidden; margin: 5px;
	}
	.main .box-content .log-list .log-item .log-link{
		width: 100%; height: 100%; display: block; background-position: center center; 
		background-size: cover; border: 1px solid #dfe0df;
	}
	.main .box-content .log-list .log-item .log-link:hover{transform: scale(0.9);}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<!-- box-title(제목) --------------------------------------------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>멍멍친구 일지</span>
		<div class="box-message">멍멍친구의 일지를 감상하고, 친구를 맺어보세요.</div>
	</div>
	<!-- box-nav(메뉴) ----------------------------------------------------------------------------------------------- -->
	<div class="box-nav">
		<!-- box-set(아이콘 버튼들) --------------------------------------------------------------------------------------- -->
		<div class="box-set d-flex justify-content-end">
			<div class="set box-filter p-2"><i class="btn-filter fa-solid fa-filter"></i></div>
			<div class="set box-sort p-2"><i class="btn-sort fa-solid fa-arrow-down-short-wide"></i></div>
		</div>
		<!-- box-drop(드랍 박스) ---------------------------------------------------------------------------------------- -->
		<div class="box-drop" style="display: none;">
			<!-- drop-filter -------------------------------------------------------------------------------------------- -->
			<div class="drop drop-filter">
				<!-- box-select -------------------------------------------------------- -->
				<div class="box-select d-flex flex-column">
					<!-- box-radio(강아지 선택) -------------------------------------------------------- -->
					<div class="box-radio">
						<div class="box-message">사진을 보고 싶은 강아지를 선택하세요.</div>
						<c:forEach items="${dList}" var="dog">
							<div class="form-check-inline">
								<label class="form-check-label">
									<input type="radio" class="form-check-input" name="dgNum" value="${dog.dg_num}">${dog.dg_name}
								</label>
							</div>
			 			</c:forEach>
					</div>
					<!-- box-year(년도 선택) -------------------------------------------------------- -->
					<div class="box-year">
						<div class="box-message mb-2">보고 싶은 년도를 선택하세요.</div>
						<div class="form-group mb-0" style="width: 100px;">
							<select class="form-control" name="regYear">
								<option>년도</option>
						  	<c:forEach items="${regYearList}" var="regYear">
						  		<option value="${regYear}">${regYear}</option>
						  	</c:forEach>
							</select>
						</div>
					</div>
				</div>
				<!-- box-btn(초기화, 설정) -------------------------------------------------------- -->
				<div class="box-btn">
					<button type="button" class="btn-reset">초기화</button>
					<button type="button" class="btn-set">설정</button>
				</div>
			</div>
		</div>
		<div class="box-drop" style="display: none;">
			<!-- drop-sort ---------------------------------------------------------------------------------------------- -->
			<div class="drop drop-sort">
				<!-- box-choose(정렬 방식 선택) -------------------------------------------------------- -->
				<div class="box-choose">
					<span class="sort sort-date sort-latest select" data-value="desc">최신순</span>
					<span class="sort sort-date sort-oldest" data-value="asc">오래된순</span>
					<span class="sort sort-popularity" data-value="1">인기순</span>
				</div>
			</div>
		</div>
	</div>
	<!-- box-content ------------------------------------------------------------------------------------------------ -->
	<div class="box-content">
		<ul class="log-list"></ul>
	</div>
</body>
<!-- script ******************************************************************************************************* -->
<script>
/* 변수 *********************************************************************************************************** */
	let page = 1;
	let mb_num = ${member.mb_num};
	let obj = {
		page,
		perPageNum : 12,
		mb_num,
		dg_num : 0,
		regYear : '',
		order : 'desc',
		popularity : 0
	};
/* 이벤트 *********************************************************************************************************** */		
	$(function(){
		//일지들 보여줌
		getLogList(obj);
		//필터 아이콘(btn-filter) 클릭------------------------------------------------------------------------------------------
		$('.main .box-nav .btn-filter').click(function(){
			$(this).parents('.box-set').siblings('.box-drop').eq(0).siblings('.box-drop').hide();
			$(this).parents('.box-set').siblings('.box-drop').eq(0).toggle();
			$(this).parent().siblings().children().removeClass('select');
			$(this).toggleClass('select');
		})
		
		//정렬 아이콘(btn-sort) 클릭-------------------------------------------------------------------------------------------
		$('.main .box-nav .btn-sort').click(function(){
			$(this).parents('.box-set').siblings('.box-drop').eq(1).siblings('.box-drop').hide();
			$(this).parents('.box-set').siblings('.box-drop').eq(1).toggle();
			$(this).parent().siblings().children().removeClass('select');
			$(this).toggleClass('select');
		})
		
		//스크롤이 브라우저 끝에 도달했을 때-----------------------------------------------------------------------------------------
		$(window).scroll(function(){
		  let scrollTop = $(window).scrollTop();
		  let innerHeight = $(window).innerHeight();
		  let scrollHeight = $('body').prop('scrollHeight');
		  if (scrollTop + innerHeight >= scrollHeight) {
				page++;
				obj.page = page;
				getLogList(obj);
      }
		})//
		
		//필터 설정(btn-set) 클릭 --------------------------------------------------------------------------------------------
		$('.main .box-drop .drop-filter .box-btn .btn-set').click(function(){
			let dg_num = $('.main .box-drop .drop-filter .box-radio [name=dgNum]:checked').val();
			let regYear = $('.main .box-drop .drop-filter .box-year [name=regYear]').val();
			//ul의 li 비우고
			$('.main .box-content .log-list .log-item').remove();
			//페이지 1로 초기화
			obj.page = 1;
			//강아지를 선택했으면 
			if(typeof(dg_num) != 'undefined')
				obj.dg_num = dg_num;
			//년도를 선택했으면
			if(regYear != '년도')
				obj.regYear = regYear;
			//리스트 불러오기
			getLogList(obj);
			//화면 재구성
			$(this).parents('.box-drop').hide();
			$('.main .box-nav .box-set .set .fa-solid').removeClass('select');
		})//
		
		//필터 초기화(btn-reset) 클릭 --------------------------------------------------------------------------------------------
		$('.main .box-drop .drop-filter .box-btn .btn-reset').click(function(){	
			//페이지 1로 초기화
			obj.page = 1;
			//라디오 박스 값 초기화
			$('.main .box-drop .drop-filter .box-radio [name=dgNum]').prop('checked', false);
			obj.dg_num = 0;
			//select 태그 초기화
			$('.main .box-drop .drop-filter .box-year [name=regYear]').val("년도").prop('selected', true);
			obj.regYear = '';
			//리스트 초기화
			$('.main .box-drop .drop-filter .box-btn .btn-set').click();
		})//
		
		//최신순, 오래된 순 클릭(sort-date) 클릭 --------------------------------------------------------------------------------------------
		$('.main .box-drop .drop-sort .box-choose .sort-date').click(function(){
			//obj 값 바꾸고
			let order = $(this).data('value');
			obj.order = order;
			obj.popularity = 0;
			//화면 재구성
			//ul의 li 비우고
			$('.main .box-content .log-list .log-item').remove();
			//리스트 불러오기
			getLogList(obj);
			//선택한 값 색 바꾸기
			$('.main .box-drop .drop-sort .box-choose .sort').removeClass('select');
			$(this).addClass('select');
		})//
		
		//인기순 클릭(sort-popularity) 클릭 --------------------------------------------------------------------------------------------
		$('.main .box-drop .drop-sort .box-choose .sort-popularity').click(function(){
			//obj 값 바꾸고
			let popularity = $(this).data('value');
			obj.order = 'desc';
			obj.popularity = popularity;	
			//화면 재구성
			//ul의 li 비우고
			$('.main .box-content .log-list .log-item').remove();
			//리스트 불러오기
			getLogList(obj);
			//선택한 값 색 바꾸기
			$('.main .box-drop .drop-sort .box-choose .sort').removeClass('select');
			$(this).addClass('select');
		})//
		
		//사진 클릭했을 때 -----------------------------------------------------------------------------------------
		$(document).on('click', '.main .box-content .log-list .log-link', function(e){
			let lg_num = $(this).parent().data('lgnum');
			let obj = {lg_num}
			//조회수 증가
			//볼 수 없는 일지를 선택한 경우 조회수 증가 안하고
			if(!countViews(obj)){
				alert('볼 수 없는 일지입니다.');
				e.preventDefault();
				location.href = '<%=request.getContextPath()%>/log/friendLog/'+mb_num;
				return;
			}
		})//
	})//

/* 함수 *********************************************************************************************************** */
	// getLogList -----------------------------------------------------------------------------------------------------
	function getLogList(obj){
		ajaxPost(false, obj, '/get/logList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			for(log of data.lList){
				let criUrl = makeCriUrl(log.lg_num, obj);
				html += '<li class="log-item" data-lgNum="'+log.lg_num+'">';
				html +=		'<a href="'+contextPath+'/log/friendlogDetail/'+mb_num+criUrl+'" class="log-link"'; 
				html +=			'style="background-image: url('+contextPath+'/log/img'+log.lg_image+')"></a>';
				html += '</li>';
			}
			$('.main .box-content .log-list').append(html);
		});
	}//
	
	// makeCriUrl -----------------------------------------------------------------------------------------------------
	function makeCriUrl(lg_num, obj){
		let lgNumUrl = '?lg_num=' + lg_num;
		let pageUrl = lgNumUrl +'&page=' + obj.page;
		let mbNumUrl = pageUrl + '&mb_num=' +  obj.mb_num;
		let dgNumUrl = mbNumUrl + '&dg_num=' +  obj.dg_num;
		let regYearUrl = dgNumUrl + '&regYear=' +  obj.regYear;
		let orderUrl = regYearUrl + '&order=' +  obj.order;
		let popularityUrl = orderUrl  + '&popularity=' +  obj.popularity;
		return popularityUrl;
	}//
	
	// countViews -----------------------------------------------------------------------------------------------------
	function countViews(obj){
		let res = true;
		ajaxPost(false, obj, '/count/views', function(data){
			res = data.res;
		});
		return res;
	}//
</script> 
</html>