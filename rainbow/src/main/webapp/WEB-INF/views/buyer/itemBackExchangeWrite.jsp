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
<link rel="stylesheet" type="text/css" href="/css/myPage/inquiryWrite.css">

<script type="text/javascript" src="/js/buyer/itemBackExchangeWrite.js"></script>

</head>
	<body>
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					
					<!-- 구매관리메뉴 -->
					<%@include file="/WEB-INF/views/buyer/buyMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main/">HOME</a> &gt; <a href="/buyer/buyMain.do">구매관리</a> &gt; 상품구매관리 &gt; 구매목록 &gt; <b>반품/교환요청 쓰기</b>
						</div>
						<div id="v5ContentsWrap">
						
							<form id="insertInquiryForm" name="regFrm" onsubmit="return false;">
								<input type="hidden" name="info_seq" value="${resultDataMap.info.INFO_SEQ }"/>
								<input type="hidden" name="order_seq" value="${resultDataMap.info.ORDER_SEQ }"/>
								<input type="hidden" name="order_no" value="${resultDataMap.info.ORDER_NO }"/>
							
								<table class="common_table_normal">
									<colgroup>
										<col width="100">
										<col width="632">
									</colgroup>
									<tbody>
										<tr>
											<th>주문번호</th>
											<td><span class="span_default">${resultDataMap.info.ORDER_NO }</span></td>
										</tr>
										<tr>
											<th>주문명</th>
											<td><span class="span_default">${resultDataMap.info.ORDER_NAME }</span></td>
										</tr>
										<tr>
											<th>현재주문상태</th>
											<td><span class="span_default">${resultDataMap.info.ORDER_STATE_NAME }</span></td>
										</tr>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">요청분류</span></th>
											<td>
												<select class="select_default" name="be_type">
													<option value="">선택</option>
													<option value="1">반품요청</option>
													<option value="2">교환요청</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">요청제목</span></th>
											<td>
												<input type="text" class="input" name="be_subject" maxlength="100" style="width:610px;">
											</td>
										</tr>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">요청내용</span></th>
											<td>
												<textarea name="be_content" style="width: 610px; height: 300px; word-break:break-all;"></textarea>
											</td>
										</tr>
										<tr>
											<th>파일첨부1</th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="be_attach_img_path_1"  view="be_attach_img_path_1_view" path="be_attach_img_path_1_path"/>
												</div>
												<span id="be_attach_img_path_1_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="be_attach_img_path_1_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
										<tr>
											<th>파일첨부2</th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="be_attach_img_path_2"  view="be_attach_img_path_2_view" path="be_attach_img_path_2_path"/>
												</div>
												<span id="be_attach_img_path_2_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="be_attach_img_path_2_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
								
							<div class="submit_button_area">
								<button class="button_submit" type="button" title="목록보기" onclick="javascript:location.href='/buyer/buyList.do'">목록보기</button>
								<button class="button_submit" type="button" title="요청등록" onclick="insertItemBackExchange();">요청등록</button>
							</div>
							
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