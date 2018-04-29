/**
 * 엑셀파일 읽어오기
 * @returns
 */
function itemExcelRead(){
	
	if(isNull($("input[name=excel_file]").val())){
		alert("파일을 선택해 주세요.");
		return;
	}
	
	//Get form
	var form = $('form[name=excelFrm]')[0];
	//Create an FormData object
	var data = new FormData(form);
	
	$.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/seller/itemExcelReadAjax.do",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        beforeSend : function(xmlHttpRequest){
			$(".layer_bg").show();
		},
        success: function(result, status, xhr){
        	if(result.result == AJAX_RESULT_SUCCESS){
        		var html = '';
        		var successCnt = 0;
        		$(result.excelData).each(function(idx, obj){
        			html += '<tr>';
        			html += '	<td class="center"><input type="checkbox" name="chk_item" value="'+obj.rowNum+'" onchange="javascript:checkBoxOneCheck(this, \'chk_item_all\');"></td>';
        			html += '	<td class="center"><img src="'+obj.J+'" width="60" height="60" onerror="this.src=\'http://via.placeholder.com/60x60\'"></td>';
        			html += '	<td class="left">'+obj.D+'</td>';
        			html += '	<td class="right">'+$.number(obj.last_price)+'원</td>';
        			html += '	<td class="center">'+obj.rowNum+'행</td>';
        			html += '	<td class="left">'+obj.errMsg+'</td>';
        			html += '	<td class="center"><button class="button_height_small" type="button" onclick="deleteUploadItem(this);">삭제</button></td>';
        			html += '</tr>';
        			
        			if(isNull(obj.errMsg)){
        				successCnt++;
        			}
        		});
        		
        		$("table#excelReadDataTbl > tbody").html(html);
        		
        		$("b.regRedColor:eq(0)").text(result.excelData.length);
        		$("b.regRedColor:eq(1)").text(successCnt);
        		
        		$("table#excelReadSummary").show();
        		$("div.tblItemWrap").show();
        		$("div.submit_button_area").show();
        		
        		excelData = result.excelData;
        	}else{
        		defaultAlert(result.message);
        	}
        	
        	$(".layer_bg").hide();
        },
        error: function(jqXHR, textStatus, errorThrown){
        	if(jqXHR.status == 300){
        		defaultAlert("로그인이 필요합니다.");
        	}
        }
    });
}

