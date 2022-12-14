<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 Q&A 상세보기</title>
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
	.main .box-content .box-btn,
	.main .box-content .box-answer .box-set{font-size: 18px; font-weight: bold;}
	.main .box-content .box-btn .fa-solid:hover,
	.main .box-content .box-answer .box-set .fa-solid:hover{color: #FF9E54; cursor: pointer;}
	.main .box-content .box-qna-title{
		padding: 30px 30px 10px; font-size: 18px; border-top: 2px solid #d7d5d5;
	}
	.main .box-content .box-qna-detail{padding: 0 30px 30px;}
	.main .box-content .box-attachment{
		width: 100%; border-top: 1px solid #d7d5d5; padding: 10px 44px;
	}
	.main .box-content .box-attachment .attachment:hover{color: #FF9E54; cursor: pointer;}
	.main .box-content .box-qna-content{
		width: 100%; border-top: 1px solid #d7d5d5; padding: 44px;
		border-bottom: 2px solid #d7d5d5;
	}
	.main .box-content .box-register-answer,
	.main .box-content .box-answer{padding: 30px;}
	.main .box-content .box-register-answer .btn-register,
	.main .box-content .box-register-answer .btn-modify{
		box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3); width: 100%;
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-bottom: 10px;
	}
	.main .box-content .box-register-answer .btn-register:hover,
	.main .box-content .box-register-answer .btn-modify:hover{color:#fff7ed;}
	.main .box-content .box-answer{
		background-color:#fff7ed; border: 1px solid #d7d5d5;
		border-radius: 10px; margin: 30px;
	}
	.main .box-content .box-register-answer .btn-modify{width: 49%;}
	.main .box-content .box-register-answer .btn-cancel{
		box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3); width: 49%;
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fff7ed; margin-bottom: 10px;
		margin-left: 1%;
	}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 Q&A 상세보기</span>
	<div class="box-message">굿즈 Q&A를 관리하거나, 답변을 확인하세요.</div>
</div>
<div class="box-content">
	<div class="box-btn text-right mr-3 mb-3">
		<a class="link-list" href="<c:url value="/goods/qna"></c:url>">
			<i class="btn-goToList fa-solid fa-list mr-4"></i>
		</a>
		<a class="link-modify" href="<c:url value="/goods/modifyQna/${qna.qn_num}"></c:url>">
			<i class="btn-modify fa-solid fa-pen-to-square mr-4"></i>
		</a>
		<i class="btn-delete fa-solid fa-trash-can"></i>
	</div>
	<div class="box-qna-title">
		<span class="gs_name">${qna.gs_name}</span>
		<span class="ml-2 mr-2">-</span>
		<strong class="bd_title">${qna.bd_title}</strong>
	</div>
	<div class="box-qna-detail text-right">
		<div class="box-nickname">
			<span class="mr-2">작성자 :</span>
			<span class="mb_nickname">${qna.mb_nickname}</span>
		</div>
		<div class="box-regDate">
			<span class="mr-2">작성일 :</span>
			<span class="bd_reg_date">${qna.bd_reg_date_str}</span>
		</div>
	</div>
	<div class="box-attachment">
		<span>첨부파일</span>
		<c:if test="${fileList.size() == 0}">첨부파일 없음</c:if>
		<c:if test="${fileList.size() != 0}">
			<c:forEach items="${attachmentList}" var="attachment">
				<div class="ml-3 mt-1">
					<a class="attachment" href="<c:url value="/file${attachment.at_name}"></c:url>" download="${attachment.at_ori_name}">
						<i class="fa-solid fa-file mr-2"></i><span class="at_ori_name">${attachment.at_ori_name}</span>
					</a>
				</div>
			</c:forEach>
		</c:if>
	</div>
	<div class="box-qna-content">
		<div class="bd_content">${qna.bd_content}</div>
	</div>
	<div class="box-register-answer" 
	<c:if test="${(user != null && user.mb_level != 'A' && user.mb_level != 'S') || (qna.qn_state != '답변 대기') || comment != null}">style="display:none;"</c:if>>
		<div class="mb-2 font-weight-bold">Q&A 답변 작성</div>
		<textarea name="cm_content"><c:if test="${comment != null}">${comment.cm_content}</c:if></textarea>
		<c:if test="${qna.qn_state == '답변 대기' && comment == null}">
			<button type="button" class="btn-register mt-3">Q&A 답변 등록</button>
		</c:if>
		<c:if test="${qna.qn_state == '답변 완료' && comment != null}">
			<button type="button" class="btn-modify mt-3">Q&A 답변 수정</button>
			<button type="button" class="btn-cancel">취소</button>
		</c:if>
	</div>
	<c:if test="${qna.qn_state == '답변 완료' && comment != null}">
		<div class="box-answer">
			<c:if test="${user.mb_level == 'A' || user.mb_level == 'S'}">
				<div class="box-set text-right">
					<i class="btn-modify fa-solid fa-pen-to-square mr-3"></i>
					<i class="btn-delete fa-solid fa-trash-can"></i>
				</div>
			</c:if>
			<div class="box-answer-content">
				<div class="mb-2 font-weight-bold">Q&A 답변</div>
				<div class="cm_reg_date text-right">${comment.cm_reg_date_str}</div>
				<div class="cm_content">${comment.cm_content}</div>
			</div>
		</div>
	</c:if>
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let userMbNum = '${user.mb_num}';
	let userLevel = '${user.mb_level}';
/* 이벤트 *********************************************************************************************************** */
$(function(){
	$(document).ready(function(){
		//썸머노트 ==============================================================================================
		$('[name=cm_content]').summernote({
			placeholder: 'Q&A 답변을 입력하세요.',
			tabsize: 2,
			height: 400,
			minHeight: 400,
			lang: 'ko-KR',
			toolbar: [
			  ['style', ['style']],
			  ['font', ['bold', 'underline', 'clear']],
			  ['fontname', ['fontname']],
			  ['color', ['color']],
			  ['para', ['ul', 'ol', 'paragraph']],
			  ['table', ['table']],
			  ['insert', ['link', 'picture']]
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
	
	//QNA 삭제(btn-delete) 클릭	=================================================================================
	$('.main .box-content .box-btn .btn-delete').click(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 삭제하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		//관리자가 아닌 다른 회원이 삭제하면
		let mbNum = ${qna.bd_mb_num};
		if(userLevel != 'A' && userLevel != 'S' && (userMbNum != mbNum)){
			alert('Q&A를 작성한 회원만 삭제할 수 있습니다.');	
			return;
		}
		//삭제할건지 묻기
		if(!confirm('Q&A를 삭제하겠습니까?'))
			return;
		//삭제하기
		deleteQna();
	})//
	
	//QNA 수정(link-modify) 클릭	=================================================================================
	$('.main .box-content .box-btn .link-modify').click(function(e){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 수정하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			e.preventDefault();
			return;
		}
		//다른 회원이 수정하면
		let mbNum = '${qna.bd_mb_num}';
		if(userMbNum != mbNum){
			alert('Q&A를 작성한 회원만 수정할 수 있습니다.');	
			e.preventDefault();	
			return;
		}
		//답변 완료한 게시글은 수정 못함
		if('${qna.qn_state}' == '답변 완료'){
			alert('답변을 완료한 Q&A는 수정할 수 없습니다. 새로 등록해주세요.');
			e.preventDefault();
			return;
		}
		//수정할건지 묻기
		if(!confirm('Q&A를 수정하겠습니까?')){
			e.preventDefault();
			return;
		}
	})//
	
	//답변 등록(btn-register) 클릭	=================================================================================
	$('.main .box-content .box-register-answer .btn-register').click(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 삭제하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		//관리자가 아니면
		if(userLevel != 'A' && userLevel != 'S'){
			alert('관리자만 작성할 수 있습니다.');	
			return;
		}
		//이미 답변한 QNA
		if('${qna.qn_state}' != '답변 대기'){
			alert('이미 답변한 Q&A입니다.')
			return;
		}
		let cm_content = $('[name=cm_content]').val();
		if(cm_content == ''){
			alert('답변을 작성해주세요.');	
			return;
		}
		//등록할건지 묻기
		if(!confirm('Q&A 답변을 등록하겠습니까?'))
			return;
		answerQna(cm_content);
	})//
	
	//QNA 답변 삭제(btn-delete) 클릭	=================================================================================
	$('.main .box-content .box-answer .box-set .btn-delete').click(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 삭제하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		//관리자가 아니면
		if(userLevel != 'A' && userLevel != 'S'){
			alert('관리자만 삭제할 수 있습니다.');	
			return;
		}
		//삭제할건지 묻기
		if(!confirm('Q&A 답변을 삭제하겠습니까?'))
			return;
		//삭제하기
		let cm_num = '${comment.cm_num}';
		let cm_bd_num = '${comment.cm_bd_num}';
		let obj = {
			cm_num,
			cm_bd_num
		};
		deleteQnaAnswer(obj);
	})//
	
	//QNA 답변 수정(btn-modify) 클릭	=================================================================================
	$('.main .box-content .box-answer .box-set .btn-modify').click(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 수정하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		//관리자가 아니면
		if(userLevel != 'A' && userLevel != 'S'){
			alert('관리자만 수정할 수 있습니다.');	
			return;
		}
		//수정할건지 묻기
		if(!confirm('Q&A 답변을 수정하겠습니까?'))
			return;
		//화면 재구성
		$('.main .box-content .box-answer').hide();
		$('.main .box-content .box-register-answer').show();
	})//
	
	//답변 수정 취소(btn-cancel) 클릭	=================================================================================
	$('.main .box-content .box-register-answer .btn-cancel').click(function(){
		if(!confirm('답변 수정을 취소하겠습니까?'))
			return;
		//내용 다시 되돌리기
		let cmContent = '${comment.cm_content}';
		$('.main .box-content .box-register-answer [name=cm_content]').summernote('code', cmContent);
		//화면 재구성
		$('.main .box-content .box-answer').show();
		$('.main .box-content .box-register-answer').hide();
	})//
	
	//답변 수정(btn-modify) 클릭	=================================================================================
	$('.main .box-content .box-register-answer .btn-modify').click(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 수정하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			return;
		}
		//관리자가 아니면
		if(userLevel != 'A' && userLevel != 'S'){
			alert('관리자만 수정할 수 있습니다.');	
			return;
		}
		//수정할건지 묻기
		if(!confirm('Q&A 답변을 수정하겠습니까?'))
			return;
		let cm_num = '${comment.cm_num}';
		let cm_bd_num = '${qna.qn_bd_num}';
		let cm_content = $('[name=cm_content]').val();
		let obj = {
			cm_num,
			cm_bd_num,
			cm_content
		};
		modifyQnaAnswer(obj);
	})//
});
	
