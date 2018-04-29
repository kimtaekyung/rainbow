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
<link rel="stylesheet" type="text/css" href="/css/seller/sellMain.css">

</head>
	<body>
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
		
						<!-- 전일/금일 주문 상품개수 표시 -->
						<div style="width: auto; height: 20px; margin-bottom: 15px; padding: 6px; background-color: #e8e8e8; color: #333; font-family: 'dotum', '돋움'; font-size: 9pt; letter-spacing: -0.06em; text-align: center;">
							레인보우에서는 지난주 <font color="#cc0000"><b>4,761,041</b></font>상품이 도매가격으로
							판매되었고, 오늘은 현재시간까지 <font color="#cc0000"><b>837,346</b></font>상품이
							주문되었습니다.
						</div>
		
		
						<!-- Start -->
						<div class="sellerInfo">
							<span class="sellerName"><b class="black">${sessionScope.rb_member.MB_NAME }(${sessionScope.rb_member.MB_ID })</b>
								판매자님 반갑습니다.</span> <span class="sellerLevel"> 판매등급: 4등급 (3,833점) |
								구매만족도: <img src="http://211.43.195.122/image/v6/common/icon/img_starFull.jpg" width="14" height="13" alt="찬별"><img src="http://211.43.195.122/image/v6/common/icon/img_starFull.jpg" width="14" height="13" alt="찬별"><img src="http://211.43.195.122/image/v6/common/icon/img_starFull.jpg" width="14" height="13" alt="찬별"><img src="http://211.43.195.122/image/v6/common/icon/img_starFull.jpg" width="14" height="13" alt="찬별"><img src="http://211.43.195.122/image/v6/common/icon/img_starFull.jpg" width="14" height="13" alt="찬별"> (100%/82명)
							</span>
						</div>
						
						<div class="lSellerWrap">
							<span class="sellerCoupon">
								<b class="gray">나의 쿠폰 현황: </b>
								<!-- <a href="/main/mySell/adv/my_psCoupon.php"> 파워스페셜 <b class="gray">0</b>개</a> | --> 
								<a href="/main/mySell/coupon/my_couponFreeList.php"> 5일 무료등록 <b class="gray">0</b>개</a> | 
								상품홍보쿠폰 잔액 : <b class="red">0</b>원
								<br/> 
								<b class="gray">나의 e-money현황:</b> 현금 
								<b class="red"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH }"/></b>원 | 카드 
								<b class="red"><fmt:formatNumber value="${sessionScope.rb_member.MB_CASH_CARD }"/></b>원
							</span> 
							<span class="sellerHelp"> 
								<a href="/binary/Doc/new_seller_manual_2.3.1.pdf" target="_blank">
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellerManual1.jpg" alt="판매자 매뉴얼" width="80" height="20">
								</a> 
								<a href="http://get.adobe.com/kr/reader/" target="_blank"> 
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellerManual2.jpg" alt="Adobe Reader" width="75" height="20">
								</a> <br> 
								<a href="javascript:popupHelpCat('SELL')"> 
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnSaleHelp.jpg" alt="판매관리도움말" width="94" height="20" class="padded" style="padding: 8px 0 0 60px;">
								</a>
							</span>
						</div>
		
						<!-- 상품판매현황 -->
						<div class="sellWrap">
							<div class="sellInfo">
								<div class="sellState">
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_titleItemSale.jpg" alt="상품판매현황" width="495" height="19"> <span class="sell">최근
										<b>1개월</b> 기준(전체 판매건수 : <b class="orange">1</b>건)
									</span>
								</div>
								<div class="gClearBoth"></div>
		
								<div class="sellStep sellStep2l">
		
									<!-- 입금예정 -->
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellPayment.jpg" class="sellPayment" alt="입금예정" width="56" height="17">
									<div class="count">
										<a href="/main/mySell/sell/my_sellList.php?mode=WAITPAY" class="orange paymentCount"> 0건 </a>
									</div>
		
									<br>
		
									<!-- 승인대기 -->
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellApproval.jpg" class="sellApproval" alt="승인대기" width="56" height="17">
									<div class="count">
										<a href="/main/mySell/sell/my_sellList.php?mode=WAITCONFIRM" class="orange approvalCount"> 0건 </a>
									</div>
								</div>
		
								<div class="sellArrow">
									<img src="http://211.43.195.137/image/v6/elements/my/common/img_arrow.jpg" class="arrow" alt="화살표" width="17" height="32">
								</div>
		
								<div class="sellStep sellStep2l">
		
									<!-- 발송예정 -->
									<br> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellSendWait.jpg" class="sellSendWait" alt="발송예정" width="56" height="17">
									<div class="count">
										<a href="/main/mySell/sell/my_sellList.php?mode=WAITDELI" class="orange sendWaitCount"> 0건 </a>
									</div>
									<br> <a href="/main/mySell/sell/my_sellList.php?mode=WAITDELI" class="orange sendWaitCount"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnSend.jpg" class="sellSendBtn pointer" alt="발송하기" width="67" height="20">
									</a>
								</div>
		
								<div class="sellArrow">
									<img src="http://211.43.195.137/image/v6/elements/my/common/img_arrow.jpg" class="arrow" alt="화살표" width="17" height="32">
								</div>
		
								<div class="sellStep sellStep1l">
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellSend.jpg" class="sellSend" alt="배송중" width="43" height="17">
									<div class="count">
										<a href="/main/mySell/sell/my_sellList.php?mode=WAITOK" class="orange sendCount"> 0건 </a>
									</div>
								</div>
		
								<div class="sellArrow">
									<img src="http://211.43.195.137/image/v6/elements/my/common/img_arrow.jpg" class="arrow" alt="화살표" width="17" height="32">
								</div>
		
								<div class="sellStep sellStep1l">
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellSave.jpg" class="sellSave" alt="적립예정" width="56" height="17">
									<div class="count">
										<a href="/main/mySell/sell/my_sellList.php?mode=WAITSERV" class="orange saveCount"> 0건 </a>
									</div>
								</div>
							</div>
							<div class="itemEnd">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelItemEnd.jpg" alt="판매종료/취소현황" width="98" height="15">
								<ul class="itemEndList">
									<li><a href="/main/mySell/sell/my_sellList.php?mode=DONE">
											<span class="left">판매종료</span> <span class="right">1건</span>
									</a></li>
									<li><a href="/main/mySell/sell/my_sellList.php?mode=DENYCONFIRM"> <span class="left">승인취소</span> <span class="right">0건</span>
									</a></li>
									<li><a href="/main/mySell/sell/my_sellList.php?mode=DENYSELL"> <span class="left">판매취소</span> <span class="right">0건</span>
									</a></li>
									<li><a href="/main/mySell/sell/my_sellList.php?mode=DENYBUY">
											<span class="left">구매취소</span> <span class="right">0건</span>
									</a></li>
									<li><a href="/main/mySell/sell/my_sellListReturn.php"> <span class="left">반품중</span> <span class="right">0건</span>
									</a></li>
								</ul>
							</div>
							<div class="bargain">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelBargain.jpg" alt="흥정현황" width="47" height="15">
								<ul class="bargainList">
									<li><a href="/main/mySell/sell/my_sellNegoList.php?stat=W1">
											<span class="right orange"> <b>0</b>건
										</span> <span class="orange">확인대기<br>흥정요청
										</span>
									</a></li>
									<li><a href="/main/mySell/sell/my_sellNegoList.php?stat=W2">
											<span class="right"> <b>0</b>건
										</span> <span>주문대기<br>흥정요청
										</span>
									</a></li>
									<li><a href="/main/mySell/sell/my_sellNegoAdd.php"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnBargain.jpg" alt="구매자를 지정하여">
									</a></li>
								</ul>
							</div>
						</div>
		
						<!-- 상품 등록현황 -->
						<div class="clear"></div>
						<div class="itemWrap">
							<div class="itemReg">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelItemReg.jpg" alt="상품등록현황" width="75" height="15">
								<table class="itemRegTbl">
									<thead>
										<tr>
											<th align="center">승인대기</th>
											<th align="center">승인거부</th>
											<th align="center">판매중</th>
											<th align="center">기간미지정</th>
											<th align="center">판매종료</th>
											<th align="center">기간종료</th>
											<th align="center">삭제예정</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=WAIT"> 0개
											</a></td>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=DENY"> 0개
											</a></td>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=DONE"> <strong>2건</strong>
											</a></td>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=DATE"> 0개
											</a></td>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=NONE"> 0개
											</a></td>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=OVER">
													21개 </a></td>
											<td align="center"><a href="/main/mySell/register/my_sellList.php?mode=DEL"> 0개
											</a></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="itemAdvState">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelAdvState.jpg" class="gFloatLeft" alt="광고현황" width="47" height="15"> <a href="/main/mySell/adv/my_advAdd.php"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnAdvRequest.jpg" class="gFloatRight" alt="광고신청하기" width="81" height="20">
								</a>
								<ul class="advStateList">
									<li><a href="/main/mySell/adv/my_advList.php?scat=&amp;sstatus=DONE">
											<span class="left">결제완료</span> <span class="right">0건</span>
									</a></li>
									<li><a href="/main/mySell/adv/my_advList.php?scat=&amp;sstatus=ING">
											<span class="left">등록완료</span> <span class="right">5건</span>
									</a></li>
									<li><a href="/main/mySell/adv/my_advList.php?scat=&amp;sstatus=PAY">
											<span class="left">입금대기</span> <span class="right">0건</span>
									</a></li>
								</ul>
							</div>
						</div>
						<div class="clear"></div>
		
						<div class="supportCenterWrap">
							<a href="/main/mySell/sellerSupport/sell_supportCenterMain.php" class="bnrLeft"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_bnrMemberSupportCenter.png" alt="회원지원센터" title="회원지원센터" width="487" height="100">
							</a> <a href="/main/board/boardList.php?mode=inNS&amp;no=3780" class="bnrRight"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_bnrImageGuide.png" alt="상품상세페이지 가이드 및 템플릿" title="상품상세페이지 가이드 및 템플릿" width="284" height="100">
							</a>
						</div>
		
						<div class="etcWrap">
		
							<!-- 판매자 공지사항 -->
							<div class="sellerNotice">
								<div class="noticeTitle">
									<span class="left"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_sellerNotice.jpg" alt="판매자공지사항" width="86" height="15">
									</span> <span class="right"> <a href="/main/board/boardList.php?mode=inNS" class="noticeMore">
											더보기 <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg" class="pointer" alt="더보기" width="13" height="13">
									</a>
									</span>
								</div>
								<ul>
		
									<li><a href="/main/board/boardList.php?mode=inNS&amp;no=4228">[이벤트]
											12월 배너 광고 이벤트, 7일 이상 신청시 옵...</a></li>
		
									<li><a href="/main/board/boardList.php?mode=inNS&amp;no=4224">[공지]KB국민은행
											계좌이체 서비스 일시중지 안내(11/...</a></li>
		
									<li><a href="/main/board/boardList.php?mode=inNS&amp;no=4222">[공지]SC제일은행
											카드 및 계좌이체 서비스 일시중지...</a></li>
		
									<li><a href="/main/board/boardList.php?mode=inNS&amp;no=4210">[공지]
											상품주문옵션 대량등록 기능 도입 안내</a></li>
		
									<li><a href="/main/board/boardList.php?mode=inNS&amp;no=4209">[이벤트]
											11월 배너 광고 길게 하면 기간을 2배로~!!</a></li>
								</ul>
							</div>
							<div class="itemQState">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelCleanCampaign.jpg" alt="구매자권리신고/후기현황" title="구매자권리신고/후기현황" width="132" height="15">
								<div class="qStateList">
									<ul>
										<li><a href="/main/mySell/cleanCampaign/my_cleanReportList.php?mode=WAIT">
												<span class="left">읽지않은신고글</span> <span class="right">0건</span>
										</a></li>
										<li><a href="/main/mySell/cleanCampaign/my_cleanReportList.php?mode=READ">
												<span class="left">읽은신고글</span> <span class="right">0건</span>
										</a></li>
										<li class="orange"><a href="/main/mySell/cleanCampaign/my_cleanReportList.php?mode=NOREPLY">
												<span class="left">미답변신고글</span> <span class="right">0건</span>
										</a></li>
										<li><a href="/main/mySell/cleanCampaign/my_cleanReportList.php?mode=REPLIED">
												<span class="left">답변완료신고글</span> <span class="right">0건</span>
										</a></li>
									</ul>
								</div>
								<div class="qReviewStatus">
									<ul>
										<li><a href="/main/mySell/support/my_sellResult.php"> <span class="left">구매후기</span> <span class="right">1,502건</span>
										</a></li>
									</ul>
								</div>
							</div>
		
							<!-- 매출내역 다운로드 / 대금정산현황 -->
							<div class="saleInfo">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_saleList.jpg" alt="매출내역다운로드" width="96" height="15">
								<div class="saleListDL">
									<div class="row">
										<form name="report1" method="post" action="sell/my_sellIng.php">
											<input type="hidden" name="mode" value="xls"> <select name="yy" class="saleYear">
												<option value="2017">2017년</option>
												<option value="2016">2016년</option>
												<option value="2015">2015년</option>
												<option value="2014">2014년</option>
												<option value="2013">2013년</option>
												<option value="2012">2012년</option>
												<option value="2011">2011년</option>
												<option value="2010">2010년</option>
											</select> <select name="mm" class="saleDivision">
												<option value="1">01월 판매내역</option>
												<option value="2">02월 판매내역</option>
												<option value="3">03월 판매내역</option>
												<option value="4">04월 판매내역</option>
												<option value="5">05월 판매내역</option>
												<option value="6">06월 판매내역</option>
												<option value="7">07월 판매내역</option>
												<option value="8">08월 판매내역</option>
												<option value="9">09월 판매내역</option>
												<option value="10">10월 판매내역</option>
												<option value="11">11월 판매내역</option>
												<option value="12" selected="">12월 판매내역</option>
											</select> <input type="image" src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnDownload.jpg" alt="다운로드" width="62" height="20">
										</form>
									</div>
									<div class="row">
										<form name="report2" method="post" action="sell/my_sellIng.php">
											<input type="hidden" name="mode" value="xls"> <select name="yy" class="saleYear">
												<option value="2017">2017년</option>
												<option value="2016">2016년</option>
												<option value="2015">2015년</option>
												<option value="2014">2014년</option>
												<option value="2013">2013년</option>
												<option value="2012">2012년</option>
												<option value="2011">2011년</option>
												<option value="2010">2010년</option>
											</select> <select name="qt" class="saleDivision">
												<option value="1">1분기 판매내역</option>
												<option value="2">2분기 판매내역</option>
												<option value="3">3분기 판매내역</option>
												<option value="4" selected="">4분기 판매내역</option>
											</select> <input type="image" src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnDownload.jpg" alt="다운로드" width="62" height="20">
										</form>
									</div>
								</div>
								<div class="calculateState">
									<div class="title">
										<div class="left">
											<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_labelPayment.jpg" alt="대금정산현황" width="70" height="15">
										</div>
										<div class="right">2017.12.04 기준</div>
									</div>
									<table class="calculateList" width="100%">
										<colgroup>
											<col width="50%">
											<col width="50%">
										</colgroup>
										<tbody>
											<tr>
												<td><span class="labels">금 일</span> <span class="amount"><b class="calculatePrice">0</b> 원</span></td>
												<td><span class="labels">금 월</span> <span class="amount"><b class="calculatePrice">0</b> 원</span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="clear"></div>
						<div class="authPower">
							<div class="authPowerLeft">
								<a href="/main/myPage/authCenter/my_authPower.php"> <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_authPowerBtn.jpg" width="125" height="50" alt="인증받기">
								</a>
							</div>
							<div class="authPowerCenter">
								<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_authPowerIco.jpg" width="68" height="68" alt="인증받기">
							</div>
							<div class="authPowerRight">
								· 상품등록옵션쿠폰 최대 <b>550,000</b>원 무상지급 (1년 재가입시 <b>10% 추가할인</b>)<br>
								· 나의 상품리스트에 '<b>파워멤버</b>' 인증마크 표시 및 포토갤러리 자동적용<br>
							</div>
		
						</div>
						<div class="clear"></div>
		
						<div class="sellerSupportWrap">
							<div class="itemSupport">
								<div class="title">
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_titleItemSupport.jpg" alt="상품문의현황" width="112" height="16">
								</div>
								<div style="width: 380px; margin: 15px 0 5px 0;">
									<span class="sptTitle">· 읽지않은문의글 (0건)</span> <span class="right">
										<a href="/main/mySell/support/my_itemSupport.php?status=UNREAD" class="noticeMore"> 더보기 <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg" class="pointer" alt="더보기" width="13" height="13">
									</a>
									</span>
									<ul>
										<li style="text-align: center;">최근 한 달 내 등록된 문의글이 없습니다.</li>
									</ul>
								</div>
								<div style="width: 380px; margin: 31px 0 5px 0;">
									<span class="sptTitle">· 답변없는문의글 (0건)</span> <span class="right">
										<a href="/main/mySell/support/my_itemSupport.php?status=NOREPLY" class="noticeMore"> 더보기 <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg" class="pointer" alt="더보기" width="13" height="13">
									</a>
									</span>
									<ul>
										<li style="text-align: center;">최근 한 달 내 등록된 문의글이 없습니다.</li>
									</ul>
								</div>
							</div>
							<div class="orderSupport">
								<div class="title">
									<img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_titleOrderSupport.jpg" alt="거래문의현황" width="112" height="16"> <span class="right">
										<a href="/main/mySell/chat/my_chatList.php" class="noticeMore">
											더보기 <img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg" class="pointer" alt="더보기" width="13" height="13">
									</a>
									</span>
								</div>
								<div style="width: 380px; margin: 5px 0 0 0;">
									<ul>
										<li style="text-align: center;">문의글이 없습니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="clear"></div>
		
						<div style="margin: 20px 0 14px 0;"></div>
						<div class="advWrap">
							<a href="/main/mySell/adv/my_advAdd.php"> <span class="advLeft"><img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_advAreaLeft.png" alt="매출상승의 지름길" width="380" height="98"></span>
							</a> <a href="/main/board/boardList.php?mode=inNS&amp;no=2785&amp;advcnt=SellMain">
								<span><img src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_advAreaRight.png" alt="상품등록시 판매가격(부가가치세 포함) 확인 안내" width="380" height="98"></span>
							</a>
						</div>
		
						<div style="margin: 14px auto 0px auto;">
							<a href="http://domeggook.com/7216492" target="_blank"> <img src="http://img.domeggook.com/image/mySell/adv/bnr_wondersAd.png" title="원더스 퀵서비스" alt="원더스 e쿠폰" width="770" height="113">
							</a>
						</div>
		
						<div style="margin: 14px auto 0px auto;">
							<a href="http://domeggook.com/main/information/info_list.php?mode=inNM&amp;no=4084" target="_blank"> <img src="http://img.domeggook.com/image/mySell/adv/bnr_shoplingAd.png" title="샵플링" alt="샵플링" width="770" height="110">
							</a>
						</div>
		
						<div style="margin: 14px auto 0px auto;">
							<a href="/main/affiliate/aff_pintech.php" target="_blank"> <img src="http://img.domeggook.com/image/mySell/adv/bnr_pintechAd.jpg" title="핀텍 링크" alt="핀텍 선결제 서비스" width="770" height="150">
							</a>
						</div>
		
						<div class="clear"></div>
		
						<!-- 스피드고배송관 -->
						<div style="width: 100%; margin-bottom: 15px; margin-top: 15px;">
							<a href="/main/mySell/storehouse/my_shAdd.php" style="display: block; margin-right: 18px; text-align: right;">
								<img src="http://211.43.195.137/image/mySell/storehouse/img_bnrStoreHouse.png" alt="스피드고배송관 등록" title="스피드고배송관 등록">
							</a>
						</div>
						<div class="customerCenter">
							<img src="http://211.43.195.137/image/v6/elements/my/common/img_bnrCustomerCenter.jpg" alt="고객센터" width="770" height="62">
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