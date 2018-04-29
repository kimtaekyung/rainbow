$(document).ready(function(){

});

//반품/교환요청 등록
function insertItemBackExchange(){
	
	if(isNull($("select[name=be_type]").val())){
		defaultAlert("요청분류를 선택해 주세요.");
		return;
	}
	if(isNull($("input[name=be_subject]").val())){
		defaultAlert("요청제목을 입력해 주세요.");
		return;
	}
	if(isNull($("textarea[name=be_content]").val())){
		defaultAlert("요청내용을 입력해 주세요.");
		return;
	}
	if(!isNull($("input[name=be_attach_img_path_1]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=be_attach_img_path_1]").val())){
			defaultAlert("첨부 이미지1은 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return;
		}
	}
	if(!isNull($("input[name=be_attach_img_path_2]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=be_attach_img_path_2]").val())){
			defaultAlert("첨부 이미지2은 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return;
		}
	}
	
	defaultConfirm("요청등록 하시겠습니까?", function(){
		var form = $('form[name=regFrm]')[0];
		var data = new FormData(form);
		
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/buyer/insertItemBackExchangeAjax.do",
	        data: data,
	        processData: false,
	        contentType: false,
	        cache: false,
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		defaultAlert(result.message,null,function(){
	        			location.href = "/buyer/buyList.do";
	        		});
	        	}else{
	        		defaultAlert(result.message,null,function(){
	        			location.href = "/buyer/buyList.do";
	        		});
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	        	if(jqXHR.status == 300){
	        		defaultAlert("로그인이 필요합니다.!!");
	        	}else{
	        		defaultAlert("고객센터에 문의주세요.");
	        	}
	        }
	    });
	});
	
}
