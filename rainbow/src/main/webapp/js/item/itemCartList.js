$(document).ready(function(){
});

//장바구니 삭제(그룹 또는 옵션일부)
function deleteShopCart(orderNo, cartSeq){
	
	defaultConfirm("삭제하시겠습니까?", function(){
		$.ajax({
			type: "POST",
			url: "/item/deleteShopCartAjax.do",
			data: {
				"order_no":orderNo,
				"cart_seq":cartSeq
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
					defaultAlert("고객센터에 문의주세요.");
				}
			}
		});
	});
}

//선택상품삭제 또는 전체상품삭제
//deleteType( S:선택삭제 A:전체삭제)
function checkDeleteShopCart(deleteType){
	
	var oderNoStr = "";
	if(deleteType == "S"){
		$("input[name=chk_cart").each(function(){
			if($(this).is(":checked")){
				if(isNull(oderNoStr)){
					oderNoStr = "'" + this.value + "'";
				}else{
					oderNoStr = oderNoStr + ",'" + this.value + "'";
				}
			}
		});
	}
	
	defaultConfirm("삭제하시겠습니까?", function(){
		$.ajax({
			type: "POST",
			url: "/item/deleteShopCartAllAjax.do",
			data: {
				"order_no_str":oderNoStr
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
					defaultAlert("고객센터에 문의주세요.");
				}
			}
		});
	});
}

