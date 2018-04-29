<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>알 샵</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="p3p" content="">
<meta http-equiv="imagetoolbar" content="no">
<meta http-equiv="pics-label" content="">
<meta name="generator" content="">
<meta name="author" content="">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="classification" content="">
<meta name="robots" content="">
<meta name="naver-site-verification" content="">
<meta name="verify-v1" content="">
<meta name="y_key" content="">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=1560">
<link rel="shortcut icon" href="">
<meta name="msapplication-config" content="">
<meta name="theme-color" content="">
<!-- CSS -->
<!-- 공통 -->
<%@include file="/WEB-INF/views/common/include.jsp"%>
<!-- 공통 -->
<!-- 메인 -->
<link rel="stylesheet" type="text/css" href="/css/popup/itemCategoryPopup.css">
<!-- 메인 -->
<!-- CSS 끝 -->
<script type="text/javascript">
$(document).ready(function(){
	itemCategoryListAjax();
});


//카테고리 선택완료
//부모폼으로 카테고리값 전송
function submitCategory(){
	var cate_code1 = $("select#category1").val();
	var cate_code2 = $("select#category2").val();
	var cate_code3 = $("select#category3").val();
	
	if(cate_code1 == null || cate_code1 == "" || cate_code1 == undefined){
		alert("1단계 분류가 선택되지 않았습니다.");
		return;
	}
	if(cate_code2 == null || cate_code2 == "" || cate_code2 == undefined){
		alert("2단계 분류가 선택되지 않았습니다.");
		return;
	}
	
	var jsonCateInfo = {};
	jsonCateInfo.cate_code1 = cate_code1;
	jsonCateInfo.cate_name1 = $("select#category1 option:selected").text();
	jsonCateInfo.cate_code2 = cate_code2;
	jsonCateInfo.cate_name2 = $("select#category2 option:selected").text();
	jsonCateInfo.cate_code3 = cate_code3;
	jsonCateInfo.cate_name3 = $("select#category3 option:selected").text();

	parent.setCategory(jsonCateInfo);
}

//카테고리 목록조회
var categoryList = [];
function itemCategoryListAjax(){
	$.ajax({
		type : "POST"
		,url : "/item/itemCategoryListAjax.do"
		,data : {}
		,dataType : "json"
		,async : true
		,success : function(result, status, xhr) {
			if(result.resultData != null && result.resultData != undefined){
				categoryList = result.resultData;
				$(categoryList).each(function(idx, obj){
					if(obj.CATE_DEPTH == 1){
						$("select#category1").append('<option value="'+obj.CATE_CODE+'">'+obj.CATE_NAME+' ☞</option>');
					}
				});
			}
		}
		,error : function(jqXHR, textStatus, errorThrown) {
			console.log("error");
			//console.log(jqXHR);
			//console.log(textStatus);
			//console.log(errorThrown);
		}
	});
}

