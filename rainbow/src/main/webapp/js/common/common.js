$(document).ready(function(){
	
	//클릭이벤트 잡아서 레이어 감추기
	$(document).on("click",function(e){
		//.hideLayerGroup라는 class를 가진이외의 영역에서 클릭이벤트가 일어났을때
		var container = $(".hideLayerGroup");
		if (!container.is(e.target) && container.has(e.target).length === 0){
			//container가 아닌곳에서 클릭이벤트가 일어낫을 경우만 현재 if문에 들어온다
			$(".hideLayerGroup").css("display","none");
		}
	});
	
	JBOX_MODAL = new jBox("Modal");
	JBOX_IMAGE = new jBox('Image',{
		maxWidth:700
		,maxHeight:500
		,imageCounter : true
		//,closeOnMouseleave : true
	});//<a href="/image1_large.jpg" title="My title 1" data-jbox-image="gallery1"><img src="/image1_small.jpg" alt=""></a> << 사용방법
	
	initLatelyViewItemList();
	
	
//	defaultAlert('aa','aa',function(){
//		console.log("callback");
//	})
	
	$(".datepicker").datepicker();
	/**
	 * 상품 드래그 이벤트 설정
	 */
	
	if(!isNull($("div#IHeaderWishBox").css("right"))){
		$(".draggableItem").draggable({
			helper: 'clone'   //원본이 아닌 복사본으로
			,appendTo:'body'  //드래그 효과가 보이는 레이어층
//			,revert: true     //원레 위치로 돌아가는 효과
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
	
	/**
	 * 관심상품 드롭 이벤트 설정
	 */
	$("#IHeaderWishBox").droppable({
		drop: function( event, ui ){
			//기본은 전체 선택되어있을경우 선택된 타입으로 getMyInterestItemList 함수를 호출한다.
			var type = "0";
			$("ul#myInterestItemType_ul > li").each(function(){
				if($(this).hasClass("on")){
					type = $(this).children("a").attr("price");
				}
			});
			insertInterestItem($(ui.draggable).attr("item_seq"),type);
			stopClickEventBubbling(event);
		}
	});
	
	/**
	 * 파일업로드
	 */
	$(".uploadfile").on("change", function() {
		var objViewId = $(this).attr("view");
		var objPathId = $(this).attr("path");
		var viewTarget = $("#" + objViewId);
		var pathTarget = $("#" + objPathId);
		var val = $(this).val();
		var thisDom = $(this)[0];
		$(pathTarget).text(val);
		
		if (thisDom.files && thisDom.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				console.log(e.target);
				$(viewTarget).attr('src', e.target.result);
				$(viewTarget).css("width","80%");
			}
		}
		reader.readAsDataURL(thisDom.files[0]);
		return false;
	});
	
	$("input.numberData").numeric();
	
	/**
	 * 엘셀 저장 전역 이벤트
	 */
	$("#btn-excel").on("click", function (e) {
		
		var orderName = $("#excelHeaderInfo").attr("orderName");
		var searchFormId = $("#excelHeaderInfo").attr("searchFormId");
		var saveFileName = $("#excelHeaderInfo").attr("saveFileName");
		
		
		var searchInfoObjectList = $("#" + searchFormId).serializeArray();
		var headerInfoObjectList = new Array();
		var searchInfoObject = {};
		
		if(searchInfoObjectList){
			$(searchInfoObjectList).each(function() {
				console.log(this);
				searchInfoObject[this.name] = this.value;
			}); 
		}
	
		$("#excelHeaderInfo").children().each(function(index){
			var keyParam = $(this).attr("keyParam");
			var valueParam = $(this).attr("valueParam");
			
			var obj = {
				"index"	: index + ""
				,"keyParam" : keyParam
				,"valueParam" : valueParam
			}
			headerInfoObjectList.push(obj);
		});	
		
		var param = {
			"orderName" : orderName
			,"searchInfoObject" : JSON.stringify(searchInfoObject)
			,"headerInfoObjectList" : JSON.stringify(headerInfoObjectList)
			,"saveFileName" : saveFileName
		}

	    var $preparingFileModal = $("#preparing-file-modal");
	    $preparingFileModal.dialog({ modal: true });
	    $("#progressbar").progressbar({value: false});
	    $.fileDownload(
	    	"/excel/download.do"
	    	,{
	    		successCallback: function (url) {
	    			$preparingFileModal.dialog('close');
	    		}
	    	,httpMethod: 'POST'
	        //,dataType:"json"
	    	,data: param
	    	,failCallback: function (responseHtml, url) {
	            $preparingFileModal.dialog('close');
	            	$("#error-modal").dialog({ modal: true });
	        	}
	    	}
	    );
        // 버튼의 원래 클릭 이벤트를 중지 시키기 위해 필요합니다.
        stopClickEventBubbling(e);
    });
});

/**
 * 최근 본 상품 관련 로컬 스토리지 공간 확보 일정 시간 지난 것 뺴고 재저장 페이지별 무조건 호출
 * @returns
 */
function initLatelyViewItemList(){
	if(isNull(getItemLocalStorage('latelyViewItemList'))){
		setLocalStorage('latelyViewItemList',null);
		$("ul#latelyViewItemList_ul").append('<li>찾아본<br>상품이<br>없습니다.</li>');
	}else{
		var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
		if(latelyViewItemListJson != "null" || isNull(latelyViewItemListJson)){
			
			var nowDate = new Date();
			
			var latelyViewItemList = JSON.parse(latelyViewItemListJson);
			var latelyViewItemListNew = new Array();
			
			for(var i in latelyViewItemList){
				
				var viewTime = new Date(latelyViewItemList[i].viewTime);
				//시간이 경과된경우 를 제외하고 재 저장
				if(nowDate.getTime() < viewTime.getTime()){
					latelyViewItemListNew.push(latelyViewItemList[i]);
				}
			}
			
			//시간이 모두 경과된 경우 담긴 새로운 배열요소가 없으므로 로컬 스토리지를 비워줌.
			if(latelyViewItemListNew.length == 0){
				setLocalStorage('latelyViewItemList',null);
			}else{
				setLocalStorage('latelyViewItemList',JSON.stringify(latelyViewItemListNew));
			}
			
		}
		LatelyViewItemRender(1);
	}
}

/**
 * 로컬 스토리지 저장 후 아이템 상세보기 페이지 이동
 * @param itemSeq
 * @returns
 */
function moveItemViewPage(itemSeq,itemImagePath){
	
	var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
	var viewTime = new Date();
	//상품 본내역이 없다면.
	if(latelyViewItemListJson == "null" || isNull(latelyViewItemListJson)){
		var latelyViewItemListNew = new Array();
		
		var latelyViewItem = {
			"itemSeq" : itemSeq
			,"itemImagePath" : itemImagePath
			,"viewTime" :viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
		}
		
		latelyViewItemListNew.unshift(latelyViewItem);
		setLocalStorage('latelyViewItemList',JSON.stringify(latelyViewItemListNew));
	//상품을 본내역이 있다면
	}else{
		var latelyViewItemList = JSON.parse(latelyViewItemListJson);
		var isExistsItem = false;
		
		breakPoint : for(var i in latelyViewItemList){
			if(Number(latelyViewItemList[i].itemSeq) == Number(itemSeq)){
				isExistsItem = true; 
				break breakPoint;
			}
		}
		
		//새로본 상품일경우
		if(!isExistsItem){
			
			//최대 50개
			if(latelyViewItemList.length == Number(LATELY_VIEW_ITEM_MAX_SAVE_COUNT)) latelyViewItemList.pop();
			
			var latelyViewItem = {
				"itemSeq" : itemSeq
				,"itemImagePath" : itemImagePath
				,"viewTime" :viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
			}
			latelyViewItemList.unshift(latelyViewItem);
			setLocalStorage('latelyViewItemList',JSON.stringify(latelyViewItemList));
		}
	}
	location.href="/item/itemView.do?item_seq=" + itemSeq;
}

/**
 * 최근 본 상품 화면 셋팅(페이징)
 * @param list
 * @returns
 */
function LatelyViewItemRender(page){
	$("ul#latelyViewItemList_ul").empty();
	
	if(getItemLocalStorage('latelyViewItemList') != "null" || isNull(getItemLocalStorage('latelyViewItemList'))){
		
		var latelyViewItemList = JSON.parse(getItemLocalStorage('latelyViewItemList'));
		var length = latelyViewItemList.length;
		var maxPage = length / LATELY_VIEW_ITEM_PAGEING_SIZE;
		$("div#latelyViewItemListPageing_div").css("display","block");
		$("strong#nowLatelyViewItemPage_strong").text(page);
		$("span#totalLatelyViewItemPage_span").text(Math.ceil(maxPage))
		
		//리스트 인덱스 값을 구한다. 
		for(var i = ((page-1) * LATELY_VIEW_ITEM_PAGEING_SIZE); i < (page*LATELY_VIEW_ITEM_PAGEING_SIZE); i++){
			if(!isNull(latelyViewItemList[i])){
				$("ul#latelyViewItemList_ul").append(
												$("<li>").append(
															$("<a>").attr("href","/item/itemView.do?item_seq="+latelyViewItemList[i].itemSeq)
																.append($("<img>").attr("src",latelyViewItemList[i].itemImagePath)
																				  .attr("alt","최근본상품"))));
			}
		}
		
	}else{
		$("ul#latelyViewItemList_ul").append('<li>찾아본<br>상품이<br>없습니다.</li>');
		$("div#latelyViewItemListPageing_div").css("display","none");
	}
	
}

/**
 * 최근 본 상품 페이지 버튼 클릭
 * @param type
 * @returns
 */
function latelyViewItemPageingPlusMinus(type){
	
	if(type == "minus"){
		if(Number($("strong#nowLatelyViewItemPage_strong").text()) > 1){
			$("strong#nowLatelyViewItemPage_strong").text(Number($("strong#nowLatelyViewItemPage_strong").text()) - 1);
			LatelyViewItemRender($("strong#nowLatelyViewItemPage_strong").text());
		}
		
	}else{
		if(Number($("strong#nowLatelyViewItemPage_strong").text()) < Number($("span#totalLatelyViewItemPage_span").text())){
			$("strong#nowLatelyViewItemPage_strong").text(Number($("strong#nowLatelyViewItemPage_strong").text()) + 1);
			LatelyViewItemRender($("strong#nowLatelyViewItemPage_strong").text());
		}
	}
}
/**
 * 관심상품 헤더 열고 닫기
 * @returns
 */
function animateHeaderWishBox(){
	var right = $("div#IHeaderWishBox").css("right").replace("px","");
	//열려있음
	if(Number(right) > -340 ){
		$("button#wishBtn").addClass("on");
		$("div#IHeaderWishBox").animate({ "right": "-340px" }, "fast" );
	}else{
		$("button#wishBtn").removeClass("on");
		$("div#IHeaderWishBox").animate({ "right": "0px" }, "fast" );
	}
}



/**
 * Datepicket 기본설정 
 */
$.datepicker.setDefaults({
    prevText: '이전달',		// prev 아이콘의 툴팁.
    nextText: '다음달',		// next 아이콘의 툴팁.
    currentText: "오늘",	// 오늘 날짜로 이동하는 버튼 패널
    closeText: '닫기',		// 닫기 버튼 패널
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    weekHeader: "주",
    firstDay : 0,
    showMonthAfterYear: true,
    yearSuffix: '년',
    dateFormat:'yy-mm-dd',		// 텍스트 필드에 입력되는 날짜 형식.
    showButtonPanel: true,		// 캘린더 하단에 버튼 패널을 표시한다.
    changeYear: true, 			// 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
});

/**
 * 이벤트 버블링 제거
 * @param event
 * @returns
 */
function stopClickEventBubbling(event){
   if (event && event.preventDefault) {
      event.preventDefault();
      event.stopPropagation();
    }
    else {
       event = event || window.event;
       event.cancelBubble = true;
       event.returnValue = false;
    }
}

/**
 * 주소검색 팝업
 * @param cate
 * @returns
 */
function goAddrPopup(cate){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var w 		= 570;//윈도우 팝업 넓이
	var h 		= 420;//윈오두 팝업 높이
	var left 	= screen.width/2 - w/2;
  	var top 	= screen.height/2 - h/2;
	var pop 	= window.open("/common/addrSearchPopup.do?cate=" + cate,"pop","width="+w+",height="+h+",left="+left+",top="+top+", scrollbars=yes, resizable=yes, "); 
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
  	//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}

/**
 * 정규식 검사
 * @param reg
 * @param value
 * @returns
 */
function getRegExpResult(reg,value){
	var result = reg.exec(value);  
    if(!result){
    	return false;
    }else{
    	return true;
    }
}

/**
 * 날짜 시작 종료 검사
 * @param sDate
 * @param eDate
 * @returns
 */
function chkDateFromTo(sDate, eDate){
	sDate = sDate.replace(/-/gi, '');
	eDate = eDate.replace(/-/gi, '');
	
	if(Number(sDate) > Number(eDate)){
		return false;
	}else{
		return true;
	}
}

/**
 * 
 * @param obj
 * @returns
 */
function isNull(obj){
	if(obj == '' || obj == null || obj == undefined || obj == NaN || isNull == "null" || isNull == "undefined"){ 
		return true;
	}else{
		return false;
	}
}

/**
 * 로컬스토리지 저장
 * @param name
 * @param obj
 * @returns
 */
function setLocalStorage(name,obj){
	localStorage.setItem(name, obj);
}

/**
 * 로컬 스토리지 삭제
 * @param name
 * @returns
 */
function removeLocalStorage(name){
	localStorage.removeItem(name);
}

/**
 * 로컬스토리지에서 특정 객체 가져오기
 * @param name
 * @returns
 */
function getItemLocalStorage(name){
	return localStorage.getItem(name);
}


/**
 * 체크 박스 전체 체크
 * all check 전체 체크
 * ex)<input type="checkbox" children_name="childrend name" onchange="checkBoxAllCheck(this)">
 * children_name = 하위 체크 박스의 name 어트리뷰트 값
 * @param obj
 * @returns
 */
function checkBoxAllCheck(obj){
	var box_name = $(obj).attr("children_name");
	
	if($(obj).is(":checked")){
		$("[name="+box_name+"]").prop("checked",true);
	}else{
		$("[name="+box_name+"]").prop("checked",false);
	}
}

/**
 * 하위 체크 박스 
 * 전체 클릭 후 하나의 객체 체크 해제시 전체 체크 박스 체크 해제와 
 * 객체를 하나씩 체크하여 전체 체크시 전체 체크 박스 자동 체크
 * ex)<input type="checkbox" name="체크박스 이름 = 상위 children_name 값" onchange="javascript:checkBoxOneCheck(this,전체 체크박스 id);"/>
 * @param obj
 * @param allCheckId
 * @returns
 */
function checkBoxOneCheck(obj,allCheckId){
	var box_name = $(obj).attr("name");
	var check_box_objs = $("[name="+box_name+"]");
	var checkBoxLength = $(check_box_objs).length;
	
	if(!$(obj).is(":checked")){
		$("#"+allCheckId).prop("checked",false);
	}else{
		if(checkBoxLength == $("[name="+box_name+"]:checked").length){
			$("#"+allCheckId).prop("checked",true);
		}
	}
}

/**
 * 입력받은 금액을 한글로 변환한다.
 * @param num
 * @returns
 */
function viewKorean(num) {
	num = num.replace(/,/gi, '');
	var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
	var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천");
	var result = ""; 
	for(i=0; i<num.length; i++){
		str = ""; 
		han = hanA[num.charAt(num.length-(i+1))];
		if(han != "") str += han+danA[i];
		if(i == 4) str += "만";
		if(i == 8) str += "억";
		if(i == 12) str += "조";
		result = str + result; 
	} 
	
	if(num != 0) result = result + "원"; 
	return result; 
}

/**
 * 검색조건 빠른계산 날짜계산
 * @param type
 * @returns
 */
function getQuickDate(type){
	var sDate = new Date();
	
	if(type == "week"){
		sDate.setDate(sDate.getDate() - 7);
	}else if(type == "month"){
		sDate.setMonth(sDate.getMonth() - 1);
		sDate.setDate(sDate.getDate() + 1);
	}else if(type == "threeMonth"){
		sDate.setMonth(sDate.getMonth() - 3);
		sDate.setDate(sDate.getDate() + 1);
	}else if(type == "sixMonth"){
		sDate.setMonth(sDate.getMonth() - 6);
		sDate.setDate(sDate.getDate() + 1);
	}else if(type == "year"){
		sDate.setYear(sDate.getFullYear() - 1);
		sDate.setDate(sDate.getDate() + 1);
	}
	
	var sYear = sDate.getFullYear();
	var sMonth = sDate.getMonth()+1;
	var sDay = sDate.getDate();
	
	return sYear+"-"+(sMonth<10?"0"+sMonth:sMonth)+"-"+(sDay<10?"0"+sDay:sDay);
}

/**
 * 검색 공통
 * @param formId
 * @returns
 */
function searchFormSubmit(formId){
	$("input#page").val("1");
	$("form#"+formId).submit();
}

/**
 * 검색 날자 변경 공통
 * @param date
 * @param formId
 * @param startDateInputName
 * @param endDateInputName
 * @returns
 */
function changeQuickDate(date,formId,startDateInputName,endDateInputName){
	if(!isNull(date)){
		var schSdate = getQuickDate(date);
		var schEdate = getQuickDate('day');
		$("input[name="+startDateInputName+"]").val(schSdate);
		$("input[name="+endDateInputName+"]").val(schEdate);
		searchFormSubmit(formId);
	}
}

/**
 * 기본 알럿 창
 * @param content 알림 내용
 * @param title 알림 제목
 * @param width 알림 레이어 넓이
 * @returns
 */
function defaultAlert(content,title,callback,width){
	JBOX_MODAL.setTitle(isNull(title) ? '알림' : title);
	JBOX_MODAL.setContent(isNull(content) ? '' : content);
	JBOX_MODAL.open({
		width : isNull(width) ? 400 : width
		,onClose : function(){
			if(typeof callback === "function")callback();
		} 
	});
}

/**
 * 기본 공지 
 * @param content 내용
 * @param color 색상
 * @param align 정렬
 * @param autoClose 사라지는 시간
 * @param minWidth 레이어 최소 넓이
 * @param attributes 속성 추가생성 방향및 레이어 위치
 * @param offset 기준 px 조정값
 * @returns
 */
function defaultNotice(content,color,align,autoClose,minWidth,attributes,offset){
	new jBox('Notice', {
	    content: isNull(content) ? '내용' : content
	    ,color: isNull(color) ? 'red' : color
	    ,align : isNull(align) ? 'right': align
	    ,autoClose : isNull(autoClose) ? 3000 : timer
	    ,minWidth : isNull(minWidth) ? 300 : minWidth
		,attributes:isNull(attributes) ? {x: 'right', y: 'bottom'} : attributes//
		,offset : isNull(offset) ? {x : 15 , y : 15} : offset
	});
}
/**
 * 기본 컨펌 함수
 * @param content 질의내용
 * @param confirmFunc 확인시 콜백
 * @param cancelFunc 취소시 콜백
 * @param data 콜백 데이터
 * @returns
 */
function defaultConfirm(content,confirmFunc,cancelFunc,data){
	new jBox('Confirm', {
		content: isNull(content) ? 'Do you want to continue?' : content
	    ,confirmButton: '확인'
	    ,cancelButton: '취소'
	    ,confirm: function(){
	    	if(typeof confirmFunc === "function"){
	    		if(!isNull(data)){
	    			confirmFunc(data);
	    		}else{
	    			confirmFunc();
	    		}
	    	}
	    }
	    ,cancel: function(){
	    	if(typeof cancelFunc === "function"){
	    		if(!isNull(data)){
	    			cancelFunc(data);
	    		}else{
	    			cancelFunc();
	    		}
	    	}
	    }

	}).open();
}

function uploadImageNone(obj,width,src){
	$(obj).css("width",width);
	$(obj).attr("src",src);
}

/*
 * 아이디 입력 폼 기본 설명 텍스트 셋팅
 */
function setDefaultInputMent(elementId,ment){
	$("#" + elementId).text(ment).css("color","grey");
}
