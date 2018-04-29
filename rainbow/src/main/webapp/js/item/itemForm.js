var oEditors = [];
var categoryList = [];

$(document).ready(function(){
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "item_content",
		sSkinURI: "/plugin/SE2/SmartEditor2Skin.html",  
		htParams : {
		    bUseToolbar : true,             // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		    bUseVerticalResizer : true,     // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		    bUseModeChanger : true,         // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		    bSkipXssFilter : true,      // client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		    //aAdditionalFontList : aAdditionalFontSet,     // 추가 글꼴 목록
		    fOnBeforeUnload : function(){
		        //defaultAlert("완료!");
		    },
		    //18N_LOCALE : sLang
		}, //boolean
		fOnAppLoad : function(){
		    //예제 코드
		    //oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	//달력
	$(".datepicker").datepicker({
		dateFormat:'yymmdd'
	});
	
	//카테고리검색
	itemCategoryListAjax();
});

/**
 * 카테고리 목록조회
 */
function itemCategoryListAjax(){
	$.ajax({
		type : "POST"
		,url : "/item/itemCategoryListAjax.do"
		,data : {}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.resultData != null && result.resultData != undefined){
				categoryList = result.resultData;
				$(categoryList).each(function(idx, obj){
					if(obj.CATE_DEPTH == 1){
						$("select#category1").append('<option value="'+obj.CATE_CODE+'" '+($("input[name=cate_code1]").val()==obj.CATE_CODE?'selected':'')+'>'+obj.CATE_NAME+'</option>');
					}
				});
				
				if(!isNull($("input[name=cate_code2]").val())){
					onloadCategory(1);
					onloadCategory(2);
				}
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			console.log("error");
		}
	});
}

/**
 * onload 카테고리
 * 상품수정시 선택되어 있는 카테고리 selected 하기
 */
function onloadCategory(depth){
	if(depth == 1){
		$(categoryList).each(function(idx, obj){
			if(obj.CATE_DEPTH == 2 && $("input[name=cate_code1]").val() == obj.CATE_CODE.substring(0, 3) ){
				$("select#category2").append('<option value="'+obj.CATE_CODE+'" '+($("input[name=cate_code2]").val()==obj.CATE_CODE?'selected':'')+'>'+obj.CATE_NAME+'</option>');
			}
		});
	}else{
		$(categoryList).each(function(idx, obj){
			if(obj.CATE_DEPTH == 3 && $("input[name=cate_code2]").val() == obj.CATE_CODE.substring(0, 5) ){
				$("select#category3").append('<option value="'+obj.CATE_CODE+'" '+($("input[name=cate_code3]").val()==obj.CATE_CODE?'selected':'')+'>'+obj.CATE_NAME+'</option>');
			}
		});
	}
}

/**
 * 카테고리 변경
 * @returns
 */
function changeCategory(depth){
	if(depth == 1){
		$("select#category2").empty();
		$("select#category3").empty();
		$("select#category2").append('<option value="">-카테고리2선택-</option>');
		$("select#category3").append('<option value="">-카테고리3선택-</option>');
		$(categoryList).each(function(idx, obj){
			if(obj.CATE_DEPTH == 2 && $("select#category1").val() == obj.CATE_CODE.substring(0, 3) ){
				$("select#category2").append('<option value="'+obj.CATE_CODE+'" '+($("input[name=cate_code2]").val()==obj.CATE_CODE?'selected':'')+'>'+obj.CATE_NAME+'</option>');
			}
		});
		
		$("div#categorySpan").text($("select#category1 option:selected").text());
		$("input[name=cate_code1]").val($("select#category1").val());
		$("input[name=cate_code2]").val("");
		$("input[name=cate_code3]").val("");
	}else if(depth == 2){
		$("select#category3").empty();
		$("select#category3").append('<option value="">-카테고리3선택-</option>');
		$(categoryList).each(function(idx, obj){
			if(obj.CATE_DEPTH == 3 && $("select#category2").val() == obj.CATE_CODE.substring(0, 5) ){
				$("select#category3").append('<option value="'+obj.CATE_CODE+'">'+obj.CATE_NAME+'</option>');
			}
		});
		
		$("div#categorySpan").text( $("select#category1 option:selected").text() + " > " + $("select#category2 option:selected").text() );
		
		$("input[name=cate_code2]").val($("select#category2").val());
		$("input[name=cate_code3]").val("");
	}else if(depth == 3){
		$("div#categorySpan").text( $("select#category1 option:selected").text() + " > " + $("select#category2 option:selected").text() + " > " +  $("select#category3 option:selected").text() );
		$("input[name=cate_code3]").val($("select#category3").val());
	}
}


