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
<link rel="stylesheet" type="text/css" href="/css/myPage/memberLeave.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/myPage/memberLeave.js"></script>

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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">개인정보관리</a> &gt; <b>회원탈퇴신청</b>
						</div>
						<div id="v5ContentsWrap">
							<!--안내 시작-->
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">회원 탈퇴 안내</span>
							</div>
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td class="left">
											<p class="textLimit">설명설명<b>설명설명</b>설명설명</p>
											<p class="textLimit">설명설명설명설명설명</p>
											<p class="textLimit">설명설명설명설명설명</p>
											<p class="textLimit">설명설명설명설명설명</p>
											<p class="textLimit">ㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㅇㄴㅁㅇ</p>
											<p class="textLimit">e-money충전이란 내 e-money통장에 돈을 보관하는 것이며, e-money라는 상품을 구입하는 것이 아닙니다</p>
											<p class="textLimit">ㅇㅁㄴㅇㄴㅁㅇㅁㅇ</p>
											<p class="textLimit">e-money로 상품을 구입한 경우 카드매입전표나 현금영수증 등이 자동발급됩니다dadadasdadaadadsadadadasdasdadsadsadadasdasdasdasdasdsadsadasdasdsa (현지에서 직접 상품이 배송되는 해외거래건은 제외)</p>
										</td>
									</tr>
								</tbody>
							</table>
							<!--안내 종료-->
							<!--폼 시작-->
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">회원 탈퇴 신청</span>
							</div>
							<form id="memberLeaveForm">
								<input type="hidden" name="mb_password">							
								<table class="common_table_normal">
									<tbody>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">회원아이디</span>
											</th>
											<td colspan="3"><span class="span_default"><b>${sessionScope.rb_member.MB_ID}</b></span></td>
										</tr>
										<!--비번-->
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">비밀번호</span>
											</th>
											<td colspan="3"><input type="password" maxlength="20" class="input" id="mb_password_tmp"></td>
										</tr>
										<!--탈퇴사유-->
										<tr>
											<th>
												<span class="span_default">탈퇴사유</span>
											</th>
											<td colspan="3">
												<textarea placeholder="200자 이하 입력" name="mb_leave_reason" maxlength="200" style="width: 400px;height: 100px;"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							<!--폼 종료-->
							</form>
							<div class="submit_button_area">
								<button type="button" class="button_submit" onclick="memberLeave();">회원 탈퇴</button>
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