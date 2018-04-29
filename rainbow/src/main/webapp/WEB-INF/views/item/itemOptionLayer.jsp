<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="item" value="${resultDataMap.item }"/>
<c:set var="itemOption" value="${resultDataMap.itemOption }"/>
<c:set var="itemOptionGroup" value="${resultDataMap.itemOptionGroup }"/>
<c:set var="cartList" value="${resultDataMap.cartList }"/>

<!-- 추가옵션 여부 확인 -->
<c:forEach var="option" items="${itemOption }">
	<c:if test="${option.IO_TYPE eq 1 }">
		<c:set var="isAddOption" value="true"/>
	</c:if>
</c:forEach>
<c:set var="itemPrice" value="${not empty item.ITEM_COUPON_PRICE ? item.ITEM_PRICE-item.ITEM_COUPON_PRICE : not empty item.ITEM_CUST_PRICE ? item.ITEM_CUST_PRICE : item.ITEM_PRICE }"/>

<input type="hidden" name="item_seq" value="${item.ITEM_SEQ }"/>
<input type="hidden" name="item_title" value="${item.ITEM_TITLE }"/>
<input type="hidden" name="item_name" value="${item.ITEM_NAME }"/>
<input type="hidden" name="item_seller_seq" value="${item.MB_SEQ }"/>
<input type="hidden" name="item_price" value="${not empty item.ITEM_COUPON_PRICE ? item.ITEM_PRICE-item.ITEM_COUPON_PRICE : not empty item.ITEM_CUST_PRICE ? item.ITEM_CUST_PRICE : item.ITEM_PRICE }"/>
<input type="hidden" name="order_no" value="${cartList[0].ORDER_NO }"/>
<input type="hidden" name="delivery_type" value="${cartList[0].DELIVERY_TYPE }"/>


<!-- <div id="lPay"> -->
	<h3>옵션 및 수량수정</h3>
	<div id="itemOptSelect">
		<table class="common_table_normal">
			<colgroup>
				<col width="100"/>
				<col width="*"/>
			</colgroup>
			<tbody>
		
<!-- 필수옵션 시작 -->
<c:set var="arrOptionSubject" value="${fn:split(item.ITEM_OPTION_SUBJECT, ',') }"/>
<c:if test="${not empty item.ITEM_OPTION_SUBJECT }">
	<c:choose>
		<c:when test="${fn:length(arrOptionSubject) gt 1 }">
			<c:forEach var="subject" items="${arrOptionSubject }" varStatus="status">
				<tr>
					<th class="center">${subject }</th>
					<td>
						<select class="select_default" name="select_option" id="select_option_${status.index }" ${status.index gt 0 ? 'disabled="desabled"':'' } onchange="changeSelectOption(this, ${status.index});">
							<option value="">선택</option>
					<c:if test="${status.index eq 0 }">
						<c:forEach var="option" items="${itemOptionGroup }">
							<option value="${option.IO_GROUP_NAME }" io_price="${option.IO_PRICE }" io_stock_qty="${option.IO_STOCK_QTY }">${option.IO_GROUP_NAME }</option>
						</c:forEach>
					</c:if>
						</select>
					</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
				<tr>
					<th class="center">${item.ITEM_OPTION_SUBJECT }</th>
					<td>
						<select class="select_default" name="select_option" id="select_option_${status.index }" ${status.index gt 0 ? 'disabled="desabled"':'' } onchange="changeSelectOption(this, ${status.index});">
							<option value="">선택</option>
					<c:forEach var="option" items="${itemOption }">
						<c:if test="${option.IO_TYPE eq 0 }">
							<option value="${fn:replace(option.IO_NAME, '^', '') }" io_price="${option.IO_PRICE }" io_stock_qty="${option.IO_STOCK_QTY }">${fn:replace(option.IO_NAME, '^', '') }( +<fmt:formatNumber value="${option.IO_PRICE }"/>) ${option.IO_STOCK_QTY }개</option>
						</c:if>
					</c:forEach>
						</select>
					</td>
				</tr>
		</c:otherwise>
	</c:choose>