function selectCategory(depth){
	if(depth == 1){
		$("select#category2").empty();
		$("select#category3").empty();
		$(categoryList).each(function(idx, obj){
			if(obj.CATE_DEPTH == 2 && $("select#category1").val() == obj.CATE_CODE.substring(0, 3) ){
				$("select#category2").append('<option value="'+obj.CATE_CODE+'">'+obj.CATE_NAME+' ☞</option>');
			}
		});
		
		$("span#categorySpan").text( $("select#category1 option:selected").text().replace(" ☞", "") );
	}else if(depth == 2){
		$("select#category3").empty();
		$(categoryList).each(function(idx, obj){
			if(obj.CATE_DEPTH == 3 && $("select#category2").val() == obj.CATE_CODE.substring(0, 5) ){
				$("select#category3").append('<option value="'+obj.CATE_CODE+'">'+obj.CATE_NAME+'</option>');
			}
		});
		
		$("span#categorySpan").text( $("select#category1 option:selected").text().replace(" ☞", "") + " > " + $("select#category2 option:selected").text() );
	}else if(depth == 3){
		
		$("span#categorySpan").text( $("select#category1 option:selected").text().replace(" ☞", "") + " > " + $("select#category2 option:selected").text().replace(" ☞", "") + " > " +  $("select#category3 option:selected").text() );
	}
}
</script>
</head>
	<body>
	<table width="100%" height="100%" border="0" cellpadding="10" cellspacing="1" bgcolor="#d0d0d0" align="center">
		<tbody>
			<tr valign="top">
				<td bgcolor="#ffffff">

					<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" align="center">
						<tbody>
							<tr>
								<td align="left">
									<font color="gray">정확한 분류선택은 검색결과, 판촉시장, 스타일갤러리, 제휴사이트 등에 연결되어 판매가 증대 됩니다</font>
								</td>
								<td align="right">
									<a href="javascript:parent.closePopupLayer()">
										<img src="http://211.43.195.137/image/common/btn_close.gif" width="54" height="20" border="0" align="absmiddle" alt="창닫기">
									</a>
								</td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
						</tbody>
					</table>

					<table width="100%" border="0" cellpadding="10" cellspacing="2" bgcolor="#ffffff" align="center">
						<tbody>
							<tr bgcolor="#ffffff" valign="top">
								<td width="25%" style="padding: 0">
									<table width="100%" border="0" cellpadding="5" cellspacing="0" bgcolor="#ffffff" align="center">
										<tbody>
											<tr>
												<td align="center" bgcolor="#D4EBF6">1단계 분류</td>
											</tr>
											<tr>
												<td bgcolor="#E7F7F7">
													<select style="width: 100%" size="11" id="category1" onchange="javascript:selectCategory(1);">
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
								<td width="25%" style="padding: 0">
									<table width="100%" border="0" cellpadding="5" cellspacing="0" bgcolor="#ffffff" align="center">
										<tbody>
											<tr>
												<td align="center" bgcolor="#D4EBF6">2단계 분류</td>
											</tr>
											<tr>
												<td bgcolor="#E7F7F7">
													<select style="width: 100%" size="11" id="category2" onchange="javascript:selectCategory(2);">
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
								<td width="25%" style="padding: 0">
									<table width="100%" border="0" cellpadding="5" cellspacing="0" bgcolor="#ffffff" align="center">
										<tbody>
											<tr>
												<td align="center" bgcolor="#D4EBF6">3단계 분류</td>
											</tr>
											<tr>
												<td bgcolor="#E7F7F7">
													<select style="width: 100%" size="11" id="category3" onchange="javascript:selectCategory(3);">
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>

					<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
						<tbody>
							<tr>
								<td bgcolor="#D4EBF6" height="3"></td>
							</tr>
							<tr>
								<td bgcolor="#9CC7EF" height="1"></td>
							</tr>
						</tbody>
					</table>

					<table width="100%" border="0" cellpadding="15" cellspacing="0" bgcolor="#F3FbFb" align="center">
						<tbody>
							<tr valign="top">
								<td colspan="4">
									카테고리 선택결과
									<b> :: 
										<font color="#0000cc">
											<span id="categorySpan"></span>
										</font>
									</b>
									<font color="#0000cc">
										<font color="gray">☞ 표시가 없는 분류까지 선택 하세요 ::</font>
									</font>
								</td>
							</tr>
						</tbody>
					</table>

					<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
						<tbody>
							<tr>
								<td bgcolor="#9CC7EF" height="1"></td>
							</tr>
							<tr>
								<td bgcolor="#D4EBF6" height="3"></td>
							</tr>
						</tbody>
					</table>

					<p></p>

					<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" align="center">
						<tbody>
							<tr>
								<td align="center"><img src="http://211.43.195.137/image/mySell/register/btn_registerCategoryOk.gif" border="0" align="absmiddle" id="categorySaveButton" style="cursor: pointer;" onclick="javascript:submitCategory();"></td>
							</tr>
						</tbody>
					</table>


				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>