/**
 * 
 */
$(document).ready(function() {
	
});
/*
 * 주소검색 팝업 리턴
 */
function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2,
		engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm,
		bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn,
		lnbrMnnm, lnbrSlno, emdNo, cate) {

	if (cate == "mbAddress") {
		$("input[name=mb_zip_code]").val(zipNo);
		$("input[name=mb_address]").val(roadAddrPart1);
		$("input[name=mb_address_detail]").val(addrDetail);
	} else if (cate == "bizAddress") {
		$("input[name=mb_biz_zip_code]").val(zipNo);
		$("input[name=mb_biz_address]").val(roadAddrPart1);
		$("input[name=mb_biz_address_detail]").val(addrDetail);
	}
}

function memberBizInfoUpdate() {
	console.log("memberBizInfoUpdate()...");

	var validationCheckResult = updateFormValidationCheck();
	console.log("validationCheckResult >> " + validationCheckResult);
	if (validationCheckResult) {
		var form = $("form#memberBizUpdateForm")[0];
		// Create an FormData object
		var data = new FormData(form);
		
		console.log(data);
		$.ajax({
			type : "POST",
			enctype : 'multipart/form-data',
			url : "/myPage/updateMemberBizInfoAjax.do",
			data : data,
			processData : false,
			contentType : false,
			cache : false,
			success : function(result, status, xhr) {
				
				console.log(result);
				if(result.result == AJAX_RESULT_SUCCESS){
					defaultAlert("인증,변경 요청이 완료되었습니다.",null,function(){
						window.location.reload();
					});
				}else{
					if(result.data == "1"){
						defaultAlert('상호 입력이 올바르지 않습니다.');
					}else if(result.data == "2"){
						defaultAlert('사업자유형 입력이 올바르지 않습니다.');
					}else if(result.data == "3" || result.data == "4" || result.data == "5" ){
						defaultAlert('대표자 이름 입력이 올바르지 않습니다.');
					}else if(result.data == "4"){
						defaultAlert('사업자 번호 입력이 올바르지 않습니다.');
					}else if(result.data == "5" ){
						defaultAlert('업태 입력이 올바르지 않습니다.');
					}else if(result.data == "6"){
						defaultAlert('업종 입력이 올바르지 않습니다.');
					}else if(result.data == "7"){
						defaultAlert('사업장 주소 입력이 완료되지 않았습니다.');
					}else if(result.data == "8"){
						defaultAlert('사업장 주소 우편번호 입력이 완료되지 않았습니다.');
					}else if(result.data == "9"){
						defaultAlert('사업장 기본주소 입력이 완료되지 않았습니다.');
					}else if(result.data == "10"){
						defaultAlert('사업장 상세주소 입력이 완료되지 않았습니다.');
					}else if(result.data == "11" || result.data == "12"){
						defaultAlert('사업장 전화 입력이 올바르지 않습니다.');
					}else if(result.data == "13"){
						defaultAlert('사업자 등록 사본이 올바르지 않습니다.');
					}else if(result.data == "14"){
						defaultAlert('회원정보 변경중 오류가 발생하였습니다. 관리자에게 문의 하세요.');
					}else if(result.data == "15"){
						defaultAlert('회원정보 변경중 오류가 발생하였습니다. 관리자에게 문의 하세요.');
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
function updateFormValidationCheck() {

	// 상호명
	if (isNull($("input[name=mb_biz_name]").val())) {
		defaultAlert("상호명 입력이 완료되지 않았습니다.");
		return false;
	} else {
		if (!getRegExpResult(BIZNAME_REGULAR_EXPRESSTION, $("input[name=mb_biz_name]").val())) {
			defaultAlert("상호명 입력 형식이 바르지 않습니다.");
			return false;
		}
	}

	// 사업자 유형
	if (isNull($("select[name=mb_biz_type]").val())) {
		defaultAlert("사업자 유형 값이 바르지 않습니다.");
		return false;
	} else {
		if (!getRegExpResult(BIZ_TYPE_EXPRESSTION,$("select[name=mb_biz_type]").val())) {
			defaultAlert("업자 유형 값이 바르지 않습니다.");
			return false;
		}
	}
	// 대표자명
	if (isNull($("input[name=mb_biz_ceo_name]").val())) {
		defaultAlert("대표자명 입력이 완료되지 않았습니다.");
		return false;
	} else {
		if (!getRegExpResult(BIZCEONAME_REGULAR_EXPRESSTION, $("input[name=mb_biz_ceo_name]").val())) {
			defaultAlert("대표자명 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	// 사업자 등록번호 입력칸 3개중 한개라도 미입력시 체크
	if (isNull($("input#mb_biz_no_1").val())
			|| isNull($("input#mb_biz_no_2").val())
			|| isNull($("input#mb_biz_no_3").val())) {
		defaultAlert("사업자 등록번호 입력이 완료 되지 않았습니다.");
		return false;
	} else {
		var bizNo = $("input#mb_biz_no_1").val() + "-"
				+ $("input#mb_biz_no_2").val() + "-"
				+ $("input#mb_biz_no_3").val();
		if (!getRegExpResult(BIZNO_REGULAR_EXPRESSTION, bizNo)) {
			defaultAlert("사업자 등록번호 입력 형식이 바르지 않습니다.");
			return false;
		} else {
			$("input[name=mb_biz_no]").val(bizNo);
		}
	}

	// 업태
	if (isNull($("input[name=mb_biz_condition]").val())) {
		defaultAlert("업태가 입력 되지 않았습니다");
		return false;
	} else {
		if (!getRegExpResult(BIZ_CONDITION_EXPRESSTION, $(
				"input[name=mb_biz_condition]").val())) {
			defaultAlert("업태 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	// 업종
	if (isNull($("input[name=mb_biz_condition]").val())) {
		defaultAlert("업태가 입력 되지 않았습니다");
		return false;
	} else {
		if (!getRegExpResult(BIZ_CONDITION_EXPRESSTION, $(
				"input[name=mb_biz_condition]").val())) {
			defaultAlert("업태 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	// 주소
	if (isNull($("input[name=mb_biz_category]").val())) {
		defaultAlert("사업장 주소 우편번호 입력이 완료 되지 않았습니다.");
		return false;
	} else {
		if (!getRegExpResult(BIZ_CATEGORY_EXPRESSTION, $(
				"input[name=mb_biz_category]").val())) {
			defaultAlert("사업장 주소 우편번호 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	if (isNull($("input[name=mb_biz_address]").val())) {
		defaultAlert("사업장 기본 주소 입력이 완료되지 않았습니다.");
		return false;
	} else {
		if (!getRegExpResult(ADDRESS_REGULAR_EXPRESSTION, $(
				"input[name=mb_biz_address]").val())) {
			defaultAlert("사업장 기본 주소 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	if (isNull($("input[name=mb_biz_address_detail]").val())) {
		defaultAlert("사업장 상세 주소 입력이 완료되지 않았습니다.");
		return false;
	} else {
		if (!getRegExpResult(ADDRESS_DETAIL_REGULAR_EXPRESSTION, $(
				"input[name=mb_biz_address_detail]").val())) {
			defaultAlert("사업장 상세 주소 입력 형식이 바르지 않습니다.");
			return false;
		}
	}
	// 사업장전화번호 입력한 2개중 한개라도 미입력시 체크
	if (isNull($("input#bizTelno2").val())
			|| isNull($("input#bizTelno3").val())) {
		defaultAlert("사업장 전화 번호 입력이 완료되지 않았습니다.");
		return false;
	} else {
		if (!getRegExpResult(BIZTELNO_REGULAR_EXPRESSTION,
				$("select#bizTelno1").val() + "-" + $("input#bizTelno2").val()
						+ "-" + $("input#bizTelno3").val())) {
			defaultAlert("사업장 전화 번호 번호 입력 형식이 바르지 않습니다.");
			return false;
		} else {
			$("input[name=mb_biz_tel]").val(
					$("select#bizTelno1").val() + "-"
							+ $("input#bizTelno2").val() + "-"
							+ $("input#bizTelno3").val());
		}
	}
	
	// 사업자등록증 이미지
	if(isNull($("img#mb_biz_img_path_view").attr("src"))){
		if (isNull($("input[name=mb_biz_img_path]").val())) {
			defaultAlert("사업자 등록 사본 이미지 파일이 첨부 되지 않았습니다.");
			return false;
		}else{
			if (!getRegExpResult(IMAGE_EXPRESSION, $("input[name=mb_biz_img_path]").val())) {
				defaultAlert("파일 형식이 올바르지 않니다. (gif, jpg, jpeg, png 파일만 업로드 가능 합니다.)");
				return false;
			}
		}
	}
	return true;
}
