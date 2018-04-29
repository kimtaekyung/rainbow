<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="/js/lib/vticker.min.js"></script>
<script type="text/javascript" src="/js/common/header.js"></script>
<link rel="stylesheet" type="text/css" href="/css/common/header.css">
<div id="lHeaderTop">
	<!-- 최상단 메뉴바입니다. -->
	<div id="headerMenubar">
		<!-- 우측 네비게이션 영역 -->
		<ul id="rightMenu">
			<c:choose>
				<c:when test="${empty sessionScope.rb_member}">
					<li class="login">
						<c:choose>
							<c:when test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'],'/auth/login.do') > -1}">
								<a>로그인&nbsp;</a>
							</c:when>
							<c:otherwise>
								<a href="/auth/login.do?<c:out value="${requestScope['javax.servlet.forward.request_uri']}"/>?${ pageContext.request.queryString}" title="로그인">로그인&nbsp;</a>
							</c:otherwise>
						</c:choose>
					</li>
					<li>
						<a href="/auth/agreement.do" title="회원가입">회원가입&nbsp;</a>
					</li>
					<li class="subMenu">
						<a href="/myPage/myPageMain.do" title="마이페이지">마이페이지&nbsp;<img src="/images/common/header/arrowDown.png" alt="open sub-menu" title="open sub-menu"></a>
						<ul style="display: none;">
							<li><a href="/myPage/memberInfoUpdate.do" title="정보수정">정보수정</a></li>
							<li><a href="/myPage/emoneyUseList.do" title="e-money통장">e-money통장</a></li>
							<li><a href="/myPage/inquiryList.do" title="1:1상담">1:1상담</a></li>
							<li><a class="lastSubMenu" href="/myPage/myPageMain.do" title="더보기 >">더보기 &gt;</a></li>
						</ul>
					</li>
					<li>
						<a href="/item/itemCartList.do" title="장바구니"><img src="/images/common/header/cart.png" alt="cart" title="cart" style="vertical-align: -1px;">&nbsp;장바구니</a>
					</li>
					<!-- <li class="subMenu">
						<a href="/buyer/buyMain.do" title="구매관리">구매관리&nbsp;<img src="/images/common/header/arrowDown.png" alt="open sub-menu" title="open sub-menu"></a>
						<ul>
							<li><a href="" title="전체구매목록">전체구매목록</a></li>
							<li><a href="" title="흥정하기">흥정하기</a></li>
							<li><a href="" title="관심상품목록">관심상품목록</a></li>
							<li><a href="" title="상품문의관리">상품문의관리</a></li>
							<li><a class="lastSubMenu" href="" title="더보기 >">더보기 &gt;</a></li>
						</ul>
					</li>
					<li class="subMenu">
						<a href="/seller/sellMain.do" title="판매관리">판매관리&nbsp;<img src="/images/common/header/arrowDown.png" alt="open sub-menu" title="open sub-menu"></a>
						<ul>
							<li><a href="" title="무료상품등록">무료상품등록</a></li>
							<li><a href="" title="상품발송예정">상품발송예정</a></li>
							<li><a href="" title="흥정하기">흥정하기</a></li>
							<li><a href="" title="등록상품관리">등록상품관리</a></li>
							<li><a href="" title="광고신청하기">광고신청하기</a></li>
							<li><a href="" title="전체문의글">전체문의글</a></li>
							<li><a href="" title="구매후기관리">구매후기관리</a></li>
							<li><a class="lastSubMenu" href="" title="더보기 >">더보기 &gt;</a></li>
						</ul>
					</li> -->
					<li><a href="/myPage/inquiryList.do" title="1:1상담">1:1상담&nbsp;</a></li>
				</c:when>
				<c:otherwise>
					<li id="rightMenuMsg">
						<img src="/images/common/header/${sessionScope.rb_member.MB_LETTER_COUNT gt 0 ? 'messageOn.png' : 'messageOff.png' }" alt="확인하지 않은 쪽지가 있습니다." title="쪽지함" onclick="javascript:location.href='/myPage/letterList.do';" width="13" height="15">
					</li>
					<li id="rightMenuName">
						<a href="/myPage/memberInfoUpdate.do" title="${sessionScope.rb_member.MB_NAME}(${sessionScope.rb_member.MB_TYPE eq '1' ? '일반회원': sessionScope.rb_member.MB_TYPE eq '2' ? '판매회원':'관리자회원'})님"> ${sessionScope.rb_member.MB_NAME}(${sessionScope.rb_member.MB_TYPE eq '1' ? '일반회원': sessionScope.rb_member.MB_TYPE eq '2' ? '판매회원':'관리자회원'})님 </a>
					</li>
					<li class="login">
						<a href="/auth/logout.do" title="로그아웃">로그아웃&nbsp;</a>
					</li>
					<c:if test="">
					
					</c:if>
					<li class="subMenu">
						<a href="/myPage/myPageMain.do" title="마이페이지">마이페이지&nbsp;<img src="/images/common/header/arrowDown.png" alt="open sub-menu" title="open sub-menu"></a>
						<ul style="display: none;">
							<li><a href="/myPage/memberInfoUpdate.do" title="정보수정">정보수정</a></li>
							<c:if test="${sessionScope.rb_member.MB_TYPE eq '1'}">
								<li><a href="/myPage/emoneyUseList.do" title="e-money통장">e-money통장</a></li>
							</c:if>
							<li><a href="/myPage/inquiryList.do" title="1:1상담">1:1상담</a></li>
							<li><a class="lastSubMenu" href="/myPage/myPageMain.do" title="더보기 >">더보기 &gt;</a></li>
						</ul>
					</li>
					<c:if test="${sessionScope.rb_member.MB_TYPE eq '1'}">
						<li>
							<a href="/item/itemCartList.do" title="장바구니">
								<img src="/images/common/header/cart.png" alt="cart" title="cart" style="vertical-align: -1px;">&nbsp;장바구니(&nbsp;<b>${sessionScope.rb_member.MB_CART_COUNT }</b> )
							</a>
						</li>
					</c:if>
					<c:if test="${sessionScope.rb_member.MB_TYPE eq '1'}">
						<li class="subMenu"><a href="/buyer/buyMain.do" title="구매관리">구매관리&nbsp;
							<img src="/images/common/header/arrowDown.png" alt="open sub-menu" title="open sub-menu"></a>
							<ul>
								<li><a href="/buyer/buyList.do" title="전체구매목록">전체구매목록</a></li>
								<li><a href="/buyer/interestItemList.do" title="관심상품목록">관심상품목록</a></li>
								<li><a href="/buyer/itemQaList.do" title="상품문의관리">상품문의관리</a></li>
								<li><a class="lastSubMenu" href="/buyer/buyMain.do" title="더보기 >">더보기 &gt;</a></li>
							</ul>
						</li>
					</c:if>
					<c:if test="${sessionScope.rb_member.MB_TYPE eq '2'}">
						<li class="subMenu">
							<a href="/seller/sellMain.do" title="판매관리">판매관리&nbsp;<img src="/images/common/header/arrowDown.png" alt="open sub-menu" title="open sub-menu"></a>
							<ul>
								<li><a href="/item/itemForm.do" title="상품등록">상품등록</a></li>
								<li><a href="/seller/sellRegistItemList.do" title="등록상품관리">등록상품관리</a></li>
								<li><a href="/seller/sellList.do" title="상품발송예정">상품발송예정</a></li>
								<li><a href="/seller/itemQaList.do" title="전체문의글">전체문의글</a></li>
								<li><a class="lastSubMenu" href="/seller/sellMain.do" title="더보기 >">더보기 &gt;</a>
								</li>
							</ul>
						</li>
					</c:if>
					<li>
						<a href="/myPage/inquiryList.do" title="1:1상담">1:1상담&nbsp;</a>
					</li>
					<div style="clear: both;"></div>
				</c:otherwise>
			</c:choose>
		</ul>
		<div class="clearboth"></div>
		<div style="position: relative;"></div>
	</div>
