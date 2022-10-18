<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>aside-메인홈</title>
<style>
	/*aside -------------------------------------------------------------------------------------- */
	.side-main .box-login,
	.side-main .box-account{
		border: 1px solid #52443b; border-radius: 5px;
		padding: 20px; background-color: #fff7ed;
	}
	.side-main .box-login .btn-login{
		font-size: 18px; font-weight: bold; padding: 5px 0;
		width: 100%; display: inline-block; border-radius: 5px;
		border: none; background-color: #fb9600; color:#fff7ed;
		text-align: center; margin: 20px 0;
	}
	.side-main .box-login .btn-login:hover{background-color:#ffa31c;}
	.side-main .box-login .box-footer,
	.side-main .box-account .box-service{font-size: 12px;}
	.side-main .box-login .box-footer>div,
	.side-main .box-account .box-user>a,
	.side-main .box-account .box-user>div{display: inline-block;}
	.side-main .box-login .box-footer>div>a .fa-solid{line-height: 16px;}
	.side-main .box-login .box-footer>div>a:hover,
	.side-main .box-account .box-user .link-profile-set:hover .fa-solid,
	.side-main .box-account .box-point .mypoint .fa-solid,
	.side-main .box-account .box-service>a:hover,
	.side-main .box-account .box-service>a:hover .fa-solid{color: #fb9600;}
	.side-main .box-login .box-footer .box-find .link-find-pw::before{
		display: inline-block; width: 2px; height: 2px;
	  	margin: 0 6px; content: ""; vertical-align: 3px;
	  	background-color: #d8d8d8;
	}
	.side-main .box-account .box-user{margin-bottom: 10px;}
	.side-main .box-account .box-user .thumb img{
		border-radius: 50px; width: 60px; height: 60px; margin-left: 10px;
	}
	.side-main .box-account .box-user .nickname{
		height: 60px; line-height: 60px; padding-left: 10px;
		font-weight: bold; overflow: hidden; text-overflow: ellipsis;
	}
	.side-main .box-account .box-user .link-profile-set .fa-solid{line-height: 60px;}
	.side-main .box-account .box-point{
		font-size: 18px; font-weight: bold; border-top: 1px solid #d8d8d8;
		padding: 20px; border-bottom: 1px solid #d8d8d8;
	}
	.side-main .box-account .box-service{padding-top: 20px;}
	.side-main .box-account .box-service .fa-solid{font-size: 24px;}
</style>
</head>
<body>
<c:if test="${user==null}">
	<div class="box-login">
		<div class="box-header">
			<small>만나서 반갑습니다. 멍멍일지입니다.</small>
		</div>
		<a href="<c:url value="/account/login"></c:url>" class="btn-login">로그인</a>
		<div class="box-footer clearfix">
			<div class="box-find float-left">
				<a href="<c:url value="/account/find?type=id"></c:url>" class="link-find-id"><i class="fa-solid fa-lock mr-1"></i>아이디</a>
				<a href="<c:url value="/account/find?type=pw"></c:url>" class="link-find-pw">비밀번호찾기</a>
			</div>
			<div class="box-signup float-right">
				<a href="<c:url value="/account/signup"></c:url>" class="link-signup"><i class="fa-solid fa-dog mr-1"></i>회원가입</a>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${user!=null}">
	<div class="box-account">
		<div class="box-profile">
			<div class="box-user d-flex" style="width: 100%;">
				<div class="thumb"><img src="<c:url value="${user.mb_profile_url}"></c:url>"></div>
				<div class="nickname"><c:url value="${user.mb_nickname}"></c:url></div>
				<a href ="<c:url value="/mypage/modifyProfile"></c:url>" class="link-profile-set ml-2"><i class="fa-solid fa-user-pen mr-1"></i></a>
			</div>
		</div>
		<div class="box-point clearfix pl-3 pr-3">
			<a href="#" class="link-point">
				<span class="mypoint float-left"><i class="fa-solid fa-bone mr-2"></i>내 멍멍포인트</span>
				<span class="float-right"><span class="mypoint-amount" style="color: #fb9600;">${user.availablePoint}</span><span class="pl-1">P</span></span>
			</a>
		</div>
		<div class="box-service d-flex">
			<a href="<c:url value="/log/mylog/${user.mb_num}"></c:url>" class="link-mylog text-center flex-fill">
				<i class="fa-solid fa-book mb-2 " style="display: block;"></i>나의 일지
			</a>
			<a href="<c:url value="/mypage"></c:url>" class="link-mypage text-center flex-fill">
				<i class="fa-solid fa-house mb-2" style="display: block;"></i>마이페이지
			</a>
			<c:if test="${user.mb_level == 'A' ||	user.mb_level == 'S'}">
				<a href="<c:url value="/admin"></c:url>" class="link-mypage text-center flex-fill">
					<i class="fa-solid fa-screwdriver-wrench mb-2" style="display: block;"></i>관리자페이지
				</a>
			</c:if>
		</div>
	</div>
</c:if>
</body>
</html>