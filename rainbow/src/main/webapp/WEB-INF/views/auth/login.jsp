<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>알 샵</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="p3p" content="">
<meta http-equiv="imagetoolbar" content="no">
<meta http-equiv="pics-label" content="">
<meta name="generator" content="">
<meta name="author" content="">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="classification" content="">
<meta name="robots" content="">
<meta name="naver-site-verification" content="">
<meta name="verify-v1" content="">
<meta name="y_key" content="">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=1560">
<link rel="shortcut icon" href="">
<meta name="msapplication-config" content="">
<meta name="theme-color" content="">
<!-- CSS -->
<!-- 공통 -->
<%@include file="/WEB-INF/views/common/include.jsp"%>
<!-- 공통 -->
<!-- 메인 -->
<link rel="stylesheet" type="text/css" href="/css/auth/login.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/auth/login.js"></script>
<!-- 메인 -->
<!-- CSS 끝 -->
</head>
	<body>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					<input type="hidden" id="returnUrl" value="${returnUrl}">
					<form id="memberLoginForm">
						<div id="loginBox">
							<input type="hidden" name="mb_password">
							<div id="loginPageLogo_div">
								<img id=""src="/images/common/header/logo.png">
							</div>
							<ul>
								<li>
									<input value="" type="text" name="mb_id" placeholder="아이디" onkeypress="if(event.keyCode==13) {login(); return false;}">
								</li>
								<li>
									<input value="" type="password" id="mb_password_tmp" placeholder="비밀번호" onkeypress="if(event.keyCode==13) {login(); return false;}">
								</li>
								<li>
									<button type="button" id="loginBtn" onclick="javascript:login();">로그인</button>
								</li>
								<li>
									<button type="button" id="joinBtn" onclick="location.href='/auth/agreement.do'">회원가입</button>
								</li>
								<li>
									<div id="save_div">
										<label>
											<input type="checkbox" id="save" checked>아이디 저장
										</label>
									</div>	
								</li>
							</ul>
							<ul id="loginBoxLink_ul">
								<li><a href="/auth/findAccountInfo.do">아이디찾기</a></li>
								<li><a href="/auth/findPasswordInfo.do">비밀번호찾기</a></li>
								<li><a href="/main/questionAndAnswerList.do?search_word=로그인">로그인에 문제가 있나요</a></li>
							</ul>
						</div>
					</form>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>