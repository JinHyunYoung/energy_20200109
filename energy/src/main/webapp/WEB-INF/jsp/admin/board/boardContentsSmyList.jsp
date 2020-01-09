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

<!-- table 1dan list -->
<div class="album_list_hor_area marginb30">

	<ul class="album_list_hor">
	
		<c:forEach items="${boardList }" var="list">
		<li>
		
			<c:if test="${not empty list.image_file_nm}">
				<img src="/contents/board/${list.image_file_nm}" alt="썸네일" class="info_img" />
			</c:if>
			
			<c:if test="${empty list.image_file_nm}">
				<img src="/images/admin/common/detail_no_img.png" alt="이미지 없음" class="info_img" />
			</c:if>
			
			<div class="list_info">			
						
				<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1 or fn:indexOf(boardinfo.view_print, 'cate') != -1}">
				<dl class="view">
										
					<%-- 국내외여부 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1}">
						<dt class="vdt"><span>국내외여부</span></dt>
						
						<c:if test="${list.domestic_yn eq 'Y'}">
						<dd class="vdd">국내</dd>
						</c:if>
						
						<c:if test="${list.domestic_yn ne 'Y'}">
						<dd class="vdd">해외</dd>
						</c:if>
					</c:if>
					
					<%-- 카테고리 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}">
						<dt class="vdt"><span>카테고리</span></dt>
						<dd class="vdd">${list.cate_nm }</dd>
					</c:if>
			
				</dl>
				</c:if>
				
				<%-- 제목 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">				
				<strong class="title">
					
					<%-- 제목링크 확인 --%>
					<c:if test="${empty list.title_link}">
					
						<%-- 디테일 사용 --%>
						<c:if test="${boardinfo.detail_yn eq 'Y'}">
							<a href="javascript:contentsView('${list.contents_id }')" >${list.title }</a>
						</c:if>
						
						<%-- 디테일 사용 안함--%>
						<c:if test="${boardinfo.detail_yn eq 'N'}">
							${list.title }
						</c:if>
					
						<%-- 댓글 사용여부 확인 --%>
						<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">
							<c:if test="${list.comment_cnt > 0}">
								[<strong class="reply_count">${list.comment_cnt }</strong>]
							</c:if>
						</c:if>
					</c:if>												
				
					<%-- 제목링크 사용 --%>
					<c:if test="${not empty list.title_link}">
						<a href="javascript:contentsView('${list.title_link }')" >${list.title }</a>
					</c:if>
					
				</strong>					
				</c:if>
				
				<%-- 내용 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">
				<p class="memo">
					<c:choose>
						<c:when test="${fn:length(list.contents) > 200}">
							<c:out value="${fn:substring(list.contents,0,200)}"/><c:out value="..."/>
						</c:when>
						<c:otherwise>
							${list.contents }
						</c:otherwise>
					</c:choose>
				</p>
				</c:if>
				
				<c:if test="${
				fn:indexOf(boardinfo.view_print, 'name') != -1 or 
				fn:indexOf(boardinfo.view_print, 'email') != -1 or 
				fn:indexOf(boardinfo.view_print, 'reg_date') != -1 or 
				fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">
				<dl class="view">
					
					<%-- 작성자 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}">
						<dt class="vdt"><span>작성자</span></dt>
						<dd class="vdd">${list.name }</dd>
					</c:if>
					
					<%-- 휴대전화
					<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') != -1}">
						<dt class="vdt"><span>휴대전화</span></dt>
						<dd class="vdd">${list.handphone }</dd>
					</c:if>
					 --%>
					
					<%-- 이메일 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'email') != -1}">
						<dt class="vdt"><span>이메일</span></dt>
						<dd class="vdd">${list.email }</dd>
					</c:if>
					
					<%-- 작성일 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}">
						<dt class="vdt"><span>작성일</span></dt>
						<dd class="vdd">${list.reservation_date }</dd>
					</c:if>
					
					<%-- 아이피 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">
						<dt class="vdt"><span>IP</span></dt>
						<dd class="vdd">${list.ip_addr }</dd>
					</c:if>
				</dl>
				</c:if>
				
				
				<%-- URL --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'url') != -1}">
				<dl class="view">				
					<dt class="vdt"><span>URL</span></dt>
					<dd class="vdd"><a href=" ${list.url_link }" title="해당 url로 새창이동" target="_blank">${list.url_title }</a></dd>
				</dl>
				</c:if>
				
				
				<c:if test="${
				fn:indexOf(boardinfo.view_print, 'origin') != -1 or 
				fn:indexOf(boardinfo.view_print, 'country') != -1 or 
				fn:indexOf(boardinfo.view_print, 'etc') != -1 or 
				fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">
				<dl class="view">
					
					<%-- 출처 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') != -1}">
						<dt class="vdt"><span>출처</span></dt>
						<dd class="vdd">${list.origin }</dd>
					</c:if>
					
					<%-- 국가 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'country') != -1}">
						<dt class="vdt"><span>국가</span></dt>
						<dd class="vdd">${list.country }</dd>
					</c:if>
					
					<%-- 기타 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1}">
						<dt class="vdt"><span>
							<c:if test="${boardinfo.etc_label_nm eq 1 }">기타</c:if>
							<c:if test="${boardinfo.etc_label_nm eq 2 }">출원번호</c:if>
							<c:if test="${boardinfo.etc_label_nm eq 3 }">발행처</c:if>
							<c:if test="${boardinfo.etc_label_nm eq 4 }">운영기관</c:if>
						</span></dt>
						<dd class="vdd">${list.etc }</dd>
					</c:if>
					
					<%-- 날짜 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">
						<dt class="vdt"><span>
							<c:if test="${boardinfo.contents_date_label_nm eq 1 }">날짜</c:if>
							<c:if test="${boardinfo.contents_date_label_nm eq 2 }">출원일</c:if>
							<c:if test="${boardinfo.contents_date_label_nm eq 3 }">발간일</c:if>
						</span></dt>
						<dd class="vdd">${list.contents_date }</dd>
					</c:if>
				</dl>
				</c:if>
				
				<c:if test="${
				fn:indexOf(boardinfo.view_print, 'recommend') != -1 or 
				fn:indexOf(boardinfo.view_print, 'satisfy') != -1 or 
				fn:indexOf(boardinfo.view_print, 'hits') != -1}">
				<dl class="view">
					
					<%-- 추천수 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') != -1}">
						<dt class="vdt"><span>추천</span></dt>
						<dd class="vdd">${list.recommend }</dd>
					</c:if>
					
					<%-- 만족도 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') != -1}">
						<dt class="vdt"><span>만족도</span></dt>
						<dd class="vdd">${list.satisfy }</dd>
					</c:if>
					
					<%-- 조회수 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}">
						<dt class="vdt"><span>조회수</span></dt>
						<dd class="vdd">${list.hits }</dd>
					</c:if>
				</dl>
				</c:if>
				
				<%-- 첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}">
				<dl class="view">				
					<c:if test="${not empty list.group_id }">
						<dl class="view">
							<dt class="vdt"><span>첨부파일</span></dt>
							<dd class="vdd"><img src="/images/admin/icon/icon_file.png" alt="파일" /></dd>
						</dl>
					</c:if>
				</dl>
				</c:if>
								
			</div>
		</li>
		</c:forEach>
		
		<c:if test="${empty boardList }">
			<li><div class="list_info">등록된 게시물이 없습니다.</div></li>
		</c:if>
		
	</ul>
</div>
<!--// table 1dan list -->

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->