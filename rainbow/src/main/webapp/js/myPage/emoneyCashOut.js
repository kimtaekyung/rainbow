/**
 * 
 */
$(document).ready(function(){
	
	$("input[name=co_amount]").numeric();
	$("span#mbCashKor").text( "(" + viewKorean($("td#mbCashAmount_td").attr("cash-amount")) + ")");
	
	
	$("input[name=co_amount]").on("keyup",function(e){
		var beforeCash = $("td#mbCashAmount_td").attr("cash-amount");
		var minus = $(this).val();
		var total = Number(beforeCash) - Number(minus);
		$("span#remain_co_amount").text($.number(total));
		$(this).val($.number($(this).val()));
		stopClickEventBubbling(e);
	});
	
});

function cashOut(){
	var validationCheckResult = updateFormValidationCheck();
	if(validationCheckResult){
		$("input[name=co_amount]").val($("input[name=co_amount]").val().replace(/,/gi, ''));
		var param = $("#emoneyCashOutForm").serialize();
		
		$.ajax({
			type : "POST"
			,url : "/myPage/insertCashOutAjax.do"
			,data : param
			,dataType : "json"
			,async : true
			,success : function(result, status, xhr) {
				console.log(result);
				if(result.result == AJAX_RESULT_SUCCESS){
					defaultAlert("출금 신청이 완료 되었습니다",null,function(){
						window.location.reload();
					});
				}else{
					if(result.data == "1"){
						defaultAlert("출금 금액 입력이 바르지 않습니다.",null,function(){
							window.location.reload();
						});
					}else if(result.data == "2"){
						defaultAlert("출금 계좌 설정이 되지 않았습니다.",null,function(){
							window.location.reload();
						});
					}else if(result.data == "3"){
						defaultAlert("출금 계좌 설정이 되지 않았습니다.",null,function(){
							window.location.reload();
						});
					}else if(result.data == "4"){
						defaultAlert("출금 계좌 설정이 되지 않았습니다.",null,function(){
							window.location.reload();
						});
					}else if(result.data == "5"){
						defaultAlert("출근 신청중 알수 없는 오류가 발생하였습니다. 관리자에게 문의하세요",null,function(){
							window.location.reload();
						});
					}else{
						defaultAlert("출근 신청중 알수 없는 오류가 발생하였습니다. 관리자에게 문의하세요",null,function(){
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
}

function updateFormValidationCheck(){
	
	var amount = $("input[name=co_amount]").val().replace(/,/gi, '');
	
	if ((!getRegExpResult(EMONEY_CHARGE_AMOUNT_REGULAR_EXPRESSTION, amount)) || (Number(amount) < 10000)) {
		defaultAlert("충전금액 입력이 올바르지 않습니다.(10,000원 이상 금액을 입력해주세요)");
		return false;
	}
	
	if(Number(amount) > Number($("td#mbCashAmount_td").attr("cash-amount"))){
		defaultAlert("보유하신 현금성 e-money 가 입력하신 출금 금액보다 작습니다.");
		return false;
	}
	
	if(isNull($("input[name=co_bank]").val()) || isNull($("input[name=co_account]").val()) || isNull($("input[name=co_account_name]").val())){
		defaultAlert("출금 계좌 설정이 없습니다.",null,function(){
			location.href="/myPage/memberInfoUpdate.do";
			return false;
		});
	}
	return true;
}
