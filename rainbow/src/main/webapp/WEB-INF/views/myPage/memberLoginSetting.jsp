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
<link rel="stylesheet" type="text/css" href="/css/myPage/memberLoginSetting.css">
<script type="text/javascript" src="/js/myPage/memberLoginSetting.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">개인정보관리</a> &gt; <b>로그인관리</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">로그인 관리</span>
							</div>
							<div>
								<ul id="loginMngTabUl">
									<li class="loginMngTabUl  ${resultMap.menuType eq '1' ? 'selected' : ''}" onClick="javascript:location.href='/myPage/memberLoginSetting.do?menuType=1'">로그인현황보기</li>
									<li class="loginMngTabUl  ${resultMap.menuType eq '2' ? 'selected' : ''}" onClick="javascript:location.href='/myPage/memberLoginSetting.do?menuType=2'">로그인기록보기</li>
									<li class="loginMngTabUl  ${resultMap.menuType eq '3' ? 'selected' : ''}" onClick="javascript:location.href='/myPage/memberLoginSetting.do?menuType=3'">로그인차단설정</li>
								</ul>
								<form id="loginSettingForm" action="/myPage/memberLoginSetting.do?menuType=${resultMap.menuType}">
									<input type="hidden" name="menuType" value="${resultMap.menuType}">
									<input type="hidden" id="page" name="page" value="${resultMap.page}">
									<input type="hidden" name="pageSize" value="${resultMap.pageSize}">
									<c:choose>
										<c:when test="${resultMap.menuType eq '1'}">
											<!-- 로그인 현황 -->
											<div id="loginInfoWrap">
												<!--안내 시작-->
												<table class="common_table_normal">
													<tbody>
														<tr>
															<td class="left">
																<p class="textLimit">현재 로그인 중인 기기 또는 PC의 목록을 확인할 수 있으며, <b>[연결끊기]</b>를 클릭하면 로그아웃됩니다</p>
																<p class="textLimit">활동 및 로그인 일시 정보는 시스템 상황에 따라 일부 오차가 있을 수 있습니다</p>
															</td>
														</tr>
													</tbody>
												</table>
												<table class="common_table_normal">
													<tbody>
														<tr>
															<td>총 <b>${resultMap.total}</b>건의 로그인 현황이 있습니다</td>
														</tr>
													</tbody>
												</table>
												<table class="common_table_normal">
													<colgroup>
														<col width="270px">
														<col width="*">
														<col width="110px">
														<col width="150px">
														<col width="80px">
													</colgroup>
													<thead>
														<tr>
															<th>운영체제 및 브라우저</th>
															<th>로그인IP</th>
															<th>기기타입</th>
															<th>최초 로그인일시</th>
															<th>관리</th>
														</tr>
													</thead>
													<tbody>
														<c:choose>
															<c:when test="${not empty resultMap.loginSessionList }">
																<c:forEach var="data" items="${resultMap.loginSessionList }">
																	<tr>
																		<td class="center textLimit" title="${data.LO_DEVICE_ENV}">${data.LO_DEVICE_ENV}</td>
																		<td class="center textLimit">${data.LO_IP}</td>
																		<td class="center textLimit">${data.LO_DEVICE_TYPE}</td>
																		<td class="center textLimit">${data.LO_DTTM}</td>
																		<td class="center textLimit">
																			<c:if test="${resultMap.mySessionId ne data.MB_SESSION_ID }">
																				<button class="button_default" type="button" onclick="disConnectSession('${data.MB_SESSION_ID}');">해제</button>
																			</c:if>
																		</td>
																	</tr>
																</c:forEach>
															</c:when>
															<c:otherwise>
																<tr>
																	<td class="center" colspan="5">기록이없습니다.</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</tbody>
												</table>
												<table class="common_table_normal">
													<tbody>
														<tr>${resultMap.paging }</tr>
													</tbody>
												</table>
											</div>
										</c:when>
										<c:when test="${resultMap.menuType eq '2'}">
											<!-- 로그인 기록 -->
											<div id="loginListWrap" style="display: ${resultMap.menuType eq '2' ? 'block' : 'none'};">
												<!--안내 시작-->
												<table class="common_table_normal">
													<tbody>
														<tr>
															<td class="left">
																<p class="textLimit">로그인 기록은 통신비밀보호법에 의해 최대 3개월까지만 보관됩니다</p>
																<p class="textLimit">로그인 일시 정보는 시스템 상황에 따라 일부 오차가 있을 수 있습니다</p>
															</td>
														</tr>
													</tbody>
												</table>
												<!--안내 종료-->
												<table class="common_table_normal">
													<tbody>
														<tr>
															<td>총 <b>${resultMap.total}</b>건의 로그인 현황이 있습니다</td>
														</tr>
													</tbody>
												</table>
												<table class="common_table_normal">
													<colgroup>
														<col width="150px">
														<col width="120px">
														<col width="200px">
														<col width="80px">
														<col width="140px">
														<col width="*">
													</colgroup>
													<thead>
														<tr>
															<th nowrap="nowrap">일시</th>
															<th nowrap="nowrap">타입</th>
															<th nowrap="nowrap">운영체제 및 브라우저</th>
															<th nowrap="nowrap">PC/모바일</th>
															<th nowrap="nowrap">아이피</th>
															<th nowrap="nowrap">IP</th>
														</tr>
													</thead>
													<tbody>
														<c:choose>
															<c:when test="${not empty resultMap.loginLogList }">
																<c:forEach var="data" items="${resultMap.loginLogList }">
																	<tr>
																		<td class="center textLimit">${data.LO_DTTM}</td>
																		<td class="center textLimit">${data.LO_TYPE}</td>
																		<td class="center textLimit"title="${data.LO_DEVICE_ENV}" class="textLimit">${data.LO_DEVICE_ENV}</td>
																		<td class="center textLimit">${data.LO_DEVICE_TYPE}</td>
																		<td class="center textLimit">${data.LO_IP}</td>
																		<td class="center textLimit">
																			<button class="button_default" type="button" onclick="blockIp('${data.LO_IP}');">차단</button>
																		</td>
																	</tr>
																</c:forEach>
															</c:when>
															<c:otherwise>
																<tr>
																	<td align="center" colspan="6">기록이없습니다.</td>
																</tr>
															</c:otherwise>
														</c:choose>
													</tbody>
												</table>
												<table class="common_table_normal">
													<tbody>
														<tr>${resultMap.paging }</tr>
													</tbody>
												</table>
											</div>
										</c:when>
										<c:otherwise>
											<!-- 로그인 차단 설정 -->
											<div id="loginBlockWrap" style="display: ${resultMap.menuType eq '3' ? 'block' : 'none'};">
												<!--안내 시작-->
												<table class="common_table_normal">
													<tbody>
														<tr>
															<td class="left">
																<p class="textLimit">특정 IP주소를 등록하여 로그인을 차단할 수 있습니다</p>
																<p class="textLimit">차단된 IP주소로 로그인이 시도되는 경우, 아이디와 비밀번호 이외에 본인 정보를 추가로 입력해야만 로그인 할 수 있습니다</p>
																<p class="textLimit">현재 접속한 IP주소는 <b>${resultMap.nowIp }</b> 입니다</p>
															</td>
														</tr>
													</tbody>
												</table>
												<!--안내 종료-->
												<table class="common_table_normal">
													<tbody>
														<tr>
															<td>
																<span>총 <b>${resultMap.total}</b>건의 IP차단 기록이 있습니다</span>
																<input type="text" class="input" id="blockIp" onkeydown="if(event.keyCode == 13){blockIpInputValue();}">
																<button class="button_default" type="button" onclick="blockIpInputValue();">차단</button>
															</td>
														</tr>
													</tbody>
												</table>
												
												<table class="common_table_normal">
													<colgroup>
														<col width="300px">
														<col width="*">
														<col width="120px">
													</colgroup>
													<thead>
														<tr>
															<th>차단IP</th>
															<th>차단일시</th>
															<th>삭제</th>
														</tr>
													</thead>
													<tbody>
														<c:choose>
															<c:when test="${not empty resultMap.blockIpList }">
																<c:forEach var="data" items="${resultMap.blockIpList }">
																	<tr>
																		<td class="center textLimit">${data.MB_IP }</td>
																		<td class="center textLimit">${data.REG_DTTM }</td>
																		<td class="center textLimit">
																			<button class="button_default" type="button" onclick="deleteBlockIp('${data.MBI_SEQ}');">해제</button>
																		</td>
																	</tr>
																</c:forEach>	
															</c:when>
															<c:otherwise>
																<tr>
																	<td class="center" colspan="3">차단된 IP주소가 없습니다</td>
																</tr>
															</c:otherwise>	
														</c:choose>
													</tbody>
												</table>
												<table class="common_table_normal">
													<tbody>
														<tr>${resultMap.paging }</tr>
													</tbody>
												</table>
											</div>
										</c:otherwise>
									</c:choose>
								</form>
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