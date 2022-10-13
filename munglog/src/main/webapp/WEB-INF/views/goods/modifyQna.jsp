<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 Q&A 수정</title>
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
	.main .box-content .box-btn{font-size: 18px; font-weight: bold;}
	.main .box-content .box-btn .fa-solid:hover{color: #FF9E54; cursor: pointer;}
	.main .box-content .box-modify label{font-weight: bold;}
	.main .box-content .box-modify .box-attachment .btn-delete{line-height:24px;}
	.main .box-content .box-modify .box-attachment .btn-delete:hover{color: #FF9E54; cursor: pointer;}
	.main .box-content .box-modify .btn-modify{
		box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-bottom: 10px;
	}
	.main .box-content .box-modify .btn-modify:hover{color:#fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 Q&A 수정</span>
	<div class="box-message">정보를 입력하고 굿즈 Q&A를 수정하세요.</div>
</div>		
<!-- box-content ------------------------------------------------------------------------------------------------- -->	
<form class="box-content" method="post" enctype="multipart/form-data">
	<div class="box-btn text-right mb-3">
		<a class="link-list" href="<c:url value="/goods/qna"></c:url>">
			<i class="btn-goToList fa-solid fa-list"></i>
		</a>
	</div>
	<!-- box-modify ------------------------------------------------------------------------------------------------- -->
	<div class="box-modify">
		<input type="hidden" name="qn_bd_num" value="${qna.qn_bd_num}">
		<!-- box-goods(굿즈 선택) ------------------------------------------------------------------------------------------------- -->
		<div class="box-goods mb-3">
			<label>문의할 굿즈</label>
			<select class="form-control" name="qn_gs_num">
				<option value ="0">굿즈 선택</option>
				<c:forEach items="${goodsList}" var="goods">
					<option value="${goods.gs_num}" <c:if test="${goods.gs_num == qna.qn_gs_num}">selected</c:if>>${goods.gs_name}</option>
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
			<textarea type="text" class="form-control" name="bd_content">${qna.bd_content}</textarea>
		</div>
		<!-- box-atachment(첨부파일) ------------------------------------------------------------------------------------------------- -->
		<div class="box-attachment form-group">
			<label>첨부파일파일</label>
			<c:forEach items="${attachmentList}" var="attachment">
				<a href="javascript:0;" class="oriAttachment mb-2 form-control">
					${attachment.at_ori_name}
					<i class="btn-delete fa-solid fa-square-xmark float-right" data-value="${attachment.at_num}"></i>
				</a>
			</c:forEach>
			<c:forEach begin="1" end="${3-attachmentList.size()}">
				<input type="file" class="mb-2 form-control" name="attachments">
			</c:forEach>
	 	</div>
	 	<!-- btn-modify ------------------------------------------------------------------------------------------------- -->
		<button type="submit" class="btn-modify col-12 mt-4">QNA 수정</button>
	</div>
</form>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		// 제목 선택 ===========================================================================================
		let gsNum = '${qna.qn_gs_num}';
		let bdTitle = '${qna.bd_title}';
		$('[name=bd_title] option').each(function(){
			let value = $(this).val();
			if(value == bdTitle){
				$(this).prop('selected', true);
				return false;
			}
		})
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
	
	// 첨부파일 삭제 클릭 =================================================================================
	$('.main .box-content .box-modify .box-attachment .btn-delete').click(function(){
		let atNum = $(this).data('value');
		let html = '';
		html += '<input type="file" class="mb-2 form-control" name="attachments">';
		html += '<input type="hidden" name="nums" value="'+atNum+'">';
		$(this).parents('.box-attachment').append(html);
		$(this).parent().remove();
	})//
	
	// form 보내기 전 =================================================================================
	$('form').submit(function(){
		//로그인 안했으면
		if('${user.mb_num}' == ''){
			if(confirm('Q&A를 수정하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return false;
		}
		//답변 완료한 게시글은 수정 못함
		if('${qna.qn_state}' == '답변 완료'){
			alert('답변을 완료한 Q&A는 수정할 수 없습니다. 새로 등록해주세요.');
			return false;
		}
		//굿즈 입력했는지
		let qn_gs_num = $('[name=bd_gs_num]').val();
		if(qn_gs_num == 0){
			alert('문의할 굿즈를 선택해주세요.');
			return false;
		}
		//제목 입력했는지
		let bd_title = $('[name=bd_title]').val();
		if(bd_title == 0){
			alert('문의 제목을 선택해주세요.');
			return false;
		}
		//내용 입력했는지
		let bd_content = $('[name=bd_content]').val();
		if(bd_content == '' || bd_content.length == 0){
			alert('문의 내용을 입력해주세요.');
			return false;
		}
		//첨부파일 개수 확인(최대 3개)
		let attachmentLength = $('.box-attachment [name=attachments]').length;
		let oriAttachmentLength = $('.box-attachment .oriAttachment').length;
		if(attachmentLength + oriAttachmentLength != 3 || attachmentLength > 3 || oriAttachmentLength > 3){
			alert('첨부파일은 최대 3개까지 가능합니다.');
			return false;
		}
		//수정할건지 묻기
		if(!confirm('Q&A를 수정하겠습니까?'))
			return false;
	})//
});
</script>
</html>