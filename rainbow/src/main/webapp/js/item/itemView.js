$(document).ready(function(){
	
	var itemStatus = $("input[name=item_status]").val();
	if(itemStatus != "2" && itemStatus != "3"){
		var msg = "";
		if(itemStatus == "4")	msg = "판매가 종료된 상품입니다.<br><br>이전 페이지로 이동합니다.";
		if(itemStatus == "5")	msg = "기간이 만료된 상품입니다.<br><br>이전 페이지로 이동합니다.";
		defaultAlert(msg,null,function(){
			history.back(-1);
		});
	}
	
	getItemShopQaList();	//상품문의목록 조회
	
	$("input[name=option_order_qty]").numeric();
});

//상품사진 마우스오버 세팅
function setItemImage(obj){
	var imgSrc = $(obj).attr("src");
	$("img.mainThumb").attr("src", imgSrc);
}

//상품문의 목록/작성 변경
function changeItemQnaDiv(gb){
	if(gb == 1){
		$("div#lSupportList").css("display", "none");
		$("div#lSupportWrite").fadeIn();
	}else if(gb == 2){
		$("div#lSupportWrite").css("display", "none");
		$("div#lSupportList").fadeIn();
	}else{
		$("div#lSupportView").css("display", "none");
		$("div#lSupportList").fadeIn();
	}
}

//질문 비밀글 지정체크
function checkIqaOpen(obj){
	if($(obj).is(":checked")){
		$("input[name=iqa_open]").val("1");
	}else{
		$("input[name=iqa_open]").val("0");
	}
}

