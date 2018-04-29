<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- CSS -->
<!-- 공통 -->
<%@include file="/WEB-INF/views/common/include.jsp"%>
<!-- 공통 -->
<!-- 메인 -->
<link rel="stylesheet" type="text/css" href="/css/common/content.css">
<link rel="stylesheet" type="text/css" href="/css/myPage/myPageMain.css">
<!-- 메인 -->
<!-- CSS 끝 -->
</head>
	<body>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					<%@include file="/WEB-INF/views/common/myPageLeftMenu.jsp"%>
					<div id="v6RightContent">
						<!-- Contents -->
						<div id="myPageMainWrap">
	
							<!-- 회원정보 -->
							<div class="myPageSeller">
								<b>박승규(psk6402)</b>님 반갑습니다.
							</div>
	
							<!-- 나의 쿠폰현황 / 매뉴얼 myPageCouponNew-->
							<div class="myPageCoupon myPageCouponNew" style="height: 20px;">
								<!-- 아웃벌점제도로 인해 레이아웃 변경영역 (박종일) -->
								<div class="left" style="padding-top: 4px;">
									<b>나의 아웃벌점현황 :</b> <a
										href="/main/myPage/outPoint/my_outPoint.php"> 판매자아웃벌점 <b
										class="gray">0</b>점
									</a> | <a href="/main/myPage/outPoint/my_outPoint.php"> 구매자아웃벌점
										<b class="gray">0</b>점
									</a>
								</div>
								<div class="left" style="padding-left: 2px; padding-top: 0;">
									<a
										href="http://domeggook.com/main/popup/help/popup_helpView.php?no=3281&amp;back=L21haW4vcG9wdXAvaGVscC9wb3B1cF9oZWxwTGlzdC5waHA%2FY2F0PSZzdz0lQkUlQzYlQkYlRjQlQjklRkElQzElQTE%3D"
										onclick="popupOutHelp(); return false;" target="_blank"> <img
										src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_infoOutPointView.png"
										border="0" alt="아웃벌점제도안내 자세히보기">
									</a>
								</div>
								<div class="right">
									<a href="/binary/Doc/buyer_manual.pdf" target="_blank"> <img
										src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_manual1.jpg"
										width="53" height="20" border="0" alt="구매자 매뉴얼">
									</a> <a href="/binary/Doc/seller_manual.pdf" target="_blank"> <img
										src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_manual2.jpg"
										width="86" height="20" border="0" alt="판매자 매뉴얼">
									</a> <a href="http://get.adobe.com/kr/reader/" target="_blank">
										<img
										src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_manual3.jpg"
										width="78" height="20" border="0" alt="Adobe Reader">
									</a>
								</div>
							</div>
							<!-- 나의 회원등급현황 -->
							<div class="myPageMember">
								<div class="myPageMemGrade">
									<div class="myPageMemLevelTitle">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_memberLevel.jpg"
											width="98" height="14" border="0" alt="나의 회원등급현황"> (최근 <b>1개월</b>
										기준) <span> <a href="/main/myPage/score/my_scoreView.php">
												<b>더보기</b> <img
												src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg"
												width="12" height="12" border="0" alt="더보기">
										</a>
										</span>
									</div>
									<div class="myPageMemLevel">
										<table width="406px">
											<colgroup>
												<col width="*">
												<col width="203px">
											</colgroup>
											<tbody>
												<tr>
													<td>
														<div class="rankWrap rankTitle">판매등급</div>
														<div class="rankWrap">
															<img
																src="http://211.43.195.137/image/v6/elements/my/mypage/main/grade/blue/img_blueGrade1.png"
																width="54" height="54" border="0" alt="">
															<div class="rankFont">4</div>
															<div class="scoreFont">3,833점</div>
														</div>
													</td>
													<td>
														<div class="rankWrap rankTitle">구매등급</div>
														<div class="rankWrap">
															<img
																src="http://211.43.195.137/image/v6/elements/my/mypage/main/grade/blue/img_blueGrade1.png"
																width="54" height="54" border="0" alt="">
															<div class="rankFont">4</div>
															<div class="scoreFont">812점</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
	
								<!-- 나의 인증내역 -->
								<div class="myPageCertification">
									<div class="myPageCerTitle">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_certification.jpg"
											width="73" height="14" border="0" alt="나의 인증내역">
									</div>
									<div class="myPageCerContents">
										<a href="/main/myPage/authCenter/my_authMail.php"> <img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/auth/img_email.png"
											width="83" height="99" border="0" alt="이메일" title="이메일">
										</a> <a href="/main/myPage/authCenter/my_authPower.php"> <img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/auth/img_NoCertification.png"
											width="40" height="40" alt="미인증" title="미인증" class="noCert">
											<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/auth/img_power.png"
											width="84" height="99" border="0" alt="파워멤버" title="파워멤버">
										</a> <a href="/main/myPage/authCenter/my_authCompany.php"> <img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/auth/img_company.png"
											width="83" height="99" border="0" alt="사업자회원" title="사업자회원">
										</a> <a href="/main/myPage/authCenter/my_authMobile.php"> <img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/auth/img_mobile.png"
											width="84" height="99" border="0" alt="휴대폰" title="휴대폰">
										</a>
									</div>
								</div>
								<div class="gClearBoth"></div>
							</div>
	
							<div class="myPageConCenter">
	
								<!-- 회원정보수정 / 개인환경설정 -->
								<div class="myPageInfoModify">
									<div class="left">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_memInfoModify.jpg"
											width="70" height="14" alt="회원정보수정" class="btnName"> <a
											href="/main/member/mem_formRegular.php?mode=editRegular">
											<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/button/img_btnModify.jpg"
											width="76" height="20" alt="수정하기">
										</a>
									</div>
									<div class="right">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_personalPre.jpg"
											width="70" height="14" alt="개인환경설정" class="btnName"> <a
											href="/main/member/mem_config.php"> <img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/button/img_btnSet.jpg"
											width="76" height="20" alt="설정하기">
										</a>
									</div>
								</div>
	
								<!-- 세금계산서 발급현황 -->
								<div class="stat gFloatLeft">
									<img
										src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_statusTax.jpg"
										width="108" height="14" border="0" alt="세금계산서 발급현황">
	
									<table>
										<colgroup>
											<col width="125px">
											<col width="125px">
										</colgroup>
										<tbody>
											<tr>
												<td><span class="title">전체내역</span> <span
													class="valueShort"><b>17</b>건</span></td>
												<td><span class="title">5/4분기</span> <span
													class="valueShort"><b>0</b>건</span></td>
											</tr>
										</tbody>
									</table>
								</div>
	
								<!-- 포인트 현황 -->
								<div class="stat gFloatRight">
									<img
										src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_titlePointStatus.png"
										width="57" height="14" alt="포인트현황" title="포인트현황">
	
									<table>
										<colgroup>
											<col width="120px">
											<col width="149px">
										</colgroup>
										<tbody>
											<tr>
												<td><span class="title">보유액</span> <span
													class="valueLong"><b>0</b>P</span></td>
												<td><span class="title">금월소멸예정</span> <span
													class="valueLong"><b>0</b>P</span></td>
											</tr>
										</tbody>
									</table>
	
								</div>
								<div class="gClearBoth"></div>
							</div>
	
							<!-- 회원지원센터 -->
							<div class="supportCenterWrap">
								<a href="/main/mySell/sellerSupport/sell_supportCenterMain.php">
									<img
									src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_bnrMemberSupportCenter.jpg"
									alt="회원지원센터" width="770" height="100">
								</a>
							</div>
	
							<div class="myPageConBottom">
	
								<!-- 공지사항 -->
								<div class="myPageNotice gFloatLeft">
									<div class="myPageNoticeTitle">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_notice.jpg"
											width="49" height="14" border="0" alt="공지사항"> <span>
											<a href="/main/board/boardList.php?mode=inNY"> <b>더보기</b>
												<img
												src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg"
												width="12" height="12" border="0" alt="더보기">
										</a>
										</span>
									</div>
									<div class="myPageNoticeCon">
										<table>
											<colgroup>
												<col width="225">
												<col width="50" align="right">
											</colgroup>
											<tbody>
	
												<tr>
													<td><a
														href="/main/board/boardList.php?mode=inNY&amp;no=4207"
														class="title">[구인] 고객지원센터에서 인재를 찾습니다....</a></td>
													<td class="date">17/10/27</td>
												</tr>
	
												<tr>
													<td><a
														href="/main/board/boardList.php?mode=inNY&amp;no=4205"
														class="title">[공지] 포인트 적립 기준 변경 안내</a></td>
													<td class="date">17/10/26</td>
												</tr>
	
												<tr>
													<td><a
														href="/main/board/boardList.php?mode=inNY&amp;no=4181"
														class="title">[언론보도] 도매꾹은 어떻게 최저가를 유지...</a></td>
													<td class="date">17/09/14</td>
												</tr>
	
												<tr>
													<td><a
														href="/main/board/boardList.php?mode=inNY&amp;no=4180"
														class="title">[공지] 도매꾹 이용약관 및 개인정보처리방...</a></td>
													<td class="date">17/09/14</td>
												</tr>
	
												<tr>
													<td><a
														href="/main/board/boardList.php?mode=inNY&amp;no=4164"
														class="title">[서적] 무재고/무자본 오픈마켓 전문셀러 완...</a></td>
													<td class="date">17/08/31</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
	
								<!-- 이머니 현황 -->
								<div class="myPageEmoney gFloatLeft">
									<div class="myPageEmoneyTitle">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_emoneyStatus.jpg"
											width="82" height="14" border="0" alt="이머니현황">
									</div>
									<div class="myPageEmoneyCon">
										<table width="100%">
											<colgroup>
												<col width="60px">
												<col width="65px">
												<col width="*px">
											</colgroup>
											<tbody>
												<tr>
													<td colspan="2" class="title"><b>사용가능 e-money</b></td>
													<td class="amt"><b>19,035</b>원</td>
												</tr>
												<tr class="childTop">
													<td class="title"><b>·</b> 카드성</td>
													<td class="button"><a
														href="/main/myPage/emoney/my_emoneyIn.php"> <img
															src="http://211.43.195.137/image/v6/elements/my/mypage/main/button/img_btnCharge.jpg"
															width="58" height="20" border="0" alt="충전하기">
													</a></td>
													<td class="amt">0원</td>
												</tr>
												<tr class="childBottom">
													<td class="title"><b>·</b> 현금성</td>
													<td class="button"><a
														href="/main/myPage/emoney/my_emoneyOut.php"> <img
															src="http://211.43.195.137/image/v6/elements/my/mypage/main/button/img_btnWithdraw.jpg"
															width="58" height="20" border="0" alt="출금하기">
													</a></td>
													<td class="amt">19,035원</td>
												</tr>
												<tr class="myPageEmoneyConTr">
													<td colspan="2" class="title"><b>출금대기금액<b> </b></b></td>
													<td class="amt"><b>0<b>원 </b></b></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
	
								<!-- 나의 상담기록 -->
								<div class="myPageCounRecode gFloatLeft">
									<div class="myPageCounRecodeTitle">
										<img
											src="http://211.43.195.137/image/v6/elements/my/mypage/main/img_counRecode.jpg"
											width="76" height="14" border="0" alt="나의 상담기록"> <span>
											<a href="/main/myPage/support/my_supportList.php"> <b>더보기</b>
												<img
												src="http://211.43.195.137/image/v6/elements/my/mysell/main/img_btnMore.jpg"
												width="12" height="12" border="0" alt="">
										</a>
										</span>
									</div>
									<div class="myPageCounRecodeCon">
										<ul>
	
											<li><img src="/image/myPage/support/ico_supportDone.gif"
												width="37" height="16" border="0" align="absmiddle"> <a
												href="/main/myPage/support/my_supportView.php?no=368088">스피드배송관
													상품 철회...</a></li>
	
											<li><img src="/image/myPage/support/ico_supportDone.gif"
												width="37" height="16" border="0" align="absmiddle"> <a
												href="/main/myPage/support/my_supportView.php?no=331940">[SH6962314]
													▣6개월교환...</a></li>
	
											<li><img src="/image/myPage/support/ico_supportDone.gif"
												width="37" height="16" border="0" align="absmiddle"> <a
												href="/main/myPage/support/my_supportView.php?no=331938">[SH7052523]
													방탄9H 강화...</a></li>
	
											<li><img src="/image/myPage/support/ico_supportDone.gif"
												width="37" height="16" border="0" align="absmiddle"> <a
												href="/main/myPage/support/my_supportView.php?no=331888">[SH6962314]
													▣6개월교환...</a></li>
	
											<li><img src="/image/myPage/support/ico_supportDone.gif"
												width="37" height="16" border="0" align="absmiddle"> <a
												href="/main/myPage/support/my_supportView.php?no=331886">[SH7052523]
													방탄9H 강화...</a></li>
										</ul>
									</div>
								</div>
								<div class="gClearBoth"></div>
							</div>
							<div style="margin: 20px 0 0 0;"></div>
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