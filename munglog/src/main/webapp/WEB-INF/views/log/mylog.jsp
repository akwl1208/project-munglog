<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-나의일지</title>
<!-- css ************************************************************ -->
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
	.main .box-nav{margin-bottom: 10px; position: relative;}
	.main .box-nav .box-set .set{margin-left: 10px;}
	.main .box-nav .box-set .set .fa-solid:hover{color:#fb9600;}
	.main .box-nav .box-drop{
		position: absolute; top: 40px; left: 0; right: 0; background-color: white;
		width: 100%; border-bottom: 3px solid rgba(73, 67, 60, 0.1);
		
	}
	.main .box-nav .box-drop .drop{padding: 20px 40px;}
	.main .box-drop .drop-upload .box-checkbox .box-message,
	.main .box-drop .drop-filter .box-dog .box-message{margin: 5px 0;}
	.main .box-drop .drop-upload .box-file .btn-file,
	.main .box-drop .drop-upload .box-send .btn-send,
	.main .box-drop .drop-filter .box-btn .btn-reset,
	.main .box-drop .drop-filter .box-btn .btn-filter{
		padding: 5px 10px; background-color: #a04c00; margin-left: 10px;
		border: none; color: #fff7ed; border-bottom: 3px solid rgba(73, 67, 60, 0.3);
		border-radius: 3px;
	}
	.main .box-drop .drop-upload .box-send,
	.main .box-drop .drop-filter .box-year{margin-top: 20px;}
	.main .box-drop .drop-upload .box-send .box-preview{margin: 0 auto;}
	.main .box-drop .drop-filter .box-btn{text-align: right;}
	.main .box-drop .drop-sort .box-choose{text-align: right;}
	.main .box-drop .drop-sort .box-choose .sort-oldest::before,
	.main .box-drop .drop-sort .box-choose .sort-popularity::before{
		display: inline-block; content: ''; margin: 0 10px;
		width: 1px; height: 12px; background-color: #b9ab9a;
		line-height: 24px;
	}
	.main .box-content{background-color: red; height: 100px;	padding: 20px 44px;}
</style>
</head>
<!-- html ************************************************************ -->
<body>
	<!-- box-title(제목) -------------------------------------------------------- -->
	<div class="box-title">
		<i class="fa-solid fa-paw"></i><span>멍멍 일지</span>
		<div class="box-message">강아지의 일상을 기록하고 감상하세요.</div>
	</div>
	<!-- box-nav(메뉴) -------------------------------------------------------- -->
	<div class="box-nav">
		<!-- box-set(아이콘 버튼들) -------------------------------------------------------- -->
		<div class="box-set d-flex justify-content-end">
			<div class="set box-upload p-2"><i class="btn-upload fa-solid fa-camera"></i></div>
			<div class="set box-filter p-2"><i class="btn-filter fa-solid fa-filter"></i></i></div>
			<div class="set box-sort p-2""><i class="btn-sort fa-solid fa-arrow-down-short-wide"></i></div>
		</div>
		<!-- box-drop(드랍 박스) -------------------------------------------------------- -->
		<div class="box-drop" style="display: none;">
			<!-- drop-upload -------------------------------------------------------- -->
			<div class="drop drop-upload">
				<!-- box-select -------------------------------------------------------- -->
				<div class="box-select d-flex flex-column">
					<!-- box-checkbox(강아지 선택) -------------------------------------------------------- -->
					<div class="box-checkbox">
						<div class="box-message">사진 속 강아지를 선택하세요.</div>
						<c:forEach items="${dList}" var="dog">
							<div class="box-dog form-check-inline">
								<label class="form-check-label" for="check1">
									<input type="checkbox" class="form-check-input" name="dg_num" value="${dog.dg_num}">${dog.dg_name}
								</label>
							</div>
			 			</c:forEach>
					</div>
					<!-- box-file(사진 선택) -------------------------------------------------------- -->
					<div class="box-file ml-auto">
						<input type="file" name="file" accept="image/jpg, image/jpeg, image/png, image/gif" style="display: none;">
						<button type="button" class="btn-file">사진 선택</button>
					</div>
				</div>
				<!-- box-send(사진 미리보기, 사진 전송) -------------------------------------------------------- -->
				<div class="box-send" style="display: none;">
					<div class="d-flex align-items-end justify-content-between">
						<!-- box-preview(사진 미리보기) -------------------------------------------------------- -->
						<div class="box-preview">
							<img class="preview" style="max-width: 300px; max-height: 300px;">
						</div>
						<!-- 사진 전송 버튼(box-send) -------------------------------------------------------- -->
						<button type="button" class="btn-send">사진 등록</button>
					</div>
				</div>
			</div>
			<!-- drop-filter -------------------------------------------------------- -->
			<div class="drop drop-filter">
				<!-- box-select -------------------------------------------------------- -->
				<div class="box-select d-flex flex-column">
					<!-- box-dog(강아지 선택) -------------------------------------------------------- -->
					<div class="box-dog">
						<div class="box-message">사진을 보고 싶은 강아지를 선택하세요.</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="optradio">멍멍이
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="optradio">왈왈이
							</label>
						</div>
						<div class="form-check-inline disabled">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="optradio">뭉뭉이
							</label>
						</div>
					</div>
					<!-- box-year(년도 선택) -------------------------------------------------------- -->
					<div class="box-year">
						<div class="box-message mb-2">보고 싶은 년도를 선택하세요.</div>
						<div class="form-group mb-0" style="width: 100px;">
							<select class="form-control">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
							</select>
						</div>
					</div>
				</div>
				<!-- box-btn(초기화, 설정) -------------------------------------------------------- -->
				<div class="box-btn">
					<button type="button" class="btn-reset">초기화</button>
					<button type="button" class="btn-filter">설정</button>
				</div>
			</div>
			<!-- drop-sort -------------------------------------------------------- -->
			<div class="drop drop-sort">
				<!-- box-choose(정렬 방식 선택) -------------------------------------------------------- -->
				<div class="box-choose">
					<span class="sort sort-lastest">최신순</span>
					<span class="sort sort-oldest">오래된순</span>
					<span class="sort sort-popularity">인기순</span>
				</div>
			</div>
		</div>
	</div>
	<!-- box-content -------------------------------------------------------- -->
	<div class="box-content">
	${dList}
	</div>
</body>
<!-- script **************************************************************************** -->
<script>
	$(function(){	
	/* 이벤트 **************************************************************************** */
		//사진 등록 아이콘 클릭-------------------------------------------------------
		$('.main .box-nav .btn-upload').click(function(){
			$('.box-drop').toggle();
			$('.drop').hide();
			$('.drop-upload').show();
		})
		
		//필터 아이콘 클릭-------------------------------------------------------
		$('.main .box-nav .btn-filter').click(function(){
			$('.box-drop').toggle();
			$('.drop').hide();
			$('.drop-filter').show();
		})
		
		//정렬 아이콘 클릭-------------------------------------------------------
		$('.main .box-nav .btn-sort').click(function(){
			$('.box-drop').toggle();
			$('.drop').hide();
			$('.drop-sort').show();
		})
		
		//사진 선택 버튼(btn-file) 클릭-------------------------------------------------------
		$('.main .drop-upload .box-file .btn-file').click(function(){
			$('.main .drop-upload .box-file [name=file]').click();
		})
		
		//사진을 선택했으면 -------------------------------------------------------
		$('.main .drop-upload .box-file [name=file]').on('change', function(event) {
			//파일을 선택하지 않았으면
			if(event.target.files.length == 0){
				$('.main .box-drop .drop-upload .box-file').show();
				$('.main .box-drop .drop-upload .box-send').hide();
				return;
			} else{
				$('.main .box-drop .drop-upload .box-file').hide();
				$('.main .box-drop .drop-upload .box-send').show();			
			}
		  let file = event.target.files[0];
		  let reader = new FileReader(); 
		  
		  reader.onload = function(e) {
		      $('.main .drop-upload .box-send .box-preview .preview').attr('src', e.target.result);
		  }
		  reader.readAsDataURL(file);
		});
	
		$('.main .box-drop .drop-upload .box-send .box-preview').click(function(){
			$('.main .drop-upload .box-file [name=file]').click();
			$('.main .drop-upload .box-file [name=file]').change();
		})
	})
</script> 
</html>