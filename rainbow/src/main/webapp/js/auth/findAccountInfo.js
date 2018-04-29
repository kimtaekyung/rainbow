/**
 * 
 */
$(document).ready(function(){
	$("input.findType_input[type=radio]").on("change",function(){
		if($(this).attr("id") == "findAccountType_1"){
			$("table#findAccountType_1_view").show();
			$("table#findAccountType_2_view").hide();
		}else{
			$("table#findAccountType_2_view").show();
			$("table#findAccountType_1_view").hide();
		}
	});
});

/*
 * 이메일 셀렉트박스 이벤트
 */
function setMailForm(obj){
	$("#mail2").val(obj.value);
}