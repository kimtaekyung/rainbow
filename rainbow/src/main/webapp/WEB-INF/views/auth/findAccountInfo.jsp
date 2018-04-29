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
<link rel="stylesheet" type="text/css" href="/css/auth/findAccountInfo.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/auth/findAccountInfo.js"></script>
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
						<span class="common_lable_span">아이디 찾기</span>
					</div>
					<ul id="loginMngTabUl">
						<li class="loginMngTabUl selected" onClick="javascript:location.href='/auth/findAccountInfo.do'">아이디 찾기</li>
						<li class="loginMngTabUl" onClick="javascript:location.href='/auth/findPasswordInfo.do'">비밀번호 찾기</li>
					</ul>
					<table class="common_table_max">
						<tbody>
							<tr>
								<td>
									<span class="span_default"><input type="radio" name="findType" class="findType_input" id="findAccountType_1"><label for="findAccountType_1" class="lable_default">본인인증 후 찾기</label></span>
									<span class="span_default"><input type="radio" name="findType" class="findType_input" checked="checked" id="findAccountType_2"><label for="findAccountType_2" class="lable_default">등록된 휴대폰으로 찾기</label></span>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="common_table_max findAccountType_tr" id="findAccountType_1_view" style="display: none;">
						<tbody>
							<tr class="findAccountType_tr">
								<td class="findAccountType center" >
									<button type="button" class="button_submit" onclick="defaultAlert('준비중입니다.');">인증하기</button>
									<p class="desc"><br>회원님의 명의로 등록된 휴대폰으로 본인확인을 진행합니다.</p>
								</td>
							</tr>
							<!-- 인증후 -->
							<tr id="afterCertArea">
								<td class="center">
									<h1>회원님의 계정 아이디(이메일)는 <b style="color:#e5004f;">nerobong2@gmail.com</b> 입니다.</h1>
									<br><br><br><br>
									<button type="button" class="button_submit" onclick="">로그인</button>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="common_table_max findAccountType_tr" id="findAccountType_2_view">
						<tbody>
							<tr class="findAccountType_tr">
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">이름</span></th>
								<td colspan="3">
									<input type="text" name="mb_name" maxlength="4" onfocus="setDefaultInputMent('find_mb_name','가입된 계정에 이름을 입력 해주세요.');">
									<p id="find_mb_name" class="desc">가입된 계정에 이름을 입력 해주세요.</p>
								</td>
							</tr>
							<tr class="findAccountType_tr" id="findAccountType_2_view">
								<th><span class="span_default">등록한 휴대폰 번호</span></th>
								<td colspan="3">
									<select class="select_default" id="mtelno1" onfocus="setDefaultInputMent('find_mb_hp_ment_p','휴대폰번호 를 입력 하세요.');"> 
									     <option value="010" selected="">010</option> 
									     <option value="011">011</option> 
									     <option value="016">016</option> 
									     <option value="017">017</option> 
									     <option value="018">018</option> 
									     <option value="019">019</option> 
								    </select>
								    <span class="span_default">-</span>
								    <input type="text" class="numberData" maxlength="4" id="mtelno2" onfocus="setDefaultInputMent('find_mb_hp_ment_p','휴대폰번호 를 입력 하세요.');">
								    <span class="span_default">-</span>
								    <input type="text" class="numberData" maxlength="4" id="mtelno3" onfocus="setDefaultInputMent('find_mb_hp_ment_p','휴대폰번호 를 입력 하세요.');">
									<input type="hidden" name="mb_hp">
									<button type="button" class="button_default">휴대폰으로 받기</button>
									<p class="desc" id="find_mb_hp_ment_p">휴대폰번호 를 입력 하세요.</p>
								</td>
							</tr>
							<tr>
								<th><span class="span_default">이메일</span></th>
								<td colspan="3">
									<input type="text" id="mail1" maxlength="40" onfocus="setDefaultInputMent('find_mb_email_ment_p','이메일을 입력 하세요.');">
									<fontface="arial">@</fontface="arial">
									<input type="text" id="mail2" maxlength="40" onfocus="setDefaultInputMent('find_mb_email_ment_p','이메일을 입력 하세요.');">
									<select class="select_default" id="mail3" onchange="setMailForm(this);" onfocus="setDefaultInputMent('find_mb_email_ment_p','이메일을 입력 하세요.');">
										<option value="" selected="selected">직접입력</option>
										<option value="naver.com">네이버</option>
										<option value="gmail.com">구글메일</option>
										<option value="hanmail.net">한메일</option>
										<option value="hotmail.com">핫메일</option>
										<option value="chollian.net">천리안</option>
										<option value="hitel.net">하이텔</option>
										<option value="dreamwiz.com">드림위즈</option>
										<option value="yahoo.co.kr">야후</option>
										<option value="lycos.co.kr">라이코스</option>
										<option value="netian.com">네띠앙</option>
										<option value="korea.com">코리아닷컴</option>
										<option value="orgio.net">오르지오</option>
										<option value="empal.com">엠파스(엠팔)</option>
										<option value="hanafos.com">하나포스</option>
									</select>
									<input type="hidden" name="mb_email">
									<button type="button" class="button_default">이메일로 받기</button>
									<p class="desc" id="find_mb_email_ment_p">휴대폰번호 를 입력 하세요.</p>
								</td>
							</tr>
							<tr>
								<th><img src="/images/auth/ico_must.gif"><span class="span_default">인증번호</span></th>
								<td colspan="3">
									<input type="text" class="numberData" maxlength="6" onfocus="setDefaultInputMent('find_auth_code','인증번호(6자리)를 입력 하세요');"><span class="span_default">남은 시간 2분 48 초</span>
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
							<!-- 인증후 -->
							<tr id="afterCertArea">
								<td class="center" colspan="4">
									<h1>회원님의 계정 아이디(이메일)는 <b style="color:#e5004f;">nerobong2@gmail.com</b> 입니다.</h1>
									<br><br><br><br>
									<button type="button" class="button_submit" onclick="">로그인</button>
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