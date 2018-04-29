$(document).ready(function(){
	$("li.typemenuTab").on("click",function(e){
		location.href="/main/questionAndAnswerList.do?rqt_seq=" + $(this).attr("rqt_seq");
		stopClickEventBubbling(e);
	});
	
	$("li.cs_list_area_li").on("click",function(e){
		if(!isNull($(this).children("div.cs_list_area_div_answer"))){
			if(!$(this).children("div.cs_list_area_div_answer").is(':visible')){
				$(this).children("div.cs_list_area_div_answer").show();
				$(this).find("img.cs_list_area_img_a").attr("src","/images/main/cs_up.png");
			}else{
				$(this).children("div.cs_list_area_div_answer").hide();
				$(this).find("img.cs_list_area_img_a").attr("src","/images/main/cs_down.png");
			}
		}
		stopClickEventBubbling(e);
		
	});
	
	$("div.cs_list_more_div").on("click",function(e){
		
		$("li.cs_list_area_li:not(:visible)").each(function(index){
			if(index < 10){
				$(this).css("display","inline-block");
			}
		});
		
		if($("li.cs_list_area_li:not(:visible)").length > 0){
			$("div.cs_list_more_div").show();
		}else{
			$("div.cs_list_more_div").hide();
		}
		
		stopClickEventBubbling(e);
	});
	
	$("#cs-search-input").keydown(function(key) {
		if (key.keyCode == 13) {
			location.href="/main/questionAndAnswerList.do?search_word="+$(this).val();
		}
	});
});




