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
<link rel="stylesheet" type="text/css" href="/css/item/itemCartComplete.css">

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
							현재위치 : <a href="/main.do">HOME</a> &gt; <a href="/buyer/buyMain.do">상품구매관리</a> &gt; <b class="fontBolder">주문완료</b>
						</div>
	
						<h2>주문완료</h2>
						<div class="orderSuccess">
							<div style="color:#e5004f; font-size: 35px; font-weight: bold;">"주문이 정상적으로 완료되었습니다"</div>
							<div>
								<div>
									구매관리 &gt; 상품구매관리 &gt; <a href="/main/myBuy/order/my_orderList.php?mode=ENTIRE">전체구매목록</a>에서
									주문내역 확인 및 배송추적을 하실 수 있습니다.
								</div>
							</div>
						</div>
						<!-- <div id="orderCountdown">
							<b><span>2초 후</u></b>에 주문내역 페이지로 이동합니다.
						</div> -->
						<div class="submit_button_area">
							<button class="button_list" title="주문확인" onclick="location.href='/buyer/buyList.do'">주문확인</button>
						</div>
						<!-- <div class="orderBtn">
							<a href="/buyer/buyList.do">
								<img src="/images/item/order/img_btnOrdConfirm.jpg" width="157" height="42" alt="주문확인" title="주문확인">
							</a>
						</div> -->
					</div>
					<div class="gClearBoth"></div>
	
				</div>
			</div>
	
			<!-- 푸터 -->
			<%@include file="/WEB-INF/views/common/footer.jsp" %>
		</div>
	</body>
</html>