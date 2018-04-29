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
<link rel="stylesheet" type="text/css" href="/css/myPage/emoneyCashOutList.css">
<script type="text/javascript" src="/js/myPage/emoneyCashOutList.js"></script>
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
								href="/main/myPage/my_pageMain.php">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">emoney-통장</a> &gt; <b>e-money출금내역</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">e-money 출금 내역</span>
							</div>
							<form id="emoneyCashOutListForm" action="/myPage/emoneyCashOutList.do">
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
												<select class="select_default" name="quick" onchange="javascript:changeQuickDate(this.value,'emoneyCashOutListForm','sch_sdate','sch_edate');">
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
												<button class="button_default" type="button" onclick="searchFormSubmit('emoneyCashOutListForm');" >찾기</button>
											</td>
										</tr>
									</tbody>
								</table>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td >총 <b><fmt:formatNumber value="${resultMap.total }" pattern="#,###" /></b>건 의 출금 신청 내역이 있습니다</td>
										</tr>
									</tbody>
								</table>
								
								<table class="common_table_normal">
									<colgroup>
										<col width="36px">
										<col width="120px">
										<col width="*">
										<col width="140px">
										<col width="100px">
										<col width="100px">
										<col width="85px">
										<col width="100px">
									</colgroup>
									<tbody>
										<tr>
											<th>번호</th>
											<th>출금금액</th>
											<th>출금은행</th>
											<th>출금계좌</th>
											<th>예금주명</th>
											<th>현재상태</th>
											<th>출금취소신청</th>
											<th>등록일</th>
										</tr>
										
										<c:choose>
											<c:when test="${not empty resultMap.emoneyCashOutList}">
												<c:forEach var="data" items="${resultMap.emoneyCashOutList }">
													<tr>
														<td class="center textLimit"><fmt:parseNumber>${data.ROWNUM }</fmt:parseNumber></td>
														<td class="right textLimit"><fmt:formatNumber value="${data.CO_AMOUNT}" pattern="#,###" /></td>
														<td class="center textLimit">${data.CO_BANK }</td>
														<td class="center textLimit">${data.CO_ACCOUNT }</td>
														<td class="center textLimit">${data.CO_ACCOUNT_NAME }</td>
														
														<c:choose>
															<c:when test="${data.CO_STATE eq '1'}">
																<td class="center textLimit">
																	<font color="black">출금대기</font>
																</td>
																<td class="center textLimit">
																	<a style="color: blue; cursor: pointer;" onclick="javascript:cancelCashOut('${data.CO_SEQ}'); return false;">취소신청</a>
																</td>
															</c:when>
															<c:when test="${data.CO_STATE eq '2'}">
																<td class="center textLimit"><font color="green">출금완료</font></td>
																<td class="center textLimit">-</td>
															</c:when>
															<c:when test="${data.CO_STATE eq '3'}">
																<td class="center textLimit"><font color="red">출금취소</font></td>
																<td class="center textLimit">-</td>
															</c:when>
															<c:otherwise>
																<td class="center textLimit">-</td>
																<td class="center textLimit">-</td>
															</c:otherwise>
														</c:choose>
														<td class="center textLimit" title="${data.CO_REG_DTTM }">${fn:split(data.CO_REG_DTTM,' ')[0]}</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td class="center textLimit" colspan="8">출금 내역이 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
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