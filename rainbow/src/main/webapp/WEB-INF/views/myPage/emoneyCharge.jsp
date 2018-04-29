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
<link rel="stylesheet" type="text/css" href="/css/myPage/emoneyCharge.css">
<script type="text/javascript" src="/js/myPage/emoneyCharge.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">emoney-통장</a> &gt; <b>e-money충전하기</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">e-money 충전</span>
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
							
							<!--금액안내 및 카드수수료계산기 시작-->
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">금액 입력</span>
							</div>
	
							<table class="common_table_normal">
								<tbody>
									<tr>
										<th>현금성 e-money</th>
										<th>카드성 e-money</th>
										<th>총 보유 e-money</th>
										<th>e-money충전금액</th>
										<th>총 e-money합계</th>
									</tr>	
									<tr>
										<td class="right"><b id="mb_cash_b"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH }" pattern="#,###" />원</b></td>
										<td class="right"><b id="mb_cash_card_b"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH_CARD }" pattern="#,###" />원</b></td>
										<td class="right"><b id="mb_cash_total_b" cash-amount="${sessionScope.rb_member.MB_CASH  + sessionScope.rb_member.MB_CASH_CARD}"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH  + sessionScope.rb_member.MB_CASH_CARD}" pattern="#,###" />원</b></td>
										<td class="right"><font color="#0000cc"><b><span id="cash_amount_sapn">0</span>원</b></font></td>
										<td class="right"><font color="#cc0000"><b><span id="cash_amount_sapn_total"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH  + sessionScope.rb_member.MB_CASH_CARD}" pattern="#,###" /></span>원</b></font></td>
									</tr>
								</tbody>
							</table>
							<form id="emoneyChargeForm">
								<input type="hidden" name="cc_pay_name">
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td class="center">
												<b>e-money 충전금액</b>
												<input name="cc_amount" type="text" size="25" maxlength="11"> 원
												<input name="cc_pay_type" type="radio" value="1" checked="checked"> 무통장 입금
												<input name="cc_pay_type" type="radio" value="2"> 신용카드 
												<p class="desc"><b>(e-money는 최소 10,000원 이상, 최대 100,000,000 원 이하로 충전 할 수 있습니다)</b></p>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
							<div class="submit_button_area">
								<button type="button" class="button_submit" onclick="chargeMemberCash();">e-money 충전</button>
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