<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<!-- table_search_area -->
<div class="table_search_area">
	<div class="float_left">
		<span><strong class="color_pointo" id="tot_cnt">${totalcnt }</strong>건</span>
	</div>
	<div class="float_right">
		<select class="in_wp100" title="보기 선택" onchange="changePageSize(this.value)">
			<option value="15" <c:if test="${param.miv_pageSize eq 15 }" >selected</c:if> >15개씩 보기</option>
			<option value="20" <c:if test="${param.miv_pageSize eq 20 }" >selected</c:if>>20개씩 보기</option>
			<option value="50" <c:if test="${param.miv_pageSize eq 50 }" >selected</c:if>>50개씩 보기</option>
			<option value="100" <c:if test="${param.miv_pageSize eq 100 }" >selected</c:if>>100개씩 보기</option>
		</select>
	</div>
</div>
<!--// table_search_area -->

<!-- album_list_area -->
<div class="album_list_area">

	<ul class="album_list report_list">
	
		<c:forEach items="${boardList }" var="list">
		
		<li>
			<div class="album">
			
				<div class="album_img_area">
					<c:if test="${not empty list.image_file_nm}">
						<img src="/contents/board/${list.image_file_nm}" alt="썸네일" class="info_img" />
					</c:if>
					<c:if test="${empty list.image_file_nm}">
						<img src="/images/admin/common/detail_no_img.png" alt="이미지 없음" class="info_img" />
					</c:if>
				</div>
				
				<div class="album_txt_area">
					
					<%-- 제목 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">				
					<div class="album_title_area">
						<span class="album_title">
							<a href="javascript:contentsView('${list.contents_id }')" >${list.title }</a>
						</span>							
					</div>			
					</c:if>
					
					<%-- 기타, 날짜 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1 or fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">	
					<div class="album_register_area">					
						<ul>
							<li>
								<%-- 기타 --%>
								<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1}">
								<strong class="register_name">${list.etc }</strong>
								</c:if>
								
								<%-- 날짜 --%>
								<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">
								<span>${list.contents_date }</span>
								</c:if>								
							</li>
						</ul>												
					</div>	
					</c:if>
										
					<%-- 첨부파일이 있는경우 --%>
					<c:if test="${not empty list.group_id}">
					<div class="album_file_area">						
						
						<%-- 첨부파일이 1개인경우 다운로드 --%>
						<c:if test="${not empty list.file_id}">
							<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" title="다운받기">
						</c:if>
						
							<img src="/images/admin/icon/icon_file.png" alt="첨부파일" />
						
						<c:if test="${not empty list.file_id}">
							</a>
						</c:if>
						
					</div>
					</c:if>		
						
				</div>
			</div>
		</li>
		
		</c:forEach>
	
		<c:if test="${empty boardList }">
		<li><div class="album">등록된 게시물이 없습니다.</div></li>
		</c:if>
	
	</ul>
</div>
<!--// table 1dan list -->

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->