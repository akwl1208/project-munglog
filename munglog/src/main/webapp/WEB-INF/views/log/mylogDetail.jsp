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
	.main .box-content .swiper-slide .item-nav .btn-delete:hover{color: #ff9e54; cursor:pointer;}
	.main .box-content .swiper-slide .item-nav .btn-modify.select,
	.main .box-content .swiper-slide .item-nav .auto-start.select,
	.main .box-content .swiper-slide .item-nav .auto-stop.select{color: #fb9600;}
	.main .box-content .swiper-slide .box-nav .item-nav .box-set .btn-modify{line-height : 24px;}
	/* main box-nav box-drop --------------------------------------------------------------------- */
	.main .box-nav .box-drop{
		padding: 20px 40px; z-index: 10;
		position: absolute; top: 40px; left: 0; right: 0; background-color: white;
		width: 100%; border-bottom: 3px solid rgba(73, 67, 60, 0.1);
	}
	.main .box-content .box-drop .box-send .box-message,
	.main .box-content .box-drop .box-check .box-message{margin: 5px 0;}
	.main .box-content .box-drop .box-send .btn-send{
		padding: 5px 10px; background-color: #a04c00; margin-left: 10px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
		border-radius: 3px;
	}
	.main .box-content .box-drop .box-send{margin-top: 20px;}
	.main .box-content .box-drop .box-send .box-preview{margin: 0 auto;}
	.main .box-content .box-drop .box-send .box-preview:hover{cursor:pointer}
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
	.main .box-content .mylog{
		float: right; font-weight: bold; margin-right: 37px;
	}
	.main .box-content .mylog:hover{color: #fb9600;}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<!-- 제목 -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>나의 일지 상세보기</span>
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
								<ul class="list-nav list-group list-group-horizontal" data-value="${log.pt_cl_num}">
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
										<i class="fa-solid fa-heart mr-3"></i><span class="heart">${log.lg_heart}</span>
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
											<c:if test="${log.pt_cl_num == 0}">
												<i class="btn-delete fa-solid fa-trash-can" data-value="${log.lg_num}"></i>										
											</c:if>
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
										<!-- file(파일 선택) ------------------------------------------------------------------------------- -->
										<input type="file" name="file" accept="image/jpg, image/jpeg, image/png, image/gif" style="display: none;">
									</div>
									<!-- box-send -------------------------------------------------------------------------------------- -->
									<div class="box-send">
										<div class="box-message">사진을 클릭하면 수정할 수 있습니다.</div>
										<div class="d-flex align-items-end justify-content-between">
											<div class="box-preview">
												<img class="preview" style="max-width: 300px; max-height: 300px;" src="<c:url value="${log.lg_image_url}"></c:url>">
											</div>
											<button type="button" class="btn-send" data-value="${log.lg_num}">사진 수정</button>
										</div>
									</div>
								</div>
							</div>
							<!-- box-img ------------------------------------------------------------------------------------------- -->
							<div class="box-img">
								<img class="lg_image" src="<c:url value="${log.lg_image_url}"></c:url>">
								<div class="btn-swiper swiper-button-next"></div>
								<div class="btn-swiper swiper-button-prev"></div>
							</div>
							<a class="mylog" href="<c:url value="/log/mylog/${user.mb_num}"></c:url>">나의 일지로 돌아가기</a>							
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
	let deleteDList = [];
	let cl_num = '${challenge.cl_num}'; //현재 진행중인 챌린지
/* 이벤트 *********************************************************************************************************** */
	$(function(){
		// 수정 버튼 클릭(btn-modify)---------------------------------------------------------------------------------------
		$('.main .box-content .box-nav .btn-modify').click(function(){
			let pt_cl_num =$('.main .swiper-slide-active .list-nav').data('value');
			//지난 챌린지면 수정 못함
			if(pt_cl_num != 0 && pt_cl_num != cl_num){
				alert('지난 챌린지에 참여한 사진은 수정하지 못합니다.')	;
				return;
			}
			//체크박스 체크 해제
			$('.main .swiper-slide-active .box-drop [name=dg_num]').prop('checked', false);
			//사진의 lg_num 가져옴
			let lg_num = $(this).data('value');
			//사진의 피사체에 체크
			//챌린지에 참여했으면 체크 못하게 막기
			if(pt_cl_num == 0)
				getSubjectList(lg_num);
			else{
				$('.main .swiper-slide-active .box-drop [name=dg_num]').prop('disabled', true);
				$('.main .swiper-slide-active .box-drop .box-select .box-check .box-message').text('챌린지에 참여한 일지는 강아지를 선택할 수 없습니다.');	
			}
			//만약 수정 시 삭제할 피사체 담기
			deleteDList = pushDgNum();
			//사진 초기화
			previewInit();
			//화면 재구성
			$(this).toggleClass('select');
			$('.main .box-content .swiper-slide-active .box-drop').toggle();	
		})//
		
		//사진 선택했으면(input:file)------------------------------------------------------------------------------------------
		$('.main .box-drop .box-select [name=file]').on('change', function(event) {
			//파일을 안했으면 유지
			if(event.target.files.length == 0){
				previewInit();
				return;		
			}
		  let file = event.target.files[0];
		  let reader = new FileReader();
		  //선택한 파일 미리보기에 넣기
		  reader.onload = function(e) {
		  	$('.main .swiper-slide-active .box-drop .box-send .preview').attr('src', e.target.result);
		  }
		  reader.readAsDataURL(file);
		})//
	
		//미리보기 사진(box-preview) 클릭---------------------------------------------------------------------------------------
		$('.main .box-drop .box-send .box-preview').click(function(){
			$('.main .swiper-slide-active .box-drop .box-select [name=file]').click();
		})//
		
		//사진 수정 버튼(btn-send) 클릭-----------------------------------------------------------------------------------------
		$('.main .box-drop .box-send .btn-send').click(function(){
			//수정할건지 묻기
			if(!confirm('사진을 수정하겠습니까?'))
				return;
			//수정할 강아지 번호 저장
			let modifyDList = pushDgNum();
			//사진의 lg_num 가져옴
			let lg_num = $(this).data('value');
			//파일 가져옴
			let file = $('.main .swiper-slide-active .box-drop .box-select [name=file]')[0].files[0];
			//강아지 체크도 바꾸지 않고 파일도 안바꿨으면 
			if((JSON.stringify(deleteDList) === JSON.stringify(modifyDList)) && typeof(file) == 'undefined'){
				alert('사진 속 강아지나 사진을 변경해주세요.');					
				return;
			}
			//강아지 정보와 사진 정보 서버로 보내기
			let data = new FormData();
			data.append('file', file);
			data.append('d_dg_nums[]', deleteDList);
			data.append('m_dg_nums[]', modifyDList);
			data.append('lg_num', lg_num);
			$.ajax({
				async: false,
				type:'POST',
				data: data,
				url: "<%=request.getContextPath()%>/modify/log",
					processData : false,
					contentType : false,
					dataType: "json",
					success : function(data){
						//이미지 파일이 아닐 때
						if(data.res == 0){
							alert('이미지 파일만 등록가능 합니다.');
							//화면 재구성
							previewInit();
							$('.main .swiper-slide-active .box-drop .box-select [name=file]').click();
						}
						//성공했을 때
						else if(data.res == 1){
							alert('사진을 수정했습니다.');
							//화면 새로고침
							location.reload();		
						}
						//실패했을 때
						else if(data.res == -1){
							alert('일지 수정에 실팼습니다. 다시 시도해주세요.');
							//체크박스 체크 해제
							$('.main .swiper-slide-active .box-drop [name=dg_num]').prop('checked', false);
							//사진의 lg_num 가져옴
							let lg_num = $(this).data('value');
							//사진의 피사체에 체크
							getSubjectList(lg_num);
							//화면 재구성
							previewInit();
						}
						//지난 챌린지를 수정하려고 하는 경우
						else if(data.res == 3){
							alert('지난 챌린지에 참여한 일지는 수정할 수 없습니다.');
							previewInit();
						}
					}
				});
			})//
			
			//이미지 영역 클릭(box-img) 클릭-----------------------------------------------------------------------------------------
			$('.main .box-content .box-img').click(function(){
				$('.auto-stop').click();
			})//	
			
			//삭제 버튼(btn-delete) 클릭-----------------------------------------------------------------------------------------
			$('.main .box-content .box-nav .btn-delete').click(function(){
				if(!confirm('사진을 삭제하겠습니까?'))
					return;
				let lg_num = $(this).data('value');
				if(typeof(lg_num) == 'undefined' || lg_num < 1)
					return;				
				let obj = {
					lg_num
				}
				//일지 삭제
				ajaxPost(false, obj, '/delete/log', function(data){
					if(data.res == 0)
						alert('챌린지에 참여한 일지는 삭제할 수 없습니다.')
					else if(data.res == 1){
						alert('일지를 삭제했습니다.')
						//화면 새로고침
						location.reload();
					}
					else
						alert('일지 삭제에 실패했습니다. 다시 시도해주세요.')
				});
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
	// getSubjectList ------------------------------------------------------------------------------------------------
	function getSubjectList(lg_num){
		if(typeof(lg_num) == 'undefined' || lg_num < 1)
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
					if(dg_num == sb_dg_num)
						$(this).prop('checked', true);
				})
			}
		});
	}//
	
	// pushDgNum ------------------------------------------------------------------------------------------------
	function pushDgNum(){
		let dList = [];
		//선택한 강아지 list에 담기
		$('.main .swiper-slide-active .box-drop .box-select [name=dg_num]:checked').each(function(){
			//강아지 번호 추출
			let dg_num = $(this).val();
			//강아지 리스트에 담기
    	dList.push(dg_num);
		})
		return dList;
	}//
	
	function previewInit(){
		$('.main .swiper-slide-active .box-drop .box-select [name=file]').val('');
		let url = $('.main .swiper-slide-active .box-img .lg_image').attr('src');
		$('.main .swiper-slide-active .box-drop .box-send .preview').attr('src', url);
	}
</script> 
</html>