<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<%@include file="/WEB-INF/views/common/include.jsp"%>

<script type="text/javascript" src="/js/seller/sellList.js"></script>
</head>
	<body>
	
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					
					<!-- 판매관리 메뉴 -->
					<%@include file="/WEB-INF/views/seller/sellMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/seller/sellMain.do">판매관리</a> &gt; 상품판매관리 &gt; <b>판매자 정산내역</b>
						</div>
						<div id="v5ContentsWrap">
		
							<form name="schFrm" id="schFrm" method="get" action="/seller/calculateList.do">
								<input type="hidden" name="page" id="page" value="${resultDataMap.page }"/>
								<input type="hidden" name="pageSize" id="pageSize" value="${resultDataMap.pageSize }"/>
								
								<div class="excel_area_div">
									<div class="verticalMiddleParent">
										<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
										<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀다운로드</a>
									</div>
								</div>
								
								<table class="common_table_normal" id="searchTbl">
									<tbody>
										<tr>
											<th>주문일</th>
											<td colspan="5">
												<select class="select_default" name="quick" style="width: 110px;" onchange="javascript:changeQuickDate(this.value,'schFrm','sch_sdate','sch_edate');">
													<option value="">빠른선택</option>
													<option value="day" ${resultDataMap.quick eq 'day' ? 'selected':'' }>오늘</option>
													<option value="week" ${resultDataMap.quick eq 'week' ? 'selected':'' }>1주일</option>
													<option value="month" ${resultDataMap.quick eq 'month' ? 'selected':'' }>1개월</option>
													<option value="threeMonth" ${resultDataMap.quick eq 'threeMonth' ? 'selected':'' }>3개월</option>
													<option value="sixMonth" ${resultDataMap.quick eq 'sixMonth' ? 'selected':'' }>6개월</option>
													<option value="year" ${resultDataMap.quick eq 'year' ? 'selected':'' }>1년</option>
												</select>
												<input type="text" name="sch_sdate" value="${resultDataMap.sch_sdate }" class="datepicker" style="width:85px;"/>
												<span class="span_default"> ~ </span>
												<input type="text" name="sch_edate" value="${resultDataMap.sch_edate }" class="datepicker" style="width:85px;"/>
												<button class="button_default" type="button" onclick="searchFormSubmit('schFrm');" >찾기</button>
											</td>
										</tr>
									</tbody>
								</table>
								
								<%-- <table class="common_table_normal">
									<tbody>
										<tr>
											<td>총 <b><fmt:formatNumber value="${resultDataMap.total }" pattern="#,###" /></b>개의 주문서가 있습니다.</td>
										</tr>
									</tbody>
								</table> --%>
								
								<table class="common_table_normal">
									<colgroup>
										<col width="85">
										<col width="110">
										<col width="*">
										<col width="50">
										<col width="35">
										<col width="70">
										<col width="80">
									</colgroup>
									<tbody>
										<tr>
											<th>주문번호</th>
											<th>주문상태</th>
											<th>주문명</th>
											<th>구매자</th>
											<th>수량</th>
											<th>결제금액</th>
											<th>주문일</th>
										</tr>
							<c:choose>
								<c:when test="${empty resultDataMap.sellList }">
										<tr>
											<td colspan="7" class="center">검색된 내역이 없습니다.</td>
										</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="data" items="${resultDataMap.sellList }">
										<tr>
											<td rowspan="2" class="center">
												${fn:substring(data.ORDER_NO, 0, 8) }<br>
												${fn:substring(data.ORDER_NO, 8, fn:length(data.ORDER_NO)) }
											</td>
											<td rowspan="2" class="center">
												${data.ORDER_STATE_NAME }<br/>
												<input type="hidden" name="curr_order_state" value="${data.ORDER_STATE }"/>
											<c:if test="${data.ORDER_STATE ne 6 and data.ORDER_STATE ne 7 and data.ORDER_STATE ne 8 }"> 
												<select class="select_default" name="save_order_state" style="height:25px;padding:3px 12px;">
													<option value="">상태선택</option>
													<option value="3">배송대기</option>
													<option value="4">배송중</option>
													<option value="8">판매취소</option>
													<option value="11">반품승인</option>
													<option value="12">교환승인</option>
													<option value="13">반품완료</option>
													<option value="14">교환완료</option>
												</select><br>
												<a href="javascript:void(0);" onclick="updateShopOrderState(this, '${data.INFO_SEQ}', '${data.ORDER_SEQ }', '${data.ORDER_NO }');">
													<font color="#0000cc"><span style="text-decoration: underline;">상태변경</span></font>
												</a>
											</c:if>
											</td>
											<td rowspan="2" class="left">
												<a href="/seller/sellView.do?order_seq=${data.ORDER_SEQ }&order_no=${data.ORDER_NO }">
													${data.ORDER_NAME }
												</a>
		
												<div style="position: relative;">
													<button class="button_height_small" type="button" onclick="viewOption(this, '${data.ORDER_NO}');">옵션전체보기</button>
													<table class="hideLayerGroup" style="position: absolute; top: 20px; left: 0px; width: 490px; border: 2px solid #ccc; border-collapse: collapse; background-color: #fff; z-index: 100; display: none;">
														<colgroup>
															<col width="*">
															<col width="60">
															<col width="120">
														</colgroup>
														<!-- 주문옵션목록 영역 -->
														<tbody>
														</tbody>
													</table>
												</div>
											</td>
											<td rowspan="2">${data.MB_ID }
												<!-- <br><span style="cursor: pointer" onclick="openWindow('my_sellReport.php?no=11890487', 'ngm_sellReport', 700, 700, 'resizable=yes, scrollbars=yes')">
													<font color="#cc0000"><span style="text-decoration: underline;">주문확인서</span></font>
												</span> -->
											</td>
											<td rowspan="2" class="right">${data.ORDER_QTY }개</td>
											<td rowspan="2" class="right">
												<div><fmt:formatNumber value="${data.ORDER_PRICE }"/>원</div>
											<c:if test="${data.DELIVERY_CHARGE gt 0 }">
												<div style="color: #cc0000; letter-spacing: -1px">배송비 <fmt:formatNumber value="${data.DELIVERY_CHARGE }"/>원</div>
											</c:if>
											</td>
											<td class="center">${data.ORDER_REG_DTTM }</td>
										</tr>
										<tr>
											<td class="center">${data.SEND_REQ_DATE }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							
									</tbody>
								</table>
							</form>
		
							<table class="common_table_normal">
								<tbody>
									<tr>${resultDataMap.paging }</tr>
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