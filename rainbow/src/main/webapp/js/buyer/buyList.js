$(document).ready(function(){

	$("form#schFrm input").on("keypress", function(e){
		if(e.keyCode == 13){
			searchFormSubmit('schFrm');
		}
	});
});

/**
 * 옵션보기
 * @param obj
 * @param orderNo
 * @returns
 */
function viewOption(obj, orderNo){
	
	if($(obj).parent('div').find('table').css("display") == "none"){
		$.ajax({
	        type: "POST",
	        url: "/buyer/getOrderInfoOptionAjax.do",
	        data: {
	        	"order_no":orderNo
	        },
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		var optionList = result.optionList;
	        		
	        		var html = '';
	        		var itemName = '';
	        		var itemPrice = 0;
	        		
	        		$(optionList).each(function(){
	        			itemName = '';
	        			itemPrice = 0;
	        			if(this.IO_TYPE == "0"){
	        				itemName = this.ITEM_NAME == this.IO_NAME ? this.ITEM_NAME : this.ITEM_NAME + '/' + this.IO_NAME;
	            			itemPrice = (this.ITEM_PRICE + this.IO_PRICE) * this.CART_QTY;
	            		}else{
	            			itemName = this.IO_NAME;
	            			itemPrice = this.IO_PRICE * this.CART_QTY;
	            		}
	        			
	        			html += '<tr style="background-color:#fff;">';
	        			html += '	<td align="left" style="padding: 7px 5px 4px 5px; line-height: 14px;">'+itemName+'</td>';
	        			html += '	<td align="right" style="padding: 7px 5px 4px 5px; line-height: 14px;">'+this.CART_QTY+'개</td>';
	        			html += '	<td align="right" style="padding: 7px 5px 4px 5px; line-height: 14px;">'+$.number(itemPrice)+'원</td>';
	        			html += '</tr>';
	        		});
	        		
	        		$(obj).parent('div').find('tbody').html(html);
	        		$(obj).parent('div').find('table').css("display", "");
	        		
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
	}else{
		$(obj).parent('div').find('table').css("display", "none");
	}
}

/**
 * 주문취소
 * @param infoSeq
 * @param orderSeq
 * @param orderNo
 * @returns
 */
function cancelOrder(infoSeq, orderSeq, orderNo){
	defaultConfirm("주문을 취소하시겠습니까?", function(){
		$.ajax({
	        type: "POST",
	        url: "/buyer/cancelOrderAjax.do",
	        data: {
	        	"info_seq":infoSeq,
	        	"order_seq":orderSeq,
	        	"order_no":orderNo
	        },
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		location.reload();
	        	}else{
	        		defaultAlert(result.message);
	        		location.reload();
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	        	if(jqXHR.status == 300){
	        		defaultAlert("로그인이 필요합니다.!!");
	        	}else{
	        		defaultAlert("취소에 실패했습니다. 고객센터에 문의주세요.");
	        	}
	        }
	    });
	});
}

/**
 * 상품 반품/교환요청 취소
 * @param infoSeq
 * @param orderSeq
 * @param orderNo
 * @returns
 */
function cancelBackExchange(infoSeq, orderSeq, orderNo, orderState){
	
	defaultConfirm("반품/교환요청을 취소하시겠습니까?", function(){
		$.ajax({
	        type: "POST",
	        url: "/buyer/cancelBackExchangeAjax.do",
	        data: {
	        	"info_seq":infoSeq,
	        	"order_seq":orderSeq,
	        	"order_no":orderNo,
	        	"curr_order_state":orderState
	        },
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		location.reload();
	        	}else{
	        		defaultAlert(result.message);
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	        	if(jqXHR.status == 300){
	        		defaultAlert("로그인이 필요합니다.!!");
	        	}else{
	        		defaultAlert("취소에 실패했습니다. 고객센터에 문의주세요.");
	        	}
	        }
	    });
	});
}