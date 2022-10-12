<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 Q&A 등록</title>
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
	.main .box-content .box-register label{font-weight: bold;}
	
	.main .box-content .box-register .btn-register{
		box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-bottom: 10px;
	}
	.main .box-content .box-register .box-attachment input{
		line-height: 24px;
	}
	.main .box-content .box-register .btn-register:hover{color:#fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 Q&A 등록</span>
	<div class="box-message">정보를 입력하고 굿즈 Q&A를 등록하세요.</div>
</div>		
<!-- box-content ------------------------------------------------------------------------------------------------- -->	
<form class="box-content" method="post" enctype="multipart/form-data">
	<!-- box-register ------------------------------------------------------------------------------------------------- -->
	<div class="box-register">
		<!-- box-goods(굿즈 선택) ------------------------------------------------------------------------------------------------- -->
		<div class="box-goods mb-3">
			<label>문의할 굿즈</label>
			<select class="form-control" name="qn_gs_num">
				<option value ="0">굿즈 선택</option>
				<c:forEach items="${goodsList}" var="goods">
					<option value="${goods.gs_num}">${goods.gs_name}</option>
				</c:forEach>
			</select>	
		</div>
		<!-- box-qna-title(문의 제목) ------------------------------------------------------------------------------------------------- -->
		<div class="box-qna-title mb-3">
			<label>문의 제목</label>
			<select class="form-control" name="bd_title">
				<option value="0">제목 선택</option>
				<option>상품 문의</option>
				<option>배송 문의</option>
				<option>교환 및 환불 문의</option>
				<option>결제 문의</option>
				<option>기타 문의</option>
			</select>	
		</div>
		<!-- box-qna-content(문의 내용) ------------------------------------------------------------------------------------------------- -->
		<div class="box-qna-content mb-3 form-group">
			<label>문의 내용</label>
			<textarea type="text" class="form-control" name="bd_content"></textarea>
		</div>
		<!-- box-ataachment(첨부파일) ------------------------------------------------------------------------------------------------- -->
		<div class="box-attachment form-group">
			<label>첨부파일파일</label>
			<input type="file" class="mb-2 form-control" name="attachments">
			<input type="file" class="mb-2 form-control" name="attachments">
			<input type="file" class="form-control" name="attachments">
	 	</div>
	 	<!-- btn-register ------------------------------------------------------------------------------------------------- -->
		<button type="submit" class="btn-register col-12 mt-4">QNA 등록</button>
	</div>
</form>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		//썸머노트 ==============================================================================================
		$('[name=bd_content]').summernote({
			placeholder: '문의 내용을 입력하세요.',
			tabsize: 2,
			height: 600,
			minHeight: 600,
			lang: 'ko-KR',
			toolbar: [
			  ['style', ['style']],
			  ['font', ['bold', 'underline', 'clear']],
			  ['fontname', ['fontname']],
			  ['color', ['color']],
			  ['para', ['ul', 'ol', 'paragraph']],
			  ['table', ['table']],
			  ['insert', ['picture']]
			],
			callbacks: {
				onImageUpload: function(files) {
					if(files == null || files.length ==0)
						return;
					for(file of files){
				  	let data = new FormData();
				  	data.append('file',files[0]);
				  	let thisObj = $(this);
						ajaxPostData(data, '/upload/qnaImg', function(data){
				 			let url = '<%=request.getContextPath()%>/qna/img' + data.url;
				 			thisObj.summernote('insertImage', url);
				 		});
					}
  	   	}
  	  }
		})
	})//
	
	// form 보내기 전 =================================================================================
	$('form').submit(function(){
		if('${user.mb_num}' == ''){
			if(confirm('Q&A를 등록하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		let qn_gs_num = $('[name=bd_gs_num]').val();
		if(qn_gs_num == 0){
			alert('문의할 굿즈를 선택해주세요.')
			return false;
		}
		let bd_title = $('[name=bd_title]').val();
		if(bd_title == 0){
			alert('문의 제목을 선택해주세요.')
			return false;
		}
		let bd_content = $('[name=bd_content]').val();
		if(bd_content == '' || bd_content.length == 0){
			alert('문의 내용을 입력해주세요.')
			return false;
		}
		let inputLength = $('.box-attachment [name=attachments]').length;
		if(inputLength > 3){
			alert('첨부파일은 최대 3개까지 가능합니다.')
			return false;
		}
	})//
});
</script>
</html>