/**
 * 
 */
$(document).ready(function(){
	//커밋 테스트
	//다른 아이디
	//2차커밋
	//회원가입 가입하기 버튼
	$("input[name=agree_check]").on("click",function(e){
		if($("input#input_sign_agree_check_1").prop("checked") && $("input#input_sign_agree_check_2").prop("checked")){
			$("#allCheck").prop("checked",true);
		}else{
			$("#allCheck").prop("checked",false);
		}
	});
	//회원가입 동의 페이지 동의 전체 선택
	$("input#allCheck").on("click",function(e){
		if($("#allCheck").prop("checked")) {  
			$("input[name=agree_check]").prop("checked",true); 
		}else{ 
			$("input[name=agree_check]").prop("checked",false); 
		} 
	});
});
/*
 * 약관동의 체크
 */
function allAgreeCheck(){
	if($("input#input_sign_agree_check_1").prop("checked") && $("input#input_sign_agree_check_2").prop("checked")){
		location.href = "/auth/join.do";
	}else{
		if(!$("input#input_sign_agree_check_1").prop("checked")){
			defaultAlert("RSHOP 이용약관 에 동의하지 않았습니다");
			return;
		}
		
		if(!$("input#input_sign_agree_check_2").prop("checked")){
			defaultAlert("개인정보 수집 및 이용목적 에 동의하지 않았습니다");
			return;
		}
	}
}
