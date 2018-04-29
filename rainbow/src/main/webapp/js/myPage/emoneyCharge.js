/**
 * 
 */
$(document).ready(function(){
	$("input[name=cash_amount]").numeric();
	$("input[name=cc_amount]").on("keyup",function(e){
		$("span#cash_amount_sapn").text($.number($(this).val()));
		var beforeCash = $("b#mb_cash_total_b").attr("cash-amount");
		var plus = $(this).val().replace(/,/gi, '');
		var total = Number(beforeCash) + Number(plus);
		$("span#cash_amount_sapn_total").text($.number(total));
		$(this).val($.number($(this).val()));
		stopClickEventBubbling(e);
	});
	
});


/**
 * 이머니 충전 요청 무통장입금만 가능.
 * @returns
 */
function chargeMemberCash(){
	
	console.log("chargeMemberCash");
	//일단 가라 데이터 입력
	//1 : 무통장 입급, 2:신용카드
	
	if($("input[name=cc_pay_type]:checked").val() == "1"){
		
		//테스트 무통장 입금자명 셋팅
		$("input[name=cc_pay_name]").val("김태경");
		//테스트 무통장 입금자명 셋팅
		
		
		
		var validationCheckResult = updateFormValidationCheck();
		
		if(validationCheckResult){
			$("input[name=cc_amount]").val($("input[name=cc_amount]").val().replace(/,/gi, ''));
			var param = $("#emoneyChargeForm").serialize();
			$.ajax({
				type : "POST"
				,url : "/myPage/insertCashChargeAjax.do"
				,data : param
				,dataType : "json"
				,async : true
				,success : function(result, status, xhr) {
					if(result.result == AJAX_RESULT_SUCCESS){
						defaultAlert("충전 신청이 완료 되었습니다",null,function(){
							window.location.reload();
						});
					}else{
						if(result.data == "1"){
							defaultAlert("무통장입금자 입력이 바르지 않습니다.",null,function(){
								window.location.reload();
							});
						}else if(result.data == "2"){
							defaultAlert("이머니 입력이 바르지 않습니다.(10,000 ~ 100,000,000)",null,function(){
								window.location.reload();
							});
						}else if(result.data == "3"){
							defaultAlert("잘못된 요청입니다.",null,function(){
								window.location.reload();
							});
						}else if(result.data == "4"){
							defaultAlert("충전 신청중 오류가 발생하였습니다. 고객센터 문의 바랍니다.",null,function(){
								window.location.reload();
							});
						}else{
							defaultAlert("충전 신청중 오류가 발생하였습니다. 고객센터 문의 바랍니다.",null,function(){
								window.location.reload();
							});
						}
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
	}else{
		defaultAlert('현재 가드 결제가 불가 합니다.');
	}
}

function updateFormValidationCheck(){
	
	
	var amount = $("input[name=cc_amount]").val().replace(/,/gi, '');
	
	if (!getRegExpResult(EMONEY_CHARGE_AMOUNT_REGULAR_EXPRESSTION, amount)) {
		defaultAlert("충전금액 입력이 올바르지 않습니다.");
		return false;
	}
	
	if (!getRegExpResult(ONE_NUMBER_REGULAR_EXPRESSTION, $("input[name=cc_pay_type]").val())) {
		defaultAlert("충전방식 입력이 올바르지 않습니다.");
		return false;
	}
	
	if (!getRegExpResult(NAME_REGULAR_EXPRESSTION, $("input[name=cc_pay_name]").val())) {
		defaultAlert("무통장 입금자명 입력이 바르지 않습니다.");
		return false;
	}
	
	return true;
}
