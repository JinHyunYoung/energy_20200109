<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
$(document).ready(function(){
	
	// tab 이벤트
	$(function() {
	    
		$(".area_tab > ul.tablist li").click(function() {
		    
	        var now_tab = $(this).index();
	        
	        $(this).parent().find("li").removeClass("on");
	        $(this).parent().parent().parent().find(".tab").addClass("hidden");
	
	        $(this).parent().find("li").eq(now_tab).addClass("on");
	        $(this).parent().parent().parent().find(".tab").eq(now_tab).removeClass("hidden");
	        	        	        
	        if(now_tab == 0) {
	            $("#tab_domestic_yn").val(""); 
	        } else if(now_tab == 1) {
	            $("#tab_domestic_yn").val("Y"); 
	        } else if(now_tab == 2) {
	            $("#tab_domestic_yn").val("N"); 
	        }
	        
	        search();
	    });
	});
	
	
	init_tab();
	
});

function init_tab(){
    var tab_domestic_yn = $('#tab_domestic_yn').val();
    
    if(tab_domestic_yn == 'Y'){
		$("ul.tablist li:eq(0)").removeClass('on');
		$("ul.tablist li:eq(1)").addClass('on');
		$("ul.tablist li:eq(2)").removeClass('on');
    }else if(tab_domestic_yn == 'N'){	
		$("ul.tablist li:eq(0)").removeClass('on');
		$("ul.tablist li:eq(1)").removeClass('on');
		$("ul.tablist li:eq(2)").addClass('on');
    }
}

</script>

<!-- 국내외구분 탭 -->	
<c:if test="${boardinfo.tabmenu_use_yn eq 'Y'}"> 

	<input type='hidden' id="tab_domestic_yn" name='domestic_yn' value="${param.domestic_yn}" />
	
	<div class="area_tab marginb40">
		<ul class="tablist">
			<li class="on"><a href="#x" title="전체">전체</a></li>
			<li><a href="#x" title="국내">국내</a>	</li>
			<li><a href="#x" title="해외">해외</a></li>
		</ul>
	</div>		
	
	<div class="tab"></div>	
	<div class="tab hidden"></div>	 
	<div class="tab hidden"></div>
	
</c:if>

<!-- table_count_area -->	
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

		<c:if test="${boardinfo.board_type eq 'Q'}">
			<label for="reply_ststus" class="hidden">답변상태 선택</label>
			<select class="in_wp80" id="reply_ststus" name="reply_ststus" >
				<option value="">답변상태</option>
				<option value="S" <c:if test="${param.reply_ststus eq 'S' }" >selected</c:if>>답변완료</option>
				<option value="W" <c:if test="${param.reply_ststus eq 'W' }" >selected</c:if>>답변대기</option>
			</select>
		</c:if>

		<c:if test="${boardinfo.tabmenu_use_yn ne 'Y'}"> 
		<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}"> 
			<label for="domestic_yn" class="hidden">국내외구분 선택</label>
			<select class="in_wp120" id="domestic_yn" name="domestic_yn">
				<option value="">국내외구분</option>
				<option value="Y" <c:if test="${param.domestic_yn eq 'Y' }" >selected</c:if>>국내</option>
				<option value="N" <c:if test="${param.domestic_yn eq 'N' }" >selected</c:if>>해외</option>
			</select>
		</c:if>
		</c:if>

		<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}"> 
			<label for="cate_id" class="hidden">카테고리 선택</label>
			<select class="in_wp80" id="cate_id" name="cate_id">
				<option value="">카테고리</option>
				<c:forEach items="${category }" var="list">
					<option value="${list.cate_id }" <c:if test="${list.cate_id eq param.cate_id}" >selected</c:if>>${list.title }</option>
				</c:forEach>
			</select>
		</c:if>
		
		<label for="searchkey" class="hidden">검색어 분류 선택</label>
		<select class="in_wp100" id="searchkey" name="searchkey">
			<option value="T" <c:if test="${param.searchkey eq 'T' }" >selected</c:if> >제목</option>
			<option value="C" <c:if test="${param.searchkey eq 'C' }" >selected</c:if> >내용</option>
			<option value="U" <c:if test="${param.searchkey eq 'U' }" >selected</c:if> >작성자</option>
		</select>  
		
        <label for="searchtxt" class="hidden">검색어 입력창</label>
		<input type="text" name="searchtxt" id="searchtxt" class="in_w200" value="${param.searchtxt}"/>
		
        <button class="btn table_search" title="조회" onclick="search();"><span>조회</span></button>
		
	</div>
	<!--// search_area -->
	
