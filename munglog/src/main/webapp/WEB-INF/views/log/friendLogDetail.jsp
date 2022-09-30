<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-나의일지</title>
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
	/* main box-content --------------------------------------------------------------------- */
	.main .box-content{margin: 30px 44px;}
	.main .box-content .swiper{width:100%;}
	.main .box-content .swiper .swiper-slide {width:100%;}
	/* main box-nav --------------------------------------------------------------------- */
	.main .box-content .swiper-slide .box-nav{position: relative;}
	.main .box-content .swiper-slide .box-nav .list-nav{text-align: center;}
	.main .box-content .swiper-slide .box-nav .item-nav{font-weight: bold;}
	{color: #fb9600;}
	.main .box-content .swiper-slide .box-nav .box-heart .btn-heart:hover,
	.main .box-content .swiper-slide .item-nav .auto-start:hover,
	.main .box-content .swiper-slide .item-nav .auto-stop:hover,
	.main .box-content .swiper-slide .box-nav .item-nav .box-set .fa-solid:hover{color: #ff9e54; cursor:pointer;}
	.main .box-content .swiper-slide .box-nav .box-heart .btn-heart.select,
	.main .box-content .swiper-slide .item-nav .auto-start.select,
	.main .box-content .swiper-slide .item-nav .auto-stop.select{color: #fb9600;}
	.main .box-content .swiper-slide .box-nav .item-nav .box-set .fa-solid{line-height : 24px;}
	/* main box-img --------------------------------------------------------------------- */
	.main .box-content .swiper .swiper-slide .box-img{
		width:100%; height: 500px; margin-top: 30px; position: relative;
		display: flex; flex-direction: row; align-items: center;
	}
	.main .box-content .swiper .swiper-slide .lg_image{
		max-width: 50%; max-height: 500px; object-fit: cover; display: block; margin: auto;
	}
	.main .box-content .swiper .swiper-button-next,
	.main .box-content .swiper .swiper-button-prev{
		position: absolute; color: #a04c00; top: 50%; z-index: 8;
	}
	.main .box-content .friendLog{
		float: right; font-weight: bold; margin-right: 37px;
	}
	.main .box-content .friendLog:hover{color: #fb9600;}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<!-- 제목 -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>${member.mb_nickname} 일지 상세보기</span>
		<div class="box-message">${member.mb_nickname}님의 사진을 보고 좋아요를 눌러주세요. 슬라이드쇼도 볼 수 있습니다.</div>
	</div>
	<!-- box-content ------------------------------------------------------------------------------------------------- -->
	<div class="box-content">
		<div class="wrapper">
			<div class="swiper">
				<div class="swiper-wrapper">	
					<!-- swiper-slide ---------------------------------------------------------------------------------------- -->
					<c:forEach items="${logList}" var="log">
						<div class="swiper-slide">
							<!-- box-nav -------------------------------------------------------------------------------------------- -->
							<div class="box-nav">
								<ul class="list-nav list-group list-group-horizontal" data-lgmbnum="${log.lg_mb_num}" data-lgnum="${log.lg_num}">
									<!-- 등록일 ------------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<span class="lg_reg_date">${log.lg_reg_date_time}</span> 
									</li>
									<!-- 조회수 ------------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<i class="fa-regular fa-eye mr-3"></i><span class="lg_views">${log.lg_views}</span>
									</li>
									<!-- 하트수 ------------------------------------------------------------------------------------- -->
									<li class="box-heart item-nav list-group-item border-0 flex-fill">
										<i class="btn-heart fa-solid fa-heart mr-3"></i><span class="heart">${log.lg_heart}</span>
									</li>
									<!-- 슬라이드쇼 ----------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<div class="box-slide">
											<i class="auto-start fa-solid fa-circle-play mr-4"></i>
											<i class="auto-stop select fa-solid fa-stop"></i>
										</div>
									</li>
									<!-- 신고 ------------------------------------------------------------------------------------------ -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<div class="box-set">
											<i class="fa-solid fa-land-mine-on"></i>
										</div>
									</li>
								</ul>
							</div>
							<!-- box-img ------------------------------------------------------------------------------------------- -->
							<div class="box-img">
								<img class="lg_image" src="<c:url value="${log.lg_image_url}"></c:url>">
								<div class="btn-swiper swiper-button-next"></div>
								<div class="btn-swiper swiper-button-prev"></div>
							</div>
							<a class="friendLog" href="<c:url value="/log/friendlog/${member.mb_num}"></c:url>">${member.mb_nickname}님 일지로 돌아가기</a>							
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- script ******************************************************************************************************* -->
<script>
	/* 변수 *********************************************************************************************************** */
		let slideIndex = '${index}';
		let userMbNum = '${user.mb_num}';
	/* 이벤트 *********************************************************************************************************** */
		$(function(){	
			$(document).ready(function(){
				let ul = $('.main .box-nav .list-nav');
				let size = ul.length;
				for(let i = 0; i < size; i++){
					let lg_num = ul.eq(i).data('lgnum');
					//하트 화면 구성 --------------------------------------------------------------------------------------------------
					let obj = {
						ht_lg_num : lg_num,
						ht_mb_num : userMbNum
					}
					getHeart(obj, i);
				}
			})//
			
			//하트 버튼 클릭(btn-heart) 클릭-----------------------------------------------------------------------------------------
			$(document).on('click', '.main .box-content .box-heart .btn-heart', function(){
				//로그인 안했으면 로그인 화면으로
				if(userMbNum == ''){
					if(confirm('하트를 누르려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
						location.href = '<%=request.getContextPath()%>/account/login';
					return;
				}
				//일지를 쓴 회원이랑 하트를 누른 회원이 같으면
				let lg_mb_num = $(this).parents('.list-nav').data('lgmbnum');
				if(lg_mb_num == userMbNum){
					return;					
				}
				//일지 번호 가져오기
				let lg_num = $(this).parents('.list-nav').data('lgnum');
				let obj = {
					ht_lg_num : lg_num,
					ht_mb_num : userMbNum				
				}
				//아이콘 색깔 수정
				clickHeart(obj, this);
				//하트 개수 수정
				obj = {lg_num}
				getTotalHeart(obj, this);
			})//
			
			//이미지 영역 클릭(box-img) 클릭-----------------------------------------------------------------------------------------
			$('.main .box-content .box-img').click(function(){
				$('.auto-stop').click();
			})//	
			
			//swiper----------------------------------------------------------------------------------------------------------
			const swiper = new Swiper('.swiper', {
				slidesPerView: 1,
				speed: 400, 
				Loop : false,
				centeredSlides: true, //사진 가운데
				preventClicks: true,
				initialSlide : slideIndex,
				//사진 1개면 버튼 숨김
				watchOverflow : true,
				// 좌우 화살표 요소 지정
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				on: {
					init: function () {
						$('.main .box-content .swiper .swiper-slide').addClass('changed');
					},
					slideChangeTransitionStart: function() {
						$('.main .box-content .swiper .swiper-slide').addClass('changing');
						$('.main .box-content .swiper .swiper-slide').removeClass('changed');
					},
					slideChangeTransitionEnd: function() {
						$('.main .box-content .swiper .swiper-slide').removeClass('changing');
						$('.main .box-content .swiper .swiper-slide').addClass('changed');
					},
          activeIndexChange: function () {
	          slideIndex = this.realIndex; //현재 슬라이드 index 갱신
          },
          slideChange : function() {
        	  $('.main .box-content .swiper .box-drop').hide();
        	  $('.main .box-content .box-nav .btn-modify').removeClass('select');
						//조회수 증가
						let lg_num = $('.main .swiper-slide-active .box-nav .list-nav').data('lgnum');
						let obj = {lg_num}
						countViews(obj)
          }
	      }
			});//
			
			//슬라이드쇼 시작
			$('.auto-start').on('click', function() {
				$('.auto-stop').removeClass('select');
				$('.auto-start').addClass('select');
				swiper.autoplay.start();
			});//
			
			//슬라이드쇼 정지
			$('.auto-stop').on('click', function() {
				$('.auto-start').removeClass('select');
				$('.auto-stop').addClass('select');
	      swiper.autoplay.stop();
			});//
		})//

/* 함수 *********************************************************************************************************** */
		// clickHeart : 하트 누르기 -----------------------------------------------------------------------------------
	function clickHeart(obj,selector){
		ajaxPost(false, obj, '/click/heart', function(data){
			console.log(data.res)
			//하트 상태에 따라 하트 색깔 다르게
    	if(data.res == 1)
    		$(selector).addClass('select')
    	else if(data.res == 0)
    		$(selector).removeClass('select');
    	else if(data.res == -1)
    		alert('로그인하거나 다시 시도해주세요.')
		});
	}//
	
	// getHeart : 하트 정보 가져오기 -----------------------------------------------------------------------------------
	function getHeart(obj, index){
		ajaxPost(false, obj, '/get/heart', function(data){
			//없거나 상태가 0이면
			if(data.heart == null || (data.heart != null && data.heart.ht_state == '0'))
				$('.main .box-nav .list-nav').eq(index).find('.btn-heart').removeClass('select');	
			//해당 일지에 좋아요 눌렀으면
			if(data.heart != null && data.heart.ht_state == '1')
				$('.main .box-nav .list-nav').eq(index).find('.btn-heart').addClass('select');
		});
	}//
	
	// getTotalHeart : 하트개수 가져오기 -----------------------------------------------------------------------------------
	function getTotalHeart(obj, selector){
		ajaxPost(false, obj, '/get/totalHeart', function(data){
			$(selector).next().text('');
			if(data.log == null)
				$(selector).next().text('0');
			else
				$(selector).next().text(data.log.lg_heart)
		});
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