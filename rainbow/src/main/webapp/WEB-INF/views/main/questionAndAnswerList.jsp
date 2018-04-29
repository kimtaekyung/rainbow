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
<link rel="stylesheet" type="text/css" href="/css/main/main.css">
<link rel="stylesheet" type="text/css" href="/css/main/questionAndAnswerList.css">
<script type="text/javascript" src="/js/main/questionAndAnswerList.js"></script>
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
					<div class="cs_search_area_div">
					    <h1 class="cs_search_title_h1">고객센터</h1>
					    <div class="cs_search_input_div">
					    	<div class="cs_search_div">
					    		<input class="cs_search_input" id="cs-search-input" type="text" maxlength="20" placeholder="자주묻는 질문 검색" value="${resultMap.search_word }">
						        <span class="cs_search_span">
						        	<img class="cs_search_img"alt="" src="/images/main/search_icon.png">
						        </span>
					    	</div>
					    </div>
					</div>
					<div class="cs_navi_area_div" style="border:1ps solid black;">
						<ul class="cs_navi_area_ul">
						    <li rqt_seq="" class="typemenuTab ${empty resultMap.rqt_seq ? 'on' : ''}"><a><span class="cs-faq__menu-link-text">전체</span></a></li>
						    <c:forEach var="data" items="${resultMap.questionAndAnswerTypeList }" varStatus="i">
						    	<li rqt_seq="${data.RQT_SEQ }" class="typemenuTab ${resultMap.rqt_seq eq i.count ? 'on' : ''}"><a><span class="cs-faq__menu-link-text">${data.RQT_TYPE }</span></a></li>
						    </c:forEach>
						</ul>
					</div>
					<div class="cs_list_area_div">
						<ul class="cs_list_area_ul">
							<c:forEach var="data" items="${resultMap.questionAndAnswerList }" varStatus="i">
								<li class="cs_list_area_li" style="display: ${i.index lt 10 ? 'inline-block' : 'none'}">
									<a class="cs_list_area_a">
										<span class="cs_list_area_span">
											<img class="cs_list_area_img_q" src="/images/main/question.png">
											<span>[${data.RQT_TYPE }] ${data.RQA_QUESTION }</span>
											<img class="cs_list_area_img_a" src="/images/main/cs_down.png">
										</span>
									</a>
									
									<c:if test="${not empty data.RQA_ANSWER }">
										<div class="cs_list_area_div_answer" style="display:none;">
											<span>
												<img src="/images/main/answer.png">
												<span>${data.RQA_ANSWER }</span>
											</span>
										</div>
									</c:if>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="cs_list_more_div" style="display: ${fn:length(resultMap.questionAndAnswerList) > 10 ? 'block':'none'};"> 
						<a>더보기</a>
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>