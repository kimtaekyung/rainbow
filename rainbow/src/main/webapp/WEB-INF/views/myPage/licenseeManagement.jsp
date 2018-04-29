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
<link rel="stylesheet" type="text/css" href="/css/myPage/licenseeManagement.css">
<script type="text/javascript" src="/js/myPage/licenseeManagement.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">개인정보관리</a> &gt; <b>사업자인증신청/변경</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">사업자 인증 신청/변경</span>
							</div>
							<form name="memberBizUpdateForm" id="memberBizUpdateForm">
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td class="left">
												<p class="textLimit">설명설명<b>설명설명</b>설명설명</p>
												<p class="textLimit">설명설명설명설명설명</p>
												<p class="textLimit">설명설명설명설명설명</p>
												<p class="textLimit">설명설명설명설명설명</p>
												<p class="textLimit">ㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㅇㄴㅁㅇ</p>
												<p class="textLimit">e-money충전이란 내 e-money통장에 돈을 보관하는 것이며, e-money라는 상품을 구입하는 것이 아닙니다</p>
												<p class="textLimit">ㅇㅁㄴㅇㄴㅁㅇㅁㅇ</p>
												<p class="textLimit">e-money로 상품을 구입한 경우 카드매입전표나 현금영수증 등이 자동발급됩니다dadadasdadaadadsadadadasdasdadsadsadadasdasdasdasdasdsadsadasdasdsa (현지에서 직접 상품이 배송되는 해외거래건은 제외)</p>
											</td>
										</tr>
									</tbody>
								</table>
								<table class="common_table_normal">
									<colgroup>
										<col width="140px">
										<col width="*">
										<col width="130px">
										<col width="*">
									</colgroup>
									<tbody>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">상호명</span>
											</th>
											<td class="left">
												<input type="text" name="mb_biz_name" maxlength="20" value="${sessionScope.rb_member.MB_BIZ_NAME }">
											</td>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">사업자유형</span>
											</th>
											<td class="left">
												<select class="select_default" name="mb_biz_type">
													<option value="일반과세자" ${sessionScope.rb_member.MB_BIZ_TYPE eq '일반과세자' ? 'selected' : '' }>일반과세자</option>
													<option value="간이과세자" ${sessionScope.rb_member.MB_BIZ_TYPE eq '간이과세자' ? 'selected' : '' }>간이과세자</option>
													<option value="면세사업자" ${sessionScope.rb_member.MB_BIZ_TYPE eq '면세사업자' ? 'selected' : '' }>면세사업자</option>
													<option value="비영리기관" ${sessionScope.rb_member.MB_BIZ_TYPE eq '비영리기관' ? 'selected' : '' }>비영리기관</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">대표자명</span>
											</th>
											<td class="left">
												<input type="text" name="mb_biz_ceo_name" maxlength="30" value="${sessionScope.rb_member.MB_BIZ_CEO_NAME}">
											</td>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">사업자등록번호</span>
											</th>
											<td class="left">
												<input type="text" size="3" class="numberData" id="mb_biz_no_1" maxlength="3" value="${fn:split(sessionScope.rb_member.MB_BIZ_NO,'-')[0]}">
												
												<span class="span_default">-</span>
												<input type="text" size="2" class="numberData" id="mb_biz_no_2" maxlength="2" value="${fn:split(sessionScope.rb_member.MB_BIZ_NO,'-')[1]}">
												<span class="span_default">-</span>
												<input type="text" size="5" class="numberData" id="mb_biz_no_3" maxlength="5" value="${fn:split(sessionScope.rb_member.MB_BIZ_NO,'-')[2]}">
												<input type="hidden" name="mb_biz_no">
											</td>
										</tr>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">업태</span>
											</th>
											<td>
												<input type="text" size="20" name="mb_biz_condition" maxlength="20" value="${sessionScope.rb_member.MB_BIZ_CONDITION}">
												<p class="desc">업태가 다수인 경우, 주요업태만 선별작성</p>
											</td>
											<th><img class="must" src="/images/auth/ico_must.gif"><span class="span_default">업종</span>
											</th>
											<td>
												<input type="text" name="mb_biz_category" maxlength="100" value="${sessionScope.rb_member.MB_BIZ_CATEGORY}">
											</td>
										</tr>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">사업자주소</span>
											</th>
											<td class="left" colspan="3">
												<input readonly="readonly" type="text" name="mb_biz_zip_code" maxlength="10" size="10" value="${sessionScope.rb_member.MB_BIZ_ZIP_CODE}">
												<button type="button" class="button_default" onclick="goAddrPopup('bizAddress');">우편번호검색</button>
												<input readonly="readonly" type="text" name="mb_biz_address" maxlength="70" size="70" value="${sessionScope.rb_member.MB_BIZ_ADDRESS}">
												<input type="text" name="mb_biz_address_detail" maxlength="70" size="70" value="${sessionScope.rb_member.MB_BIZ_ADDRESS_DETAIL}">
											</td>
										</tr>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">사업장전화</span>
											</th>
											<td colspan="3">
												<select id="bizTelno1" class="select_default">
													<option value="02" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 02 ? 'selected' : ''}>02</option>
													<option value="031" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 031 ? 'selected' : ''}>031</option>
													<option value="032" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 032 ? 'selected' : ''}>032</option>
													<option value="033" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 033 ? 'selected' : ''}>033</option>
													<option value="041" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 041 ? 'selected' : ''}>041</option>
													<option value="042" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 042 ? 'selected' : ''}>042</option>
													<option value="043" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 043 ? 'selected' : ''}>043</option>
													<option value="051" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 051 ? 'selected' : ''}>051</option>
													<option value="052" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 052 ? 'selected' : ''}>052</option>
													<option value="053" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 053 ? 'selected' : ''}>053</option>
													<option value="054" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 054 ? 'selected' : ''}>054</option>
													<option value="055" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 055 ? 'selected' : ''}>055</option>
													<option value="061" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 061 ? 'selected' : ''}>061</option>
													<option value="062" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 062 ? 'selected' : ''}>062</option>
													<option value="063" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 063 ? 'selected' : ''}>063</option>
													<option value="064" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 064 ? 'selected' : ''}>064</option>
													<option value="070" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq 070 ? 'selected' : ''}>070</option>
												</select><span class="span_default">-</span> 
												<input class="numberData" maxlength="4" type="text" id="bizTelno2" value="${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[1]}">
												<span class="span_default">-</span>  
												<input class="numberData" maxlength="4" type="text" id="bizTelno3" value="${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[2]}">
												<input type="hidden" name="mb_biz_tel">
											</td>
										</tr>
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">사업자등록증사본</span>
											</th>
											<td colspan="3">
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="mb_biz_img_path"  view="mb_biz_img_path_view" path="mb_biz_img_path_path"/>
												</div>
												<span id="mb_biz_img_path_path" class="fileuploadurl">${sessionScope.rb_member.MB_BIZ_IMG_PATH }</span>
												<div class="file_upload_view_div">
													<img  class="uploadImage" id="mb_biz_img_path_view" src="${sessionScope.rb_member.MB_BIZ_IMG_PATH }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
												</div>
												<p class="desc">사업자등록증 사본을 첨부할 수 없는 경우에는 신청 후에 FAX로 전송해주세요.<br> FAX전송시에는 사업자등록증 사본 상단에 반드시 개인정회원ID를 기재하여 주세요.</p>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="submit_button_area">
									<button type="button" class="button_submit" onclick="memberBizInfoUpdate();">${sessionScope.rb_member.MB_BIZ_CERT_STATE eq '0' ? '신청하기' : '변경하기' }</button>
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