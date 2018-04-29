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
<link rel="stylesheet" type="text/css" href="/css/myPage/emoneyCashOut.css">
<script type="text/javascript" src="/js/myPage/emoneyCashOut.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">emoney-통장</a> &gt; <b>e-money출금하기</b>
						</div>
						<div id="v5ContentsWrap">
							<!--안내 시작-->
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">e-money 출금 안내</span>
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
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">e-money 출금 정보</span>
							</div>
							<form id="emoneyCashOutForm">
								<input type="hidden" name="co_bank" value="${not empty sessionScope.rb_member.MB_BANK_NAME ? sessionScope.rb_member.MB_BANK_NAME : '' }">
								<input type="hidden" name="co_account" value="${not empty sessionScope.rb_member.MB_BANK_NO ? sessionScope.rb_member.MB_BANK_NO : '' }">
								<input type="hidden" name="co_account_name" value="${not empty sessionScope.rb_member.MB_BANK_OWNER ? sessionScope.rb_member.MB_BANK_OWNER : '' }">
								
								<table class="common_table_normal">
									<colgroup>
										<col width="200px">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th><span class="span_default">현금성e-money 잔액</span></th>
											<td class="center" id="mbCashAmount_td" cash-amount="${sessionScope.rb_member.MB_CASH }"><fmt:formatNumber>${sessionScope.rb_member.MB_CASH }</fmt:formatNumber></td>
										</tr>
	
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">e-money 출금금액</span></th>
											<td class="center">
												<input name="co_amount" type="text" size="15" maxlength="10" style="text-align: right;"> 원
											</td>
										</tr>
										<tr>
											<th><span class="span_default">출금 후 현금성e-money 잔액</span></th>
											<td class="center">
												<font color="#cc0000"><b><span id="remain_co_amount"><fmt:formatNumber>${sessionScope.rb_member.MB_CASH }</fmt:formatNumber></span>원</b></font>
											</td>
										</tr>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">출금계좌정보</span></th>
											<c:choose>
												<c:when test="${(not empty sessionScope.rb_member.MB_BANK_NAME) and (not empty sessionScope.rb_member.MB_BANK_NO) and (not empty sessionScope.rb_member.MB_BANK_OWNER) }">
													<td class="center">
														<b>${sessionScope.rb_member.MB_BANK_NAME }</b>&nbsp;
														<b>${sessionScope.rb_member.MB_BANK_NO }</b>&nbsp;
														<b>${sessionScope.rb_member.MB_BANK_OWNER }</b> &nbsp;
														<a href="/myPage/memberInfoUpdate.do">
															<font color="#0000cc"><u><b>출금계좌정보변경</b></u></font>
														</a>
													</td>
												</c:when>
												<c:otherwise>
													<td class="center">계좌정보가 입력되지 않았습니다.&nbsp;
														<a href="/myPage/memberInfoUpdate.do">
															<font color="#0000cc"><u><b>출금계좌정보변경</b></u></font>
														</a>
													</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</tbody>
								</table>
							</form>
							<div class="submit_button_area">
								<button type="button" class="button_submit" onclick="cashOut();">e-money 출금</button>
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