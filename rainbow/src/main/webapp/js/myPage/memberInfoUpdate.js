/**
 * 
 */
$(document).ready(function(){
	
});

/*
 * 아이디 입력 폼 기본 설명 텍스트 셋팅
 */
function setDefaultInputMent(elementId,ment){
	$("#" + elementId).text(ment).css("color","grey");
}
/*
 * 이메일 셀렉트박스 이벤트
 */
function setMailForm(obj){
	$("input#mail2").val(obj.value);
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

function memberInfoUpdate(){
	
	if(isNull($("input#mb_password_tmp").val())){
		defaultAlert("비밀번호가 입력되지 않았습니다.");
		return;
	}
	//비밀번호 확인
	if(!isNull($("input#new_mb_password_tmp").val()) || !isNull($("input#new_mb_password_confirm_tmp").val())){
		if(isNull($("input#new_mb_password_tmp").val())){
			defaultAlert("새로운 비밀번호가 입력되지 않았습니다.");
			return;
		}
		
		if(isNull($("input#new_mb_password_confirm_tmp").val())){
			defaultAlert("새로운 비밀번호 확인이 입력되지 않았습니다.");
			return;
		}
		
		if($("input#new_mb_password_tmp").val() != $("input#new_mb_password_confirm_tmp").val()){
			defaultAlert("새로운 비밀번호와 새로운 비밀번호 확인이 일치하지 않습니다.");
			return;
		}
	}
	//데이터 셋팅
	//이메일
	if(!isNull($("input#mail1").val()) &&  !isNull($("input#mail2").val())){
		$("input[name=mb_email").val($("input#mail1").val() + "@" + $("input#mail2").val());
	}else{
		defaultAlert("이메일 입력이 바르지 않습니다.");
		return;  
	}
	//전부 입력되었을때만 파라미터 셋팅
	if(!isNull($("select#telno1").val()) && !isNull($("input#telno2").val()) && !isNull($("input#telno3").val())){
		$("input[name=mb_tel]").val($("select#telno1").val() + "-" + $("input#telno2").val() + "-" + $("input#telno3").val());
	}
	
	if(!isNull($("select#bizTelno1").val()) && !isNull($("input#bizTelno2").val()) && !isNull($("input#bizTelno3").val())){
		$("input[name=mb_biz_tel]").val($("select#bizTelno1").val() + "-" + $("input#bizTelno2").val() + "-" + $("input#bizTelno3").val());
	}else{
		//사업자 회원의 경우 필수 입력값이기때문에 체크
		if($("input[name=mb_type]").val() == "2"){
			defaultAlert("사업장전화 입력이 바르지 않습니다.");
			return;
		}
	}
	
	if(!isNull($("select#mtelno1").val()) && !isNull($("input#mtelno2").val()) && !isNull($("input#mtelno3").val())){
		$("input[name=mb_hp]").val($("select#mtelno1").val() + "-" + $("input#mtelno2").val() + "-" + $("input#mtelno3").val());
	}else{
		defaultAlert("휴대폰번호 입력이 바르지 않습니다.");
		return;
	}
	
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
				
				//입력된 비밀번호 rsa 암호화
				$("input[name=mb_password]").val(rsa.encrypt($("input#mb_password_tmp").val()));
				
				if(!isNull($("input#new_mb_password_tmp").val()) && !isNull($("input#new_mb_password_confirm_tmp").val())){
					$("input[name=new_mb_password]").val(rsa.encrypt($("input#new_mb_password_tmp").val()));
					$("input[name=new_mb_password_confirm]").val(rsa.encrypt($("input#new_mb_password_confirm_tmp").val()));
				}
				
				var param = $("#memberUpdateForm").serialize();
				
				$.ajax({
					type : "POST"
					,url : "/myPage/updateMemberInfoAjax.do"
					,data : param
					,dataType : "json"
					,async : true
					,success : function(result, status, xhr) {
						$("input[name=mb_password]").val("");
						$("input[name=mb_password_confirm]").val("");
						$("input[name=new_mb_password_confirm]").val("");
						$("input[name=mb_email]").val("");
						$("input[name=mb_tel]").val("");
						$("input[name=mb_hp]").val("");
						$("input[name=mb_biz_tel]").val("");
						if(result.result == AJAX_RESULT_SUCCESS){
							defaultAlert("회원 정보가 성공적으로 변경 되었습니다.",null,function(){
								window.location.reload();
							});
						}else{
							if(result.data == "1"){
								defaultAlert('아이디가 올바르지 않습니다.');
							}else if(result.data == "2"){
								defaultAlert('존재하지 않는 아이디 입니다.');
							}else if(result.data == "3" || result.data == "4" || result.data == "5" ){
								defaultAlert('비밀번호가 입력이 올바르지 않습니다.');
							}else if(result.data == "5"){
								defaultAlert('비밀번호가 입력이 올바르지 않습니다.');
							}else if(result.data == "6" ){
								defaultAlert('새로운 비밀번호 입력이 올바르지 않습니다.');
							}else if(result.data == "7"){
								defaultAlert('새로운 비밀번호 와 비밀번호 확인이 일치하지 않습니다.');
							}else if(result.data == "8"){
								defaultAlert('닉네임 입력이 올바르지 않습니다.');
							}else if(result.data == "9"){
								defaultAlert('이미 존재하는 닉네임 입니다.');
							}else if(result.data == "10"){
								defaultAlert('닉네임이 입력되지 않았습니다.');
							}else if(result.data == "11"){
								defaultAlert('이메일이 입력되지 않았습니다.');
							}else if(result.data == "12"){
								defaultAlert('이메일이 입력이 올바르지 않습니다.');
							}else if(result.data == "13"){
								defaultAlert('우편번호 입력이 올바르지 않습니다.');
							}else if(result.data == "14"){
								defaultAlert('전화번호 입력이 올바르지 않습니다.');
							}else if(result.data == "15" || result.data == "16"){
								defaultAlert('휴대폰번호 입력이 올바르지 않습니다.');
							}else if(result.data == "17" || result.data == "18"){
								defaultAlert('예금주 입력이 올바르지 않습니다.(한글 2~4자)');
							}else if(result.data == "19"){
								defaultAlert('계좌번호 입력이 올바르지 않습니다.(-를 제외한 숫자를 입력해주세요)');
							}else if(result.data == "20" || result.data == "21" || result.data == "22"){
								defaultAlert('사업장 전화 입력이 올바르지 않습니다.');
							}else if(result.data == "25"){
								defaultAlert('이미 가입된 이메일 입니다.');
							}else if(result.data == "26"){
								defaultAlert('이미 가입된 휴대폰 번호 입니다. ');
							}else{
								defaultAlert('회원정보 변경중 오류가 발생 하였습니다.',null,function(){
									window.location.reload();
								});
							}
						}
//						location.href ="/myPage/myPageMain.do";
					}
					,error : function(jqXHR, textStatus, errorThrown) {
						//가입 실패 원레 입력했던 패스워드 값으로 변경 하기.
						$("input[name=mb_password]").val("");
						$("input[name=mb_password_confirm]").val("");
						$("input[name=new_mb_password_confirm]").val("");
						$("input[name=mb_email]").val("");
						$("input[name=mb_tel]").val("");
						$("input[name=mb_hp]").val("");
						$("input[name=mb_biz_tel]").val("");
						if (jqXHR.status == 300) {
							defaultAlert("로그인이 필요합니다.",null,function(){
								location.href="/auth/login.do";
							});
						}
					}
				});
				
			}else{
				defaultAlert("데이터 복호화중 오류가 발생 했습니다.");
				$("input[name=mb_password]").val("");
				$("input[name=mb_password_confirm]").val("");
				$("input[name=new_mb_password_confirm]").val("");
				$("input[name=mb_email]").val("");
				$("input[name=mb_tel]").val("");
				$("input[name=mb_hp]").val("");
				$("input[name=mb_biz_tel]").val("");
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			defaultAlert("데이터 복호화중 오류가 발생 했습니다.");
		}
	});
	
	return;
}
