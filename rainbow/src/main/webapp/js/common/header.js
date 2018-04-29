/**
 * 
 */
$(document).ready(function(){
	getCategoryList();
	getSearchTextRankList();
	$("li.subMenu").on("mouseover",function(e){
		if($(this).children("ul")){
			$(this).children("ul").show();
		}
	});
	$("li.subMenu").on("mouseout",function(e){
		if($(this).children("ul")){
			$(this).children("ul").hide();
		}
	});
	$("button.WishBtn").on("click",function(e){
		animateHeaderWishBox();
		stopClickEventBubbling(e);
	});
	/**
	 * 관심상품 금액 분류 버튼 클릭
	 */
	$("a.priceTab_li").on("click",function(e){
		//페이징 값 초기화
		$("input[name=pageAjaxData]").val(1);
		//현재 클릭 된 금액 범위 타입을 넘긴다.
		getMyInterestItemList($(this).attr("price"));
		stopClickEventBubbling(e);
	});
	
	$("div#hSearchBoxMenu").on("mouseover",function(){
		$("ul#searchList").show();
	});
	
	$("div#hSearchBoxMenu").on("mouseout",function(){
		$("ul#searchList").hide();
	});
	
	$("ul#searchList li").on("click",function(e){
		$("ul#searchList").hide();
		$("span#searchView").text($(this).text());
	});
});

/**
 * 페이징 버튼클릭
 * @param type
 * @returns
 */
function pageingPlusMinus(plusOrMinus){
	//현재 페이징 값
	var page = $("input[name=pageAjaxData]").val();
	
	//최대 페이징 값
	var maxPage = $("input#maxPage").val();
	page = plusOrMinus == "plus" ? Number(page) + Number(1) : Number(page) - Number(1);
	
	//처음 페이지 또는 마지막 페이지 일 경우는 아무일도일어 나지 않는다.
	if(page < 1 || page > maxPage){
		return;
	}else{
		$("input[name=pageAjaxData]").val(page);
		
		//기본은 전체 선택되어있을경우 선택된 타입으로 getMyInterestItemList 함수를 호출한다.
		var type = "0";
		$("ul#myInterestItemType_ul > li").each(function(){
			if($(this).hasClass("on")){
				type = $(this).children("a").attr("price");
			}
		});
		getMyInterestItemList(type);
	}
	
}

/**
 * 관심 상품 불러오기
 * @param type
 * @returns
 */
