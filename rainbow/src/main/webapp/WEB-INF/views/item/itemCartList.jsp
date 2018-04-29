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

<script type="text/javascript" src="/js/item/itemCartList.js"></script>

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
					<div id="cartWrap">
	
						<h2>장바구니</h2>
						<div class="total">
							총 <b>${fn:length(cartGroupList) }개</b>의 상품
						</div>
	
						<div id="cartList">
						
							<table class="common_table_max">
								<colgroup>
									<col width="25px">
									<col width="80px">
									<col width="*">
									<col width="82px">
									<col width="75px">
									<col width="82px">
									<col width="96px">
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th>상품</th>
										<th>옵션정보</th>
										<th>합계금액</th>
										<th>배송비</th>
										<th>결제금액</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody>
							
						<c:choose>
							<c:when test="${empty cartList }">
									<tr>
										<td colspan="6">장바구니에 담은 상품이 없습니다.</td>
									</tr>
							</c:when>
							<c:otherwise>
							
								<c:set var="sumAmt" value="0"/>
								<c:set var="totalAmt" value="0"/>
								<c:forEach var="group" items="${cartGroupList }">
									<c:set var="sumAmt" value="0"/>
									<tr>
										<td class="center" style="padding:0px;">
											<input type="checkbox" name="chk_cart" value="${group.ORDER_NO }" item_seq=${group.ITEM_SEQ } onchange="checkBoxOneCheck(this, 'chk_all');">
										</td>
										<td class="center" style="padding:0px;">
											<a href="/item/itemView.do?item_seq=${group.ITEM_SEQ }">
												<img src="${group.ITEM_REPRESENT_IMAGE }" width="75" height="75" alt="${group.ITEM_NAME }" title="${group.ITEM_NAME }">
											</a>
										</td>
										<td class="left" style="padding:10px;">
											<div class="itemElements">
												<%-- <div class="leftArea">
													<div class="img">
														<a href="/item/itemView.do?item_seq=${group.ITEM_SEQ }">
															<img src="${group.ITEM_REPRESENT_IMAGE }" width="75" height="75" alt="${group.ITEM_NAME }" title="${group.ITEM_NAME }">
														</a>
													</div>
													<div class="global"></div>
												</div> --%>
												<div class="title" style="float:left;">
													<a href="/item/itemView.do?item_seq=${group.ITEM_SEQ }">[${group.ORDER_NO }]${group.ITEM_NAME }</a>
												</div>
												<div class="opt" style="float:left;">
													<table class="tblSelectOpts" style="width:100%;">
														<colgroup>
															<col width="*">
															<col width="120px">
															<col width="100px">
														</colgroup>
														<tbody>
													
													<c:forEach var="cart" items="${cartList }">
														<c:if test="${group.ORDER_NO eq cart.ORDER_NO }">
															<tr>
																<td class="textLimit">
																	<c:if test="${cart.IO_TYPE eq 0 }">${cart.ITEM_NAME } ${cart.ITEM_NAME eq cart.IO_NAME ? '':cart.IO_NAME }</c:if>
																	<c:if test="${cart.IO_TYPE eq 1 }">${cart.IO_NAME }</c:if>
																</td>
																<td class="qty">
																	<input class="qty" type="text" name="cart_qty" value="${cart.CART_QTY }" data-org="2">
																	<button class="button_height_small" type="button" onclick="updateCartQty(this, '${cart.ORDER_NO}', '${cart.CART_SEQ }');">변경</button>
																</td>
																<c:set var="itemAmt" value="${cart.IO_TYPE eq 0 ? (cart.ITEM_PRICE + cart.IO_PRICE) : cart.IO_PRICE }"/>
																<c:set var="sumAmt" value="${sumAmt + (itemAmt*cart.CART_QTY) }"/>
																<td class="amt">X <fmt:formatNumber value="${itemAmt }"/>원 
																	<input type="image" src="/images/item/cart/btn_cart_delete.png" width="15" height="15" alt="옵션삭제" title="옵션삭제" onclick="deleteShopCart('${cart.ORDER_NO}', '${cart.CART_SEQ }');">
																</td>
															</tr>
														</c:if>
													</c:forEach>
														
														</tbody>
													</table>
												</div>
												<%-- <a href="javascript:void(0);" onclick="optionLayer('${group.ORDER_NO}', '${group.ITEM_SEQ }');" class="linkEditOpt">옵션 및 수량수정 &gt;</a> --%>
											</div>
										</td>
										<td class="right" style="padding:5px;"><fmt:formatNumber value="${sumAmt }"/>원</td>
										<td class="center" style="padding:5px;">
											<div class="normal">
												${group.DELIVERY_TYPE eq 1 ? '무료배송':'2,500원<br>선결제' }
												<c:set var="sumAmt" value="${group.DELIVERY_TYPE eq 1 ? sumAmt : (sumAmt+2500) }"/>
											</div>
											<div class="addFee" id="addFee_comon00:957"></div>
										</td>
										<td class="right" style="padding:5px;">
											<div class="totalAmt"><fmt:formatNumber value="${sumAmt }"/>원</div>
										</td>
										<td class="center buttons" style="padding:5px;">
											<button class="order" onclick="goOrderFormOne(this);">주문</button>
											<button class="edit" onclick="optionLayer('${group.ORDER_NO }', '${group.ITEM_SEQ}');return false;">수정</button>
											<button class="edit" onclick="deleteShopCart('${group.ORDER_NO}');">삭제</button>
										</td>
									</tr>
									<c:set var="totalAmt" value="${totalAmt + sumAmt }"/>
								</c:forEach>
								
							</c:otherwise>
						</c:choose>
						
								</tbody>
								<tfoot>
									<tr>
										<td class="center" style="padding: 0px;">
											<input type="checkbox" id="chk_all" children_name="chk_cart" onchange="checkBoxAllCheck(this);">
										</td>
										<td colspan="2" style="padding: 10px;">
											<div id="cartSelectBtnWrap">
												<button type="button" class="button_height_small" title="선택상품 삭제" onclick="checkDeleteShopCart('S');">선택상품삭제</button>
												<button type="button" class="button_height_small" title="전체상품 삭제" onclick="checkDeleteShopCart('A');">전체상품삭제</button>
											</div>
										</td>
										<td colspan="4" class="right" style="padding: 10px;">총 결제금액 <span id="checkedTotal"><fmt:formatNumber value="${not empty totalAmt ? totalAmt : 0 }"/>원</span>
										</td>
									</tr>
								</tfoot>
							</table>
	
						</div>
						
						<div class="submit_button_area">
							<button class="button_submit" title="주문하기" onclick="beforeResOrderForm();">주문하기</button>
							<button class="button_list" title="계속쇼핑하기" onclick="history.back(-1);">계속쇼핑하기</button>
							<form name="orderFrm" method="post" action="/item/itemOrderForm.do">
								<input type="hidden" name="order_no" value=""/>
							</form>
						</div>
							
						<!-- <div class="confirm">
							<input type="button" class="domestic" value="주문하기" title="주문하기" onclick="beforeResOrderForm();">
							<input type="button" class="continue" value="계속쇼핑하기" title="계속쇼핑하기" onclick="history.back(-1);">
							
						</div> -->
	
					</div>
	
				</div>
				<div class="gClearBoth"></div>
			
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
			
		</div>
		
		<!-- 옵션 수정 및 변경 레이어(상품옵션수정 클릭시 Ajax로 로딩해서 붙임) -->
		<div id="lOptQty">
			<div class="frm">
			</div>
		</div>
		
	</body>
</html>