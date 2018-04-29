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
<link rel="stylesheet" type="text/css" href="/css/auth/joinComplete.css">
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
					
					<div id="v5ContentsWrap">
						<div class="memJoinSuccess">
							<div>
								<img
									src="http://211.43.195.137/image/v6/elements/member/joinSuccess/img_normalMemJoinSuccess2.png"
									alt="도매꾹의 회원이 되신 것을 축하드립니다." title="도매꾹의 회원이 되신 것을 축하드립니다."
									usemap="#joinSuccessBtn">
								<map name="joinSuccessBtn">
									<area shape="rect" href="/main/" coords="90,551,367,612"
										alt="다음에 할래요" title="다음에 할래요">
									<area shape="rect"
										href="/main/member/mem_formRegularCertificate.php"
										coords="379,551,657,612" alt="정회원 가입하기" title="정회원 가입하기">
								</map>
							</div>
						</div>
	
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>