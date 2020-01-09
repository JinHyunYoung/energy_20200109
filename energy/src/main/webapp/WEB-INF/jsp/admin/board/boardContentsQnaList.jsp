<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<c:forEach items="${boardlist }" var="list">

	<tr>
	
	<c:forEach items="${viewSortList }" var="view">
	
		<%-- <c:if test="${view.v_print ne 'secret' &&  view.v_print ne 'reply_status' && view.v_print ne 'link'}"> --%>
		
			<td class="
				<%-- <c:if test="${view.v_sort eq 1 }">first</c:if>
				<c:if test="${view.v_sort eq view.total_cnt }"> last</c:if> --%>
				<c:if test="${view.v_print eq 'title' || view.v_print eq 'contents'}"> alignl</c:if>
			">
			
				<%-- 번호 --%>
				<c:if test="${view.v_print eq 'number'}">
					<c:if test="${list.noti eq 'Y'}">공지</c:if>
					<c:if test="${list.noti ne 'Y'}">[버노]</c:if>
				</c:if>
				
				<%-- 국내외여부 --%>
				<c:if test="${view.v_print eq 'domestic_yn'}">
					<c:if test="${list.domestic_yn eq 'Y'}">
						<span class="album_nation">국내</span>
					</c:if>
					<c:if test="${list.domestic_yn ne 'Y'}">
						<span class="album_nation">해외</span>
					</c:if>
				</c:if>
				
				<%-- 카테고리 --%>
				<c:if test="${view.v_print eq 'cate'}">${list.cate_nm }</c:if>
				
				<%-- 제목 --%>
				<c:if test="${view.v_print eq 'title'}">
				
					<%-- 제목링크 확인 --%>
					<c:if test="${empty list.title_link}">
					
						<%-- 디테일 사용여부 확인 --%>
						<c:if test="${boardinfo.detail_yn eq 'Y'}">
						
							<a href="javascript:contentsView('${list.contents_id }')" >${list.title }</a>
							
							<%-- 비밀글 여부 아이콘 --%>
							<c:if test="${list.secret eq 'Y'}">[비밀글]</c:if>
							
						</c:if>
						
						<c:if test="${boardinfo.detail_yn eq 'N'}">${list.title }</c:if>
						
					</c:if>
					
					<%-- 제목링크 --%>
					<c:if test="${not empty list.title_link}">
						<a href="${list.title_link }" >${list.title }</a>
					</c:if>
					
				</c:if>
				<%--// 제목 --%>
				
				<%-- URL --%>
				<c:if test="${view.v_print eq 'url'}">${list.url_title } ${list.url_link }</c:if>
				
				<%-- 출처 --%>
				<c:if test="${view.v_print eq 'origin'}">${list.origin }</c:if>					
					
				<%-- 국가 --%>
				<c:if test="${view.v_print eq 'country'}">
					<dt class="vdt"><span>국가</span></dt>
					<dd class="vdd">${list.country }</dd>
				</c:if>
				
				<%-- 기타 --%>
				<c:if test="${view.v_print eq 'etc'}">
					<dt class="vdt"><span>
						<c:if test="${boardinfo.etc_label_nm eq 1 }">기타</c:if>
						<c:if test="${boardinfo.etc_label_nm eq 2 }">출원번호</c:if>
						<c:if test="${boardinfo.etc_label_nm eq 3 }">발행처</c:if>
						<c:if test="${boardinfo.etc_label_nm eq 4 }">운영기관</c:if>
					</span></dt>
					<dd class="vdd">${list.etc }</dd>
				</c:if>
				
				<%-- 날짜 --%>
				<c:if test="${view.v_print eq 'contents_date'}">
					<dt class="vdt"><span>
						<c:if test="${boardinfo.contents_date_label_nm eq 1 }">날짜</c:if>
						<c:if test="${boardinfo.contents_date_label_nm eq 2 }">출원일</c:if>
						<c:if test="${boardinfo.contents_date_label_nm eq 3 }">발간일</c:if>
					</span></dt>
					<dd class="vdd">${list.contents_date }</dd>
				</c:if>
				
				<%-- 내용 --%>
				<c:if test="${view.v_print eq 'contents'}">${list.contents }</c:if>
				
				<%-- 썸네일 --%>
				<c:if test="${view.v_print eq 'thumb'}">썸네일</c:if>
				
				<%-- 첨부파일 --%>
				<c:if test="${view.v_print eq 'attach'}">첨부파일</c:if>
				
				<%-- 작성자 --%>
				<c:if test="${view.v_print eq 'name'}">${list.name }</c:if>
				
				<%-- 핸드폰 --%>
				<c:if test="${view.v_print eq 'phone'}">${list.handphone }</c:if>
				
				<%-- 이메일 --%>
				<c:if test="${view.v_print eq 'email'}">${list.email }</c:if>
				
				<%-- 작성일 --%>
				<c:if test="${view.v_print eq 'reg_date'}">${list.reservation_date }</c:if>
				
				<%-- 아이피 --%>
				<c:if test="${view.v_print eq 'ip_addr'}">아이피</c:if>
				
				<%-- 추천수 --%>
				<c:if test="${view.v_print eq 'recommend'}">추천수</c:if>
				
				<%-- 만족도 --%>
				<c:if test="${view.v_print eq 'satisfy'}">만족도</c:if>
				
				<%-- 조회수 --%>
				<c:if test="${view.v_print eq 'hits'}">${list.hits }</c:if>
			
			</td>
			
		<%-- </c:if> --%>
		
	</c:forEach>	
	
	</tr>
	
</c:forEach>