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
<link rel="stylesheet" type="text/css" href="/css/buyer/buyMain.css">

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
	
						<!-- Start -->
						<div class="gFloatLeft userWelcome">
							<b>${sessionScope.rb_member.MB_NAME }(${sessionScope.rb_member.MB_ID })</b>님 반갑습니다.
						</div>
						<div class="gFloatRight">
							구매등급: <b>4등급(810점)</b>
						</div>
						<div class="gClearBoth"></div>
	
	
						<div id="myCouponWrap" class="lMyCouponWrap" style="background-color: #FFF;">
							<div class="gFloatLeft" id="myCoupon">
								<b>나의 쿠폰 현황 :</b> <a href="/main/myBuy/coupon/my_couponSaleList.php">구매할인쿠폰 <b>0</b>개
								</a>
								<div style="height: 5px;"></div>
								<b>나의 e-money현황: </b> 현금 <b class="red"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH }"/></b>원 | 카드 <b class="red"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH_CARD }"/></b>원
							</div>
							<div id="helpWrap" class="gFloatRight">
								<a href="/binary/Doc/new_buyer_manual_2.3.1.pdf" target="_blank">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_buyerManual1.jpg" alt="구매자매뉴얼">
								</a> <a href="http://get.adobe.com/kr/reader" target="_blank"> <img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_buyerManual2.jpg" alt="Adobe Reader">
								</a> <img src="http://211.43.195.137/image/v6/elements/my/mybuy/button/img_btnBuyManageHelp.jpg" alt="상품구매도움말" class="padded gCursorPointer" onclick="window.open('/main/popup/help/popup_helpsList.php?mode=help&amp;cat=BUY', '_blank', 'width=569,height=635,top=30,left=30,scrollbars=yes,resizable=yes')">
							</div>
							<div class="gClearBoth"></div>
						</div>
	
	
						<!-- 진행중인 구매 -->
						<div id="buyStatusWrap">
							<div id="buying" class="gFloatLeft">
								<img class="gFloatLeft" src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_buyingTitle.jpg" alt="진행중인 구매"> <span class="sellStrWrap">최근 <b>1개월</b>
									기준(전체 구매수 : <b class="orangeBold">1</b>건)
								</span>
	
								<!-- 입금예정, 승인대기영역 -->
								<div id="depositWrap" class="gFloatLeft bgRound">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_depositTitle.jpg" alt="입금예정"> <a href="/main/myBuy/order/my_orderList.php?mode=WAITPAY" class="orangeBold">0건</a> <img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_approvalTitle.jpg" alt="승인대기"> <a href="/main/myBuy/order/my_orderList.php?mode=WAITCONFIRM" class="orangeBold">0건</a>
								</div>
	
								<div class="gFloatLeft arrow">
									<img src="http://211.43.195.137/image/v6/elements/my/common/img_arrow.jpg" alt="화살표">
								</div>
	
								<!-- 배송준비중 -->
								<div id="deliveryReadyWrap" class="gFloatLeft bgRound">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_deliveryReadyTitle.jpg" alt="배송준비중"> <a href="/main/myBuy/order/my_orderList.php?mode=WAITDELI" class="orangeBold">0건</a>
								</div>
	
								<div class="gFloatLeft arrow">
									<img src="http://211.43.195.137/image/v6/elements/my/common/img_arrow.jpg" alt="화살표">
								</div>
	
								<!-- 배송중 -->
								<div id="deliveryWrap" class="gFloatLeft bgRound">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_deliveryTitle.jpg" alt="배송중"> <a href="/main/myBuy/order/my_orderList.php?mode=WAITOK" class="orangeBold">1건<br></a> <a href="/main/myBuy/order/my_orderList.php?mode=WAITOK" class="orangeBold"> <img class="receiptBtn" src="http://211.43.195.137/image/v6/elements/my/mybuy/button/img_btnSmallReceipt.jpg" alt="수령확인">
									</a>
								</div>
	
								<div class="gFloatLeft arrow">
									<img src="http://211.43.195.137/image/v6/elements/my/common/img_arrow.jpg" alt="화살표">
								</div>
	
								<!-- 구매종료 영역 -->
								<div id="paymentCompleteWrap" class="gFloatLeft bgRound">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_paymentCompleteTitle.jpg" alt="결제완료"> <a href="/main/myBuy/order/my_orderList.php?mode=DONE" class="orangeBold">0건</a>
								</div>
	
								<div class="gClearBoth"></div>
							</div>
	
							<!-- 구매종료/취소현황 영역 -->
							<div id="buyCancel" class="gFloatLeft">
								<div>
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_buyCancelTitle.jpg" alt="구매종료/취소현황">
								</div>
								<ul>
									<li><a href="/main/myBuy/order/my_orderList.php?mode=DENYCONFIRM">
											<span class="name">승인취소</span> <span class="cnt">0건</span>
									</a></li>
									<li><a href="/main/myBuy/order/my_orderList.php?mode=DENYSELL"> <span class="name">판매취소</span> <span class="cnt">0건</span>
									</a></li>
									<li><a href="/main/myBuy/order/my_orderList.php?mode=DENYBUY"> <span class="name">구매취소</span> <span class="cnt">0건</span>
									</a></li>
									<li><a href="/main/myBuy/order/my_orderListReturn.php">
											<span class="name">반품중</span> <span class="cnt">0건</span>
									</a></li>
								</ul>
							</div>
	
							<!-- 흥정현황 영역 -->
							<div id="bargain" class="gFloatLeft">
								<div class="gAlignLeft">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_bargainTitle.jpg" alt="흥정현황">
								</div>
								<div id="bargainWrap">
									<div>
										<span class="orangeColor">확인대기<br>흥정요청<br></span> <a href="/main/myBuy/order/my_orderNegoList.php?stat=W1"><b class="orangeBold">0</b>건</a>
									</div>
									<div>
										<span>주문대기<br>흥정요청<br></span> <a href="/main/myBuy/order/my_orderNegoList.php?stat=W2"><b>0</b>건</a>
									</div>
								</div>
								<div class="gClearBoth"></div>
							</div>
							<div class="gClearBoth"></div>
						</div>
	
						<!-- 최근 구매정보 영역 -->
						<div id="recentBuyWrap">
	
							<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_recentBuyTitle.jpg" alt="최근구매정보"> <span id="recentBuyStr">최근 <b>1개월</b>
								기준(전체 구매건수 : <b class="orangeBold">1</b>건 | 구매금액 : <b class="orangeBold">20,650</b>원)
							</span>
							<table id="recentBuyTable" width="100%" cellspacing="0" cellpadding="0">
								<colgroup>
									<col width="100px">
									<col width="85px">
									<col width="*">
									<col width="75px">
									<col width="85px">
									<col width="100px">
									<col width="85px">
								</colgroup>
								<thead>
									<tr>
										<th>주문일자(번호)</th>
										<th colspan="2">주문상품정보</th>
										<th>구매수량</th>
										<th>구매금액</th>
										<th>배송비(판매자)</th>
										<th>주문상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>2017-11-16<br> OR11984331 <a href="/main/myBuy/order/my_orderView.php?no=11984331"> <img src="http://211.43.195.137/image/v6/elements/my/mybuy/button/img_btnItemOrderSheet.jpg" alt="상품주문서">
										</a>
										</td>
										<td class="orderItem"><img width="65" height="65" src="http://211.43.195.122/upload/item/2016/11/02/14780361907972CB6CEDDAB3BC4F4FFE/14780361907972CB6CEDDAB3BC4F4FFE_img_150" alt=""></td>
										<td class="orderItem"><a href="/s/6996094">소매꾹 SM81
												울100% 앙고라 보아캡 여성 겨울 털 모자</a></td>
										<td><b>3개</b></td>
										<td><b class="orangeBold">18,150원</b></td>
										<td><b> <br> 2,500원<br>
										</b> cosmasp</td>
										<td>배송중 <a href="javascript:void(0);" onclick="goDeliTrace('HYUNDAI','400880527810', '11984331_6996094','1');" target="naggama_deli"><img src="http://211.43.195.137/image/v6/elements/my/mybuy/button/img_btnDeliveryInquiry.jpg" alt="배송조회"></a> <a href="/main/myBuy/order/my_orderView.php?no=11984331&amp;back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">
												<img src="http://211.43.195.137/image/v6/elements/my/mybuy/button/img_btnBigReceipt.jpg" alt="수령확인"> <img src="http://211.43.195.137/image/v6/elements/my/mybuy/button/img_btnBuyReview.jpg" alt="구매후기">
										</a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
	
						<div class="etcWrap">
	
							<!-- 구매자 공지사항 -->
							<div class="buyerNotice">
								<div class="noticeTitle">
									<span class="left"> <img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_buyerNoticeTitle.jpg" alt="구매자공지사항" width="86" height="15">
									</span> <span class="right"> <a href="/main/board/boardList.php?mode=inNB" class="noticeMore">
											더보기 <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg" class="pointer" alt="더보기" width="13" height="13">
									</a>
									</span>
								</div>
								<ul>
	
									<li><a href="/main/board/boardList.php?mode=inNB&amp;no=4224">[공지]KB국민은행
											계좌이체 서비스 일시중지 안내(11/...</a></li>
	
									<li><a href="/main/board/boardList.php?mode=inNB&amp;no=4222">[공지]SC제일은행
											카드 및 계좌이체 서비스 일시중지...</a></li>
	
									<li><a href="/main/board/boardList.php?mode=inNB&amp;no=4207">[구인]
											고객지원센터에서 인재를 찾습니다.</a></li>
	
									<li><a href="/main/board/boardList.php?mode=inNB&amp;no=4205">[공지]
											포인트 적립 기준 변경 안내</a></li>
	
									<li><a href="/main/board/boardList.php?mode=inNB&amp;no=4201">[공지]
											판/구매관리 상품문의 페이지 리뉴얼 안내</a></li>
								</ul>
							</div>
	
							<!-- 상품문의글 -->
							<div class="itemQState">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelItemInquiry.jpg" alt="상품문의현황" width="75" height="15">
								<div class="qStateList">
									<ul>
										<li><a href="/main/myBuy/support/my_itemSupport.php?status=UNREAD">
												<span class="left">읽지않은문의글</span> <span class="right">0건</span>
										</a></li>
										<li><a href="/main/myBuy/support/my_itemSupport.php?status=NOREPLY">
												<span class="left">읽어본문의글</span> <span class="right">0건</span>
										</a></li>
										<li class="orange"><a href="/main/myBuy/support/my_itemSupport.php?status=NOREPLY">
												<span class="left">답변없는문의글</span> <span class="right">0건</span>
										</a></li>
										<li><a href="/main/myBuy/support/my_itemSupport.php?status=REPLY">
												<span class="left">답변있는문의글</span> <span class="right">0건</span>
										</a></li>
									</ul>
								</div>
							</div>
	
							<!-- 회원지원센터 -->
							<div class="supportCenter">
								<a href="/main/mySell/sellerSupport/sell_supportCenterMain.php">
									<img src="http://211.43.195.137/image/v6/elements/my/mybuy/main/img_bnrMemberSupportCenter.jpg" alt="회원지원센터" width="284" height="164">
								</a>
							</div>
	
						</div>
						<div class="clear"></div>
	
	
						<div id="myBuyTabWrap">
							<!-- 나의 관심상품 -->
							<div class="myItemWrap" id="myBuyWishItem" style="display: block;">
								<ul id="tapMenu">
									<li class="tapSelect">나의 관심상품 (18개)</li>
									<li onclick="selectTab('myBuyWishSeller')"><b>단골판매자 목록</b>
										(<b class="greenBold">5</b>건)</li>
									<li onclick="selectTab('myBuyRecently')"><b>오늘 본 상품</b> (<b class="greenBold">0</b>건)</li>
								</ul>
	
								<div class="gMoreSection">
									<a href="/main/myBuy/wish/my_wishItemList.php"> 더보기 <img src="http://211.43.195.122/image/v6/index/row3/img_btnMore.jpg" width="13" height="13" alt="더보기">
									</a>
								</div>
	
								<ul id="myItemContent">
									<li class="myItemInfo"><a href="/6900424?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">
											<img class="itemImg" src="http://211.43.195.122/upload/item/2016/08/04/147028763582950FAC5847FA5E581221/147028763582950FAC5847FA5E581221_img_150" alt="월드온 박스형 스마트폰 확대스크린 3d거치대 모바일" height="150" width="150">
									</a>
										<div class="itemStatus">
											<img src="http://211.43.195.137/image/v6/elements/item/icon/img_iconDome.jpg" alt="도매꾹">
										</div>
										<div class="itemName">
											<a href="/6900424?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">월드온
												박스형 스마트폰 확대스크린 3d거치대 모바일</a>
										</div>
										<div class="itemPrice">
											<b class="redColor">1,890원</b> (최소 <b>10</b>개)
										</div>
										<div class="itemDate">
											<b>17/03/10</b> 01:36:14
										</div>
										<div class="sellerInfo">
											<span class="sellerId">worldcom</span> <span class="sellerLv">
												<img src="http://211.43.195.137/image/v6/common/icon/img_iconP.jpg" alt="worldcom님은 파워멤버입니다.">판매<b>1등급</b>
											</span>
										</div></li>
									<li class="myItemInfo"><a href="/6129439?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">
											<img class="itemImg" src="http://211.43.195.122/upload/item/2015/01/02/142019006941FEB88EE0A0D4383AB30E/142019006941FEB88EE0A0D4383AB30E_img_150" alt="디와이유통) 300종 박신*st/트위스트머리끈/토끼머리" height="150" width="150">
									</a>
										<div class="itemStatus">
											<img src="http://211.43.195.137/image/v6/elements/item/icon/img_iconDome.jpg" alt="도매꾹">
										</div>
										<div class="itemName">
											<a href="/6129439?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">디와이유통)
												300종 박신*st/트위스트머리끈/토끼머리</a>
										</div>
										<div class="itemPrice">
											<b class="redColor">66원</b> (최소 <b>3</b>개)
										</div>
										<div class="itemDate">
											<b>17/02/10</b> 10:59:18
										</div>
										<div class="sellerInfo">
											<span class="sellerId">mpmaster</span> <span class="sellerLv">
												판매<b>3등급</b>
											</span>
										</div></li>
									<li class="myItemInfo"><a href="/6640940?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">
											<img class="itemImg" src="http://211.43.195.122/upload/item/2016/01/14/145275331616FC58EBD160F1CA806A55/145275331616FC58EBD160F1CA806A55_img_150" alt="H800 블루투스넥밴드" height="150" width="150">
									</a>
										<div class="itemStatus">
											<img src="http://211.43.195.137/image/v6/elements/item/icon/img_iconDome.jpg" alt="도매꾹">
										</div>
										<div class="itemName">
											<a href="/6640940?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">H800
												블루투스넥밴드</a>
										</div>
										<div class="itemPrice">
											<b class="redColor">8,000원</b> (최소 <b>3</b>개)
										</div>
										<div class="itemDate">
											<b>16/03/23</b> 11:36:09
										</div>
										<div class="sellerInfo">
											<span class="sellerId">smartbox</span> <span class="sellerLv">
												판매<b>1등급</b>
											</span>
										</div></li>
									<li class="myItemInfo"><a href="/6669793?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">
											<img class="itemImg" src="http://211.43.195.122/upload/item/2016/02/17/14556757660DA98E462FC69649C25C8E/14556757660DA98E462FC69649C25C8E_img_150" alt="넥밴드 800 [당일발송+최저가 판매중]" height="150" width="150">
									</a>
										<div class="itemStatus">
											<img src="http://211.43.195.137/image/v6/elements/item/icon/img_iconDome.jpg" alt="도매꾹">
										</div>
										<div class="itemName">
											<a href="/6669793?back=L21haW4vbXlCdXkvbXlfYnV5TWFpbi5waHA%3D">넥밴드
												800 [당일발송+최저가 판매중]</a>
										</div>
										<div class="itemPrice">
											<b class="redColor">12,000원</b> (최소 <b>3</b>개)
										</div>
										<div class="itemDate">
											<b>16/02/24</b> 05:27:46
										</div>
										<div class="sellerInfo">
											<span class="sellerId">unicus</span> <span class="sellerLv">
												판매<b>6등급</b>
											</span>
										</div></li>
								</ul>
								<div class="gClearBoth"></div>
							</div>
	
							<!-- 단골판매자 목록 -->
							<div class="myItemWrap" id="myBuyWishSeller" style="display: none;">
								<ul id="tapMenu">
									<li onclick="selectTab('myBuyWishItem')"><b>나의 관심상품</b> (<b class="greenBold">18</b>개)</li>
									<li class="tapSelect">단골판매자 목록 (5건)</li>
									<li onclick="selectTab('myBuyRecently')"><b>오늘 본 상품</b> (<b class="greenBold">0</b>건)</li>
								</ul>
								<div class="gMoreSection">
									<a href="/main/myBuy/wish/my_wishSellerList.php"> 더보기 <img src="http://211.43.195.122/image/v6/index/row3/img_btnMore.jpg" width="13" height="13" alt="더보기">
									</a>
								</div>
								<table width="100%">
									<colgroup>
										<col width="55px">
										<col width="*">
										<col width="70px">
										<col width="70px">
										<col width="70px">
										<col width="70px">
										<col width="70px">
										<col width="70px">
										<col width="80px">
										<col width="60px">
									</colgroup>
									<thead>
										<tr>
											<th>번호</th>
											<th>회원아이디</th>
											<th>등록상품</th>
											<th>전체등급</th>
											<th>판매등급</th>
											<th>평가등급</th>
											<th>거래시도</th>
											<th>거래완료</th>
											<th>등록일</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>526305</td>
											<td>dldnjsdl2</td>
											<td><a href="/main/item/itemList.php?sec=SHOP&amp;sec=COM&amp;sf=id&amp;sw=dldnjsdl2">등록상품</a></td>
											<td>2등급</td>
											<td>1등급</td>
											<td>1등급</td>
											<td>1회</td>
											<td>1회</td>
											<td>17/04/12</td>
											<td><a href="./wish/my_wishIng.php?mode=delWishSeller&amp;no=526305" onclick="return confirm('정말 삭제 하겠습니까?');"> <img src="/image/myBuy/wish/btn_del.gif" width="45" height="20">
											</a></td>
										</tr>
										<tr>
											<td>512266</td>
											<td>psk6402</td>
											<td><a href="/main/item/itemList.php?sec=SHOP&amp;sec=COM&amp;sf=id&amp;sw=psk6402">등록상품</a></td>
											<td>5등급</td>
											<td>4등급</td>
											<td>4등급</td>
											<td>0회</td>
											<td>0회</td>
											<td>16/12/14</td>
											<td><a href="./wish/my_wishIng.php?mode=delWishSeller&amp;no=512266" onclick="return confirm('정말 삭제 하겠습니까?');"> <img src="/image/myBuy/wish/btn_del.gif" width="45" height="20">
											</a></td>
										</tr>
										<tr>
											<td>502102</td>
											<td>oohoo2</td>
											<td><a href="/main/item/itemList.php?sec=SHOP&amp;sec=COM&amp;sf=id&amp;sw=oohoo2">등록상품</a></td>
											<td>2등급</td>
											<td>1등급</td>
											<td>1등급</td>
											<td>0회</td>
											<td>0회</td>
											<td>16/10/12</td>
											<td><a href="./wish/my_wishIng.php?mode=delWishSeller&amp;no=502102" onclick="return confirm('정말 삭제 하겠습니까?');"> <img src="/image/myBuy/wish/btn_del.gif" width="45" height="20">
											</a></td>
										</tr>
										<tr>
											<td>493090</td>
											<td>kjhwill</td>
											<td><a href="/main/item/itemList.php?sec=SHOP&amp;sec=COM&amp;sf=id&amp;sw=kjhwill">등록상품</a></td>
											<td>3등급</td>
											<td>7등급</td>
											<td>5등급</td>
											<td>0회</td>
											<td>0회</td>
											<td>16/08/04</td>
											<td><a href="./wish/my_wishIng.php?mode=delWishSeller&amp;no=493090" onclick="return confirm('정말 삭제 하겠습니까?');"> <img src="/image/myBuy/wish/btn_del.gif" width="45" height="20">
											</a></td>
										</tr>
										<tr>
											<td>493068</td>
											<td>pozman</td>
											<td><a href="/main/item/itemList.php?sec=SHOP&amp;sec=COM&amp;sf=id&amp;sw=pozman">등록상품</a></td>
											<td>2등급</td>
											<td>1등급</td>
											<td>3등급</td>
											<td>0회</td>
											<td>0회</td>
											<td>16/08/04</td>
											<td><a href="./wish/my_wishIng.php?mode=delWishSeller&amp;no=493068" onclick="return confirm('정말 삭제 하겠습니까?');"> <img src="/image/myBuy/wish/btn_del.gif" width="45" height="20">
											</a></td>
										</tr>
									</tbody>
								</table>
							</div>
	
	
							<!-- 오늘 본 상품 -->
							<div class="myItemWrap" id="myBuyRecently" style="display: none;">
								<ul id="tapMenu">
									<li onclick="selectTab('myBuyWishItem')"><b>나의 관심상품</b> (<b class="greenBold">18</b>개)</li>
									<li onclick="selectTab('myBuyWishSeller')"><b>단골판매자 목록</b>
										(<b class="greenBold">5</b>건)</li>
									<li class="tapSelect">오늘 본 상품 (0건)</li>
								</ul>
								<div class="gMoreSection">
									<a href="/main/myBuy/wish/my_historyList.php"> 더보기 <img src="http://211.43.195.122/image/v6/index/row3/img_btnMore.jpg" width="13" height="13" alt="더보기">
									</a>
								</div>
								<ul id="myItemContent">
									<li class="myItemEmpty">오늘 본 상품이 없습니다.</li>
								</ul>
								<div class="gClearBoth"></div>
							</div>
	
						</div>
	
	
						<!-- 광고영역부분 -->
						<div style="margin: 40px 0 0 0;"></div>
						<div id="advertiseArea"></div>
	
						<div id="customerService">
							<img src="http://211.43.195.137/image/v6/elements/my/common/img_bnrCustomerCenter.jpg" alt="고객센터">
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