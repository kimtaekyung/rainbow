$(document).ready(function(){
	setSaveId();
});

function login(){
	
	if(loginFormValidationCheck()){
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
					
					var param = $("#memberLoginForm").serialize();
					$.ajax({
						type : "POST"
						,url : "/auth/memberLoginAjax.do"
						,data : param
						,dataType : "json"
						,async : true
						,success : function(result, status, xhr) {
							
							if(result.result == AJAX_RESULT_SUCCESS){
								
								if($("input#save").prop("checked")){
									var member = {
										"id" : 	$("input[name=mb_id]").val()
									}
									setLocalStorage("member",JSON.stringify(member));
								}else{
									removeLocalStorage("member");
								}
								
								if(!isNull($("#returnUrl").val())){
									if($("#returnUrl").val().indexOf("/auth/login.do") > -1
										|| $("#returnUrl").val().indexOf("/auth/join.do") > -1
										|| $("#returnUrl").val().indexOf("/auth/agreement.do") > -1){
										location.href = "/main.do";
									}else{
										location.href = $("#returnUrl").val();
									}
									
											
								}else{
									location.href = "/main.do";
								}
							}else{
								//가입 실패 원레 입력했던 패스워드 값으로 변경 하기.
								if(result.data == "1" || result.data == "3" || result.data == "4"){
									defaultAlert("아이디 또는 비빌번호 입력 형식이 바르지 않습니다.");
									$("input[name=mb_id]").val("");
									$("input[name=mb_password]").val("");
									$("input#mb_password_tmp").val("");
								}else if(result.data == "2"){
									defaultAlert("존재 하지 않는 아이디 입니다.");
									$("input[name=mb_id]").focus();
									$("input[name=mb_password]").val("");
									$("input#mb_password_tmp").val("");
								}else if(result.data == "5"){
									defaultAlert("알 수 없는 오류 입니다.");
									$("input[name=mb_id]").val("");
									$("input[name=mb_password]").val("");
									$("input#mb_password_tmp").val("");
									$("input[name=mb_member]").focus();
								}else if(result.data == "6"){
									defaultAlert("비밀번호가 일치하지 않습니다.");
									$("input[name=mb_password]").val("");
									$("input#mb_password_tmp").val("");
								}else if(result.data == "7"){
									defaultAlert("현재 아이피로는 로그인이 불가합니다.");
									$("input[name=mb_password]").val("");
									$("input#mb_password_tmp").val("");
									$("input[name=mb_member]").focus();
								}
									
							}
						}
						,error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR);
							console.log(textStatus);
							console.log(errorThrown);
							$("input[name=mb_password]").val("");
							$("input#mb_password_tmp").val("");
						}
					});
					
				}else{
					defaultAlert("데이터 복호화중 오류가 발생 했습니다.");
					$("input[name=mb_password]").val("");
					$("input#mb_password_tmp").val("");
				}
			}
			,error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
				$("input[name=mb_password]").val("");
				$("input#mb_password_tmp").val("");
			}
		});
	}
}

function loginFormValidationCheck(){
	
	if(isNull($("input[name=mb_id]").val())){
		defaultAlert("아이디가 입력되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(ID_REGULAR_EXPRESSTION,$("input[name=mb_id]").val())){
			defaultAlert("아이디가 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	
	if(isNull($("input#mb_password_tmp").val())){
		defaultAlert("비밀번호가 입력되지 않았습니다.");
		return false;
	}else{
		if(!getRegExpResult(PW_REGULAR_EXPRESSTION,$("input#mb_password_tmp").val())){
			defaultAlert("비밀번호 입력 형식이 바르지 않습니다");
			return false;
		}
	}
	return true;
}
//로컬스토리지에서 저장된 아이디를 가져온다.
function setSaveId(){
	var member = JSON.parse(getItemLocalStorage("member"));
	if(!isNull(member)){
		$("input#save").prop("checked",true);
		if(!isNull(member.id)){
			$("input[name=mb_id]").val(member.id);
		}
	}else{
		$("input#save").prop("checked",false);
	}
}