function getMyInterestItemList(type){
	
	$("ul#myInterestItemType_ul > li").removeClass("on");
	$("ul#myInterestItemType_ul > li").eq(type).addClass("on");
	
	var pageAjaxData = $("input[name=pageAjaxData]").val();
	var pageSizeAjaxData = $("input[name=pageSizeAjaxData]").val();
	
	var param = {
		"page" : pageAjaxData
		,"pageSize" : pageSizeAjaxData
		,"type" : type
	}
	
	$.ajax({
		type : "POST"
		,url : "/buyer/getMyInterestItemListAjax.do"
		,data : param
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				$("ul#interestItemList_ul").empty();
				//관심상품이 있을경우.
				if(result.myInterestItemList.length > 0){
					
					var html = '';
					
					for(var i in result.myInterestItemList){
						html += '<li>';
						html += '	<button onclick="javascript:deleteIterestItem('+result.myInterestItemList[i].ITEM_SEQ+','+result.type+'); return false;">닫기</button>';
						html += '	<a href="#">';
						html += '		<img src="'+result.myInterestItemList[i].ITEM_REPRESENT_IMAGE+'" alt="상품이미지">';
						html += '	</a>';
						html += '	<p>'+result.myInterestItemList[i].ITEM_NAME+'</p>';
						html += '	<span>'+$.number(result.myInterestItemList[i].ITEM_LAST_PRICE)+'</span>';
						html += '</li>';
					}
					$("ul#interestItemList_ul").append(html);
					$("strong#nowPage_strong").text(result.page);
					$("span#totalPage_span").text(result.totalPage);
					$("input[name=pageAjaxData]").val(result.page);
					$("input#maxPage").val(result.totalPage);
					$("div#interestItemListEmpty_div").css("display","none");
					$("div#interestItemList_div").css("display","block");
					$("div#interestItemListPageing_div").css("display","block");
					
					
				}else{
					$("div#interestItemList_div").css("display","none");
					$("div#interestItemListEmpty_div").css("display","block");
					$("div#interestItemListPageing_div").css("display","none");
				}
			}else{
				if(result.data == "1"){
					defaultAlert("일반회원 전용입니다.");
				}else{
					defaultAlert("잘못된 요청 입니다");
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

/**
 * 관심상품 삭제하기
 * @param item_seq
 * @returns
 */
function deleteIterestItem(item_seq,type){
	
	var pageAjaxData = $("input[name=pageAjaxData]").val();
	var pageSizeAjaxData = $("input[name=pageSizeAjaxData]").val();
	var param = {
		"page" : pageAjaxData
		,"pageSize" : pageSizeAjaxData
		,"type" : type
		,"item_seq" : item_seq
	}
	
	$.ajax({
		type : "POST"
		,url : "/buyer/deleteMyInterestItemAjax.do"
		,data : param
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			
			if(result.result == AJAX_RESULT_SUCCESS){
				$("ul#interestItemList_ul").empty();
				//관심상품이 있을경우.
				if(result.myInterestItemList.length > 0){
					
					var html = '';
					
					for(var i in result.myInterestItemList){
						html += '<li>';
						html += '	<button onclick="javascript:deleteIterestItem('+result.myInterestItemList[i].ITEM_SEQ+','+result.type+'); return false;">닫기</button>';
						html += '	<a href="#">';
						html += '		<img src="'+result.myInterestItemList[i].ITEM_REPRESENT_IMAGE+'" alt="상품이미지">';
						html += '	</a>';
						html += '	<p>'+result.myInterestItemList[i].ITEM_NAME+'</p>';
						html += '	<span>'+$.number(result.myInterestItemList[i].ITEM_LAST_PRICE)+'</span>';
						html += '</li>';
					}
					$("ul#interestItemList_ul").append(html);
					$("strong#nowPage_strong").text(result.page);
					$("span#totalPage_span").text(result.totalPage);
					$("input[name=pageAjaxData]").val(result.page);
					$("input#maxPage").val(result.totalPage);
					$("div#interestItemListEmpty_div").css("display","none");
					$("div#interestItemList_div").css("display","block");
					$("div#interestItemListPageing_div").css("display","block");
					
					if(typeof setInterestItemHeartImage == 'function') {
						console.log("call delete after setInterestItemHeartImage().....");
						setInterestItemHeartImage(item_seq);  
					}
					
				}else{
					$("div#interestItemList_div").css("display","none");
					$("div#interestItemListEmpty_div").css("display","block");
					$("div#interestItemListPageing_div").css("display","none");
				}
				
				defaultNotice("관심상품이 삭제되었습니다.");
				
			}else{
				if(result.data == "1"){
					defaultAlert("일반회원 전용입니다.");
				}else if(result.data == "6"){
					defaultAlert("이미 삭제된 관심상품 입니다.");
				}else{
					defaultAlert("잘못된 요청 입니다");
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

/**
 * 관심상품 추가하기
 * @param itemSeq
 * @returns
 */
function insertInterestItem(itemSeq,type){
	
	var pageAjaxData = $("input[name=pageAjaxData]").val();
	var pageSizeAjaxData = $("input[name=pageSizeAjaxData]").val();
	var param = {
		"page" : pageAjaxData
		,"pageSize" : pageSizeAjaxData
		,"type" : type
		,"item_seq" : itemSeq
	}
	
	$.ajax({
		type : "POST"
		,url : "/buyer/insertMyInterestItemAjax.do"
		,data : param
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				$("ul#interestItemList_ul").empty();
				//관심상품이 있을경우.
				if(result.myInterestItemList.length > 0){
					
					var html = '';
					
					for(var i in result.myInterestItemList){
						html += '<li>';
						html += '	<button onclick="javascript:deleteIterestItem('+result.myInterestItemList[i].ITEM_SEQ+','+result.type+'); return false;">닫기</button>';
						html += '	<a href="#">';
						html += '		<img src="'+result.myInterestItemList[i].ITEM_REPRESENT_IMAGE+'" alt="상품이미지">';
						html += '	</a>';
						html += '	<p>'+result.myInterestItemList[i].ITEM_NAME+'</p>';
						html += '	<span>'+$.number(result.myInterestItemList[i].ITEM_LAST_PRICE)+'</span>';
						html += '</li>';
					}
					$("ul#interestItemList_ul").append(html);
					$("strong#nowPage_strong").text(result.page);
					$("span#totalPage_span").text(result.totalPage);
					$("input[name=pageAjaxData]").val(result.page);
					$("input#maxPage").val(result.totalPage);
					$("div#interestItemListEmpty_div").css("display","none");
					$("div#interestItemList_div").css("display","block");
					$("div#interestItemListPageing_div").css("display","block");
					
					if(typeof setInterestItemHeartImage == 'function') {
						console.log("call insert after setInterestItemHeartImage().....");
						setInterestItemHeartImage(itemSeq);  
					}
					
				}else{
					$("div#interestItemList_div").css("display","none");
					$("div#interestItemListEmpty_div").css("display","block");
					$("div#interestItemListPageing_div").css("display","none");
				}
				
				defaultNotice("관심상품이 추가되었습니다.");
				
			}else{
				if(result.data == "1"){
					defaultAlert("일반회원 전용입니다.");
				}else if(result.data == "6"){
					defaultAlert("이미 추가된 관심상품 입니다.");
				}else if(result.data == "7"){
					defaultAlert("관심상품 추가중 오류가 발생하였습니다. 관리자에게 문의하세요.");
				}else if(result.data == "8"){
					defaultAlert("존재 하지 않는 상품입니다.",null,function(){
						window.location.reload();
					});
				}else if(result.data == "9"){
					defaultAlert("판매가 종료된 상품 입니다.",null,function(){
						window.location.reload();
					});
				}else if(result.data == "10"){
					defaultAlert("삭제된 상품 입니다.",null,function(){
						window.location.reload();
					});
				}else{
					defaultAlert("잘못된 요청 입니다.");
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

/**
 * 인기검색어 조회
 * @returns
 */
function getSearchTextRankList(){
	$.ajax({
		type : "POST"
		,url : "/main/getSearchTextRankListAjax.do"
		,data : null
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.result == AJAX_RESULT_SUCCESS){
				if(result.searchTextRankList.length > 0){
					for(var i in result.searchTextRankList){
						$("#hPopularTitleList_area_ul").append($("<li>").addClass("textLimit").attr("searchText",result.searchTextRankList[i].RST_TEXT).on("click",function(){
							$("input[name=search_text]").val($(this).attr("searchText"));
							searchItemListInBox();
						})
								.append($("<div>").addClass(i < 3 ? "searchTextRoll_div_red" : "searchTextRoll_div_grey").text(Number(i)+1))
								.append($("<a>").addClass("searchTextRoll_a").text(result.searchTextRankList[i].RST_TEXT)));
						$("#hPopularTitle_area_ul").append($("<li>").addClass("textLimit")
											.append($("<div>").addClass(i < 3 ? "searchTextRoll_div_red" : "searchTextRoll_div_grey").text(Number(i)+1))
											.append($("<a>").addClass("searchTextRoll_a").text(result.searchTextRankList[i].RST_TEXT)));
						
					}
					$("#hPopularTitle_area_div").vTicker({
						speed : 1000
						,pause : 2000
						,showItems : 1
						,height:20
						,padding:2
					});
				}
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			
		}
	});
}

/**
 * 카테고리 리스트 조회
 * @returns
 */
function getCategoryList(){
	$.ajax({
        type: "POST",
        url: "/categoryListAjax.do",
        data: {},
        processData: false,
        contentType: false,
        cache: false,
        success: function(result, status, xhr){
        	var categoryList = [];
        	if(result.result == AJAX_RESULT_SUCCESS && result.resultData != null && result.resultData.length > 0){
        		categoryList = result.resultData;
        		
        		var html = '';
        		for(var i=0; i<categoryList.length; i++){
        			if(categoryList[i].CATE_DEPTH == 1){
        				html += '<div class="lMainTopCate1">';
        				html += '	<div class="lMainTopCate1Sel"><a class="lMainTopCate1Sel_a" cate_code1="'+categoryList[i].CATE_CODE+'" onclick="searchItemListInHeader(this);">'+categoryList[i].CATE_NAME+'</a><img class="lMainTopCate1Sel_img" style="display:none;" src="/images/common/header/menu_arrow_right.png"></div>';
        				html += '		<div class="lMainTopCate2" style="display: none;">';
        				html += '			<div class="lMainTopCate2_menu">';		
        				for(j=0; j<categoryList.length; j++){
        					if(categoryList[j].CATE_DEPTH == 2 && categoryList[i].CATE_CODE == categoryList[j].CATE_CODE.substring(0,3)){
	        						html += '	<div class="lMainTopCate2_inner">';
	        						html += '		<div cate_code1="'+categoryList[i].CATE_CODE+'" cate_code2="'+categoryList[j].CATE_CODE+'" class="lMainTopCate2List" onclick="searchItemListInHeader(this);">'+categoryList[j].CATE_NAME+'</div>';
	        						html += '	</div>';
        					}
        				}
        				html += '			</div>';
        				html += '			<div class="adItemImage_div">';
        				html += '				<img onclick="javascript:location.href = \'/item/itemView.do?item_seq='+categoryList[i].CATE_ADVERTISE_ITEM_SEQ+'\'" class="adItemImage_img" onerror="this.src=\'http://via.placeholder.com/300x290\'" src="'+categoryList[i].CATE_ADVERTISE_IMG+'">';
        				html += '			</div>';
        				html += '		</div>';
        				html += '</div>';
        			}
        		}
        		
        		$("div.lMainTopCate").html(html);
        		
        		$("div#lHeaderMenuAllcate").on("mouseover",function(){
        			$("div.lMainTopCate").show();
        		});
        		
        		$("div#lHeaderMenuAllcate").on("mouseout",function(){
        			$("div.lMainTopCate").hide();
        		});
      		
        		$("div.lMainTopCate1").on("mouseover",function(){
        			$(this).find($("div.lMainTopCate2")).show();
        			$(this).find($("img.lMainTopCate1Sel_img")).show();
        		});
        		
        		$("div.lMainTopCate1").on("mouseout",function(){
        			$(this).find($("div.lMainTopCate2")).hide();
        			$(this).find($("img.lMainTopCate1Sel_img")).hide();
        		});
        	}
        },
        error: function(jqXHR, textStatus, errorThrown){
        }
    });
}

/**
 *  카테고리 클릭 상품검색
 * @param obj
 * @returns
 */
function searchItemListInHeader(obj){
	
	if(!isNull($(obj).attr("cate_code1"))){
		cate_code1 = $(obj).attr("cate_code1");
		$("form[name=itemSchFrm] > input[name=p_cate_code1]").val($(obj).attr("cate_code1"));
		$("form[name=itemSchFrm] > input[name=p_cate_code2]").val("");
	}
	if(!isNull($(obj).attr("cate_code2"))){
		$("form[name=itemSchFrm] > input[name=p_cate_code2]").val($(obj).attr("cate_code2"));
	}
	
	searchItemList();
}

/**
 * 가격대별 상품 검색 클릭
 * @returns
 */
function searchItemListInPrice(obj){
	$(obj).parent().addClass("on").siblings().removeClass("on");
	
	var cate_code1 = "";
	var cate_code2 = "";
	var start_price = "";
	var end_price = "";
	if($("div.pageNavigtor_div").length > 0){
		aCate = $("div.pageNavigtor_div").find("a.pageNavigtor_a");
		if($(aCate).length == 2){
			$("form[name=itemSchFrm] > input[name=p_cate_code1]").val($($(aCate).eq(1)).attr("cate_code1"));
		}else if($(aCate).length == 3){
			$("form[name=itemSchFrm] > input[name=p_cate_code1]").val($($(aCate).eq(1)).attr("cate_code1"));
			$("form[name=itemSchFrm] > input[name=p_cate_code2]").val($($(aCate).eq(2)).attr("cate_code2"));
		}
	}
	
	searchItemList();
}

/**
 * 헤더 상품명 검색
 * @returns
 */
function searchItemListInBox(){
	$("form[name=itemSchFrm] > input[name=p_cate_code1]").val("");
	$("form[name=itemSchFrm] > input[name=p_cate_code2]").val("");
	$("form[name=itemSchFrm] > input[name=p_search_type]").val($("span#searchView").text());
	$("form[name=itemSchFrm] > input[name=p_search_text]").val($("input[name=search_text]").val());
	
	searchItemList();
}


/**
 * 상품 목록 검색
 * header, 상품목록 페이지 공통사용
 * @returns
 */
function searchItemList(){
	setHeaderPriceOnMenuValue();
	
	$("form[name=itemSchFrm] > input[name=p_page]").val("1");
	$("form[name=itemSchFrm] > input[name=p_pageSize]").val("12");
	$("form[name=itemSchFrm]").submit();
}

/**
 * 레프트 가격대별 검색 선택되어 있는 금액 파라미터로 세팅
 * @returns
 */
function setHeaderPriceOnMenuValue(){
	$("div.IH_Price > ul > li").each(function(idx, obj){
		if($(obj).hasClass("on")){
			var priceTxt = $(obj).find("a").text();
			$("form[name=itemSchFrm] > input[name=p_price_idx]").val($(obj).index());
			priceTxt = priceTxt.replace(/만원/gi, "")
			if(priceTxt.indexOf("~") > -1){
				var arrTxt = priceTxt.split("~");
				$("form[name=itemSchFrm] > input[name=p_start_price]").val((Number(arrTxt[0])*10000));
				$("form[name=itemSchFrm] > input[name=p_end_price]").val((Number(arrTxt[1])*10000));
			}else{
				if(priceTxt.indexOf("이하") > -1){
					priceTxt = priceTxt.replace("이하", "");
					$("form[name=itemSchFrm] > input[name=p_start_price]").val("");
					$("form[name=itemSchFrm] > input[name=p_end_price]").val((Number(priceTxt)*10000));
				}else if(priceTxt.indexOf("이상") > -1){
					priceTxt = priceTxt.replace("이상", "");
					$("form[name=itemSchFrm] > input[name=p_start_price]").val((Number(priceTxt)*10000));
					$("form[name=itemSchFrm] > input[name=p_end_price]").val("");
				}else{	//전체
					$("form[name=itemSchFrm] > input[name=p_start_price]").val("");
					$("form[name=itemSchFrm] > input[name=p_end_price]").val("");
				}
			}
		}
	});
}