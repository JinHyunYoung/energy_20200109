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

	<ul class="album_list">
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
				<div class="album_name_area">
				
					<%-- 국내외여부 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1}">
						<c:if test="${list.domestic_yn eq 'Y'}">
							<span class="album_nation">국내</span>
						</c:if>
						<c:if test="${list.domestic_yn ne 'Y'}">
							<span class="album_nation">해외</span>
						</c:if>
					</c:if>
					
					<%-- 카테고리 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}">
						<span class="album_category">${list.cate_nm }</span>
					</c:if>
					
					<%-- 조회수 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}">
						<span class="album_number">${list.hits }</span>
					</c:if>
						
					
				</div>
				<div class="album_title_area">
				
				<%-- 제목 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">
				
					<%-- 제목링크 확인 --%>
					<c:if test="${empty list.title_link}">
					
						<%-- 디테일 사용여부 확인 --%>
						<c:if test="${boardinfo.detail_yn eq 'Y'}">
						
							<%-- 상세 보기 --%>
							<span class="album_title">
								<a href="javascript:contentsView('${list.contents_id }')" >${list.title }</a>
							</span>
							
						</c:if>
						
						<%-- 상세 사용여부 --%>
						<c:if test="${boardinfo.detail_yn eq 'N'}">
							<span class="album_title">${list.title }</span>
						</c:if>
						
					</c:if>
					
					<%-- 타이틀 링크 --%>
					<c:if test="${not empty list.title_link}">
						<a href="javascript:contentsView('${list.title_link}')" >
							<span class="album_title">${list.title }</span>
						</a>
					</c:if>
					
				</c:if>
				</div>
														
				<c:if test="${
				fn:indexOf(boardinfo.view_print, 'name') != -1 or 
				fn:indexOf(boardinfo.view_print, 'comment') != -1 or 
				fn:indexOf(boardinfo.view_print, 'reg_date') != -1 or 
				fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">	
				<div class="album_register_area">
					<ul>					
						<li>
							<%-- 작성자 --%>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}">
								<strong class="register_name">${list.name }</strong>
							</c:if>
							
							<%-- 댓글 사용여부 확인 --%>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">
								<c:if test="${list.comment_cnt > 0}">
									<p class="reply_count">댓글 [<span>${list.comment_cnt }</span>]</p>
								</c:if>
							</c:if>
						</li>
						
						<li>
							
							<%-- 작성일 --%>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}">
								<span>${list.reservation_date }</span>
							</c:if>
						
							<%-- 아이피 --%>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">
								<span> / ${list.ip_addr }</span>
							</c:if>							
							
						</li>						
					</ul>												
				</div>
				</c:if>	
				
								
				<%-- 첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}">
				<div class="album_file_area">				
					<c:if test="${not empty list.group_id }">
						<span class="album_file">
							<img src="/images/admin/icon/icon_file.png" alt="첨부파일">
						</span>
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