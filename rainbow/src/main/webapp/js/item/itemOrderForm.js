$(document).ready(function(){
	$(".datepicker").datepicker({
		dateFormat:'yymmdd'
		//onSelect:selectDatepicker
	});
	
	//수령자명 입력시 그외 정보 자동 세팅
	$("input[name=recv_name]").on("blur", function(){
		recvInfoAutoSet(this);
	});
	
});

/**
 * 주소검색 팝업 리턴
 */
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo,cate){
	$("div#address"+cate).find("input[name=recv_zip_code]").val(zipNo);
	$("div#address"+cate).find("input[name=recv_address]").val(roadAddrPart1);
	$("div#address"+cate).find("input[name=recv_address_dtl]").val(addrDetail);
}

//결제방법선택
function clickPayType(obj){
	if($(obj).val() == "1" || $(obj).val() == "2"){
		$("#confirmPw").show();
	}else{
		$("#confirmPw").hide();
	}
}

/**
 * 결제금액 계산 및 화면 세팅
 */
function calculateOrderPrice(){
	
	var totOrderPrice = 0;
	var totOrderQty = 0;
	var totDeliveryCharge = 0;
	var totDeliveryCnt = 0;
	
	$("tr.orderTr").each(function(){
		if(!$(this).hasClass("soldout")){
			totOrderPrice = totOrderPrice + Number($(this).find("input[name=order_price]").val())
			totOrderQty = totOrderQty + Number($(this).find("input[name=order_qty]").val())
			totDeliveryCharge = totDeliveryCharge + Number($(this).find("input[name=delivery_charge]").val())
			if(Number($(this).find("input[name=delivery_charge]").val()) > 0){
				totDeliveryCnt++;
			}
		}
	});
	
	$("b#totOrderQty").text(totOrderQty);
	$("b#totDeliveryCnt").text(totDeliveryCnt);
	$("sup#cartDeliAmount").text($.number(totDeliveryCharge));
	$("sup#totOrderPrice").text($.number(totOrderPrice));
	$("sup#cartAmount").text($.number(totOrderPrice));
}

/**
 * 결제전 상품의 상태를 체크한다.
 * @returns
 */
