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
<link rel="stylesheet" type="text/css" href="/css/myPage/emoneyChargeList.css">
<script type="text/javascript" src="/js/myPage/emoneyChargeList.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">emoney-통장</a> &gt; <b>e-money충전내역</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">e-money 충전 내역</span>
							</div>
							<form id="emoneyChargeListForm">
								<input type="hidden" id="page" name="page" value="${resultMap.page}">
								<input type="hidden" name="pageSize" value="${resultMap.pageSize}">
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
												<select class="select_default" name="quick" onchange="javascript:changeQuickDate(this.value,'emoneyChargeListForm','sch_sdate','sch_edate');">
													<option value="" 			${resultMap.quick eq '' ? 'selected' :'' }>빠른선택</option>
													<option value="day" 		${resultMap.quick eq 'day' ? 'selected' :'' }>오늘</option>
													<option value="week" 		${resultMap.quick eq 'week' ? 'selected' :'' }>1주일</option>
													<option value="month" 		${resultMap.quick eq 'month' ? 'selected' :'' }>1개월</option>
													<option value="threeMonth" 	${resultMap.quick eq 'threeMonth' ? 'selected' :'' }>3개월</option>
													<option value="sixMonth" 	${resultMap.quick eq 'sixMonth' ? 'selected' :'' }>6개월</option>
													<option value="year" 		${resultMap.quick eq 'year' ? 'selected' :'' }>1년</option>
												</select>
												<input type="text" name="sch_sdate" value="${resultMap.sch_sdate }" class="datepicker input_default">
												<span class="span_default"> ~ </span>  
												<input type="text" name="sch_edate" value="${resultMap.sch_edate }" class="datepicker input_default">
												<button class="button_default" type="button" onclick="searchFormSubmit('emoneyChargeListForm');" >찾기</button>
											</td>
										</tr>
									</tbody>
								</table>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td >총 <b><fmt:formatNumber value="${resultMap.total }" pattern="#,###" /></b>건의 e-money 충전신청 기록이 있습니다</td>
										</tr>
									</tbody>
								</table>	
								<table class="common_table_normal">
									<colgroup>
										<col width="44px">
										<col width="100px">
										<col width="80px">
										<col width="*">
										<col width="80px">
										<col width="72px">
										<col width="100">
										<col width="80px">
										<col width="72px">
										<col width="50px">
									</colgroup>
									<tbody>
										<tr>
											<th>번호</th>
											<th>결제금액</th>
											<th>결제방법</th>
											<th>결제은행</th>
											<th>입금자명</th>
											<th>현재상태</th>
											<th>상태변경일</th>
											<th>등록일</th>
											<th>영수증</th>
											<th>취소</th>
										</tr>
		
										<c:choose>
											<c:when test="${not empty resultMap.emoneyChargeList }">
												
												<c:forEach var="data" items="${resultMap.emoneyChargeList}">
													<tr>
														<td class="center textLimit"><fmt:parseNumber>${data.ROWNUM }</fmt:parseNumber></td>
														<td class="right textLimit"><fmt:formatNumber value="${data.CC_AMOUNT}" pattern="#,###" /></td>
														<td class="center textLimit">${data.CC_PAY_TYPE eq '1' ? '무통장입금' : '신용카드' }</td>
														<td class="center textLimit" title="${not empty data.CC_PAY_BANK  ? data.CC_PAY_BANK : '-'}">${not empty data.CC_PAY_BANK  ? data.CC_PAY_BANK : '-'}</td>
														<td class="center textLimit">${data.CC_PAY_NAME }</td>
														<td class="center textLimit"><font color="green">${data.CC_STATE eq '1' ? '입금대기' :  data.CC_STATE eq '2' ? '결제완료':data.CC_STATE eq '3' ? '입금취소' : '관리자취소'}</font></td>
														<td class="center textLimit" title="${not empty data.CC_MOD_DTTM ? data.CC_MOD_DTTM : '-' }">${not empty data.CC_MOD_DTTM ? fn:split(data.CC_MOD_DTTM,' ')[0] : '-' }</td>
														<td class="center textLimit" title="${data.CC_REG_DTTM }">${fn:split(data.CC_REG_DTTM, ' ')[0] }</td>
														<td class="center"><a href="#" style="color: #0000cc; text-decoration: underline">확인</a></td>
														<td class="center"><c:if test="${data.CC_PAY_TYPE eq '1' and  data.CC_STATE eq '1'}"><a href="#" onclick="javascript:cashChargeCancel('${data.CC_SEQ}'); return false;" style="color: red; text-decoration: underline">취소</a></c:if></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td class="center textLimit" colspan="9">내역이 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
								<p></p>
								<table class="common_table_normal">
									<tbody>
										<tr>${resultMap.paging }</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>