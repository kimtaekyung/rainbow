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
<link rel="stylesheet" type="text/css" href="/css/myPage/memberSetting.css">
<script type="text/javascript" src="/js/myPage/memberSetting.js"></script>
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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">개인정보관리</a> &gt; <b>개인환경설정</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">개인 환경 설정</span>
							</div>
							<c:choose>
								<c:when test="${sessionScope.rb_member.MB_TYPE eq '1'}">
									<!--폼 시작-->
									<form id="memberSerringUpdateForm">
										<input type="hidden" name="confNoticeEnable" value="1">
										<table class="common_table_normal">
											<colgroup>
												<col align="center" valign="top" bgcolor="#dcdddf" width="150px" style="white-space: nowrap">
												<col align="center" valign="top" bgcolor="#f7f7f7" style="word-break: break-all; padding: 0;">
												<col align="center" valign="top" bgcolor="#f7f7f7" style="word-break: break-all; padding: 0;">
											</colgroup>
											<tbody>
												<tr>
													<th>상품결제안내</th>
													<td class="center"><input type="checkbox" name="use_payment_email" value="1" ${memberSetting.USE_PAYMENT_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_payment_mms" value="1" ${memberSetting.USE_PAYMENT_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>

												<tr>
													<th>배송시작안내</th>
													<td class="center"><input type="checkbox" name="use_delivery_start_email" value="1" ${memberSetting.USE_DELIVERY_START_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_delivery_start_mms" value="1" ${memberSetting.USE_DELIVERY_START_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>

												<tr>
													<th>판매자취소안내</th>
													<td class="center"><input type="checkbox" name="use_seller_cancel_email" value="1" ${memberSetting.USE_SELLER_CANCEL_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_seller_cancel_mms" value="1" ${memberSetting.USE_SELLER_CANCEL_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>

												<tr>
													<th>결제취소안내</th>
													<td class="center"><input type="checkbox" name="use_self_cancel_email" value="1" ${memberSetting.USE_SELF_CANCEL_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_self_cancel_mms" value="1" ${memberSetting.USE_SELF_CANCEL_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>
												
												<tr>
													<th>반품승인안내</th>
													<td class="center"><input type="checkbox" name="use_return_approve_email" value="1" ${memberSetting.USE_RETURN_APPROVE_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_return_approve_mms" value="1" ${memberSetting.USE_RETURN_APPROVE_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>

												<tr>
													<th>교환승인안내</th>
													<td class="center"><input type="checkbox" name="use_exchange_approve_email" value="1" ${memberSetting.USE_EXCHANGE_APPROVE_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_exchange_approve_mms" value="1" ${memberSetting.USE_EXCHANGE_APPROVE_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>

												<tr>
													<th>반품완료안내</th>
													<td class="center"><input type="checkbox" name="use_return_success_email" value="1" ${memberSetting.USE_RETURN_SUCCESS_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_return_success_mms" value="1" ${memberSetting.USE_RETURN_SUCCESS_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>

												<tr>
													<th>교환완료안내</th>
													<td class="center"><input type="checkbox" name="use_exchange_success_email" value="1" ${memberSetting.USE_EXCHANGE_SUCCESS_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_exchange_success_mms" value="1" ${memberSetting.USE_EXCHANGE_SUCCESS_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>
											</tbody>
										</table>
									</form>
								</c:when>
								<c:otherwise>
									<!--폼 시작-->
									<form id="memberSerringUpdateForm">
										<table class="common_table_normal">
											<tbody>
												<tr>
													<th>판매자 연락처 안내</th>
													<td colspan="2">
														<p><input type="checkbox" name="use_tel" value="1" ${memberSetting.USE_TEL eq '1' ? 'checked' : ''}>자택전화번호(${not empty sessionScope.rb_member.MB_TEL ? sessionScope.rb_member.MB_TEL : '등록된 전화번호가 없습니다.' })</p>
														<p><input type="checkbox" name="use_hp" value="1" ${memberSetting.USE_HP eq '1' ? 'checked' : ''}>휴대전화번호(${not empty sessionScope.rb_member.MB_HP ? sessionScope.rb_member.MB_HP : '등록된 휴대전화가 없습니다.' })</p>
														<p><input type="checkbox" name="use_biz_tel" value="1" ${memberSetting.USE_BIZ_TEL eq '1' ? 'checked' : ''}>업체전화번호(${not empty sessionScope.rb_member.MB_BIZ_TEL ? sessionScope.rb_member.MB_BIZ_TEL : '등록된 사업장전화가 없습니다.' })</p>
													</td>
												</tr>
												<tr>
													<th>기본 택배사 선택</th>
													<td colspan="2">
														<select class="select_default" name="default_delivery_company">
															<option value="noselected" ${(memberSetting.DEFAULT_DELIVERY_COMPANY eq 'noselected') or (empty memberSetting.DEFAULT_DELIVERY_COMPANY) ? 'selected' : ''}>선택안함</option>
															<option value="DAEHAN" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'DAEHAN' ? 'selected' : ''}>CJ대한통운</option>
															<option value="GTXLOGIS" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'GTXLOGIS' ? 'selected' : ''}>GTX로지스</option>
															<option value="KGB" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'KGB' ? 'selected' : ''}>KGB택배</option>
															<option value="KGLOGIS" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'KGLOGIS' ? 'selected' : ''}>KG로지스</option>
															<option value="KUNYOUNG" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'KUNYOUNG' ? 'selected' : ''}>건영택배</option>
															<option value="KYUNGDONG" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'KYUNGDONG' ? 'selected' : ''}>경동택배</option>
															<option value="GOODSTOLUCK" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'GOODSTOLUCK' ? 'selected' : ''}>굿투럭</option>
															<option value="DADREAM" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'DADREAM' ? 'selected' : ''}>다드림택배</option>
															<option value="DAESIN" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'DAESIN' ? 'selected' : ''}>대신택배</option>
															<option value="KGBL" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'KGBL' ? 'selected' : ''}>로젠택배</option>
															<option value="HYUNDAI" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'HYUNDAI' ? 'selected' : ''}>롯데택배(구 현대택배)</option>
															<option value="YELLOWCAP" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'YELLOWCAP' ? 'selected' : ''}>옐로우캡</option>
															<option value="EPOST" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'EPOST' ? 'selected' : ''}>우체국택배</option>
															<option value="ILYANG" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'ILYANG' ? 'selected' : ''}>일양택배</option>
															<option value="CHUNIL" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'CHUNIL' ? 'selected' : ''}>천일택배</option>
															<option value="CVSNET" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'CVSNET' ? 'selected' : ''}>편의점택배</option>
															<option value="HANSEO" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'HANSEO' ? 'selected' : ''}>한서호남택배</option>
															<option value="HPL" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'HPL' ? 'selected' : ''}>한의사랑택배</option>
															<option value="HANJIN2" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'HANJIN2' ? 'selected' : ''}>한진정기화물</option>
															<option value="HANJIN" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'HANJIN' ? 'selected' : ''}>한진택배</option>
															<option value="HDEXP" ${memberSetting.DEFAULT_DELIVERY_COMPANY eq 'HDEXP' ? 'selected' : ''}>합동택배</option>
														</select>&nbsp;
														<font color="gray">상품 배송 시 선택된 택배사를 기본으로 선택하도록합니다</font>
													</td>
												</tr>
												<tr>
													<th>입금완료안내</th>
													<td class="center"><input type="checkbox" name="use_deposit_success_email" value="1" ${memberSetting.USE_DEPOSIT_SUCCESS_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_deposit_success_mms" value="1" ${memberSetting.USE_DEPOSIT_SUCCESS_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>
												<tr>
													<th>결제취소안내</th>
													<td class="center"><input type="checkbox" name="use_buyer_cancel_email" value="1" ${memberSetting.USE_BUYER_CANCEL_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_buyer_cancel_mms" value="1" ${memberSetting.USE_BUYER_CANCEL_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>
												<tr>
													<th>반품요청안내</th>
													<td class="center"><input type="checkbox" name="use_return_request_email" value="1" ${memberSetting.USE_RETURN_REQUEST_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_return_request_mms" value="1" ${memberSetting.USE_RETURN_REQUEST_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>
												<tr>
													<th>교환요청안내</th>
													<td class="center"><input type="checkbox" name="use_exchange_request_email" value="1" ${memberSetting.USE_EXCHANGE_REQUEST_EMAIL eq '1' ? 'checked' : ''}> 이메일</td>
													<td class="center"><input type="checkbox" name="use_exchange_request_mms" value="1" ${memberSetting.USE_EXCHANGE_REQUEST_MMS eq '1' ? 'checked' : ''}> 쪽지</td>
												</tr>
											</tbody>
										</table>
									</form>
								</c:otherwise>
							</c:choose>
							<div class="submit_button_area">
								<button type="button" class="button_submit" onclick="memberSettingInfoUpdate();">변경 하기</button>
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