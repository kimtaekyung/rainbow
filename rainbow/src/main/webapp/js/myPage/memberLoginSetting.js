/**
 * 
 */
$(document).ready(function(){

});
function disConnectSession(id){
	$.ajax({
		type : "POST"
		,url : "/myPage/deleteMemberSessionAjax.do"
		,data : {
			"mb_session_id" : id
		}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				defaultAlert("연결해제가 완료 되었습니다.",null,function(){
					window.location.reload();
				});
			}else{
				defaultAlert("연결해제중 오류가 발생 하였습니다.",null,function(){
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

function blockIpInputValue(){
	console.log($("input#blockIp").val());
	blockIp($("input#blockIp").val());
}


function blockIp(ip){
	$.ajax({
		type : "POST"
		,url : "/myPage/insertMemberBlockIpAjax.do"
		,data : {
			"mb_ip" : ip
		}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				defaultAlert("아이피 " + ip + "를 차단 하였습니다.",null,function(){
					window.location.reload();
				});
			}else{
				if(result.data == '1'){
					defaultAlert("아이피 차단중 오류가 발생 하였습니다.",null,function(){
						window.location.reload();
					});
				}else if(result.data == '2'){
					defaultAlert("아이피 차단중 오류가 발생 하였습니다.",null,function(){
						window.location.reload();
					});
				}else if(result.data == '3'){
					defaultAlert("이미 차단된 아이피 입니다.",null,function(){
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
}

function deleteBlockIp(mbi_seq){
	$.ajax({
		type : "POST"
		,url : "/myPage/deleteMemberBlockIpAjax.do"
		,data : {
			"mbi_seq" : mbi_seq
		}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				defaultAlert("아이피 차단내역을 삭제 하였습니다.",null,function(){
					window.location.reload();
				});
			}else{
				if(result.data == '1'){
					defaultAlert("아이피 차단내역을 삭제중 오류가 발생 하였습니다.",null,function(){
						window.location.reload();
					});
				}else if(result.data == '2'){
					defaultAlert("이미 삭제된 아이피 차단내역 입니다.",null,function(){
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
}