//질문등록 validation check
function checkValidateIqa(){
	if(isNull($("input[name=iqa_subject]").val())){
		defaultAlert("문의제목을 입력해주세요.");
		$("input[name=iqa_subject]").focus();
		return false;
	}
	
	if(isNull($("textarea[name=content]").val())){
		defaultAlert("문의내용을 입력해주세요.");
		$("textarea[name=content]").focus();
		return false;
	}
	
	if($("input[name=attach_image]").val() != null && $("input[name=attach_image]").val() != ''){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=attach_image]").val())){
			defaultAlert("이미지는 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	return true;
}

//질문등록
function addShopItemQa(){
	
	if(!checkValidateIqa()){
		return;
	}
	
	var form = $('form[name=iqaFrm]')[0];
	var data = new FormData(form);
	
	$.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/item/insertItemQaAjax.do",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS){
        		defaultAlert(result.message);
        		
        		getItemShopQaList();
        		initShopItemQaValues();
        		changeItemQnaDiv(2);
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

//질문등록폼 null set
function initShopItemQaValues(){
	$("input[name=iqa_subject]").val("");
	$("textarea[name=content]").val("");
	$("input[name=iqa_image]").val("");
	$("input[name=iqa_open]").val("0");
	$("input[name=chk_iqa_open]").prop("checked", false);
}

//질문목록조회
function getItemShopQaList(){
	var itemSeq = $("form[name=iqaFrm] > input[name=item_seq]").val();
	
	$.ajax({
		type : "POST",
		url : "/item/getItemShopQaListAjax.do",
		data : {
			"item_seq":$("form[name=iqaFrm] > input[name=item_seq]").val(),
			"page":$("form[name=iqaFrm] > input[name=page]").val(),
			"pageSize":$("form[name=iqaFrm] > input[name=pageSize]").val()
		},
		dataType : "json",
		async : true,
		success : function(result, status, xhr) {
			var html = '';
			var qaList = result.qaList;
			
			if(qaList != null && qaList != undefined && qaList.length > 0){
				$(qaList).each(function(idx, obj){
					html += '<tr>';
					html += '	<td>'+obj.IQA_SEQ+'</td>';
					html += '	<td style="color:'+(obj.IQA_IS_ANSWER == 0 ? '#e72d2d':'#2dc1e7')+'">'+(obj.IQA_IS_ANSWER == 0 ? '답변미완료':'답변완료')+'</td>';
					html += '	<td style="text-align:left; color:">';
					html += '		<img src="/images/item/view/ico_question.png" style="margin-right:4px;">';
					if(obj.IQA_OPEN == 0){
						html += '	<a href="javascript:void(0);" onclick="viewItemQaReply(this, '+obj.IQA_SEQ+');"><span style="color:#aaaaaa;">'+obj.IQA_SUBJECT+'</span></a>';
					}else{
						if(!isNull(result.sessionMember) && result.sessionMember.MB_SEQ == obj.MB_SEQ){
							html += '	<a href="javascript:void(0);" onclick="viewItemQaReply(this, '+obj.IQA_SEQ+');"><span style="color:#aaaaaa;">비밀글입니다</span></a>';
						}else{
							html += '	<span style="color:#aaaaaa;">비밀글입니다</span>';
						}
						html += '	<img src="/images/item/view/locked_lite.png" style="margin-left:4px; vertical-align:-1px;" width="9" height="12" alt="비밀글">';
					}
					html += '	</td>';
					html += '	<td>'+obj.MB_ID+'</td>';
					html += '	<td style="color:#1B1B1B">'+obj.IQA_REG_DTTM_YMD+'</td>';
					html += '</tr>';
				});
				
				$("ul.lTap").each(function(){
					$(this).find("li:eq(2) b").text(result.total);
				});
			}else{
				html += '<tr>';
				html += '	<td colspan="5">상품문의 내역이 없습니다.</td>';
				html += '<tr>';
			}
			
			$("div#lSupportListPage > table > tbody").html(html);
			$("#qaPaging").html(result.paging);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			defaultAlert("고객센터에 문의주세요.");
		}
	});
}

function iqaPaging(){
	getItemShopQaList();
	return false;
}

//답변보기
function showItemQaReply(iqaSeq, isAnswer){
	if(isAnswer == 1){
		if($("tr#replay_"+iqaSeq).css("display") == "none"){
			$("tr#replay_"+iqaSeq).css("display", "table-row");
		}else{
			$("tr#replay_"+iqaSeq).css("display", "none");
		}
	}
}

//문의글 답변 뷰페이지
function viewItemQaReply(obj, iqaSeq){
	
	$.ajax({
        type: "POST",
        url: "/item/getShopItemQaContentListAjaxHtml.do",
        data: {
        	"iqa_seq":iqaSeq
        },
        dataType : "html",
		async : true,
        success: function(result, status, xhr){
        	$("div#lSupportView").html(result);
        	$("#lSupportView").css("display", "block");
        	$("#lSupportList").css("display", "none");
        	
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

//문의글 재질문 및 답변 등록
function insertShopItemQaContent(){
	if(isNull($("form[name=qaContentFrm] textarea").val())){
		defaultAlert("내용을 입력해 주세요.");
		return;
	}
	
	var form = $('form[name=qaContentFrm]')[0];
	var data = new FormData(form);
	
	$.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/item/insertItemQaContentAjax.do",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS){
//        		defaultAlert(result.message);
        		
        		getItemShopQaList();
        		initShopItemQaValues();
        		changeItemQnaDiv(3);
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

//관심상품 등록/해제
function myItemRegist(obj, itemSeq){
	var actionType = "";
	var imgSrc = $(obj).find("img#addMyFavorItem").attr("src");
	if(imgSrc.indexOf("_off") > -1){
		actionType = "C";
	}else{
		actionType = "D";
	}
	
	$.ajax({
        type: "POST",
        url: "/item/insertMyItemAjax.do",
        data: {
        	"item_seq":itemSeq,
        	"action_type":actionType
        },
        dataType : "json",
        cache: false,
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS){
        		if(actionType == "C"){
        			$(obj).find("img#addMyFavorItem").attr("src", imgSrc.replace("_off", "_on"));
        		}else{
        			$(obj).find("img#addMyFavorItem").attr("src", imgSrc.replace("_on", "_off"));
        		}
        		//우측 관심상품목록 재조회
        		var type = "0";
        		$("ul#myInterestItemType_ul > li").each(function(){
        			if($(this).hasClass("on")){
        				type = $(this).children("a").attr("price");
        			}
        		});
        		getMyInterestItemList(type);
        		setInterestItemHeartImage(itemSeq);
        	}else{
        		defaultAlert(result.message);
        	}
        },
        error: function(jqXHR, textStatus, errorThrown){
        	if(jqXHR.status == 300){
        		defaultAlert("로그인이 필요합니다.!");
        	}else{
        		defaultAlert("[오류] 고객센터에 문의바랍니다.");
        	}
        }
    });
}

/**
 * 관심상품 하트표시 설정/해제
 * 우측 관심상품으로 등록/삭제시 상품상세페이지에서 하트표시 설정 
 */
function setInterestItemHeartImage(itemSeq){
	$.ajax({
        type: "POST",
        url: "/item/getMyItemAjax.do",
        data: {
        	"item_seq":itemSeq
        },
        dataType : "json",
        cache: false,
        success: function(result, status, xhr){
        	console.log(result);
        	if(result.result == AJAX_RESULT_SUCCESS){
        		if(!isNull(result.myItem)){
        			$("img#addMyFavorItem").attr("src", "/images/item/view/icon_favorite_on.png");
        		}else{
        			$("img#addMyFavorItem").attr("src", "/images/item/view/icon_favorite_off.png");
        		}
        	}else{
        		defaultAlert(result.message);
        	}
        },
        error: function(jqXHR, textStatus, errorThrown){
        	if(jqXHR.status == 300){
        		defaultAlert("로그인이 필요합니다.!!");
        	}
        }
    });
}



//1차 또는 2차 옵션 하위 옵션목록 조회
function getItemOptionList(ioName, eqNum, optionLength){
	var itemSeq = $("form[name=orderFrm] > input[name=item_seq]").val();
	
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
	var itemPrice = Number($("form[name=orderFrm] > input[name=item_price]").val());
	var optionPrice = Number($(obj).find("option:selected").attr("io_price"));
	var optionType = 0;
	
	if(optionQty == "0"){
		defaultAlert("품절된 상품입니다.");
		return;
	}
	
	//옵션타입을 설정(0:필수옵션 1:추가옵션)
	if($(obj).attr("name") == "select_option"){
		itemPrice = itemPrice + optionPrice;
		optionType = 0;
	}else{
		itemPrice = optionPrice;
		optionType = 1;
	}
	
	//선택한 옵션의 값이 NULL이 아닌경우
	if(!isNull($(obj).val())){
		
		var isDupOption = false;
		
		$("input[name=option_name]").each(function(){
			if($(obj).val() == this.value){
				isDupOption = true;
			}
		});
		
		//이미 추가되어 있는 옵션이 아닐경우 옵션 추가
		if(!isDupOption){
			var itemName = $("form[name=orderFrm] > input[name=item_name]").val()
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
		}else{
			defaultAlert("이미 추가되어 있는 옵션입니다.");
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
	var itemPrice = $("form[name=orderFrm] > input[name=item_price]").val();	//상품금액
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

//장바구니 담기
//btnType 1:구매 2:장바구니
function insertCart(btnType){
	if(!chkCartValidation()){
		return;
	}
	
	var cartData = createCartData();
	
	$.ajax({
        type: "POST",
        url: "/item/insertShopCartAjax.do",
        data: {
        	"item_seq": $("form[name=orderFrm] > input[name=item_seq]").val(),
        	"jsonStr":JSON.stringify(cartData)
        },
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS){
        		if(btnType == 1){
        			$("form[name=payFrm] > input[name=order_no]").val(result.order_no);
        			$("form[name=payFrm]").attr("action", "/item/itemOrderForm.do");
        			$("form[name=payFrm]").submit();
        		}else{
        			$("div#lPayCartNotice").show();
        		}
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
	
	var deliveryCharge = $("select[name=delivery_charge]");
	if(deliveryCharge.length == 0){
		$("input[name=delivery_type]").val("1");
	}else{
		if(isNull($(deliveryCharge).val())){
			defaultAlert("배송비결제를 선택해 주세요.");
			return false;
		}else{
			$("input[name=delivery_type]").val($(deliveryCharge).val());
		}
	}
	
	var itemOptionTr = $("div#itemOptResult > table > tbody > tr");
	if(itemOptionTr.length == 0){
		
		if($("select[name=select_option]").length == 0 && $("form[name=orderFrm] > input[name=item_qty]").val() == "0"){
			defaultAlert("본 상품은 품절되어 판매가 불가합니다.");
			return false;
		}
		
		if($("select[name=select_option]").length > 0){
			
			var totOpQty = 0;
			$("select[name=select_option] option").each(function(){
				if(!isNull(this.value)){
					totOpQty = totOpQty + Number($(this).attr("io_stock_qty"));
				}
			});
			
			if(totOpQty == 0){
				defaultAlert("본 상품은 품절되어 판매가 불가합니다.", null, null, 500);
				return false;
			}else{
				defaultAlert("옵션을 선택해 주세요.");
				return false;
			}
		}
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
	
	var itemSeq = $("form[name=orderFrm] > input[name=item_seq]").val();
	var itemSellerSeq = $("form[name=orderFrm] > input[name=item_seller_seq]").val();
	var itemTitle = $("form[name=orderFrm] > input[name=item_title]").val();
	var itemName = $("form[name=orderFrm] > input[name=item_name]").val();
	var itemPrice = $("form[name=orderFrm] > input[name=item_price]").val();
	var deliveryType = $("form[name=orderFrm] > input[name=delivery_type]").val();
	var cartData = new Array();
	
	var data = new Object();
	$("div#itemOptResult > table tr").each(function(){
		data = new Object();
		
		data.item_seq = itemSeq;
		data.item_seller_seq = itemSellerSeq;
		data.item_title = itemTitle;
		data.item_name = itemName;
		data.item_price = itemPrice;
		data.delivery_type = deliveryType;
		data.io_name = $(this).find("input[name=option_name]").val();
		data.io_type = $(this).find("input[name=option_type]").val();
		data.io_price = $(this).find("input[name=option_price]").val();
		data.cart_qty = $(this).find("input[name=option_order_qty]").val();
		
		cartData.push(data);
	});
	
	return cartData;
}