//상품수량변경
function updateCartQty(obj, orderNo, cartSeq){
	var cartQty = $(obj).siblings("input[name=cart_qty]").val();
	if(isNull(cartQty)){
		defaultAlert("수량을 입력해 주세요");
		return;
	}
	
	if(Number(cartQty) < 1){
		defaultAlert("수량은 1개 이상 입력해주세요.");
		return;
	}
	
	$.ajax({
		type: "POST",
		url: "/item/updateShopCartQtyAjax.do",
		data: {
			"order_no":orderNo,
			"cart_seq":cartSeq,
			"cart_qty":cartQty
		},
		success: function(result, status, xhr){
			if(result.result == AJAX_RESULT_SUCCESS){
				location.reload();
			}else{
				$("div#lOptQty").css("display","none");
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
}

//옵션 및 수량 수정 레이어 팝업
function optionLayer(orderNo, itemSeq){
	$.ajax({
		type: "POST",
		url: "/item/itemOptionLayer.do",
		data: {
			"order_no":orderNo,
			"item_seq":itemSeq
		},
		dataType: "html",
		success: function(result, status, xhr){
			$("div.frm").html(result);
			$("div#lOptQty").show();
//			if(result.result == AJAX_RESULT_SUCCESS){
//				location.reload();
//			}else{
//				defaultAlert(result.message);
//			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			if(jqXHR.status == 300){
				defaultAlert("로그인이 필요합니다.!!");
			}else{
				defaultAlert("고객센터에 문의주세요.");
			}
		}
	});
}


/**************************************************************
옵션 레이어 관련 함수
*****************************************************************/
//1차 또는 2차 옵션 하위 옵션목록 조회
function getItemOptionList(ioName, eqNum, optionLength){
	var itemSeq = $("input[name=item_seq]").val();
	
	$.ajax({
        type: "POST",
        url: "/item/getItemOptionListAjax.do",
        data: {
        	"item_seq":itemSeq,
        	"io_name":ioName
        },
        dataType : "json",
        cache: false,
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS && result.resultData != null && result.resultData.length > 0){
        		var html = '<option value="">선택</option>';
        		
        		$(result.resultData).each(function(){
        			if( (eqNum == 0 && optionLength == 2) || (eqNum == 1 && optionLength == 3) ){
        				html += '<option value="'+ioName+(this.IO_NAME.replace(ioName+"^", ""))+'" io_price="'+this.IO_PRICE+'" io_stock_qty="'+this.IO_STOCK_QTY+'">'+(this.IO_NAME.replace(ioName+"^", ""))+'(+'+$.number(this.IO_PRICE)+'원)('+(this.IO_STOCK_QTY > 0 ? this.IO_STOCK_QTY+'개':'품절')+')</option>';
        			}else{
        				html += '<option value="'+(this.IO_NAME.replace(ioName+"^", ""))+'" io_price="'+this.IO_PRICE+'" io_stock_qty="'+this.IO_STOCK_QTY+'">'+(this.IO_NAME.replace(ioName+"^", ""))+'</option>';
        			}
        		});
        		
        		$("select[name=select_option]:eq("+(eqNum+1)+")").html(html);
        		$("select[name=select_option]:eq("+(eqNum+1)+")").prop("disabled", false);
        	}
        },
        error: function(jqXHR, textStatus, errorThrown){
        	console.log("오류!! 개발자에게 문의바랍니다.");
        }
    });
}

//선택옵션 선택후
//--> 2차옵션 선택 또는 
//--> 수량 선택 입력칸 추가(동일한 옵션 선택시 추가하지 않음)
function changeSelectOption(obj, eqNum){
	//2차 옵션 존재여부 확인
	var optionLength = $("select[name=select_option]").length;
	if(optionLength == 1){
		addSelectOptionQty(obj);
	}else{
		var paramName = "";
		if(optionLength == 3 && eqNum == 1){
			var beforeOption = $("select[name=select_option]:eq("+(eqNum-1)+")").val();
			paramName = beforeOption+"^"+$(obj).val();
		}else{
			paramName = $(obj).val();
		}
		
		//마지막 옵션 선택일경우 수량 입력칸 추가
		if( (optionLength == 2 && eqNum == 1) || (optionLength == 3 && eqNum == 2) ){
			addSelectOptionQty(obj);
		}else{
			getItemOptionList(paramName, eqNum, optionLength);
		}
	}
}

//수량선택 추가
//동일한 옵션이 선택되어 있지 않을경우만 추가
//옵션에 대한 수량이 없을경우 추가하지 않음
function addSelectOptionQty(obj){
	
	var trLength = $("div#itemOptResult > table > tbody > tr").length;
	var optionQty = $(obj).find("option:selected").attr("io_stock_qty");
	var itemPrice = Number($("input[name=item_price]").val());
	var optionPrice = Number($(obj).find("option:selected").attr("io_price"));
	var optionType = 0;
	
	if($(obj).attr("name") == "select_option"){
		itemPrice = itemPrice + optionPrice;
		optionType = 0;
	}else{
		itemPrice = optionPrice;
		optionType = 1;
	}
	
	if($(obj).val() != null && $(obj).val() != "" && optionQty != "0"){
		
		var isDupOption = false;
		
		$("input[name=option_name]").each(function(){
			if($(obj).val() == this.value){
				isDupOption = true;
			}
		});
		
		//이미 추가되어 있는 옵션이 아닐경우 옵션 추가
		if(!isDupOption){
			var itemName = $("input[name=item_name]").val()
			var html = '';
			html += '<tr>';
			if(optionPrice > 0){
				html += '<th valign="middle">'+ (optionType == 0 ? itemName+'-':'') + $(obj).val() +'(+'+($.number(optionPrice))+')</th>';
			}else{
				html += '<th valign="middle">'+ (optionType == 0 ? itemName+'-':'') + $(obj).val() +'</th>';
			}
			html += '	<td valign="top" class="qty">';
			html += '		<div class="wrap">';
			html += '			<input type="hidden" name="option_type" value="'+optionType+'"/>';
			html += '			<input type="hidden" name="option_name" value="'+$(obj).val()+'"/>';
			html += '			<input type="hidden" name="option_price" value="'+optionPrice+'"/>';
			html += '			<input type="hidden" name="option_qty" value="'+optionQty+'"/>';
			html += '			<input type="text" name="option_order_qty" value="1">';
			html += '			<button class="btnUp" type="button" onclick="changeItemOptionOrderQty(this, \'+\');">+</button>';
			html += '			<button class="btnDown" type="button" onclick="changeItemOptionOrderQty(this, \'-\');">-</button>';
			html += '		</div>';
			html += '	</td>';
			html += '	<td valign="middle" class="amt">';
			html += '		<div class="wrap">';
			html += '			<button onclick="removeOptionQty(this);">X</button>';
			html += '		</div><span>'+$.number(itemPrice)+'</span>원';
			html += '	</td>';
			html += '</tr>';
			
			if(optionType == 0){
				$("div#itemOptResult > table > tbody").append(html);
			}else{
				$("div#itemOptResult > table > tfoot").append(html);
			}
			
			calculatePrice();	calculatePrice();	//상품전체 금액합계 계산
			$("div#lPayRes").show();
		}
	}
	
	$("input[name=option_order_qty]").numeric();
}


//상품수량변경
function changeItemOptionOrderQty(obj, type){
	var targetObj = $(obj).parent().find("input[name=option_order_qty]");
	var orderQty = Number($(targetObj).val());
	var itemPrice = Number($("input[name=item_price]").val());
	var itemQty = Number($(obj).parent().find("input[name=option_qty]").val());
	var optionPrice = Number($(obj).parent().find("input[name=option_price]").val());
	var optionType = $(obj).parent().find("input[name=option_type]").val();
	
	if(type == "+" && itemQty > orderQty){
		orderQty++;
	}else if(type == "-" && orderQty > 1){
		orderQty--;
	}
	
	$(targetObj).val(orderQty);
	if(optionType == 0){
		$(obj).parents("tr:first").find("td.amt > span").text($.number((itemPrice+optionPrice)*orderQty));
	}else{
		$(obj).parents("tr:first").find("td.amt > span").text($.number(optionPrice*orderQty));
	}
	
	calculatePrice();	//상품전체 금액합계 계산
}

//옵션수량 입력필드 삭제
function removeOptionQty(obj){
	$(obj).parents("tr:first").remove();
	
	var optionTrLength = $("div#itemOptResult > table > tbody > tr").length;
	if(optionTrLength == 0){
		$("select[name=select_option]").val("");
		$("select[name=add_option]").val("");
		if($("select[name=select_option]:eq(1)").length > 0){
			$("select[name=select_option]:eq(1)").prop("disabled", true);
		}
		if($("select[name=select_option]:eq(2)").length > 0){
			$("select[name=select_option]:eq(2)").prop("disabled", true);
		}
		$("div#lPayRes").hide();
	}else{
		calculatePrice();	calculatePrice();	//상품전체 금액합계 계산
	}
}

//상품옵션선택 및 수량변경시 금액계산
function calculatePrice(){
	var itemPrice = $("input[name=item_price]").val();	//상품금액
	var totQty = 0;			//상품 총 주문수량
	var totQtyAdd = 0;		//추가상품 총 주문수량
	var totOptionPrice = 0;	//상품 총 옵션가격
	
	$("input[name=option_order_qty]").each(function(){
		if($(this).parent().find("input[name=option_type]").val() == "0"){	//필수옵션
			totQty = totQty + Number(this.value);
			totOptionPrice = totOptionPrice + Number($(this).parent().find("input[name=option_price]").val()) * Number(this.value);
		}else{		//추가옵션
			totQtyAdd = totQtyAdd + Number(this.value);
			totOptionPrice = totOptionPrice + Number($(this).parent().find("input[name=option_price]").val()) * Number(this.value);
		}
	});
	
	var totalPrice = itemPrice * totQty + totOptionPrice;
	$("strong#lPayResAmt").text($.number(totalPrice));
	$("strong#lPayResQty").text(totQty + totQtyAdd);
}

//상품수량 직접입력시 재고량 비교
function checkItemQty(obj){
	if(isNull($(obj).val())) return;
	
	var optionQty = $(obj).siblings("input[name=option_qty]").val();
	if(!getRegExpResult(NUMBER_EXPRESSION, $(obj).val())){
		defaultAlert("수량은 정수만 입력 가능합니다.");
		$(obj).val("1");
		return;
	}
	
	if(Number($(obj).val()) > Number(optionQty)){
		$(obj).val(optionQty);
		return;
	}
}

//장바구니 수정
function updateCart(){
	if(!chkCartValidation()){
		return;
	}
	
	var cartData = createCartData();
	
	$.ajax({
        type: "POST",
        url: "/item/updateShopCartAjax.do",
        data: {
        	"item_seq":$("div.frm > input[name=item_seq]").val(),
        	"order_no":$("div.frm > input[name=order_no]").val(),
        	"jsonStr":JSON.stringify(cartData)
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
        		defaultAlert("고객센터에 문의주세요.");
        	}
        }
    });
}

