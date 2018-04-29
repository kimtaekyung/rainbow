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

<script type="text/javascript" src="/js/buyer/interestItemList.js"></script>

</head>
	<body>
		
		<div id="wrap">
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
					
					<!-- 구매관리메뉴 -->
					<%@include file="/WEB-INF/views/buyer/buyMenu.jsp"%>
					
					<div id="v6RightContent">
						<div class="v6Location">
							현재위치 : <a href="/main/">HOME</a> &gt; <a href="/buyer/buyMain.do">구매관리</a> &gt; 관심상품관리 &gt; <b>관심상품목록</b>
						</div>
						<div id="v5ContentsWrap">
							<div class="common_lable_div">
								<img class="common_lable_img" src="/images/common/ico_common2.gif">
								<span class="common_lable_span">관심 상품 목록</span>
							</div>
							<form name="schFrm" id="schFrm" method="get" action="/buyer/interestItemList.do">
								<input type="hidden" name="page" id="page" value="${resultDataMap.page }"/>
								<input type="hidden" name="pageSize" id="pageSize" value="${resultDataMap.pageSize }"/>
							<table class="common_table_normal" id="searchTbl">
								<tbody>
									<tr>
										<th>등록자</th>
										<td>
											<input type="text" name="seller_id" value="${resultDataMap.seller_id }" style="width:90px;"/>
										</td>
										<th>상품번호</th>
										<td colspan="3">
											<input type="text" name="item_seq" value="${resultDataMap.item_seq }" style="width:90px;"/>
											<button class="button_default" type="button" onclick="searchFormSubmit('schFrm');" >찾기</button>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
	
							<table class="common_table_normal">
								<tbody>
									<tr>
										<td>총 <b><fmt:formatNumber value="${resultDataMap.total }" pattern="#,###" /></b>개의 관심상품이 있습니다.</td>
									</tr>
								</tbody>
							</table>
	
							<table class="common_table_normal">
								<colgroup>
									<col width="25">
									<col width="85">
									<col width="60">
									<col width="*">
									<col width="80">
									<col width="80">
									<col width="55">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="chk_item_seq_all" children_name="chk_item_seq" onchange="checkBoxAllCheck(this)"></th>
										<th>이미지</th>
										<th>상품번호</th>
										<th>상품제목</th>
										<th>등록자</th>
										<th>등록일</th>
										<th>비고</th>
									</tr>
								</thead>
								<tbody>
								
						<c:choose>
							<c:when test="${empty resultDataMap.myItemList }">
									<tr>
										<td colspan="7">관심상품 내역이 없습니다.</td>
									</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="data" items="${resultDataMap.myItemList }">
									<tr>
										<td class="center"><input type="checkbox" name="chk_item_seq" value="${data.ITEM_SEQ }" onchange="javascript:checkBoxOneCheck(this, 'chk_item_seq_all');"></td>
										<td class="center"><img src="${data.ITEM_REPRESENT_IMAGE }" border="0" width="75" height="75" class="image"></td>
										<td class="center">${data.ITEM_SEQ }<br><br></td>
										<td>
											<a href="javascript:void(0);" onclick="javascript:moveItemViewPage('${data.ITEM_SEQ}','${data.ITEM_REPRESENT_IMAGE}'); return false;"><font color="#0000cc">${data.ITEM_TITLE }</font></a>
											<br><br>현재수량 : <fmt:formatNumber value="${data.ITEM_QTY }"/> 개<br>판매단가 : <fmt:formatNumber value="${data.ITEM_LAST_PRICE }"/>원
										</td>
										<td class="center">${data.SELLER_ID }</td>
										<td class="center">${data.REG_DTTM }</td>
										<td class="center">
											<button class="button_height_small" type="button" onclick="deleteInterestItem(this);">삭제</button>
										</td>
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
							
							<div style="text-align: right">
								<button class="button_height_small" type="button" onclick="deleteInterestItemList();">선택삭제하기</button>
								<!-- <img src="/images/buyer/btn_delAll.gif" width="97" height="20" alt="전체삭제하기" border="0" align="absmiddle" onclick="deleteAllInterestItem();" style="cursor: pointer;"> -->
							</div>
		
						</div>
					</div>
				</div>
			</div>
			
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>