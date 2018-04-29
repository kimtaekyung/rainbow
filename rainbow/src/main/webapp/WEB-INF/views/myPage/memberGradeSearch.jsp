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
						<div class="v6Location">
							현재위치 : <a href="/main/">HOME</a> &gt; <a
								href="/main/myPage/my_pageMain.php">마이페이지</a> &gt; 개인정보관리 &gt; <b>회원등급조회</b>
						</div>
						<div id="v5ContentsWrap">
	
							<!--안내 시작-->
							<table width="770" border="0" cellpadding="0" cellspacing="0"
								align="center">
								<tbody>
									<tr>
										<td bgcolor="#9bcd38" height="1"></td>
									</tr>
									<tr>
										<td bgcolor="#dcdddf" height="3"></td>
									</tr>
								</tbody>
							</table>
	
	
							<table width="770" border="0" cellpadding="0" cellspacing="0"
								align="center" bgcolor="#f7f7f7">
								<tbody>
									<tr valign="top">
										<td width="250" valign="top">
	
											<table width="100%" border="0" cellpadding="10"
												cellspacing="1" align="center">
												<tbody>
													<tr>
														<td>
															<li><b>나의</b> 회원점수 및 등급내역</li>
														<li><a href="javascript:popupHelpView(922,'')"><font
																	color="#0000cc"><b><u>회원점수 산출 규정</u></b></font></a>
																<br></li>
														</td>
													</tr>
												</tbody>
											</table>
	
										</td>
										<td width="160"></td>
										<td width="200" valign="top">
	
											<table width="100%" border="0" cellpadding="10"
												cellspacing="1" bgcolor="#ffffff" align="center">
												<tbody>
													<tr>
														<form></form>
														<td bgcolor="#f7f7f7">
															<li>다른 회원의 회원점수 조회 <br> &nbsp; &nbsp; <input
																type="text" class="input" size="15" name="id"
																value="psk6402"> <input type="image"
																src="/image/member/btn_search.gif" align="absmiddle">
														</li>
														</td>
													</tr>
	
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
	
							<table width="770" border="0" cellpadding="0" cellspacing="0"
								align="center">
								<tbody>
									<tr>
										<td bgcolor="#dcdddf" height="3"></td>
									</tr>
									<tr>
										<td bgcolor="#9bcd38" height="1"></td>
									</tr>
								</tbody>
							</table>
							<!--안내 종료-->
	
	
							<p></p>
	
	
							<!--항목별등급 시작-->
							<table width="770" border="0" cellpadding="0" cellspacing="0"
								align="center">
	
								<!--레이아웃정의-->
								<colgroup>
									<col width="385" style="padding: 0 10 0 0">
									<col width="384" style="padding: 0 0 0 10">
	
								</colgroup>
								<tbody>
									<tr>
										<td><img src="/image/common/ico_common2.gif" width="18"
											height="18" border="0" align="absmiddle"> <img
											src="/image/member/level/ttl_levelSEL.gif" width="58"
											height="15" border="0" align="absmiddle"></td>
										<td style="padding: 0 0 0 35"><img
											src="/image/common/ico_common2.gif" width="18" height="18"
											border="0" align="absmiddle"> <img
											src="/image/member/level/ttl_levelBUY.gif" width="58"
											height="15" border="0" align="absmiddle"></td>
									</tr>
	
									<tr>
										<td colspan="2" height="10"></td>
									</tr>
	
									<tr valign="top">
										<td>
											<!--판매등급 시작-->
											<table width="363" border="0" cellpadding="0" cellspacing="0">
												<tbody>
													<tr>
														<td><img
															src="/image/member/level/bgi_levelGraphBoxTop.gif"
															width="363" height="4" border="0" align="absmiddle"></td>
													</tr>
													<tr>
														<td
															background="/image/member/level/bgi_levelGraphBoxMiddle.gif"
															style="padding: 10 0 10 0">
	
															<table width="335" height="112" border="0" cellpadding="0"
																cellspacing="0" align="center">
																<tbody>
																	<tr>
																		<td width="108">
																			<table width="108" height="112" border="0"
																				cellpadding="0" cellspacing="0" align="center"
																				background="/image/member/level/bgi_levelBoxSmall.gif">
																				<tbody>
																					<tr align="center">
																						<td height="80">
																							<!--등급 아이콘--> <img
																							src="/image/member/level/ico_62level4.gif"
																							border="0" align="absmiddle">
	
																						</td>
																					</tr>
																					<tr align="center">
																						<td height="26">
																							<!--등급 점수--> 3,833점
	
																						</td>
																					</tr>
																				</tbody>
																			</table>
																		</td>
																		<td width="227" align="right">
																			<!--등급 그래프--> <img
																			src="/main/myPage/score/my_scoreGraph.php?cat=SEL&amp;id=psk6402"
																			width="210" height="112" border="0" align="absmiddle">
	
																		</td>
																	</tr>
																</tbody>
															</table>
	
														</td>
													</tr>
													<tr>
														<td><img
															src="/image/member/level/bgi_levelGraphBoxBottom.gif"
															width="363" height="4" border="0" align="absmiddle"></td>
													</tr>
												</tbody>
											</table> <!--판매등급 종료-->
	
										</td>
										<td>
											<!--구매등급 시작-->
											<table width="363" border="0" cellpadding="0" cellspacing="0"
												align="right">
												<tbody>
													<tr>
														<td><img
															src="/image/member/level/bgi_levelGraphBoxTop.gif"
															width="363" height="4" border="0" align="absmiddle"></td>
													</tr>
													<tr>
														<td
															background="/image/member/level/bgi_levelGraphBoxMiddle.gif"
															style="padding: 10 0 10 0">
	
															<table width="335" height="112" border="0" cellpadding="0"
																cellspacing="0" align="center">
																<tbody>
																	<tr>
																		<td width="108">
																			<table width="108" height="112" border="0"
																				cellpadding="0" cellspacing="0" align="center"
																				background="/image/member/level/bgi_levelBoxSmall.gif">
																				<tbody>
																					<tr align="center">
																						<td height="80">
																							<!--등급 아이콘--> <img
																							src="/image/member/level/ico_62level4.gif"
																							border="0" align="absmiddle">
	
																						</td>
																					</tr>
																					<tr align="center">
																						<td height="26">
																							<!--등급 점수--> 812점
	
																						</td>
																					</tr>
																				</tbody>
																			</table>
																		</td>
																		<td width="227" align="right">
																			<!--등급 그래프--> <img
																			src="/main/myPage/score/my_scoreGraph.php?cat=BUY&amp;id=psk6402"
																			width="210" height="112" border="0" align="absmiddle">
	
																		</td>
																	</tr>
																</tbody>
															</table>
	
														</td>
													</tr>
													<tr>
														<td><img
															src="/image/member/level/bgi_levelGraphBoxBottom.gif"
															width="363" height="4" border="0" align="absmiddle"></td>
													</tr>
												</tbody>
											</table> <!--구매등급 종료-->
	
										</td>
									</tr>
	
	
	
	
	
								</tbody>
							</table>
							<!--항목별등급 종료-->
	
	
	
	
	
	
							<p></p>
							<br>
	
							<!--상세정보 시작-->
							<table width="770" border="0" cellpadding="0" cellspacing="0"
								align="center">
								<tbody>
									<tr>
										<td width="*"><img src="/image/common/ico_common2.gif"
											width="18" height="18" border="0" align="absmiddle"> <img
											src="/image/member/level/ttl_levelDetail.gif" width="127"
											height="15" border="0" align="absmiddle"></td>
										<td width="230px" nowrap=""><font color="gray"> 최근
												30일간의 회원점수 변동 기록 입니다 </font></td>
									</tr>
									<tr>
										<td colspan="2" height="10"></td>
									</tr>
									<tr>
										<td colspan="2" bgcolor="#9bcd38" height="1"></td>
									</tr>
									<tr>
										<td colspan="2" bgcolor="#dcdddf" height="3"></td>
									</tr>
									<tr>
										<td colspan="2" height="10"></td>
									</tr>
								</tbody>
							</table>
	
	
							<table width="770" border="0" cellpadding="8" cellspacing="1"
								bgcolor="#ffffff" align="center">
								<tbody>
									<tr bgcolor="#dcdddf" align="center">
										<td width="60px" nowrap="">번호</td>
										<td width="88px" nowrap=""><select style="width: 80px"
											onchange="CatControl(this)">
												<option value="">전체분류</option>
												<option value="">───────</option>
												<option value="SEL">판매점수</option>
												<option value="BUY">구매점수</option>
												<option value="ACT">활동점수</option>
												<option value="SRV">기여점수</option>
												<option value="CRD">평가점수</option>
										</select></td>
										<td width="*">설명</td>
										<td width="68px" nowrap="">증가된점수</td>
										<td width="68px" nowrap="">감소된점수</td>
										<td width="78px" nowrap="">점수반영결과</td>
										<td width="112px" nowrap="">발생시간</td>
									</tr>
	
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">64097396</td>
										<td nowrap="" align="center">구매점수</td>
										<td>[OR11984331] 상품구매완료</td>
										<td nowrap="" align="right">2</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">812</td>
										<td nowrap="" align="center">2017.12.04 14:00:01</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">63827807</td>
										<td nowrap="" align="center">판매점수</td>
										<td>[OR11890487] 상품판매완료</td>
										<td nowrap="" align="right">1</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">3833</td>
										<td nowrap="" align="center">2017.11.27 14:00:02</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">63506231</td>
										<td nowrap="" align="center">구매점수</td>
										<td>[OR11846188] 상품구매완료</td>
										<td nowrap="" align="right">2</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">810</td>
										<td nowrap="" align="center">2017.11.14 16:41:30</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">63475130</td>
										<td nowrap="" align="center">구매점수</td>
										<td>[OR11846187] 상품구매완료</td>
										<td nowrap="" align="right">2</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">808</td>
										<td nowrap="" align="center">2017.11.13 14:00:01</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">61130736</td>
										<td nowrap="" align="center">구매점수</td>
										<td>[OR11057666] 상품구매완료</td>
										<td nowrap="" align="right">2</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">806</td>
										<td nowrap="" align="center">2017.08.07 08:00:01</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">60689683</td>
										<td nowrap="" align="center">구매점수</td>
										<td>[OR10912220] 상품구매완료</td>
										<td nowrap="" align="right">2</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">804</td>
										<td nowrap="" align="center">2017.07.20 14:00:01</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">60614831</td>
										<td nowrap="" align="center">판매점수</td>
										<td>[OR10953800] 상품판매완료</td>
										<td nowrap="" align="right">1</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">3832</td>
										<td nowrap="" align="center">2017.07.17 14:00:02</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">60541810</td>
										<td nowrap="" align="center">평가점수</td>
										<td>구매만족도 (만족)</td>
										<td nowrap="" align="right">1</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">372</td>
										<td nowrap="" align="center">2017.07.14 21:35:22</td>
									</tr>
	
									<tr bgcolor="#ebebeb">
										<td nowrap="" align="center">60472189</td>
										<td nowrap="" align="center">판매점수</td>
										<td>[OR10693091] 상품판매완료</td>
										<td nowrap="" align="right">1</td>
										<td nowrap="" align="right"></td>
										<td nowrap="" align="right">3831</td>
										<td nowrap="" align="center">2017.07.12 14:00:01</td>
									</tr>
	
									<tr bgcolor="#f7f7f7" align="center">
										<td colspan="7" height="60"><a
											href="my_scoreLog.php?scat="><span class="linkBlue">
													더 많은 기록을 보려면 클릭하세요 </span></a></td>
									</tr>
								</tbody>
							</table>
							<p></p>
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