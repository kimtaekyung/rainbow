<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<%@include file="/WEB-INF/views/common/include.jsp"%>
<link rel="stylesheet" type="text/css" href="/css/seller/sellRegistItemList.css">

<script type="text/javascript" src="/js/seller/sellRegistItemList.js"></script>

</head>
	<body>
		
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					
					<!-- 판매관리 메뉴 -->
					<%@include file="/WEB-INF/views/seller/sellMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/seller/sellMain.do">판매관리</a> &gt; 상품등록관리 &gt; <b>상품목록</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">상품 목록</span>
							</div>
							<div class="excel_area_div">
								<div class="verticalMiddleParent" style="float: left;">
									<span>선택된 상품을 모두</span>
									<select class="select_default" name="sel_item_display" style="height:25px;padding:3px 12px;">
										<option value="1">숨기기</option>
										<option value="2">진열하기</option>
									</select>
									<button class="button_height_small" type="button" onclick="updateShopItemDisplayCheckItem();">확인</button>
								</div>
								<div class="verticalMiddleParent">
									<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
									<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀다운로드</a>
								</div>
							</div>
							
							<input type="hidden" name="p_cate_code1" value="${resultDataMap.cate_code1 }">
							<input type="hidden" name="p_cate_code2" value="${resultDataMap.cate_code2 }">
							<input type="hidden" name="p_cate_code3" value="${resultDataMap.cate_code3 }">
							
							<form name="schFrm" id="schFrm" action="/seller/sellRegistItemList.do" method="get">
								<input type="hidden" name="item_status" value="${resultDataMap.item_status }">
								<input type="hidden" name="page" id="page" value="${resultDataMap.page }"/>
								<input type="hidden" name="pageSize" id="pageSize" value="${resultDataMap.pageSize }"/>
								
							<table class="common_table_normal" id="searchTbl">
								<tbody>
									<tr>
										<th>재고수량</th>
										<td colspan="2">
											<select class="select_default" name="item_qty" style="width:110px;">
												<option value="">전체</option>
												<option value="50" ${resultDataMap.item_qty eq '50' ? 'selected':'' }>50개 이내</option>
												<option value="100" ${resultDataMap.item_qty eq '100' ? 'selected':'' }>100개 이내</option>
												<option value="500" ${resultDataMap.item_qty eq '500' ? 'selected':'' }>500개 이내</option>
												<option value="1000" ${resultDataMap.item_qty eq '1000' ? 'selected':'' }>1,000개 이내</option>
											</select>
										</td>
										<th>진열상태</th>
										<td colspan="2">
											<select class="select_default" name="item_display" style="width:110px;">
												<option value="">전체</option>
												<option value="2" ${resultDataMap.item_display eq '2' ? 'selected':'' }>진열중</option>
												<option value="1" ${resultDataMap.item_display eq '1' ? 'selected':'' }>숨김중</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>카테고리</th>
										<td colspan="5">
											<select class="select_default" name="cate_code1" id="category1" onchange="selectCategory(1);" style="width:180px;">
												<option value="">-카테고리선택-</option>
											</select>
											<select class="select_default" name="cate_code2" id="category2" onchange="selectCategory(2);" style="width:180px;">
												<option value="">상위분류를 선택하세요</option>
											</select>
											<select class="select_default" name="cate_code3" id="category3" style="width:180px;">
												<option value="">상위분류를 선택하세요</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>검색어</th>
										<td colspan="5">
											<select class="select_default" name="search_type" style="width:120px;">
												<option value="NAME" ${resultDataMap.search_type eq 'NAME' ? 'selected':'' }>상품명</option>
												<option value="TITLE" ${resultDataMap.search_type eq 'TITLE' ? 'selected':'' }>상품제목</option>
												<option value="KEYWORD" ${resultDataMap.search_type eq 'KEYWORD' ? 'selected':'' }>키워드</option>
											</select>
											<input type="text" name="search_word" value="${resultDataMap.search_word }" style="width:400px;">
											<button class="button_default" type="button" onclick="searchFormSubmit('schFrm');" >찾기</button>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
							
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>총 <b><fmt:formatNumber value="${resultDataMap.total }" pattern="#,###" /></b>개의 상품이 있습니다.</td>
									</tr>
								</tbody>
							</table>
		
							<table class="common_table_normal">
								<colgroup>
									<col width="25">
									<col width="80">
									<col width="110">
									<col width="*">
									<col width="55">
									<col width="55">
									<col width="65">
									<col width="65">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="itemChkAll" children_name="chk_item_seq" onchange="checkBoxAllCheck(this);"></th>
										<th>이미지</th>
										<th>상태</th>
										<th>제목(상품명)</th>
										<th>진열여부</th>
										<th>정보수정</th>
										<th>등록일</th>
										<th>판매기간</th>
									</tr>
								</thead>
								<tbody>
								
						<c:choose>
							<c:when test="${empty resultDataMap.itemList }">
									<tr>
										<td colspan="8" class="center">등록된 상품이 존재하지 않습니다.</td>	
									</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="data" items="${resultDataMap.itemList }" varStatus="status">
									<tr>
										<td style="vertical-align: middle;">
											<input type="checkbox" name="chk_item_seq" value="${data.ITEM_SEQ }" onchange="checkBoxOneCheck(this, 'itemChkAll');">
										</td>
										<td style="position: relative;text-align: center;vertical-align: middle;">
											<img src="${data.ITEM_REPRESENT_IMAGE }" border="0" width="75" height="75" class="image" onerror="this.src='/images/seller/img_notExist150.gif'">
										</td>
										<td class="center">
											<div style="padding:2px;background:${data.ITEM_STATUS eq '2' ? '#027b02':'#a7006e'};color:#ffffff;text-align:center;">${data.ITEM_STATUS_NAME }</div>
										<c:if test="${data.ITEM_STATUS ne '1' and data.ITEM_STATUS ne '6' }">
											<select class="select_default" name="save_item_status" style="height:25px;padding:3px 12px;">
												<option value="">상태선택</option>
												<option value="2">판매중</option>
												<option value="3">재고없음</option>
												<option value="4">판매종료</option>
												<option value="5">기간종료</option>
											</select><br/>
											<a href="javascript:void(0);" onclick="updateShopItemStatus(this, '${data.ITEM_SEQ}');">
												<font color="#0000cc"><span style="text-decoration: underline;">상태변경</span></font>
											</a>
										</c:if>
										</td>
										<td class="left">
											<a href="/item/itemView.do?item_seq=${data.ITEM_SEQ }">${data.ITEM_TITLE }</a>
											<%-- <div style="margin-top: 5px">배송방법 : ${data.ITEM_DELIVERY_CHARGE_TYPE_NAME }</div> --%>
											<!-- <span style="color: #cc0000; text-decoration: underline; cursor: pointer;" onclick="popupItemOptEdit(7164686);">● 상품주문옵션 확인/수정</span> -->
										</td>
										<td class="center">
											<c:if test="${data.ITEM_DISPLAY eq '1' }">
												<font color="gray">숨김중</font><br>
												<a href="javascript:void(0);" onclick="updateShopItemDisplay(${data.ITEM_SEQ}, '2');" style="color: #cc0000;text-decoration: underline;">진열하기</a>
											</c:if>
											<c:if test="${data.ITEM_DISPLAY eq '2' }">
												<a href="javascript:void(0);" onclick="updateShopItemDisplay(${data.ITEM_SEQ}, '1');" style="color: #cc0000;text-decoration: underline;">숨김하기</a><br>
												<font color="gray">진열중</font>
											</c:if>
										</td>
										<td class="center">
											<a href="/item/itemForm.do?item_seq=${data.ITEM_SEQ }" style="color: #0000cc;text-decoration: underline;">정보수정</a><br>
										</td>
										<td class="left" title="${data.ITEM_REG_DTTM }">${data.ITEM_REG_DTTM_YMD }</td>
										<td class="left" title="${data.ITEM_SELL_PERIOD_FROM }~${data.ITEM_SELL_PERIOD_TO }">${data.ITEM_SELL_PERIOD_FROM }<br/>${data.ITEM_SELL_PERIOD_TO }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
		
								</tbody>
							</table>
		
							<table class="common_table_normal">
								<tbody>
									<tr>${resultDataMap.paging }</tr>
								</tbody>
							</table>
		
						</div>
						
					</div>
		
					<div class="gClearBoth"></div>
		
				</div>
			</div>
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>