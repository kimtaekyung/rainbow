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
<link rel="stylesheet" type="text/css" href="/css/buyer/buyList.css">

<script type="text/javascript" src="/js/buyer/buyList.js"></script>

</head>
	<body>
		
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					
					<!-- 구매관리메뉴 -->
					<%@include file="/WEB-INF/views/buyer/buyMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main/">HOME</a> &gt; <a href="/buyer/buyMain.do">구매관리</a> &gt; 상품구매관리 &gt; <b>구매목록</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">상품 구매 목록</span>
							</div>
							<div class="excel_area_div">
								<div class="verticalMiddleParent">
									<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
									<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀다운로드</a>
								</div>
							</div>
		
							<form name="schFrm" id="schFrm" method="get" action="/buyer/buyList.do">
								<input type="hidden" name="page" id="page" value="${resultDataMap.page }"/>
								<input type="hidden" name="pageSize" id="pageSize" value="${resultDataMap.pageSize }"/>
								
							<table class="common_table_normal" id="searchTbl">
								<tbody>
									<tr>
										<th>주문일자</th>
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
									<tr>
										<th>주문번호</th>
										<td>
											<input type="text" name="order_no" value="${resultDataMap.order_no }" style="width:90px;"/>
										</td>
										<th>주문상태</th>
										<td>
											<select class="select_default" name="order_state" style="width:110px;">
												<option value="">선택</option>
												<option value="1" ${resultDataMap.order_state eq '1' ? 'selected':'' }>결제대기</option>
												<option value="2" ${resultDataMap.order_state eq '2' ? 'selected':'' }>결제완료</option>
												<option value="3" ${resultDataMap.order_state eq '3' ? 'selected':'' }>배송대기</option>
												<option value="4" ${resultDataMap.order_state eq '4' ? 'selected':'' }>배송중</option>
												<option value="5" ${resultDataMap.order_state eq '5' ? 'selected':'' }>구매완료</option>
												<option value="6" ${resultDataMap.order_state eq '6' ? 'selected':'' }>결제대기취소</option>
												<option value="7" ${resultDataMap.order_state eq '7' ? 'selected':'' }>결제취소</option>
												<option value="8" ${resultDataMap.order_state eq '8' ? 'selected':'' }>판매취소</option>
												<option value="9" ${resultDataMap.order_state eq '9' ? 'selected':'' }>반품요청</option>
												<option value="10" ${resultDataMap.order_state eq '10' ? 'selected':'' }>교환요청</option>
												<option value="11" ${resultDataMap.order_state eq '11' ? 'selected':'' }>반품승인</option>
												<option value="12" ${resultDataMap.order_state eq '12' ? 'selected':'' }>교환승인</option>
												<option value="13" ${resultDataMap.order_state eq '13' ? 'selected':'' }>반품완료</option>
												<option value="14" ${resultDataMap.order_state eq '14' ? 'selected':'' }>교환완료</option>
											</select>
										</td>
										<th>판매자</th>
										<td>
											<input type="text" name="seller_mb_id" value="${resultDataMap.seller_mb_id }" style="width:90px;"/>
										</td>
									</tr>
									<tr>
										<th>구매번호</th>
										<td>
											<input type="text" name="order_seq" value="${resultDataMap.order_seq }" style="width:90px;"/>
										</td>
										<th>주문명</th>
										<td>
											<input type="text" name="order_name" value="${resultDataMap.order_name }" style="width:90px;"/>
										</td>
										<th>수령인</th>
										<td>
											<input type="text" name="recv_name" value="${resultDataMap.recv_name }" style="width:90px;"/>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
							
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>총 <b><fmt:formatNumber value="${resultDataMap.total }" pattern="#,###" /></b>개의 주문내역이 있습니다.</td>
									</tr>
								</tbody>
							</table>
	
							<table class="common_table_normal">
								<colgroup>
									<col width="85">
									<col width="70">
									<col width="*">
									<col width="60">
									<col width="60">
									<col width="90">
									<col width="80">
								</colgroup>
								<tbody>
									<tr>
										<th>주문번호</th>
										<th>주문상태</th>
										<th>상품번호 / 상품제목</th>
										<th>판매자</th>
										<th>수령인</th>
										<th>금액/수량</th>
										<th>주문일</th>
									</tr>
						<c:choose>
							<c:when test="${empty resultDataMap.buyList }">
									<tr>
										<td colspan="7" class="center">주문내역이 없습니다.</td>
									</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="data" items="${resultDataMap.buyList }">
									<tr>
										<td class="center">${fn:substring(data.ORDER_NO, 0, 8) }<br/>${fn:substring(data.ORDER_NO, 8, fn:length(data.ORDER_NO)) }</td>
										<td class="center">${data.ORDER_STATE_NAME }
											<c:if test="${data.ORDER_STATE eq 1 or data.ORDER_STATE eq 2 or data.ORDER_STATE eq 3 }">
												<br/>
												<a href="javascript:void(0);" onclick="cancelOrder('${data.INFO_SEQ}', '${data.ORDER_SEQ }', '${data.ORDER_NO }');">
													<font color="#0000cc"><span style="text-decoration: underline;">주문취소</span></font>
												</a>
											</c:if>
										</td>
										<td class="left">
										<c:if test="${data.ORDER_STATE eq 4 }">
											<a href="javascript:void(0);" onclick="alert('개발중입니다.');">
												<font color="#cc0000">[<span style="text-decoration: underline;">구매완료</span>]</font>
											</a>
										</c:if>
										<c:if test="${data.ORDER_STATE eq 4 or data.ORDER_STATE eq 5 }">
											<a href="/buyer/itemBackExchangeWrite.do?order_seq=${data.ORDER_SEQ}&order_no=${data.ORDER_NO}">
												<font color="#cc0000">[<span style="text-decoration: underline;">반품/교환요청</span>]</font>
											</a>
										</c:if>
										<c:if test="${data.ORDER_STATE eq 9 or data.ORDER_STATE eq 10 }">
											<a href="javascript:void(0);" onclick="cancelBackExchange('${data.INFO_SEQ}', '${data.ORDER_SEQ }', '${data.ORDER_NO }', '${data.ORDER_STATE }');">
												<font color="#cc0000">[<span style="text-decoration: underline;">반품/교환요청취소</span>]</font>
											</a>
										</c:if>
											<a href="/buyer/buyView.do?info_seq=${data.INFO_SEQ }&order_no=${data.ORDER_NO }&order_seq=${data.ORDER_SEQ }">
												<font color="#0000cc"> ${data.ORDER_NAME }</font>
											</a>
											<div style="position: relative;">
												<button class="button_height_small" type="button" onclick="viewOption(this, '${data.ORDER_NO}');">옵션전체보기</button>
												<table class="hideLayerGroup" style="position: absolute; top: 20px; width: 490px; border: 2px solid #ccc; border-collapse: collapse; background-color: #fff; z-index: 100; display: none;">
													<colgroup>
														<col width="*">
														<col width="60px">
														<col width="100px">
													</colgroup>
													<!-- 옵션내용영역 -->
													<tbody>
													</tbody>
												</table>
											</div>
										</td>
										<td class="center">${data.SELLER_MB_ID }</td>
										<td class="center">${data.RECV_NAME }</td>
										<td class="right">
											<fmt:formatNumber value="${data.ORDER_PRICE }"/>원<br>${data.ORDER_QTY }개
										</td>
										<td class="center" title="${data.ORDER_REG_DTTM }">
											<font face="굴림체">${data.ORDER_REG_DTTM_YMD }</font>
										<c:if test="${not empty data.DELIVERY_NO }">
											<div style="margin-top: 11px; font-size: 11px; line-height: 16px;">
												${data.DELIVERY_COMPANY }<br> ${data.DELIVERY_NO }<br>
												<a href="javascript:void(0);" onclick="defaultAlert('준비중입니다.');"><font color="#cc0000"><span style="text-decoration: underline;">배송조회</span></font></a>
											</div>
										</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
	
								</tbody>
							</table>

							<table class="common_table_normal">
								<tbody>
									<tr>${resultDataMap.paging }</tr>
								</tbody>
							</table>
		
						</div>
					</div>
				</div>
			</div>
			
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>