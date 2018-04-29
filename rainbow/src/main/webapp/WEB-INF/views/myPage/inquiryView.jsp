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
<link rel="stylesheet" type="text/css" href="/css/myPage/letterView.css">
<script type="text/javascript" src="/js/myPage/letterView.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <b>상담글 보기</b>
						</div>
						<div id="v5ContentsWrap">
							<table class="common_table_normal">
								<colgroup>
									<col width="100">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>상담분류</th>
										<td class="textLimit"><span class="span_default">${resultMap.inquiry.RIT_NAME } - ${resultMap.inquiry.RIT_DESC }</span></td>
									</tr>
									<tr>
										<th>상담글제목</th>
										<td class="textLimit">
											<span class="span_default">${resultMap.inquiry.RI_SUBJECT }</span>
										</td>
									</tr>
									<tr>
										<th>등록시간</th>
										<td class="textLimit"><span class="span_default">${resultMap.inquiry.RI_REG_DTTM }</span></td>
									</tr>
								</tbody>
							</table>
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>${resultMap.inquiry.RI_CONTENT}</td>
									</tr>
									<c:if test="${not empty resultMap.inquiry.RI_ATTACH_IMG_PATH_1}">
										<tr>
											<td>
												<div class="file_upload_view_div">
													<img class="uploadImage"  src="${resultMap.inquiry.RI_ATTACH_IMG_PATH_1}" alt="등록된 이미지가 없습니다.">
												</div>
											</td>
										</tr>
									</c:if>
									<c:if test="${not empty resultMap.inquiry.RI_ATTACH_IMG_PATH_2}">
										<tr>
											<td>
												<div class="file_upload_view_div">
													<img class="uploadImage"  src="${resultMap.inquiry.RI_ATTACH_IMG_PATH_2}" alt="등록된 이미지가 없습니다.">
												</div>
											</td>
										</tr>
									</c:if>
									<c:if test="${not empty resultMap.inquiry.RI_ATTACH_IMG_PATH_3}">
										<td>
											<div class="file_upload_view_div">
												<img class="uploadImage"  src="${resultMap.inquiry.RI_ATTACH_IMG_PATH_3}" alt="등록된 이미지가 없습니다.">
											</div>
										</td>
									</c:if>
									<c:if test="${not empty resultMap.inquiry.RI_ATTACH_IMG_PATH_4}">
										<tr>
											<td>
												<div class="file_upload_view_div">
													<img class="uploadImage"  src="${resultMap.inquiry.RI_ATTACH_IMG_PATH_4}" alt="등록된 이미지가 없습니다.">
												</div>
											</td>
										</tr>
									</c:if>
									<c:if test="${not empty resultMap.inquiry.RI_ATTACH_IMG_PATH_5}">
										<tr>
											<td>
												<div class="file_upload_view_div">
													<img class="uploadImage"  src="${resultMap.inquiry.RI_ATTACH_IMG_PATH_5}" alt="등록된 이미지가 없습니다.">
												</div>
											</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<c:if test="${resultMap.inquiry.RI_IS_ANSWER eq '1'}">
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td class="right"><span class="span_default">${resultMap.inquiry.RI_ANSWER_DTTM }</span></td>
										</tr>
										<tr>
											<th class="left verticalMiddleParent">
												<img class="verticalMiddleChild" src="/images/myPage/ico_supportDone.png"> ${resultMap.inquiry.MB_NAME }
											</th>
										</tr>
										<tr>
											<td>${resultMap.inquiry.RI_ANSWER }</td>
										</tr>
									</tbody>
								</table>
							</c:if>
							
							<div class="submit_button_area">
								<button type="button" class="button_default" onclick="location.href='/myPage/inquiryList.do'">목록으로</button>
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