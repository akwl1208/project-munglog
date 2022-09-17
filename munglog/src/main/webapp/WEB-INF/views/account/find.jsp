<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아이디 비번 찾기</title>
<!-- css ************************************************************ -->
	<style>
		*{padding: 0; margin: 0; color: #52443b;}
		a{text-decoration: none; color: #52443b;}
		a:hover{text-decoration: none; color: #a04c00; font-weight: bold;}
		.container{
			border: 2px solid #52443b; border-radius: 10px;
			box-shadow: 3px 3px 10px 0 rgba(73, 67, 60, 0.2);
			padding: 0 30px; width: 500px; min-width: 500px;
		}
		.box-find{margin: 0 auto; padding: 54px 0;}
		.box-logo{
			text-align: center; font-weight: 900; font-size: 24px;
			padding: 10px 0;
		}
		.box-logo .fa-paw{margin-right: 6px;}
		.box-message{
			font-size: 12px; text-align: center;
		}
		.box-tab{margin: 30px 0 0;}
		.box-tab .nav-item{
			width: 218px; text-align: center;
		}
		.box-tab .nav-item .nav-link.active{
			background-color: #a04c00; font-weight: bold; color: #fff7ed;
		}
		.box-input,
		.box-result{padding: 34px 0 0;}
		.box-input .form-group{margin-bottom: 34px;}
		.box-inform{
			background-color: #fff7ed;; text-align: center; margin: 0 0 34px;
			padding: 20px; border-radius: 5px;
		}
		.error{
			color: #fb9600; font-size: 12px;
		}
		.btn{
			font-size: 18px; font-weight: bold; padding: 5px 0;
			border: none; background-color: #fb9600; margin-bottom: 10px;
		}
		.btn:hover{color:#fff7ed;}
	</style>
</head>
<!-- html ************************************************************ -->
<body>
	<div style="display: flex; align-items: center; justify-content: center; min-height: 100vh;">
		<div class="container">
			<!-- box-find -------------------------------------------------------- -->
			<div class="box-find">
				<!-- box-title -------------------------------------------------------- -->
				<div class="box-title">
					<!-- 로고 -------------------------------------------------------- -->
					<div class="box-logo">
						<a href="<c:url value="/"></c:url>"><i class="fa-solid fa-paw"></i><span>멍멍일지</span></a>
					</div>
					<!-- 안내문구 -------------------------------------------------------- -->
					<div class="box-message">회원가입 시 입력한 정보로 아이디/비밀번호를 찾으세요.</div>
				</div>
				<!-- box-tab -------------------------------------------------------- -->
				<div class="box-tab" >
					<!-- 탭 메뉴 -------------------------------------------------------- -->
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#id">아이디 찾기</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#pw">비밀번호 찾기</a>
						</li>
					</ul>
					<!-- 탭 내용 -------------------------------------------------------- -->
					<div class="tab-content">
						<!-- 아이디 찾기 -------------------------------------------------------- -->
						<div id="id" class="tab-pane active">
							<!-- box-input -------------------------------------------------------- -->
							<div class="box-input">
								<!-- 이름 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>이름</label>
									<input type="text" class="form-control" name="mb_name" id="mb_name">
								</div>
								<!-- 핸드폰번호 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>핸드폰번호</label>
									<input type="text" class="form-control" name="mb_phone" id="mb_phone">
									<label class="error" for="#mb_phone"></label>
								</div>
								<!-- 아이디찾기 버튼 -------------------------------------------------------- -->
								<button type="button" class="btn btn-id col-12">아이디 찾기</button>
							</div>
							<!-- box-result -------------------------------------------------------- -->	
							<div class="box-result" style="display: none;">
								<!-- 결과 알려줌 -------------------------------------------------------- -->
								<div class="box-inform">
									<span>회원님의 아이디는 <b>****@naver.com</b> 입니다.</span>
								</div>
								<!-- 버튼 -------------------------------------------------------- -->
								<button class="btn btn-login col-12">로그인</button>
							</div>
						</div>
						<!-- 비밀번호 찾기 -------------------------------------------------------- -->
						<div id="pw" class="tab-pane fade">
							<!-- box-input -------------------------------------------------------- -->
							<div class="box-input">
								<!-- 이메일 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>이메일</label>
									<input type="text" class="form-control" name="mb_email" id="mb_email">
									<label class="error" for="#mb_email"></label>
								</div>
								<!-- 이름 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>이름</label>
									<input type="text" class="form-control" name="mb_name" id="mb_name">
								</div>
								<!-- 핸드폰번호 입력 -------------------------------------------------------- -->
								<div class="form-group">
									<label>핸드폰번호</label>
									<input type="text" class="form-control" name="mb_phone" id="mb_phone">
									<label class="error" for="#mb_phone"></label>
								</div>
								<!-- 비밀번호 찾기 -------------------------------------------------------- -->
								<button type="button" class="btn btn-pw col-12">비밀번호 찾기</button>
							</div>
							<!-- box-result -------------------------------------------------------- -->	
							<div class="box-result" style="display: none;">
								<!-- 결과 알려줌 -------------------------------------------------------- -->
								<div class="box-inform">
									<span>이메일로 임시비밀번호를 보냈습니다. 확인해주세요.</span>
								</div>
								<!-- 버튼 -------------------------------------------------------- -->
								<button class="btn btn-login col-12">로그인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- script **************************************************************************** -->
<script>
	$(function(){
	/* 이벤트 **************************************************************************** */	
	let type = '${type}';
	$('[href="#'+type+'"]').click();
	})
</script>
</body>
</html>