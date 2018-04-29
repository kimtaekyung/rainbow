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
<link rel="stylesheet" type="text/css" href="/css/myPage/memberInfoUpdate.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/myPage/memberInfoUpdate.js"></script>
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
						<form id="memberUpdateForm">
							<input type="hidden" name="mb_type" value = "${sessionScope.rb_member.MB_TYPE }">
							<input type="hidden" name="mb_id" value="${sessionScope.rb_member.MB_ID }">
							<input type="hidden" name="mb_password">
							<input type="hidden" name="new_mb_password">
							<input type="hidden" name="new_mb_password_confirm">
							<div class="v6Location">
								현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/myPage/myPageMain.do">마이페이지</a> &gt; <a href="/myPage/myPageMain.do">개인정보관리</a> &gt; <b>회원정보수정</b>
							</div>
							<div id="v5ContentsWrap">
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">회원 정보 입력</span>
								</div>
								<table id="tblMemInfo" class="common_table_normal">
									<colgroup>
										<col width="150px">
										<col width="230px">
										<col width="150px">
										<col width="*">
									</colgroup>
									<!--회원아이디-->
									<tbody>
										<tr>
											<th>
												<span class="span_default">회원아이디</span>
											</th>
											<td colspan="3"><span class="span_default"><b>${sessionScope.rb_member.MB_ID }</b></span></td>
										</tr>
										<!--비밀번호-->
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">기존 비밀번호</span>
											</th>
											<td colspan="3"> 
												<input type="password" id="mb_password_tmp" maxlength="20">
											</td>
										</tr>
										<!--새로운 비밀번호 입력시, 추가확인 140627 신동주-->
										<tr>
											<th>
												<span class="span_default">새 비밀번호</span>
											</th>
											<td colspan="3">
												<input type="password" id="new_mb_password_tmp" maxlength="20">
											</td>
										</tr>
		
										<tr>
											<th>
												<span class="span_default">새 비밀번호확인</span>
											</th>
											<td colspan="3">
												<input type="password" id="new_mb_password_confirm_tmp" maxlength="20">
											</td>
										</tr>
		
										<!-- 회원 닉네임 -->
										<tr>
											<th>
												<img class="must" src="/images/auth/ico_must.gif"><span class="span_default">닉네임</span>
											</th>
											<td colspan="3">
												<input type="text" name="mb_nickname" maxlength="20" value="${sessionScope.rb_member.MB_NICKNAME }">
												<p class="desc">
													닉네임은 1~20자 한글, 영문, 숫자 입력 가능 합니다.
												</p>
											</td>
										</tr>
		
		
										<!--회원이름 -->
										<tr>
											<th><span class="span_default">회원이름</span></th>
											<td><span class="span_default"><b>${sessionScope.rb_member.MB_NAME }</b></span></td>
											<th><span class="span_default">생년월일</span></th>
											<td><span class="span_default"><b>${fn:substring(sessionScope.rb_member.MB_BIRTHDAY, 0, 4)}-${fn:substring(sessionScope.rb_member.MB_BIRTHDAY, 4, 6)}-${fn:substring(sessionScope.rb_member.MB_BIRTHDAY, 6, 8)}</b></span></td>
										</tr>
		
										<!--이메일주소-->
										<tr>
											<th><img class="must" src="/images/auth/ico_must.gif"><span class="span_default">이메일주소</span></th>
											<td colspan="3">
												<input type="text" id="mail1" maxlength="40" value="${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[0]}">
												<span><font face="arial">@</font></span>
												<input type="text" id="mail2" maxlength="40" value="${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1]}">
												<select class="select_default" onchange="javascript:setMailForm(this);">
													<option value="" selected>직접입력</option>
													<option value="naver.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'naver.com' ? 'selected' : ''}>네이버</option>
													<option value="gmail.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'gmail.com' ? 'selected' : ''}>구글메일</option>
													<option value="hanmail.net" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'hanmail.net' ? 'selected' : ''}>한메일</option>
													<option value="hotmail.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'hotmail.com' ? 'selected' : ''}>핫메일</option>
													<option value="chollian.net" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'chollian.net' ? 'selected' : ''}>천리안</option>
													<option value="hitel.net" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'hitel.net' ? 'selected' : ''}>하이텔</option>
													<option value="dreamwiz.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'dreamwiz.com' ? 'selected' : ''}>드림위즈</option>
													<option value="yahoo.co.kr" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'yahoo.co.kr' ? 'selected' : ''}>야후</option>
													<option value="lycos.co.kr" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'lycos.co.kr' ? 'selected' : ''}>라이코스</option>
													<option value="netian.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'netian.com' ? 'selected' : ''}>네띠앙</option>
													<option value="korea.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'korea.com' ? 'selected' : ''}>코리아닷컴</option>
													<option value="orgio.net" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'orgio.net' ? 'selected' : ''}>오르지오</option>
													<option value="empal.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'empal.com' ? 'selected' : ''}>엠파스(엠팔)</option>
													<option value="hanafos.com" ${fn:split(sessionScope.rb_member.MB_EMAIL,'@')[1] eq 'hanafos.com' ? 'selected' : ''}>하나포스</option>
												</select>
												<input type="hidden" name="mb_email">
											</td>
										</tr>
										<!--메일진수신-->
										<tr>
											<th><img class="must" src="/images/auth/ico_must.gif"><span class="span_default">메일진수신여부</span></th>
											<td colspan="3">
												<input type="checkbox" name="mb_event_receive" value="1" ${sessionScope.rb_member.MB_EVENT_RECEIVE eq '1' ? 'checked' : ''}><span class="span_default">알샵 상품과 이벤트 등의 쇼핑관련 메일을 수신합니다</span>
												<p class="desc">이메일 수신거부와 상관없이 구매 정보, 서비스 주요정책 관련 메세지 등은 발송됩니다</p>
											</td>
										</tr>
		
										<!--자택주소-->
										<tr>
											<th>
												<span class="span_default">주소</span>
											</th>
											<td colspan="3">
												<input readonly="readonly" type="text" name="mb_zip_code" maxlength="10" size="10" value="${sessionScope.rb_member.MB_ZIP_CODE }" maxlength="10">
												<button class="button_default" type="button" onclick="goAddrPopup('mbAddress');">우편번호찾기</button>
												<input readonly="readonly" type="text" name="mb_address" maxlength="70" size="70" value="${sessionScope.rb_member.MB_ADDRESS }" style="width: 400px">
												<input type="text" name="mb_address_detail" maxlength="70" size="70" value="${sessionScope.rb_member.MB_ADDRESS_DETAIL }" style="width: 400px">
											</td>
										</tr>
										<!--자택전화-->
										<tr>
											<th><span>자택전화번호</span></th>
											<td colspan="3">
												<select id="telno1" class="select_default">
													<option value="02" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '02' ? 'selected' : empty fn:split(sessionScope.rb_member.MB_TEL,'-')[0] ? 'selected' : ''}>02</option>
													<option value="031" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '031' ? 'selected' : ''}>031</option>
													<option value="032" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '032' ? 'selected' : ''}>032</option>
													<option value="033" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '033' ? 'selected' : ''}>033</option>
													<option value="041" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '041' ? 'selected' : ''}>041</option>
													<option value="042" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '042' ? 'selected' : ''}>042</option>
													<option value="043" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '043' ? 'selected' : ''}>043</option>
													<option value="051" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '031' ? 'selected' : ''}>031</option>
													<option value="052" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '052' ? 'selected' : ''}>052</option>
													<option value="053" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '053' ? 'selected' : ''}>053</option>
													<option value="054" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '054' ? 'selected' : ''}>054</option>
													<option value="055" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '055' ? 'selected' : ''}>055</option>
													<option value="061" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '061' ? 'selected' : ''}>061</option>
													<option value="062" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '062' ? 'selected' : ''}>062</option>
													<option value="063" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '063' ? 'selected' : ''}>063</option>
													<option value="064" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '064' ? 'selected' : ''}>064</option>
													<option value="070" ${fn:split(sessionScope.rb_member.MB_TEL,'-')[0] eq '070' ? 'selected' : ''}>070</option>
												</select>
												<span><font face="fixedsys">-</font></span>
												<input value="${fn:split(sessionScope.rb_member.MB_TEL,'-')[1]}" type="text" class="numberData" maxlength="4" id="telno2">
												<span><font face="fixedsys">-</font></span>
												<input value="${fn:split(sessionScope.rb_member.MB_TEL,'-')[2]}" type="text" class="numberData" maxlength="4" id="telno3">
												<input type="hidden" name="mb_tel">
											</td>
										</tr>
		
										<!--휴대전화-->
										<tr>
											<th><img class="must" src="/images/auth/ico_must.gif"><span class="span_default">휴대전화번호</span></th>
											<td colspan="3">
												<select id="mtelno1" class="select_default">
													<option value="010" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '010' ? 'selected' : '' }>010</option>
													<option value="011" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '011' ? 'selected' : '' }>011</option>
													<option value="016" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '016' ? 'selected' : '' }>016</option>
													<option value="017" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '017' ? 'selected' : '' }>017</option>
													<option value="018" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '018' ? 'selected' : '' }>018</option>
													<option value="019" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '019' ? 'selected' : '' }>019</option>
													<option value="050" ${fn:split(sessionScope.rb_member.MB_HP, '-')[0] eq '050' ? 'selected' : '' }>050</option>
												</select>
												<span><font face="fixedsys">-</font></span>
												<input value="${fn:split(sessionScope.rb_member.MB_HP, '-')[1]}" type="text" class="numberData" maxlength="4" id="mtelno2">
												<span><font face="fixedsys">-</font></span>
												<input value="${fn:split(sessionScope.rb_member.MB_HP, '-')[2]}" type="text" class="numberData" maxlength="4" id="mtelno3">
												<p class="desc">주문,판매,입금,질문,답변 등을 문자 메세지로 전달 받을 수 있습니다</p>
												<input type="hidden" name="mb_hp">
											</td>
										</tr>
									</tbody>
								</table>
								
								<!--가입폼 시작 :: 계좌정보-->
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">계좌 정보 입력</span>
								</div>
								<table class="common_table_normal">
									<colgroup>
										<col width="150px">
										<col width="230px">
										<col width="150px">
										<col width="*">
									</colgroup>
									<!--예금주명, 은행명-->
									<tbody>
										<tr>
											<th><span class="span_default">예금주명</span></th>
											<td><input type="text" name="mb_bank_owner" size="20" maxlength="20" value="${sessionScope.rb_member.MB_BANK_OWNER}"></td>
											<th><span class="span_default">은행선택</span></th>
											<td>
												<select class="select_default" name="mb_bank_name">
													<option value="">선택하세요</option>
													<option value="HSBC" ${sessionScope.rb_member.MB_BANK_NAME eq 'HSBC' ? 'selected' : '' }>HSBC</option>
													<option value="경남은행" ${sessionScope.rb_member.MB_BANK_NAME eq '경남은행' ? 'selected' : '' }>경남은행</option>
													<option value="광주은행" ${sessionScope.rb_member.MB_BANK_NAME eq '광주은행' ? 'selected' : '' }>광주은행</option>
													<option value="국민은행" ${sessionScope.rb_member.MB_BANK_NAME eq '국민은행' ? 'selected' : '' }>국민은행</option>
													<option value="기업은행" ${sessionScope.rb_member.MB_BANK_NAME eq '기업은행' ? 'selected' : '' }>기업은행</option>
													<option value="농협중앙회" ${sessionScope.rb_member.MB_BANK_NAME eq '농협중앙회' ? 'selected' : '' }>농협중앙회</option>
													<option value="단위농협" ${sessionScope.rb_member.MB_BANK_NAME eq '단위농협' ? 'selected' : '' }>단위농협</option>
													<option value="대구은행" ${sessionScope.rb_member.MB_BANK_NAME eq '대구은행' ? 'selected' : '' }>대구은행</option>
													<option value="부산은행" ${sessionScope.rb_member.MB_BANK_NAME eq '부산은행' ? 'selected' : '' }>부산은행</option>
													<option value="산업은행" ${sessionScope.rb_member.MB_BANK_NAME eq '산업은행' ? 'selected' : '' }>산업은행</option>
													<option value="새마을금고" ${sessionScope.rb_member.MB_BANK_NAME eq '새마을금고' ? 'selected' : '' }>새마을금고</option>
													<option value="수협" ${sessionScope.rb_member.MB_BANK_NAME eq '수협' ? 'selected' : '' }>수협</option>
													<option value="신한은행" ${sessionScope.rb_member.MB_BANK_NAME eq '신한은행' ? 'selected' : '' }>신한은행</option>
													<option value="신협" ${sessionScope.rb_member.MB_BANK_NAME eq '신협' ? 'selected' : '' }>신협</option>
													<option value="씨티은행" ${sessionScope.rb_member.MB_BANK_NAME eq '씨티은행' ? 'selected' : '' }>씨티은행</option>
													<option value="에이비앤암로" ${sessionScope.rb_member.MB_BANK_NAME eq '에이비앤암로' ? 'selected' : '' }>에이비앤암로</option>
													<option value="외환은행" ${sessionScope.rb_member.MB_BANK_NAME eq '외환은행' ? 'selected' : '' }>외환은행</option>
													<option value="우리은행" ${sessionScope.rb_member.MB_BANK_NAME eq '우리은행' ? 'selected' : '' }>우리은행</option>
													<option value="우체국" ${sessionScope.rb_member.MB_BANK_NAME eq '우체국' ? 'selected' : '' }>우체국</option>
													<option value="저축은행" ${sessionScope.rb_member.MB_BANK_NAME eq '저축은행' ? 'selected' : '' }>저축은행</option>
													<option value="전북은행" ${sessionScope.rb_member.MB_BANK_NAME eq '전북은행' ? 'selected' : '' }>전북은행</option>
													<option value="제일은행" ${sessionScope.rb_member.MB_BANK_NAME eq '제일은행' ? 'selected' : '' }>제일은행</option>
													<option value="제주은행" ${sessionScope.rb_member.MB_BANK_NAME eq '제주은행' ? 'selected' : '' }>제주은행</option>
													<option value="조흥은행" ${sessionScope.rb_member.MB_BANK_NAME eq '조흥은행' ? 'selected' : '' }>조흥은행</option>
													<option value="하나은행" ${sessionScope.rb_member.MB_BANK_NAME eq '하나은행' ? 'selected' : '' }>하나은행</option>
													<option value="한미은행" ${sessionScope.rb_member.MB_BANK_NAME eq '한미은행' ? 'selected' : '' }>한미은행</option>
												</select>
											</td>
										</tr>
										<!--계좌번호-->
										<tr>
											<th><span class="span_default">계좌번호</span></th>
											<td colspan="3">
												<input class="numberData" type="text" name="mb_bank_no" maxlength="30" value="${sessionScope.rb_member.MB_BANK_NO }">
												<p class="desc">- 없이숫자만 입력 하세요</p>
												<p class="desc">인증된 실명 또는 사업자등록증의 성명과 예금주가 동일하지 않을 경우 송금처리가 되지 않을 수도 있습니다</p>
											</td>
										</tr>
									</tbody>
								</table>
								
								<!--가입폼 시작 :: 계좌정보-->
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">사업자 정보</span>
									<span class="span_default"><button type="button" class="button_default" onclick="javascript:location.href='/myPage/licenseeManagement.do'">변경/신청</button></span>
								</div>
								<table class="common_table_normal">
									<colgroup>
										<col width="150px">
										<col width="230px">
										<col width="150px">
										<col width="*">
									</colgroup>
									<!--상호명, 사업자유형-->
									<tbody>
										<tr>
											<th><span class="span_default">상호명</span></th>
											<td><span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_NAME }[${sessionScope.rb_member.MB_CRET_BIZ eq '1'? '인증완료':'미인증'}]</b></span></td>
											<th><span class="span_default">사업자유형</span></th>
											<td><span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_TYPE}[${sessionScope.rb_member.MB_CRET_BIZ eq '1'? '인증완료':'미인증'}]</b></span></td>
										</tr>
										<!--대표자명, 사업자등록번호-->
										<tr>
											<th><span class="span_default">대표자명</span></th>
											<td><span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_CEO_NAME }[${sessionScope.rb_member.MB_CRET_BIZ eq '1'? '인증완료':'미인증'}]</b></span></td>
											<th><span class="span_default">사업자등록번호</span></th>
											<td><span class="span_default"><b>${fn:split(sessionScope.rb_member.MB_BIZ_NO,'-')[0]}-${fn:split(sessionScope.rb_member.MB_BIZ_NO,'-')[1]}-${fn:split(sessionScope.rb_member.MB_BIZ_NO,'-')[2]}[${sessionScope.rb_member.MB_CRET_BIZ eq '1'? '인증완료':'미인증'}]</b></span></td>
										</tr>
										<tr>
											<th><span class="span_default">업태</span></th>
											<td><span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_CONDITION}[${sessionScope.rb_member.MB_CRET_BIZ eq '1'? '인증완료':'미인증'}]</b></span></td>
											<th><span class="span_default">업종</span></th>
											<td><span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_CATEGORY}[${sessionScope.rb_member.MB_CRET_BIZ eq '1'? '인증완료':'미인증'}]</b></span></td>
										</tr>
										<!--사업자주소-->
										<tr>
											<th><span class="span_default">사업자 주소</span></th>
											<td colspan="3">
												<span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_ZIP_CODE}</b></span><br>
												<span class="span_default"><b>${sessionScope.rb_member.MB_BIZ_ADDRESS} ${sessionScope.rb_member.MB_BIZ_ADDRESS_DETAIL}</b></span>
											</td>
										</tr>
										<!--사업장전화-->
										<tr>
											<th><span class="span_default">사업장 전화</span></th>
											<td colspan="3">
												<select id="bizTelno1" class="select_default">
													<option value="02" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '02' ? 'selected' : empty fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] ? 'selected' : ''}>02</option>
													<option value="031" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '031' ? 'selected' : ''}>031</option>
													<option value="032" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '032' ? 'selected' : ''}>032</option>
													<option value="033" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '033' ? 'selected' : ''}>033</option>
													<option value="041" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '041' ? 'selected' : ''}>041</option>
													<option value="042" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '042' ? 'selected' : ''}>042</option>
													<option value="043" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '043' ? 'selected' : ''}>043</option>
													<option value="051" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '051' ? 'selected' : ''}>051</option>
													<option value="052" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '052' ? 'selected' : ''}>052</option>
													<option value="053" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '053' ? 'selected' : ''}>053</option>
													<option value="054" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '054' ? 'selected' : ''}>054</option>
													<option value="055" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '055' ? 'selected' : ''}>055</option>
													<option value="061" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '061' ? 'selected' : ''}>061</option>
													<option value="062" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '062' ? 'selected' : ''}>062</option>
													<option value="063" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '063' ? 'selected' : ''}>063</option>
													<option value="064" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '064' ? 'selected' : ''}>064</option>
													<option value="070" ${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[0] eq '070' ? 'selected' : ''}>070</option>
												</select>
												<span><font face="fixedsys">-</font></span>
												<input type="text" class="numberData" maxlength="4" id="bizTelno2" value="${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[1]}">
												<span><font face="fixedsys">-</font></span> 
												<input type="text" class="numberData" maxlength="4" id="bizTelno3" value="${fn:split(sessionScope.rb_member.MB_BIZ_TEL,'-')[2]}">
												<input type="hidden" name="mb_biz_tel">
											</td>
										</tr>
									</tbody>
								</table>
								<!--가입폼 종료 :: 사업자정보-->
								<p></p>
								<!--가입폼 시작 :: 부가정보-->
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">부가 정보 입력</span>
								</div>
								<table class="common_table_normal">
									<colgroup>
										<col width="150px">
										<col width="*">
									</colgroup>
									<!--추천인 아이디-->
									<tbody>
										<tr>
											<th><span class="span_default">추천인 아이디</span></th>
											<td colspan="3">
												<span class="span_default"><b>${empty sessionScope.rb_member.MB_RECOMM_ID ? '추천인 없음' : sessionScope.rb_member.MB_RECOMM_ID}</b></span>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="submit_button_area">
									<button type="button" class="button_submit" onclick="memberInfoUpdate();">변경 하기</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>