function clickBtnCategory(){
	$("iframe[name=popupFrame]").attr("src", "/item/itemCategoryPopup.do");
	$("div#mainPopupLayer").show();
}

//선택옵션목록생성
function registSelectOption(){

	var arrTemp = [];
	var html = '';
	var selectOption = '';
	
	var selectOption1 = $("input[name=select_option]:eq(0)").val();
	var selectOption2 = $("input[name=select_option]:eq(1)").val();
	var selectOption3 = $("input[name=select_option]:eq(2)").val();
	var selectOptionItem1 = $("input[name=select_option_item]:eq(0)").val();
	var selectOptionItem2 = $("input[name=select_option_item]:eq(1)").val();
	var selectOptionItem3 = $("input[name=select_option_item]:eq(2)").val();
	
	if(isNull(selectOption1) && isNull(selectOption2) && isNull(selectOption3)){
		defaultAlert("옵션을 입력해 주세요.");
		return;
	}
	
	if(!isNull(selectOption1) && !isNull(selectOptionItem1)){
		$("input[name=item_option_subject]").val(selectOption1);
		var arrOption1 = selectOptionItem1.split(',');
		
		if(!isNull(selectOption2) && !isNull(selectOptionItem2)){
			$("input[name=item_option_subject]").val(selectOption1+","+selectOption2);
			var arrOption2 = selectOptionItem2.split(',');
			
			if(!isNull(selectOption3) && !isNull(selectOptionItem3)){	//옵션1, 옵션2, 옵션3 있을경우
				$("input[name=item_option_subject]").val(selectOption1+","+selectOption2+","+selectOption1);
				var arrOption3 = selectOptionItem3.split(','); 
				
				for(var i=0; i<arrOption1.length; i++){
					for(var j=0; j<arrOption2.length; j++){
						for(var k=0; k<arrOption3.length; k++){
							if(!isNull(arrOption1[i]) && !isNull(arrOption2[j]) && !isNull(arrOption3[k])){
								html += '<tr>';
//								html += '	<td class="center"><input type="checkbox" name="chk_select_option" value="1"/></td>';
								html += '	<td class="left textLimit" colspan="2" title="'+arrOption1[i]+arrOption2[j]+arrOption3[k]+'">';
								html += '		<input type="hidden" name="io_name" value="'+arrOption1[i]+'^'+arrOption2[j]+'^'+arrOption3[k]+'"/>';
								html += '		<input type="hidden" name="io_type" value="0"/>';
								html += '		'+arrOption1[i]+arrOption2[j]+arrOption3[k];
								html += '	</td>';
								html += '	<td class="center"><input type="text" name="io_price" value="0" style="text-align:right;width:70px;"/></td>';
								html += '	<td class="center"><input type="text" name="io_stock_qty" value="0" style="text-align:right;width:70px;"/></td>';
								html += '	<td class="center"><input type="text" name="io_noti_qty" value="0" style="text-align:right;width:70px;"/></td>';
								html += '	<td class="center"><select class="select_default" style="width:80px;" name="io_use"><option value="1">사용</option><option value="0">미사용</option></select></td>';
								html += '</tr>';
							}
						}
					}
				}
			}else{	//옵션1, 옵션2 있을경우
				for(var i=0; i<arrOption1.length; i++){
					for(var j=0; j<arrOption2.length; j++){
						if(!isNull(arrOption1[i]) && !isNull(arrOption2[j])){
							html += '<tr>';
//							html += '	<td><input type="checkbox" name="chk_select_option" value="1"/></td>';
							html += '	<td class="left textLimit" colspan="2" title="'+arrOption1[i]+arrOption2[j]+'">';
							html += '		<input type="hidden" name="io_name" value="'+arrOption1[i]+'^'+arrOption2[j]+'"/>';
							html += '		<input type="hidden" name="io_type" value="0"/>';
							html += '		'+arrOption1[i]+arrOption2[j];
							html += '	</td>';
							html += '	<td class="center"><input type="text" name="io_price" value="0" style="text-align:right;width:70px;"/></td>';
							html += '	<td class="center"><input type="text" name="io_stock_qty" value="0" style="text-align:right;width:70px;"/></td>';
							html += '	<td class="center"><input type="text" name="io_noti_qty" value="0" style="text-align:right;width:70px;"/></td>';
							html += '	<td class="center"><select class="select_default" style="width:80px;" name="io_use"><option value="1">사용</option><option value="0">미사용</option></select></td>';
							html += '</tr>';
						}
					}
				}
			}
		}else{	//옵션1 있을경우
			for(var i=0; i<arrOption1.length; i++){
				if(!isNull(arrOption1[i])){
					html += '<tr>';
//					html += '	<td class="center"><input type="checkbox" name="chk_select_option" value="1"/></td>';
					html += '	<td class="left textLimit" colspan="2" title="'+arrOption1[i]+'">';
					html += '		<input type="hidden" name="io_name" value="'+arrOption1[i]+'"/>';
					html += '		<input type="hidden" name="io_type" value="0"/>';
					html += '		'+arrOption1[i];
					html += '	</td>';
					html += '	<td class="center"><input type="text" name="io_price" value="0" style="text-align:right;width:70px;"/></td>';
					html += '	<td class="center"><input type="text" name="io_stock_qty" value="0" style="text-align:right;width:70px;"/></td>';
					html += '	<td class="center"><input type="text" name="io_noti_qty" value="0" style="text-align:right;width:70px;"/></td>';
					html += '	<td class="center"><select class="select_default" style="width:80px;" name="io_use"><option value="1">사용</option><option value="0">미사용</option></select></td>';
					html += '</tr>';
				}
			}
		}
	}
	
	$("table#selectOptionTable > tbody").html(html);
	$("table#selectOptionTable").css("display", "table");
}

