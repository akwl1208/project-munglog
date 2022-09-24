<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-멍멍피드</title>
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
	.main .box-drop .drop-sort .box-choose{text-align: right;}
	.main .box-drop .drop-sort .box-choose .sort{
		display: inline-block; cursor: pointer;
	}
	.main .box-drop .drop-sort .box-choose .sort.select{color:#fb9600; font-weight: bold;}
	.main .box-drop .drop-sort .box-choose .sort-popularity::before{
		display: inline-block; content: ''; margin: 0 10px;
		width: 1px; height: 12px; background-color: #b9ab9a;
		line-height: 24px;
	}
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
		<i class="fa-solid fa-paw"></i><span>멍멍 피드</span>
		<div class="box-message">귀여운 멍멍친구들의 일지를 즐기세요. </div>
	</div>
	<!-- box-nav(메뉴) ----------------------------------------------------------------------------------------------- -->
	<div class="box-nav">
		<!-- box-set(아이콘 버튼들) --------------------------------------------------------------------------------------- -->
		<div class="box-set d-flex justify-content-end">
			<div class="set box-sort p-2"><i class="btn-sort fa-solid fa-arrow-down-short-wide"></i></div>
		</div>
		<!-- box-drop(드랍 박스) ---------------------------------------------------------------------------------------- -->
		<div class="box-drop" style="display: none;">
			<!-- drop-sort ---------------------------------------------------------------------------------------------- -->
			<div class="drop drop-sort">
				<!-- box-choose(정렬 방식 선택) -------------------------------------------------------- -->
				<div class="box-choose">
					<div class="sort sort-lastest select">최신순</div>
					<div class="sort sort-popularity">인기순</div>
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
	let obj = {
		page,
		perPageNum : 12,
		mb_num : 0,
		dg_num : 0,
		regYear : ''
	};
	$(function(){
		//일지들 보여줌
		getLogList(obj);
	/* 이벤트 *********************************************************************************************************** */	
		//정렬 아이콘(btn-sort) 클릭-------------------------------------------------------------------------------------------
		$('.main .box-nav .btn-sort').click(function(){
			$('.main .box-nav .box-drop').toggle();
			$('.main .box-nav .drop').hide();
			$('.main .box-nav .drop-sort').show();
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
	})
/* 함수 *********************************************************************************************************** */
	// getLogList -----------------------------------------------------------------------------------------------------
	function getLogList(obj){
		ajaxPost(false, obj, '/get/logList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			for(log of data.lList){
				html += '<li class="log-item" data-lgNum="'+log.lg_num+'" data-mbNum="'+log.lg_mb_num+'">';
				html +=		'<a href="#" class="log-link"'; 
				html +=			'style="background-image: url('+contextPath+'/log/img'+log.lg_image+')"></a>';
				html += '</li>';
			}
			$('.main .box-content .log-list').append(html);
		});
	}//
</script> 
</html>