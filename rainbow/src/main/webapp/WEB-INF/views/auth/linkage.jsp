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
<link rel="stylesheet" type="text/css" href="/css/auth/linkage.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/auth/linkage.js"></script>
<!-- 메인 -->
<!-- CSS 끝 -->
</head>
	<body>
		<!-- 주소 찾기 검색용 -->
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					<div class="common_lable_div">
						<img class="common_lable_img" src="/images/common/ico_common2.gif">
						<span class="common_lable_span">알샵에서 사용하실 비밀번호를 입력하세요</span>
					</div>
					<table id="afterCertArea" class="common_table_max">
						<tbody>
							<tr>
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">알샵 비밀번호</span></th>
								<td class="center" colspan="3">
									<input type="password" id="mb_password_tmp" maxlength="20" onblur="memberPasswordCheck(this);" onfocus="setDefaultInputMent('join_mb_password_ment_p','비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.');">
									<p class="desc" id="join_mb_password_ment_p">비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.</p>
								</td>
							
							</tr>						
							<tr>
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">비밀번호 확인</span></th>
								<td class="center" colspan="3">
									<input type="password" id="mb_password_tmp_confirm" maxlength="20" onblur="memberPasswordCheck(this);" onfocus="setDefaultInputMent('join_mb_password_ment_p','비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.');">
									<p class="desc" id="join_mb_password_ment_p">비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.</p>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="submit_button_area">
						<!-- <input type="image" src="/images/auth/btn_memberRegisterOk.gif" border="0" alt="회원가입을 합니다" onclick="javascript:memberJoin();"> -->
						<button type="button" class="button_submit">입력완료</button>
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>