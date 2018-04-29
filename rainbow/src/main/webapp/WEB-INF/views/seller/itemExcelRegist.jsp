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
<link rel="stylesheet" type="text/css" href="/css/seller/itemExcelRegist.css">

<script type="text/javascript" src="/js/seller/itemExcelRegist.js"></script>

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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/seller/sellMain.do">판매관리</a> &gt; 상품등록관리 &gt; <b>상품대량등록하기</b>
						</div>
						<div id="v5ContentsWrap">
	
							<div id="regFrmWrap">
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">상품대량등록 주의사항</span>
								</div>
								<div class="excel_area_div">
									<div class="verticalMiddleParent">
										<img class="verticalMiddleChild" src="/images/common/btn_xls.gif">
										<a class="verticalMiddleChild" href="" onclick="alert('준비중입니다.');">엑셀양식 다운로드</a>
									</div>
								</div>
								
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td class="left">
												<p class="noticeRedColor">동일상품을 3개 이상 도배 등록하거나 3개 이하인 경우에도 판매조건이나 내용이 동일한 경우 도배등록으로 간주하여 승인, 거부, 숨김처리와 함께 민형사상 책임을 지게 되니 주의해주세요.</p>
												<p>상표권을 침해할 소지가 있는 상품, 피임기구 및 의료용품 이외의 성인용품, 주류 및 담배 등은 등록할 수 없습니다.</p>
												<p>상품상세설명에 도덕적으로 부적합하거나 불량한 내용 또는 자사홍보나 직거래를 유도하는 것으로 간주될만한 내용이 있을 경우 등록되지 않습니다.</p>
												<p>쇼핑몰이나 상점을 처분하는 경우, 상품거래가 아닌 경우, 입고일이나 배송가능일이 미기재된 오더베이스 진행상품의 경우 등록할 수 없습니다.</p>
												<p>상품의 가격이 다른 마켓보다 높거나 한 상품페이지에 가격이 각각 다른 상품설명이 기재되어 있는 경우 등록할 수 없습니다.</p>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">기본내용입력(엑셀파일업로드)</span>
								</div>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td>
												<p>대량등록은 <b class="noticeRedColor">1회 최소 10개에서 최대 200개</b>까지 가능하며, <b class="noticeRedColor">최대 신청 가능 개수는 1,000개</b>입니다.<br/> 
													(ex. 승인대기 상품이 900개일 경우 100개까지 대량등록신청이 가능합니다.)<br>
													관리자 검수 및 승인 후 추가 신청이 가능하며, 엑셀파일의 입력방법을 확인 후 작성하여 업로드해주세요.</p>
												<p>다운로드 받은 엑셀파일의 속성이나 기본 셀 값, 개수, 순서 등을 절대 변경해서는 안됩니다.</p>
												<p>엑셀 항목별 필수사항은 빠짐없이 모두 입력해야 하며 형식과 맞지 않는 입력값, 공백, 상품명 및 이미지의 중복이 있을 경우 업로드가 불가하기 때문에 주의해주세요. 조건부 필수는 해당 사항에 적용될 경우에만 입력하면 됩니다.</p>
												<p>전문가업로드 방식의 이미지업로드 등은 대량등록이 지원되지 않는 기능입니다. 상품 등록 후 '정보수정'을 통해 개별 설정해주세요.</p>
												<p>엑셀파일의 예시값은 해당 셀에만 유효한 예시값이며 다른 셀의 조건과는 무관하니 참고해주세요.</p>
											</td>
										</tr>
									</tbody>
								</table>
	
								<form name="excelFrm" enctype="multipart/form-data">
								
								<table class="common_table_normal">
									<colgroup>
										<col width="150px">
										<col width="*">
										<col width="100px">
									</colgroup>
									<tbody>
										<tr>
											<th>대량등록 파일업로드</th>
											<td>
												<div class="file_upload_div">
													<span>파일찾기</span>
													<input class="uploadfile" type="file" name="excel_file" view="excel_file_view" path="excel_file_path"/>
												</div>
												<span id="excel_file_path" class="fileuploadurl"></span>
											</td>
											<td class="right">
												<button class="button_height_small" type="button" onclick="itemExcelRead();">엑셀업로드</button>
											</td>
										</tr>
									</tbody>
								</table>
									
								</form>
	
								<form method="post" action="/main/mySell/register/my_sellItemsRegIng.php" enctype="multipart/form-data" name="selItemFrm" onsubmit="return frmSelItemDelChk()" id="uploadTitle">
								
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">업로드상품목록</span>
								</div>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td>
												<p>아래 업로드된 상품 중 오류가 있는 상품의 경우 오류 사유을 참조하여 엑셀 파일의 내용 수정 후 다시 업로드해주세요.<br>
													[대량등록신청]버튼을 클릭하기 전 연속해서 다른 내용의 파일을 업로드하면 최종 업로드된 파일로 덮어쓰기 됩니다.</p>
												<p>숫자는 엑셀 시트의 행(가로) 순서이며, 알파벳은 열(세로) 이름을 의미합니다.<br/>
													예) [행]에 18이 표시되고 오류사유에 "AQ의 입력값이 올바르지 않습니다."라고 메세지가 출력될 경우, 18번째 행과 열 이름 AQ가 만나는 셀의 내용이 형식과 맞지 않게 입력되었기 때문에 수정해야합니다.</p>
												<p><b>등록 실패 상품 혹은 정상 업로드 된 상품 중 일부를 제외하고 등록을 원할 경우 [삭제]버튼 또는 체크박스 선택 후 [선택한 상품제외]버튼을 클릭해 주세요.</b></p>
												<p>대량등록신청 이후 관리자 승인이 필요합니다.</p>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="common_lable_div">
									<img class="common_lable_img" src="/images/common/ico_common2.gif">
									<span class="common_lable_span">도움이 필요하세요</span>
								</div>
								<table class="common_table_normal">
									<tbody>
										<tr>
											<td>
												<p>엑셀을 통한 대량등록이 어렵다면 1:1상담이나 전화(1111-1111)를 통하여 문의를 해주세요. 도움을 받을 수 있습니다.</p>
											</td>
										</tr>
									</tbody>
								</table>
								
								
								<table class="common_table_normal" id="excelReadSummary" style="display: none;">
									<colgroup>
										<col width="*">
										<col width="100px">
									</colgroup>
									<tr>
										<td><span>총 <b class="regRedColor">0</b>개의 상품 중 	<b class="regRedColor">0</b>개의 상품이 정상입니다.</span></td>
										<td>
											<button class="button_height_small" type="button" onclick="alert('개발중');">선택한 상품제외</button>
										</td>
									</tr>
								</table>
									
								<div class="tblItemWrap" style="display: none">
									<table class="common_table_normal" id="excelReadDataTbl">
										<colgroup>
											<col width="25px">
											<col width="60px">
											<col width="150px">
											<col width="80px">
											<col width="40px">
											<col width="280px">
											<col width="60px">
										</colgroup>
										<thead>
											<tr>
												<th><input type="checkbox" id="chk_item_all" children_name="chk_item" onchange="checkBoxAllCheck(this)"></th>
												<th>이미지</th>
												<th>상품명</th>
												<th>가격</th>
												<th>행</th>
												<th>등록오류사유</th>
												<th>삭제</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="center"><input type="checkbox" name="chk_item" value="" onchange="javascript:checkBoxOneCheck(this, 'chk_item_all');"></td>
												<td class="center"><img src="" width="60" height="60" onerror="this.src='http://via.placeholder.com/60x60'"></td>
												<td class="left">화이트셔츠</td>
												<td class="right">10,000원</td>
												<td class="center">4행</td>
												<td class="left">
													C열 : 다른 행에 중복된 상품명이 존재 합니다.<br>
													P열 : 다른 행에 중복된 이미지가 존재 합니다.<br>
													V열 : 상품판매단가설정에 사업자회원 할인적용(02)을 선택한 경우만 할인후 판매가에 입력이 가능합니다.<br>
													AC열 : 배송비 설정에서 수량별차등배송비를 선택하였을 경우만 입력해주세요.<br>
													AN열 : 최저준수가격은 상품판매단가보다 높아야 합니다.추천준수가격은 상품판매단가보다 높아야 합니다.<br>
												</td>
												<td class="center">
													<button class="button_height_small" type="button" onclick="deleteUploadItem(this);">삭제</button>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								</form>
								
								<div class="submit_button_area" style="display: none;">
									<button class="button_submit" type="button" title="대량등록하기" onclick="insertExcelItemList();">대량등록하기</button>
								</div>
	
							</div>
	
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