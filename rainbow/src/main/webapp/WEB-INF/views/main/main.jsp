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
<link rel="stylesheet" type="text/css" href="/css/main/main.css">

<script type="text/javascript" src="/js/lib/jssor.slider-27.1.0.min.js"></script>
<script type="text/javascript" src="/js/main/main.js"></script>
</head>
	<body>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle" style="width: 100%;">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					<div id="MainWrap">
						<!-- 메인 슬라이더 -->
					    <div id="mainSlider_div">
					        <!-- 로딩바 -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="/images/common/loading.gif" />
					        </div>
					        <!-- 슬라이더 영역 -->
					        <div data-u="slides" style="cursor:pointer;position:relative;top:0px;left:0px;width:980px;height:380px;overflow:hidden;">
					            <!-- 클래스 추가시 이미지 레이어에 클래스 붙음 -->
					            
					        <c:forEach var="data" items="${resultMap.advertiseList }">
					        	<div class="slider_img" ad-link ="${data.AD_LINK }" data-p="170.00">
					                <img data-u="image" src="${data.AD_IMAGE_PATH }" />
					                <img data-u="thumb" src="${data.AD_IMAGE_PATH }" />
					            </div>
					        </c:forEach>
					        
					        </div>
					        <!-- 썸네일 네비게이터 -->
					        <div data-u="thumbnavigator" class="jssort101" style="position:absolute;left:0px;bottom:0px;width:980px;height:100px;background-color:#000;" data-autocenter="1" data-scale-bottom="0.75">
					            <div data-u="slides">
					            	<!-- 클래스 추가시 이미지에 클래스 붙음 -->
					                <div data-u="prototype" class="p" style="width:190px;height:90px;cursor: pointer;">
					                    <div data-u="thumbnailtemplate" class="t"></div>
					                    <svg viewbox="0 0 16000 16000" class="cv">
					                        <circle class="a" cx="8000" cy="8000" r="3238.1"></circle>
					                        <line class="a" x1="6190.5" y1="8000" x2="9809.5" y2="8000"></line>
					                        <line class="a" x1="8000" y1="9809.5" x2="8000" y2="6190.5"></line>
					                    </svg>
					                </div>
					            </div>
					        </div>
					        <!-- 좌측 화살표 버튼 -->
					        <div data-u="arrowleft" class="jssora106" style="width:55px;height:55px;top:162px;left:30px;" data-scale="0.75">
					            <svg viewbox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
					                <circle class="c" cx="8000" cy="8000" r="6260.9"></circle>
					                <polyline class="a" points="7930.4,5495.7 5426.1,8000 7930.4,10504.3 "></polyline>
					                <line class="a" x1="10573.9" y1="8000" x2="5426.1" y2="8000"></line>
					            </svg>
					        </div>
					        <!-- 우측 화살표 버튼 -->
					        <div data-u="arrowright" class="jssora106" style="width:55px;height:55px;top:162px;right:30px;" data-scale="0.75">
					            <svg viewbox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
					                <circle class="c" cx="8000" cy="8000" r="6260.9"></circle>
					                <polyline class="a" points="8069.6,5495.7 10573.9,8000 8069.6,10504.3 "></polyline>
					                <line class="a" x1="5426.1" y1="8000" x2="10573.9" y2="8000"></line>
					            </svg>
					        </div>
					    </div>
					    <!-- //메인 슬라이더끝 -->
					    <!-- 오늘등록 상품 -->
					    <div class="mainTodayItemList_header_div">
				    		<div class="border_div"></div>
				    		<div class="title_div">
				    			<div class="title_wrap"><h1>신상 입고</h1></div>
				    		</div>
				    	</div>
					    <div id="mainTodayItemList_div">
					    	<div id="itemListAreaMain_type1_div">
								<ol id="itemListArea_ol">
								
								<c:forEach var="data" items="${resultMap.newItemList }">
									<li class="itemRow_li ${data.ITEM_QTY eq 0 ? 'soldOut':'' }">
										<a class="itemThumb_a" href="#" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE }'); return false;">
											<img item_seq="${data.ITEM_SEQ }" class="itemThumb_img draggableItem" src="${data.ITEM_REPRESENT_IMAGE }" alt="${data.ITEM_NAME }" title="${data.ITEM_NAME }">
											<c:if test="${data.ITEM_QTY eq 0 }"><img class="soldOut_img" src="/images/common/soldOut.png"></c:if>
										</a>
										<div class="itemTitle_div">
											<div class="itemTitleInner_div"></div>
											<a class="itemTitleInner_a" href="#" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE }'); return false;">${data.ITEM_NAME }</a>
										</div>
										<div class="itemState_div">
											<div class="itemPrice_div">
												<b class="itemPriceBefore_b"><del><fmt:formatNumber value="${data.ITEM_CUST_PRICE }"/></del></b>원<strong class="itemPriceAfter_b"><fmt:formatNumber value="${data.ITEM_LAST_PRICE }"/></strong>원
											</div>
										</div>
									</li>
								</c:forEach>
								
								</ol>
							</div>
					    </div>
					    <!-- // 오늘 등록 상품 끝 -->
						<!-- 구분광고1 -->
					    <div id="mainAdvertise_1_div">
					    	<img src="/images/main/ad3.jpg">
					    </div>
					    <!-- //구분광고1 끝 -->
					    <div class="mainTodayItemList_header_div">
				    		<div class="border_div"></div>
				    		<div class="title_div">
				    			<div class="title_wrap"><h1>인기 상품</h1></div>
				    		</div>
				    	</div>
					    <!-- 인기 상품 -->
					    <div id="mainPopularItemList_div"> 
					    	<div id="itemListAreaMain_type2_div">
								<ol id="itemListArea_ol">
								
								<c:forEach var="data" items="${resultMap.popularItemList }">
									<li class="itemRow_li ${data.ITEM_QTY eq 0 ? 'soldOut':'' }">
										<a class="itemThumb_a" href="#" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE }'); return false;">
											<img item_seq="${data.ITEM_SEQ }" class="itemThumb_img draggableItem" src="${data.ITEM_REPRESENT_IMAGE }" alt="${data.ITEM_NAME }" title="${data.ITEM_NAME }">
											<c:if test="${data.ITEM_QTY eq 0 }"><img class="soldOut_img" src="/images/common/soldOut.png"></c:if>
										</a>
										<div class="itemTitle_div">
											<div class="itemTitleInner_div"></div>
											<a class="itemTitleInner_a" href="#" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE }'); return false;">${data.ITEM_NAME }</a>
										</div>
										<div class="itemState_div">
											<div class="itemPrice_div">
												<b class="itemPriceBefore_b"><del><fmt:formatNumber value="${data.ITEM_CUST_PRICE }"/></del></b>원<strong class="itemPriceAfter_b"><fmt:formatNumber value="${data.ITEM_LAST_PRICE }"/></strong>원
											</div>
										</div>
									</li>
								</c:forEach>
									
								</ol>
							</div>
					    </div>
					    <!-- // 인기 상품 끝 -->
					    <!-- 구분광고2 -->
					    <div id="mainAdvertise_2_div">
					    	<img src="/images/main/ad1.png">
					    </div>
					    <div class="mainTodayItemList_header_div">
				    		<div class="border_div"></div>
				    		<div class="title_div">
				    			<div class="title_wrap"><h1>특가 상품</h1></div>
				    		</div>
				    	</div>
					    <!-- //구분광고2 끝 -->
					    <!-- 특가 상품 -->
					    <div id="mainSaleItemList_div">
					    	<div id="itemListAreaMain_type1_div">
								<ol id="itemListArea_ol">
								
								<c:forEach var="data" items="${resultMap.specialPriceItemList }">
									<li class="itemRow_li ${data.ITEM_QTY eq 0 ? 'soldOut':'' }">
										<a class="itemThumb_a" href="#" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE }'); return false;">
											<img item_seq="${data.ITEM_SEQ }" class="itemThumb_img draggableItem" src="${data.ITEM_REPRESENT_IMAGE }" alt="${data.ITEM_NAME }" title="${data.ITEM_NAME }">
											<c:if test="${data.ITEM_QTY eq 0 }"><img class="soldOut_img" src="/images/common/soldOut.png"></c:if>
										</a>
										<div class="itemTitle_div">
											<div class="itemTitleInner_div"></div>
											<a class="itemTitleInner_a" href="#" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE }'); return false;">${data.ITEM_NAME }</a>
										</div>
										<div class="itemState_div">
											<div class="itemPrice_div">
												<b class="itemPriceBefore_b"><del><fmt:formatNumber value="${data.ITEM_CUST_PRICE }"/></del></b>원<strong class="itemPriceAfter_b"><fmt:formatNumber value="${data.ITEM_LAST_PRICE }"/></strong>원
											</div>
										</div>
									</li>
								</c:forEach>
									
								</ol>
							</div>
					    </div>
					    <!-- // 특가 상품 끝 -->
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>