</div>
<div id="lHeaderSearch">
	<div class="lHeaderSearch">
		<div class="hLogo">
			<a href="/main.do"> 
				<img src="/images/common/header/logo.png" width="158" height="49">
			</a>
		</div>
		<div class="hSearch">
			<div class="hSearchBox">
				<div class="hSearchBoxSelect">
					<div id="hSearchBoxMenu">
						<span id="searchView">${not empty resultDataMap.p_search_type ? resultDataMap.p_search_type : '상품명' }</span><img id="searchArrow" src="/images/common/header/arrowDown.png">
						<ul id="searchList" style="display: none;">
							<li>상품명</li>
							<li>상품번호</li>
							<li>판매자ID</li>
							<li>닉네임</li>
						</ul>
					</div>
				</div>
				<div class="hSearchBoxInput">
					<input type="text" name="search_text" class="kwd" value="${resultDataMap.p_search_text }" onkeypress="if(event.keyCode==13){searchItemListInBox();}">
				</div>
				<div class="hSearchBoxSearch">
					<input id="searchWordSubmit" type="button" value="" onclick="searchItemListInBox();">
				</div>
				<div class="clearBoth"></div>
			</div>
			<ul id="searchSuggestion"></ul>
			<div class="hPopular">
				<div id="hPopularTitle" class="title" style="">인기검색어</div>
				<div id="hPopularTitle_area_div">
					<ul id="hPopularTitle_area_ul">
					</ul>
				</div>
				<div id="hPopularTitleList_area_div">
					<ul id="hPopularTitleList_area_ul">
					
					</ul>
				</div>
			</div>
		</div>
		<div class="hLink">
			<ul class="hLinkMenu">
				<li><a href="/buyer/interestItemList.do">관심상품</a></li>
				<li class="bar">|</li>
				<li><a href="">테마꾸미기</a></li>
				<li class="bar">|</li>
				<li><a href="/main/questionAndAnswerList.do">Q & A</a></li>
			</ul>
		</div>
		<div class="clearBoth"></div>
	</div>
