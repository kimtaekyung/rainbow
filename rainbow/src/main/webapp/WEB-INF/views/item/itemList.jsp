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
<link rel="stylesheet" type="text/css" href="/css/item/itemList.css">

<script type="text/javascript" src="/js/item/itemList.js"></script>

</head>
	<body>
		<c:set var="itemList" value="${resultDataMap.itemList }"/>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
				
					<div id="itemList">
						<div class="pageNavigtor_div">
							<!-- <a class="pageNavigtor_a" href="/main.do">전체</a> -->
							<a class="pageNavigtor_a" href="" onclick="searchItemListInNavi('0');return false;">전체</a>
						<c:if test="${not empty resultDataMap.p_cate_code1 }">
							&gt; <a class="pageNavigtor_a" href="" onclick="searchItemListInNavi('1');return false;" cate_code1="${resultDataMap.p_cate_code1 }">${resultDataMap.cate_code1_name }</a>
						</c:if>
						<c:if test="${not empty resultDataMap.p_cate_code2 }">
							&gt; <a class="pageNavigtor_a" href="" onclick="searchItemListInNavi('2');return false;" cate_code2="${resultDataMap.p_cate_code2 }">${resultDataMap.cate_code2_name }</a>
						</c:if>
						</div>
						
						<%-- <form id="itemFrm" action="/item/itemList.do" method="get">
							<input type="hidden" name="page" value="${resultDataMap.page }"/>
							<input type="hidden" name="pageSize" value="${resultDataMap.pageSize }"/>
							<input type="hidden" name="cate_code1" value="${resultDataMap.cate_code1 }">
							<input type="hidden" name="cate_code2" value="${resultDataMap.cate_code2 }">
							<input type="hidden" name="sch_order" value="${resultDataMap.sch_order }">
							<input type="hidden" name="start_price" value="${resultDataMap.start_price }">
							<input type="hidden" name="end_price" value="${resultDataMap.end_price }">
							<input type="hidden" name="price_idx" value="${resultDataMap.price_idx }">
						</form> --%>
						<div id="itemSortArea_div">
			                <ul id="itemSortArea_ul">
		                        <li class="${resultDataMap.p_sch_order eq '1' ? 'selected':'' }"><a class="itemSort_a" onclick="searchItemListInOrder('1');">낮은가격순</a></li>
		                        <li class="${resultDataMap.p_sch_order eq '2' ? 'selected':'' }"><a class="itemSort_a" onclick="searchItemListInOrder('2');">높은가격순</a></li>
		                        <li class="${resultDataMap.p_sch_order eq '3' ? 'selected':'' }"><a class="itemSort_a" onclick="searchItemListInOrder('3');">최신순</a></li>
		                        <li class="${resultDataMap.p_sch_order eq '4' ? 'selected':'' } last"><a class="itemSort_a" onclick="searchItemListInOrder('4');">판매량순</a></li>
			                </ul>
        				</div>
        				<div id="itemSearchCount_div">
        					<span>총 <b>${resultDataMap.total }</b>건이 검색되었습니다</span>
        				</div>
						<div id="itemListArea_div">
							<ol id="itemListArea_ol">
							
							<c:forEach var="data" items="${itemList }" varStatus="i">
								<li class="itemRow_li ${data.ITEM_QTY eq 0 ? 'soldOut':'' }">
								
								<c:if test="${i.count lt 6 }">
									<!-- 랭킹 표시할려면 -->
									<img class="itemThumbLable_img" src="/images/item/view/rankLabel.png">
									<span class="itemThumbLable_span">${i.count }</span>
									<!--// 랭킹 표시 -->
								</c:if>
									<a class="itemThumb_a" href="javascript:void(0);" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE}'); return false;" >
										<img item_seq="${data.ITEM_SEQ }" onerror="this.src='http://via.placeholder.com/220x220'" class="itemThumb_img draggableItem" src="${data.ITEM_REPRESENT_IMAGE }" alt="${data.ITEM_NAME }" title="${data.ITEM_NAME }">
										<c:if test="${data.ITEM_QTY eq 0 }"><img class="soldOut_img" src="/images/common/soldOut.png"></c:if>
									</a>
									<div class="itemTitle_div">
										<div class="itemTitleInner_div"></div>
										<a class="itemTitleInner_a" href="javascript:void(0);" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE}'); return false;">${data.ITEM_TITLE }</a>
									</div>
									<div class="itemState_div">
										<div class="itemPrice_div">
											<b class="itemPriceBefore_b"><del><fmt:formatNumber value="${data.ITEM_CUST_PRICE }"/></del></b>원<strong class="itemPriceAfter_b"><fmt:formatNumber value="${data.ITEM_LAST_PRICE }"/></strong>원
										</div>
										<div class="itemDelivery_div">
											<span class="itemInventoryText_div">재고</span>
											<span class="itemInventoryText_div">|</span>
											<span class="itemInventoryAmount_div"><b>${data.ITEM_QTY }</b>개</span>
											<span class="itemDelivery_div">${data.ITEM_DELIVERY_CHARGE_TYPE_NAME }</span>
										</div>
									</div>
									<ul class="itemTag_ul">
										<!-- 최대 6개까지 표현 없을시 itemTag_li_type1 대신 none 클래스 li 추가 -->
										<li class="itemTag_li_type1">${data.ITEM_TAG_NAME }</li>
									<c:set var="arrTagSub" value="${fn:split(data.ITEM_TAG_SUB, ',') }"/>
									<c:forEach var="tagStr" items="${arrTagSub }" varStatus="i">
										<li class="itemTag_li_type${i.index+2 }">${tagStr }</li>
									</c:forEach>
									<c:if test="${fn:length(arrTagSub) < 5 }">
										<c:forEach begin="${fn:length(arrTagSub)+1 }" end="5" step="1">
											<li class="none"></li>
										</c:forEach>
									</c:if>
									</ul>
								</li>
							</c:forEach>
								
							</ol>
						</div>
					</div>
					
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>