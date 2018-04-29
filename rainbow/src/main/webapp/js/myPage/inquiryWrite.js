/**
 * 
 */
$(document).ready(function(){
	$(".uploadfile").on("change", function() {
		var objId = $(this).attr("id");

		var target = $(this).next();
		var val = $(this).val();
		var thisDom = $(this)[0];
		if (thisDom.files && thisDom.files[0]) {

			var reader = new FileReader();
			reader.onload = function(e) {
				$(target).css("max-width", "100%");
				$(target).attr('src', e.target.result);
			}
		} else {

		}
		reader.readAsDataURL(thisDom.files[0]);
		return false;
	});
	
});

function updateFormValidationCheck(){
	
	if(isNull($("select[name=rit_seq]").val())){
		defaultAlert("잘못된 요청입니다.",null,function(){
			window.location.reload();
			return false;
		});
		
		
	}else{
		if (!getRegExpResult(SUPPORT_TYPE_REGULAR_EXPRESSTION, $("select[name=rit_seq]").val())) {
			defaultAlert("잘못된 요청입니다.",null,function(){
				window.location.reload();
				return false;
			});
		}
	}
	
	if(isNull($("input[name=ri_subject]").val())){
		defaultAlert("제목이 입력되지 않았습니다.");
		return false;
	}
	
	if(isNull($("textarea[name=ri_content]").val())){
		defaultAlert("내용이 입력되지 않았습니다.");
		return false;
	}
	
	if(!isNull($("input[name=ri_attach_img_path_1]").val())){
		if (!getRegExpResult(IMAGE_EXPRESSION, $("input[name=ri_attach_img_path_1]").val())) {
			defaultAlert("파일 형식이 올바르지 않니다. (gif, jpg, jpeg, png 파일만 업로드 가능 합니다.)");
			return false;
		}
	}
	
	if(!isNull($("input[name=ri_attach_img_path_2]").val())){
		if (!getRegExpResult(IMAGE_EXPRESSION, $("input[name=ri_attach_img_path_2]").val())) {
			defaultAlert("파일 형식이 올바르지 않니다. (gif, jpg, jpeg, png 파일만 업로드 가능 합니다.)");
			return false;
		}
	}
	
	if(!isNull($("input[name=ri_attach_img_path_3]").val())){
		if (!getRegExpResult(IMAGE_EXPRESSION, $("input[name=ri_attach_img_path_3]").val())) {
			defaultAlert("파일 형식이 올바르지 않니다. (gif, jpg, jpeg, png 파일만 업로드 가능 합니다.)");
			return false;
		}
	}
	
	if(!isNull($("input[name=ri_attach_img_path_4]").val())){
		if (!getRegExpResult(IMAGE_EXPRESSION, $("input[name=ri_attach_img_path_4]").val())) {
			defaultAlert("파일 형식이 올바르지 않니다. (gif, jpg, jpeg, png 파일만 업로드 가능 합니다.)");
			return false;
		}
	}

	if(!isNull($("input[name=ri_attach_img_path_5]").val())){
		if (!getRegExpResult(IMAGE_EXPRESSION, $("input[name=ri_attach_img_path_5]").val())) {
			defaultAlert("파일 형식이 올바르지 않니다. (gif, jpg, jpeg, png 파일만 업로드 가능 합니다.)");
			return false;
		}
	}
	return true;
}


function insertInquiry(){
	
	var validationCheckResult = updateFormValidationCheck();
	
	if(validationCheckResult){
		
		var form = $("form#insertInquiryForm")[0];
		// Create an FormData object
		var data = new FormData(form);
		
		$.ajax({
			type : "POST",
			enctype : 'multipart/form-data',
			url : "/myPage/insertInquiryAjax.do",
			data : data,
			processData : false,
			contentType : false,
			cache : false,
			success : function(result, status, xhr) {
				
				if(result.result == AJAX_RESULT_SUCCESS){
					defaultAlert("상담글 쓰기를 완료 하였습니다.",null,function(){
						location.href="/myPage/inquiryList.do";
					});
				}else{
					
					if(result.data == "1"){
						defaultAlert("제목이 입력되지 않았습니다.");
					}else if(result.data == "2"){
						defaultAlert("내용이 입력되지 않았습니다.");
					}else if(result.data == "3"){
						defaultAlert("잘못된 요청입니다.");
						window.location.reload();
					}else if(result.data == "4"){
						defaultAlert("잘못된 요청입니다.");
						window.location.reload();
					}else if(result.data == "5"){
						defaultAlert("상담글 쓰기중 오류가 발생하였습니다.");
					}
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				if (jqXHR.status == 300) {
					defaultAlert("로그인이 필요합니다.",null,function(){
						location.href="/auth/login.do";
					});
				}
			}
		});
	}
}