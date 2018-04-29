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
<link rel="stylesheet" type="text/css" href="/css/auth/join.css">
<script type="text/javascript" src="/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/js/RSA/rng.js"></script>
<script type="text/javascript" src="/js/auth/join.js"></script>

<!-- 메인 -->
<!-- CSS 끝 -->
</head>
	<body>
		<!-- 주소 찾기 검색용 -->
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					<input type="hidden" id="returnUrl" value="">
					<form id="memberJoinForm">
						<input type="hidden" name="mb_password">
						<!--가입안내 시작-->
						<div class="common_lable_div">
							<img class="common_lable_img" src="/images/common/ico_common2.gif">
							<span class="common_lable_span">회원 가입 안내</span>
						</div>
						<table class="common_table_max">
							<tbody>
								<tr>
									<td>
										<p>가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구</p>
										<p>가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구가입안내문구</p>
									</td>
								</tr>
							</tbody>
						</table>
						<center>
							<img src="http://via.placeholder.com/478x69">
						</center>
						<div class="common_lable_div">
							<img class="common_lable_img" src="/images/common/ico_common2.gif">
							<span class="common_lable_span">회원 분류 선택</span>
						</div>
						<table class="common_table_max">
							<tbody>
								<!-- 회원타입 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">회원타입</span></th>
									<td colspan="3">
										<div>
											<input type="radio" name="mb_type" value="1" checked="checked"><label>일반</label>
											<input type="radio" name="mb_type" value="2"><label>판매자</label>
										</div>
										<p class="desc">회원 분류</p>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="common_lable_div">
							<img class="common_lable_img" src="/images/common/ico_common2.gif">
							<span class="common_lable_span">회원 정보 입력</span>
						</div>
						<table class="common_table_max">
							<tbody>
								<!-- 회원아이디 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">회원아이디</span></th>
									<td colspan="3">
										<input type="text" name="mb_id" maxlength="20" onfocus="setDefaultInputMent('join_mb_id_ment_p','아이디는 4~20자 이내의 영문, 숫자, _ 만 입력 가능합니다.');">
										<button type="button" class="button_default" onclick="memberIdCheck();" >아이디중복체크</button>
										<p id="join_mb_id_ment_p" class="desc">아이디는 3~20자 이내의 영문, 숫자, _ 만 입력 가능합니다.</p>
									</td>
								</tr>
								<!-- 비밀번호 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">비밀번호</span></th>
									<td colspan="3">
										<input type="password" id="mb_password_tmp" maxlength="20" onblur="memberPasswordCheck(this);" onfocus="setDefaultInputMent('join_mb_password_ment_p','비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.');">
										<p class="desc" id="join_mb_password_ment_p">비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.</p>
									</td>
								</tr>
								<!-- 비밀번호확인 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">비밀번호확인</span></th>
									<td colspan="3">
										<input type="password" id="mb_password_confirm_tmp" maxlength="20" onblur="memberPasswordConfirmCheck(this);" onfocus="setDefaultInputMent('join_mb_password_confirm_ment_p','비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.');">
										<p class="desc" id="join_mb_password_confirm_ment_p">비밀번호는 8~20자 이내의 영대소문자,숫자,특수문자(!@#$%^&amp;+=)로 이루어져야 합니다.</p>
									</td>
								</tr>
								<!-- 이름 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">이름</span></th>
									<td colspan="3">
										<input type="text" name="mb_name" maxlength="4" onblur="javascript:memberNameCheck(this);" onfocus="setDefaultInputMent('join_mb_name_ment_p','한글 (공백제외) 만 입력 가능 합니다.');">
										<p class="desc" id="join_mb_name_ment_p">이름은 한글(공백제외) 2~4자 만 입력 가능 합니다.</p>
									</td>
								</tr>
								<!-- 닉네임 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">닉네임</span></th>
									<td colspan="3">
										<input type="text" name="mb_nickname" maxlength="20" onfocus="setDefaultInputMent('join_mb_nickname_ment_p','닉네임은 1~20자 한글, 영문, 숫자 입력 가능 합니다.');">
										<button type="button" class="button_default" onclick="javascript:memberNickNameCheck();">닉네임중복체크</button>
										<p class="desc" id="join_mb_nickname_ment_p">닉네임은 1~20자 한글, 영문, 숫자 입력 가능 합니다.</p>
									</td>
								</tr>
								<!-- 생년월일 -->
								<tr>
									<th>생년월일</th>
									<td colspan="3">
										<select id="birth_year" class="select_default" onfocus="setDefaultInputMent('join_mb_birthday_ment_p','생년월일 을 선택하세요.');"></select>
										<select id="birth_month" class="select_default" onfocus="setDefaultInputMent('join_mb_birthday_ment_p','생년월일 을 선택하세요.');"></select>
										<select id="birth_day" class="select_default" onfocus="setDefaultInputMent('join_mb_birthday_ment_p','생년월일 을 선택하세요.');"></select>
										<input type="hidden" name="mb_birthday" maxlength="8" size="8">
										<div>
											<input type="radio" name="mb_birthday_type" value="0" checked="checked"><label for="contactChoice1">양력</label>
											<input type="radio" name="mb_birthday_type" value="1"><label for="contactChoice2">음력</label>
										</div>
										<p class="desc" id="join_mb_birthday_ment_p">생년월일 을 선택하세요.</p>
									</td>
								</tr>
								<!-- 전화번호 -->
								<tr>
									<th>전화번호</th>
									<td colspan="3">
										<select  class="select_default" id="telno1" onfocus="setDefaultInputMent('join_mb_tel_ment_p','전화번호를 입력 하세요.');"> 
										     <option value="02" selected="">02</option> 
										     <option value="031">031</option> 
										     <option value="032">032</option> 
										     <option value="033">033</option> 
										     <option value="041">041</option> 
										     <option value="042">042</option> 
										     <option value="043">043</option> 
										     <option value="051">051</option> 
										     <option value="052">052</option> 
										     <option value="053">053</option> 
										     <option value="054">054</option> 
										     <option value="055">055</option> 
										     <option value="061">061</option> 
										     <option value="062">062</option> 
										     <option value="063">063</option> 
										     <option value="064">064</option> 
										     <option value="070">070</option>
									    </select>
									    <span><font face="fixedsys">-</font></span>
									    <input type="text" class="numberData" maxlength="4" id="telno2" onfocus="setDefaultInputMent('join_mb_tel_ment_p','전화번호를 입력 하세요.');">
									    <span><font face="fixedsys">-</font></span>
									    <input type="text" class="numberData" maxlength="4" id="telno3" onfocus="setDefaultInputMent('join_mb_tel_ment_p','전화번호를 입력 하세요.');">
										<input type="hidden" name="mb_tel">
										<p class="desc" id="join_mb_tel_ment_p">전화번호를 입력 하세요.</p>
									</td>
								</tr>
								<!-- 휴대폰번호 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">휴대폰번호</span></th>
									<td colspan="3">
										<select class="select_default" id="mtelno1" onfocus="setDefaultInputMent('join_mb_hp_ment_p','휴대폰번호 를 입력 하세요.');"> 
										     <option value="010" selected="">010</option> 
										     <option value="011">011</option> 
										     <option value="016">016</option> 
										     <option value="017">017</option> 
										     <option value="018">018</option> 
										     <option value="019">019</option> 
									    </select>
									    <span><font face="fixedsys">-</font></span>
									    <input type="text" class="numberData" maxlength="4" id="mtelno2" onfocus="setDefaultInputMent('join_mb_hp_ment_p','휴대폰번호 를 입력 하세요.');">
									    <span><font face="fixedsys">-</font></span>
									    <input type="text" class="numberData" maxlength="4" id="mtelno3" onfocus="setDefaultInputMent('join_mb_hp_ment_p','휴대폰번호 를 입력 하세요.');">
										<input type="hidden" name="mb_hp">
										<p class="desc" id="join_mb_hp_ment_p">휴대폰번호 를 입력 하세요.</p>
									</td>
								</tr>
								<!--이메일주소-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">이메일주소</span></th>
									<td colspan="3" >
										<input type="text" id="mail1" maxlength="40" onfocus="setDefaultInputMent('join_mb_email_ment_p','이메일을 입력 하세요.');">
										<fontface="arial">@</fontface="arial">
										<input type="text" id="mail2" maxlength="40" onfocus="setDefaultInputMent('join_mb_email_ment_p','이메일을 입력 하세요.');">
										<select class="select_default" id="mail3" onchange="setMailForm(this);" onfocus="setDefaultInputMent('join_mb_email_ment_p','이메일을 입력 하세요.');">
											<option value="" selected="selected">직접입력</option>
											<option value="naver.com">네이버</option>
											<option value="gmail.com">구글메일</option>
											<option value="hanmail.net">한메일</option>
											<option value="hotmail.com">핫메일</option>
											<option value="chollian.net">천리안</option>
											<option value="hitel.net">하이텔</option>
											<option value="dreamwiz.com">드림위즈</option>
											<option value="yahoo.co.kr">야후</option>
											<option value="lycos.co.kr">라이코스</option>
											<option value="netian.com">네띠앙</option>
											<option value="korea.com">코리아닷컴</option>
											<option value="orgio.net">오르지오</option>
											<option value="empal.com">엠파스(엠팔)</option>
											<option value="hanafos.com">하나포스</option>
										</select>
										<input type="hidden" name="mb_email">
										<p class="desc" id="join_mb_email_ment_p">이메일을 입력 하세요.</p>
									</td>
								</tr>
								<!-- 주소 -->									
								<tr>
									<th>주소</th>
									<td colspan="3">
										<input readonly="readonly" type="text" name="mb_zip_code" maxlength="10" size="10" onfocus="setDefaultInputMent('join_mb_addresss_ment_p','주소를 입력 하세요.');">우편번호
										<button type="button" class="button_default" onclick="goAddrPopup('mbAddress');">우편번호찾기</button>
										<input readonly="readonly" type="text" name="mb_address" maxlength="70" size="70" onfocus="setDefaultInputMent('join_mb_addresss_ment_p','주소를 입력 하세요.');">기본주소
										<input type="text" name="mb_address_detail" maxlength="70" size="70" onfocus="setDefaultInputMent('join_mb_addresss_ment_p','주소를 입력 하세요.');">상세주소
										<p class="desc" id="join_mb_addresss_ment_p">주소를 입력 하세요.</p>
									</td>
								</tr>
								
								
								<!-- 상호명 -->
								<tr>
									<th><img class="sellerType_img" style="display: none;" src="/images/auth/ico_must.gif"><span class="span_default">상호명</span></th>
									<td colspan="3">
										<input type="text" name="mb_biz_name" maxlength="20" onfocus="setDefaultInputMent('join_mb_biz_name_ment_p','1~20자 한글, 영문, 숫자 입력 가능 합니다.');">
										<p class="desc" id="join_mb_biz_name_ment_p">상호명은 1~20자 한글, 영문, 숫자 입력 가능 합니다.</p>
									</td>
								</tr>
								<!-- 대표자명 -->
								<tr>
									<th><img class="sellerType_img" style="display: none;" src="/images/auth/ico_must.gif"><span class="span_default">대표자명</span></th>
									<td colspan="3">
										<input type="text" name="mb_biz_ceo_name" maxlength="70" onfocus="setDefaultInputMent('join_mb_biz_ceo_name_ment_p','대표자명은 한글(공백제외) 2~4자 만 입력 가능 합니다.');">
										<p class="desc" id="join_mb_biz_ceo_name_ment_p">대표자명은 한글(공백제외) 2~4자 만 입력 가능 합니다.</p>
									</td>
								</tr>
								<!-- 사업자 등록 번호 -->
								<tr>
									<th><img class="sellerType_img" style="display: none;" src="/images/auth/ico_must.gif"><span class="span_default">사업자등록번호</span></th>
									<td colspan="3">
										<input type="text" class="numberData" maxlength="3" id="mb_biz_no_1" onfocus="setDefaultInputMent('join_mb_biz_no_ment_p','사업자 등록번호를 입력 하세요.');">
										<span><font face="fixedsys">-</font></span>
										<input type="text" class="numberData" maxlength="2" id="mb_biz_no_2" onfocus="setDefaultInputMent('join_mb_biz_no_ment_p','사업자 등록번호를 입력 하세요.');">
										<span><font face="fixedsys">-</font></span>
										<input type="text" class="numberData" maxlength="5" id="mb_biz_no_3" onfocus="setDefaultInputMent('join_mb_biz_no_ment_p','사업자 등록번호를 입력 하세요.');">
										<input type="hidden" name="mb_biz_no">
										<p class="desc" id="join_mb_biz_no_ment_p">사업자 등록번호를 입력 하세요.</p>
									</td>
								</tr>
								<!-- 사업장 전화번호 -->
								<tr>
									<th><img class="sellerType_img" style="display: none;" src="/images/auth/ico_must.gif"><span class="span_default">사업장전화</span></th>
									<td colspan="3">
										<select class="select_default" id="bizTelno1" onfocus="setDefaultInputMent('join_mb_biz_tel_ment_p','사업장전화번호를 입력 하세요.');"> 
										     <option value="02" selected="">02</option> 
										     <option value="031">031</option> 
										     <option value="032">032</option> 
										     <option value="033">033</option> 
										     <option value="041">041</option> 
										     <option value="042">042</option> 
										     <option value="043">043</option> 
										     <option value="051">051</option> 
										     <option value="052">052</option> 
										     <option value="053">053</option> 
										     <option value="054">054</option> 
										     <option value="055">055</option> 
										     <option value="061">061</option> 
										     <option value="062">062</option> 
										     <option value="063">063</option> 
										     <option value="064">064</option> 
										     <option value="070">070</option>
									    </select>
									    <span><font face="fixedsys">-</font></span>
									    <input type="text" class="numberData" maxlength="4" id="bizTelno2" onfocus="setDefaultInputMent('join_mb_biz_tel_ment_p','사업장전화번호를 입력 하세요.');">
									    <span><font face="fixedsys">-</font></span>
									    <input type="text" class="numberData" maxlength="4" id="bizTelno3" onfocus="setDefaultInputMent('join_mb_biz_tel_ment_p','사업장전화번호를 입력 하세요.');">
										<input type="hidden" name="mb_biz_tel">
										<p class="desc" id="join_mb_biz_tel_ment_p">사업장전화번호를 입력 하세요.</p>
									</td>
								</tr>
								<!-- 사업장 주소지 -->
								<tr>
									<th><img class="sellerType_img" style="display: none;" src="/images/auth/ico_must.gif"><span class="span_default">사업장 주소</span></th>
									<td colspan="3">
										<input readonly="readonly" type="text" name="mb_biz_zip_code" maxlength="10" size="10" onfocus="setDefaultInputMent('join_mb_biz_address_ment_p','사업장주소를 입력 하세요.');">우편번호
										<button type="button" class="button_default" type="button" onclick="goAddrPopup('bizAddress');">우편번호찾기</button>
										<input readonly="readonly" type="text" name="mb_biz_address" maxlength="70" size="70" onfocus="setDefaultInputMent('join_mb_biz_address_ment_p','사업장주소를 입력 하세요.');">기본주소
										<input type="text" name="mb_biz_address_detail" maxlength="70" size="70" onfocus="setDefaultInputMent('join_mb_biz_address_ment_p','사업장주소를 입력 하세요.');">상세주소
										<p class="desc" id="join_mb_biz_address_ment_p">사업장주소를 입력 하세요.</p>
									</td>
								</tr>
								
								<!-- 매장형태 -->
								<tr class="mb_type_tr">
									<th>매장형태</th>
									<td colspan="3">
										<input type="checkbox" name="mb_biz_type_1" value="1"><label>대리점</label>
										<input type="checkbox" name="mb_biz_type_2" value="1"><label>판매점</label>
										<input type="checkbox" name="mb_biz_type_3" value="1"><label>온라인</label>
										<input type="checkbox" name="mb_biz_type_4" value="1"><label>방문판매</label>
										<input type="checkbox" name="mb_biz_type_5" value="1"><label>기타</label>
									</td>
								</tr>
								<!-- P코드,매장코드 -->
								<tr class="mb_type_tr">
									<th><span class="span_default">P코드, 대리점코드</span></th>
									<td colspan="3">
										<input type="text" name="mb_biz_code" onfocus="setDefaultInputMent('join_mb_biz_code_ment_p','P코드, 대리점코드 를 입력 하세요.');">
										<p class="desc" id="join_mb_biz_code_ment_p">P코드, 대리점코드 를 입력 하세요.</p>
									</td>
								</tr>
								<tr>
								<!-- 정보수신 -->
								</tr><tr class="mb_type_tr">
									<th>정보수신</th>
									<td colspan="3">
										<input type="checkbox" name="mb_info_recv_mail" value="1"><label>email</label>
										<input type="checkbox" name="mb_info_recv_post" value="1"><label>우편</label>
										<input type="checkbox" name="mb_info_recv_sms" value="1"><label>문자</label>
										<input type="checkbox" name="mb_info_recv_hp" value="1"><label>전화</label>
									</td>
								</tr>
								<tr class="mb_type_tr">
									<th><span class="span_default">정보공개</span></th>
									<td colspan="3">
										<input type="checkbox" name="mb_info_open" value="1" checked="checked"><label>동의</label>
									</td>
								</tr>
								<!-- 추천인 아이디 -->
								<tr class="mb_type_tr">
									<th>추천인ID</th>
									<td colspan="3">
										<input type="text" name="mb_recomm_id" onfocus="setDefaultInputMent('join_mb_recomm_id_ment_p','추천인 ID를 입력 하세요.');">
										<p class="desc" id="join_mb_recomm_id_ment_p">추천인 ID를 입력 하세요.</p>
									</td>
								</tr>
								
							</tbody>
						</table>
						<!--가입폼 종료-->
						<div class="submit_button_area">
							<!-- <input type="image" src="/images/auth/btn_memberRegisterOk.gif" border="0" alt="회원가입을 합니다" onclick="javascript:memberJoin();"> -->
							<button type="button" class="button_submit" id="memberJoinBtn" alt="회원가입" onclick="javascript:memberJoin();">가입완료</button>
						</div>
					</form>
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>