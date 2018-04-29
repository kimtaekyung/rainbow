<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="lSupportViewTop">
	<ul>
		<li>
			<span class="lSupportViewTopColor">판매자가 확인한 문의글은 수정하거나 삭제할 수 없으며,</span> 먼저 등록된 문의글을 확인하면 보다 유익한 정보를 얻을 수 있습니다
		</li>
	</ul>
	<div id="lSupportViewWriteBtn">
		<input type="button" value="문의글 목록" id="lSupportListBtn" onclick="changeItemQnaDiv(3);">
	</div>
</div>

<div id="lSupportViewPage">
	<table class="lSupportViewTbl">
		<colgroup>
			<col width="95px">
			<col width="*">
		</colgroup>
		<thead>
			<tr>
				<th class="lSupportViewTh">문의제목</th>
				<td class="lSupportViewTd1 td">
					<span>${resultData.itemQa.IQA_SUBJECT }</span>
				</td>
			</tr>
			<tr>
				<th class="lSupportViewTh">문의글 등록자</th>
				<td class="lSupportViewTd2 td">
					<span class="lSupportViewWriteName">${resultData.itemQa.MB_ID }</span> (${resultData.itemQa.IQA_REG_DTTM_YMDHIS })
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<div class="lSuppoortViewContents">${resultData.contentList[0].CONTENT }</div>
					<div class="lSupportViewBtn"></div>
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<div class="lSupportViewReplyList">
				
			<c:if test="${fn:length(resultData.contentList) gt 1 }">
				<c:forEach var="con" items="${resultData.contentList }" varStatus="status">
					<c:if test="${status.index gt 0 }">
						<div class="lSupportViewReply">
							<div class="lSupportViewReplyWrap">
								<span>${con.MB_ID } (${con.CONTENT_REG_DTTM_YMDHIS })</span>
							</div>
							<div class="lSupportViewComments">
								<div class="lSupportViewComMemo">
									<span>${con.CONTENT }</span>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
						<!-- <div class="lSupportViewReply">
							<div class="lSupportViewReplyWrap">
								<span>psk6402 (2017/04/14 12:45:24)</span>
							</div>
							<div class="lSupportViewComments">
								<div class="lSupportViewComMemo">
									<span>안녕하세요 몽크로스다용도케이스 판매자 입니다. <br>
											대량 주문 시 가격 조정 가능 하시며 연락처 남겨 주시면 통화상으로 안내 도와 드리겠습니다. <br>
											감사합니다.
									</span>
								</div>
							</div>
						</div>
						<div class="lSupportViewReply">
							<div class="lSupportViewReplyWrap">
								<span>
									<img src="http://211.43.195.137/image/item/view/ico_lockedLite.png" style="margin-left:4px; vertical-align:-1px;" width="9" height="12" alt="비밀글">
									jangunmall (2017/10/29 20:01:18)
								</span>
							</div>
							<div class="lSupportViewComments">
								<div class="lSupportViewComMemo">
									<span>이 답변글은 문의글 등록자와 답변글 등록자 본인만 볼 수 있는 비밀글 입니다</span>
								</div>
							</div>
						</div> -->
					</div>
					
					<!-- 재질문 또는 답변 영역 -->
					<!-- 문의작성자와 로그인유저가 동일 또는 상품판매자와 로그인유저가 동일한 경우-->
				<c:if test="${sessionScope.rb_member.MB_SEQ eq resultData.itemQa.MB_SEQ or sessionScope.rb_member.MB_SEQ eq resultData.itemQa.ITEM_SELLER_SEQ }">
					<div class="lSupportViewWrite">
						<form name="qaContentFrm" class="lSupportViewFrm" method="post" action="/main/item/itemSupportAjax.php" enctype="multipart/form-data">
							<input type="hidden" name="iqa_seq" value="${resultData.itemQa.IQA_SEQ }">
							<input type="hidden" name="content_type" value="${sessionScope.rb_member.MB_SEQ eq resultData.itemQa.ITEM_SELLER_SEQ ? '1':'0' }">
							<input type="hidden" name="content_order" value="${fn:length(resultData.contentList)+1 }"/>
							
						<table>
							<colgroup>
								<col width="730px">
								<col width="120px">
							</colgroup>
							<tbody>
								<tr>
									<td class="lSupportViewMemo">
										<textarea id="lSupportViewTextarea" name="content" class="lSupportViewWriteArea"></textarea>
									</td>
									<td class="lSupportViewComBox">
										<!-- <div class="lSupportViewCheckBoxWrap">
											<input type="checkbox" id="lSupportViewCheckbox" name="secret" value="1">
											<label for="lSupportViewCheckbox">비밀글 지정</label>
										</div> -->
										<div class="lSupportViewAddBtn">
											<input type="button" onclick="insertShopItemQaContent();" value="${sessionScope.rb_member.MB_SEQ eq resultData.itemQa.ITEM_SELLER_SEQ ? '답변':'질문' }등록">
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="lSupportViewImageWrap">
							<div class="lSupportViewImages"><img src="/images/item/view/ico_camera.png">이미지첨부</div>
							<div class="lSupportViewImageFiles">
								<input type="file" value="" name="attach_image" class="lSupportViewFiles">
							</div>
							<!-- <input type="button" value="이미지추가" id="lSupportViewAddFile" onclick="lAddImage()"> -->
						</div>
						<div style="padding-top:10px; margin-left:120px; color:#aaaaaa; clear:both;">· 모든 이미지는 관리자가 검토하니 주의해주세요</div>
							
						</form>
					</div>
				</c:if>
					
				</td>
			</tr>
		</thead>
	</table>
</div>