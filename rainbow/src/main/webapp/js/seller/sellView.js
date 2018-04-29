$(document).ready(function(){
	
});

/**
 * 반품/교환요청에 대한 답변 저장
 * @returns
 */
function saveBackExchangeAnswer(){
	
	if(isNull($("textarea[name=be_answer]").val())){
		defaultAlert("답변내용을 입력해 주세요.");
		return;
	}
	
	defaultConfirm("답변을 등록하시겠습니까?", function(){
		$.ajax({
	        type: "POST",
	        url: "/seller/updateShopItemBackExchangeAnswerAjax.do",
	        data: {
	        	"be_seq":$("input[name=be_seq]").val(),
	        	"be_answer":$("textarea[name=be_answer]").val(),
	        	"order_state":$("select[name=order_state]").val(),
	        	"curr_order_state":$("input[name=curr_order_state]").val(),
	        	"info_seq":$("input[name=info_seq]").val(),
	        	"order_seq":$("input[name=order_seq]").val(),
	        	"order_no":$("input[name=order_no]").val()
	        },
	        dataType : "json",
			async : true,
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		defaultAlert(result.message,null,function(){
	        			location.reload();
					});
	        	}else{
	        		defaultAlert(result.message);
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

/**
 * 배송정보 저장
 * @returns
 */
function updateDeliveryInfo(){
	
	if(isNull($("select[name=delivery_company]").val())){
		defaultAlert("배송회사를 선택해주세요.");
		$("select[name=delivery_company]").focus();
		return;
	}
	
	if(isNull($("input[name=delivery_no]").val())){
		defaultAlert("송장번호를 입력해주세요.");
		$("input[name=delivery_no]").focus();
		return;
	}
	
	defaultConfirm("배송정보를 저장하시겠습니까?", function(){
		$.ajax({
	        type: "POST",
	        url: "/seller/updateDeliveryInfoAjax.do",
	        data: {
	        	"info_seq":$("input[name=info_seq]").val(),
	        	"order_seq":$("input[name=order_seq]").val(),
	        	"order_no":$("input[name=order_no]").val(),
	        	"delivery_company":$("select[name=delivery_company]").val(),
	        	"delivery_no":$("input[name=delivery_no]").val()
	        },
	        dataType : "json",
			async : true,
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		defaultAlert(result.message,null,function(){
	        			location.reload();
					});
	        	}else{
	        		defaultAlert(result.message);
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