var excelData = new Array();
var itemList = new Array();
function createItemList(excelData){
	itemList = new Array();
	if(!isNull(excelData)){
		
		$(excelData).each(function(idx, excel){
			var obj = new Object();
			var optionList = new Array();
			
			obj.cate_code1 = excel.B.substring(0, 3);
			obj.cate_code2 = excel.B;
			obj.item_title = excel.C;
			obj.item_name = excel.D;
			obj.item_keyword = excel.E;
			obj.item_origin = excel.F;
			obj.item_maker = excel.G;
			obj.item_model_name = excel.H;
			obj.item_content = excel.I;
			obj.item_cust_price = excel.K;
			obj.item_price = excel.L;
			obj.item_coupon_price = excel.M;
			obj.item_last_price = excel.last_price;
			obj.item_qty = excel.N;
			obj.item_sell_period_from = excel.O;
			obj.item_sell_period_to = excel.P;
			obj.item_tag = excel.Q;
			obj.item_tag_sub = excel.R;
			obj.item_delivery_charge_type = excel.S;
			obj.item_represent_image = excel.J;
			if(!isNull(excel.AB)){
				obj.item_img1 = excel.AB;
			}
			if(!isNull(excel.AC)){
				obj.item_img2 = excel.AC;
			}
			if(!isNull(excel.AD)){
				obj.item_img3 = excel.AD;
			}
			if(!isNull(excel.AE)){
				obj.item_img4 = excel.AE;
			}
			if(!isNull(excel.AF)){
				obj.item_img5 = excel.AF;
			}
			obj.state = excel.state;
			
			//필수옵션
			if(!isNull(excel.T)){
				var optionObj = new Object();
				var arrOptionSubject = excel.T.split('\n');
				var arrOptionName = excel.U.split('\n');
				
				if(arrOptionSubject.length == arrOptionName.length){
					
					//옵션그룹제목
					var strOptionSubject = '';
					for(var i=0; i<arrOptionSubject.length; i++){
						if(i==0){
							strOptionSubject = arrOptionSubject[i];
						}else{
							strOptionSubject = strOptionSubject + ',' + arrOptionSubject[i];
						}
					}
					obj.item_option_subject = strOptionSubject;	//필수옵션그룹명
					
					//옵션명
					if(arrOptionSubject.length == 1){
						var arrOptionName = excel.U.split('|');
						var arrOptionPrice = excel.W.split('|');
						var arrOptionQty = excel.V.split('|');
						
						for(var i=0; i<arrOptionName.length; i++){
							var optionObj = new Object();
							optionObj.io_type = "0";
							optionObj.io_name = arrOptionName[i];
							optionObj.io_price = arrOptionPrice[i];
							optionObj.io_stock_qty = arrOptionQty[i];
							optionObj.io_noti_qty = "0";
							optionObj.io_use = "1";
							
							optionList.push(optionObj);
						}
					}else{
						//옵션은 최대2개
						var arrOptionName = excel.U.split('\n');
						var arrTemp = new Array();
						var arrTemp1 = arrOptionName[0].split('|');
						var arrTemp2 = arrOptionName[1].split('|');
						
						for(var i=0; i<arrTemp1.length; i++){
							for(var j=0; j<arrTemp2.length; j++){
								arrTemp.push(arrTemp1[i] + "^" + arrTemp2[j]);
							}
						}
						
						var arrOptionPrice = excel.W.split('|');
						var arrOptionQty = excel.V.split('|');
						for(var i=0; i<arrTemp.length; i++){
							var optionObj = new Object();
							optionObj.io_type = "0";
							optionObj.io_name = arrTemp[i];
							optionObj.io_price = arrOptionPrice[i];
							optionObj.io_stock_qty = arrOptionQty[i];
							optionObj.io_noti_qty = "0";
							optionObj.io_use = "1";
							
							optionList.push(optionObj);
						}
					}
				}else{
					defaultAlert("필수옵션 내용이 맞지 않습니다.");
					return;
				}
				
				obj.select_option_list = optionList;
			}
			
			//추가옵션
			if(!isNull(excel.X)){
				var optionObj = new Object();
				var arrOptionSubject = excel.X.split('\n');
				var arrOptionName = excel.Y.split('\n');
				
				if(arrOptionSubject.length == arrOptionName.length){
					//옵션그룹제목
					var strOptionSubject = '';
					for(var i=0; i<arrOptionSubject.length; i++){
						if(i==0){
							strOptionSubject = arrOptionSubject[i];
						}else{
							strOptionSubject = strOptionSubject + ',' + arrOptionSubject[i];
						}
					}
					obj.item_supply_subject = strOptionSubject;	//추가옵션 그룹명
					
					//옵션명
					var arrOptionName = excel.Y.split('|');
					var arrOptionPrice = excel.AA.split('|');
					var arrOptionQty = excel.Z.split('|');
					
					for(var i=0; i<arrOptionName.length; i++){
						var optionObj = new Object();
						optionObj.io_type = "1";
						optionObj.io_name = arrOptionName[i];
						optionObj.io_price = arrOptionPrice[i];
						optionObj.io_stock_qty = arrOptionQty[i];
						optionObj.io_noti_qty = "0";
						optionObj.io_use = "1";
						
						optionList.push(optionObj);
					}
				}else{
					defaultAlert("추가옵션 내용이 맞지 않습니다.");
					return;
				}
				
				obj.add_option_list = optionList;
			}
			
			itemList.push(obj);
		});
	}
	console.log(itemList);
}

/**
 * 업로드 상품내역 한건 삭제(화면에서만)
 * @param obj
 * @returns
 */
function deleteUploadItem(obj){
	var trIdx = $(obj).parents("tr:first").index();
	excelData.splice(trIdx, 1);
	
	$(obj).parents('tr:first').remove();
}

/**
 * 상품대량등록하기
 * @returns
 */
function insertExcelItemList(){
	createItemList(excelData);	//엑셀데이터 저장데이터로 가공
	
	excelLoop : for(var i=0; i<itemList.length; i++){
		if(itemList[i].state == "-1"){
			defaultAlert("오류가 있는 상품이 있습니다.<br>삭제 또는 수정후 재업로드 바립니다.");
			return;
			break excelLoop;
		}
	}
	
	defaultConfirm("상품을 대량등록하시겠습니까?", function(){
		$.ajax({
	        type: "POST",
	        url: "/seller/insertExcelItemListAjax.do",
	        data: {
	        	"item_list":JSON.stringify(itemList)
	        },
	        dataType : "json",
			async : true,
			beforeSend : function(xmlHttpRequest){
				$(".layer_bg").show();
			},
	        success: function(result, status, xhr){
	        	if(result.result == AJAX_RESULT_SUCCESS){
	        		defaultAlert(result.message,null,function(){
	        			location.href="/seller/sellRegistItemList.do";
	        		},null);
	        	}else{
	        		defaultAlert(result.message);
	        	}
	        	$(".layer_bg").hide();
	        },
	        error: function(jqXHR, textStatus, errorThrown){
	        	if(jqXHR.status == 300){
	        		defaultAlert("로그인이 필요합니다.");
	        	}else {
	        		defaultAlert("고객센터로 문의바랍니다.");
	        	}
	        }
	    });
	});
}