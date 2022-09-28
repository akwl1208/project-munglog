<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 관리</title>
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
	.main .box-content .box-register .box-file{
		border: 1px solid #dfe0df;
		width: 170px; height: 170px; text-align: center;
	}
	.main .box-content .box-register .box-file:hover .btn-file{color: #fb9600; cursor:pointer;}
	.main .box-content .box-register .fa-square-plus{line-height: 170px;}
	.main .box-content .box-register .box-detail .error{font-size: 12px; color: #fb9600;}
	.main .box-content .box-register .box-button .btn-register,
	.main .box-content .box-register .box-button .btn-modify,
	.main .box-content .box-register .box-button .btn-cancel{
		float: right; background-color: #a04c00;
		border: none; color: #fff7ed; box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
		border-radius: 3px; padding: 5px 10px;
	}
	.main .box-content .box-list thead{background-color: #dfe0df;}
	.main .box-content .box-list td, 
	.main .box-content .box-list tr{text-align: center;}
	.main .box-content .box-list td{
		height: 112px; vertical-align: middle; line-height: 112px;
	}
	.main .box-content .box-list .item-thumb .thumb{width: 112px; height: 112px;}
	.main .box-content .box-list .item-thumb .cl_thumb{width: 100%; height: 100%;}
	.main .box-content .box-list .item-theme .cl_theme{
		width: 370px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
	}
	.main .box-content .box-list .item-modify:hover .btn-modify,
	.main .box-content .box-list .item-delete:hover .btn-delete{color: #fb9600; cursor:pointer;}
	.main .box-content .box-list .page-link {color: #402E32;}
	.main .box-content .box-list .page-item.active .page-link {
	 z-index: 1; color: #fb9600; font-weight:bold;
	 background : #fff; border-color: #DFE0DF;	 
	}	
	.main .box-content .box-list .page-link:focus,
	.main .box-content .box-list .page-link:hover {
	  color: #000; background-color: #DFE0DF; border-color: #ccc;
	}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>챌린지 관리</span>
	<div class="box-message">챌린지를 등록하고 관리하세요.</div>
</div>
<!-- box-content ----------------------------------------------------------------------------------------------------- -->			
<div class="box-content">
	<!-- box-register(챌린지 등록/수정) ------------------------------------------------------------------------------------- -->
	<div class="box-register">
		<div class="clearfix">
			<!-- box-file(파일 선택) ------------------------------------------------------------------------------------------ -->				
			<div class="box-file float-left">
				<div class="btn-file" width="100%" height="100%"><i class="fa-solid fa-square-plus"></i></div>
				<input type="file" name="file" style="display: none;" accept="image/jpg, image/jpeg, image/png, image/gif">
				<img class="preview" width="100%" height="100%" style="display: none;">
				<img class="modiPreview" width="100%" height="100%" style="display: none;">
			</div>
			<!-- box-detail(정보 입력) ---------------------------------------------------------------------------------------- -->						
			<div class="box-detail float-right" style="width:calc(100% - 170px - 20px)">
				<input type="text" class="clNum" style="display:none;">
				<!-- 년도 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group">
					<input type="text" class="clYear form-control" placeholder="년도 (예시: 2022)">			
				</div>
				<!-- 월 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group">
					<input type="text" class="clMonth form-control" placeholder="월 (예시1: 09)">
				</div>
				<!-- 주제 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group">
					<textarea class="clTheme form-control" rows="2" style="resize:none" placeholder="챌린지 주제를 100자 이하로 작성해주세요."></textarea>
				</div>
				<!-- 오류 메세지 ------------------------------------------------------------------------------------------------ -->
				<div class="error"></div>
			</div>
		</div>
		<!-- box-button ------------------------------------------------------------------------------------------------ -->
		<div class="box-button">
			<!-- 챌린지 등록 버튼 ---------------------------------------------------------------------------------------------- -->
			<div class="btn-register-set">
				<button type="button" class="btn-register mb-4">챌린지 등록</button>
			</div>
			<!-- 챌린지 수정 버튼 ---------------------------------------------------------------------------------------------- -->
			<div class = "btn-modify-set" style="display:none;">
				<button type="button" class="btn-cancel mb-4">취소</button>				
				<button type="button" class="btn-modify mr-2 mb-4">챌린지 수정</button>
			</div>
		</div>
	</div>
	<!-- box-list(챌린지 목록) -------------------------------------------------------------------------------------------- -->
	<div class="box-list">
		<table class="table table-hover">
			<thead>
				<tr>
					<th width="20%">썸네일</th>
					<th width="5%">년도</th>
					<th width="5%">월</th>
					<th width="60%">주제</th>
					<th width="5%"></th>
					<th width="5%"></th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
		<ul class="pagination justify-content-center mt-5"></ul>
	</div>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let yearRegex = /^(\d{4})$/;
	let monthRegex = /^(\d{2})$/;
	let page = 1;
	let cri = {
		page,
		perPageNum : 12
	}
	const now = new Date();
	const thisYear = now.getFullYear();
	const thisMonth = now.getMonth()+1;
	let oriYear;
	let oriMonth;
/* 이벤트 *********************************************************************************************************** */
	$(function(){
		$(document).ready(function(){
			// 챌린지 리스트 화면 구성
			getChallengeList(cri);		
		})//
		
		// textarea 글자수 제한 이벤트 ----------------------------------------------------------------------------------
    $('.main .box-content .box-register .box-detail .clTheme').on('keyup', function() {	 
      if($(this).val().length > 100)
        $(this).val($(this).val().substring(0, 100));
    })//
    
		// 사진 선택(btn-file), 미리보기(preview), 수정미리보기(modiPreview) -----------------------------------------------------
		$('.main .box-content .box-register .box-file .btn-file, .main .box-content .box-register .box-file .preview, .main .box-content .box-register .box-file .modiPreview').click(function(){
			$('.main .box-content .box-register .box-file [name=file]').click();
		})
		
		//사진 선택했으면(input:file)------------------------------------------------------------------------------------------
		$('.main .box-content .box-register .box-file [name=file]').on('change', function(event) {
			let modiPreview = $('.main .box-content .box-register .box-file .modiPreview').attr('src');
			//미리보기 화면 구성
			if(typeof(modiPreview) != 'undefined' && event.target.files.length == 0){
				$('.main .box-content .box-register .box-file .btn-file').hide();
				$('.main .box-content .box-register .box-file .modiPreview').show();
				$('.main .box-content .box-register .box-file .preview').hide();
				return;
			} else if(typeof(modiPreview) != 'undefined' && event.target.files.length != 0){
				$('.main .box-content .box-register .box-file .btn-file').hide();
				$('.main .box-content .box-register .box-file .modiPreview').hide();
				$('.main .box-content .box-register .box-file .preview').show(); 
			} else if(typeof(modiPreview) == 'undefined' && event.target.files.length == 0){
				$('.main .box-content .box-register .box-file .btn-file').show();
				$('.main .box-content .box-register .box-file .preview').hide();
				$('.main .box-content .box-register .box-file .modiPreview').hide();
				return;
			} else{
				$('.main .box-content .box-register .box-file .btn-file').hide();
				$('.main .box-content .box-register .box-file .preview').show();
				$('.main .box-content .box-register .box-file .modiPreview').hide();
			}
		  let file = event.target.files[0];
		  let reader = new FileReader(); 
		  
		  reader.onload = function(e) {
		  	$('.main .box-content .box-register .box-file .preview').attr('src', e.target.result);
		  }
		  reader.readAsDataURL(file);
		})//
		
		//챌린지 등록(btn-register) 클릭---------------------------------------------------------------------------------------
		$('.main .box-content .box-register .box-button .btn-register').click(function(){
			//챌린지 등록할건지 묻기
			if(!confirm('챌린지를 등록하시겠습니까?'))
				return;
			//에러메세지 없애기
			$('.main .box-content .box-register .box-detail .error').text('');
			//사진을 선택하지 않았으면
			let cl_thumb = $('.main .box-content .box-register .box-file [name=file]').val();
			if(cl_thumb == ''){
				alert('사진을 선택하세요.');
				//화면 재구성
				$('.main .box-content .box-register .box-file [name=file]').click();
				return;
			}
			//값 가져오기 
			let cl_year = $('.main .box-content .box-register .box-detail .clYear').val();
			let cl_month = $('.main .box-content .box-register .box-detail .clMonth').val();
			let cl_theme = $('.main .box-content .box-register .box-detail .clTheme').val();
			//형식 검사
			if(!validateChallenge(cl_year, cl_month, cl_theme))
				return;
			let data = new FormData();
			data.append('file', $('.main .box-content .box-register .box-file [name=file]')[0].files[0]);
			data.append('cl_year', cl_year);
			data.append('cl_month', cl_month);
			data.append('cl_theme', cl_theme);
			//챌린지 등록
			ajaxPostData(data, '/register/challenge', registerChallengeSuccess);
		})//
		
		//페이지네이션(page-link) 클릭-------------------------------------------------------------------------------------
		$(document).on('click','.main .box-content .box-list .page-link',function(e){
			e.preventDefault();
			cri.page = $(this).data('page');
			getChallengeList(cri);
		})//
		
		//수정 아이콘(btn-modify) 클릭-------------------------------------------------------------------------------------
		$(document).on('click','.main .box-content .box-list .item-modify .btn-modify',function(){
			if(!confirm('해당 챌린지를 수정하겠습니까?'))
				return;
			//readonly 해제
			$('.main .box-content .box-register .box-detail .clYear').prop('readonly', false);
			$('.main .box-content .box-register .box-detail .clMonth').prop('readonly', false);
			//값 가져오기
			let cl_num = $(this).data('value');
			let cl_thumb = $(this).parent().siblings('.item-thumb').find('.cl_thumb').attr('src');
			oriYear = $(this).parent().siblings('.item-year').find('.cl_year').text();
			oriMonth = $(this).parent().siblings('.item-month').find('.cl_month').text();
			let cl_theme = $(this).parent().siblings('.item-theme').find('.cl_theme').text();
			//값 넣어주기
			$('.main .box-content .box-register .box-file .btn-file').hide();
			$('.main .box-content .box-register .box-file .preview').hide();
			$('.main .box-content .box-register .box-file .modiPreview').show();
			$('.main .box-content .box-register .box-file .modiPreview').attr('src',cl_thumb);
			$('.main .box-content .box-register .box-detail .clNum').val(cl_num);
			$('.main .box-content .box-register .box-detail .clYear').val(oriYear);
			$('.main .box-content .box-register .box-detail .clMonth').val(oriMonth);
			$('.main .box-content .box-register .box-detail .clTheme').val(cl_theme);
			//진행 중이거나 지난 챌린지는 날짜 수정 못함
			if(Number(oriYear) < thisYear || Number(oriMonth) <= thisMonth){
				$('.main .box-content .box-register .box-detail .clYear').prop('readonly', true);
				$('.main .box-content .box-register .box-detail .clMonth').prop('readonly', true);
			}
			//버튼 재구성
			$('.main .box-content .box-register .btn-register-set').hide();
			$('.main .box-content .box-register .btn-modify-set').show();
		})//
		
		//수정 취소 버튼(btn-cancel) 클릭-------------------------------------------------------------------------------------
		$('.main .box-content .box-register .btn-modify-set .btn-cancel').click(function(){
			if(!confirm('챌린지 수정을 취소하겠습니까?'))
				return;
			//readonly 풀어주고
			$('.main .box-content .box-register .box-detail .clYear').prop('readonly', false);
			$('.main .box-content .box-register .box-detail .clMonth').prop('readonly', false);
			//화면 초기화
			initialization();
		})//
		
		//수정 버튼 클릭(btn-modify) 클릭-------------------------------------------------------------------------------------
		$('.main .box-content .box-register .btn-modify-set .btn-modify').click(function(){
			if(!confirm('챌린지를 수정하겠습니까?'))
				return;
			//에러메세지 없애기
			$('.main .box-content .box-register .box-detail .error').text('');
			//값 가져오기
			let cl_num = $('.main .box-content .box-register .box-detail .clNum').val();
			let cl_year = $('.main .box-content .box-register .box-detail .clYear').val();
			let cl_month = $('.main .box-content .box-register .box-detail .clMonth').val();
			let cl_theme = $('.main .box-content .box-register .box-detail .clTheme').val();
			//형식 검사
			if(!validateChallenge(cl_year, cl_month, cl_theme))
				return;
			//지난 챌린지는 수정할 수 없다.
			if(oriMonth <= thisMonth){
				$('.main .box-content .box-register .box-detail .error').text('이미 진행된 챌린지는 수정할 수 없습니다.');
				let cl_month = $('.main .box-content .box-register .box-detail .clMonth').focus();
				return;
			}
			console.log(oriYear)
			console.log(oriMonth)
			let data = new FormData();
			data.append('file', $('.main .box-content .box-register .box-file [name=file]')[0].files[0]);
			data.append('cl_num', Number(cl_num));
			data.append('cl_year', cl_year);
			data.append('cl_month', cl_month);
			data.append('cl_theme', cl_theme);
			data.append('oriYear', oriYear);
			data.append('oriMonth', oriMonth);
			//챌린지 수정
			ajaxPostData(data, '/modify/challenge', modifyChallengeSuccess);
		})//
		

	});		
	
/* 함수 *********************************************************************************************************** */
	// ajaxPostData : data 타입 보냄 --------------------------------------------------------------------------------
	function ajaxPostData(data, url, func){
		$.ajax({
			async: false,
			type:'POST',
			data: data,
			url: "<%=request.getContextPath()%>" + url,
			processData : false,
			contentType : false,
			dataType: "json",
			success : function(data){
				func(data)
			}
		});		
	}//
	
	// getChallengeList : 챌린지 리스트 가져오기 -------------------------------------------------------------------------------
	function getChallengeList(obj){
		ajaxPost(false, obj, '/get/challengeList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			//리스트 구현-----------------------------------------------------------------------------------
			for(challenge of data.challengeList){
				html += '<tr>';
				html += 	'<td class="item-thumb">';
				html += 		'<div class="thumb">';
				html += 			'<img class="cl_thumb" src="'+contextPath+challenge.cl_thumb_url+'">';
				html += 		'</div>';
				html += 	'</td>';
				html += 	'<td class="item-year"><span class="cl_year">'+challenge.cl_year+'</span></td>';
				html += 	'<td class="item-month"><span class="cl_month">'+challenge.cl_month+'</span></td>';
				html += 	'<td class="item-theme">';
				html += 		'<div class="cl_theme">'+challenge.cl_theme+'</div>';
				html += 	'</td>';
				html += 	'<td class="item-modify"><i class="btn-modify fa-solid fa-pen-to-square" data-value="'+challenge.cl_num+'"></i></td>';
				//진행중이거나 지난 챌린지 삭제 못하도록 막음
				let year = Number(challenge.cl_year);
				let month = Number(challenge.cl_month);
				html += 	'<td class="item-delete">';
				if(year >= thisYear && month > thisMonth)
					html += 	'<i class="btn-delete fa-solid fa-trash" data-value="'+challenge.cl_num+'"></i>';
				html += 	'</td>';
				html += '</tr>';
			}
			$('.main .box-content .box-list tbody').html(html);
			
			//페이지네이션 구현--------------------------------------------------------------------------
			html = '';
			let pm = data.pm;
			//이전
			html += 	'<li class="page-item';
			if(!pm.prev)
				html += 	' disabled';
			html += 	'">';
			html += 		'<a class="page-link" href="#" data-page="'+(pm.startPage-1)+'">이전</a>';
			html += 	'</li>';
			//페이지 숫자
			for(let i = pm.startPage; i <= pm.endPage; i++){
				html += '<li class="page-item';
				if(pm.cri.page == i)
					html += ' active';
				html += '">';
				html += 	'<a class="page-link" href="#" data-page="'+i+'">'+i+'</a>';
				html += '</li>';				
			}
			//다음
			html += 	'<li class="page-item';
			if(!pm.next)
				html += 	' disabled';
			html += 	'">';
			html += 		'<a class="page-link" href="#" data-page="'+(pm.endPage+1)+'">다음</a>';
			html += 	'</li>';
			$('.main .box-content .box-list .pagination').html(html);			
		});		
	}//
	
	// registerChallengeSuccess : 챌린지 등록에 성공했을 때 -----------------------------------------------------------------------	
	function registerChallengeSuccess(data){
		if(!data.res)
			alert('챌린지 등록에 실패했습니다. 형식에 맞게 입력했는지 또는 이미지 파일이 맞는지 확인해주세요.');
		else{
			alert('챌린지를 등록했습니다.');
			//화면 초기화
			initialization()
			//화면 새로고침
			location.reload();
		}
	}//
	
	// validateChallenge : 입력값 형식 검사 ---------------------------------------------------------------------------
	function validateChallenge(cl_year, cl_month, cl_theme){
		//값이 없으면
		if(cl_year == ''){
			$('.main .box-content .box-register .box-detail .clYear').focus();
			$('.main .box-content .box-register .box-detail .error').text('년도를 입력하세요.')
			return false;
		}
		//형식에 맞지 않으면
		if(Number(cl_year) < thisYear){
			$('.main .box-content .box-register .box-detail .clYear').focus();
			$('.main .box-content .box-register .box-detail .error').text(thisYear + '년부터 입력하세요.')
			return false;
		}
		//형식에 맞지 않으면
		if(!yearRegex.test(cl_year)){
			$('.main .box-content .box-register .box-detail .clYear').focus();
			$('.main .box-content .box-register .box-detail .error').text('2022 형식으로 입력하세요.')
			return false;
		}
		//값이 없으면
		if(cl_month == ''){
			$('.main .box-content .box-register .box-detail .clMonth').focus();
			$('.main .box-content .box-register .box-detail .error').text('월을 입력하세요.')
			return false;
		}
		//1~12월이 아니면
		if(Number(cl_month) < 1 || Number(cl_month) > 12){
			$('.main .box-content .box-register .box-detail .clMonth').focus();
			$('.main .box-content .box-register .box-detail .error').text('1~12월 중에 입력하세요.')
			return false;
		}
		//형식에 맞지 않으면
		if(!monthRegex.test(cl_month)){
			$('.main .box-content .box-register .box-detail .clMonth').focus();
			$('.main .box-content .box-register .box-detail .error').text('09 형식으로 입력하세요.')
			return false;
		}
		//값이 없으면
		if(cl_theme == ''){
			$('.main .box-content .box-register .box-detail .clTheme').focus();
			$('.main .box-content .box-register .box-detail .error').text('챌린지 주제를 입력하세요.')
			return false;
		}
		//100자 초과면
		if(cl_theme > 100){
			$('.main .box-content .box-register .box-detail .clTheme').focus();
			$('.main .box-content .box-register .box-detail .error').text('100자 이하로 작성해주세요.')
			return false;
		}
		return true;
	}//
	
	// modifyChallengeSuccess : 챌린지 수정에 성공했을 때 -----------------------------------------------------------------------	
	function modifyChallengeSuccess(data){
		if(!data.res)
			alert('챌린지 수정에 실패했습니다. 형식에 맞게 입력했는지 또는 이미지 파일이 맞는지 확인해주세요.');
		else{
			alert('챌린지를 수정했습니다.');
			//화면 초기화			
			initialization();
			//화면 새로고침
			location.reload();
		}
	}//
	
	function  initialization(){
		//값 비우기
		$('.main .box-content .box-register .box-detail .clYear').val(''); //년도 비우기
		$('.main .box-content .box-register .box-detail .clMonth').val('');	//월 비우기
		$('.main .box-content .box-register .box-detail .clTheme').val('');	//월 비우기
		$('.main .box-content .box-register .box-file [name=file]').val(''); //파일 비우기
		$('.main .box-content .box-register .box-file .modiPreview').attr('src', '');
		//파일 선택 화면 보이기
		$('.main .box-content .box-register .box-file .btn-file').show();
		$('.main .box-content .box-register .box-file .preview').hide();
		$('.main .box-content .box-register .box-file .modiPreview').hide();
		//버튼 재구성
		$('.main .box-content .box-register .btn-register-set').show();
		$('.main .box-content .box-register .btn-modify-set').hide();
	}
</script>
</html>