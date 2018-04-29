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
<link rel="stylesheet" type="text/css" href="/css/auth/findPasswordInfo.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/auth/findPasswordInfo.js"></script>
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
						<span class="common_lable_span">패스워드 찾기</span>
					</div>
					<ul id="loginMngTabUl">
						<li class="loginMngTabUl" onClick="javascript:location.href='/auth/findAccountInfo.do'">아이디 찾기</li>
						<li class="loginMngTabUl selected" onClick="javascript:location.href='/auth/findPasswordInfo.do'">비밀번호 찾기</li>
					</ul>
					<table class="common_table_max">
						<tbody>
							<tr class="findAccountType_tr">
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">아이디</span></th>
								<td colspan="3">
									<input type="text" name="mb_id" maxlength="20" onfocus="setDefaultInputMent('find_mb_id','아이디를 입력해주세요.');">
									<span class="span_default"><input type="radio" name="findType" class="findType_input" id="findAccountType_1"><label for="findAccountType_1" class="lable_default">등록된 휴대폰</label></span>
									<span class="span_default"><input type="radio" name="findType" class="findType_input" checked="checked" id="findAccountType_2"><label for="findAccountType_2" class="lable_default">등록된 이메일</label></span>
									<span><button type="button" class="button_default" onclick="defaultAlert('준비중입니다.');">인증번호 받기</button></span>
									<p id="find_mb_id" class="desc">아이디를 입력해주세요.</p>
								</td>
							</tr>
							<tr>
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">인증번호</span></th>
								<td colspan="3">
									<input type="text" class="numberData" maxlength="6" onfocus="setDefaultInputMent('find_auth_code','이메일을 입력 하세요.');"><span class="span_default">남은 시간 2분 48 초</span>
									<p class="desc" id="find_auth_code">인증번호(6자리)를 입력 하세요</p>
								</td>
							</tr>
							<!-- 인증전 -->
							<tr id="beforeCertArea">
								<td class="center" colspan="4">
									<button type="button" class="button_submit" onclick="">인증하기</button>
									<p class="desc"><br>회원가입시 등록된 휴대폰으로 본인확인을 진행합니다.</p>
								</td>
							</tr>
						</tbody>
					</table>
					<table id="afterCertArea" class="common_table_max">
						<tbody>
							<tr>
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">새로운 비밀번호</span></th>
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
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>