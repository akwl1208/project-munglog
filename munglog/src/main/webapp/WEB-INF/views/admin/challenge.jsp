<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	.main .box-content .box-register .box-thumb{
		border: 1px solid #dfe0df;
		width: 170px; height: 170px; text-align: center;
	}
	.main .box-content .box-register .box-thumb:hover .btn-select{color: #fb9600; cursor:pointer;}
	.main .box-content .box-register .fa-square-plus{line-height: 170px;}
	.main .box-content .box-register .box-detail .error{font-size: 12px; color: #fb9600;}
	.main .box-content .box-register .btn-register{
		float: right; background-color: #a04c00; margin-left: 10px;
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
	.main .box-content .box-list .item-delete:hover .btn-delete{color: fb9600; cursor:pointer;}
</style>
</head>
<!-- html ************************************************************************************************************ -->
<body>
<!-- 제목 -------------------------------------------------------- -->
<div class="box-title">
	<i class="fa-solid fa-paw"></i><span>챌린지 관리</span>
	<div class="box-message">챌린지를 등록하고 관리하세요.</div>
</div>			
<div class="box-content">
	<div class="box-register">
		<div class="clearfix">					
			<div class="box-thumb float-left">
				<div class="btn-select" width="100%" height="100%"><i class="fa-solid fa-square-plus"></i></div>
				<input type="file" name="file" style="display: none;" accept="image/jpg, image/jpeg, image/png, image/gif">
				<img class="preview" width="100%" height="100%" style="display: none;">
			</div>						
			<div class="box-detail float-right" style="width:calc(100% - 170px - 20px)">
				<div class="form-group">
					<input type="text" class="clYear form-control" placeholder="년도">			
				</div>
				<div class="form-group">
					<input type="text" class="clMonth form-control" placeholder="월">
				</div>
				<div class="form-group">
					<textarea class="clTheme form-control" rows="2" style="resize:none" placeholder="챌린지 주제를 100자 이하로 작성해주세요."></textarea>
				</div>
				<div class="error"></div>
			</div>
		</div>
		<button type="button" class="btn-register mb-4">챌린지 등록</button>
	</div>
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
			<tbody>
				<tr>
					<td class="item-thumb">
						<div class="thumb">
							<img class="cl_thumb" src="">
						</div>
					</td>
					<td class="cl_year">2022</td>
					<td class="cl_month">9</td>
					<td class="item-theme">
						<div class="cl_theme">단풍과 함께 강아지 사진을 찍어주세요.</div>
					</td>
					<td class="item-modify"><i class="btn-modify fa-solid fa-pen-to-square"></i></td>
					<td class="item-delete"><i class="btn-delete fa-solid fa-trash"></i></td>
				</tr>
			</tbody>
		</table>
	</div>
	<ul class="pagination justify-content-center mt-5">
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">Previous</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">1</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">2</a></li>
		<li class="page-item"><a class="page-link text-muted" href="javascript:void(0);">Next</a></li>
	</ul>
</div>
</body>
</html>