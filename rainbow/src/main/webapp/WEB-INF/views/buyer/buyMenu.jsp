<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
        type: "POST",
        url: "/buyer/getBuyLeftMenuDataCountAjax.do",
        data: {},
        dataType : "json",
		async : true,
        success: function(result, status, xhr){
        	console.log(result);
        	
        	var orderGroupCount = result.orderGroupCount;
        	
        	$("a#orderState").text( $("a#orderState").text() + '('+orderGroupCount.TOTAL+')');
        	$("a#orderState1").text( $("a#orderState1").text() + '('+orderGroupCount.STATE_1+')');
        	$("a#orderState2").text( $("a#orderState2").text() + '('+orderGroupCount.STATE_2+')');
        	$("a#orderState3").text( $("a#orderState3").text() + '('+orderGroupCount.STATE_3+')');
        	$("a#orderState4").text( $("a#orderState4").text() + '('+orderGroupCount.STATE_4+')');
        	$("a#orderState5").text( $("a#orderState5").text() + '('+orderGroupCount.STATE_5+')');
        	$("a#orderState6").text( $("a#orderState6").text() + '('+orderGroupCount.STATE_6+')');
        	$("a#orderState7").text( $("a#orderState7").text() + '('+orderGroupCount.STATE_7+')');
        	$("a#orderState8").text( $("a#orderState8").text() + '('+orderGroupCount.STATE_8+')');
        	$("a#orderState9").text( $("a#orderState9").text() + '('+orderGroupCount.STATE_9+')');
        	$("a#orderState10").text( $("a#orderState10").text() + '('+orderGroupCount.STATE_10+')');
        	$("a#orderState11").text( $("a#orderState11").text() + '('+orderGroupCount.STATE_11+')');
        	$("a#orderState12").text( $("a#orderState12").text() + '('+orderGroupCount.STATE_12+')');
        	$("a#orderState13").text( $("a#orderState13").text() + '('+orderGroupCount.STATE_13+')');
        	$("a#orderState14").text( $("a#orderState14").text() + '('+orderGroupCount.STATE_14+')');
        },
        error: function(jqXHR, textStatus, errorThrown){
        }
    });
});
</script>
					<div id="v6LeftSubMenu">
						<div class="section">
							<div class="title">
								<img src="http://via.placeholder.com/145x75" alt="구매관리 타이틀" title="구매관리 타이틀" width="145" height="75">
							</div>
						</div>
	
						<div class="section">
							<div class="title">
								<img src="/images/buyer/img_itemManage.jpg" alt="상품구매관리" title="상품구매관리" width="145" height="22">
							</div>
							<ul>
								<li class="${currUri eq '/buyer/buyList.do' and empty resultDataMap.order_state  ? 'selected':'' }"><a href="/buyer/buyList.do" id="orderState">전체보기</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '1' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=1" id="orderState1">결제대기</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '2' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=2" id="orderState2">결제완료</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '3' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=3" id="orderState3">배송대기</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '4' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=4" id="orderState4">배송중</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '5' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=5" id="orderState5">구매완료</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '6' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=6" id="orderState6">결제대기취소</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '7' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=7" id="orderState7">결제취소</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '8' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=8" id="orderState8">판매취소</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '9' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=9" id="orderState9">반품요청</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '10' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=10" id="orderState10">교환요청</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '11' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=11" id="orderState11">반품승인</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '12' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=12" id="orderState12">교환승인</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '13' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=13" id="orderState13">반품완료</a></li>
								<li class="${currUri eq '/buyer/buyList.do' and resultDataMap.order_state eq '14' ? 'selected':'' }"><a href="/buyer/buyList.do?order_state=14" id="orderState14">교환완료</a></li>
							</ul>
						</div>
	
						<div class="section">
							<div class="title">
								<img src="/images/buyer/img_itemFavoriteManage.jpg" alt="관심상품관리" width="145" height="22">
							</div>
							<ul>
								<li class="${currUri eq '/buyer/interestItemList.do' ? 'selected':'' }"><a href="/buyer/interestItemList.do">관심상품목록</a></li>
								<li><a href="javascript:alert('개발중');">테마꾸미기</a></li>
							</ul>
						</div>
	
<!-- 						<div class="section"> -->
<!-- 							<div class="title"> -->
<!-- 								<img src="/images/buyer/img_menuB2bChk.png" alt="도매매" width="145" height="22"> -->
<!-- 							</div> -->
<!-- 							<ul> -->
<!-- 								<li><a href="/main/myBuy/supplyChk/my_supplyChk.php">My품절확인목록(0)</a></li> -->
<!-- 								<li><a href="/main/myBuy/supplyChk/my_allSupplyChk.php">전체품절확인목록</a></li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
	
	
						<div class="section">
							<div class="title">
								<img src="/images/buyer/img_cart.jpg" alt="장바구니" width="145" height="22">
							</div>
							<ul>
								<li class="${currUri eq '/item/itemCartList.do' ? 'selected':'' }"><a href="/item/itemCartList.do">장바구니목록</a></li>
							</ul>
						</div>
	
						<div class="section">
							<div class="title">
								<img src="/images/buyer/img_itemInquiryManage.jpg" alt="상품문의관리" width="145" height="22">
							</div>
							<ul>
								<li class="${currUri eq '/buyer/itemQaList.do' ? 'selected':'' }"><a href="/buyer/itemQaList.do">상품문의목록</a></li>
							</ul>
						</div>
	
						<!-- <div class="section">
							<div class="title">
								<img src="/images/buyer/img_cleanCampaign.jpg" alt="구매자권리찾기" width="145" height="42">
							</div>
							<ul>
								<li><a href="">전체신고글(0)</a></li>
								<li><a href="">답변없는신고글(0)</a></li>
								<li><a href="">답변있는신고글(0)</a></li>
							</ul>
						</div> -->
	
						<!-- <div class="boxSection">
							<div class="title">
								<img src="/images/buyer/img_menuMyDome.jpg" alt="My도매꾹 바로가기" width="145" height="22">
							</div>
							<ul>
								<li><a href="/myPage/emoneyUseList.do">E-money관리</a></li>
								<li><a href="/myPage/taxCalculationList.do">세금계산서</a></li>
								<li><a href="/myPage/memberInfoUpdate.do">개인정보관리</a></li>
								<li><a href="/myPage/memberGradeSearch.do">회원등급보기</a></li>
								<li><a href="/myPage/inquiryList.do">1:1상담</a></li>
							</ul>
						</div> -->
					</div>