//추가옵션추가
function addOptionInput(){
	var trLength = $("table#addOption > tbody > tr").length;
	
	html = '';
	html += '<tr>';
	html += '	<td style="padding:5px;">';
	html += '		<label>추가'+(trLength+1)+'</label>';
	html += '		<input type="text" name="add_option" value=""/>';
	html += '	</td>';
	html += '	<td style="padding:5px;">';
	html += '		<label>추가'+(trLength+1)+' 항목</label>';
	html += '		<input type="text" name="add_option_item" value="" style="width:300px;"/>';
	html += '		<button class="button_height_small" type="button" onclick="javascript:deleteAddOption(this);">삭제</button>';
	html += '	</td>';
	html += '	<td style="padding:5px;"><button class="button_height_small" type="button" id="btnAddOption" onclick="javascript:addOptionInput();">옵션추가</button></td>';
	html += '</tr>';
	
	$("#btnAddOption").remove();
	$("table#addOption > tbody").append(html);
}

//추가옵션삭제
function deleteAddOption(obj){
	$(obj).parents("tr:first").remove();
	
	if($("#btnAddOption").length == 0){
		var trLength = $("table#addOption > tbody > tr").length;
		$("table#addOption > tbody > tr:eq("+(trLength-1)+") > td:eq(1)").append('<button class="button_height_small" type="button" id="btnAddOption" onclick="javascript:addOptionInput();">옵션추가</button>');
	}
	
	registAddOption();
}

//추가옵션목록생성
function registAddOption(){
	
	var arrTemp = [];
	var html = '';
	var addOption = '';
	
	if($("input[name=add_option_item]").length > 0){
		$("input[name=add_option_item]").each(function(idx, obj){
			var addOption = $("input[name=add_option]:eq("+idx+")").val();
			if(!isNull(addOption) && !isNull($(obj).val())){
				
				if(idx == 0){
					$("input[name=item_supply_subject]").val(addOption);
				}else{
					$("input[name=item_supply_subject]").val($("input[name=item_supply_subject]").val()+","+addOption);
				}
				
				arrTemp = $(obj).val().split(',');
				addOption = $("input[name=add_option]:eq("+idx+")").val();
				
				$(arrTemp).each(function(idx2, str){
					if(!isNull(str)){
						html += '<tr io_group="'+addOption+'">';
//						html += '	<td><input type="checkbox" name="chk_add_option"/></td>';
						html += '	<td class="left textLimit" title="'+addOption+'">';
						html += '		<input type="hidden" name="io_name" value="'+str+'"/>';
						html += '		<input type="hidden" name="io_type" value="1"/>';
						html += '		'+addOption;
						html += '	</td>';
						html += '	<td colspan="2" class="left textLimit" title="'+str+'">'+str+'</td>';
						html += '	<td class="center"><input type="text" name="io_price" value="0" style="text-align:right;width:70px;"/></td>';
						html += '	<td class="center"><input type="text" name="io_stock_qty" value="0" style="text-align:right;width:70px;"/></td>';
						html += '	<td class="center"><input type="text" name="io_noti_qty" value="0" style="text-align:right;width:70px;"/></td>';
						html += '	<td class="center"><select name="io_use" class="select_default" style="width:80px;"><option value="1">사용</option><option value="0">미사용</option></select></td>';
						html += '</tr>';
					}
				});
			}
		});
		
		if(!isNull(html)){
			$("table#addOptionTable > tbody").html(html);
			$("table#addOptionTable").css("display", "table");
		}
	}else{
		defaultAlter("추가옵션 내용을 입력해 주세요.");
		return;
	}
}

