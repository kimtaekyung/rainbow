$(document).ready(function(){
	itemCategoryListAjax();
});

/**
 * 카테고리 목록조회
 */
var categoryList = [];
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
				
				var pCateCode1 = $("input[name=p_cate_code1]").val();
				var strSelected = "";
				$(categoryList).each(function(idx, obj){
					strSelected = "";
					if(obj.CATE_DEPTH == 1){
						if(!isNull(pCateCode1) && obj.CATE_CODE == pCateCode1){
							strSelected = "selected";
						}
						$("select#category1").append('<option value="'+obj.CATE_CODE+'" '+strSelected+'>'+obj.CATE_NAME+'</option>');
					}
				});
				
				if(!isNull(pCateCode1)){
					selectCategory(1);
				}
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			defaultAlert("시스템오류입니다. 1:1문의 바랍니다.");
		}
	});
}

/**
 * 카테고리 선택
 * @param depth
 * @returns
 */
function selectCategory(depth){
	if(depth == 1){
		$("select#category2").empty();
		$("select#category3").empty();
		$("select#category2").append('<option value="">선택하세요</option>');
		$("select#category3").append('<option value="">상위분류를 선택하세요</option>');
		
		var pCateCode2 = $("input[name=p_cate_code2]").val();
		var strSelected = "";
		$(categoryList).each(function(idx, obj){
			strSelected = "";
			if(obj.CATE_DEPTH == 2 && $("select#category1").val() == obj.CATE_CODE.substring(0, 3) ){
				if(!isNull(pCateCode2) && obj.CATE_CODE == pCateCode2){
					strSelected = "selected";
				}
				$("select#category2").append('<option value="'+obj.CATE_CODE+'" '+strSelected+'>'+obj.CATE_NAME+'</option>');
			}
		});
		
		if(!isNull(pCateCode2)){
			selectCategory(2);
		}
	}else if(depth == 2){
		$("select#category3").empty();
		$("select#category3").append('<option value="">선택하세요</option>');
		
		var pCateCode3 = $("input[name=p_cate_code3]").val();
		var strSelected = "";
		$(categoryList).each(function(idx, obj){
			strSelected = "";
			if(obj.CATE_DEPTH == 3 && $("select#category2").val() == obj.CATE_CODE.substring(0, 5) ){
				if(!isNull(pCateCode3) && obj.CATE_CODE == pCateCode3){
					strSelected = "selected";
				}
				$("select#category3").append('<option value="'+obj.CATE_CODE+'" '+strSelected+'>'+obj.CATE_NAME+'</option>');
			}
		});
	}
}

/**
 * 상품 진열,숨김
 * @param itemSeq
 * @param itemDisplay
 * @returns
 */
function updateShopItemDisplay(itemSeq, itemDisplay){
	
	$.ajax({
		type : "POST"
		,url : "/seller/updateShopItemDisplayAjax.do"
		,data : {
			"item_seq":itemSeq,
			"item_display":itemDisplay
		}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				location.reload();
			}else{
				defaultAlert(result.message);
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			defaultAlert("시스템오류입니다. 1:1문의 바랍니다.");
		}
	});
}

/**
 * 선택상품 진열, 숨김
 * @returns
 */
function updateShopItemDisplayCheckItem(){
	var itemDisplay = $("select[name=sel_item_display]").val();
	var itemSeq = '';
	
	if($("input[name=chk_item_seq]:checked").length > 0){
		$("input[name=chk_item_seq]:checked").each(function(){
			if(isNull(itemSeq)){
				itemSeq = "'" + this.value + "'";
			}else{
				itemSeq = itemSeq + ",'" + this.value + "'";
			}
		});
		
		defaultConfirm("선택된 상품을 "+(itemDisplay == "1" ? "숨기":"진열하")+"시겠습니까?", function(){
			updateShopItemDisplay(itemSeq, itemDisplay);
		});
	}else{
		defaultAlert("선택된 상품이 없습니다.");
		return;
	}
	
}

/**
 * 판매자가 상품 상태변경
 * @returns
 */
function updateShopItemStatus(obj, itemSeq){
	var itemStatus = $(obj).parents("td:first").find("select[name=save_item_status]").val();
	if(isNull(itemStatus)){
		defaultAlert("변경할 상태를 선택해 주세요.");
		return;
	}
	
	defaultConfirm("상태를 변경하시겠습니까?", function(){
		$.ajax({
			type : "POST"
			,url : "/seller/updateShopItemStatusAjax.do"
			,data : {
				"item_seq":itemSeq,
				"item_status":itemStatus
			}
			,dataType : "json"
			,async : true
			,success : function(result, status, xhr) {
				if(result.result == AJAX_RESULT_SUCCESS){
					location.reload();
				}else{
					defaultAlert(result.message);
				}
			}
			,error : function(jqXHR, textStatus, errorThrown) {
				if(jqXHR.status == 300){
	        		defaultAlert("로그인이 필요합니다.!!");
	        	}else{
	        		defaultAlert("고객센터에 문의주세요.");
	        	}
			}
		});
	});
}