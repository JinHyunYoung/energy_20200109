<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
</script>


<!-- table_top_area -->	
<div class="table_top_area">

	<div class="table_top_left">
		<span><strong id="tot_cnt" class="table_count">${totalcnt}</strong>건</span>
		
		<!--
		<select class="in_wp100" title="보기 선택" id="pageSize" onchange="changePageSize();">
			<option value="15" <c:if test="${param.miv_pageSize eq 15 }" >selected</c:if> >15개</option>
			<option value="20" <c:if test="${param.miv_pageSize eq 20 }" >selected</c:if>>20개</option>
			<option value="50" <c:if test="${param.miv_pageSize eq 50 }" >selected</c:if>>50개</option>
			<option value="100" <c:if test="${param.miv_pageSize eq 100 }" >selected</c:if>>100개</option>
		</select>
		-->
	</div>
	
	<div class="table_top_right">
	
		<label for="domestic_yn" class="hidden">국내외구분 선택</label>
		<select class="in_wp120" id="domestic_yn" name="domestic_yn">
			<option value="">-국내외구분-</option>
			<option value="Y" <c:if test="${param.domestic_yn eq 'Y' }" >selected</c:if>>국내</option>
			<option value="N" <c:if test="${param.domestic_yn eq 'N' }" >selected</c:if>>해외</option>
		</select>

		<label for="organ_gb" class="hidden">기관구분</label>
		<g:select id="organ_gb" name="organ_gb" codeGroup="ORGAN_GB" selected="${param.organ_gb}" titleCode="기관구분" cls="form-control" />  	
			
		<label for="user_yn" class="hidden">사용여부</label>
		<select class="in_wp100" id="user_yn" name="user_yn">
			<option value="">-사용여부-</option>
			<option value="Y" <c:if test="${param.user_yn eq 'Y' }" >selected</c:if> >사용</option>
			<option value="N" <c:if test="${param.user_yn eq 'N' }" >selected</c:if> >미사용</option>
		</select>  
		
        <label for="organ_nm" class="hidden">기관명</label>
		<input type="text" name="organ_nm" id="organ_nm" class="in_w200" placeholder="기관명" value="${param.organ_nm}"/>
		
        <button class="btn table_search" title="조회" onclick="search();"><span>조회</span></button>
		
	</div>
	<!--// search_area -->
	
</div>
<!--// table_top_area -->

         
<!-- album_list_hor_area -->	
<div class="album_list_hor_area marginb30">

	<ul class="album_list_hor">
	
		<c:forEach items="${organList}" var="list">		
			<li>
				<c:if test="${not empty list.image_file_nm}">
					<img src="/contents/organ/${list.image_file_nm}" alt="썸네일" class="info_img" />
				</c:if>
				<c:if test="${empty list.image_file_nm}">
					<img src="/images/web/common/no_album_img.png" alt="이미지 없음" class="info_img" />
				</c:if>
									
				<div class="list_info">
					<strong class="related_organ_category">
					<c:if test="${list.domestic_yn eq 'Y' }" >[국내]</c:if>
					<c:if test="${list.domestic_yn eq 'N' }" >[해외]</c:if>
					${list.organ_gb_nm}</strong>
					<strong class="related_organ_name">${list.organ_nm}</strong>
					<dl class="view">
						<dt class="vdt">
							<span>홈페이지</span>
						</dt>
						<dd class="vdd">
							<a title="해당 url로 새창이동" class="link" href="${list.organ_homepage}" target="_blank">
								${list.organ_homepage}
							</a> 
						</dd>
					</dl>
					<dl class="view">
						<dt class="vdt">
							<span>전화번호</span>
						</dt>
						<dd class="vdd">${list.organ_tel}</dd>
					</dl>
					<dl class="view">
						<dt class="vdt">	
							<span>주소</span>
						</dt>
						<dd class="vdd">(${list.post}) ${list.addr1} (${list.addr2})</dd>
					</dl>
					<dl class="view">
			 			<dt class="vdt">
							<span>관리기관</span>
						</dt>
						<dd class="vdd">${list.mt_organ_nm}</dd>
					</dl>
				</div>
			</li>
		</c:forEach>
		
		<c:if test="${empty organList }">
			<li>등록된 게시물이 없습니다.</li>
		</c:if>
	</ul>
</div>
<!--// album_list_hor_area -->

<!-- paging_area -->
${organPagging}
<!--// paging_area -->
	
