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
<link rel="stylesheet" type="text/css" href="/css/item/itemView.css">

<script type="text/javascript" src="/js/item/itemView.js"></script>

</head>
	<body>
		<c:set var="item" value="${resultDataMap.item }"/>
		<c:set var="itemOption" value="${resultDataMap.itemOption }"/>
		<c:set var="itemOptionGroup" value="${resultDataMap.itemOptionGroup }"/>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->

			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					<div id="itemView">
						<div id="lPath">
							<ol class="main">
								<li id="lPathCat1" class="dropdown nosub" ><a href="/main.do">레인보우샵홈</a></li>
								<li id="lPathCat2" class="dropdown nosub" >${item.CATE_CODE1_NAME }</li>
								<li id="lPathCat3" class="dropdown nosub" >${item.CATE_CODE2_NAME }</li>
								<c:if test="${not empty item.CATE_CODE3 }">
								<li id="lPathCat4" class="dropdown nosub" >${item.CATE_CODE3_NAME }</li>
								</c:if>
							</ol>
						</div>
						<div style="clear: both"></div>
	
						<div id="lThumb">
							<!-- 인기상품 랭킹 진입시 이미지표시 -->
							<div id="rank100"></div>
	
							<!-- 섬네일 이미지 -->
							<a class="thumbLightbox" title="${item.ITEM_NAME }">
								<img item_seq="${item.ITEM_SEQ }" class="draggableItem mainThumb" src="${item.ITEM_REPRESENT_IMAGE }" width="330" height="330" alt="상품 섬네일 이미지" title="상품 섬네일 이미지">
							</a>
	
							<!-- 하단기능 -->
							<ul class="prodFuncList">
								<li class="prodFunc">
									<table cellspacing="1" cellpadding="0" border="0" bgcolor="#dddddd" style="width:100%;"><!--5개이상-->
										<tbody>
											<tr>
												<td bgcolor="#ffffff">
													<a href="${item.ITEM_REPRESENT_IMAGE }" data-jbox-image="상품이미지" title="${item.ITEM_NAME }">
														<img src="${item.ITEM_REPRESENT_IMAGE }" width="24%" height="80" border="0" onmouseover="setItemImage(this);">
													</a>
													
													<c:if test="${not empty item.ITEM_IMG1 }"><a href="${item.ITEM_IMG1 }" data-jbox-image="상품이미지" title="${item.ITEM_NAME }"><img src="${item.ITEM_IMG1 }" width="24%" height="80" border="0" onmouseover="setItemImage(this);"></a></c:if>
													<c:if test="${not empty item.ITEM_IMG2 }"><a href="${item.ITEM_IMG2 }" data-jbox-image="상품이미지" title="${item.ITEM_NAME }"><img src="${item.ITEM_IMG2 }" width="24%" height="80" border="0" onmouseover="setItemImage(this);"></a></c:if>
													<c:if test="${not empty item.ITEM_IMG3 }"><a href="${item.ITEM_IMG3 }" data-jbox-image="상품이미지" title="${item.ITEM_NAME }"><img src="${item.ITEM_IMG3 }" width="24%" height="80" border="0" onmouseover="setItemImage(this);"></a></c:if>
													<c:if test="${not empty item.ITEM_IMG4 }"><a href="${item.ITEM_IMG4 }" data-jbox-image="상품이미지" title="${item.ITEM_NAME }"><img src="${item.ITEM_IMG4 }" width="24%" height="80" border="0" onmouseover="setItemImage(this);"></a></c:if>
													<c:if test="${not empty item.ITEM_IMG5 }"><a href="${item.ITEM_IMG5 }" data-jbox-image="상품이미지" title="${item.ITEM_NAME }"><img src="${item.ITEM_IMG5 }" width="24%" height="80" border="0" onmouseover="setItemImage(this);"></a></c:if>
												</td>
											</tr>
										</tbody>
									</table>
								</li>
							</ul>
						</div>
						
					<form name="orderFrm">
						<input type="hidden" name="item_seq" value="${item.ITEM_SEQ }"/>
						<input type="hidden" name="item_seller_seq" value="${item.MB_SEQ }"/>
						<input type="hidden" name="item_title" value="${item.ITEM_TITLE }"/>
						<input type="hidden" name="item_name" value="${item.ITEM_NAME }"/>
						<input type="hidden" name="item_qty" value="${item.ITEM_QTY }"/>
						<input type="hidden" name="item_price" value="${item.ITEM_LAST_PRICE }"/>
						<input type="hidden" name="delivery_type" value=""/>
						<input type="hidden" name="item_status" value="${item.ITEM_STATUS }"/>
	
						<div id="lInfoList">
							<div class="lInfoTopTitleIdWrap">
								<div class="lInfoTopWrap">
									<div class="lInfoTopItemNo">상품번호&nbsp;${item.ITEM_SEQ }</div>
									<div class="lInfoClearBoth"></div>
	
								</div>
	
								<div class="lInfoTitle">${item.ITEM_TITLE }</div>
							</div>
	
							<div class="lInfoSellWrap">
								<table class="lInfoSellTbl">
									<tbody>
										<tr>
											<td class="lInfoSellTblTd1">상품명</td>
											<td class="lInfoSellTblTd2">${item.ITEM_NAME }</td>
										</tr>
										<tr>
											<td class="lInfoSellTblTd1">모델명</td>
											<td class="lInfoSellTblTd2">${item.ITEM_MODEL_NAME }</td>
										</tr>
										<tr>
											<td class="lInfoSellTblTd1">시중가격</td>
											<td class="lInfoSellTblTd2">
												<!-- <div class="lInfoTopSaleIcon"></div> -->
												<div>
													<div class="lInfoSellPrice">
														<%-- <c:if test="${not empty item.ITEM_PRICE }"> --%>
															<b><del style="color: gray;"><fmt:formatNumber value="${item.ITEM_CUST_PRICE }"/></del></b><span> 원</span>
														<%-- </c:if>
														<c:if test="${empty item.ITEM_PRICE }">
															<b><fmt:formatNumber value="${item.ITEM_CUST_PRICE }"/></b><span> 원</span>
														</c:if> --%>
													</div>
													<!-- <div class="lInfoClearBoth"></div> -->
												</div>
											</td>
										</tr>
									<%-- <c:if test="${not empty item.ITEM_PRICE }">
										<tr>
											<td class="lInfoSellTblTd1">전시가격</td>
											<td class="lInfoSellTblTd2">
												<div>
													<div class="lInfoSellPrice">
														<b><fmt:formatNumber value="${item.ITEM_PRICE }"/> </b><span> 원</span>
													</div>
												</div>
											</td>
										</tr>
									</c:if> --%>
										<tr>
											<td class="lInfoSellTblTd1">최종판매가격</td>
											<td class="lInfoSellTblTd2">
												<div>
													<div class="lInfoSellPrice">
														<b><fmt:formatNumber value="${item.ITEM_LAST_PRICE }"/> </b><span> 원</span>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="lInfoSellTblTd1">재고수량</td>
											<td class="lInfoSellTblTd2">
												<div class="lInfoSellQty">
													<b><fmt:formatNumber value="${item.ITEM_QTY }"/></b> 개
												</div>
												<div class="lInfoClearBoth"></div>
											</td>
										</tr>
										<tr>
											<td class="lInfoSellTblTd1">배송비결제</td>
											<td class="lInfoSellTblTd2">
											<c:if test="${item.ITEM_DELIVERY_CHARGE_TYPE eq '1' or item.ITEM_DELIVERY_CHARGE_TYPE eq '2' }">
												무료배송
											</c:if>
											<c:if test="${item.ITEM_DELIVERY_CHARGE_TYPE ne '1' and item.ITEM_DELIVERY_CHARGE_TYPE ne '2' }">
												<select name="delivery_charge">
													<option value="">선택</option>
													<option value="2">주문시결제(선결제)</option>
													<option value="3">상품수령시결제(착불)</option>
												</select>
											</c:if>
											</td>
										</tr>
										<tr>
											<td class="lInfoSellTblTd1">배송운임</td>
											<td class="lInfoSellTblTd2">
												<div>택배</div>
												<div class="lInfoSellDeliInfo">착불배송, 제주 및 도서산간 지역은 추가 배송비 부과 가능</div>
												<div class="lInfoClearBoth"></div>
											</td>
										</tr>
										<!-- <tr>
											<td class="lInfoSellTblTd1">배송정보</td>
											<td class="lInfoSellTblTd2">평균발송일 <b> 2.5</b>일 이내</td>
										</tr> -->
									</tbody>
								</table>
							</div>
						</div>
						
						
						<!-- 추가옵션 여부 확인 -->
						<c:forEach var="option" items="${itemOption }">
							<c:if test="${option.IO_TYPE eq 1 }">
								<c:set var="isAddOption" value="true"/>
							</c:if>
						</c:forEach>
						<c:set var="itemPrice" value="${item.ITEM_LAST_PRICE }"/>
						
						<div id="lPay">
							<div id="itemOptSelect">
								<table>
									<tbody>
								
						<!-- 필수옵션 시작 -->
						<c:set var="arrOptionSubject" value="${fn:split(item.ITEM_OPTION_SUBJECT, ',') }"/>
						<c:if test="${not empty item.ITEM_OPTION_SUBJECT }">
							<c:choose>
								<c:when test="${fn:length(arrOptionSubject) gt 1 }">
									<c:forEach var="subject" items="${arrOptionSubject }" varStatus="status">
										<tr>
											<th>${subject }</th>
											<td>
												<select name="select_option" id="select_option_${status.index }" ${status.index gt 0 ? 'disabled="desabled"':'' } onchange="changeSelectOption(this, ${status.index});">
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
											<th>${item.ITEM_OPTION_SUBJECT }</th>
											<td>
												<select name="select_option" id="select_option_${status.index }" ${status.index gt 0 ? 'disabled="desabled"':'' } onchange="changeSelectOption(this, ${status.index});">
													<option value="">선택</option>
											<c:forEach var="option" items="${itemOption }">
												<c:if test="${option.IO_TYPE eq 0 }">
													<c:if test="${option.IO_STOCK_QTY eq 0 }">
														<option value="${fn:replace(option.IO_NAME, '^', '') }" io_price="${option.IO_PRICE }" io_stock_qty="${option.IO_STOCK_QTY }">${fn:replace(option.IO_NAME, '^', '') }(품절)</option>
													</c:if>
													<c:if test="${option.IO_STOCK_QTY ne 0 }">
														<option value="${fn:replace(option.IO_NAME, '^', '') }" io_price="${option.IO_PRICE }" io_stock_qty="${option.IO_STOCK_QTY }">${fn:replace(option.IO_NAME, '^', '') }( +<fmt:formatNumber value="${option.IO_PRICE }"/>) ${option.IO_STOCK_QTY }개</option>
													</c:if>
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
											<td>추가옵션</td>
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
									
									<c:if test="${empty item.ITEM_OPTION_SUBJECT and item.ITEM_QTY gt 0 }">
										<tr>
											<th valign="middle">${item.ITEM_NAME }</th>
											<td valign="top" class="qty">
												<div class="wrap">
													<input type="hidden" name="option_name" value="${item.ITEM_NAME }"/>
													<input type="hidden" name="option_type" value="0"/>
													<input type="hidden" name="option_price" value="0"/>
													<input type="hidden" name="option_qty" value="${item.ITEM_QTY }"/>
													<input type="text" name="option_order_qty" value="1" onkeyup="checkItemQty(this);">
													<button class="btnUp" type="button" onclick="changeItemOptionOrderQty(this, '+');">+</button>
													<button class="btnDown" type="button" onclick="changeItemOptionOrderQty(this, '-');">-</button>
												</div>
											</td>
											<td valign="middle" class="amt">
												<div class="wrap">
													<!-- <button>X</button> -->
												</div>
												<span><fmt:formatNumber value="${itemPrice }"/></span>&nbsp;원
											</td>
										</tr>
									</c:if>
									
									</tbody>
									<!-- 추가옵션상품 수량 입력필드 추가 영역 -->
									<tfoot>
									
									</tfoot>
								</table>
							</div>
							<div id="lPayRes" style="display: ${empty item.ITEM_OPTION_SUBJECT ? 'block':'none'};">
								<span class="amt">총 상품금액(수량) : <strong id="lPayResAmt"><fmt:formatNumber value="${itemPrice }"/></strong><b>원</b></span>
								<span class="qty">(<strong id="lPayResQty">1</strong>개)</span>
							</div>
							<div id="lItemOptDummy"></div>
						</div>
					</form>
	
					<c:if test="${not empty sessionScope.rb_member and sessionScope.rb_member.MB_TYPE eq 1 }">
						<div id="lPayBottom">
							
							<form name="payFrm" method="post">
								<input type="hidden" name="order_no" value=""/>
							</form>
	
							<a href="javascript:void(0);" onclick="insertCart(1); return false;">
								<button class="buy" id="lPayBtnBuy">구매하기</button>
							</a>
							<a href="javascript:void(0);" onclick="insertCart(2); return false;">
								<button class="normal" id="lPayBtnCart">장바구니</button>
							</a>
							<a href="javascript:void(0);" onclick="myItemRegist(this, '${item.ITEM_SEQ}')">
								<button class="normal">
									<img id="addMyFavorItem" src="/images/item/view/icon_favorite_${item.ITEM_SEQ eq item.IS_FAVORITE ? 'on':'off' }.png" width="16" height="15" title="관심상품등록" alt="관심상품등록" style="vertical-align: -2px;"> 관심상품등록
								</button>
							</a>
	
							<div id="lPayCartNotice">
								<div class="title">장바구니 담기</div>
								<div class="contents">
									장바구니에 상품을 담았습니다<br> 바로 확인하겠습니까?
								</div>
								<div class="btn">
									<button class="cart" onclick="location.href='/item/itemCartList.do'">장바구니로</button>
									<button class="continue" onclick="javascript:$('#lPayCartNotice').hide();">계속 쇼핑</button>
								</div>
								<button class="close" onclick="javascript:$('#lPayCartNotice').hide();">닫기</button>
							</div>
						</div>
					</c:if>
	
						<div id="lPayDonate"></div>
	
						<!-- <div id="lBtm" class="hide">
							<div id="lBtmBar">
								<span class="amt"> 총 상품금액(수량) : <strong id="lBtmAmt">0</strong>원
								</span> <span class="qty"> (<strong id="lBtmQty">0</strong>개)
								</span>
	
								<button id="lBtmBuy" onclick="$('#lPayBtnBuy').click()">바로구매</button>
								<button id="lBtmCart" onclick="$('#lPayBtnCart').click()">장바구니</button>
								<button id="lBtmFav" onclick="$('#lPayBtnFav').click()">관심상품</button>
								<button id="lBtmFolder" onclick="javascript:toggleBtmBody()">펼치기/접기</button>
							</div>
							<div id="lBtmBody">
								<ul id="lBtmBodyTop">
									<li><a href="#" onclick="openWindow('/main/popup/item/popup_itemOptionView.php?no=7459212&amp;market=dome', 'itemOptView', '600', '600', 'scrollbars=yes,resizable=yes'); return false;">
											전체옵션보기 <img src="http://211.43.195.137/image/item/view/ico_moreOption.png" width="12" height="11" alt="전체옵션보기">
									</a></li>
									<li>배송비 <b>2,500</b>원 ~
									</li>
									<li id="lBtmDeliChoose"><span>배송비결제</span></li>
								</ul>
							</div>
						</div> -->
	
	
						<!-- 관련상품 영역(나중에 추가) -->
						<section id="lSummaryPacking">
							
						</section>
						
						
						<ul class="lTap" id="lTapView">
							<li class="sel"><a href="#lTapView">상품정보</a></li>
							<li><a href="#lTapReview">구매후기 (<b>0</b>)</a></li>
							<li><a href="#lTapSupport">상품문의 (<b>0</b>)</a></li>
							<li><a href="#lTapSeller">판매자/반품/교환정보</a></li>
						</ul>
	
						<div id="lInfoView">
							<div class="lInfoViewSubWrap">
								<form method="post" name="itemCom" action="/main/item/itemIng.php" onsubmit="return lInfoViewSubMemoReg()">
									<input type="hidden" name="mode" value="itemCom"> <input type="hidden" name="no" value="7459212">
									<table class="lInfoViewSubTbl">
										<tbody>
											<tr>
												<td class="lInfoViewSubTd1">상세설명 이미지 사용여부</td>
												<td class="lInfoViewSubTd2" style="vertical-align: middle;">
													<div class="lInfoViewImgUse">
														<div>
															<b>사용불가</b>
														</div>
														<div>본 이미지는 레인보우에 저작권이 있으며 어떠한 경우라도 무단 도용시 법적(민형사상)책임이 따릅니다.</div>
													</div>
													<div class="lInfoViewBtn">
														<div class="lInfoClearBoth"></div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
	
	
							<!-- 상품설명 -->
							<div class="lInfoViewItemContents" id="lInfoViewItemContents">
								${item.ITEM_CONTENT }
								<!-- 외부 이미지 로딩 부분 -->
								<div id="preloadArea" class="gDisplayNone"></div>
							
							</div>
	
						</div>
						
						<ul class="lTap" id="lTapReview">
							<li><a href="#lTapView">상품정보</a></li>
							<li class="sel"><a href="#lTapReview">구매후기 (<b>0</b>)</a></li>
							<li><a href="#lTapSupport">상품문의 (<b>0</b>)</a></li>
							<li><a href="#lTapSeller">판매자/반품/교환정보</a></li>
						</ul>
	
						<div id="lReview">
							<div id="lReviewHead">
								<div style="float: left">도매꾹은 소중한 구매후기를 가감없이 보여주는 정직한
									사이트입니다</div>
	
							</div>
	
							<table id="lReviewTbl">
								<colgroup>
									<col width="95px">
									<col width="*">
									<col width="95px">
									<col width="95px">
									<col width="95px">
								</colgroup>
	
								<thead>
									<tr>
										<th>만족도</th>
										<th colspan="2">내용</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
								</thead>
	
								<tbody>
									<tr>
										<td class="scoreTd">
											<img src="/images/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별"><img src="/images/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별"><img src="/images/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별">
										</td>
										<td class="memoTd">양모레자306~8매</td>
										<td class="delTd"></td>
										<td>hot*******</td>
										<td>17/12/09</td>
									</tr>
									<tr>
										<td class="scoreTd">
											<img src="/images/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별"><img src="/images/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별"><img src="/images/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별">
										</td>
										<td class="memoTd">감사합니다</td>
										<td class="delTd"></td>
										<td>csj****</td>
										<td>17/12/05</td>
									</tr>
								</tbody>
							</table>
	
							<div id="lReviewPage">
								<ol>
									<li class="curr"><a href="javascript:drawReviewTbody(1)">1</a></li>
									<li><a href="/7459212#lTapReview" onclick="drawReviewTbody(2)">2</a></li>
								</ol>
								<a href="javascript:drawReviewTbody(2)" class="btn af1">1페이지
									후</a>
								<div id="lReviewPageInputs">
									<input type="text" id="lReviewPgInput" value="1"><input type="button" value="이동" onclick="drawReviewTbody(document.getElementById('lReviewPgInput').value)"><span>총
										<b>2</b>페이지
									</span>
								</div>
							</div>
						</div>
	
						<ul class="lTap" id="lTapSupport">
							<li><a href="#lTapView">상품정보</a></li>
							<li><a href="#lTapReview">구매후기 (<b>0</b>)</a></li>
							<li class="sel"><a href="#lTapSupport">상품문의 (<b>0</b>)</a></li>
							<li><a href="#lTapSeller">판매자/반품/교환정보</a></li>
						</ul>
						
						<div id="lSupport">
							
							<!-- 상품문의 목록영역[시작] -->
							<div id="lSupportList" style="display: block;">
								<div id="lSupportListTop">
									<ul>
										<li>
											<span class="lSupportViewTopColor">판매자가 확인한 문의글은 수정하거나 삭제할 수 없으며,</span> 먼저 등록된 문의글을 확인하면 보다 유익한 정보를 얻을 수 있습니다
										</li>
									</ul>
									<div id="lSupportListWriteBtn">
										<input type="button" value="문의글 작성" onclick="changeItemQnaDiv(1);">
									</div>
								</div>
								<div id="lSupportListPage">
									<table>
										<colgroup>
											<col width="95px">
											<col width="95px">
											<col width="*">
											<col width="95px">
											<col width="95px">
										</colgroup>
										<thead>
											<tr>
												<th>번호</th>
												<th>상태</th>
												<th>내용</th>
												<th>작성자</th>
												<th>작성일</th>
											</tr>
										</thead>
										<!-- 상품문의 들어가는곳 -->
										<tbody>
										</tbody>
									</table>
								</div>
								
								<table style="width:100%;border:0;background-color:#ffffff;text-align:center;margin-top:10px;">
									<tbody>
										<tr id="qaPaging">
										</tr>
									</tbody>
								</table>
							
							</div>
							<!-- 상품문의 목록영역[끝] -->
						
							<!-- 문의글 작성영역[시작] -->
							<div id="lSupportWrite" style="display: none;">
								<div id="lSupportWriteTop">
									<ul>
										<li>
											<span class="lSupportWriteTopColor">판매자가 확인한 문의글은 수정하거나 삭제할 수 없으며,</span> 먼저 등록된 문의글을 확인하면 보다 유익한 정보를 얻을 수 있습니다
										</li>
									</ul>
									<div id="lSupportListWriteBtn">
										<input type="button" value="문의글 목록" onclick="changeItemQnaDiv(2);">
									</div>
								</div>
							
								<div id="lSupportWritePage">
									
									<form name="iqaFrm" id="lSupportWriteFrm" method="post" action="" enctype="multipart/form-data" onsubmit="return iqaPaging();">
										<input type="hidden" name="item_seq" value="${item.ITEM_SEQ }">
										<input type="hidden" name="iqa_open" value="0"/>
										<input type="hidden" name="page" id="page" value="1"/>
										<input type="hidden" name="pageSize" id="pageSize" value="5"/>
									
									<div id="lSupportWriteTblWrap">
										<table>
											<colgroup>
												<col width="95px">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>상품제목</th>
													<td class="lSuportWriteItemTitle">${item.ITEM_NAME }</td>
												</tr>
												<!-- <tr>
													<th>답변받기</th>
													<td>
														<span class="lSupportWriteCheckBoxWrap">
															<input type="checkbox" id="lSupportWriteCheckbox" name="msg" value="1">
															<label for="lSupportWriteCheckbox">쪽지로 받음</label>
														</span>
														<span class="lSupportWriteCheckBoxWrap">
															<input type="checkbox" id="lSupportWriteCheckbox2" name="mail" value="1">
															<label for="lSupportWriteCheckbox2">메일로 받음</label>
														</span>
														<span class="lSupportWriteCheckBoxWrap">
															<input type="checkbox" id="lSupportWriteCheckbox3" name="sms" value="1">
															<label for="lSupportWriteCheckbox3">문자메세지로 받음</label>
														</span>
													</td>
												</tr> -->
												<tr>
													<th>비밀글 지정</th>
													<td>
														<div class="lSupportWriteCheckBoxWrap">
															<input type="checkbox" id="lSupportWriteCheckbox4" name="chk_iqa_open" value="1" onclick="checkIqaOpen(this);">
															<label for="lSupportWriteCheckbox4">문의한 내용을 판매자만 확인할 수 있도록 비밀글로 지정합니다.</label>
														</div>
													</td>
												</tr>
												<tr>
													<th>문의제목</th>
													<td><input type="text" name="iqa_subject" maxlength="80" value=""/></td>
												</tr>
												<tr>
													<th class="lSupportWriteMemo">문의내용</th>
													<td>
														<div class="lSupportWriteNotice">
															매매, 당사자간 직거래 유도시, 문의글 삭제 및 회원탈퇴 조치됩니다 (HTML 태그 사용불가)<br>
															비방, 광고, 불건전한 내용의 글은 관리자에 의해 사전동의 없이 삭제될 수 있습니다<br>
															이메일 주소나 전화번호 등 개인정보를 입력할 경우 타인에 의해 도용될 수 있으니 주의바랍니다
														</div>
														<textarea name="content"></textarea>
														<div class="lSupportEditFileWrap"></div>
														<div class="lSupportWriteImageWrap">
															<div class="lSupportWriteImage">
																<img src="/images/item/view/attach_image.png" style="vertical-align:-1px; margin-right:4px;">이미지첨부
															</div>
															<div class="lSupportWrtieImageFiles">
																<input type="file" name="attach_image" value=""/>
															</div>
															<!-- <input type="button" value="이미지추가" onclick="lSupportWriteAddImage();"> -->
														</div>
														<div style="margin-top:10px; margin-left:98px; color:#aaaaaa; clear:both;">모든 이미지는 관리자가 검토하니 주의해주세요</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="lSupportWriteSubmit">
										<input type="button" id="btnQaRegt" value="문의글등록" onclick="addShopItemQa();">
										<input type="button" value="취소" onclick="changeItemQnaDiv(2);">
									</div>
									</form>
								</div>
							</div>
							<!-- 문의글 작성영역[끝] -->
							
							<!-- 문의글 뷰 영역[시작] -->
							<div id="lSupportView" style="display: none;">
							</div>
							<!-- 문의글 뷰 영역[끝] -->
							
						</div>
	
						<ul class="lTap" id="lTapSeller">
							<li><a href="#lTapView">상품정보</a></li>
							<li><a href="#lTapReview">구매후기 (<b>0</b>)</a></li>
							<li><a href="#lTapSupport">상품문의 (<b>0</b>)</a></li>
							<li class="sel"><a href="#lTapSeller">판매자/반품/교환정보</a></li>
						</ul>
	
						<div id="lSeller">
							<div id="sellerSellInfo">
								<div class="sellInfoSymbol">
									<img src="http://211.43.195.137/image/item/view/ico_greatMember.png" width="17" height="12" alt="우수판매" title="우수판매" class="good">
									우수판매<span> | </span>판매1등급<span> | </span>사업자인증
								</div>
	
								<div class="sellerInfoSimple">
									<div class="sellerNickId">
										<span class="nick">우현상사</span> <span class="id">(dks5309)</span>
									</div>
	
									<div class="sellerSatisfy" title="최근 6개월 이내 수령확인된 주문건 기준">
										<img src="http://211.43.195.137/image/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별">&nbsp;<img src="http://211.43.195.137/image/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별">&nbsp;<img src="http://211.43.195.137/image/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별">&nbsp;<img src="http://211.43.195.137/image/item/view/ico_starOn.png" width="13" height="12" alt="찬별" title="찬별">&nbsp;<img src="http://211.43.195.137/image/item/view/ico_starHalf.png" width="13" height="12" alt="반별" title="반별">&nbsp; <span>(
											99% / 1,087명 )</span>
									</div>
	
									<div class="wishSellerNQuestionBtns" style="margin-top: 6px;">
										<a href="/main/myBuy/wish/my_wishIng.php?mode=addWishMember&amp;no=7459212" target="actionFrame" class="wishSellerBtn"> <img src="http://211.43.195.137/image/item/view/ico_heartOff.png" width="13" height="12"> 관심판매자등록
										</a> <a href="/main/member/mem_formLogin.php?back=Lzc0NTkyMTI%2Fbm89NzQ1OTIxMg%3D%3D" class="questionBtn">상품문의</a>
									</div>
								</div>
							</div>
	
							<div id="otherItemListWrap">
								<ul id="otherItemTabsUl">
	
									<li class="basicTab selected" onclick="otherItemsView('basic', this)"><span class="tabText">판매자의 다른상품</span> <a href="/main/item/itemList.php?sf=id&amp;sw=dks5309" target="_blank">더보기</a></li>
								</ul>
	
	
								<ul id="basicOtherItemsUl" class="otherItemsUlBlock">
	
									<li><a href="/7515584?market=dome" target="_blank"> <img src="http://211.43.195.137//upload/item/2017/11/03/15096912468EFD27F33006ADEE0D5317/15096912468EFD27F33006ADEE0D5317_stt_150.png" width="80" height="80" alt="상품이미지" title="상품이미지">
											[우현상사]렉스퍼머플러/밍크목도리/퍼머플러
									</a>
	
										<div class="amtWrap">
											<span>2,500</span> 원
										</div></li>
	
									<li><a href="/5526997?market=dome" target="_blank"> <img src="http://211.43.195.137//upload/item/2013/01/23/135891754668EB29006CB006BF3DDCF0/135891754668EB29006CB006BF3DDCF0_stt_150.png" width="80" height="80" alt="상품이미지" title="상품이미지"> 우현상사
											고급런닝브라/디자인다양/사이즈다양/좋은소
									</a>
	
										<div class="amtWrap">
											<span>5,500</span> 원
										</div></li>
	
									<li><a href="/7424461?market=dome" target="_blank"> <img src="http://211.43.195.137//upload/item/2017/08/31/15041700446DAA03AF4F0A04451FE652/15041700446DAA03AF4F0A04451FE652_stt_150.png" width="80" height="80" alt="상품이미지" title="상품이미지"> [우현상사]
											피치기모 원피스/투피스/잠옷/홈웨어
									</a>
	
										<div class="amtWrap">
											<span>4,500</span> 원
										</div></li>
	
									<li><a href="/5538709?market=dome" target="_blank"> <img src="http://211.43.195.137//upload/item/2013/02/13/136075019707A5B76B205CF1F2323072/136075019707A5B76B205CF1F2323072_stt_150.png" width="80" height="80" alt="상품이미지" title="상품이미지"> 우현상사
											빅사이즈고급면팬티5종/면100%/색상다양/사
									</a>
	
										<div class="amtWrap">
											<span>1,300</span> 원
										</div></li>
	
									<li><a href="/6937391?market=dome" target="_blank"> <img src="http://211.43.195.137//upload/item/2016/09/08/1473316744839EE786C77BCC0044974B/1473316744839EE786C77BCC0044974B_stt_150.png" width="80" height="80" alt="상품이미지" title="상품이미지"> [우현상사]
											피치기모 원피스/투피스/잠옷/홈웨어
									</a>
	
										<div class="amtWrap">
											<span>4,500</span> 원
										</div></li>
								</ul>
							</div>
	
							<ul id="sellerHInfoUl">
								<li style="width: 434px; line-height: 14px; padding-bottom: 0;">·
									상호/대표자명 : 우현상사 / 정회원만 열람가능</li>
								<li style="width: 400px; line-height: 14px; text-indent: -82px; padding-left: 90px; padding-bottom: 0;">·
									사업장소재지 : 정회원만 열람가능</li>
								<li>· 사업자등록번호 : 정회원만 열람가능</li>
								<li>· 연락처 : 정회원만 열람가능</li>
							</ul>
						</div>
	
						<div id="lSellerBody">
							<div id="cleanCampaign">
								<img src="/imageㄴ/item/view/ico_notice.png" alt="도매꾹 클린캠페인" title="클린캠페인 이미지" width="20" height="25">
								<b class="title">클린캠페인</b>
								<div id="reportBtn">
									<a onclick="cleanSupWritePop(7459212, '', 'Lzc0NTkyMTI%2Fbm89NzQ1OTIxMg%3D%3D');" title="신고하기" target="_blank">신고하기</a>
								</div>
								<br>
								<ul>
									<li>· 도매꾹의 서비스를 이용하지 않고, 판매자에게 직접 상품대금을 지급하는 직거래 시 피해가 발생될
										수 있으니 주의 바랍니다</li>
									<li>· 직거래로 발생한 피해에 대해 도매꾹은 책임을 지지 않습니다</li>
									<li>· 구매자의 권리를 보호하고 안전한 거래를 위해 클린캠페인을 시행합니다. &nbsp; 불법상품 및
										부적격 상품의 판매 또는 부적절한 광고내용이나 권리침해 발생 시 신고해주세요</li>
								</ul>
							</div>
							<div class="lSellerBodyDiv">
								<b class="title">반품/교환정보</b><br> <br> 반품 및 교환은 상품 수령확인을
								하지 않은 상태에서 상품 수령 후 7일 이내 판매자와 협의하여 신청하실 수 있습니다<br> (상품 수령확인
								이후 샘플 구매시 반품이 불가능하며, 판매자가 반품을 수락할 경우에만 반품을 하실 수 있습니다)
	
								<p>
									<b>반품 및 교환이 불가능한 경우</b><br>
								</p>
								<ul>
									<li>· 구매자 단순 변심 시, 반품가능기간(상품 수령 후 7일)이 경과된 경우</li>
									<li>· 포장을 개봉하였거나 포장이 훼손되어 상품가치가 현저히 상실된 경우(예. 식품, 화장품, 향수류
										등)</li>
									<li>· 구매자의 사용(라벨이 떨어진 의류 등) 또는 시간의 경과에 의하여 상품의 가치가 현저히 감소한
										경우</li>
									<li>· 고객주문 확인 후, 상품제작에 진행되는 주문제작 상품인 경우</li>
									<li>· 복제가 가능한 상품 등의 포장을 훼손한 경우(CD, DVD, 게임, 도서 등의 경우 포장 개봉
										시)</li>
								</ul>
								<p></p>
								<p>
									<b>배송비 부담 정책</b>
								</p>
								<ul>
									<li>· 판매자 부담 : 판매자의 관리소홀 및 부주의로 인해 훼손/파손된 제품 및 상품설명과 상이한
										제품이 배송된 경우</li>
									<li>· 구매자 부담 : 구매자의 단순변심 및 판단착오로 인한 교환/반품의 경우</li>
								</ul>
								<p></p>
								<p>
									<b>반품 및 교환절차</b><br> · 판매자와 협의 &gt; 구매관리 &gt; 배송중 &gt; 해당상품
									제목클릭 &gt; 주문서내 [반품요청] 버튼클릭 (자세한 절차는 <a href="http://domeggook.com/main/popup/help/popup_helpsView.php?no=2314&amp;mode=help" onclick="popupHelpView(2314, ''); return false;" title="반품요청절차" target="_blank">도움말</a> 참조)
								</p>
							</div>
							<div id="sellerInfo">
								<b>판매자 입력정보</b>
								<ul>
									<li>· 반품비용 : 상세정보 별도표기</li>
									<li>· 교환.반품.보증/배상금 지급조건 : 상세정보 별도표기</li>
									<li>· 피해보상/분쟁처리 : 상세정보 별도표기</li>
									<li>· 약관확인 : 상세정보 별도표기</li>
								</ul>
							</div>
						</div>
						
					</div>
				</div>
			</div>

			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>