</div>
<!--// table_count_area -->

<!-- album_list_hor_area -->	
<div class="album_list_hor_area marginb30">

	<ul class="album_list_hor">
	<c:forEach items="${boardList }" var="list">
	
		<li> 
		
			<c:if test="${not empty list.image_file_nm}">
				<img src="/contents/board/${list.image_file_nm}" alt="썸네일" class="info_img" />
			</c:if>
			
			<c:if test="${empty list.image_file_nm}">
				<img src="/images/web/common/no_album_img.png" alt="이미지 없음" class="info_img" />
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
				
					<%-- 제목링크 사용안함 --%>
					<c:if test="${empty list.title_link}">
					
						<%-- 디테일 사용 --%>
						<c:if test="${boardinfo.detail_yn eq 'Y'}">
							<a href="javascript:contentsView('${list.contents_id }')" >${list.title }</a>
						</c:if>
						
						<%-- 디테일 사용안함 --%>
						<c:if test="${boardinfo.detail_yn eq 'N'}">
							${list.title }
						</c:if>
						
						<%-- 댓글 사용여부 확인 --%>
						<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">
							<c:if test="${list.comment_cnt > 0}">
								[<strong class="color_pointr">${list.comment_cnt }</strong>]
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
					<dt class="vdt"><span>첨부파일</span></dt>
					<dd class="vdd">
					
					<%-- 디테일 사용안함 --%>
					<c:if test="${boardinfo.detail_yn ne 'Y'}">
					
						<%-- 첨부파일이 있는경우 --%>
						<c:if test="${not empty list.group_id}">
						
							<%-- 첨부파일이 1개인경우 다운로드 --%>
							<c:if test="${not empty list.file_id}">
								<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" title="다운받기">
							</c:if>
								<img src="/images/web/icon/icon_file.png" alt="첨부파일" />
							<c:if test="${not empty list.file_id}">
								</a>
							</c:if>
						</c:if>
					</c:if>
					
					<%-- 디테일 사용 --%>
					<c:if test="${boardinfo.detail_yn eq 'Y'}">
					
						<%-- 첨부파일이 있는경우 --%>
						<c:if test="${not empty list.group_id}">
							<img src="/images/web/icon/icon_file.png" alt="첨부파일" />
						</c:if>
					</c:if>
					
					</dd>
				</dl>
				</c:if>
				<%-- // 첨부파일 --%>
				
			</div>
		</li>
	</c:forEach>
	
	<c:if test="${empty boardList }">
		<li>등록된 게시물이 없습니다.</li>
	</c:if>
	
	</ul>
</div>
<!--// album_list_hor_area -->

<!-- button_area -->
<div class="button_area">

	<div class="float_right">
	
		<%-- 회원이면서 글쓰기 권한이 있는경우 --%>
		<c:if test="${not empty param.s_auth_id }">
			<c:if test="${fn:indexOf(boardinfo.grant_write, 'M') != -1}">
				<button class="btn save" onclick="contentsWrite()" title="등록"><span>등록</span></button>
			</c:if>
		</c:if>
		
		<%-- 비회원이면서 글쓰기 권한이 있는경우 --%>
		<c:if test="${empty param.s_auth_id }">
			<c:if test="${fn:indexOf(boardinfo.grant_write, 'G') != -1}">
				<button class="btn save" onclick="contentsWrite()" title="등록"><span>등록</span></button>
			</c:if>
		</c:if>
		
	</div>
</div>
<!--// button_area -->

<!-- paging_area -->
${boardPagging}
<!--// paging_area -->