//배송비유형 변경
function changeDeliveryType(obj){
	if($(obj).val() == "3"){
		$("#deliveryCondition").css("display","block");
	}else{
		$("#deliveryCondition").css("display","none");
	}
}

//상품전송시 입력값 체크
function itemCheckValidate(){
	
	var mode = isNull($("input[name=item_seq]").val()) ? "C":"U";
	
	if(!getRegExpResult(ITEM_CATEGORY1_EXPRESSION, $("form[name=reg] > input[name=cate_code1]").val())){
		defaultAlert("카테고리가 유효하지 않습니다.");
		return false;
	}
	if(!getRegExpResult(ITEM_CATEGORY2_EXPRESSION, $("form[name=reg] > input[name=cate_code2]").val())){
		defaultAlert("카테고리가 유효하지 않습니다.");
		return false;
	}
	
	if(isNull($("input[name=item_title]").val())){
		defaultAlert("상품제목을 입력해주세요.");
		return false;
	}
	
	if(isNull($("input[name=item_name]").val())){
		defaultAlert("상품명을 입력해주세요.");
		return false;
	}
	
	if(isNull($("input[name=item_keyword]").val())){
		defaultAlert("키워드를 입력해주세요.");
		return false;
	}
	
	if(isNull($("select[name=item_origin]").val())){
		defaultAlert("원산지를 선택해주세요.");
		return false;
	}
	
	if(isNull($("input[name=item_maker]").val())){
		defaultAlert("제조사를 입력해주세요.");
		return false;
	}
	
	//등록, 수정 분기처리
	if(mode == "C"){
		var item_content = oEditors[0].getContents().replace("<p>&nbsp;</p>", "");
		if(isNull(item_content)){
			defaultAlert("상품상세내용을 입력해주세요.");
			return false;
		}else{
			//에디터 내용을 textarea로 복사
			oEditors.getById["item_content"].exec("UPDATE_CONTENTS_FIELD", []);
		}
	}else{
		if(isNull($("textarea[name=item_content]").val())){
			defaultAlert("상품상세내용을 입력해주세요.");
			return false;
		}
	}
	
	var custPrice = $("input[name=item_cust_price]").val().replace(/,/gi, '');
	if(!getRegExpResult(PRICE_EXPRESSION, custPrice)){
		defaultAlert("시중가격이 유효하지 않습니다.");
		return false;
	}else{
		$("input[name=item_cust_price]").val(custPrice);
	}
	
	var price = $("input[name=item_price]").val().replace(/,/gi, '');
	if(!isNull(price)){
		if(!getRegExpResult(PRICE_EXPRESSION, price)){
			defaultAlert("판매가격이 유효하지 않습니다.");
			return false;
		}else{
			$("input[name=item_price]").val(price);
		}
	}
	
	var couponPrice = $("input[name=item_coupon_price]").val().replace(/,/gi, '');
	if(!isNull(couponPrice)){
		if(!getRegExpResult(PRICE_EXPRESSION, couponPrice)){
			defaultAlert("쿠폰할인금액이 유효하지 않습니다.");
			return false;
		}else{
			$("input[name=item_coupon_price]").val(couponPrice);
		}
	}
	
	$("input[name=item_last_price]").val( $("input[name=item_last_price]").val().replace(/,/gi, '') );
	
	if(!getRegExpResult(PRICE_EXPRESSION, $("input[name=item_qty]").val())){
		defaultAlert("재고수량이 유효하지 않습니다.");
		return false;
	}
	
	if(!getRegExpResult(DATE_EXPRESSION, $("input[name=item_sell_period_from]").val())){
		defaultAlert("상품판매기간 시작일자가 유효하지 않습니다.");
		return false;
	}
	if(!getRegExpResult(DATE_EXPRESSION, $("input[name=item_sell_period_to]").val())){
		defaultAlert("상품판매기간 종료일자가 유효하지 않습니다.");
		return false;
	}
	if(!chkDateFromTo($("input[name=item_sell_period_from]").val(), $("input[name=item_sell_period_to]").val())){
		defaultAlert("상품판매기간 시작일자는 종료일자보다 클 수 없습니다.");
		return false;
	}
	
	if(!$("input[name=item_tag]").is(":checked")){
		defaultAlert("상품태그를 선택해주세요.");
		return false;
	}
	var tagVal = '';
	var tagCnt = 0;
	$("input.item_tag_sub").each(function(){
		if($(this).is(":checked")){
			if(tagCnt == 0){
				tagVal = this.value;
			}else{
				tagVal = tagVal + ',' + this.value;
			}
			tagCnt++;
		}
	});
	if(tagCnt == 0){
		defaultAlert("상품태그를 한개 이상 선택해주세요.");
		return false;
	}
	$("input[name=item_tag_sub]").val(tagVal);
	
	if(isNull($("select[name=item_delivery_charge_type]").val())){
		defaultAlert("배송비유형을 선택해주세요.");
		return false;
	}
	
	//대표이미지 체크
	if(mode == "C"){
		if(isNull($("input[name=item_represent_image]").val())){
			defaultAlert("상품대표이미지를 선택해주세요.");
			return false;
		}
		
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_represent_image]").val())){
			defaultAlert("상품대표이미지는 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}else{
		if(!isNull($("input[name=item_represent_image]").val())){
			if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_represent_image]").val())){
				defaultAlert("상품대표이미지는 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
				return false;
			}
		}
	}
	
	if(!isNull($("input[name=item_img1]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_img1]").val())){
			defaultAlert("상품이미지1은 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	if(!isNull($("input[name=item_img2]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_img2]").val())){
			defaultAlert("상품이미지2는 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	if(!isNull($("input[name=item_img3]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_img3]").val())){
			defaultAlert("상품이미지3은 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	if(!isNull($("input[name=item_img4]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_img4]").val())){
			defaultAlert("상품이미지4는 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	if(!isNull($("input[name=item_img5]").val())){
		if(!getRegExpResult(IMAGE_EXPRESSION, $("input[name=item_img5]").val())){
			defaultAlert("상품이미지5는 gif, jpg, jpeg, png 파일만 업로드 가능합니다.");
			return false;
		}
	}
	
	//상품필수(선택)옵션체크
	var selectOptionTr = $("table#selectOptionTable > tbody > tr");
	var isValidOption = true;
	if(selectOptionTr.length > 0){
		$(selectOptionTr).each(function(){
			if(!getRegExpResult(PRICE_EXPRESSION, $(this).find("input[name=io_price]").val())){
				defaultAlert("선택옵션 추가금액이 유효하지 않습니다.");
				isValidOption = false;
				return;
			}
			if(!getRegExpResult(PRICE_EXPRESSION, $(this).find("input[name=io_stock_qty]").val())){
				defaultAlert("선택옵션 재고수량이 유효하지 않습니다.");
				isValidOption = false;
				return;
			}
		});
	}
	if(!isValidOption){
		return false;
	}
	
	//상품필수옵션 재고수량 체크
	//옵션 재고수량을 더해서 상품의 재고수량값을 변경
	var totalOptionQty = 0;
	if(selectOptionTr.length > 0){
		$(selectOptionTr).each(function(){
			totalOptionQty = totalOptionQty + Number($(this).find("input[name=io_stock_qty]").val());
		});
		$("input[name=item_qty]").val(totalOptionQty);
	}
	
	//상품추가옵션체크
	var addOptionTr = $("table#addOptionTable > tbody > tr");
	var isValidOption = true;
	if(addOptionTr.length > 0){
		$(addOptionTr).each(function(){
			if(!getRegExpResult(PRICE_EXPRESSION, $(this).find("input[name=io_price]").val())){
				defaultAlert("추가옵션 추가금액이 유효하지 않습니다.");
				isValidOption = false;
				return;
			}
			if(!getRegExpResult(PRICE_EXPRESSION, $(this).find("input[name=io_stock_qty]").val())){
				defaultAlert("추가옵션 재고수량이 유효하지 않습니다.");
				isValidOption = false;
				return;
			}
		});
	}
	if(!isValidOption){
		return false;
	}
	
	return true;
}

