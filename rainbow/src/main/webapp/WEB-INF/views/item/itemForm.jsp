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
<link rel="stylesheet" type="text/css" href="/css/item/itemForm.css">

<script type="text/javascript" src="/plugin/SE2/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="/js/constant/constant.js"></script>
<script type="text/javascript" src="/js/item/itemForm.js"></script>

</head>
	<body>
	
		<c:set var="item" value="${resultDataMap.item }"/>
		<c:set var="itemOption" value="${resultDataMap.itemOption }"/>
		<c:set var="itemOptionGroup" value="${resultDataMap.itemOptionGroup }"/>
	
		<div id="wrap">
		
			<!-- 팝업 레이어 -->
			<div id="mainPopupLayer" style="position: absolute; visibility: visible; display: none; background: gray; width: 820px; height: 367px; top: 667px; left: 550px; z-index: 200000;">
				<iframe name="popupFrame" id="popupFrame" style="width: 820px; height: 367px; overflow: scroll; border:0;"></iframe>
			</div>
		
			<!-- 헤더 -->
			<%@include file="/WEB-INF/views/common/header.jsp"%>
			<!-- 중앙부 -->
			<div id="v6Middle">
				<!-- 콘텐츠 영역 -->
				<div id="v6Contents">
	
					<!-- <h2>상품등록</h2>
	
					<a href="#" target="_blank">
						<img src="http://211.43.195.137/image/mySell/register/sellInfoForm/bnr_itemTitlePolicyChange.png">
					</a> -->
	
					<!--등록안내 시작-->
					<div class="common_lable_div">
						<img class="common_lable_img" src="/images/common/ico_common2.gif">
						<span class="common_lable_span">등록안내</span>
					</div>
	
					<table class="common_table_max">
						<tbody>
							<tr>
								<td><b>레인보우샾에서 상품을 매매하거나 서비스를 이용시 레인보우샾의
										모든 약관과 다음 사항을 준수해야 하며, 등록한 상품 및 해당 거래와 관련된 모든 민,형사상의 책임은 회원님
										개개인에게 있습니다</b>
	
									<ul class="guide">
										<li>허위과장 광고 및 기만적 방법으로 구매자를 유인하지 않습니다</li>
										<li>해당 상품과 관련한 통관, 판매허가, 품목허가 등의 준수여부를 확인하고, 관련법령을 위배 하지
											않습니다</li>
									</ul>
	
									<ul class="guide">
										<li>상품에 사용하는 상품(상표)명이 타인의 등록상표와 유사한 경우 상표권침해 등의 문제가 발생할 수
											있습니다</li>
										<li style="list-style: none; margin-left: 10px;">권리범위나 관계를
											꼼꼼히 확인한 후 등록하여 제 3자의 권리를 침해하는 상품등록 및 거래를 하지 않도록 합니다</li>
									</ul>
	
									<ul class="guide">
										<li>레인보우샾에 등록한 상품을 자신이 운영하는 사이트나 다른 사이트에서 동시에 팔면서 레인보우샾보다 가격을
											더 저렴하게 판매하거나 무료배송비, 사은품 제공 등 특별 혜택을 줄 경우 회원활동에 제재를 받게 됩니다</li>
										<li>동일한 상품을 2개 이상 도배등록하거나 부가가치세법 및 소득세법상의 의무를 회피하려는 목적으로
											동일한 상품을 여러 아이디로 등록시 민형사상 책임을 지며 강제 회원탈퇴됩니다</li>
										<li>레인보우샾에 등록된 상품은 판매촉진 등을 위해 레인보우샾에서 홍보 목적으로 사용할 수 있습니다</li>
									</ul> <br> <b>등록된 상품은 관리자가 상품입력형식을 검토하여 승인할 경우에만 상품목록에 진열됩니다</b>
	
									<ul class="guide">
										<li>상품정보에 내 사이트주소를 적거나 링크를 거는 등 사이트나 회사홍보 목적으로 상품을 등록해서는
											안됩니다</li>
										<li>잘못된 카테고리 선택, 제목, 키워드, 내용 등을 검토하여 이상이 있을 경우 승인이 거부될 수
											있습니다</li>
										<li>연속하여 1회 이상 수정요청을 받지 않으면 관리자의 사전승인 단계가 생략됩니다</li>
										<li>사후 관리시 관리자로부터 수정요청을 받으면 다시 승인단계를 거쳐야만 자동진열 됩니다</li>
									</ul></td>
							</tr>
						</tbody>
					</table>
					
					<div class="common_lable_div">
						<img class="common_lable_img" src="/images/common/ico_common2.gif">
						<span class="common_lable_span">정보입력</span>
					</div>
	
					<form name="reg" method="post" action="/item/itemRegist.do" enctype="multipart/form-data">
						<input type="hidden" name="item_seq" value="${item.ITEM_SEQ }" />
						<input type="hidden" name="cate_code1" value="${item.CATE_CODE1 }"/>
						<input type="hidden" name="cate_code2" value="${item.CATE_CODE2 }"/>
						<input type="hidden" name="cate_code3" value="${item.CATE_CODE3 }"/>
					
						<!--카테고리-->
						<table class="common_table_max">
							<colgroup>
								<col width="150px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">카테고리선택</span></th>
									<td>
										<select class="select_default" name="category1" id="category1" onchange="changeCategory(1);">
											<option value="">-카테고리1선택-</option>
										</select>
										<select class="select_default" name="category2" id="category2" onchange="changeCategory(2);">
											<option value="">-카테고리2선택-</option>
										</select>
										<select class="select_default" name="category3" id="category3" onchange="changeCategory(3);">
											<option value="">-카테고리3선택-</option>
										</select>
										<!-- <button class="button_height_small" type="button" onclick="javascript:clickBtnCategory();">카테고리선택</button> -->
										<p class="desc">카테고리1, 카테고리2는 필수선택입니다.</p>
									</td>
								</tr>
								<tr>
									<td>선택된 카테고리</td>
									<td>
										<div id="categorySpan" style="display: inline; color: #cc0000">
											<c:if test="${not empty item }">${item.CATE_CODE1_NAME } &gt; ${item.CATE_CODE2_NAME } <c:if test="${not empty item.CATE_CODE3 }">&gt; ${item.CATE_CODE3_NAME }</c:if>  </c:if>
											<c:if test="${empty item }">선택된 레인보우샾 카테고리가 없습니다</c:if>
										</div>
									</td>
								</tr>
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">상품제목</span></th>
									<td>
										<input type="text" maxlength="100" name="item_title" value="${item.ITEM_TITLE }" style="width: 650px;">
										<span id="spanLengthTitle">(0/100)</span>
										<p class="desc">
											상품제목에는 <span style="color: #cc0000">[ ] ( ) * + - = $ %
												&amp; / . ± × ÷ ℃ € ￠ ￡ ￥</span> 특수문자만 입력 가능하며, 그 외 특수문자는 삭제 후 저장됩니다<br>
											(키보드로 입력가능한 기호 및 공백은 <span style="color: #cc0000">1byte</span>, 한글, 일문, 한문 및 특수문자는 <span style="color: #cc0000">2byte</span>)<br>
										</p>
									</td>
								</tr>
								<!--상품명 -->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">상품명</span></th>
									<td>
										<input type="text" maxlength="50" name="item_name" value="${item.ITEM_NAME }" style="width: 400px; height: 16px">
										<span id="spanLengthTitle">(0/50)</span>
										<p class="desc">
											상품명에는 <span style="color: #cc0000">[ ] ( ) * + - = $ %
												&amp; / . ± × ÷ ℃ € ￠ ￡ ￥</span> 특수문자만 입력 가능하며, 그 외 특수문자는 삭제 후 저장됩니다<br>
											(키보드로 입력가능한 기호 및 공백은 <span style="color: #cc0000">1byte</span>, 한글, 일문, 한문 및 특수문자는 <span style="color: #cc0000">2byte</span>)<br>
										</p>
									</td>
								</tr>
								<!--키워드-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">키워드</span></th>
									<td>
										<p class="desc">
											이 상품과 무관한 카테고리명이나 인기 키워드를 입력할 경우 상품등록 거부 및 경고를 받게 됩니다.<br>
											<input type="text" name="item_keyword" value="${item.ITEM_KEYWORD }" style="width:650px;"><br>
											<font color="gray"> 검색 키워드를 최대5개까지 ,(콤마)로 구분하여 입력하세요 (예: 맥반석비누,옥비누,상황비누,황토비누) <br>
												하나의 검색 키워드에는 <font color="#000000">한글 7자, 영문ㆍ숫자 15자</font> 까지만 사용이 가능 합니다
											</font><br>
											<font color="#cc0000"> 브랜드명을 2개 이상 입력 할 경우 검색시 반영 되지 않습니다 (예: 나이키, 리바이스, 아디다스) </font>
										</p>
									</td>
									<!-- <td bgcolor="#f3f3f3"></td> -->
								</tr>
								<!--원산지-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">원산지(제조국)</span></th>
									<td>
										<select class="select_default" name="item_origin" style="width: 120px;">
											<option value="">원산지선택</option>
											<option value="">-------------</option>
											<option value="대한민국" ${item.ITEM_ORIGIN eq '대한민국' ? 'selected':'' }>대한민국</option>
											<option value="중국" ${item.ITEM_ORIGIN eq '중국' ? 'selected':'' }>중국</option>
											<option value="일본" ${item.ITEM_ORIGIN eq '일본' ? 'selected':'' }>일본</option>
											<option value="미국" ${item.ITEM_ORIGIN eq '미국' ? 'selected':'' }>미국</option>
											<option value="">-------------</option>
											<option value="대만" ${item.ITEM_ORIGIN eq '대만' ? 'selected':'' }>대만</option>
											<option value="대한민국" ${item.ITEM_ORIGIN eq '대한민국' ? 'selected':'' }>대한민국</option>
											<option value="독일" ${item.ITEM_ORIGIN eq '독일' ? 'selected':'' }>독일</option>
											<option value="미국" ${item.ITEM_ORIGIN eq '미국' ? 'selected':'' }>미국</option>
											<option value="베트남" ${item.ITEM_ORIGIN eq '베트남' ? 'selected':'' }>베트남</option>
											<option value="일본" ${item.ITEM_ORIGIN eq '일본' ? 'selected':'' }>일본</option>
											<option value="이탈리아" ${item.ITEM_ORIGIN eq '이탈리아' ? 'selected':'' }>이탈리아</option>
											<option value="인도네시아" ${item.ITEM_ORIGIN eq '인도네시아' ? 'selected':'' }>인도네시아</option>
											<option value="중국" ${item.ITEM_ORIGIN eq '중국' ? 'selected':'' }>중국</option>
											<option value="태국" ${item.ITEM_ORIGIN eq '태국' ? 'selected':'' }>태국</option>
											<option value="프랑스" ${item.ITEM_ORIGIN eq '프랑스' ? 'selected':'' }>프랑스</option>
											<option value="홍콩" ${item.ITEM_ORIGIN eq '홍콩' ? 'selected':'' }>홍콩</option>
											<option value="기타 국가" ${item.ITEM_ORIGIN eq '기타 국가' ? 'selected':'' }>기타 국가</option>
										</select>
										<p class="desc">
											ㆍ원산지를 허위로 표기할 경우 표시.광고의 공정화에 관한 법률에 저촉될 수 있습니다<br>
											ㆍ구성품 별 제조국이 다른 경우 각 구성품의 제조국<br>
											ㆍ원산지와 가공지 등이 다를 경우 함께 표기<br>
											ㆍ농수산물의 경우 원산지 표시에 관한 법률에 따른 원산지
										</p>
									</td>
								</tr>
								<!--제조사-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">제조사</span></th>
									<td>
										<input type="text" name="item_maker" value="${item.ITEM_MAKER }">
										<p class="desc">
											ㆍ수입품의 경우 수입자를 함께 입력, 병행수입의 경우 병행수입 여부로 대체 가능<br>
											ㆍ구성품 별 제조자가 다른 경우 각 구성품의 제조자, 수입자 입력<br>
											ㆍ식품(농수산물, 가공식품, 건강기능식품) : 생산자, 수입품의 경우 수입자를 함께 표기<br>
											ㆍ디지털 콘텐츠(음원, 게임 등)는 제작자 또는 공급자 입력<br>
											ㆍ상품권 및 쿠폰은 발행자 입력
										</p>
									</td>
								</tr>
								<!--모델명/규격-->
								<tr>
									<th>모델명/규격(품명)</th>
									<td><input type="text" name="item_model_name" value="${item.ITEM_MODEL_NAME }"></td>
								</tr>
								<!--상품상세내용-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">상품상세내용</span></th>
									<td>상세이미지는 가로 최대 956픽셀까지, HTML코드 입력시 65535 byte까지만 가능합니다</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea name="item_content" id="item_content" style="width: 910px; height: 600px;">${item.ITEM_CONTENT }</textarea>
									</td>
								</tr>
								<!--시중가격-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">시중가격</span></th>
									<td>
										<input type="text" maxlength="10" value="${item.ITEM_CUST_PRICE }" name="item_cust_price" onkeyup="this.value=$.number(this.value);" onblur="setItemPrice();" style="text-align: right;"> 원
										<p class="desc">시중에서 판매되는 상품의 가격을 입력합니다.</p>
									</td>
								</tr>
								<!--판매가격-->
								<tr>
									<th>판매가격</th>
									<td>
										<input type="text" maxlength="10" value="${item.ITEM_PRICE }" name="item_price" onkeyup="this.value=$.number(this.value);" onblur="setItemPrice();" style="text-align: right;"> 원
										<p class="desc">실제 판매할 상품의 가격을 입력합니다.</p>
									</td>
								</tr>
								<!--할인금액-->
								<tr>
									<th>할인금액</th>
									<td>
										<input type="text" maxlength="10" value="${item.ITEM_COUPON_PRICE }" name="item_coupon_price" onkeyup="this.value=$.number(this.value);" onblur="setItemPrice();" style="text-align: right;"> 원
										<p class="desc">할인금액을 입력하면 시중가격(판매가격 입력시 판매가격)에서 차감이 되어 최종판매금액으로 계산됩니다.</p>
									</td>
								</tr>
								<!--최종판매금액-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">최종판매가격</span></th>
									<td>
										<input type="text" maxlength="10" value="${item.ITEM_LAST_PRICE }" name="item_last_price" readonly="readonly" style="text-align: right;"> 원
										<p class="desc">화면에 표시될 최종판매금액입니다. 자동으로 계산됩니다.</p>
									</td>
								</tr>
								<!--재고수량-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">재고수량</span></th>
									<td><input type="text" maxlength="10" value="${item.ITEM_QTY }" name="item_qty" style="text-align: right;"> 개</td>
								</tr>
								<!--상품판매일시-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">상품판매일시</span></th>
									<td>
										<input type="text" maxlength="10" value="${item.ITEM_SELL_PERIOD_FROM }" name="item_sell_period_from" class="datepicker" readonly="readonly"> ~
										<input type="text" maxlength="10" value="${item.ITEM_SELL_PERIOD_TO }" name="item_sell_period_to" class="datepicker" readonly="readonly">
										<p class="desc">상품의 판매기간을 입력합니다.</p>
									</td>
									<!-- <td bgcolor="#f3f3f3"></td> -->
								</tr>
								<!--상품태그-->
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">상품태그</span></th>
									<td>
										<input type="radio" name="item_tag" id="rdo_item_tag1" value="1" ${item.ITEM_TAG eq '1' ? 'checked':'' }><label for="rdo_item_tag1">새상품</label>
										<input type="radio" name="item_tag" id="rdo_item_tag2" value="2" ${item.ITEM_TAG eq '2' ? 'checked':'' }><label for="rdo_item_tag2">미사용전시</label>
										<input type="radio" name="item_tag" id="rdo_item_tag3" value="3" ${item.ITEM_TAG eq '3' ? 'checked':'' }><label for="rdo_item_tag3">전시시연</label>
										<input type="radio" name="item_tag" id="rdo_item_tag4" value="4" ${item.ITEM_TAG eq '4' ? 'checked':'' }><label for="rdo_item_tag4">렌탈전시</label>
										<input type="radio" name="item_tag" id="rdo_item_tag5" value="5" ${item.ITEM_TAG eq '5' ? 'checked':'' }><label for="rdo_item_tag5">터프한중고</label>
										<br/><br/>
										<input type="hidden" name="item_tag_sub" value="${item.ITEM_TAG_SUB }">
										<input type="checkbox" name="item_tag_sub1" id="item_tag_sub1" class="item_tag_sub" value="신품수준" ${fn:indexOf(item.ITEM_TAG_SUB, '신품수준') > -1 ? 'checked':'' }><label for="item_tag_sub1">신품수준</label>
										<input type="checkbox" name="item_tag_sub2" id="item_tag_sub2" class="item_tag_sub" value="선착순한정" ${fn:indexOf(item.ITEM_TAG_SUB, '선착순한정') > -1 ? 'checked':'' }><label for="item_tag_sub2">선착순한정</label>
										<input type="checkbox" name="item_tag_sub3" id="item_tag_sub3" class="item_tag_sub" value="노마진" ${fn:indexOf(item.ITEM_TAG_SUB, '노마진') > -1 ? 'checked':'' }><label for="item_tag_sub3">노마진</label>
										<input type="checkbox" name="item_tag_sub4" id="item_tag_sub4" class="item_tag_sub" value="스크래치" ${fn:indexOf(item.ITEM_TAG_SUB, '스크래치') > -1 ? 'checked':'' }><label for="item_tag_sub4">스크래치</label>
										<input type="checkbox" name="item_tag_sub5" id="item_tag_sub5" class="item_tag_sub" value="무료배송" ${fn:indexOf(item.ITEM_TAG_SUB, '무료배송') > -1 ? 'checked':'' }><label for="item_tag_sub5">무료배송</label>
										<input type="checkbox" name="item_tag_sub6" id="item_tag_sub6" class="item_tag_sub" value="짧은사용" ${fn:indexOf(item.ITEM_TAG_SUB, '짧은사용') > -1 ? 'checked':'' }><label for="item_tag_sub6">짧은사용</label>
										<input type="checkbox" name="item_tag_sub7" id="item_tag_sub7" class="item_tag_sub" value="가성비" ${fn:indexOf(item.ITEM_TAG_SUB, '가성비') > -1 ? 'checked':'' }><label for="item_tag_sub7">가성비</label>
									</td>
								</tr>
								<!--상품선택옵션-->
								<tr>
									<th>상품선택옵션</th>
									<td>
										<p class="desc">
											옵션항목은 콤마(,) 로 구분하여 여러개를 입력할 수 있습니다.<br/>
											옷을 예로 들어 [옵션1 : 사이즈 , 옵션1 항목 : XXL,XL,L,M,S] , [옵션2 : 색상 , 옵션2 항목 : 빨,파,노]<br/>
											옵션명과 옵션항목에 따옴표(', ")는 입력할 수 없습니다.
										</p>
										
										<input type="hidden" name="item_option_subject" value="${item.ITEM_OPTION_SUBJECT }"/>
										<c:set var="arrSubject" value="${fn:split(item.ITEM_OPTION_SUBJECT, ',') }"/>
										<table>
											<tr>
												<td style="padding:5px;">
													<label>옵션1</label>
													<input type="text" name="select_option" value=""/>
												</td>
												<td style="padding:5px;">
													<label>옵션1 항목</label>
													<input type="text" name="select_option_item" value="" style="width:400px;"/>
												</td>
											</tr>
											<tr>
												<td style="padding:5px;">
													<label>옵션2</label>
													<input type="text" name="select_option" value=""/>
												</td>
												<td style="padding:5px;">
													<label>옵션2 항목</label>
													<input type="text" name="select_option_item" value="" style="width:400px;"/>
												</td>
											</tr>
											<!-- <tr>
												<td style="padding:5px;">
													<label>옵션3</label>
													<input type="text" name="select_option" value=""/>
												</td>
												<td style="padding:5px;">
													<label>옵션3 항목</label>
													<input type="text" name="select_option_item" value="" style="width:400px;"/>
												</td>
											</tr> -->
											<tr>
												<td colspan="2" class="center" style="padding:5px;">
													<button class="button_height_small" type="button" onclick="javascript:registSelectOption();">옵션목록생성</button>
												</td>
											</tr>
										</table>
										
										<!-- 옵션존재여부 -->
										<c:set var="isSelectOption" value="false"/>
										<c:set var="isAddOption" value="false"/>
										<c:forEach var="data" items="${itemOption }">
											<c:if test="${data.IO_TYPE eq '0' }">
												<c:set var="isSelectOption" value="true"/>
											</c:if>
											<c:if test="${data.IO_TYPE eq '1' }">
												<c:set var="isAddOption" value="true"/>
											</c:if>
										</c:forEach>
										
										<!-- 선택옵션생성목록 -->
										<table class="common_table_normal" id="selectOptionTable" style="display: ${isSelectOption eq 'true' ? 'table':'none' };">
											<thead>
												<tr>
													<!-- <th class="center"><input type="checkbox"/></th> -->
													<th class="center" colspan="2">옵션</th>
													<th class="center">추가금액</th>
													<th class="center">재고수량</th>
													<th class="center">통보수량</th>
													<th class="center">사용여부</th>
												</tr>
											</thead>
											<tbody>
										<c:if test="${not empty itemOption }">
											<c:forEach var="option" items="${itemOption }">
												<c:if test="${option.IO_TYPE eq '0' }">
												<tr>
													<!-- <td><input type="checkbox" name="chk_select_option" value="1"/></td> -->
													<td colspan="2" class="left textLimit" title="${fn:replace(option.IO_NAME, '^', '') }">
														<input type="hidden" name="io_name" value="${option.IO_NAME }"/>
														<input type="hidden" name="io_type" value="${option.IO_TYPE }"/>
														${fn:replace(option.IO_NAME, '^', '') }
													</td>
													<td><input type="text" name="io_price" value="${option.IO_PRICE }" style="text-align:right;width:70px;"/></td>
													<td><input type="text" name="io_stock_qty" value="${option.IO_STOCK_QTY }" style="text-align:right;width:70px;"/></td>
													<td><input type="text" name="io_noti_qty" value="${option.IO_NOTI_QTY }" style="text-align:right;width:70px;"/></td>
													<td>
														<select name="io_use" class="select_default" style="width:80px;">
															<option value="1">사용</option>
															<option value="2">미사용</option>
														</select>
													</td>
												</tr>
												</c:if>
											</c:forEach>
										</c:if>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<th>상품추가옵션</th>
									<td>
										<p class="desc">
											옵션항목은 콤마(,) 로 구분하여 여러개를 입력할 수 있습니다. <br/>
											스마트폰을 예로 들어 [추가1 : 추가구성상품 , 추가1 항목 : 액정보호필름,케이스,충전기]<br/>
											옵션명과 옵션항목에 따옴표(', ")는 입력할 수 없습니다.
										</p>
										<input type="hidden" name="item_supply_subject" value="${item.ITEM_SUPPLY_SUBJECT }"/>
										<table id="addOption">
											<tbody>
												<tr>
													<td style="padding:5px;">
														<label>추가1</label>
														<input type="text" name="add_option" value=""/>
													</td>
													<td style="padding:5px;">
														<label>추가1 항목</label>
														<input type="text" name="add_option_item" value="" style="width:300px;"/>
													</td>
													<td style="padding:5px;">
														<button class="button_height_small" id="btnAddOption" type="button" onclick="javascript:addOptionInput();">옵션추가</button>
													</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="3" class="center" style="padding:5px;">
														<button class="button_height_small" type="button" onclick="javascript:registAddOption();">옵션목록생성</button>
													</td>
												</tr>
											</tfoot>
										</table>
										<!-- 추가옵션생성목록 -->
										<table class="common_table_normal" id="addOptionTable" style="display: ${isAddOption eq 'true' ? 'table':'none' };">
											<thead>
												<tr>
													<!-- <th><input type="checkbox"/></th> -->
													<th class="center">옵션명</th>
													<th class="center" colspan="2">옵션항목</th>
													<th class="center">상품금액</th>
													<th class="center">재고수량</th>
													<th class="center">통보수량</th>
													<th class="center">사용여부</th>
												</tr>
											</thead>
											<tbody>
										<c:if test="${not empty itemOption }">
											<c:forEach var="option" items="${itemOption }">
												<c:if test="${option.IO_TYPE eq '1' }">
												<tr>
													<!-- <td><input type="checkbox" name="chk_add_option" value="1"/></td> -->
													<td class="left textLimit" title="${item.ITEM_SUPPLY_SUBJECT }">
														<input type="hidden" name="io_name" value="${option.IO_NAME }"/>
														<input type="hidden" name="io_type" value="${option.IO_TYPE }"/>
														${item.ITEM_SUPPLY_SUBJECT }
													</td>
													<td colspan="2" class="left textLimit" title="${option.IO_NAME }">${option.IO_NAME }</td>
													<td class="center"><input type="text" name="io_price" value="${option.IO_PRICE }" style="text-align:right;width:70px;"/></td>
													<td class="center"><input type="text" name="io_stock_qty" value="${option.IO_STOCK_QTY }" style="text-align:right;width:70px;"/></td>
													<td class="center"><input type="text" name="io_noti_qty" value="${option.IO_NOTI_QTY }" style="text-align:right;width:70px;"/></td>
													<td class="center">
														<select name="io_use" class="select_default" style="width:80px;">
															<option value="1">사용</option>
															<option value="2">미사용</option>
														</select>
													</td>
												</tr>
												</c:if>
											</c:forEach>
										</c:if>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">배송비유형</span></th>
									<td>
										<select class="select_default" name="item_delivery_charge_type" onchange="javascript:changeDeliveryType(this);">
											<option value="1" ${item.ITEM_DELIVERY_CHARGE_TYPE eq '1' ? 'selected':'' }>업체기본설정</option>
											<option value="2" ${item.ITEM_DELIVERY_CHARGE_TYPE eq '2' ? 'selected':'' }>무료배송</option>
											<option value="3" ${item.ITEM_DELIVERY_CHARGE_TYPE eq '3' ? 'selected':'' }>조건부무료</option>
											<option value="4" ${item.ITEM_DELIVERY_CHARGE_TYPE eq '4' ? 'selected':'' }>유료배송</option>
											<option value="5" ${item.ITEM_DELIVERY_CHARGE_TYPE eq '5' ? 'selected':'' }>수량별부과</option>
										</select>
										
										<div id="deliveryCondition" style="color: #888888;display:none">
											조건부무료시 금액입력(입력한 금액이상일시 배송비무료)<br/>
											<input type="text" name="item_delivery_condition" value="" style="text-align:right;"/>
										</div>
									</td>
								</tr>
								<tr>
									<th><img src="/images/auth/ico_must.gif"><span class="span_default">상품대표이미지</span></th>
									<td>
										<div class="file_upload_div">
											<span>파일찾기</span>
											<input class="uploadfile" type="file" name="item_represent_image" view="item_represent_image_view" path="item_represent_image_path"/>
										</div>
										<span id="item_represent_image_path" class="fileuploadurl"></span>
										<div class="file_upload_view_div">
											<img  class="uploadImage" id="item_represent_image_view" src="${item.ITEM_REPRESENT_IMAGE }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
										</div>
									</td>
								</tr>
								<tr>
									<th>상품이미지1</th>
									<td>
										<div class="file_upload_div">
											<span>파일찾기</span>
											<input class="uploadfile" type="file" name="item_img1" view="item_img1_view" path="item_img1_path"/>
										</div>
										<span id="item_img1_path" class="fileuploadurl"></span>
										<div class="file_upload_view_div">
											<img  class="uploadImage" id="item_img1_view" src="${item.ITEM_IMG1 }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
										</div>
									</td>
								</tr>
								<tr>
									<th>상품이미지2</th>
									<td>
										<div class="file_upload_div">
											<span>파일찾기</span>
											<input class="uploadfile" type="file" name="item_img2" view="item_img2_view" path="item_img2_path"/>
										</div>
										<span id="item_img2_path" class="fileuploadurl"></span>
										<div class="file_upload_view_div">
											<img  class="uploadImage" id="item_img2_view" src="${item.ITEM_IMG2 }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
										</div>
									</td>
								</tr>
								<tr>
									<th>상품이미지3</th>
									<td>
										<div class="file_upload_div">
											<span>파일찾기</span>
											<input class="uploadfile" type="file" name="item_img3" view="item_img3_view" path="item_img3_path"/>
										</div>
										<span id="item_img3_path" class="fileuploadurl"></span>
										<div class="file_upload_view_div">
											<img  class="uploadImage" id="item_img3_view" src="${item.ITEM_IMG3 }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
										</div>
									</td>
								</tr>
								<tr>
									<th>상품이미지4</th>
									<td>
										<div class="file_upload_div">
											<span>파일찾기</span>
											<input class="uploadfile" type="file" name="item_img4" view="item_img4_view" path="item_img4_path"/>
										</div>
										<span id="item_img4_path" class="fileuploadurl"></span>
										<div class="file_upload_view_div">
											<img  class="uploadImage" id="item_img4_view" src="${item.ITEM_IMG4 }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
										</div>
									</td>
								</tr>
								<tr>
									<th>상품이미지5</th>
									<td>
										<div class="file_upload_div">
											<span>파일찾기</span>
											<input class="uploadfile" type="file" name="item_img5" view="item_img5_view" path="item_img5_path"/>
										</div>
										<span id="item_img5_path" class="fileuploadurl"></span>
										<div class="file_upload_view_div">
											<img  class="uploadImage" id="item_img5_view" src="${item.ITEM_IMG5 }" onerror="uploadImageNone(this,100,'/images/common/noImage.png')" alt="등록된 이미지가 없습니다."/>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						
					</form>
						
					<div class="submit_button_area">
						<button class="button_submit" type="button" title="취소" onclick="javascript:history.back(-1);">취소</button>
					<c:if test="${not empty item }">
						<button class="button_submit" type="button" title="저장" onclick="javascript:updateItem();">저장</button>
					</c:if>
					<c:if test="${empty item }">
						<button class="button_submit" type="button" title="등록" onclick="javascript:itemRegist();">등록</button>
					</c:if>
					</div>
	
				</div>
	
				<div class="gClearBoth"></div>
	
			</div>
	
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>