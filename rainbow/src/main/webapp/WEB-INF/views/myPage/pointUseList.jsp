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
<link rel="stylesheet" type="text/css" href="/css/myPage/pointUseList.css">
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">포인트</a> &gt; <b>포인트적립/사용내역</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">포인트 안내</span>
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
							<div class="excel_area_div">
								<div class="verticalMiddleParent">
									<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
									<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀다운로드</a>
								</div>
							</div>
							<table class="common_table_normal">
								<tbody>
									<tr>
										<th>등록일</th>
										<td colspan="4">
											<select class="select_default" name="quick" onchange="javascript:changeQuickDate(this.value,'emoneyCashOutListForm','sch_sdate','sch_edate');">
												<option value="" selected="">빠른선택</option>
												<option value="day">오늘</option>
												<option value="week">1주일</option>
												<option value="month">1개월</option>
												<option value="threeMonth">3개월</option>
												<option value="sixMonth">6개월</option>
												<option value="year">1년</option>
											</select>
											<input type="text" name="sch_sdate" value="2018-02-15" class="datepicker input_default hasDatepicker" id="dp1520959367405">
											<span class="span_default"> ~ </span>  
											<input type="text" name="sch_edate" value="2018-03-14" class="datepicker input_default hasDatepicker" id="dp1520959367406">
											<button class="button_default" type="button" onclick="searchFormSubmit('emoneyCashOutListForm');">찾기</button>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>총 <b>8</b>건 의 출금 신청 내역이 있습니다 소멸예정</td>
									</tr>
								</tbody>
							</table>
	
							<table class="common_table_normal">
								<colgroup>
									<col width="80px">
									<col width="120px">
									<col width="*">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th>발생일자</th>
										<th>구분</th>
										<th>적립/사용 내용</th>
										<th>만료일자</th>
										<th>적립포인트</th>
										<th>사용포인트</th>
										<th>잔여포인트</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="center">2017-03-10</td>
										<td class="center">배송비결제</td>
										<td class="center">배송비 결제</td>
										<td class="right">&nbsp;</td>
										<td class="right">&nbsp;</td>
										<td class="right">-2,615</td>
										<td class="right">0</td>
									</tr>
								</tbody>
							</table>
							<table class="common_table_normal">
								<tbody>
									<tr><td align="center" class="paginate">	<strong>1</strong></td><script>function go_page(page){	$('#page').val(page);	$('#emoneyCashOutListForm').submit();}</script></tr>
								</tbody>
							</table>
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