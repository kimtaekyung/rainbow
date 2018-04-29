$(document).ready(function(){
	$("#schFrm").find("input").on('keypress', function(e){
		if(e.keyCode == 13){
			searchFormSubmit('schFrm');
		}
	});
});

//답변보기
function viewAnswer(obj, iqaSeq){
	var target = $(obj).parents('li.lSupportList').find('div.lSupportDetailWrap');
	if($(target).css("display") == "none"){
		
		$.ajax({
	        type: "POST",
	        url: "/buyer/getShopItemQaContentListAjax.do",
	        data: {
	        	"iqa_seq":iqaSeq
	        },
	        dataType : "json",
			async : true,
	        success: function(result, status, xhr){
	        	
	        	var html = '';
	        	$(result.contentList).each(function(idx, con){
	        		if(idx == 0){
	        			html += '<div class="lSupportQuesWrap">';
	        			html += '	<div class="lSupportQAimg">';
	        			html += '		<img src="/images/item/view/ico_'+(con.CONTENT_TYPE=='0'?'question':'answer')+'.png">';
	        			html += '	</div>';
	        			html += '	<div class="lSupportQues">';
	        			html += '		<div class="lSupportBId">';
	        			html += '			<b>'+con.MB_NICKNAME+'</b>&nbsp;('+con.CONTENT_REG_DTTM_YMDHIS+')';
	        			html += '		</div>';
	        			html += '		<div class="lSupportBmemo">';
	        			html += '			'+con.CONTENT;
	        			if(!isNull(con.ATTACH_IMAGE)){
	        				html += '		<img src="'+con.ATTACH_IMAGE+'" width="600"/>';
	        			}
	        			html += '		</div>';
	        			html += '	</div>';
	        			html += '</div>';
	        		}else{
	        			html += '<div class="lSupportAnswer">';
	        			html += '	<div class="lSupportQAimg">';
	        			html += '		<img src="/images/item/view/ico_'+(con.CONTENT_TYPE=='0'?'question':'answer')+'.png">';
	        			html += '	</div>';
	        			html += '	<div class="lSupportAnswerWrap">';
	        			html += '		<div class="lSupportBId">';
	        			html += '			<b>'+con.MB_NICKNAME+'</b>&nbsp;('+con.CONTENT_REG_DTTM_YMDHIS+')';
	        			html += '		</div>';
	        			html += '		<div class="lSupportBmemo2">';
	        			html += '			'+con.CONTENT;
	        			if(!isNull(con.ATTACH_IMAGE)){
	        				html += '		<img src="'+con.ATTACH_IMAGE+'" width="600"/>';
	        			}
	        			html += '		</div>';
	        			html += '	</div>';
	        			html += '</div>';
	        		}
	        	});
	        	
	        	$(target).find("div.lSupportQAwrap").html(html);
	        	$(target).find("input[name=content_order]").val(result.contentList.length + 1);
	        	$("div.lSupportDetailWrap").css("display", "none");	//열려있는 답변을 모두 닫는다
	        	$(target).css("display", "block");	//선택한 답변만 열기
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
		$(target).css("display", "none");
	}
}

//문의글 재질문 등록
function insertShopItemQaContent(obj, iqaSeq){
	
	var form = $(obj).parents('form:first');
	
	if(isNull($(form).find("textarea").val())){
		defaultAlert("내용을 입력해 주세요.");
		return;
	}
	
	var form = form[0];
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
        		$(form).find("textarea").val('');
        		$(form).find("input[name=attach_image]").val('');
        		viewAnswer(obj, iqaSeq);	
        		viewAnswer(obj, iqaSeq);	//열려있는 답변영역 재조회를 위해 답변 두번호출
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