</div>
<div id="lHeaderMenuWrap">
	<div class="lHeaderMenu">
		<div id="lHeaderMenuAllcate" >
			<div>
				<img src="/images/common/header/category.png" border="0" alt="카테고리" title="카테고리"><font color="#1b1b1b">카테고리</font>
			</div>
			
			<!-- 카테고리메뉴 -->		
			<div class="lMainTopCate" style="display: none;">
				
			</div>
		</div>
		<div class="lHeaderMenuList">
			<ul>
				<!-- <li style="float:left; padding:11px 10px 0 15px;"><a href="/main/item/itemEventList.php" style="font-size:14px; color:#FF643C; text-decoration:none; letter-spacing:-1px;"><b>기획전</b>&nbsp;<img src="/images/common/header/ico_eventListY.png" style="vertical-align:-1px; margin-left:2px;"></a></li> -->
				<li class="lMenuList"><a href="/main/item/itemPackDelivery.php">신상입고</a></li>
				<li class="lHeaderMenuListLineBar lMenuList">|</li>
				<li class="lMenuList"><a href="/main/item/itemPopular.php">베스트100</a></li>
				<!-- <li class="lHeaderMenuListLineBar lMenuList">|</li>
				<li class="lMenuList"><a href="/main/item/itemEventBusinessMall.php">사업자전용</a></li>
				<li class="lHeaderMenuListLineBar lMenuList">|</li>
				<li class="lMenuList"><a href="/main/item/itemLowestPrice.php">최저가확인</a></li>
				<li class="lHeaderMenuListLineBar lMenuList">|</li>
				<li class="lMenuList"><a href="/main/item/itemEvent.php?no=31">덤핑</a></li> -->
			</ul>
			<div class="lHeaderClearBoth"></div>
		</div>
	</div>
</div>


<!-- //////////////////////////////////////////////////퀵메뉴 시작////////////////////////////////////////////////// -->
<div id="lHeaderQuickWrap">
	<!-- 왼쪽 퀵메뉴 -->
	<div class="IHeaderQL">
		<!-- 가격대별검색 -->
		<div class="IH_Price">
			<span>가격대별검색</span>		
			<ul>
				<li class="${resultDataMap.p_price_idx eq '0' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">전체</a></li>
				<li class="${resultDataMap.p_price_idx eq '1' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">1만원이하</a></li>
				<li class="${resultDataMap.p_price_idx eq '2' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">1만원~5만원</a></li>
				<li class="${resultDataMap.p_price_idx eq '3' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">5만원~10만원</a></li>
				<li class="${resultDataMap.p_price_idx eq '4' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">10만원~20만원</a></li>
				<li class="${resultDataMap.p_price_idx eq '5' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">20만원~30만원</a></li>
				<li class="${resultDataMap.p_price_idx eq '6' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">30만원~40만원</a></li>
				<li class="${resultDataMap.p_price_idx eq '7' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">40만원~50만원</a></li>
				<li class="${resultDataMap.p_price_idx eq '8' ? 'on':'' }"><a href="#" onclick="searchItemListInPrice(this);return false;">50만원이상</a></li>
			</ul>
		</div>
	</div>
	<!-- 왼쪽 퀵메뉴 끝-->
	
	<!-- 오른쪽 퀵메뉴 -->
	<div class="IHeaderQR">
		<!-- 최근 본 상품 -->
		<div class="IH_Recent">
			<p>최근 본 상품</p>
			<ul id="latelyViewItemList_ul">
				<!-- <li><a href="#"><img src="/images/common/header/product.jpg" alt="" /></a></li>
				<li><a href="#"><img src="/images/common/header/product2.jpg" alt="" /></a></li>
				<li>찾아본<br />상품이<br />없습니다.</li> -->
			</ul>
			<!-- 페이징 -->
			<div id="latelyViewItemListPageing_div" class="PageN" style="display:none;">
				<div class="Num"><strong id="nowLatelyViewItemPage_strong">1</strong><span>/</span><span id="totalLatelyViewItemPage_span">1</span></div>
				<div class="BottonA"><a href="#" onclick="javascript:latelyViewItemPageingPlusMinus('minus'); return false;"><img src="/images/common/header/arrowL.png" alt="왼쪽" /></a><a href="#" onclick="javascript:latelyViewItemPageingPlusMinus('plus'); return false;"><img src="/images/common/header/arrowR.png" alt="오른쪽" /></a></div>
			</div>
			<div class="IH_TOP"><a href="#">TOP</a></div>
		</div>
		<!-- TOP버튼 -->
		
		
	</div>
