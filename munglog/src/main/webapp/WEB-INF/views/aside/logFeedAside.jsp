<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>side-멍멍피드</title>
<!-- css ************************************************************ -->
<style>
	.side-main .box-search{
		border: 1px solid #52443b; border-radius: 5px; 
		padding: 20px 10px; box-shadow: 3px 3px 3px 0 rgba(73, 67, 60, 0.2);
	}
	.side-main .box-search .friend-list{
		margin: 20px 0 0; max-height: 180px; overflow-y: scroll;
	}
	.side-main .box-search .friend-list .friend-item{
		background-color: #fff7ed; margin-bottom: 10px;
		padding: 5px 0 5px 5px;
	}
	.side-main .box-search .friend-item .friend-link{
		display: block; height: 40px; margin: auto 0 ;
	}
	.side-main .box-search .friend-item .thumb{float: left;}
	.side-main .box-search .friend-item .thumb img{
		border-radius: 50px; width: 40px; height: 40px;
	}
	.side-main .box-search .friend-item .nickname{
		float: left; width: 166px;
		line-height: 40px; padding-left: 10px;
		font-weight: bold; overflow: hidden; text-overflow: ellipsis;
	}
</style>
</head>
<!-- html ********************************************************************************************************* -->
<body>
	<div class="box-search" style="width: 260px;">
		<input class="form-control" id="myInput" type="text" placeholder="닉네임을 검색하세요">
		<ul class="friend-list" id="myList">
			<c:forEach items="${memberList}" var="member">
				<li class="friend-item">
				<a class="friend-link" href="#">
				<div class="thumb">
				<img src="<c:url value="${member.mb_profile_url}"></c:url>">
				</div>
				<div class="nickname">${member.mb_nickname}</div>
				</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>
<!-- script ******************************************************************************************************* -->
<script>
	$(function(){
		let obj = {};
		$(document).ready(function(){
			//getMemberList(obj);
			$('#myInput').on('keyup', function() {					
				var value = $(this).val().toLowerCase();
				if(value == ''){
					$('.friend-list').hide();
				}
				if(value != ''){
					$('.friend-list').show();
					$('#myList li').filter(function() {
						$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
					});
				}
			});
		});
	})
/* 함수 *********************************************************************************************************** */
	// getMemberList -----------------------------------------------------------------------------------------------------
	function getMemberList(obj){
		ajaxPost(false, obj, '/get/memberList', function(data){
			let html = '';
			let contextPath = '<%=request.getContextPath()%>';
			for(member of data.memberList){
				html += '<li class="friend-item">';
				html += 	'<a class="friend-link" href="#">';
				html += 		'<div class="thumb">';
				html += 			'<img src="'+contextPath+'/profile/img'+member.mb_profile+'">';
				html += 		'</div>';
				html += 		'<div class="nickname">'+member.mb_nickname+'</div>';
				html += 	'</a>';
				html += '</li>';		
			}
			$('.side-main .box-search .friend-list').append(html);
		});
	}//
</script>
</html>