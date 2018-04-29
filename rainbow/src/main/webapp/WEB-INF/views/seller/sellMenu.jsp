<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
        type: "POST",
        url: "/seller/getSellLeftMenuDataCountAjax.do",
        data: {},
        dataType : "json",
		async : true,
        success: function(result, status, xhr){
        	var itemGroupCount = result.itemGroupCount;
        	var orderGroupCount = result.orderGroupCount;
        	
        	$("a#itemStatus").text( $("a#itemStatus").text() + '('+itemGroupCount.ITEM_TOTAL+')');
        	$("a#itemStatus1").text( $("a#itemStatus1").text() + '('+itemGroupCount.ITEM_STATUS_1+')');
        	$("a#itemStatus5").text( $("a#itemStatus5").text() + '('+itemGroupCount.ITEM_STATUS_5+')');
        	$("a#itemStatus2").text( $("a#itemStatus2").text() + '('+itemGroupCount.ITEM_STATUS_2+')');
        	$("a#itemStatus3").text( $("a#itemStatus3").text() + '('+itemGroupCount.ITEM_STATUS_3+')');
        	$("a#itemStatus4").text( $("a#itemStatus4").text() + '('+itemGroupCount.ITEM_STATUS_4+')');
        	
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
								<img src="http://via.placeholder.com/145x75" alt="판매관리 타이틀" width="145" height="75">
							</div>
						</div>
		
						<div class="section">
							<div class="title">
								<img src="/images/seller/img_menuItemReg.jpg" alt="상품등록관리" width="145" height="22">
							</div>
							<ul>
								<li><a href="/item/itemForm.do">상품등록하기</a></li>
								<li class="${currUri eq '/seller/itemExcelRegist.do' ? 'selected':'' }"><a href="/seller/itemExcelRegist.do">상품대량등록하기</a></li>
								<!-- <li><a href="/main/mySell/register/my_sellItemsRegStatus.php">상품대량등록현황</a></li>
								<li><a href="/main/mySell/register/my_sellNotice.php">상품공지관리</a></li>
								<li><a href="/main/mySell/register/my_sellInfoDutyList.php">고시사항일괄변경</a></li>
								<li><a href="/main/mySell/register/my_sellItemsSafetyCert.php">인증정보일괄수정</a></li> -->
								<li class="${currUri eq '/seller/sellRegistItemList.do' and empty resultDataMap.item_status ? 'selected':'' }"><a href="/seller/sellRegistItemList.do?item_status=" id="itemStatus">전체상품</a></li>
								<li class="${currUri eq '/seller/sellRegistItemList.do' and resultDataMap.item_status eq '1' ? 'selected':'' }"><a href="/seller/sellRegistItemList.do?item_status=1" id="itemStatus1">승인대기</a></li>
								<li class="${currUri eq '/seller/sellRegistItemList.do' and resultDataMap.item_status eq '5' ? 'selected':'' }"><a href="/seller/sellRegistItemList.do?item_status=5" id="itemStatus5">승인거부</a></li>
								<li class="${currUri eq '/seller/sellRegistItemList.do' and resultDataMap.item_status eq '2' ? 'selected':'' }"><a href="/seller/sellRegistItemList.do?item_status=2" id="itemStatus2">판매중</a></li>
								<li class="${currUri eq '/seller/sellRegistItemList.do' and resultDataMap.item_status eq '3' ? 'selected':'' }"><a href="/seller/sellRegistItemList.do?item_status=3" id="itemStatus3">판매종료</a></li>
								<li class="${currUri eq '/seller/sellRegistItemList.do' and resultDataMap.item_status eq '4' ? 'selected':'' }"><a href="/seller/sellRegistItemList.do?item_status=4" id="itemStatus4">기간종료</a></li>
							</ul>
						</div>
		
						<div class="section">
							<div class="title">
								<img src="/images/seller/img_menuOrderManage.jpg" alt="상품판매관리" width="145" height="22">
							</div>
							<ul>
								<li class="${currUri eq '/seller/sellList.do' and empty resultDataMap.order_state ? 'selected':'' }"><a href="/seller/sellList.do?order_state=" id="orderState">전체보기</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '1' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=1" id="orderState1">결제대기</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '2' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=2" id="orderState2">결제완료</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '3' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=3" id="orderState3">배송대기</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '4' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=4" id="orderState4">배송중</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '5' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=5" id="orderState5">구매완료</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '6' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=6" id="orderState6">결제대기취소</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '7' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=7" id="orderState7">결제취소</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '8' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=8" id="orderState8">판매취소</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '9' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=9" id="orderState9">반품요청</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '10' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=10" id="orderState10">교환요청</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '11' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=11" id="orderState11">반품승인</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '12' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=12" id="orderState12">교환승인</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '13' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=13" id="orderState13">반품완료</a></li>
								<li class="${currUri eq '/seller/sellList.do' and resultDataMap.order_state eq '14' ? 'selected':'' }"><a href="/seller/sellList.do?order_state=14" id="orderState14">교환완료</a></li>
							</ul>
						</div>
		
						<div class="section">
							<div class="title">
								<img src="/images/seller/img_menuItemInquiry.jpg" alt="상품문의관리" width="145" height="22">
							</div>
							<ul>
								<li class="${currUri eq '/seller/itemQaList.do' ? 'selected':'' }"><a href="/seller/itemQaList.do">상품문의관리</a></li>
							</ul>
						</div>
		
						<div class="section">
							<div class="title">
								<img src="/images/seller/img_menuCalculate.jpg" alt="정산내역관리" width="145" height="22">
							</div>
							<ul>
								<li><a href="">부가세신고자료</a></li>
								<li class="${currUri eq '/seller/calculateList.do' ? 'selected':'' }"><a href="/seller/calculateList.do">판매자정산내역</a></li>
							</ul>
						</div>
		
						<!-- <div class="boxSection">
							<div class="title">
								<img src="/images/seller/img_menuMyDome.jpg" alt="MyPage 바로가기" width="145" height="22">
							</div>
							<ul>
								<li><a href="/main/myPage/emoney/my_emoneyList.php">E-money관리</a></li>
								<li><a href="/main/myPage/tax/my_taxList.php">세금계산서</a></li>
								<li><a href="/main/member/mem_formRegular.php?mode=editRegular&amp;back=">개인정보관리</a></li>
								<li><a href="/main/myPage/score/my_scoreView.php">회원등급보기</a></li>
								<li><a href="/main/myPage/support/my_supportList.php">1:1상담</a></li>
							</ul>
						</div> -->
					</div>