//상품등록
function itemRegist(){
	
	if(!itemCheckValidate()){
		return;
	}
	
	//Get form
	var form = $('form[name=reg]')[0];
	//Create an FormData object
	var data = new FormData(form);
	
	defaultConfirm("상품을 등록하시겠습니까?", function(){
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/item/insertItemAjax.do",
			data: data,
			processData: false,
			contentType: false,
			cache: false,
			success: function(result, status, xhr){
				if(result.result == AJAX_RESULT_SUCCESS){
					defaultAlert(result.message,null,function(){
						location.href = '/seller/sellRegistItemList.do';
					});
				}else{
					defaultAlert(result.message);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				if(jqXHR.status == 300){
					defaultAlert("로그인이 필요합니다.");
				}else{
					defaultAlter("상품등록에 실패하였습니다.");
				}
			}
		});
	});
}

//카테고리 세팅
function setCategory(jsonCateInfo){
	$("input[name=cate_code1]").val(jsonCateInfo.cate_code1);
	$("input[name=cate_code2]").val(jsonCateInfo.cate_code2);
	$("input[name=cate_code3]").val(jsonCateInfo.cate_code3);
	
	var cateStr = jsonCateInfo.cate_name1.replace(" ☞", "") + " > " + jsonCateInfo.cate_name2.replace(" ☞", "");
	if(jsonCateInfo.cate_code3 != null && jsonCateInfo.cate_code3 != ""){
		cateStr = cateStr + " > " + jsonCateInfo.cate_name3;
	}
	$("div#categorySpan").text(cateStr);
	
	closePopupLayer();
}

