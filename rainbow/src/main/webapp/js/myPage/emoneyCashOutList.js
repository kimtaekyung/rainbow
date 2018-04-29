/**
 * 
 */
$(document).ready(function(){
	
});

function cancelCashOut(co_seq){
	
	defaultConfirm("해당 출금 신청을 취소 하시겟습니까?", function(){
		$.ajax({
			type : "POST"
			,url : "/myPage/updateCashOutCancelAjax.do"
			,data : {
				"co_seq" : co_seq
			}
			,dataType : "json"
			,async : true
			,success : function(result, status, xhr) {
				if(result.result == AJAX_RESULT_SUCCESS){
					defaultAlert("출금 신청이 취소 되었습니다",null,function(){
						window.location.reload();
					});
				}else{
					if(result.data == "1"){
						defaultAlert("잘못된 요청 입니다.",null,function(){
							window.location.reload();
						});
					}else if(result.data == "2"){
						defaultAlert("잘못된 요청 입니다.",null,function(){
							window.location.reload();
						});
					}else if(result.data == "3"){
						defaultAlert(result.message,null,function(){
							window.location.reload();
						});
					}else if(result.data == "4"){
						defaultAlert("출금 신청 취소중 오류가 발생하였습니다. 관리자에 문의하세요",null,function(){
							window.location.reload();
						});
					}else if(result.data == "5"){
						defaultAlert("출금신청이 가능한 내역이 아닙니다.",null,function(){
							window.location.reload();
						});
					}
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
	});
}
