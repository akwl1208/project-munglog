<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-피드 상세보기</title>
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
	.main .box-content .swiper-slide .box-nav .box-profile .thumb{
		border-radius: 50px; width: 25px; height: 25px; vertical-align: middle; margin-top: -4px;
	}
	.main .box-content .swiper-slide .box-nav .box-profile .nickname{
		max-width: 100px;'overflow: hidden; text-overflow: ellipsis; 
	}
	.main .box-content .swiper-slide .item-nav .auto-start:hover,
	.main .box-content .swiper-slide .item-nav .auto-stop:hover{color: #ffa31c; cursor:pointer;}
	.main .box-content .swiper-slide .item-nav .auto-start.select,
	.main .box-content .swiper-slide .item-nav .auto-stop.select{color: #fb9600;}
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
	.main .box-content .feed{
		float: right; font-weight: bold; margin-right: 37px;
	}
	.main .box-content .feed:hover{color: #fb9600;}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<!-- 제목 -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>멍멍피드 상세보기</span>
		<div class="box-message">멍멍친구의 사진을 보고 좋아요를 눌러주세요. 슬라이드쇼도 볼 수 있습니다.</div>
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
								<ul class="list-nav list-group list-group-horizontal">
									<!-- 프로필 ------------------------------------------------------------------------------------------- -->
									<li class="box-profile item-nav list-group-item border-0 flex-fill" data-lgmbnum="${log.lg_mb_num}" data-lgnum="${log.lg_num}">
									</li>
									<!-- 등록일 ------------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<span class="lg_reg_date">${log.lg_reg_date_str}</span> 
									</li>
									<!-- 조회수 ------------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<i class="fa-regular fa-eye mr-3"></i><span class="lg_views">${log.lg_views}</span>
									</li>
									<!-- 하트수 ------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<i class="fa-regular fa-face-grin-hearts mr-3"></i><span class="heart">0</span>
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
							<div class="box-img">
								<img class="lg_image" src="<c:url value="${log.lg_image_url}"></c:url>">
								<div class="btn-swiper swiper-button-next"></div>
								<div class="btn-swiper swiper-button-prev"></div>
							</div>
							<a class="feed" href="<c:url value="/log/feed"></c:url>">멍멍 피드로 돌아가기</a>						
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
		let lg_num = 0;
	/* 이벤트 *********************************************************************************************************** */
		$(function(){
			$(document).ready(function(){
				//프로필 화면 구성 --------------------------------------------------------------------------------------------------
				let li = $('.main .box-nav .list-nav .box-profile');
				let size = li.length;
				for(let i = 0; i < size; i++){
					let lg_num = li.eq(i).data('lgnum');
					let lg_mb_num = li.eq(i).data('lgmbnum');
					let obj = {lg_mb_num};
					getProfile(obj, i, lg_num);
				}
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
	// getProfile : 프로필 정보 가져오기 ------------------------------------------------------------------------------------------------
	function getProfile(obj, index, lg_num){
		ajaxPost(false, obj, '/get/profile', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			let profile = data.profile;
			let user = '${user}';
			//회원인 경우 회원 번호 추출
			let find = 'mb_num=';
			let startIndex = user.indexOf(find);
			let userMbNum = 0;
			if(startIndex != -1){
				startIndex = startIndex + find.length; 
				let endIndex = user.indexOf(',');
				userMbNum = user.substring(startIndex, endIndex);
			}
			//화면 구성
			if(user != '' && (obj.lg_mb_num == userMbNum))
				html += '<a href="'+contextPath+'/log/mylogDetail/'+obj.lg_mb_num+'?lg_num='+lg_num+'">';
			if(user == '' || (obj.lg_mb_num != userMbNum))
				html += '<a href="'+contextPath+'/log/friendlogDetail/'+obj.lg_mb_num+'?lg_num='+lg_num+'">';
			html += 	'<span class="mr-2"><img src="'+contextPath+profile.mb_profile_url+'" class="thumb"></span>';
			html += 	'<span class="nickname">'+profile.mb_nickname+'</span>';
			html += '</a>';
			$('.main .box-nav .list-nav .box-profile').eq(index).append(html);	
			
		});
	}
</script> 
</html>