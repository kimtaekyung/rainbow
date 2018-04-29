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
<link rel="stylesheet" type="text/css" href="/css/myPage/memberCertificationManagement.css">
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">개인정보관리</a> &gt; <b>나의인증관리</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">나의 인증 관리</span>
							</div>
							<div id="cert_state_desc" style="text-align: center;">
								<p><b>김태경은(일반회원)</b> 님 본인인증이 완료되지 않았습니다. 인증을 완료 해주세요.</p>
								<p><b>김태경은(일반회원)</b> 님은 <b>본인인증</b> 이 완료된 회원 입니다.</p>
								<p><b>김태경은(일반회원)</b> 님은 <b>사업자인증</b> 이 완료된 회원 입니다.</p>
							</div>
							
							<div id="cert_icon_area_div">
								<ul>
									<li>
										<div>
											<img class="certType" src="/images/myPage/phoneCert.png">
											<img class="certOk" src="/images/myPage/certOk.png">
										</div>
									</li>
									<li>
										<div>
											<img class="certType" src="/images/myPage/emailCert.png">
											<img class="certOk" src="/images/myPage/certOk.png" style="display: none;">
										</div>
									</li>
									<li>
										<div>
											<img class="certType" src="/images/myPage/bizCert.png">
											<img class="certOk" src="/images/myPage/certOk.png" style="display: none;">
										</div>
									</li>
								</ul>
							</div>
							<table class="common_table_normal">
								<tbody>
									<tr>
										<th><span class="span_default">휴대폰 인증</span></th>
										<td colspan="3">
											<input type="text" class="numberData" maxlength="3" id="mtelno1" size="3" value="010" readonly="readonly">
										    <span class="span_default">-</span>
										    <input type="text" class="numberData" maxlength="4" id="mtelno2" size="4" value="5117" readonly="readonly">
										    <span class="span_default">-</span>
										    <input type="text" class="numberData" maxlength="4" id="mtelno3" size="4" value="4770" readonly="readonly">
											<button type="button" class="button_default">인증번호 받기</button>
											<br>
											<input type="text" class="numberData" maxlength="6" onfocus="setDefaultInputMent('find_auth_code','인증번호(6자리)를 입력 하세요');"><button type="button" class="button_default">인증</button><span class="span_default">남은 시간 2분 48 초</span>
											<p class="desc" id="find_auth_code">휴대폰 으로 발송 된 인증번호(6자리)를 입력 하세요</p>
										</td>
									</tr>
									<tr>
										<th><span class="span_default">이메일 인증</span></th>
										<td colspan="3">
											<input type="text" id="mail1" maxlength="40" value="nerobong2" readonly="readonly">
											<fontface="arial">@</fontface="arial">
											<input type="text" id="mail2" maxlength="40" value="gmail.com" readonly="readonly">
											<button type="button" class="button_default">인증번호 받기</button>
											<br>
											<input type="text" class="numberData" maxlength="6" onfocus="setDefaultInputMent('find_auth_code','인증번호(6자리)를 입력 하세요');"><button type="button" class="button_default">인증</button><span class="span_default">남은 시간 2분 48 초</span>
											<p class="desc" id="find_auth_code">이메일로 발송 된 인증번호(6자리)를 입력 하세요</p>
										</td>
									</tr>
									<tr>
										<th><span class="span_default">사업자 인증</span></th>
										<td colspan="3">
											<button type="button" class="button_default" onclick="location.href='/myPage/licenseeManagement.do'">사업자 인증 하러 가기</button>
											<p class="desc">사업자 인증을 하시면 세금계산서 및 영수증 발급이 용이 합니다.</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>