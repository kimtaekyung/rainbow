$(document).ready(function(){
	$("table#searchTbl").find("input").on('keypress', function(e){
		if(e.keyCode == 13){
			searchFormSubmit('schFrm');
			stopClickEventBubbling(e);
		}
	});
	
	$("input[name=order_qty]").numeric();
	$("input[name=order_price]").numeric();
});

/**
 * 주문내역 옵션보기
 * @param obj
 * @param orderNo
 * @returns
 */
function viewOption(obj, orderNo){
	
	if($(obj).parent('div').find('table').css("display") == "none"){
		$.ajax({
	        type: "POST",
	        url: "/seller/getOrderInfoOptionAjax.do",
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
	        			
	        			html += '<tr style="background-color: #fff;">';
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
 * 주문상태 변경
 * @param obj
 * @param infoSeq
 * @param orderSeq
 * @param orderNo
 * @returns
 */
function updateShopOrderState(obj, infoSeq, orderSeq, orderNo){
	//현재 상태와 동일한 상태인지 체크
	var currOrderState = $(obj).parent().find("input[name=curr_order_state]").val();
	var saveOrderState = $(obj).parent().find("select[name=save_order_state]").val();
	
	if(isNull(saveOrderState)){
		defaultAlert("변경할 상태를 선택해 주세요.");
		return;
	}
	if(currOrderState == saveOrderState){
		defaultAlert("현재 상태와 동일한 상태입니다.");
		return;
	}
	if(!getRegExpResult(NUMBER_EXPRESSION, saveOrderState)){
		defaultAlert("변경할 상태값이 올바르지 않습니다.");
		return;
	}
	
	defaultConfirm("상태를 변경하시겠습니까?", function(){
			
		$.ajax({
	        type: "POST",
	        url: "/seller/updateShopOrderStateAjax.do",
	        data: {
	        	"order_state":saveOrderState,
	        	"info_seq":infoSeq,
	        	"order_seq":orderSeq,
	        	"order_no":orderNo,
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
	        		defaultAlert("상태변경에 실패했습니다. 고객센터에 문의주세요.");
	        	}
	        }
	    });
	});
}