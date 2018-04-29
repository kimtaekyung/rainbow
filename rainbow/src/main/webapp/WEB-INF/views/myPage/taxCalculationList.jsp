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
								href="/main/myPage/my_pageMain.php">마이페이지</a> &gt; 세금계산서 &gt; <b>발급내역보기</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">세금계산서 발급 내역</span>
							</div>
							<div class="excel_area_div">
								<div class="verticalMiddleParent">
									<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
									<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀다운로드</a>
								</div>
							</div>
							<!-- 안내시작 -->
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td class="left">
											<p>설명.........</p>
											<p>설명.........</p>
											<p>설명.........</p>
											<p>설명.........</p>	
											<p>설명.........</p>
											<p>설명.........</p>
											<p>설명.........</p>
											<p>설명.........</p>
											<p>설명.........</p>	
										</td>
									</tr>
								</tbody>
							</table>
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
							<!--안내 종료-->
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>총 <b>3</b>건의 e-money 충전신청 기록이 있습니다</td>
									</tr>
								</tbody>
							</table>	
							<table class="common_table_normal">
								<colgroup>
									<col width="80">
									<col width="40">
									<col width="30">
									<col width="100">
									<col width="*">
									<col width="100">
									<col width="100">
									<col width="70">
									<col width="70">
									<col width="70">
								</colgroup>
								<tbody>
									<tr>
										<th>일련번호</th>
										<th>연도</th>
										<th>분기</th>
										<th>사업자등록번호</th>
										<th>상호</th>
										<th>공급가액</th>
										<th>세액</th>
										<th>발급일</th>
										<th>세금계산서</th>
										<th>거래명세서</th>
									</tr>
									<tr>
										<td class="center">1702709</td>
										<td class="center">2017</td>
										<td class="center">3</td>
										<td class="center">782-87-00699</td>
										<td class="center">주식회사레인보우컨설팅</td>
										<td class="right">100,000</td>
										<td class="right">5,000</td>
										<td class="center">17-08-03</td>
										<td class="center"><a href="#">출력</a></td>
										<td class="center"><a href="#">출력</a></td>
									</tr>
								</tbody>
							</table>
							<table class="common_table_normal">
								<tbody>
									<tr><td align="center" class="paginate"><strong>1</strong></td><script>function go_page(page){	$('#page').val(page);	$('#emoneyChargeListForm').submit();}</script></tr>
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