</div>
<!-- //////////////////////////////////////////////////퀵메뉴 끝////////////////////////////////////////////////// -->

<!-- //////////////////////////////////////////////////우측 관심상품////////////////////////////////////////////////// -->
<c:if test="${sessionScope.rb_member.MB_TYPE eq '1'}">
	<div id="IHeaderWishBox">
		<button class="WishBtn on" id="wishBtn">관심<br/>상품</button><!-- 클래스 on추가 시, 버튼 활성화 표시  -->
		<div class="IHeaderWishList">
			<div class="IH_WishPriceBtn">
				<ul id="myInterestItemType_ul">
					<li><a href="#" class="priceTab_li" price="0">전체</a></li>
					<li><a href="#" class="priceTab_li" price="1">1만원미만</a></li>
					<li><a href="#" class="priceTab_li" price="2">1만원~5만원</a></li>
					<li><a href="#" class="priceTab_li" price="3">5만원~10만원</a></li>
					<li><a href="#" class="priceTab_li" price="4">10만원~20만원</a></li>
					<li><a href="#" class="priceTab_li" price="5">20만원~30만원</a></li>
					<li><a href="#" class="priceTab_li" price="6">30만원~40만원</a></li>
					<li><a href="#" class="priceTab_li" price="7">40만원~50만원</a></li>
					<li class="lastBtn"><a href="#" class="priceTab_li" price="8">50만원이상</a></li>
				</ul>
			</div>
			<!-- 관심상품 있을경우 -->
			<div id="interestItemList_div" class="IH_WishList" style="display:none;">
				<ul id="interestItemList_ul">
					<!-- <li><button>닫기</button><a href="#"><img src="/images/common/header/product.jpg" alt="" /></a><p>샤오미 보조배터리</p><span>10,400</span></li>
					<li><button>닫기</button><a href="#"><img src="/images/common/header/product2.jpg" alt="" /></a><p>샤오미 보조배터리</p><span>10,500</span></li> -->
				</ul>
			</div>
			<!-- 관심상품이 없을경우 -->
			<div id="interestItemListEmpty_div" class="IH_NoWishList" style="display:block;">
				<p>관심 상품이 없습니다.</p>
			</div>
			<!-- 페이징 -->
			<div id="interestItemListPageing_div"class="PageN" style="display:none;">
				<div class="Num"><strong id="nowPage_strong"></strong><span>/</span><span id="totalPage_span"></span></div>
				<div class="BottonA"><a href="#" onclick="javascript:pageingPlusMinus('minus');"><img src="/images/common/header/arrowL.png" alt="왼쪽" /></a><a href="#" onclick="javascript:pageingPlusMinus('plus');"><img src="/images/common/header/arrowR.png" alt="오른쪽" /></a></div>
			</div>
		</div>
	</div>
	<!-- 관심상품 페이지용 변수 -->
	<input type="hidden" name="pageAjaxData" value="1">
	<input type="hidden" name="pageSizeAjaxData" value="15">
	<input type="hidden" id="maxPage" value="1">
	<script type="text/javascript">
		getMyInterestItemList('0');
	</script>
</c:if>

<form name="itemSchFrm" id="itemSchFrm" method="get" action="/item/itemList.do">
	<input type="hidden" name="p_page" value="${resultDataMap.p_page }"/>
	<input type="hidden" name="p_total_page" value="${resultDataMap.p_total_page }"/>
	<input type="hidden" name="p_pageSize" value="${resultDataMap.p_pageSize }"/>
	<input type="hidden" name="p_cate_code1" value="${resultDataMap.p_cate_code1 }">
	<input type="hidden" name="p_cate_code2" value="${resultDataMap.p_cate_code2 }">
	<input type="hidden" name="p_sch_order" value="${resultDataMap.p_sch_order }">
	<input type="hidden" name="p_start_price" value="${resultDataMap.p_start_price }">
	<input type="hidden" name="p_end_price" value="${resultDataMap.p_end_price }">
	<input type="hidden" name="p_price_idx" value="${resultDataMap.p_price_idx }">
	<input type="hidden" name="p_search_type" value="${resultDataMap.p_search_type }"/>
	<input type="hidden" name="p_search_text" value="${resultDataMap.p_search_text }"/>
</form>