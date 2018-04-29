/**
 * 
 */
$(document).ready(function(){
	
});


/**
 * 체크 박스 선택 삭제
 * @returns
 */
function updateLetterList(type){
	
	var letterSeqList = new Array();
	
	if($("input[name=rl_seq]:checked").length > 0){
		
		$("input[name=rl_seq]:checked").each(function(){
			letterSeqList.push(Number($(this).val()));
		});
		
		var str = type == "delete" ? "삭제" : "모두확인";
		
		
		
		defaultConfirm("선택된 "+letterSeqList.length+"개의 쪽지를 "+ str + " 하시겠습니까?", function(){
			var param = {
				"type" : type
				,"letterSeqList" : JSON.stringify(letterSeqList)
			}
			$.ajax({
				type : "POST"
				,url : "/myPage/updateLetterListAjax.do"
				,data : param
				,dataType : "json"
				,async : true
				,success : function(result, status, xhr) {
					if(result.result == AJAX_RESULT_SUCCESS){
						defaultAlert("쪽지를 " + str +" 하였습니다.",null,function(){
								window.location.reload();
						});
					}else{
						defaultAlert("잘못된 요청 입니다.",null,function(){
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
		});
	}else{
		defaultAlert("선택된 쪽지가 없습니다.");
		return;
	}
}


function letterView(rl_seq){
	$("form#letterListForm").append($("<input>").attr("name","rl_seq").attr("type","hidden").val(rl_seq));
	$("form#letterListForm").attr("action","/myPage/letterView.do");
	$("form#letterListForm").serialize();
	$("form#letterListForm").submit();
}