/* 함수 *********************************************************************************************************** */
	// deleteQna : QNA 삭제 =============================================================================
	function deleteQna(){
		let bd_num = '${qna.qn_bd_num}';
		let bd_mb_num = '${qna.bd_mb_num}';
		let obj = {
			bd_num,
			bd_mb_num
		}
		ajaxPost(false, obj, '/delete/qna', function(data){
			if(data.res){
				alert('Q&A를 삭제했습니다.');
				location.href = '<%=request.getContextPath()%>/goods/qna';
			} else
				alert('Q&A 삭제에 실패했습니다.');
		});
	}//
	
	// answerQna : QNA 답변 =============================================================================
	function answerQna(cm_content){
		let cm_bd_num = '${qna.qn_bd_num}';
		let obj = {
			cm_bd_num,
			cm_content
		}
		ajaxPost(false, obj, '/answer/qna', function(data){
			if(data.res){
				alert('Q&A 답변을 등록했습니다.');
				location.reload();
			} else
				alert('Q&A 답변 등록에 실패했습니다.');
		});
	}//
	
	// deleteQnaAnswer : QNA 답변 삭제 =============================================================================
	function deleteQnaAnswer(obj){
		ajaxPost(false, obj, '/delete/qnaAnswer', function(data){
			if(data.res){
				alert('Q&A 답변을 삭제했습니다.');
				location.reload();
			} else
				alert('Q&A 답변 삭제에 실패했습니다.');
		});
	}//
	
	// modifyQnaAnswer : QNA 답변 수정 =============================================================================
	function modifyQnaAnswer(obj){
		ajaxPost(false, obj, '/modify/qnaAnswer', function(data){
			if(data.res){
				alert('Q&A 답변을 수정했습니다.');
				location.reload();
			} else
				alert('Q&A 답변 수정에 실패했습니다.');
		});
	}//
</script>
</html>