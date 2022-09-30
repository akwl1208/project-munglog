<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-챌린지</title>
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
	.main .box-nav{
		position: relative; font-size: 18px;
	}
	.main .box-nav .box-upload{text-align: right;}
	.main .box-nav .box-upload .btn-upload:hover{color:#fb9600;}
	.main .box-nav .box-upload .btn-upload.select{color:#fb9600;}
	.main .box-nav .box-drop{
		position: absolute; top: 43px; left: 0; right: 0; background-color: white;
		width: 100%; border-bottom: 3px solid rgba(73, 67, 60, 0.1);
		padding: 20px 40px; z-index: 10;
	}
	.main .box-drop .box-participate .box-preview{margin: 0 auto; cursor: pointer;}
	.main .box-drop .box-participate .box-preview .preview{max-height: 300px; max-width: 300px;}
	.main .box-drop .box-participate .btn-participate{
		padding: 5px 10px; background-color: #a04c00; margin-left: 10px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
		border-radius: 3px;
	}
	.main .box-drop .box-participate .btn-participate:hover{background-color: #b86000;}
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
	.main .box-content .log-list .log-item .log-link:hover{transform: scale(0.8);}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<!-- box-title(제목) --------------------------------------------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>멍멍 챌린지</span>
		<div class="box-message">주제에 맞는 사진을 올리고 포인트 받아가세요.</div>
	</div>
	<!-- box-nav(메뉴) ----------------------------------------------------------------------------------------------- -->
	<div class="box-nav">
		<!-- box-upload(아이콘 버튼들) --------------------------------------------------------------------------------------- -->
		<div class="box-upload p-2">
			<i class="btn-upload fa-solid fa-camera mr-3"></i>
		</div>
		<!-- box-drop -------------------------------------------------------- -->
		<div class="box-drop" style="display: none;">
			<div class="box-participate d-flex align-items-end justify-content-between">
				<input type="file" name="file" accept="image/jpg, image/jpeg, image/png, image/gif" style="display: none;">
				<div class="box-preview">
					<img class="preview">
				</div>
				<button type="button" class="btn-participate">챌린지 참여</button>
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
	let user = '${user}';
	let cl_num = ${challenge.cl_num}
	let page = 1;
	let obj = {
		page,
		perPageNum : 12,
		cl_num
	};
	const now = new Date();
	const thisYear = now.getFullYear();
	const thisMonth = now.getMonth()+1;
/* 이벤트 *********************************************************************************************************** */		
	$(function(){
		$(document).ready(function(){
			getLogList(obj);
		})//
		
		//카메라 아이콘(btn-upload) 클릭 ------------------------------------------------------------------------------------
		$('.main .box-nav .box-upload .btn-upload').click(function(){
			//진행 중인 챌린지만 참여 가능
			let clYear = ${challenge.cl_year};
			let clMonth = ${challenge.cl_month};
			if(clYear != thisYear || clMonth != thisMonth){
				alert('현재 진행 중인 챌린지에만 참여할 수 있습니다.')
				return;
			}
			//로그인한 회원만 참여 가능
			if(user == ''){
				if(confirm('챌린지를 참여하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?')){
					location.href = '<%=request.getContextPath()%>/account/login';
				}
				return;
			}
			$('.main .box-drop .box-preview').hide();
			//드롭박스를 열면 파일 선택하도록 함
			let hasSelect = $(this).attr('class').indexOf('select');
			if(hasSelect == -1)
				$('.main .box-nav .box-drop [name=file]').click();
			//파일을 선택하지 않으면 드롭박스 안열림
			let file = $('.main .box-nav .box-drop [name=file]').val();
			if(file == '')
				return;
			//아이콘 색깔 변경
			$(this).toggleClass('select');
			//드롭 박스
			$('.main .box-nav .box-drop').toggle();
		})//

		//사진 선택했으면(input:file)------------------------------------------------------------------------------------------
		$('.main .box-nav .box-drop [name=file]').on('change', function(event) {
			//파일을 선택하지 않았으면
			if(event.target.files.length == 0){
				init();
				return;
			} else{
				$('.main .box-drop .box-preview').show();
				$('.main .box-nav .box-drop').show();
				$('.main .box-nav .box-upload .btn-upload').addClass('select');	
			}
		  let file = event.target.files[0];
		  let reader = new FileReader(); 
		  
		  reader.onload = function(e) {
		  	$('.main .box-drop .box-preview .preview').attr('src', e.target.result);
		  }
		  reader.readAsDataURL(file);
		})//
		
		//미리보기 사진(box-preview) 클릭-----------------------------------------------------------------------------------------
		$('.main .box-drop .box-preview').click(function(){
			$('.main .box-nav .box-drop [name=file]').click();
		})//
		
		//챌린지 참여 버튼(btn-participages) 클릭-----------------------------------------------------------------------------------------
		$('.main .box-drop .box-participate .btn-participate').click(function(){
			//참여할건지 묻기
			if(!confirm('챌린지에 참여하시겠습니까? 챌린지에 참여한 사진은 수정/삭제에 제한이 있으니 신중하게 선택해주세요.'))
				return;
			//사진을 선택하지 않았으면
			let image = $('.main .box-nav .box-drop [name=file]').val();
			if(image == ''){
				alert('사진을 선택하세요.');
				//화면 재구성
				init();
				$('.main .box-nav .box-drop [name=file]').click();
				return;
			}
			//강아지 정보와 사진 정보 서버로 보내기
			let data = new FormData();
			data.append('file', $('.main .box-nav .box-drop [name=file]')[0].files[0]);
			data.append('cl_num', cl_num);
			//챌린지 등록
			ajaxPostData(data, '/participate/challenge', function(data){
				init();				
				if(data.res == 2)
					alert('챌린지 참여했습니다.')
				else if(data.res == 0)
					alert('이미 참여한 챌린지 입니다.')
				else if(data.res == 1){
					alert('이미지 파일만 등록 가능합니다.');
					$('.main .box-nav .box-drop [name=file]').click();	
				}
				else if(data.res == -2){
					alert('로그인한 회원만 챌린지 참여 가능합니다.')
					location.href = '<%=request.getContextPath()%>/account/login';
				}
				else
					alert('챌린지 참여에 실패했습니다. 다시 시도해주세요.')
			});
		})//
		
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
	});
	
/* 함수 *********************************************************************************************************** */
	// init : 화면 초기화 --------------------------------------------------------------------------------------------
	function init(){
		$('.main .box-drop .box-preview').hide();
		$('.main .box-nav .box-drop').hide();
		$('.main .box-nav .box-upload .btn-upload').removeClass('select');
	}//
	
	// getLogList -----------------------------------------------------------------------------------------------------
	function getLogList(obj){
		ajaxPost(false, obj, '/get/logList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			for(log of data.lList){
				let criUrl = makeCriUrl(log.lg_num, obj);
				html += '<li class="log-item">';
				html +=		'<a href="'+contextPath+'/log/challengeDetail/'+criUrl+'" class="log-link"'; 
				html +=			'style="background-image: url('+contextPath+log.lg_image_url+')"></a>';
				html += '</li>';
			}
			$('.main .box-content .log-list').append(html);
		});
	}//
	
	// makeCriUrl -----------------------------------------------------------------------------------------------------
	function makeCriUrl(lg_num, obj){
		let lgNumUrl = '?lg_num=' + lg_num;
		let pageUrl = lgNumUrl +'&page=' + obj.page;
		let clNumUrl = pageUrl + '&cl_num=' +  obj.cl_num;
		let yearUrl = clNumUrl + '&year=' +  ${challenge.cl_year};
		let monthUrl = yearUrl + '&month=' +  ${challenge.cl_month};
		return monthUrl;
	}
</script> 
</html>