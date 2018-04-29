<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="v6LeftSubMenu">
	<div class="section">
		<div class="title"><img src="http://via.placeholder.com/145x75" alt="My페이지" width="145" height="75"></div>
	</div>
	
	<c:if test="${sessionScope.rb_member.MB_TYPE eq '1' }">
		<div class="section">
		<div class="title"><img src="http://211.43.195.137/image/v6/elements/my/mypage/menu/img_emoney.jpg" alt="e-money통장" width="145" height="22"></div>
		<ul>
			<li class="${selectMenuUrl eq '/myPage/emoneyUseList.do' ? 'selected' : '' }"><a href="/myPage/emoneyUseList.do">사용내역</a></li>
			<li class="${selectMenuUrl eq '/myPage/emoneyCharge.do' ? 'selected' : '' }"><a href="/myPage/emoneyCharge.do">충전하기</a></li>
			<li class="${selectMenuUrl eq '/myPage/emoneyChargeList.do' ? 'selected' : '' }"><a href="/myPage/emoneyChargeList.do">충전내역</a></li>
			<li class="${selectMenuUrl eq '/myPage/emoneyCashOut.do' ? 'selected' : '' }"><a href="/myPage/emoneyCashOut.do">출금하기</a></li>
			<li class="${selectMenuUrl eq '/myPage/emoneyCashOutList.do' ? 'selected' : '' }"><a href="/myPage/emoneyCashOutList.do">출금내역</a></li>
		</ul>
	</div>
	</c:if>
	<c:if test="${sessionScope.rb_member.MB_TYPE eq '1' }">
		<div class="section">
			<div class="title"><img src="http://211.43.195.137/image/v6/elements/my/mypage/menu/img_taxBill.jpg" alt="세금계산서" width="145" height="22"></div>
			<ul>
				<li class="${selectMenuUrl eq '/myPage/taxCalculationList.do' ? 'selected' : '' }"><a href="/myPage/taxCalculationList.do">발급내역보기</a></li>
			</ul>
		</div>
	</c:if>
	<div class="section">
		<div class="title"><img src="http://211.43.195.137/image/v6/elements/my/mypage/menu/img_privacy.jpg" alt="개인정보관리" width="145" height="22"></div>
		<ul>
			<li class="${selectMenuUrl eq '/myPage/memberInfoUpdate.do' ? 'selected' : '' }"><a href="/myPage/memberInfoUpdate.do">회원정보수정</a></li>
			<li class="${selectMenuUrl eq '/myPage/memberSetting.do' ? 'selected' : '' }"><a href="/myPage/memberSetting.do">개인환경설정</a></li>
			<li class="${selectMenuUrl eq '/myPage/memberLoginSetting.do' ? 'selected' : '' }"><a href="/myPage/memberLoginSetting.do">로그인관리</a></li>
			<%-- <li class="${selectMenuUrl eq '/myPage/memberGradeSearch.do' ? 'selected' : '' }"><a href="/myPage/memberGradeSearch.do">회원등급조회</a></li> --%>
			<li class="${selectMenuUrl eq '/myPage/memberCertificationManagement.do' ? 'selected' : '' }"><a href="/myPage/memberCertificationManagement.do">나의인증관리</a></li>
			<li class="${selectMenuUrl eq '/myPage/licenseeManagement.do' ? 'selected' : '' }"><a href="/myPage/licenseeManagement.do">사업자인증신청/변경</a></li>
			<li class="${selectMenuUrl eq '/myPage/memberLeave.do' ? 'selected' : '' }"><a href="/myPage/memberLeave.do">회원탈퇴신청</a></li>
		</ul>
	</div>
	<c:if test="${sessionScope.rb_member.MB_TYPE eq '1' }">
		<div class="section">
			<div class="title"><img src="http://211.43.195.137/image/v6/elements/my/mypage/menu/img_point.png" alt="포인트" width="145" height="22">
			</div>
			<ul>
				<li class="${selectMenuUrl eq '/myPage/pointUseList.do' ? 'selected' : '' }"><a href="/myPage/pointUseList.do">포인트적립/사용내역</a></li>
			</ul>
		</div>
	</c:if>
	<div class="section">
		<div class="title"><img src="http://211.43.195.137/image/v6/elements/my/mypage/menu/img_support.jpg" alt="1:1상담" width="145" height="22">
		</div>
		<ul>
			<li class="${selectMenuUrl eq '/myPage/inquiryList.do' ? 'selected' : '' }"><a href="/myPage/inquiryList.do">상담글 목록</a></li>
			<li class="${selectMenuUrl eq '/myPage/inquiryWrite.do' ? 'selected' : '' }"><a href="/myPage/inquiryWrite.do">상담글 쓰기</a></li>
			<li class="${(selectMenuUrl eq '/myPage/letterList.do') || (selectMenuUrl eq '/myPage/letterView.do') ? 'selected' : '' }"><a href="/myPage/letterList.do">쪽지 수신함</a></li>
		</ul>
	</div>
</div>