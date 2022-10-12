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
	.main .box-content{
		margin: 44px;  border-bottom: 2px solid #d7d5d5;
	}
	.main .box-content .box-btn{font-size: 18px; font-weight: bold;}
	.main .box-content .box-btn .fa-solid:hover{color: #FF9E54; cursor: pointer;}
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
		<a class="link-modify" href="#">
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
</div>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */
	let userMbNum = '${user.mb_num}';
	let userLevel = '${user.mb_level}'
/* 이벤트 *********************************************************************************************************** */
$(function(){
	//QNA 삭제(btn-delete) 클릭	=================================================================================
	$('.main .box-content .box-btn .btn-delete').click(function(){
		//로그인 안했으면
		if(userMbNum == ''){
			if(confirm('Q&A를 삭제하려면 로그인이 필요합니다. 로그인 화면으로 이동하겠습니까?'))
				location.href = '<%=request.getContextPath()%>/account/login';
			e.preventDefault();
			return;
		}
		//관리자가 아닌 다른 회원이 삭제하면
		let mbNum = ${qna.bd_mb_num};
		if(userLevel != 'A' && userLevel != 'S' && (userMbNum != mbNum)){
			alert('Q&A를 작성한 회원만 삭제 수 있습니다.')	
			e.preventDefault();	
			return;
		}
		//삭제할건지 묻기
		if(!confirm('Q&A를 삭제하겠습니까?'))
			return;
		//삭제하기
		deleteQna();
	})//
})//	
	
/* 함수 *********************************************************************************************************** */
	// deleteQna : QNA 삭제 =============================================================================
	function deleteQna(){
		let bd_num = ${qna.qn_bd_num};
		let bd_mb_num = ${qna.bd_mb_num};
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
</script>
</html>