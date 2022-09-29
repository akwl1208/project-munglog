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
	.main .box-content .log-list .log-item .log-link:hover{transform: scale(1.2);}
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
				<input type="file" name="file" style="display: none;">
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
	let page = 1;
	let obj = {
		page,
		perPageNum : 12
	};
	$(function(){
/* 이벤트 *********************************************************************************************************** */		
		//카메라 아이콘(btn-upload) 클릭 ------------------------------------------------------------------------------------
		$('.main .box-nav .box-upload .btn-upload').click(function(){
			$('.main .box-drop .box-preview').hide();
			//드롭박스를 열면 파일 선택하도록 함
			let hasSelect = $(this).attr('class').indexOf('select');
			if(hasSelect == -1)
				$('.main .box-nav .box-drop [name=file]').click();
			let file = $('.main .box-nav .box-drop [name=file]').val();
			if(file == ''){
				return;
			}
			//아이콘 색깔 변경
			$(this).toggleClass('select');
			//드롭 박스
			$('.main .box-nav .box-drop').toggle();
		})

		//사진 선택했으면(input:file)------------------------------------------------------------------------------------------
		$('.main .box-nav .box-drop [name=file]').on('change', function(event) {
			//파일을 선택하지 않았으면
			if(event.target.files.length == 0){
				$('.main .box-drop .box-preview').hide();
				$('.main .box-nav .box-drop').hide();
				$('.main .box-nav .box-upload .btn-upload').removeClass('select');
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
	});
	
/* 함수 *********************************************************************************************************** */
	//  -----------------------------------------------------------------------------------------------------


</script> 
</html>