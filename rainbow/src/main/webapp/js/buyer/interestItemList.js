/**
 * 관심상품 삭제(한건)
 * @param obj
 * @returns
 */
function deleteInterestItem(obj){
	$(obj).parents("tr:first").find("input[name=chk_item_seq]").prop("checked", true);
	deleteInterestItemList();
}

/**
 * 관심상품 전체삭제
 * @param obj
 * @returns
 */
function deleteAllInterestItem(){
	$("input[name=chk_item_seq]").prop("checked", true);
	deleteInterestItemList();
}

/**
 * 관심상품삭제 프로세스
 * @returns
 */
function deleteInterestItemList(){
	
	var interestItemList = new Array();
	
	if($("input[name=chk_item_seq]:checked").length > 0){
		
		$("input[name=chk_item_seq]:checked").each(function(){
			interestItemList.push(Number($(this).val()));
		});
		
//		defaultConfirm("선택된 "+interestItemList.length+"개의 관심상품을 삭제하시겠습니까?", function(){
		defaultConfirm("관심상품을 삭제하시겠습니까?", function(){
			var param = {
				"interestItemList" : JSON.stringify(interestItemList)
			}
			$.ajax({
				type : "POST"
				,url : "/buyer/deleteInterestItemAjax.do"
				,data : param
				,dataType : "json"
				,async : true
				,success : function(result, status, xhr) {
					if(result.result == AJAX_RESULT_SUCCESS){
						defaultAlert("관심상품을 삭제하였습니다.",null,function(){
							window.location.reload();
						});
					}else{
						defaultAlert(result.message,null,function(){
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
		defaultAlert("선택된 상품이 없습니다.");
		return;
	}
}