//장바구니담기 Validation
function chkCartValidation(){
	
//	var deliveryCharge = $("select[name=delivery_charge]");
//	if(deliveryCharge.length == 0){
//		$("input[name=delivery_type]").val("1");
//	}else{
//		if(isNull($(deliveryCharge).val())){
//			defaultAlert("배송비결제를 선택해 주세요.");
//			return false;
//		}else{
//			$("input[name=delivery_type]").val($(deliveryCharge).val());
//		}
//	}
	
	var itemOptionTr = $("div#itemOptResult > table > tbody > tr");
	if(itemOptionTr.length == 0){
		defaultAlert("옵션을 선택해 주세요.");
		return false;
	}else{
		var isOptionValid = true;
		$(itemOptionTr).each(function(){
			var optionName = $(this).find("input[name=option_name]").val();
			var optionQty = $(this).find("input[name=option_qty]").val();
			var optionOrderQty = $(this).find("input[name=option_order_qty]").val();
			
			if(!getRegExpResult(NUMBER_EXPRESSION, optionOrderQty)){
				defaultAlert(name+"의 수량이 유효하지 않습니다.");
				isOptionValid = false;
				return;
			}
			if(Number(optionOrderQty) < 1){
				defaultAlert(name+"의 수량은 1개이상 주문가능합니다.");
				isOptionValid = false;
				return;
			}
			if(Number(optionOrderQty) > Number(optionQty)){
				defaultAlert(name+"의 주문가능 수량은 ["+ optionQty +"] 입니다.");
				isOptionValid = false;
				return;
			}
		});
		
		if(!isOptionValid) return false;
	}
	
	return true;
}

