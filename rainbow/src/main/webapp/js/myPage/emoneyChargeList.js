/**
 * 
 */
$(document).ready(function(){
	
});
/**
 * 무통장 입금 대기 취소
 * @param cc_seq
 * @returns
 */
function cashChargeCancel(cc_seq){
	$.ajax({
		type : "POST"
		,url : "/myPage/cashChargeCancelAjax.do"
		,data : {
			"cc_seq" : cc_seq
		}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			console.log(result);
			if(result.result == AJAX_RESULT_SUCCESS){
				defaultAlert("이머니 충전 신청 내역이 취소 되었습니다.",null,function(){
					window.location.reload();
				});
			}else if(result.result == "1" || result.result == "2"){
				defaultAlert("잘못된 요청입니다.",null,function(){
					window.location.reload();
				});
			}else if(result.result == "3"){
				defaultAlert("변경에 실패 하였습니다. 관리자에 문의 하세요.",null,function(){
					window.location.reload();
				});
			}else if(result.result == "4"){
				defaultAlert("입금 대기 건에만 취소 가능 합니다.",null,function(){
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