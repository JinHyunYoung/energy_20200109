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
		
			<c:if test="${pre_depth == 0 && list.depth == 1}">
					<!-- reply_area -->
					<div class="recommentbox">
						<ul class="comment_list">
			</c:if>
		
			<!-- class="commentData" -->
			<li class="commentData"> 
			
				<div class="info_arae">
				
					<strong class="name">${list.name}</strong>
					<span style ="color:#b5b5b5;"> | </span>
					<span style ="color:#b5b5b5;">${list.reg_date}</span>
					<span style ="color:#b5b5b5;">${list.reg_time}</span>
					
					<ul class="comment_button_area">
					
						<c:if test="${list.depth == 0}">
							<li>
								<a href="javscript:void(0)" onclick="reComment(this,'${list.comment_id }','${list.grp }','${list.sort }');"  title="답댓글 버튼">
									<span>답댓글</span>
								</a>
							</li>
						</c:if>
						
						<%-- 회원 비회원 여부 --%>
						<c:if test="${not empty s_user_no}" >
							<c:if test="${(s_user_no  eq list.REG_USERNO)}">
								<li><a href="javscript:void(0)" onclick="modComment(this,'${list.comment_id }');" title="수정 버튼"><span>수정</span></a></li>
								<li><a href="javscript:void(0)" onclick="delComment('${list.comment_id }');" title="삭제 버튼"><span>삭제</span></a></li>
							</c:if>
						</c:if>
						
						<%-- 패스워드의 존재여부 --%>
						<c:if test="${list.pass_yn eq 'Y'}">
							<li><a href="javscript:void(0)" onclick="chkComment(this,'${list.comment_id }', 'E');" title="수정 버튼"><span>수정</span></a></li>
							<li><a href="javscript:void(0)" onclick="chkComment(this,'${list.comment_id }', 'D');" title="삭제 버튼"><span>삭제</span></a></li>
						</c:if>
					</ul>
				</div>
				
				<div class="txt_area contents"><p>${list.contents }</p></div>
				
			<c:set var="pre_depth" value="${list.depth }" />
			
			<c:if test="${pre_depth == 1}">
				</li>
			</c:if>
			
		</c:forEach>
		
		</li>
		
	</ul>
	
</div>
</c:if>