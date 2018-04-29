/**
 * 
 */
$(document).ready(function(){
	
});

function memberSettingInfoUpdate(){
	
	var param = $("#memberSerringUpdateForm").serialize();
	console.log(param);
	$.ajax({
		type : "POST"
		,url : "/myPage/updateMemberSettingAjax.do"
		,data : param
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				defaultAlert("개인환경 설정이 변경 되었습니다.",null,function(){
					window.location.reload();
				});
			}else{
				defaultAlert("개인환경 설정중 오류가 발생하였습니다.",null,function(){
					window.location.reload();
				});
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			if (jqXHR.status == 300) {
				defaultAlert("로그인이 필요합니다.",null,function(){
					location.href="/auth/login.do";
				});
			}
		}
	});
}