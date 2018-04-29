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
<link rel="stylesheet" type="text/css" href="/css/myPage/letterList.css">
<script type="text/javascript" src="/js/myPage/letterList.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">1:1상담</a> &gt; <b>쪽지수신함</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">1:1 상담 쪽지 수신함</span>
							</div>
							<form id="letterListForm" action="/myPage/letterList.do">
								<input type="hidden" id="page" name="page" value="${resultMap.page}">
								<input type="hidden" name="pageSize" value="${resultMap.pageSize}">
								<table class="common_table_normal">
									<tbody>
										<tr>
											<th>등록일</th>
											<td colspan="4">
												<select class="select_default" name="quick" onchange="javascript:changeQuickDate(this.value,'letterListForm','sch_sdate','sch_edate');">
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
												<input type="radio" id="rl_view_state_1" name="rl_view_state" value="0" ${resultMap.rl_view_state eq '0' ? 'checked' : '' }><label for="rl_view_state_1">전체</label>
												<input type="radio" id="rl_view_state_2" name="rl_view_state" value="1" ${resultMap.rl_view_state eq '1' ? 'checked' : '' }><label for="rl_view_state_2">미확인</label>
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
												<button class="button_default" type="button" onclick="searchFormSubmit('letterListForm');" >찾기</button>
											</td>
										</tr>
									</tbody>
								</table>
								<%-- <div style="position: relative; top: 0; left: 0; margin: 8px 0; padding: 10px; border: 1px solid #ccc; background-color: #f3f3f3">
									<div class="searchDate">
										<span style="color: #1b1b1b;font-size: 12px;line-height: 150%;font-weight: bold;">등록일&nbsp;&nbsp;</span>
										<select style="width: 90px;height: 23px;" name="quick" onchange="javascript:changeQuickDate(this.value,'letterListForm','sch_sdate','sch_edate');">
											<option value="" 			${resultMap.quick eq '' ? 'selected' :'' }>빠른선택</option>
											<option value="day" 		${resultMap.quick eq 'day' ? 'selected' :'' }>오늘</option>
											<option value="week" 		${resultMap.quick eq 'week' ? 'selected' :'' }>1주일</option>
											<option value="month" 		${resultMap.quick eq 'month' ? 'selected' :'' }>1개월</option>
											<option value="threeMonth" 	${resultMap.quick eq 'threeMonth' ? 'selected' :'' }>3개월</option>
											<option value="sixMonth" 	${resultMap.quick eq 'sixMonth' ? 'selected' :'' }>6개월</option>
											<option value="year" 		${resultMap.quick eq 'year' ? 'selected' :'' }>1년</option>
										</select>
										<input type="text" name="sch_sdate" value="${resultMap.sch_sdate }" class="datepicker" style="width:75px;text-align: center;"> ~ 
										<input type="text" name="sch_edate" value="${resultMap.sch_edate }" class="datepicker" style="width:75px;text-align: center;">
										<br/><br/>
		                             	<span style="color: #1b1b1b;font-size: 12px;line-height: 150%;font-weight: bold;">검색어&nbsp;&nbsp;</span>
		                             	<select name="search_type" style="width: 100px; height: 23px;">
											<option value="TITLE" ${resultMap.search_type eq 'TITLE' ? 'selected' : '' }>제목</option>
											<option value="CONTENT" ${resultMap.search_type eq 'CONTENT' ? 'selected' : '' }>내용</option>
											<option value="ALL" ${resultMap.search_type eq 'ALL' ? 'selected' : '' }>제목+내용</option>
										</select>
										<input type="text" name="search_word" value="${resultMap.search_word }">
										<img src="/images/common/btn_search.gif" onclick="searchFormSubmit('letterListForm');" align="absmiddle" width="57" height="23" border="0" alt="찾기" title="찾기" style="cursor: pointer;">
										<br/>
										<div>
											<input type="radio" name="rl_view_state" value="0" ${resultMap.rl_view_state eq '0' ? 'checked' : '' }><label>전체</label>
											<input type="radio" name="rl_view_state" value="1" ${resultMap.rl_view_state eq '1' ? 'checked' : '' }><label>미확인</label>
										</div>
									</div>
								</div> --%>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td>총 <b><fmt:formatNumber value="${resultMap.total }" pattern="#,###" /></b>건의 쪽지가 있습니다</td>
										</tr>
									</tbody>
								</table>
								<div style="margin: 10px;">
									<span class="span_default"><button type="button" class="button_default" onclick="updateLetterList('delete');">선택삭제</button></span>
									<span class="span_default"><button type="button" class="button_default" onclick="updateLetterList('update');">선택확인</button></span>
								</div>
								
								<table class="common_table_normal">
									<colgroup>
										<col width="40">
										<col width="70">
										<col width="130">
										<col width="*">
										<col width="100">
										<col width="100">
									</colgroup>
									<tbody>
										<tr>
											<th><input type="checkbox" id="letterCheckAll" children_name="rl_seq" onchange="checkBoxAllCheck(this);"></th>
											<th>번호</th>
											<th>보낸사람</th>
											<th>제목</th>
											<th>확인/미확인</th>
											<th>보낸일시</th>
										</tr>
										<c:choose>
											<c:when test="${not empty resultMap.letterList }">
												<c:forEach var="data" items="${resultMap.letterList }">
													<tr>
														<td class="center"><input type="checkbox" name="rl_seq" value="${data.RL_SEQ }" onchange="checkBoxOneCheck(this, 'letterCheckAll');"></td>
														<td class="center"><fmt:parseNumber>${data.ROWNUM }</fmt:parseNumber></td>
														<td class="center">${data.MB_NICKNAME}</td>
														<td class="center textLimit"><a href="#" onclick="javascript:letterView('${data.RL_SEQ }'); return false;"><font color="#cc0000"><b>${data.RL_TITLE }</b></font></a></td>
														<td class="center">${data.RL_VIEW_STATE eq '1' ? '미확인' : '확인' }</td>
														<td class="center"><font face="굴림체" title="${data.RL_REG_DTTM }">${fn:split(data.RL_REG_DTTM,' ')[0]}</font></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr align="center" bgcolor="#f7f7f7" valign="top">
													<td colspan="6">쪽지가 없습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
										
										
									</tbody>
								</table>
								<p></p>
								<br>
								<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" align="center">
									<tbody>
										<tr>${resultMap.paging }</tr>
									</tbody>
								</table>
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