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
<link rel="stylesheet" type="text/css" href="/css/common/content.css">
<link rel="stylesheet" type="text/css" href="/css/myPage/memberPassWordConfirm.css">
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
					<%@include file="/WEB-INF/views/common/myPageLeftMenu.jsp"%>
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main/">HOME</a> &gt; <a
								href="/main/myPage/my_pageMain.php">마이도매꾹</a> &gt; <b>로그인관리</b>
						</div>
						<div id="v5ContentsWrap">
							<div id="">
								<form id="confirmPwdFrm" name="confirmPwdFrm"
									onsubmit="return false;">
									<div id="confirmPwdWrap">
										<h2>
											<img
												src="http://211.43.195.137/image/myPage/login/img_titleConfirmPwd.png"
												alt="비밀번호확인 타이틀" title="비밀번호확인 타이틀">
										</h2>
	
										<img
											src="http://211.43.195.137/image/myPage/login/img_descConfirmPwd.png"
											alt="비밀번호확인 설명" title="비밀번호확인 설명"
											style="margin: 15px 0 30px 0;">
	
										<div>
											<span class="subTitle">비밀번호</span> <input type="password"
												name="pass" value="" class="input"
												style="width: 150px; margin: 0 10px 0 10px;"
												onkeydown="chkEnter();"> <img
												src="http://211.43.195.137/image/myPage/login/img_btnLogin.png"
												alt="로그인" title="로그인" style="cursor: pointer;"
												onclick="loginManageConfirmPwd();">
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="gClearBoth"></div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>