/**
 * 
 */


function memberLeave(){
	
	defaultConfirm("정말 탈퇴하시겟습니까?", function(){
		if(leaveFormValidationCheck()){
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
						
						var param = $("#memberLeaveForm").serialize();
						
						$.ajax({
							type : "POST"
							,url : "/myPage/memberLeaveReqeustAjax.do"
							,data : param
							,dataType : "json"
							,async : true
							,success : function(result, status, xhr) {
								$("input[name=mb_password]").val("");
								if(result.result == AJAX_RESULT_SUCCESS){
									defaultAlert("회원 탈퇴가 정상적으로 처리되었습니다.",null,function(){
										location.href = "/main.do";
									});
								}else{
									if(result.data == "1"){
										defaultAlert("아이디 입력이 바르지 않습니다.");
									}else if(result.data == "2"){
										defaultAlert("아이디 입력이 바르지 않습니다.");
									}else if(result.data == "3"){
										defaultAlert("비밀번호 입력이 바르지 않습니다.");
									}else if(result.data == "4"){
										defaultAlert("비밀번호 입력이 바르지 않습니다.");
									}else if(result.data == "5"){
										defaultAlert("회원탈퇴중 오류가 발생하였습니다. 관리자에게 문의 하세요.");
									}else if(result.data == "6"){
										defaultAlert("패스워드가 일치하지 않습니다.");
									}else if(result.data == "7"){
										defaultAlert("회원탈퇴중 오류가 발생하였습니다. 관리자에게 문의 하세요.");
									}
								}
							}
							,error : function(jqXHR, textStatus, errorThrown) {
								$("input[name=mb_password]").val("");
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
					}
				}
				,error : function(jqXHR, textStatus, errorThrown) {
					defaultAlert("복호화중 오류가 발생하였습니다.");
					$("input[name=mb_password]").val("");
				}
			});
		}
	});
}

function leaveFormValidationCheck(){
	
	if(isNull($("input#mb_password_tmp").val())){
		defaultAlert("비밀번호가 입력되지 않았습니다.");
		return false;
	}else{
		if (!getRegExpResult(PW_REGULAR_EXPRESSTION, $("input#mb_password_tmp").val())) {
			defaultAlert("비밀번호 입력형식이 바르지 않습니다.");
			return false;
		}
	}
	
	if (!getRegExpResult(LEAVE_REASON_EXPRESSTION, $("input#mb_leave_reason").val())) {
		defaultAlert("탈퇴사유 입력형식이 바르지 않습니다.");
		return false;
	}
	return true;
}