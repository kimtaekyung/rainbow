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
<link rel="stylesheet" type="text/css" href="/css/myPage/inquiryView.css">
<script type="text/javascript" src="/js/myPage/inquiryView.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <b>쪽지 보기</b>
						</div>
						<c:if test="${empty resultMap.letter }">
							<script type="text/javascript">
								alert("잘못된 요청입니다.");
								location.href="/myPage/letterList.do";
							</script>
						</c:if>
						
						<div id="v5ContentsWrap">
							<table class="common_table_normal">
								<colgroup>
									<col width="100">
									<col width="*">
									
								</colgroup>
								<tbody>
									<tr>
										<th>쪽지 제목</th>
										<td class="left textLimit"><span class="span_default">${resultMap.letter.RL_TITLE }</span></td>
									</tr>
									<tr>
										<th>관리자</th>
										<td class="left textLimit"><span class="span_default">${resultMap.letter.WRITER_NAME }</span></td>
									</tr>
									<tr>
										<th>등록시간</th>
										<td class="left textLimit"><span class="span_default">${resultMap.letter.RL_REG_DTTM }</span></td>
									</tr>
								</tbody>
							</table>
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>${resultMap.letter.RL_CONTENT}</td>
									</tr>
								</tbody>
							</table>
							<div class="submit_button_area">
								<button type="button" class="button_default" onclick="goLetterList();">목록으로</button>
								<form id="letterListForm" action="/myPage/letterList.do">
									<input name="sch_sdate" type="hidden" value="${resultMap.sch_sdate}">
									<input name="sch_edate" type="hidden" value="${resultMap.sch_edate}">
									<input name="search_word" type="hidden" value="${resultMap.search_word}">
									<input name="search_type" type="hidden" value="${resultMap.search_type}">
									<input name="rl_view_state" type="hidden" value="${resultMap.rl_view_state}">
									<input name="page" type="hidden" value="${resultMap.page}">
									<input name="pageSize" type="hidden" value="${resultMap.pageSize}">
									<input name="quick" type="hidden" value="${resultMap.quick}">
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