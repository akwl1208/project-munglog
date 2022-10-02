<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 등록</title>
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
	.main .box-content .box-register .box-thumb{
		border: 1px solid #dfe0df;
		width: 170px; height: 170px; text-align: center;
	}
	.main .box-content .box-register .box-thumb .fa-solid{line-height: 170px;}
	.main .box-content .box-register .box-thumb:hover .fa-solid{color: #fb9600;}
	.main .box-content .box-register .error{font-size: 12px; color: #fb9600;}
	.main .box-content .box-option .btn-add{
		background-color: #a04c00; border-radius: 3px;
		border: none; color: #fff7ed; box-shadow: 3px 3px 3px rgba(73, 67, 60, 0.3);
	}
	.main .box-content .box-option thead{background-color: #dfe0df;}
	.main .box-content .box-option td, 
	.main .box-content .box-option tr{text-align: center;}
	.main .box-content .box-option td{vertical-align: middle;}
	.main .box-content .box-register .btn-register{
		box-shadow: 1px 1px 3px rgba(73, 67, 60, 0.3);
		font-size: 18px; font-weight: bold; padding: 5px 0;
		border: none; background-color: #fb9600; margin-bottom: 10px;
	}
	.main .box-content .box-register .btn-register:hover{color:#fff7ed;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- box-title(제목) ------------------------------------------------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>굿즈 등록</span>
	<div class="box-message">굿즈를 등록하기 위해 상품 관련 정보를 입력해주세요..</div>
</div>	
<!-- box-content ----------------------------------------------------------------------------------------------------- -->			
<form class="box-content">
	<!-- box-register -------------------------------------------------------------------------------------------------- -->
	<div class="box-register">			
		<div class="clearfix">
		 	<!-- box-thumb ------------------------------------------------------------------------------------------------- -->			
			<div class="box-thumb float-left">				
				<div class="btn-select" style="width: 100%; height: 100%;"><i class="fa-solid fa-square-plus"></i></div>
				<input type="file" name="file" style="display: none;">
				<img class="preview" width="100%" height="100%" style="display: none;">
			</div>
			<!-- 카테고리/제품명 ------------------------------------------------------------------------------------------------ -->						
			<div class="box-classification float-right" style="width:calc(100% - 170px - 20px)">
				<!-- 카테고리 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group">
					<label>카테고리</label>
					<select class="form-control">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
					</select>		
				</div>
				<!-- 상품명 ----------------------------------------------------------------------------------------------------- -->
				<div class="form-group mt-4">
					<label>상품명</label>
					<input type="text" class="gs_name form-control" name="gs_name" placeholder="상품명">			
				</div>
				<div class="error"></div>
			</div>
		</div>
		<!-- box-detail ----------------------------------------------------------------------------------------------------- -->				
		<div class="box-detail mt-4">
			<!-- box-option ----------------------------------------------------------------------------------------------------- -->
			<div class="box-option">
				<button type="button" class="btn-add mb-2 float-right p-1">옵션 추가</button>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th width="50%">옵션명</th>
							<th width="20%">수량</th>
							<th width="20%">가격</th>
							<th width="10%"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="item-name">
								<input type="text" class="ot_name form-control" name="ot_name" placeholder="옵션명">			
							</td>
							<td class="item-amount">
								<input type="text" class="ot_amount form-control" name="ot_amount" placeholder="수량">
							</td>
							<td class="item-price">
								<input type="text" class="ot_price form-control" name="ot_price" placeholder="가격">
							</td>
							<td class="btn-delete"><i class="fa-solid fa-trash"></i></td>
						</tr>
					</tbody>
				</table>
				<div class="error"></div>
			</div>
			<!-- box-description -------------------------------------------------------------------------------------- -->
			<div class="box-description mt-4">
				<div class="form-group">
					<label>상품 상세 정보</label>
					<textarea type="text" class="form-control" name="gs_description"></textarea>
				</div>
				<div class="form-group mt-4">
					<label>구매 가이드</label>
					<textarea class="form-control" name="gs_guidance"></textarea>
				</div>
			</div>
		</div>
		<!-- 굿즈 등록 버튼 ----------------------------------------------------------------------------------------------------- -->
		<button type="submit" class="btn-register col-12 mt-4">굿즈 등록</button>
	</div>
</form>
</body>
<!-- script *********************************************************************************************************** -->
<script>
/* 변수 *********************************************************************************************************** */

/* 이벤트 *********************************************************************************************************** */
	$(function(){
		//썸머노트 -----------------------------------------------------------------------------------------------------
		$('[name=gs_description]').summernote({
			placeholder: '제품 설명을 입력하세요.',
			tabsize: 2,
			height: 400
		});
		
		$('[name=gs_guidance]').summernote({
			placeholder: '구매 가이드 라인을 입력하세요.',
			tabsize: 2,
			height: 400
		});
	})	
	
/* 함수 *********************************************************************************************************** */

</script>
</html>