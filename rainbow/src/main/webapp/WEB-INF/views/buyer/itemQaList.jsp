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
<link rel="stylesheet" type="text/css" href="/css/seller/itemQaList.css">

<script type="text/javascript" src="/js/buyer/itemQaList.js"></script>

</head>
	<body>
	
		<c:set var="qaList" value="${resultDataMap.qaList }"/>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					
					<!-- 판매관리 메뉴 -->
					<%@include file="/WEB-INF/views/buyer/buyMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/buyer/buyMain.do">구매관리</a> &gt; <a href="/buyer/buyMain.do">상품문의관리</a> &gt; <b>상품문의목록</b>
						</div>
						
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">상품 문의 목록</span>
							</div>
							<!-- 검색 -->
							<form id="schFrm" name="schFrm" method="get" action="/buyer/itemQaList.do">
								<input type="hidden" name="page" id="page" value="${resultDataMap.page }"/>
								<input type="hidden" name="pageSize" id="pageSize" value="${resultDataMap.pageSize }"/>
								
							<table class="common_table_normal" id="searchTbl">
								<tbody>
									<tr>
										<th>등록일</th>
										<td colspan="5">
											<select class="select_default" name="quick" style="width: 110px;" onchange="javascript:changeQuickDate(this.value,'schFrm','sch_sdate','sch_edate');">
												<option value="">빠른선택</option>
												<option value="day" ${resultDataMap.quick eq 'day' ? 'selected':'' }>오늘</option>
												<option value="week" ${resultDataMap.quick eq 'week' ? 'selected':'' }>1주일</option>
												<option value="month" ${resultDataMap.quick eq 'month' ? 'selected':'' }>1개월</option>
												<option value="threeMonth" ${resultDataMap.quick eq 'threeMonth' ? 'selected':'' }>3개월</option>
												<option value="sixMonth" ${resultDataMap.quick eq 'sixMonth' ? 'selected':'' }>6개월</option>
												<option value="year" ${resultDataMap.quick eq 'year' ? 'selected':'' }>1년</option>
											</select>
											<input type="text" name="sch_sdate" value="${resultDataMap.sch_sdate }" class="datepicker" style="width:85px;"/>
											<span class="span_default"> ~ </span>
											<input type="text" name="sch_edate" value="${resultDataMap.sch_edate }" class="datepicker" style="width:85px;"/>
										</td>
									</tr>
									<tr>
										<th>답변상태</th>
										<td>
											<select class="select_default" name="is_answer" style="width: 110px;">
												<option value="">전체</option>
												<option value="0" ${resultDataMap.is_answer eq '0'?'selected':'' }>답변대기</option>
												<option value="1" ${resultDataMap.is_answer eq '1'?'selected':'' }>답변완료</option>
											</select>
										</td>
										<th>검색어</th>
										<td colspan="3">
											<select class="select_default" name="search_type" style="width: 110px;">
												<option value="TITLE" ${resultDataMap.search_type eq 'TITLE'?'selected':'' }>제목</option>
												<option value="NICKNAME" ${resultDataMap.search_type eq 'NICKNAME'?'selected':'' }>작성자</option>
												<option value="ITEM_SEQ" ${resultDataMap.search_type eq 'ITEM_SEQ'?'selected':'' }>상품번호</option>
											</select>
											<input type="text" name="search_word" value="${resultDataMap.search_word }"/>
											<button class="button_default" type="button" onclick="searchFormSubmit('schFrm');" >찾기</button>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
							
							<div id="lSupportItem">
							
								<!-- 리스트시작 -->
								<div id="lSupportTotalCnt">
									총 <b><fmt:formatNumber value="${resultDataMap.total }"/> </b> 건의 문의글이 있습니다
								</div>
								<div id="lSupportTop">
									<table>
										<tbody>
											<tr>
												<td style="width:54px;">글번호</td>
												<td style="width:75px;text-align:center;">답변상태</td>
												<td style="width:457px;text-align:center;">상품정보/제목</td>
												<td style="width:100px;">작성자</td>
												<td style="width:40px;">등록일</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- 리스트 -->
								<ul id="lSupportUlist">
								
						<c:choose>
							<c:when test="${empty qaList }">
								<div style="text-align:center; margin-top:40px;">조회된 문의글이 없습니다</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="data" items="${qaList }">
									<li class="lSupportList">
										<div class="lSupportListWrap">
											<div class="lSupportNo">${data.IQA_SEQ }</div>
											<div class="lSupportStatus" style="color: ${data.IQA_IS_ANSWER eq '0' ? '#e72d2d':'#2dc1e7'}">${data.IQA_IS_ANSWER eq '0' ? '답변대기':'답변완료' }</div>
											<div class="lSupportGroup">
												<div class="lSupportImg">
													<img src="${data.ITEM_REPRESENT_IMAGE }" width="35" height="35">
												</div>
												<div class="lSupportTitle">
													<a href="/item/itemView.do?item_seq=${data.ITEM_SEQ }">${data.ITEM_NAME }</a>
												</div>
												<div class="lSupportMemo" onclick="viewAnswer(this, '${data.IQA_SEQ}');">${data.IQA_SUBJECT }</div>
												<c:if test="${data.IQA_OPEN eq '1' }">
													<img src="/images/item/view/locked_lite.png" width="9px" height="12px" style="margin-top:2px;vertical-align:top;">
												</c:if>
											</div>
											<div class="lSupportId">${data.MB_NICKNAME }</div>
											<div class="lSupportDate" style="color: #1B1B1B">${data.IQA_REG_DT }</div>
										</div>
										<!-- 답변영역 -->
										<div class="lSupportDetailWrap" style="display: none;">
											<div class="lSupportQAwrap">
												<div class="lSupportQuesWrap">
													<div class="lSupportQAimg">
														<img src="/images/item/view/ico_question.png">
													</div>
													<div class="lSupportQues">
														<div class="lSupportBId">
															<b>${data.MB_NICKNAME }</b>&nbsp;(${data.IQA_REG_DTTM })
														</div>
														<div class="lSupportBmemo">
															${data.IQA_CONTENT }
															<c:if test="${not empty data.IQA_IMAGE }"><br/><br/><img src="${data.IQA_IMAGE }" width="600"/></c:if>
														</div>
													</div>
												</div>
											<c:if test="${data.IQA_IS_ANSWER eq '1' }">
												<div class="lSupportAnswer">
													<div class="lSupportQAimg">
														<img src="/images/item/view/ico_answer.png" width="13px" height="13px">
													</div>
													<div class="lSupportAnswerWrap">
														<div class="lSupportBId">
															<b>${data.SELLER_NICKNAME }</b>&nbsp;(${data.IQA_ANSWER_DTTM })
														</div>
														<div class="lSupportBmemo2">${data.IQA_ANSWER }</div>
													</div>
												</div>
											</c:if>
											</div>
											<div class="lSupportAddWrap">
												<form name="qaContentFrm" id="lAddSupportWriteFrm" method="post" action="" enctype="multipart/form-data">
													<input type="hidden" name="iqa_seq" value="${data.IQA_SEQ }">
													<input type="hidden" name="content_type" value="0">
													<input type="hidden" name="content_order" value="">
												
												<div class="lSupportAddArea">
													<textarea id="lSupportAddTextarea" name="content"></textarea>
													<!-- <div class="lSupportchecks">
														<input type="checkbox" name="secret" value="1"><label for="checklabel">비밀글로 지정</label>
													</div> -->
													<input type="button" onclick="insertShopItemQaContent(this, '${data.IQA_SEQ}');" id="lSupportSubmitBtn" value="답변등록">
												</div>
												<div class="lSupportAddFileWrap">
													<img src="/images/item/view/ico_camera.png" width="12px" height="10px">
													<div class="lSupportImgAttach">이미지첨부</div>
													<div id="lSupportFileAdd" class="addImage">
														<input type="file" name="attach_image" id="attachFile" value="">
														<!-- <input type="button" value="+이미지추가" id="lSupportImageAdd"> -->
													</div>
												</div>
												<div class="lSupportAddCaution">· 열람가능하며, 모든 이미지는 관리자가 검토하니 주의해주세요.</div>
												
												</form>
											</div>
										</div>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
		
								</ul>
							</div>
							
							<table class="common_table_normal">
								<tbody>
									<tr>${resultDataMap.paging }</tr>
								</tbody>
							</table>
						
						</div>
					</div>
				</div>
			</div>
	
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>