var dataRendering = false;
$(document).ready(function(){
	
	//스크롤 페이징
	$(document).scroll(function() {
		var maxHeight = $(document).height();
		var currentScroll = $(window).scrollTop() + $(window).height();
		var hiddenLi = $("li.itemRow_li:hidden");

		if(maxHeight <= currentScroll + ($(document).height()/4) && hiddenLi.length == 0) {
			var page = $("form[name=itemSchFrm] > input[name=p_page]").val();
			var totalPage = $("form[name=itemSchFrm] > input[name=p_total_page]").val();
			if(!dataRendering && Number(page) < Number(totalPage)){
				dataRendering = true;      
				getItemList();
			}    
		}
		//화면스크롤시 상품 FadeIn()
		if(currentScroll > (maxHeight-100) && hiddenLi.length > 0){
			$(hiddenLi).each(function(idx){
				if(idx < 4){
					$(this).fadeIn(500);
				}
			});
		}
	});
});

/**
 * 정렬 검색조건 클릭
 * @param orderType
 * @returns
 */
function searchItemListInOrder(orderType){
	$("form[name=itemSchFrm] > input[name=p_sch_order]").val(orderType);
	searchItemList();
}

/**
 * 네비 카테고리 클릭
 * @param navi
 * @returns
 */
function searchItemListInNavi(navi){
	if(navi == "0"){
		$("form[name=itemSchFrm] > input[name=p_cate_code1]").val("");
		$("form[name=itemSchFrm] > input[name=p_cate_code2]").val("");
	}else if(navi == "1"){
		$("form[name=itemSchFrm] > input[name=p_cate_code2]").val("");
	}
	searchItemList();
}

//상품조회 AJAX
function getItemList(){
	$("form[name=itemSchFrm] > input[name=p_page]").val( Number($("form[name=itemSchFrm] > input[name=p_page]").val())+1 );
	
	$.ajax({
        type: "POST",
        url: "/item/getItemListAjax.do",
        data: $("form[name=itemSchFrm]").serialize(),
        dataType : "json",
		async : true,
        success: function(result, status, xhr){
        	var html = '';
    		$(result.itemList).each(function(idx, data){
    			
    			var arrTagSub = data.ITEM_TAG_SUB.split(',');
    			
    			html += '<li class="itemRow_li '+(data.ITEM_QTY==0?'soldOut':'')+'" style="display:none;">';
    			html += '	<a class="itemThumb_a" href="javascript:void(0);" onclick="javascript:moveItemViewPage(\''+data.ITEM_SEQ+'\',\''+data.ITEM_REPRESENT_IMAGE+'\'); return false;" >';
    			html += '		<img item_seq="'+data.ITEM_SEQ+'"onerror="this.src=\'http://via.placeholder.com/220x220\'" class="itemThumb_img draggableItem" src="'+data.ITEM_REPRESENT_IMAGE+'" alt="'+data.ITEM_NAME+'" title="'+data.ITEM_NAME+'">';
    			if(data.ITEM_QTY == 0){
    				html += '	<img class="soldOut_img" src="/images/common/soldOut.png">';
    			}
    			html += '	</a>';
    			html += '	<div class="itemTitle_div">';
    			html += '		<div class="itemTitleInner_div"></div>';
    			html += '		<a class="itemTitleInner_a" href="javascript:void(0);" onclick="javascript:moveItemViewPage(\''+data.ITEM_SEQ+'\',\''+data.ITEM_REPRESENT_IMAGE+'\'); return false;">'+data.ITEM_TITLE+'</a>';
    			html += '	</div>';
    			html += '	<div class="itemState_div">';
    			html += '		<div class="itemPrice_div">';
    			html += '			<b class="itemPriceBefore_b"><del>'+$.number(data.ITEM_CUST_PRICE)+'</del></b>원<strong class="itemPriceAfter_b">'+$.number(data.ITEM_LAST_PRICE)+'</strong>원';
    			html += '		</div>';
    			html += '		<div class="itemDelivery_div">';
    			html += '			<span class="itemInventoryText_div">재고</span>';
    			html += '			<span class="itemInventoryText_div">|</span>';
    			html += '			<span class="itemInventoryAmount_div"><b>'+data.ITEM_QTY+'</b>개</span>';
    			html += '			<span class="itemDelivery_div">'+data.ITEM_DELIVERY_CHARGE_TYPE_NAME+'</span>';
    			html += '		</div>';
    			html += '	</div>';
    			html += '	<ul class="itemTag_ul">';
    			html += '		<li class="itemTag_li_type1">'+data.ITEM_TAG_NAME+'</li>';
    			for(var i in arrTagSub){
    				html += '	<li class="itemTag_li_type'+(Number(i)+2)+'">'+arrTagSub[i]+'</li>';
    			}
    			if(arrTagSub.length < 5){
    				for(var i=arrTagSub.length+1; i<5; i++){
    					html += '<li class="none"></li>';
    				}
    			}
    			html += '	</ul>';
    			html += '</li>';
    			
    		});
    		$("ol#itemListArea_ol").append(html);
    		
    		dataRendering = false;
    		
    		if(!isNull($("div#IHeaderWishBox").css("right"))){
    			//드래그 바인딩
    			$(".draggableItem").draggable({
    				helper: 'clone'   //원본이 아닌 복사본으로
    					,appendTo:'body'  //드래그 효과가 보이는 레이어층
//  						,revert: true     //원레 위치로 돌아가는 효과
    						,zIndex:100		  //같은 높이의 레이어 에서 zindex 가 필요할때.
    						,scroll: false
    						,start: function(e, ui) {
    							$(ui.helper).addClass("ui-draggable-helper");
    							var right = $("div#IHeaderWishBox").css("right").replace("px","");
    							if(Number(right) < 0 ){
    								$("button#wishBtn").removeClass("on");
    								$("div#IHeaderWishBox").animate({ "right": "0px" }, "fast" );
    							}
    						}
	    			,drag: function() {
	    			}
	    			,stop: function() {
	
	    			}
    			});
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