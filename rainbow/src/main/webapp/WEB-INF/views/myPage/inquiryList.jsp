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
<link rel="stylesheet" type="text/css" href="/css/myPage/inquiryList.css">
<script type="text/javascript" src="/js/myPage/inquiryList.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">1:1상담</a> &gt; <b>상담글목록</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">1:1 상담글 목록</span>
							</div>
							<form id="inquiryListForm" action="/myPage/inquiryList.do">
								<input type="hidden" id="page" name="page" value="${resultMap.page}">
								<input type="hidden" name="pageSize" value="${resultMap.pageSize}">
								<!--안내 시작-->
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td class="left">
												<p class="textLimit">1:1상담 운영 시간은 평일 시 ~ 시, 토요일 시 ~ 시입니다</p>
												<p class="textLimit">1:1상담에 질문을 등록하기 전에 <a href=""><font color="#0000cc"><b><u>도움말</u></b></font></a>을 먼저 읽어보기 바랍니다.</p>
											</td>
										</tr>
									</tbody>
								</table>
								<!--안내 종료-->
								<div class="excel_area_div">
									<div class="verticalMiddleParent">
										<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
										<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀다운로드</a>
									</div>
								</div>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<th>등록일</th>
											<td colspan="4">
												<select class="select_default" name="quick" onchange="javascript:changeQuickDate(this.value,'inquiryListForm','sch_sdate','sch_edate');">
													<option value="" 			${resultMap.quick eq '' ? 'selected' :'' }>빠른선택</option>
													<option value="day" 		${resultMap.quick eq 'day' ? 'selected' :'' }>오늘</option>
													<option value="week" 		${resultMap.quick eq 'week' ? 'selected' :'' }>1주일</option>
													<option value="month" 		${resultMap.quick eq 'month' ? 'selected' :'' }>1개월</option>
													<option value="threeMonth" 	${resultMap.quick eq 'threeMonth' ? 'selected' :'' }>3개월</option>
													<option value="sixMonth" 	${resultMap.quick eq 'sixMonth' ? 'selected' :'' }>6개월</option>
													<option value="year" 		${resultMap.quick eq 'year' ? 'selected' :'' }>1년</option>
												</select>
												<input type="text" name="sch_sdate" value="${resultMap.sch_sdate }" class="datepicker input_default">
												<span class="span_default"> ~ </span>  
												<input type="text" name="sch_edate" value="${resultMap.sch_edate }" class="datepicker input_default">
												
											</td>
										</tr>
										<tr>
											<th>검색어</th>
											<td colspan="4">
												<select name="search_type" class="select_default">
													<option value="TITLE" ${resultMap.search_type eq 'TITLE' ? 'selected' : '' }>제목</option>
													<option value="CONTENT" ${resultMap.search_type eq 'CONTENT' ? 'selected' : '' }>내용</option>
													<option value="ALL" ${resultMap.search_type eq 'ALL' ? 'selected' : '' }>제목+내용</option>
												</select>
												<input type="text" name="search_word" value="${resultMap.search_word }">
												<button class="button_default" type="button" onclick="searchFormSubmit('inquiryListForm');" >찾기</button>
											</td>
										</tr>
									</tbody>
								</table>
								
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td >총 <b><fmt:formatNumber value="${resultMap.total }" pattern="#,###" /></b>건의 상담글이 있습니다</td>
										</tr>
									</tbody>
								</table>	
								
								<table class="common_table_normal">
									<colgroup>
										<col width="70">
										<col width="120">
										<col width="*">
										<col width="70">
										<col width="120">
										<col width="100">
									</colgroup>
									<tbody>
										<tr>
											<th>번호</th>
											<th>상담분류</th>
											<th>제목</th>
											<th>답변</th>
											<th>담당자</th>
											<th>등록일</th>
										</tr>
			
										<c:choose>
											<c:when test="${not empty resultMap.inquiryList }">
												
												<c:forEach var="data" items="${resultMap.inquiryList }">
													<tr>
														<td class="center textLimit"><span class="span_default"><fmt:parseNumber>${data.ROWNUM }</fmt:parseNumber></span></td>
														<td class="center textLimit"><span class="span_default">${data.RIT_NAME }</span></td>
														<td class="center textLimit verticalMiddleParent">
															<c:if test="${data.RI_IS_ANSWER eq '1'}">
																<img class="verticalMiddleChild" src="/images/myPage/ico_supportDone.png">
															</c:if>
															<a class="verticalMiddleChild" href="/myPage/inquiryView.do?ri_seq=${data.RI_SEQ }">${data.RI_SUBJECT }</a>
														</td>
														<td class="center textLimit"><span class="span_default">${data.RI_IS_ANSWER eq '0' ? '미답변' : '답변' }</span></td>
														<td class="center textLimit"><span class="span_default">${not empty data.ANSWER_MB_NAME ? data.ANSWER_MB_NAME : '' }</span></td>
														<td class="center textLimit"><span class="span_default"><font face="굴림체" title="${data.RI_REG_DTTM}">${fn:split(data.RI_REG_DTTM,' ')[0]}</font></span></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td class="center" colspan="6">등록된 문의가 없습니다.</td>
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
								<!-- <table width="770" border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td width="50%">
												<a href="/myPage/inquiryList.do">
													<img src="/images/myPage/btn_supportList.gif" width="97" height="20" border="0" align="absmiddle">
												</a>
											</td>
											<td width="50%" nowrap="" align="right">
												<a href="/myPage/inquiryWrite.do">
													<img src="/images/myPage/btn_supportWrite.gif" width="97" height="20" border="0" align="absmiddle">
												</a>
											</td>
										</tr>
									</tbody>
								</table> -->
								<p></p>
								<br>
							</form>
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