//장바구니 등록 데이터 만들기
function createCartData(){
	
	var itemSeq = $("div.frm input[name=item_seq]").val();
	var itemTitle = $("div.frm input[name=item_title]").val();
	var itemName = $("div.frm input[name=item_name]").val();
	var itemPrice = $("div.frm input[name=item_price]").val();
	var orderNo = $("div.frm input[name=order_no]").val();
	var deliveryType = $("div.frm input[name=delivery_type]").val();
	var itemSellerSeq = $("div.frm input[name=item_seller_seq]").val();
	var cartData = new Array();
	
	var data = new Object();
	$("div#itemOptResult > table tr").each(function(){
		data = new Object();
		
		data.item_seq = itemSeq;
		data.item_title = itemTitle;
		data.item_name = itemName;
		data.item_price = itemPrice;
		data.delivery_type = deliveryType;
		data.item_seller_seq = itemSellerSeq;
		data.order_no = orderNo;
		data.io_name = $(this).find("input[name=option_name]").val();
		data.io_type = $(this).find("input[name=option_type]").val();
		data.io_price = $(this).find("input[name=option_price]").val();
		data.cart_qty = $(this).find("input[name=option_order_qty]").val();
		
		cartData.push(data);
	});
	
	return cartData;
}

//주문페이지 이동(선택되어 있는 상품 param으로 넘기기)
function goOrderForm(){
	var oderNoStr = "";
	$("input[name=chk_cart]").each(function(){
		if($(this).is(":checked")){
			if(isNull(oderNoStr)){
				oderNoStr = "'" + this.value + "'";
			}else{
				oderNoStr = oderNoStr + ",'" + this.value + "'";
			}
		}
	});
	
//	if(isNull(oderNoStr)){
//		defaultAlert("주문하실 상품을 선택해 주세요.");
//		return;
//	}
	
	$("form[name=orderFrm] > input[name=order_no]").val(oderNoStr);
	$("form[name=orderFrm]").submit();
}

//주문페이지 이동(단일주문)
function goOrderFormOne(obj){
	
	$("input[name=chk_cart]").prop("checked", false);
	$(obj).parents("tr:first").find("input[name=chk_cart]").prop("checked", true);
	beforeResOrderForm();
}

/**
 * 주문페이지로 이동전 주문하려는 상품 상태값 확인
 * @returns
 */
function beforeResOrderForm(){
	var orderList = new Array();
	
	if($("input[name=chk_cart]:checked").length > 0){
		
		$("input[name=chk_cart]:checked").each(function(){
			var orderObj = new Object();
			orderObj.item_seq = $(this).attr("item_seq");
			orderObj.order_no = this.value;
			
			orderList.push(orderObj);
		});
		
		$.ajax({
			type : "POST"
			,url : "/item/checkOrderItemStatusAjax.do"
			,data : {
				"order_list":JSON.stringify(orderList)
			}
			,dataType : "json"
			,async : true
			,success : function(result, status, xhr) {
				console.log(result);
				if(result.result == AJAX_RESULT_SUCCESS){
					goOrderForm();
				}else{
					result.message = result.message + "<br/>해당내역 삭제후 주문해주시기 바랍니다.";
					defaultAlert(result.message,null,null,600);
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
	}else{
		defaultAlert("주문하실 상품을 선택해주세요.");
	}
}