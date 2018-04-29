$(document).ready(function(){
	
	//setTestDefaultInputData();
	//rsaTest();
	setBirthSelectBox("select#birth_year","select#birth_month","select#birth_day");
	
	$("input[name=mb_type]").on("change",function(){
		if($(this).val() == "1"){
			$("tr.mb_type_tr").show();
			$("img.sellerType_img").hide();
		}else{
			$("tr.mb_type_tr").hide();
			$("img.sellerType_img").show();
		}
	});
	
	$("input[name=mb_id]").keydown(function (key) {
        if(key.keyCode == 13){
        	memberIdCheck();
        	stopClickEventBubbling(key);
        }
       
    });
	
	$("input[name=mb_nickname]").keydown(function (key) {
        if(key.keyCode == 13){
        	memberNickNameCheck();
        	stopClickEventBubbling(key);
        }
    });
});

/*
 * 생일입력 셀렉트 박스 셋팅
 */
function setBirthSelectBox(selector_year,selector_month,selector_day){
	
	for (var i = $.datepicker.formatDate('yy', new Date()); $.datepicker.formatDate('yy', new Date())-100 < i; i--) {
		$(selector_year).append($('<option>', {text: i, value: i}));
	}
	for (var i = 1; 13 > i; i++) {
		$(selector_month).append($('<option>', {text: i, value: i < 10 ? "0"+i : i}));
	}
	for (var i = 1; 32 > i; i++) {
		$(selector_day).append($('<option>', {text: i, value: i < 10 ? "0" + i : i}));
	}
}

/*
 * 주소검색 팝업 리턴
 */
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo,cate){
	
	if(cate == "mbAddress"){
		$("input[name=mb_zip_code]").val(zipNo);
		$("input[name=mb_address]").val(roadAddrPart1);
		$("input[name=mb_address_detail]").val(addrDetail);
		$("input[name=mb_address_type]").val(2);
	}else if(cate == "bizAddress"){
		$("input[name=mb_biz_zip_code]").val(zipNo);
		$("input[name=mb_biz_address]").val(roadAddrPart1);
		$("input[name=mb_biz_address_detail]").val(addrDetail);
	}
}
/*
 * 회원 아이디 체크
 */