</c:if>
		
			<!-- 추가옵션 시작 -->
			<c:if test="${isAddOption eq 'true' }">
				<tr>
					<th class="center">추가옵션</th>
					<td>
						<select name="add_option" onchange="addSelectOptionQty(this);">
							<option value="">선택</option>
					<c:forEach var="option" items="${itemOption }">
						<c:if test="${option.IO_TYPE eq 1 }">
							<option value="${fn:replace(option.IO_NAME, '^', '') }" io_price="${option.IO_PRICE }" io_stock_qty="${option.IO_STOCK_QTY }">${fn:replace(option.IO_NAME, '^', '') }( +<fmt:formatNumber value="${option.IO_PRICE }"/>) ${option.IO_STOCK_QTY }개</option>
						</c:if>			
					</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>
			
			</tbody>
		</table>
	</div>
	
	<!-- 수량선택 및 합계 영역-->
	<div id="itemOptResult" style="display: block;">
		<table>
		
			<!-- 필수옵션상품 수량 입력필드 추가 영역 -->
			<tbody>
			
			<c:set var="totalAmt" value="0"/>
			<c:set var="totalQty" value="0"/>
			<c:forEach var="cart" items="${cartList }">
				<tr>
					<th valign="middle">
						<c:if test="${cart.IO_TYPE eq 0 }">${cart.ITEM_NAME eq cart.IO_NAME ? '':cart.ITEM_NAME } ${cart.IO_NAME }</c:if>
						<c:if test="${cart.IO_TYPE eq 1 }">${cart.IO_NAME }</c:if>
					</th>
					<td valign="top" class="qty">
						<div class="wrap">
							<input type="hidden" name="option_name" value="${cart.IO_NAME }"/>
							<input type="hidden" name="option_type" value="${cart.IO_TYPE }"/>
							<input type="hidden" name="option_price" value="${cart.IO_PRICE }"/>
							<input type="hidden" name="option_qty" value="${item.ITEM_QTY }"/>
							<input type="text" name="option_order_qty" value="${cart.CART_QTY }" onkeyup="checkItemQty(this);">
							<button class="btnUp" type="button" onclick="changeItemOptionOrderQty(this, '+');">+</button>
							<button class="btnDown" type="button" onclick="changeItemOptionOrderQty(this, '-');">-</button>
						</div>
					</td>
					<td valign="middle" class="amt">
						<div class="wrap">
							<button onclick="removeOptionQty(this);">X</button>
						</div>
						<c:set var="itemPrice" value="${cart.IO_TYPE eq 0 ? (cart.ITEM_PRICE+cart.IO_PRICE)*cart.CART_QTY : cart.IO_PRICE*cart.CART_QTY }"/>
						<span><fmt:formatNumber value="${itemPrice }"/></span>&nbsp;원
					</td>
				</tr>
				<c:set var="totalAmt" value="${totalAmt + itemPrice }"/>
				<c:set var="totalQty" value="${totalQty + cart.CART_QTY }"/>
			</c:forEach>
			
			</tbody>
			<!-- 추가옵션상품 수량 입력필드 추가 영역 -->
			<tfoot>
			
			</tfoot>
		</table>
	</div>
	<div id="lPayRes" style="display: block;">
		<span class="amt">총 상품금액(수량) : <strong id="lPayResAmt"><fmt:formatNumber value="${totalAmt }"/></strong><b>원</b></span>
		<span class="qty">(<strong id="lPayResQty">${totalQty }</strong>개)</span>
	</div>
	
	<button class="submit" onclick="updateCart();">저장</button>
	<button class="close" onclick="$('div#lOptQty').hide(); return false;">닫기</button>
	<!-- <div id="lItemOptDummy"></div> -->
<!-- </div> -->
		