function beforePay(){
	
	var orderList = new Array();
	
	$("tr.orderTr").each(function(){
		if(!$(this).hasClass("soldout")){
			var orderObj = new Object();
			orderObj.item_seq = $(this).find("input[name=item_seq]").val();
			orderObj.order_no = $(this).find("input[name=order_no]").val();
			
			orderList.push(orderObj);
		}
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
			if(result.result == AJAX_RESULT_SUCCESS){
				insertShopOrder();
			}else{
				if($("tr.orderTr").length == 1){
					result.message = result.message + "<br/>주문가능한 상품이 없기 때문에 장바구니로 이동합니다.";
				}else{
					result.message = result.message + "<br/>해당상품은 주문목록에서 제외됩니다.<br/><br/>결제금액을 다시 확인해주세요.";
				}
				defaultAlert(result.message,null,function(){
					if($("tr.orderTr").length == 1){
						location.href = "/item/itemCartList.do";
					}else{
						var arrOrderNo = result.orderNo.split('|');
						$(arrOrderNo).each(function(idx, odr){
							$("tr#"+odr).addClass("soldout");
							calculateOrderPrice();	//금액 다시 계산
						});
					}
				},600);
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

//주문정보 확인
function insertShopOrder(){
	
	if(!chkOrderValidation()){
		return;
	}
	
	var payType = $("input[name=pay_type]:checked").val();
	if(payType != "4"){
		
		defaultConfirm("결제하시겠습니까?", function(){
			//e-money 결제시 비밀번호 암호화
			if(payType != 3){
				$.ajax({
					type: "POST",
					url: "/auth/getRsaPublicKey.do",
					data: {},
					success: function(result, status, xhr){
						
						if(result.result == AJAX_RESULT_SUCCESS){
							var rsa = new RSAKey();
							rsa.setPublic(result.RSAModulus,result.RSAExponent);
							$("input[name=rsa_password]").val(rsa.encrypt($("input[name=confirm_password]").val()))
							
							sendOrder();
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
				sendOrder();
			}
		});
	}else{
		//카드결제 로직부분
	}
}

/**
 * 주문정보 실제 저장
 * @returns
 */
function sendOrder(){
	var payType = $("input[name=pay_type]:checked").val();
	var orderData = createOrderData();
	var confirmPassword = $("input[name=rsa_password]").val();
	
	$.ajax({
        type: "POST",
        url: "/item/insertShopOrderAjax.do",
        data: {
        	"pay_type":payType,
        	"confirm_password":confirmPassword,
        	"orderStr":JSON.stringify(orderData)
        },
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS){
        		location.href = "/item/itemOrderComplete.do";
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

/**
 * 주문정보 validtion
 * @returns
 */
function chkOrderValidation(){
	var result = true;
	
	$("tr.orderTr").each(function(){
		
		if(!$(this).hasClass("soldout")){
			
			if(!getRegExpResult(NAME_REGULAR_EXPRESSTION, $(this).find("input[name=recv_name]").val())){
				defaultAlert("수령자명이 유효하지 않습니다.");
				$(this).find("input[name=recv_name]").focus();
				result = false;
				return;
			}
			
			if(!getRegExpResult(ZIPCODE_REGULAR_EXPRESSTION, $(this).find("input[name=recv_zip_code]").val())){
				defaultAlert("수령자 우편번호가 유효하지 않습니다.");
				$(this).find("input[name=recv_zip_code]").focus();
				result = false;
				return;
			}
			
			if(!getRegExpResult(ADDRESS_REGULAR_EXPRESSTION, $(this).find("input[name=recv_address]").val())){
				defaultAlert("수령자 주소가 유효하지 않습니다.");
				$(this).find("input[name=recv_address]").focus();
				result = false;
				return;
			}
			
			if(!getRegExpResult(ADDRESS_DETAIL_REGULAR_EXPRESSTION, $(this).find("input[name=recv_address_dtl]").val())){
				defaultAlert("수령자 상세주소가 유효하지 않습니다.");
				$(this).find("input[name=recv_address_dtl]").focus();
				result = false;
				return;
			}
			
			var revtHp = $(this).find("select[name=hp1]").val() + "-" + $(this).find("input[name=hp2]").val() + "-" + $(this).find("input[name=hp3]").val();
			if(!getRegExpResult(HP_REGULAR_EXPRESSTION, revtHp)){
				defaultAlert("수령자 휴대전화번호가 유효하지 않습니다.");
				$(this).find("input[name=hp2]").focus();
				result = false;
				return;
			}else{
				$(this).find("input[name=recv_hp]").val(revtHp);
			}
			
			if(!getRegExpResult(DATE_EXPRESSION, $(this).find("input[name=send_req_date]").val())){
				defaultAlert("배송요청일이 유효하지 않습니다.");
				$(this).find("input[name=send_req_date]").focus();
				result = false;
				return;
			}
		}
	});
	
	if(!result) return false;
	
	if(isNull($("input[name=pay_type]:checked").val())){
		defaultAlert("결제방법을 선택해 주세요.");
		return false;
	}
	
	var payType = $("input[name=pay_type]:checked").val();
	if(payType == "1" || payType == "2"){
		if(isNull($("input[name=confirm_password]").val())){
			defaultAlert("비밀번호를 입력해 주세요.");
			return false;
		}
		if(!getRegExpResult(PW_REGULAR_EXPRESSTION, $("input[name=confirm_password]").val())){
			defaultAlert("비밀번호가 유효하지 않습니다.");
			return false;
		}
	}
	
	if(!$("input[name=chk_agree]").is(":checked")){
		defaultAlert("개인정보에 동의해 주세요.");
		return false;
	}
	
	return result;
}

/**
 * 주문정보생성
 * @returns
 */
function createOrderData(){

	var orderData = new Array();
	var data = new Object();
	
	$("tr.orderTr").each(function(){
		
		if(!$(this).hasClass("soldout")){
			data = new Object();
			
			data.order_no = $(this).find("input[name=order_no]").val();
			data.item_seq = $(this).find("input[name=item_seq]").val();
			data.order_name = $(this).find("input[name=order_name]").val();
			data.order_price = $(this).find("input[name=order_price]").val();
			data.order_qty = $(this).find("input[name=order_qty]").val();
			data.delivery_type = $(this).find("input[name=delivery_type]").val();
			data.delivery_charge = $(this).find("input[name=delivery_charge]").val();
			data.recv_name = $(this).find("input[name=recv_name]").val();
			data.recv_hp = $(this).find("input[name=recv_hp]").val();
			data.recv_zip_code = $(this).find("input[name=recv_zip_code]").val();
			data.recv_address = $(this).find("input[name=recv_address]").val();
			data.recv_address_dtl = $(this).find("input[name=recv_address_dtl]").val();
			data.recv_message = $(this).find("textarea[name=recv_message]").val();
			data.send_req_date = $(this).find("input[name=send_req_date]").val();
			data.item_seller_seq = $(this).find("input[name=item_seller_seq]").val();
			
			orderData.push(data);
		}
	});
	
	return orderData;
}

/**
 * 수령자명 입력시 그외 정보 자동 세팅
 * @param obj
 * @returns
 */
function recvInfoAutoSet(obj){
	var recvName = $(obj).val();
	var trIndex = $(obj).parents("tr.orderTr:first").index();
	
	$("input[name=recv_name]").each(function(idx, target){
		if(trIndex != $(target).parents("tr.orderTr:first").index() && !isNull(target.value)){
			//이름 동일시 자동 세팅
			if(recvName == target.value){
				defaultConfirm("동일한 이름의 수령지정보가 있습니다.<br/>설정하시겠습니까?", function(){
					$(obj).parents('table:first').find("input[name=recv_zip_code]").val( $(target).parents('table:first').find("input[name=recv_zip_code]").val() );
					$(obj).parents('table:first').find("input[name=recv_address]").val( $(target).parents('table:first').find("input[name=recv_address]").val() );
					$(obj).parents('table:first').find("input[name=recv_address_dtl]").val( $(target).parents('table:first').find("input[name=recv_address_dtl]").val() );
					$(obj).parents('table:first').find("select[name=hp1]").val( $(target).parents('table:first').find("select[name=hp1]").val() );
					$(obj).parents('table:first').find("input[name=hp2]").val( $(target).parents('table:first').find("input[name=hp2]").val() );
					$(obj).parents('table:first').find("input[name=hp3]").val( $(target).parents('table:first').find("input[name=hp3]").val() );
					$(obj).parents('table:first').find("input[name=send_req_date]").val( $(target).parents('table:first').find("input[name=send_req_date]").val() );
					$(obj).parents('table:first').find("textarea[name=recv_message]").val( $(target).parents('table:first').find("textarea[name=recv_message]").val() );
				});
				return false;
			}
		}
	});
}