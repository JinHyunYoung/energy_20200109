<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<c:if test="${not empty commentList }">
	<div class="commentbox">
		<ul class="comment_list">
			<c:forEach items="${commentList }" var="list">
			
				<c:if test="${pre_depth == 1 && list.depth == 0 }">
							</ul>
						</div>
					</li>
				</c:if>
			
				<c:if test="${pre_depth == 0 && list.depth == 1 }">
						<!-- reply_area -->
						<div class="recommentbox">
							<ul class="comment_list">
				</c:if>
			
				<li class="commentData">
				
					<div class="info_arae">
						<strong class="name">${list.name }</strong>
						<span>${list.reg_date }</span>
						<span>${list.reg_time }</span>
					</div>
					
					<div class="txt_area contents"><p>${list.contents }</p>
					</div>
					
					<div class="button_area">
					
						<c:if test="${list.depth == 0}">
						<button class="btn_delete" title="답댓글달기" onclick="reComment(this,'${list.comment_id }','${list.grp }','${list.sort }');">
							<span><img src="/images/admin/common/btn_comment.png" alt="답댓글달기" /></span>
						</button>
						</c:if>
						
						<button class="btn_delete" title="수정하기" onclick="modComment(this,'${list.comment_id }');">
							<span><img src="/images/admin/common/btn_comment_revision.png"  alt="수정하기" /></span>
						</button>
						
						<button class="btn_delete" title="삭제하기" onclick="delComment('${list.comment_id }');">
							<span><img src="/images/admin/common/btn_comment_delete.png" alt="삭제하기" /></span>
						</button>
						
					</div>
				
				<c:set var="pre_depth" value="${list.depth }" />
				
				<c:if test="${pre_depth == 1}">
					</li>
				</c:if>
				
			</c:forEach>
			
			</li>
		</ul>
	</div>
</c:if>