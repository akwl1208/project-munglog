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
	.main .box-content .swiper-slide .item-nav .auto-start:hover,
	.main .box-content .swiper-slide .item-nav .auto-stop:hover,
	.main .box-content .swiper-slide .item-nav .btn-modify:hover,
	.main .box-content .swiper-slide .item-nav .btn-delete:hover{color: #ffa31c;}
		.main .box-content .swiper-slide .item-nav .btn-modify.select,
	.main .box-content .swiper-slide .item-nav .auto-start.select,
	.main .box-content .swiper-slide .item-nav .auto-stop.select{color: #fb9600;}
	/* main box-nav box-drop --------------------------------------------------------------------- */
	.main .box-nav .box-drop{
		padding: 20px 40px; z-index: 10;
		position: absolute; top: 40px; left: 0; right: 0; background-color: white;
		width: 100%; border-bottom: 3px solid rgba(73, 67, 60, 0.1);
	}
	.main .box-content .box-drop .box-send .box-message,
	.main .box-content .box-drop .box-check .box-message{margin: 5px 0;}
	.main .box-content .box-drop .box-file .btn-file,
	.main .box-content .box-drop .box-send .btn-send{
		padding: 5px 10px; background-color: #a04c00; margin-left: 10px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
		border-radius: 3px;
	}
	.main .box-content .box-drop .box-send{margin-top: 20px;}
	.main .box-content .box-drop .box-send .box-preview{margin: 0 auto;}
	/* main box-img --------------------------------------------------------------------- */
	.main .box-content .swiper .swiper-slide .box-img{
		width:100%; height: 500px; margin-top: 50px; position: relative;
		display: flex; flex-direction: row; align-items: center;
	}
	.main .box-content .swiper .swiper-slide .lg_image{
		width: 50%; object-fit: cover; display: block; margin: auto;
	}
	.main .box-content .swiper .swiper-button-next,
	.main .box-content .swiper .swiper-button-prev{
		position: absolute; color: #a04c00; top: 50%;
	}
	.main .box-content .swiper .swiper-button-next,
	.main .box-content .swiper .swiper-button-prev{
		position: absolute; color: #a04c00; top: 50%;
	}
	.main .box-content .mylog{
		float: right; font-weight: bold; color: #fb9600;
		margin-top: 50px;
	}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<!-- 제목 -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>일지 상세보기</span>
		<div class="box-message">사진의 상세 정보를 확인하고 관리하세요. 슬라이드쇼도 볼 수 있습니다.</div>
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
									<!-- 등록일 ------------------------------------------------------------------------------------------- -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<span class="lg_reg_date">${log.lg_reg_date_time}</span> 
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
									<!-- 수정/삭제 ------------------------------------------------------------------------------------------ -->
									<li class="item-nav list-group-item border-0 flex-fill">
										<div class="box-set">
											<i class="btn-modify fa-solid fa-camera-rotate mr-4" data-value="${log.lg_num}"></i>
											<i class="btn-delete fa-solid fa-trash-can"></i>
										</div>
									</li>
								</ul>
								<!-- box-drop ------------------------------------------------------------------------------------------ -->
								<div class="box-drop" style="display: none;">
									<div class="box-select d-flex flex-column">
										<!-- box-check(강아지 체크박스) ------------------------------------------------------------------------------------ -->
										<div class="box-check">
											<div class="box-message">사진 속 강아지를 선택하세요.</div>
											<c:forEach items="${dogList}" var="dog">
												<div class="form-check-inline">
													<label class="form-check-label">
														<input type="checkbox" class="form-check-input" name="dg_num" value="${dog.dg_num}">${dog.dg_name}
													</label>
												</div>
								 			</c:forEach>
										</div>
										<!-- box-file(파일 선택) ------------------------------------------------------------------------------- -->
										<div class="box-file ml-auto" style="display: none;">
											<input type="file" name="file" style="display: none;">
											<button type="button" class="btn-file">사진 선택</button>
										</div>
									</div>
										<!-- box-content ------------------------------------------------------------------------------------------------- -->
									<div class="box-send">
										<div class="box-message">사진을 클릭하면 수정할 수 있습니다.</div>
										<div class="d-flex align-items-end justify-content-between">
											<div class="box-preview">
												<img class="preview" style="max-width: 300px; max-height: 300px;" src="<c:url value="${log.lg_image_url}"></c:url>">
											</div>
											<button type="button" class="btn-send">사진 수정</button>
										</div>
									</div>
								</div>
							</div>
							<div class="box-img">
								<img class="lg_image" src="<c:url value="${log.lg_image_url}"></c:url>">
								<div class="btn-swiper swiper-button-next"></div>
								<div class="btn-swiper swiper-button-prev"></div>
							</div>							
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<a class="mylog" href="#">나의 일지로 돌아가기</a>
	</div>
</body>
<!-- script ******************************************************************************************************* -->
<script>
	/* 변수 *********************************************************************************************************** */
		let slideIndex = 2;
	/* 이벤트 *********************************************************************************************************** */
		$(function(){
			// 수정 버튼 클릭(btn-modify)---------------------------------------------------------------------------------------
			$('.btn-modify').click(function(){
				$(this).toggleClass('select');
				//사진의 lg_num 가져옴
				let lg_num = $(this).data('value');
				if(typeof(lg_num) == 'undefined')
					return;
				let obj = {
					lg_num
				}
				//일지의 피사체들(강아지) 가져옴
				ajaxPost(false, obj, '/get/subjectList', function(data){
					for(subject of data.subjectList){
						let sb_dg_num = subject.sb_dg_num;
						$('.main .box-drop .box-check [name=dg_num]').each(function(){
							//강아지 번호 추출
							let dg_num = $(this).val();
							//sb_dg_num과 같으면 체크
							if(dg_num == sb_dg_num){
								$(this).prop('checked', true);
							}
						})
					}
				});
				$('.box-drop').toggle();	
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
	     	  	console.log(slideIndex)
	     	  	console.log('------------------------')
	          slideIndex = this.realIndex; //현재 슬라이드 index 갱신
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
	//  ------------------------------------------------------------------------------------------------
</script> 
</html>