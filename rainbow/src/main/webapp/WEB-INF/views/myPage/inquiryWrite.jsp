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
<link rel="stylesheet" type="text/css" href="/css/myPage/inquiryWrite.css">
<script type="text/javascript" src="/js/myPage/inquiryWrite.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">1:1상담</a> &gt; <b>상담글쓰기</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">1:1 상담 글 쓰기</span>
							</div>
							<img src="http://via.placeholder.com/770x120" width="770" height="120" alt="무엇이든 물어보세요" title="무엇이든 물어보세요">
							<form id="insertInquiryForm">
								<table class="common_table_normal">
									<colgroup>
										<col width="120">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">상담분류</span></th>
											<td class="center">
												<select name="rit_seq" class="select_default" style="width: 626px;">
													<c:if test="${not empty  resultMap.inquiryTypeList}">
														<c:forEach var="data" items="${resultMap.inquiryTypeList}">
															<option value="${data.RIT_SEQ }">${data.RIT_NAME }--- ${data.RIT_DESC }</option>													
														</c:forEach>
													</c:if>
												</select>
											</td>
										</tr>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">상담글 제목</span></th>
											<td class="center">
												<input type="text" name="ri_subject" maxlength="50" style="width: 600px">
											</td>
										</tr>
										<tr>
											<th><img src="/images/auth/ico_must.gif"><span class="span_default">상담 내용</span></th>
											<td class="center">
												<div id="formTextarea">
													<textarea name="ri_content" style="width: 600px; height: 400px;"></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="span_default">파일 첨부1</span></th>
											<td>
													
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="ri_attach_img_path_1"  view="ri_attach_img_path_1_view" path="ri_attach_img_path_1_path"/>
												</div>
												<span id="ri_attach_img_path_1_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="ri_attach_img_path_1_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="span_default">파일 첨부2</span></th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="ri_attach_img_path_2"  view="ri_attach_img_path_2_view" path="ri_attach_img_path_2_path"/>
												</div>
												<span id="ri_attach_img_path_2_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="ri_attach_img_path_2_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="span_default">파일 첨부3</span></th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="ri_attach_img_path_3"  view="ri_attach_img_path_3_view" path="ri_attach_img_path_3_path"/>
												</div>
												<span id="ri_attach_img_path_3_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="ri_attach_img_path_3_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="span_default">파일 첨부4</span></th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="ri_attach_img_path_4"  view="ri_attach_img_path_4_view" path="ri_attach_img_path_4_path"/>
												</div>
												<span id="ri_attach_img_path_4_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="ri_attach_img_path_4_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
										<tr>
											<th><span class="span_default">파일 첨부5</span></th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="ri_attach_img_path_5"  view="ri_attach_img_path_5_view" path="ri_attach_img_path_5_path"/>
												</div>
												<span id="ri_attach_img_path_5_path" class="fileuploadurl"></span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="ri_attach_img_path_5_view" src="" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="submit_button_area">
									<button type="button" class="button_submit" onclick="insertInquiry();">등록하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>