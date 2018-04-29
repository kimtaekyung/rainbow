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
<link rel="stylesheet" type="text/css" href="/css/myPage/emoneyUseList.css">
<script type="text/javascript" src="/js/myPage/emoneyUseList.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">emoney-통장</a> &gt; <b>e-money사용내역</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">e-money 사용 내역</span>
							</div>
							<form id="emoneyUseListForm" action="/myPage/emoneyUseList.do">
								<input type="hidden" id="page" name="page" value="${resultMap.page}">
								<input type="hidden" name="pageSize" value="${resultMap.pageSize}">
								<div class="excel_area_div">
									<div class="verticalMiddleParent">
										<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
										<a id="btn-excel" class="verticalMiddleChild">엑셀다운로드</a>
									</div>
								</div>
								<!-- 파일 생성중 보여질 진행막대를 포함하고 있는 다이얼로그 입니다. -->
								<div title="Data Download" id="preparing-file-modal" style="display: none;">
								    <div id="progressbar" style="width: 100%; height: 22px; margin-top: 20px;"></div>
								</div>
								
								<!-- 에러발생시 보여질 메세지 다이얼로그 입니다. -->
								<div title="Error" id="error-modal" style="display: none;">
								    <p>생성실패.</p>
								</div>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<th>등록일</th>
											<td colspan="4">
												<select class="select_default" name="quick" onchange="javascript:changeQuickDate(this.value,'emoneyUseListForm','sch_sdate','sch_edate');">
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
												<button class="button_default" type="button" onclick="searchFormSubmit('emoneyUseListForm');" >찾기</button>
											</td>
										</tr>
									</tbody>
								</table>	
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td >총 <b><fmt:formatNumber value="${resultMap.total }" pattern="#,###" /></b>건 의 e-money 사용내역이 있습니다</td>
										</tr>
									</tbody>
								</table>	
								<table class="common_table_normal">
									<colgroup>
										<col width="64">
										<col width="*">
										<col width="80">
										<col width="80">
										<col width="80">
										<col width="80">
										<col width="80">
										<col width="100">
									</colgroup>
									<tbody>
										<!-- 엑셀 다운로드 버튼클릭시 이용되는 정보  orderName : 쿼리명,searchFormId : 검색 조건,keyParam : select 되는 row key,value_param : key 에 매핑되는 엑셀 헤더 명 -->
										<tr id="excelHeaderInfo" orderName="getEmoneyUseList" searchFormId="emoneyUseListForm" saveFileName="emoney-사용내역">
											<th keyParam="ROWNUM" 					valueParam="번호">번호</th>
											<th keyParam="CL_TYPE_STR"  			valueParam="내용">내용</th>
											<th keyParam="CASH_CARD_CHANGE_AMOUNT" 	valueParam="카드변동">카드변동</th>
											<th keyParam="MB_CASH_CARD" 			valueParam="카드잔액">카드잔액</th>
											<th keyParam="CASH_CHANGE_AMOUNT" 		valueParam="현금변동">현금변동</th>
											<th keyParam="MB_CASH" 					valueParam="현금잔액">현금잔액</th>
											<th keyParam="MB_TOTAL_CASH" 			valueParam="총잔액">총잔액</th>
											<th keyParam="CL_REG_DTTM" 				valueParam="발생일">발생일</th>
										</tr>
										<c:choose>
											<c:when test="${not empty resultMap.emoneyUseList}">
												<c:forEach var="data" items="${resultMap.emoneyUseList }">
													<tr>
														<td class="center textLimit"><fmt:parseNumber>${data.ROWNUM }</fmt:parseNumber></td>
														<td class="left textLimit">
															<c:choose>
																<c:when test="${not empty data.ORDER_SEQ and (data.CL_TYPE eq '5' or data.CL_TYPE eq '6' or data.CL_TYPE eq '7' or data.CL_TYPE eq '8')}">
																	<c:choose>
																		<c:when test="${data.CL_TYPE eq '5'}">
																			<a href="/buyer/buyList.do?order_seq=${data.ORDER_SEQ}&order_detail=true">
																				<font color="#0000cc"><u>현금성 이머니 상품구매[${data.ORDER_SEQ}]</u></font>
																			</a>
																		</c:when>
																		<c:when test="${data.CL_TYPE eq '6'}">
																			<a href="/buyer/buyList.do?order_seq=${data.ORDER_SEQ}&order_detail=true">
																				<font color="#0000cc"><u>카드성 이머니 상품구매[${data.ORDER_SEQ}]</u></font>
																			</a>
																		</c:when>
																		<c:when test="${data.CL_TYPE eq '7'}">
																			<a href="/buyer/buyList.do?order_seq=${data.ORDER_SEQ}&order_detail=true">
																				<font color="#0000cc"><u>현금성 이머니 상품구매취소[${data.ORDER_SEQ}]</u></font>
																			</a>
																		</c:when>
																		<c:when test="${data.CL_TYPE eq '8'}">
																			<a href="/buyer/buyList.do?order_seq=${data.ORDER_SEQ}&order_detail=true">
																				<font color="#0000cc"><u>카드성 이머니 상품구매취소[${data.ORDER_SEQ}]</u></font>
																			</a>
																		</c:when>
																	</c:choose>
																</c:when>
																<c:otherwise>
																	${data.CL_TITLE}
																</c:otherwise>
															</c:choose>
														</td>
														<td class="right textLimit"><fmt:formatNumber value="${data.CASH_CARD_CHANGE_AMOUNT}" pattern="#,###" /></td>
														<td class="right textLimit"><fmt:formatNumber value="${data.MB_CASH_CARD}" pattern="#,###" /></td>
														<td class="right textLimit"><fmt:formatNumber value="${data.CASH_CHANGE_AMOUNT}" pattern="#,###" /></td>
														<td class="right textLimit"><fmt:formatNumber value="${data.MB_CASH}" pattern="#,###" /></td>
														<td class="right textLimit"><b><fmt:formatNumber value="${data.MB_CASH + data.MB_CASH_CARD}" pattern="#,###" /></b></td>
														<td class="center textLimit" title="${data.CL_REG_DTTM }">${fn:split(data.CL_REG_DTTM,' ')[0]}</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td class="center textLimit" colspan="8">e-money 사용 내역이 없습니다.</td>
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
								<p></p>
								<br>
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