function closePopupLayer(){
	$("div#mainPopupLayer").css("display", "none");
}

//상품업데이트
function updateItem(){
	if(!itemCheckValidate()){
		return;
	}
	
	//Get form
	var form = $('form[name=reg]')[0];
	//Create an FormData object
	var data = new FormData(form);
	
	defaultConfirm("상품을 저장하시겠습니까?", function(){
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/item/updateItemAjax.do",
	        data: data,
	        processData: false,
	        contentType: false,
	        cache: false,
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		defaultAlert(result.message,null,function(){
	        			location.href = '/seller/sellRegistItemList.do';
	        		});
	        	}else{
	        		defaultAlert(result.message);
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	        	if(jqXHR.status == 300){
	        		defaultAlert("로그인이 필요합니다.");
	        	}
	        }
	    });
	});
}

//상품가격세팅
function setItemPrice(){
	var custPrice = isNull($("input[name=item_cust_price]").val()) ? "0" : $("input[name=item_cust_price]").val();
	var price = isNull($("input[name=item_price]").val()) ? "0" : $("input[name=item_price]").val();
	var couponPrice = isNull($("input[name=item_coupon_price]").val()) ? "0" : $("input[name=item_coupon_price]").val();
	var lastPrice = "0";
	
	custPrice = custPrice.replace(/,/gi, '');
	price = price.replace(/,/gi, '');
	couponPrice = couponPrice.replace(/,/gi, '');
	
	if(getRegExpResult(PRICE_EXPRESSION, custPrice) && getRegExpResult(PRICE_EXPRESSION, price) && getRegExpResult(PRICE_EXPRESSION, couponPrice)){
		
		if(Number(custPrice) > 0){
			if(!isNull(price) && price != 0){
				//시중가격보다 판매가격이 클 수 없다
				if(Number(custPrice) <= Number(price)){
					defaultAlert("판매가격은 시중가격보다 크거나 같을 수 없습니다.");
					$("input[name=item_price]").val("");
					$("input[name=item_price]").focus();
					return;
				}else{
					lastPrice = Number(price) - Number(couponPrice);
					if(lastPrice <= 0){
						defaultAlert("할인금액은 판매가격보다 크거나 같을 수 없습니다.");
						$("input[name=item_coupon_price]").val("");
						$("input[name=item_coupon_price]").focus();
						return;
					}
				}
			}else{
				lastPrice = Number(custPrice) - Number(couponPrice);
				if(lastPrice <= 0){
					defaultAlert("할인금액은 시중가격보다 크거나 같을 수 없습니다.");
					$("input[name=item_coupon_price]").val("");
					$("input[name=item_coupon_price]").focus();
					return;
				}
			}
			$("input[name=item_last_price]").val($.number(lastPrice));
		}
	}
}