function memberIdCheck(){
	
	console.log("memberIdCheck()");
	
	if($("input[name=mb_id]").val().match(SPACE_REGULAR_EXPRESSTION)){
		$("#join_mb_id_ment_p").text("아이디는 공백 입력이 불가 합니다.").css("color","red");
	}else{
		if(!getRegExpResult(ID_REGULAR_EXPRESSTION,$("input[name=mb_id]").val())){
			$("#join_mb_id_ment_p").text("아이디 입력 형식이 바르지 않습니다.").css("color","red");
		}else{
			$.ajax({
				type : "POST"
				,url : "/auth/checkMemberIdAjax.do"
				,data : {
					"mb_id" : $("input[name=mb_id]").val()
				}
				,dataType : "json"
//				로그인 인터셉터시
//				,beforeSend : function(xmlHttpRequest){
//		            xmlHttpRequest.setRequestHeader("AJAX", "true");
//		        }
				,async : false
				,success : function(result, status, xhr) {
					
					console.log(result.result);
					
					if(result.result == AJAX_RESULT_SUCCESS){
						$("#join_mb_id_ment_p").text("사용 가능한 아이디 입니다.").css("color","grey");
						$("input#mb_password_tmp").focus();
					}else{
						$("#join_mb_id_ment_p").text("이미 존재 하는 아이디 입니다.").css("color","red");
						$("input[name=mb_id]").blur();
					}
				}
				,error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		}
	}
	
}
/*
 * 비밀번호 체크
 */
function memberPasswordCheck(passwordInput){
	if(passwordInput.value.match(SPACE_REGULAR_EXPRESSTION)){
		$("#join_mb_password_ment_p").text("비밀번호는 공백 입력이 불가합니다.").css("color","red");
	}else{
		if(!getRegExpResult(PW_REGULAR_EXPRESSTION,passwordInput.value)){
			$("#join_mb_password_ment_p").text("비밀번호 입력 형식이 바르지 않습니다").css("color","red");
		}else{
			$("#join_mb_password_ment_p").text("사용 가능한 비밀번호 입니다.").css("color","grey");
		}
	}
}
/*
 * 비밀번호 확인 체크
 */
function memberPasswordConfirmCheck(passwordConfirmInput){
	if($("input#mb_password_tmp").val() != $("input#mb_password_confirm_tmp").val()){
		$("#join_mb_password_confirm_ment_p").text("비밀번호와 비밀번호 확인이 일치 하지 않습니니다").css("color","red");
	}else{
		$("#join_mb_password_confirm_ment_p").text("비밀번호 확인 완료").css("color","grey");
	}
}
/*
 * 이름 체크
 */
function memberNameCheck(nameInput){
	if(nameInput.value.match(SPACE_REGULAR_EXPRESSTION)){
		$("#join_mb_name_ment_p").text("이름은 공백 입력이 불가 합니다.").css("color","red");
	}else{
		if(!getRegExpResult(NAME_REGULAR_EXPRESSTION,nameInput.value)){
			$("#join_mb_name_ment_p").text("이름 입력 형식이 바르지 않습니다.").css("color","red");
		}else{
			$("#join_mb_name_ment_p").text("이름 입력 완료").css("color","grey");
		}
	}
}
/*
 * 닉네임 체크
 */
function memberNickNameCheck(){
	
	if($("input[name=mb_nickname]").val().match(SPACE_REGULAR_EXPRESSTION)){
		$("#join_mb_nickname_ment_p").text("닉네임은 공백입력이 되지 않습니다.").css("color","red");
	}else{
		if(!getRegExpResult(NICKNAME_REGULAR_EXPRESSTION,$("input[name=mb_nickname]").val()) ){
			$("#join_mb_nickname_ment_p").text("닉네임 입력이 바르지 않습니다.").css("color","red");
		}else{
			$.ajax({
				type : "POST"
				,url : "/auth/checkMemberNickNameAjax.do"
				,data : {
					"mb_nickname" : $("input[name=mb_nickname]").val()
				}
				,dataType : "json"
				//로그인 인터셉터시
				//,beforeSend : function(xmlHttpRequest){
				//xmlHttpRequest.setRequestHeader("AJAX", "true");
				//}
				,async : false
				,success : function(result, status, xhr) {
					if(result.result == AJAX_RESULT_SUCCESS){
						$("#join_mb_nickname_ment_p").text("사용가능한 닉네임 입니다").css("color","grey");
						$("input#telno2").focus();
					}else{
						$("#join_mb_nickname_ment_p").text("이미 존재 하는 닉네임 입니다.").css("color","red");
						$("input[name=mb_nickname]").blur();
					}
				}
				,error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
			
		}
	} 
}
/*
 * 이메일 셀렉트박스 이벤트
 */
function setMailForm(obj){
	$("#mail2").val(obj.value);
}

/*
 * 구매자 전제 입력 폼 체크
 */
function joinFormValidationCheckBuyType(){
	
	if(isNull($("input#mb_password_tmp").val())){
		$("#join_mb_password_ment_p").text("비밀번호가 입력되지 않았습니다.").css("color","red");
		defaultAlert("비밀번호가 입력되지 않았습니다.");
		return false;
	}else{
		if($("input#mb_password_tmp").val().match(SPACE_REGULAR_EXPRESSTION)){
			$("#join_mb_password_ment_p").text("비밀번호는 공백 입력이 불가합니다.").css("color","red");
			defaultAlert("비밀번호는 공백 입력이 불가합니다.");
			return false;
		}else{
			if(!getRegExpResult(PW_REGULAR_EXPRESSTION,$("input#mb_password_tmp").val())){
				$("#join_mb_password_ment_p").text("비밀번호 입력 형식이 바르지 않습니다").css("color","red");
				defaultAlert("비밀번호 입력 형식이 바르지 않습니다");
				return false;
			}
		}
	}
	
	if(isNull($("input#mb_password_confirm_tmp").val())){
		$("#join_mb_password_confirm_ment_p").text("비밀번호 확인이 입력되지 않았습니다.").css("color","red");
		defaultAlert("비밀번호 확인이 입력되지 않았습니다.");
		
		return false;
	}else{
		if($("input#mb_password_tmp").val() != $("input#mb_password_confirm_tmp").val()){
			$("#join_mb_password_confirm_ment_p").text("비밀번호와 비밀번호 확인이 일치 하지 않습니니다").css("color","red");
			defaultAlert("비밀번호와 비밀번호 확인이 일치 하지 않습니니다");
			return false;
		}
	}
	
	if(isNull($("input[name=mb_name]").val())){
		$("#join_mb_name_ment_p").text("이름이 입력되지 않았습니다.").css("color","red");
		defaultAlert("이름이 입력되지 않았습니다.");
		return false;
	}else{
		if($("input[name=mb_name]").val().match(SPACE_REGULAR_EXPRESSTION)){
			$("#join_mb_name_ment_p").text("이름은 공백 입력이 불가합니다.").css("color","red");
			defaultAlert("이름은 공백 입력이 불가합니다.");
			return false;
		}else{
			if(!getRegExpResult(NAME_REGULAR_EXPRESSTION,$("input[name=mb_name]").val())){
				("#join_mb_name_ment_p").text("이름 입력 형식이 바르지 않습니다.").css("color","red");
				defaultAlert("이름 입력 형식이 바르지 않습니다.");
				return false;
			}
		}
	}
	if(isNull($("input[name=mb_nickname]").val())){
		$("#join_mb_nickname_ment_p").text("닉네임이 입력되지 않았습니다.").css("color","red");
		defaultAlert("닉네임이 입력되지 않았습니다.");
		return false;
	}
	
	//기본 값 셋팅 되어 있음
	if(!getRegExpResult(BIRTH_REGULAR_EXPRESSTION,$("select#birth_year").val() + $("select#birth_month").val() + $("select#birth_day").val())){
		$("#join_mb_birthday_ment_p").text("생년월일 입력 형식이 바르지 않습니다.").css("color","red");
		defaultAlert("생년월일 입력 형식이 바르지 않습니다.");
		return false;
	}else{
		$("input[name=mb_birthday]").val($("select#birth_year").val() + $("select#birth_month").val() + $("select#birth_day").val());
	}
	
	//필수 요구 사항이 아니기때문에 입력된 경우에만 체크
	if(!isNull($("input#telno2").val()) || !isNull($("input#telno3").val())){
		var tel = $("select#telno1").val() + "-" + $("input#telno2").val() + "-" + $("input#telno3").val();
		if(!getRegExpResult(TEL_REGULAR_EXPRESSTION,tel)){
			$("#join_mb_tel_ment_p").text("전화번호 입력이 완료되지 않았습니다.").css("color","red");
			defaultAlert("전화번호 입력이 완료되지 않았습니다.");
			return false;
		}else{
			$("input[name=mb_tel]").val($("select#telno1").val() + "-" + $("input#telno2").val() + "-" + $("input#telno3").val());
		}
	}
	
	if(isNull($("input#mtelno2").val()) || isNull($("input#mtelno3").val())){
		$("#join_mb_hp_ment_p").text("휴대폰 번호 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("휴대폰 번호 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(HP_REGULAR_EXPRESSTION,$("select#mtelno1").val() + "-" + $("input#mtelno2").val() + "-" + $("input#mtelno3").val())){
			$("#join_mb_hp_ment_p").text("휴대폰 번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("휴대폰 번호 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_hp]").val($("select#mtelno1").val() + "-" + $("input#mtelno2").val() + "-" +  $("input#mtelno3").val());
		}
	}
	
	if(isNull($("input#mail1").val()) || isNull($("input#mail2").val())){
		console.log("입력 안댐");
		$("#join_mb_email_ment_p").text("이메일 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("이메일 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(EMAIL_REGULAR_EXPRESSTION,$("input#mail1").val() + "@" + $("input#mail2").val())){
			$("#join_mb_email_ment_p").text("이메일 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("이메일 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_email]").val($("input#mail1").val() + "@" + $("input#mail2").val());
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_biz_name]").val())){
		if(!getRegExpResult(BIZNAME_REGULAR_EXPRESSTION,$("input[name=mb_biz_name]").val())){
			$("#join_mb_biz_name_ment_p").text("상호명 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("상호명 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_biz_ceo_name]").val())){
		if(!getRegExpResult(BIZCEONAME_REGULAR_EXPRESSTION,$("input[name=mb_biz_ceo_name]").val())){
			$("#join_mb_biz_ceo_name_ment_p").text("대표자명 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("대표자명 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input#mb_biz_no_1").val()) || !isNull($("input#mb_biz_no_2").val()) || !isNull($("input#mb_biz_no_3").val())){
		var bizNo = $("input#mb_biz_no_1").val() + "-" + $("input#mb_biz_no_2").val() + "-" + $("input#mb_biz_no_3").val();
		if(!getRegExpResult(BIZNO_REGULAR_EXPRESSTION,bizNo)){
			$("#join_mb_biz_no_ment_p").text("사업자 등록번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업자 등록번호 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_biz_no]").val(bizNo);
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input#bizTelno2").val()) || !isNull($("input#bizTelno3").val())){
		if(!getRegExpResult(BIZTELNO_REGULAR_EXPRESSTION,$("select#bizTelno1").val() + "-" + $("input#bizTelno2").val() + "-" + $("input#bizTelno3").val())){
			$("#join_mb_biz_tel_ment_p").text("사업장 전화 번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 전화 번호 번호 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_biz_tel]").val($("select#bizTelno1").val() + "-" + $("input#bizTelno2").val() + "-" + $("input#bizTelno3").val());
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_biz_zip_code]").val())){
		if(!getRegExpResult(ZIPCODE_REGULAR_EXPRESSTION,$("input[name=mb_biz_zip_code]").val())){
			$("#join_mb_biz_address_ment_p").text("사업장 주소 우편번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 주소 우편번호 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_biz_address]").val())){
		if(!getRegExpResult(ADDRESS_REGULAR_EXPRESSTION,$("input[name=mb_biz_address]").val())){
			$("#join_mb_biz_address_ment_p").text("사업장 기본 주소 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 기본 주소 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_biz_address_detail]").val())){
		if(!getRegExpResult(ADDRESS_DETAIL_REGULAR_EXPRESSTION,$("input[name=mb_biz_address_detail]").val())){
			$("#join_mb_biz_address_ment_p").text("사업장 기본 주소 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 기본 주소 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_biz_code]").val() != "")){
		if(!getRegExpResult(SELLCODE_REGULAR_EXPRESSTION,$("input[name=mb_biz_code]").val())){
			$("#join_mb_biz_code_ment_p").text("P코드, 대리점코드 입력이 바르지 않습니다.").css("color","red");
			defaultAlert("P코드, 대리점코드 입력이 바르지 않습니다.");
			return false;
		}
	}
	
	//입력된 경우만 체크
	if(!isNull($("input[name=mb_recomm_id]").val())){
		if($("input[name=mb_recomm_id]").val().match(SPACE_REGULAR_EXPRESSTION)){
			$("#join_mb_recomm_id_ment_p").text("추천인 아이디는 공백 입력이 불가 합니다.").css("color","red");
			defaultAlert("추천인 아이디는 공백 입력이 불가 합니다.");
			return false;
		}else{
			if(!getRegExpResult(ID_REGULAR_EXPRESSTION,$("input[name=mb_recomm_id]").val())){
				$("#join_mb_recomm_id_ment_p").text("추천인 아이디 입력 형식이 바르지 않습니다.").css("color","red");
				defaultAlert("추천인 아이디 입력 형식이 바르지 않습니다.");
				return false;
			}
		}
	}
	
	return true;
}

/*
 * 판매자 전제 입력 폼 체크
 */
function joinFormValidationCheckSellerType(){
	
	
	if(isNull($("input#mb_password_tmp").val())){
		$("#join_mb_password_ment_p").text("비밀번호가 입력되지 않았습니다.").css("color","red");
		defaultAlert("비밀번호가 입력되지 않았습니다.");
		return false;
	}else{
		if($("input#mb_password_tmp").val().match(SPACE_REGULAR_EXPRESSTION)){
			$("#join_mb_password_ment_p").text("비밀번호는 공백 입력이 불가합니다.").css("color","red");
			defaultAlert("비밀번호는 공백 입력이 불가합니다.");
			return false;
		}else{
			if(!getRegExpResult(PW_REGULAR_EXPRESSTION,$("input#mb_password_tmp").val())){
				$("#join_mb_password_ment_p").text("비밀번호 입력 형식이 바르지 않습니다").css("color","red");
				defaultAlert("비밀번호 입력 형식이 바르지 않습니다");
				return false;
			}
		}
	}
	
	if(isNull($("input#mb_password_confirm_tmp").val())){
		$("#join_mb_password_confirm_ment_p").text("비밀번호 확인이 입력되지 않았습니다.").css("color","red");
		defaultAlert("비밀번호 확인이 입력되지 않았습니다.");
		return false;
	}else{
		if($("input#mb_password_tmp").val() != $("input#mb_password_confirm_tmp").val()){
			$("#join_mb_password_confirm_ment_p").text("비밀번호와 비밀번호 확인이 일치 하지 않습니니다").css("color","red");
			defaultAlert("비밀번호와 비밀번호 확인이 일치 하지 않습니니다");
			return false;
		}
	}
	
	if(isNull($("input[name=mb_name]").val())){
		$("#join_mb_name_ment_p").text("이름이 입력되지 않았습니다.").css("color","red");
		defaultAlert("이름이 입력되지 않았습니다.");
		return false;
	}else{
		if($("input[name=mb_name]").val().match(SPACE_REGULAR_EXPRESSTION)){
			$("#join_mb_name_ment_p").text("이름은 공백 입력이 불가합니다.").css("color","red");
			defaultAlert("이름은 공백 입력이 불가합니다.");
			return false;
		}else{
			if(!getRegExpResult(NAME_REGULAR_EXPRESSTION,$("input[name=mb_name]").val())){
				$("#join_mb_name_ment_p").text("이름 입력 형식이 바르지 않습니다.").css("color","red");
				defaultAlert("이름 입력 형식이 바르지 않습니다.");
				return false;
			}
		}
	}
	
	if(isNull($("input[name=mb_nickname]").val())){
		$("#join_mb_nickname_ment_p").text("닉네임이 입력되지 않았습니다.").css("color","red");
		defaultAlert("닉네임이 입력되지 않았습니다.");
		return false;
	}
	
	//기본 값 셋팅 되어 있음
	if(!getRegExpResult(BIRTH_REGULAR_EXPRESSTION,$("select#birth_year").val() + $("select#birth_month").val() + $("select#birth_day").val())){
		$("#join_mb_birthday_ment_p").text("생년월일 입력 형식이 바르지 않습니다.").css("color","red");
		defaultAlert("생년월일 입력 형식이 바르지 않습니다.");
		return false;
	}else{
		$("input[name=mb_birthday]").val($("select#birth_year").val() + $("select#birth_month").val() + $("select#birth_day").val());
	}
	
	//필수 요구 사항이 아니기때문에 입력된 경우에만 체크
	if(!isNull($("input#telno2").val()) || !isNull($("input#telno3").val())){
		var tel = $("select#telno1").val() + "-" + $("input#telno2").val() + "-" + $("input#telno3").val();
		if(!getRegExpResult(TEL_REGULAR_EXPRESSTION,tel)){
			$("#join_mb_tel_ment_p").text("전화번호 입력이 완료되지 않았습니다.").css("color","red");
			defaultAlert("전화번호 입력이 완료되지 않았습니다.");
			return false;
		}else{
			$("input[name=mb_tel]").val($("select#telno1").val() + "-" + $("input#telno2").val() + "-" + $("input#telno3").val());
		}
	}
	
	if(isNull($("input#mtelno2").val()) || isNull($("input#mtelno3").val())){
		$("#join_mb_hp_ment_p").text("휴대폰 번호 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("휴대폰 번호 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(HP_REGULAR_EXPRESSTION,$("select#mtelno1").val() + "-" + $("input#mtelno2").val() + "-" + $("input#mtelno3").val())){
			$("#join_mb_hp_ment_p").text("휴대폰 번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("휴대폰 번호 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_hp]").val($("select#mtelno1").val() + "-" + $("input#mtelno2").val() + "-" +  $("input#mtelno3").val());
		}
	}
	
	if(isNull($("input#mail1").val()) || isNull($("input#mail2").val())){
		$("#join_mb_email_ment_p").text("이메일 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("이메일 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(EMAIL_REGULAR_EXPRESSTION,$("input#mail1").val() + "@" + $("input#mail2").val())){
			$("#join_mb_email_ment_p").text("이메일 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("이메일 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_email]").val($("input#mail1").val() + "@" + $("input#mail2").val());
		}
	}
	
	//필수 입력
	if(isNull($("input[name=mb_biz_name]").val())){
		$("#join_mb_biz_name_ment_p").text("상호명 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("상호명 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(BIZNAME_REGULAR_EXPRESSTION,$("input[name=mb_biz_name]").val())){
			$("#join_mb_biz_name_ment_p").text("상호명 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("상호명 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	if(isNull($("input[name=mb_biz_ceo_name]").val())){
		$("#join_mb_biz_ceo_name_ment_p").text("대표자명 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("대표자명 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(BIZCEONAME_REGULAR_EXPRESSTION,$("input[name=mb_biz_ceo_name]").val())){
			$("#join_mb_biz_ceo_name_ment_p").text("대표자명 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("대표자명 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//사업자 등록번호 입력칸 3개중 한개라도 미입력시 체크
	if(isNull($("input#mb_biz_no_1").val()) || isNull($("input#mb_biz_no_2").val()) || isNull($("input#mb_biz_no_3").val())){
		$("#join_mb_biz_no_ment_p").text("사업자 등록번호 입력이 완료 되지 않았습니다.").css("color","red");
		defaultAlert("사업자 등록번호 입력이 완료 되지 않았습니다.");
		return false;
	}else{
		var bizNo = $("input#mb_biz_no_1").val() + "-" + $("input#mb_biz_no_2").val() + "-" + $("input#mb_biz_no_3").val();
		if(!getRegExpResult(BIZNO_REGULAR_EXPRESSTION,bizNo)){
			$("#join_mb_biz_no_ment_p").text("사업자 등록번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업자 등록번호 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_biz_no]").val(bizNo);
		}
	}
	
	//사업장전화번호 입력한 2개중 한개라도 미입력시 체크
	if(isNull($("input#bizTelno2").val()) || isNull($("input#bizTelno3").val())){
		$("#join_mb_biz_tel_ment_p").text("사업장 전화 번호 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("사업장 전화 번호 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(BIZTELNO_REGULAR_EXPRESSTION,$("select#bizTelno1").val() + "-" + $("input#bizTelno2").val() + "-" + $("input#bizTelno3").val())){
			$("#join_mb_biz_tel_ment_p").text("사업장 전화 번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 전화 번호 번호 입력 형식이 바르지 않습니다.");
			return false;
		}else{
			$("input[name=mb_biz_tel]").val($("select#bizTelno1").val() + "-" + $("input#bizTelno2").val() + "-" + $("input#bizTelno3").val());
		}
	}
	
	//필수 입력
	if(isNull($("input[name=mb_biz_zip_code]").val())){
		$("#join_mb_biz_address_ment_p").text("사업장 주소 우편번호 입력이 완료 되지 않았습니다.").css("color","red");
		defaultAlert("사업장 주소 우편번호 입력이 완료 되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(ZIPCODE_REGULAR_EXPRESSTION,$("input[name=mb_biz_zip_code]").val())){
			$("#join_mb_biz_address_ment_p").text("사업장 주소 우편번호 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 주소 우편번호 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//필수 입력
	if(isNull($("input[name=mb_biz_address]").val())){
		$("#join_mb_biz_address_ment_p").text("사업장 기본 주소 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("사업장 기본 주소 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(ADDRESS_REGULAR_EXPRESSTION,$("input[name=mb_biz_address]").val())){
			$("#join_mb_biz_address_ment_p").text("사업장 기본 주소 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 기본 주소 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	//필수 입력
	if(isNull($("input[name=mb_biz_address_detail]").val())){
		$("#join_mb_biz_address_ment_p").text("사업장 기본 주소 입력이 완료되지 않았습니다.").css("color","red");
		defaultAlert("사업장 상세 주소 입력이 완료되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(ADDRESS_DETAIL_REGULAR_EXPRESSTION,$("input[name=mb_biz_address_detail]").val())){
			$("#join_mb_biz_address_ment_p").text("사업장 기본 주소 입력 형식이 바르지 않습니다.").css("color","red");
			defaultAlert("사업장 상세 주소 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	return true;
}

function memberJoin(){
	console.log("memberJoin()....");
	var validationCheckResult;
	if($("input[name=mb_type]:checked").val() == "1"){
		validationCheckResult = joinFormValidationCheckBuyType();
	}else{
		validationCheckResult = joinFormValidationCheckSellerType();
	}
	if(validationCheckResult){
		
		$.ajax({
			type : "POST"
			,url : "/auth/getRsaPublicKey.do"
			,data : null
			,dataType : "json"
			,async : true
			,success : function(result, status, xhr) {
				
				if(result.result == AJAX_RESULT_SUCCESS){
					
					var rsa = new RSAKey();
					rsa.setPublic(result.RSAModulus,result.RSAExponent);
					
					$("input[name=mb_password]").val(rsa.encrypt($("input#mb_password_tmp").val()));
					
					var param = $("#memberJoinForm").serialize();
					
					$.ajax({
						type : "POST"
						,url : "/auth/memberJoinAjax.do"
						,data : param
						,dataType : "json"
						,async : true
						,success : function(result, status, xhr) {
							console.log("회원가입 버튼클릭서버 리턴 결과");
							console.log(result);
							if(result.result == AJAX_RESULT_SUCCESS){
								defaultAlert("회원 가입이 완료 되었습니다. 로그인 페이지로 이동 합니다.",null,function(){
									location.href = "/auth/login.do";
								});
							}else{
								$("input[name=mb_password]").val('');
								$("input#mb_password_temp").val('');
								$("input#mb_password_confirm_temp").val('');
								
								if(result.data == "2"){
									$("#join_mb_id_ment_p").text("아이디 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("아이디 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "3"){
									$("#join_mb_id_ment_p").text("이미 존재 하는 아이디 입니다.").css("color","red");
									defaultAlert("이미 존재 하는 아이디 입니다.");
									return;
								}else if(result.data == "4"){
									$("#join_mb_password_ment_p").text("비밀번호 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("비밀번호 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "5"){
									$("#join_mb_name_ment_p").text("이름 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("이름 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "6"){
									$("#join_mb_nickname_ment_p").text("닉네임 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("닉네임 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "7"){
									$("#join_mb_nickname_ment_p").text("이미 존재하는 닉네임 입니다.").css("color","red");
									defaultAlert("이미 존재하는 닉네임 입니다.");
									return;
								}else if(result.data == "10"){
									$("#join_mb_tel_ment_p").text("전화번호 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("전화번호 입력이 바르지 않습니다.");
								}else if(result.data == "11"){
									$("#join_mb_hp_ment_p").text("휴대폰 번호 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("휴대폰 번호 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "12"){
									$("#join_mb_email_ment_p").text("이메일 입력 형식이 바르지 않습니다.").css("color","red");
									defaultAlert("이메일 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "13"){
									$("#join_mb_addresss_ment_p").text("주소 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("주소 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "14"){
									$("#join_mb_biz_name_ment_p").text("상호 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("상호 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "15"){
									$("#join_mb_biz_ceo_name_ment_p").text("대표자명 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("대표자명 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "16"){
									$("#join_mb_biz_no_ment_p").text("사업자 등록번호 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("사업자 등록번호 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "17"){
									$("#join_mb_biz_tel_ment_p").text("사업장 전화 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("사업장 전화 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "18" || result.data == "19" || result.data == "20"){
									$("#join_mb_addresss_ment_p").text("사업장 주소 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("사업장 주소 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "22"){
									$("#join_mb_biz_code_ment_p").text("P코드, 대리점 코드 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("P코드, 대리점 코드 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "23"){
									$("#join_mb_recomm_id_ment_p").text("추천인 아이디 입력이 바르지 않습니다.").css("color","red");
									defaultAlert("추천인 아이디 입력이 바르지 않습니다.");
									return;
								}else if(result.data == "26"){
									$("#join_mb_hp_ment_p").text("이미 가입된 휴대폰 번호 입니다.").css("color","red");
									defaultAlert("이미 가입된 휴대폰 번호 입니다.");
									return;
								}else if(result.data == "27"){
									$("#join_mb_email_ment_p").text("이미 가입된 이메일 입니다.").css("color","red");
									defaultAlert("이미 가입된 이메일 입니다.");
									return;
								}else{
									defaultAlert("잘못 된 요청입니다.",null,function(){
										location.href = "/main.do";
									});
								}
								
							}
						}
						,error : function(jqXHR, textStatus, errorThrown) {
							$("input[name=mb_password]").val('');
							$("input#mb_password_temp").val('');
							$("input#mb_password_confirm_temp").val('');
							console.log(jqXHR);
							console.log(textStatus);
							console.log(errorThrown);
						}
					});
					
				}else{
					defaultAlert("데이터 복호화중 오류가 발생 했습니다.");
					$("input[name=mb_password]").val('');
					$("input#mb_password_temp").val('');
					$("input#mb_password_confirm_temp").val('');
				}
			}
			,error : function(jqXHR, textStatus, errorThrown) {
				$("input[name=mb_password]").val('');
				$("input#mb_password_temp").val('');
				$("input#mb_password_confirm_temp").val('');
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	
	}
}

/**
 * 회원 가입 테스트시 입력폼 임시 데이터 자동완성용
 * @returns
 */
function setTestDefaultInputData(){
	$("input[name=mb_id]").val("nerobong3");
	$("input#mb_password_tmp").val("rnrnrnrn12@");
	$("input#mb_password_confirm_tmp").val("rnrnrnrn12@");
	$("input[name=mb_name]").val("김태경");
	$("input[name=mb_nickname]").val("닉넴3");
	$("#telno2").val("1234");
	$("#telno3").val("1234");
	$("#mtelno2").val("1234");
	$("#mtelno3").val("1234");
	$("#mail1").val("nerobong2");
	$("#mail2").val("gmail.com");
	$("input[name=mb_zip_code]").val("06113");
	$("input[name=mb_address]").val("서울특별시 강남구 학동로12길 15");
	$("input[name=mb_address_detail]").val("202호");
	$("input[name=mb_biz_name]").val("상호명");
	$("input[name=mb_biz_ceo_name]").val("김대표");
	$("input[name=mb_biz_name]").val("상호명");
	$("#mb_biz_no_1").val("123");
	$("#mb_biz_no_2").val("12");
	$("#mb_biz_no_3").val("12345");
	$("#bizTelno2").val("1234");
	$("#bizTelno3").val("1234");
	$("input[name=mb_biz_zip_code]").val("06098");
	$("input[name=mb_biz_address]").val("서울특별시 강남구 언주로130길 35");
	$("input[name=mb_biz_address_detail]").val("6층");
	$("input[name=mb_biz_code]").val("code");
	$("input[name=mb_recomm_id]").val("reommid");
	
}
