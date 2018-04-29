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

</head>
	<body>
	
		<c:set var="info" value="${resultDataMap.info }"/>
		<c:set var="option" value="${resultDataMap.option }"/>
		<c:set var="backExchange" value="${resultDataMap.backExchange }"/>
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
							현재위치 : <a href="/main/">HOME</a> &gt; <a href="/buyer/buyMain.do">구매관리</a> &gt; 상품구매관리 &gt; 구매목록 &gt; <b>상품주문서</b>
						</div>
						<div id="v5ContentsWrap">
	
							<table class="common_table_normal">
								<colgroup>
									<col width="95">
									<col width="245">
									<col width="95">
									<col width="245">
								</colgroup>
								<tbody>
									<tr>
										<th>주문번호</th>
										<td colspan="3"><span class="span_default">${info.ORDER_NO }</span></td>
									</tr>
									<tr>
										<th>상품제목</th>
										<td colspan="3"><span class="span_default">${info.ORDER_NAME }</span></td>
									</tr>
									<tr>
										<th>상품주문옵션</th>
										<td colspan="3">
											<div style="padding: 2px 5px 0px 5px; border: 1px solid #ccc; border-collapse: collapse; background-color: #fff">
												<table style="width:100%;">
													<colgroup>
														<col width="*">
														<col width="60">
														<col width="80">
													</colgroup>
													<tbody>
													
													<c:forEach var="data" items="${option }">
														<tr style="background-color: #fff;">
															<td class="left">
															<c:set var="itemPrice" value="0"/>
															<c:if test="${data.IO_TYPE eq '0' }">
																<c:if test="${data.ITEM_NAME eq data.IO_NAME }">${data.ITEM_NAME }</c:if>
																<c:if test="${data.ITEM_NAME ne data.IO_NAME }">${data.ITEM_NAME }/${data.IO_NAME }</c:if>
																<c:set var="itemPrice" value="${(data.ITEM_PRICE+data.IO_PRICE)*data.CART_QTY }"/>
															</c:if>
															<c:if test="${data.IO_TYPE eq '1' }">
																${data.IO_NAME }
																<c:set var="itemPrice" value="${data.IO_PRICE*data.CART_QTY }"/>
															</c:if>
															</td>
															<td class="right">${data.CART_QTY }개</td>
															<td class="right"><fmt:formatNumber value="${itemPrice }"/>원</td>
														</tr>
													</c:forEach>
													
													</tbody>
												</table>
											</div>
										</td>
									</tr>
									<tr>
										<th>판매자아이디</th>
										<td><span class="span_default"><b>${info.ITEM_SELLER_ID }</b></span></td>
										<th>현재상태</th>
										<td><span class="span_default"><font color="#0000cc"><b>${info.ORDER_STATE_NAME }</b></font></span></td>
									</tr>
									<tr>
										<th>판매자이름</th>
										<td><span class="span_default">${info.ITEM_SELLER_BIZ_NAME }</span></td>
										<th>판매자이메일</th>
										<td><span class="span_default">${info.ITEM_SELLER_EMAIL }</span></td>
									</tr>
									<tr>
										<th>판매자연락처</th>
										<td colspan="3"><span class="span_default">${info.ITEM_SELLER_HP } / ${info.ITEM_SELLER_TEL }</span></td>
									</tr>
									<tr>
										<th>주문수량</th>
										<td><span class="span_default"><font color="#cc0000"><b>${info.ORDER_QTY }개</b></font></span></td>
										<th>주문일시</th>
										<td><span class="span_default">${info.ORDER_REG_DTTM }</span></td>
									</tr>
									<tr>
										<th>결제금액</th>
										<td><span class="span_default"><font color="#cc0000"><b><fmt:formatNumber value="${info.ORDER_PRICE+info.DELIVERY_CHARGE }"/>원</b></font></span></td>
										<th>상품비</th>
										<td><span class="span_default"><fmt:formatNumber value="${info.ORDER_PRICE }"/>원</span></td>
									</tr>
									<tr>
										<th>결제일시</th>
										<td><span class="span_default">${info.ORDER_REG_DTTM }</span></td>
										<th>배송비</th>
										<td><span class="span_default">
											<c:if test="${info.DELIVERY_TYPE eq '1' }">무료배송</c:if>
											<c:if test="${info.DELIVERY_TYPE eq '2' }">선결제 <fmt:formatNumber value="${info.DELIVERY_CHARGE }"/></c:if>
											</span>
										</td>
									</tr>
									<tr>
										<th>결제방법</th>
										<td><span class="span_default">${info.PAY_TYPE_NAME }</span></td>
										<th>영수증출력</th>
										<td><span class="span_default"><button class="button_height_small" type="button" onclick="alert('개발중입니다.');">영수증출력</button></span></td>
									</tr>
									<tr>
										<th>포인트사용</th>
										<td colspan="3"></td>
									</tr>
									<tr>
										<th>수령인이름</th>
										<td><span class="span_default">${info.RECV_NAME }</span></td>
										<th>휴대전화</th>
										<td><span class="span_default">${info.RECV_HP }</span></td>
									</tr>
									<tr>
										<th>수령지주소</th>
										<td colspan="3"><span class="span_default">${info.RECV_ADDRESS } ${info.RECV_ADDRESS_DTL }(${info.RECV_ZIP_CODE })</span></td>
									</tr>
									<tr>
										<th>배송회사</th>
										<td><span class="span_default">${info.DELIVERY_COMPANY }</span></td>
										<th>송장번호</th>
										<td>
											<span class="span_default"><b>${info.DELIVERY_NO }</b></span>&nbsp;&nbsp;
											<c:if test="${not empty info.DELIVERY_NO }">
													<button class="button_height_small" type="button" onclick="alert('개발중입니다.');">배송조회하기</button>
											</c:if>
										</td>
									</tr>
									<tr>
										<th>구매자전달사항</th>
										<td colspan="3"><span class="span_default">${info.RECV_MESSAGE }</span></td>
									</tr>
									
									<!-- 반품요청시 내용표시 -->
								<c:if test="${not empty backExchange }">
									<tr>
										<th>반품/교환요청분류</th>
										<td><span class="span_default">${backExchange.BE_TYPE_NAME }</span></td>
										<th>반품/교환요청일시</th>
										<td><span class="span_default">${backExchange.BE_REG_DTTM_YMDHIS }</span></td>
									</tr>
									<tr>
										<th>반품/교환요청제목</th>
										<td colspan="3" ><span class="span_default">${backExchange.BE_SUBJECT }</span></td>
									</tr>
									<tr>
										<th>반품/교환요청내용</th>
										<td colspan="3" style="padding:5px 12px;">
											${backExchange.BE_CONTENT }
											<c:if test="${not empty backExchange.BE_ATTACH_IMG_PATH_1 }">
												<br/><img src="${backExchange.BE_ATTACH_IMG_PATH_1 }" width="500"/>
											</c:if>
											<c:if test="${not empty backExchange.BE_ATTACH_IMG_PATH_2 }">
												<br/><img src="${backExchange.BE_ATTACH_IMG_PATH_2 }" width="500"/>
											</c:if>
										</td>
									</tr>
									<tr>
										<th>반품/교환요청답변</th>
										<td colspan="3" style="padding:5px 12px;">${backExchange.BE_ANSWER }</td>
									</tr>
								</c:if>
	
								</tbody>
							</table>
							
							<div class="submit_button_area">
								<button class="button_submit" title="목록보기" onclick="javascript:location.href='/buyer/buyList.do?order_state=${info.ORDER_STATE }'">목록보기</button>
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