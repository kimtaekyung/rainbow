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
<link rel="stylesheet" type="text/css" href="/css/item/itemCartList.css">

<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/item/itemOrderForm.js"></script>

<style type="text/css">
.soldout {
	zoom: 1; 
	filter: alpha(opacity=50); 
	opacity: 0.5;
}
</style>

</head>
	<body>
		<c:set var="cartList" value="${resultDataMap.cartList }"/>
		<c:set var="cartGroupList" value="${resultDataMap.cartGroupList }"/>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
	
					<div id="orderInfoForm">
	
						<!-- Head -->
						<h2>주문하기</h2>
	
						<!-- <h4 id="h4discount">주문상품</h4> -->
						<div class="common_lable_div">
							<img class="common_lable_img" src="/images/common/ico_common2.gif">
							<span class="common_lable_span">주문상품</span>
						</div>
	
						<!-- 상품목록 -->
						<div id="cartWrap">
							<table class="common_table_max">
								<colgroup>
									<col width="90px">
									<col width="*">
									<col width="87px">
									<col width="85px">
									<col width="87px">
									<col width="100px">
								</colgroup>
								<thead>
									<tr>
										<th>상품</th>
										<th>옵션정보</th>
										<th>합계금액</th>
										<th>배송비</th>
										<th>결제금액</th>
										<th>판매자</th>
									</tr>
								</thead>
								<tbody>
								
								<c:set var="sumAmt" value="0"/>				<!-- 각 상품의 합계 금액-->
								<c:set var="sumQty" value="0"/>				<!-- 각 상품의 합계 수량-->
								<c:set var="deliveryAmt" value="0"/>		<!-- 각 상품의 배송비 -->
								<c:set var="totalAmt" value="0"/>			<!-- 상품 총 주문금액 -->
								<c:set var="totalDeliveryCnt" value="0"/>	<!-- 배송비합계 -->
								<c:set var="totalDeliveryAmt" value="0"/>	<!-- 배송비합계 -->
								<c:forEach var="group" items="${cartGroupList }" varStatus="status">
									<c:set var="sumAmt" value="0"/>
									<c:set var="sumQty" value="0"/>
									<c:set var="deliveryAmt" value="0"/>
									<tr class="orderTr" id="${group.ORDER_NO }">
										<td class="center" style="padding:0px;">
											<a href="${group.ITEM_REPRESENT_IMAGE }" data-jbox-image="order_gallay" title="${group.ITEM_NAME }">
												<img src="${group.ITEM_REPRESENT_IMAGE }" width="85" height="85" alt="${group.ITEM_NAME }" title="${group.ITEM_NAME }">
											</a>
										</td>
										<td class="left" style="padding:0px;">
											<div class="itemElements">
												<div class="title" style="float: left;">
													<a href="/item/itemView.do?item_seq=${group.ITEM_SEQ }">[${group.ORDER_NO }]${group.ITEM_NAME }</a>
												</div>
												<div class="opt" style="float: left;width:98%;">
													<table class="tblSelectOpts" style="width:100%;">
														<colgroup>
															<col width="*">
															<col width="90px">
															<col width="100px">
														</colgroup>
														<tbody>
														
													<c:forEach var="cart" items="${cartList }">
														<c:if test="${group.ORDER_NO eq cart.ORDER_NO }">
															<tr>
																<td class="textLimit">
																	<c:if test="${cart.IO_TYPE eq 0 }">${cart.ITEM_NAME } ${cart.ITEM_NAME eq cart.IO_NAME ? '':cart.IO_NAME }<c:if test="${cart.IO_PRICE gt 0 }">(+<fmt:formatNumber value="${cart.IO_PRICE }"/>)</c:if></c:if>
																	<c:if test="${cart.IO_TYPE eq 1 }">${cart.IO_NAME }</c:if>
																</td>
																<td class="qty">${cart.CART_QTY }개</td>
																<c:set var="itemAmt" value="${cart.IO_TYPE eq 0 ? (cart.ITEM_PRICE + cart.IO_PRICE) : cart.IO_PRICE }"/>
																<c:set var="sumAmt" value="${sumAmt + (itemAmt*cart.CART_QTY) }"/>
																<c:set var="sumQty" value="${sumQty + cart.CART_QTY }"/>
																<td class="amt">X <fmt:formatNumber value="${itemAmt }"/>원</td>
															</tr>
														</c:if>
													</c:forEach>

														</tbody>
													</table>
												</div>
												
												<div class="memo" id="address${status.index }">
												
													<table style="width:100%;">
														<colgroup>
															<col width="70px">
															<col width="*">
														</colgroup>
														<tr>
															<th class="center">수령자명</th>
															<td class="left">
																<input type="text" name="recv_name" value="" style="width:100px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;"/>
															</td>
														</tr>
														<tr>
															<th class="center" rowspan="3">수령지</th>
															<td class="left">
																<input type="text" name="recv_zip_code" value="" size="5" maxlength="7" style="width:70px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;" readonly="readonly">
																<button type="button" class="button_height_small" onclick="goAddrPopup('${status.index}');">우편번호검색</button>
															</td>
														</tr>
														<tr>
															<td>
																<input type="text" name="recv_address" value="" class="input" readonly="readonly" style="width:400px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;">
															</td>
														</tr>
														<tr>
															<td>
																<input type="text" name="recv_address_dtl" value="" class="input" style="width:400px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;">
															</td>
														</tr>
														<tr>
															<th class="center">휴대전화</th>
															<td>
																<input type="hidden" name="recv_hp" value=""/>
																<select class="select_default" name="hp1" style="height:25px;margin:0px;padding:2px 6px;font-size: 11px;">
																	<option value="">선택</option>
																	<option value="010">010</option>
																	<option value="011">011</option>
																	<option value="016">016</option>
																	<option value="017">017</option>
																	<option value="018">018</option>
																	<option value="019">019</option>
																	<option value="050">050</option>
																	<option value="0502">0502</option>
																	<option value="0503">0503</option>
																	<option value="0504">0504</option>
																	<option value="0505">0505</option>
																	<option value="0506">0506</option>
																	<option value="0507">0507</option>
																	<option value="0707">0707</option>
																</select> -
																<input type="text" name="hp2" value="" maxlength="4" style="width:50px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;"/> -
																<input type="text" name="hp3" value="" maxlength="4" style="width:50px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;"/>
															</td>
														</tr>
														<tr>
															<th class="center">배송요청일</th>
															<td>
																<input type="text" name="send_req_date" value="" class="datepicker" style="width:70px;height:20px;margin:0px;padding:2px 6px;font-size: 11px;"/>
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<p class="desc">판매자(${group.SELLER_ID })에게 전달할 내용</p>
																<textarea name="recv_message" style="width:445px;height:50px;"></textarea>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
										<td class="right" style="vertical-align: top;padding:5px;"><fmt:formatNumber value="${sumAmt }"/>원</td>
										<td class="center" style="vertical-align: top;padding:5px;">
											<div class="normal">
												${group.DELIVERY_TYPE eq 1 ? '무료배송':'2,500원<br>선결제' }
												<c:if test="${group.DELIVERY_TYPE ne 1 }">
													<c:set var="deliveryAmt" value="2500"/>
													<c:set var="totalDeliveryCnt" value="${totalDeliveryCnt + 1 }"/>
													<c:set var="totalDeliveryAmt" value="${totalDeliveryAmt + 2500 }"/>
												</c:if>
											</div>
											<div class="addFee" id="addFee_a0007025_826"></div>
										</td>
										<td class="right" style="vertical-align: top;padding:5px;">
											<div class="totalAmt"><fmt:formatNumber value="${sumAmt+deliveryAmt }"/>원</div>
											<c:set var="totalAmt" value="${totalAmt + sumAmt }"/>
										</td>
										<td class="center" style="vertical-align: top;padding:5px;">
											<div class="nick">${group.SELLER_BIZ_NAME }</div>
											<div class="id">(${group.SELLER_ID })</div>
											
											<input type="hidden" name="order_no" value="${group.ORDER_NO }"/>
											<input type="hidden" name="item_seq" value="${group.ITEM_SEQ }"/>
											<input type="hidden" name="order_name" value="${group.ITEM_NAME }"/>
											<input type="hidden" name="order_price" value="${sumAmt }"/>
											<input type="hidden" name="order_qty" value="${sumQty }"/>
											<input type="hidden" name="delivery_type" value="${group.DELIVERY_TYPE }"/>
											<input type="hidden" name="delivery_charge" value="${deliveryAmt }"/>
											<input type="hidden" name="item_seller_seq" value="${group.ITEM_SELLER_SEQ }"/>
										</td>
									</tr>
								</c:forEach>
								
								</tbody>
							</table>
						</div>
	
						<!-- Form -->
						<form name="order" method="post">
	
							<div id="tblOrdBenefit" style="margin-top:10px;">
								<table style="width:976px;">
									<colgroup>
										<col width="245px">
										<col width="245px">
										<col width="245px">
										<col width="*">
									</colgroup>
									<thead>
										<tr>
											<td>총상품비</td>
											<td>총배송비</td>
											<td>차감금액</td>
											<td>총결제금액</td>
										</tr>
										<tr>
											<th valign="top"><small>구매상품 총 <b id="totOrderQty">${fn:length(cartGroupList) }</b>개</small>
												<div>
													<sup id="totOrderPrice"><fmt:formatNumber value="${totalAmt }"/></sup><sub>원</sub>
												</div>
											</th>
											<th valign="top"><small>선결제배송비 총 <b id="totDeliveryCnt">${totalDeliveryCnt }</b>개</small>
												<div>
													<sup id="cartDeliAmount"><fmt:formatNumber value="${totalDeliveryAmt }"/></sup><sub>원</sub>
												</div>
											</th>
											<th valign="top"><small>포인트사용</small>
												<div>
													<sup id="applyDiscountAmount">0</sup><sub>원</sub>
												</div>
											</th>
											<th valign="top"><small>&nbsp;</small>
												<div class="cartAmountTotal">
													<sup id="cartAmount"><fmt:formatNumber value="${totalAmt + totalDeliveryAmt }"/></sup><sub>원</sub>
												</div>
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td valign="top" colspan="3">
												<table style="width:100%;">
													<colgroup>
														<col width="90px">
														<col width="*">
													</colgroup>
													<tbody>
														<tr>
															<th valign="top">포인트사용</th>
															<td valign="top">
																<!-- <div>
																	배송비 <input type="text" name="usePointDeli" value="0" onchange="validateUsePointDeli()">P <img src="http://211.43.195.137/image/v6/common/button/greenHighlight/img_btnUseAll.png" width="57" height="20" alt="전액사용" style="cursor: pointer" onclick="useAllPointDeli()">
																	<span class="desc">(500P 이상 사용가능)</span>
																</div> -->
																<div>
																	상품비 <input type="text" name="usePointProduct" value="0" >P <button type="button" class="button_height_small" onclick="">전액사용</button>
																	<span class="desc">(10,000P 이상 사용가능)</span>
																</div>
																<div style="padding-top: 6px; color: #555; font-size: 11px;">
																	(사용후 잔액 <b id="pointBalanceAfterUse">0</b>P)
																</div>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td valign="top"><b>구매후 적립혜택</b>
												<table style="width:100%;">
													<colgroup>
														<col width="*">
														<col width="70px">
													</colgroup>
													<tbody>
														<tr>
															<td style="letter-spacing: -1px">구매적립 포인트(수령확인시)</td>
															<td align="right"><span class="amt" id="buyPointResult">2</span><span class="unit">P</span></td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
	
								<img src="/images/item/cart/ico_plus.png" class="icoPlus">
								<img src="/images/item/cart/ico_minus.png" class="icoMinus">
								<img src="/images/item/cart/ico_equal.png" class="icoEqual">
							</div>
	
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">주문상품</span>
							</div>
	
							<div id="tblPayInfo">
								<table style="width:100%;padding:10px;margin:2px;border:0;text-align:left;background-color:#ffffff;">
									<colgroup>
										<col valign="top" width="143px" style="background-color:#ebebeb;">
										<col valign="top" width="*" style="background-color:#f7f7f7;">
									</colgroup>
									<tbody>
										<tr>
											<th bgcolor="#ebebeb"><img src="/images/auth/ico_must.gif"><span class="span_default">결제방법선택</span></th>
											<td bgcolor="#f7f7f7">
												<dl>
													<!-- 이머니 결제 -->
													<dt style="position: relative; top: 0; left: 0">
														<input type="radio" name="pay_type" value="1" id="pay_emoney" onclick="clickPayType(this);" style="vertical-align: -2px">
														<label for="pay_emoney"><b>현금성 e-money 결제</b></label>
													</dt>
													<dd style="padding-bottom: 16px">
														<ul style="list-style-type: disc; padding-left: 30px; line-height: 1.7em;">
															<li>
																<span style="color: gray"> 현금성 e-money 보유액 : <b><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH }"/></b>원, 
																	<a href="/main/myPage/emoney/my_emoneyIn.php">
																		<span style="text-decoration: underline;">e-money통장에충전</span>
																	</a>을 해놓으면 결제시 편리하게 사용할 수 있습니다
																</span>
															</li>
														</ul>
													</dd>
													<dt style="position: relative; top: 0; left: 0">
														<input type="radio" name="pay_type" value="2" id="pay_emoney_card" onclick="clickPayType(this);" style="vertical-align: -2px">
														<label for="pay_emoney_card"><b>카드성 e-money 결제</b></label>
													</dt>
													<dd style="padding-bottom: 16px">
														<ul style="list-style-type: disc; padding-left: 30px; line-height: 1.7em;">
															<li>
																<span style="color: gray"> 카드성 e-money 보유액 : <b><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH_CARD }"/></b>원, 
																	<a href="/main/myPage/emoney/my_emoneyIn.php">
																		<span style="text-decoration: underline;">e-money통장에충전</span>
																	</a>을 해놓으면 결제시 편리하게 사용할 수 있습니다
																</span>
															</li>
														</ul>
													</dd>
													<dt>
														<input type="radio" name="pay_type" value="3" id="pay_account" onclick="clickPayType(this);" style="vertical-align: -2px">
														<label for="pay_account"><b>무통장입금</b></label>
													</dt>
													<dt>
														<input type="radio" name="pay_type" id="pay_card" value="4" onclick="clickPayType(this);" style="vertical-align: -2px">
														<label for="pay_card"><b>신용카드</b></label>
													</dt>
												</dl>
	
												<div>
													<br> <font color="#cc0000"> * 두 가지 이상의 상품을 신용카드로
														결제 후 일부 주문건이 취소되면 부분 카드취소됩니다<br> * 카드결제시 '즉시할인'을 받거나,
														하이세이브 포인트결제 등을 한 경우에는 카드부분취소가 안됩니다<br>
													</font>
												</div>
											</td>
										</tr>
	
										<tr id="confirmPw" style="display: none;">
											<th bgcolor="#ebebeb">비밀번호</th>
											<td bgcolor="#f7f7f7">
												<ul style="border: 1px solid #ffdd33; background: #ffffdd; padding: 8px; letter-spacing: -1px; list-style-type: disc; list-style-position: inside;">
													<li>회원님의 안전한 정보보호를 위하여 비밀번호를 입력하여 주십시오.</li>
												</ul> 
												<br>
												<b>비밀번호 입력</b>
												<input type="hidden" class="input" name="rsa_password" value=""/>
												<input type="password" class="input" name="confirm_password" size="30" value=""/><br>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
	
							<div id="agreeChkWrap">
								
								<label for="agreeChkInputId"><input type="checkbox" name="chk_agree" value="" id="agreeChkInputId">개인정보 제3자 제공 · 위탁에 동의합니다.</label>
	
								<div style="font-size: 11px;">
									회원님께서는 정보제공 및 위탁에 동의하지 않을 수 있으나, 동의를 거부할 경우 상품결제 및 배송이
									제한됩니다.&nbsp; <a href="javascript:void(0);" style="text-decoration: underline; cursor: pointer;" id="agreeChkTextMoreA" onclick="javascript:$('#agreeChkTbl').show();">더보기</a>
								</div>
	
								<table style="width: 100%; margin-top: 15px; display: none;" id="agreeChkTbl">
									<colgroup>
										<col width="180px">
										<col width="*">
										<col width="*">
										<col width="*">
									</colgroup>
									<thead>
										<tr>
											<th>개인정보를 제공 · 위탁받는자</th>
											<th>수집항목</th>
											<th>이용목적</th>
											<th>보유 및 이용기간</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td style="text-align: center;">
												<div>판매자,</div>
												<div style="padding-top: 3px;">배송협력사 <br>(레인보우샵 택배)</div>
											</td>
											<td>구매자 이름, 전화번호, ID, 휴대폰번호, 이메일주소, 상품 구매정보, 수취인정보(이름, 주소, 전화번호) 등</td>
											<td>
												<div>판매자와 구매자간 거래의 원활한 진행, 본인의사 확인, 고객상담 및 배송처리 등</div>
												<div style="padding-top: 3px;">배송협력사에게 위탁하는 개인정보는 배송만을목적으로 제공</div>
											</td>
											<td>
												<div>개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기(단, 관계법령에 의해 보존할 경우 의무기간 동안 보관)</div>
												<div style="padding-top: 3px;">배송처리를 위해 배송협력사들에 위탁 제공된 개인정보는 배송의 목적이 달성되면 지체없이 파기</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							
						</form>
							<div class="submit_button_area">
								<button class="button_submit" type="button" title="결제하기" onclick="beforePay();">결제하기</button>
							</div>
	
					</div>
	
				</div>
			</div>

			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>