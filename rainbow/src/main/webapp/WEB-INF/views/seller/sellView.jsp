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

<script type="text/javascript" src="/js/seller/sellView.js"></script>

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
					
					<!-- 판매관리 메뉴 -->
					<%@include file="/WEB-INF/views/seller/sellMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/seller/sellMain.do">판매관리</a> &gt; 상품판매관리 &gt; 상품주문서
						</div>
						<div id="v5ContentsWrap">
						
							<form>
								<input type="hidden" name="info_seq" value="${info.INFO_SEQ }"/>
								<input type="hidden" name="order_seq" value="${info.ORDER_SEQ }"/>
								<input type="hidden" name="order_no" value="${info.ORDER_NO }"/>
								<input type="hidden" name="be_seq" value="${backExchange.BE_SEQ }"/>
								<input type="hidden" name="curr_order_state" value="${info.ORDER_STATE }"/>
							</form>
		
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
										<th>구매자아이디</th>
										<td><span class="span_default"><b>${info.MB_ID }</b></span></td>
										<th>현재상태</th>
										<td><span class="span_default"><font color="#0000cc"><b>${info.ORDER_STATE_NAME }</b></font></span></td>
									</tr>
									<tr>
										<th>주문수량</th>
										<td><span class="span_default"><font color="#cc0000"><b>${info.ORDER_QTY }개</b></font></span></td>
										<th>주문일시</th>
										<td><span class="span_default">${info.ORDER_REG_DTTM }</span></td>
									</tr>
									<tr>
										<th rowspan="2">결제금액</th>
										<td rowspan="2"><span class="span_default"><font color="#cc0000"><b><fmt:formatNumber value="${info.TOTAL_ITEM_PRICE+info.TOTAL_DELIVERY_PRICE }"/>원</b></font></span></td>
										<th>상품비</th>
										<td><span class="span_default"><fmt:formatNumber value="${info.TOTAL_ITEM_PRICE }"/>원</span></td>
									</tr>
									<tr>
										<th>배송비</th>
										<td><span class="span_default"><fmt:formatNumber value="${info.TOTAL_DELIVERY_PRICE }"/>원</span></td>
									</tr>
									<tr>
										<th>결제방법</th>
										<td><span class="span_default">${info.PAY_TYPE_NAME }</span></td>
										<th>결제일시</th>
										<td><span class="span_default">-</span></td>
		
									</tr>
									<tr>
										<th>판매수수료</th>
										<td><span class="span_default">1,210원 (VAT 포함, 6.93%)</span>
											<!-- <div style="text-align: left; margin-top: 5px;">
												<a href="#">
													<img src="/images/seller/img_btnFeeNoticeView.jpg" alt="판매수수료전체보기" title="판매수수료전체보기" style="cursor: pointer;">
												</a>
											</div> -->
										</td>
										<th>적립예정금액</th>
										<td><span class="span_default"><font color="#0000cc"><b><fmt:formatNumber value="${info.ORDER_PRICE }"/> 원</b></font></span></td>
									</tr>
									<tr>
										<th>주문자이름</th>
										<td><span class="span_default">${info.MB_NAME }</span></td>
										<th>수령자이름</th>
										<td><span class="span_default">${info.RECV_NAME }</span></td>
									</tr>
		
									<tr>
										<th>수령자주소</th>
										<td colspan="3"><span class="span_default">${info.RECV_ADDRESS } ${info.RECV_ADDRESS_DTL }(${info.RECV_ZIP_CODE })</span></td>
									</tr>
		
									<tr>
										<th>수령자휴대전화</th>
										<td><span class="span_default">${info.RECV_HP }</span></td>
										<th>추가연락처</th>
										<td><span class="span_default">02--</span></td>
									</tr>
									<tr>
										<th>배송회사</th>
										<td>
											<select class="select_default" name="delivery_company">
												<option value="" ${(info.DELIVERY_COMPANY eq 'noselected') or (empty info.DELIVERY_COMPANY) ? 'selected' : ''}>선택안함</option>
												<option value="CJ대한통운" ${info.DELIVERY_COMPANY eq 'CJ대한통운' ? 'selected' : ''}>CJ대한통운</option>
												<option value="GTX로지스" ${info.DELIVERY_COMPANY eq 'GTX로지스' ? 'selected' : ''}>GTX로지스</option>
												<option value="KGB택배" ${info.DELIVERY_COMPANY eq 'KGB택배' ? 'selected' : ''}>KGB택배</option>
												<option value="KG로지스" ${info.DELIVERY_COMPANY eq 'KG로지스' ? 'selected' : ''}>KG로지스</option>
												<option value="건영택배" ${info.DELIVERY_COMPANY eq '건영택배' ? 'selected' : ''}>건영택배</option>
												<option value="경동택배" ${info.DELIVERY_COMPANY eq '경동택배' ? 'selected' : ''}>경동택배</option>
												<option value="굿투럭" ${info.DELIVERY_COMPANY eq '굿투럭' ? 'selected' : ''}>굿투럭</option>
												<option value="다드림택배" ${info.DELIVERY_COMPANY eq '다드림택배' ? 'selected' : ''}>다드림택배</option>
												<option value="대신택배" ${info.DELIVERY_COMPANY eq '대신택배' ? 'selected' : ''}>대신택배</option>
												<option value="로젠택배" ${info.DELIVERY_COMPANY eq '로젠택배' ? 'selected' : ''}>로젠택배</option>
												<option value="롯데택배" ${info.DELIVERY_COMPANY eq '롯데택배' ? 'selected' : ''}>롯데택배</option>
												<option value="옐로우캡" ${info.DELIVERY_COMPANY eq '옐로우캡' ? 'selected' : ''}>옐로우캡</option>
												<option value="우체국택배" ${info.DELIVERY_COMPANY eq '우체국택배' ? 'selected' : ''}>우체국택배</option>
												<option value="일양택배" ${info.DELIVERY_COMPANY eq '일양택배' ? 'selected' : ''}>일양택배</option>
												<option value="천일택배" ${info.DELIVERY_COMPANY eq '천일택배' ? 'selected' : ''}>천일택배</option>
												<option value="편의점택배" ${info.DELIVERY_COMPANY eq '편의점택배' ? 'selected' : ''}>편의점택배</option>
												<option value="한서호남택배" ${info.DELIVERY_COMPANY eq '한서호남택배' ? 'selected' : ''}>한서호남택배</option>
												<option value="한의사랑택배" ${info.DELIVERY_COMPANY eq '한의사랑택배' ? 'selected' : ''}>한의사랑택배</option>
												<option value="한진정기화물" ${info.DELIVERY_COMPANY eq '한진정기화물' ? 'selected' : ''}>한진정기화물</option>
												<option value="한진택배" ${info.DELIVERY_COMPANY eq '한진택배' ? 'selected' : ''}>한진택배</option>
												<option value="합동택배" ${info.DELIVERY_COMPANY eq '합동택배' ? 'selected' : ''}>합동택배</option>
											</select>
										</td>
										<th>송장번호</th>
										<td>
											<input type="text" name="delivery_no" value="${info.DELIVERY_NO }" style="width:80px;"/>
											<button class="button_height_small" type="button" onclick="updateDeliveryInfo();">배송저장</button>
											<%-- <c:if test="${not empty info.DELIVERY_NO }">
												<button class="button_height_small" type="button" onclick="goDeliTrace('KGBL', '23413322166', '11890487_7164686','1');">배송조회</button>
											</c:if> --%>
										</td>
									</tr>
									<tr>
										<th>수령자전달사항</th>
										<td colspan="3" style="padding:0px 12px;">${info.RECV_MESSAGE }</td>
									</tr>
									<tr>
										<th>주문상태확인</th>
										<td colspan="3"><span class="span_default"><font color="#0000cc">판매가 완료되었습니다</font></span></td>
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
										<td colspan="3">
											<textarea name="be_answer" style="width: 620px; height: 198px; word-break:break-all;">${backExchange.BE_ANSWER }</textarea>
										</td>
									</tr>
									<tr>
										<th>반품/교환요청<br/>상태변경</th>
										<td colspan="3">
											<select class="select_default" name="order_state">
												<option value="">선택</option>
												<option value="11" ${info.ORDER_STATE eq 11 ? 'selected':'' }>반품승인</option>
												<option value="12" ${info.ORDER_STATE eq 12 ? 'selected':'' }>교환승인</option>
											</select>
											<button class="button_height_small" type="button" onclick="saveBackExchangeAnswer();">답변저장</button>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
		
							<div class="submit_button_area">
								<button class="button_submit" title="목록보기" onclick="javascript:location.href='/seller/sellList.do?order_state=${info.ORDER_STATE }'">목록보기</button>
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