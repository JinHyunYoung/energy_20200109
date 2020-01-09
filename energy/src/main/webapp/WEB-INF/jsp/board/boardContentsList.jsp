<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
$(document).ready(function(){
    
	// 댓글수 노출여부 확인후 숨기기(미구현)
	<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') == -1}">
		$("#comment_cnt").hide();
	</c:if>
	
	// 답변 노출여부 확인후 숨기기(미구현)
	<c:if test="${fn:indexOf(boardinfo.view_print, 'reply_status') == -1}">
		$("#reply_status").hide();
	</c:if>
	
	
	// 모바일 전용 페이지 숨기지
	$(".mobile_list").hide();
	
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
				<c:forEach items="${category}" var="list">
					<option value="${list.cate_id}" <c:if test="${list.cate_id eq param.cate_id}" >selected</c:if>>${list.title}</option>
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

<!--// list_table_area -->  
<div class="table_area only_web_list">

	<table class="list fixed">
	
		<caption>게시판 리스트 화면</caption>
		<colgroup>
			<c:forEach items="${viewSortList}" var="view">
				<c:if test="${view.v_print ne 'secret' &&  view.v_print ne 'reply_status' && view.v_print ne 'link' && view.v_print ne 'comment'}">
					<col style="width: ${view.v_size }%;" />
				</c:if>
			</c:forEach>
		</colgroup>
		
		<thead>
		<tr>
			<c:forEach items="${viewSortList }" var="view" varStatus="i">
			
				<c:set var="totcnt" value="${view.total_cnt }" />
				
				<c:if test="${view.v_print ne 'secret' &&  view.v_print ne 'reply_status' && view.v_print ne 'link' && view.v_print ne 'comment'}">
				<th scope="col" class="
					<c:if test="${i.first}">first</c:if>
					<c:if test="${(i.index + 1) == totcnt}">last</c:if>
				">
				
				<c:if test="${view.v_print eq 'number' }">번호</c:if>
				<c:if test="${view.v_print eq 'domestic_yn' }">국내외구분</c:if>				
				<c:if test="${view.v_print eq 'cate' }">카테고리</c:if>
				<c:if test="${view.v_print eq 'title' }">제목</c:if>
				<c:if test="${view.v_print eq 'url' }">URL</c:if>
				<c:if test="${view.v_print eq 'origin' }">출처</c:if>
				<c:if test="${view.v_print eq 'country' }">국가</c:if>
				<c:if test="${view.v_print eq 'etc' }">
					<c:if test="${boardinfo.etc_label_nm eq 1 }">기타</c:if>
					<c:if test="${boardinfo.etc_label_nm eq 2 }">출원번호</c:if>
					<c:if test="${boardinfo.etc_label_nm eq 3 }">발행처</c:if>
					<c:if test="${boardinfo.etc_label_nm eq 4 }">운영기관</c:if>
				</c:if>
				<c:if test="${view.v_print eq 'contents_date' }">
					<c:if test="${boardinfo.contents_date_label_nm eq 1 }">날짜</c:if>
					<c:if test="${boardinfo.contents_date_label_nm eq 2 }">출원일</c:if>
					<c:if test="${boardinfo.contents_date_label_nm eq 3 }">발간일</c:if>
				</c:if>
				<c:if test="${view.v_print eq 'contents' }">내용</c:if>
				<c:if test="${view.v_print eq 'thumb' }">썸네일</c:if>
				<c:if test="${view.v_print eq 'attach' }">첨부파일</c:if>
				<c:if test="${view.v_print eq 'name' }">작성자</c:if>
				<!--  <c:if test="${view.v_print eq 'phone' }">휴대전화</c:if> -->
				<c:if test="${view.v_print eq 'reg_date' }">작성일</c:if>
				<c:if test="${view.v_print eq 'ip_addr' }">IP</c:if>
				<c:if test="${view.v_print eq 'recommend' }">추천</c:if>
				<c:if test="${view.v_print eq 'satisfy' }">만족도</c:if>
				<c:if test="${view.v_print eq 'hits' }">조회수</c:if>
				</th>
				</c:if>
			</c:forEach>
		</tr>
		</thead>
		
		<tbody>			
		
			<c:forEach items="${boardList }" var="list">
			
				<c:forEach items="${viewSortList}" var="view" varStatus="i">
				
				<c:if test="${view.v_print ne 'secret' &&  view.v_print ne 'reply_status' && view.v_print ne 'link' && view.v_print ne 'comment'}">
				
				<c:set var="contents_title" value="${fn:replace(list.title, 'RE : ', '')}" />
				
				<td class="
					<c:if test="${i.first}">first</c:if>
					<c:if test="${i.last}">last</c:if>
					<c:if test="${view.v_print eq 'title' || view.v_print eq 'contents'}"> alignl</c:if>
					
					<%-- 답글 여부 --%>
					<c:if test="${view.v_print eq 'title' && list.relevel_seq > 0}"> reply</c:if>
				">
				
				<%-- 번호 --%>
				<c:if test="${view.v_print eq 'number'}">
					<c:if test="${list.noti eq 'Y'}"><img src="/images/web/icon/icon_notice.png" alt="공지" /></c:if>
					<c:if test="${list.noti ne 'Y'}">${list.total_cnt - (list.rnum-1)}</c:if>
				</c:if>
				
				<%-- 국내외여부 --%>
				<c:if test="${view.v_print eq 'domestic_yn'}">
					<c:if test="${list.domestic_yn eq 'Y'}">국내</c:if>
					<c:if test="${list.domestic_yn ne 'Y'}">해외</c:if>
				</c:if>
				
				<%-- 카테고리 --%>
				<c:if test="${view.v_print eq 'cate'}">${list.cate_nm }</c:if>
				
				<%-- 제목 --%>
				<c:if test="${view.v_print eq 'title'}">
				
					<%-- 제목링크 사용안함 --%>
					<c:if test="${empty list.title_link}">
					
						<%-- 디테일 사용 --%>
						<c:if test="${boardinfo.detail_yn eq 'Y'}">
						
							<%-- 비밀글 --%>
							<c:if test="${list.secret eq 'Y' }">
							
								<%-- 비밀글이면서 비회원글인경우 --%>
								<c:if test="${empty list.REG_USERNO }">
									<c:if test= "${empty s_user_no }"><a href="javascript:contentsView('${list.contents_id }')" >${contents_title}</a></c:if>
									<c:if test= "${not empty s_user_no }">${list.title }</c:if>
								</c:if>
								
								<%-- 비밀글이면서 회원글 인경우 --%>
								<c:if test="${not empty list.REG_USERNO }">
									<c:if test= "${s_user_no eq list.REG_USERNO }"><a href="javascript:contentsView('${list.contents_id }')" >${contents_title}</a></c:if>
									
									<%-- 비밀글은 관리자 페이지에서 확인가능 --%>
									<c:if test= "${s_user_no ne list.REG_USERNO }">${contents_title}</c:if>
								</c:if>
								
							</c:if>
							<%--// 비밀글 --%>
							
							<c:if test="${list.secret ne 'Y' }">
								<a href="javascript:contentsView('${list.contents_id }')" >${contents_title}</a>
							</c:if>
							
							<c:if test="${list.comment_cnt > 0 }">
								<%-- 댓글수 --%>
								<span class="re_count" id="comment_cnt">[<strong>${list.comment_cnt }</strong>]</span>
							</c:if>
							
							<%-- 비밀글 여부 아이콘 --%>
							<c:if test="${list.secret eq 'Y'}"><img src="/images/web/icon/icon_secret.png" alt="비밀글" /></c:if>
							
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reply_status') != -1}">
							
								<c:if test="${list.reply_yn eq 'Y'}">
									<%-- 답변 사용여부 아이콘 --%>
									<span id="reply_status"><img src="/images/web/icon/icon_reply_ok.png" alt="답변완료" /></span>
								</c:if>
								
								<c:if test="${list.reply_yn eq 'N'}">
									<%-- 답변 사용여부 아이콘 --%>									
									<span id="reply_status"><img src="/images/web/icon/standby.gif" alt="답변대기" /></span>
								</c:if>
								
							</c:if>
							
						</c:if>
						<%--// 디테일 사용 --%>
						
						<%-- 디테일 사용안함 --%>
						<c:if test="${boardinfo.detail_yn ne 'Y'}">
							${contents_title}
						</c:if>
						
					</c:if>
					
					<%-- 제목링크 사용 --%>
					<c:if test="${not empty list.title_link}">
						<a href="${list.title_link}" >${contents_title}</a>
					</c:if>
					
				</c:if>
				<%-- // 제목 --%>
				
				
				<%-- 첨부파일 --%>
				<c:if test="${view.v_print eq 'attach'}">
				
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
					
				</c:if>				
				<%-- // 첨부파일 --%>
				
				<%-- 작성자 --%>
				<c:if test="${view.v_print eq 'name'}">${list.name }</c:if>
				
				<%-- 핸드폰 --%>
				<c:if test="${view.v_print eq 'phone'}">
				
					<c:set var="phone1" value="" />
					<c:set var="phone2" value="" />
					<c:set var="phone3" value="" />
					<c:if test="${not empty list.handphone }">
						<c:set var="phone" value="${list.handphone }" />
						<c:set var="phone_split" value="${fn:split(phone, '-')}" />
						<c:forEach var="p1" items="${phone_split }" varStatus="s">
							<c:if test="${s.count == 1 }"><c:set var="phone1" value="${p1 }" /></c:if>
							<c:if test="${s.count == 3 }"><c:set var="phone3" value="${p1 }" /></c:if>
						</c:forEach>
						${phone1 }-****-${phone3 }
					</c:if>
				</c:if>
				
				<%-- 이메일 --%>
				<c:if test="${view.v_print eq 'email'}">${list.email }</c:if>
				
				<%-- 작성일 --%>
				<c:if test="${view.v_print eq 'reg_date'}">${list.reservation_date }</c:if>
				
				<%-- 아이피 --%>
				<c:if test="${view.v_print eq 'ip_addr'}">${list.ip_addr }</c:if>
				
				<%-- URL --%>
				<c:if test="${view.v_print eq 'url'}">
					${list.url_title }<br/>
					<a href="${list.url_link }" target="_blank">${list.url_link }</a>
				</c:if>
				
				<%-- 출처 --%>
				<c:if test="${view.v_print eq 'origin'}"><c:out value="${list.origin }"/></c:if>
				
				<%-- 국가 --%>
				<c:if test="${view.v_print eq 'country'}"><c:out value="${list.country }"/></c:if>
				
				<%-- 기타 --%>
				<c:if test="${view.v_print eq 'etc'}"><c:out value="${list.etc }"/></c:if>
				
				<%-- 날짜 --%>
				<c:if test="${view.v_print eq 'contents_date'}"><c:out value="${list.contents_date }"/></c:if>
				
				<%-- 내용 --%>
				<c:if test="${view.v_print eq 'contents'}">
					<c:choose>
						<c:when test="${fn:length(list.contents) > 200}">
							<c:out value="${fn:substring(list.contents,0,200)}"/><c:out value="..."/>
						</c:when>
						<c:otherwise>
							${list.contents }
						</c:otherwise>
					</c:choose>
				</c:if>
				<%-- //내용 --%>
				
				<%-- 썸네일 --%>
				<c:if test="${view.v_print eq 'thumb'}">
					<c:if test="${not empty list.image_file_nm}">
						<img src="/contents/board/${list.image_file_nm}" width="56" alt="썸네일" />
					</c:if>
					<c:if test="${empty list.image_file_nm}">
						<img src="/images/web/common/no_img.png" alt="썸네일" />
					</c:if>
				</c:if>
				<%-- //썸네일 --%>
				
				<%-- 만족도 --%>
				<c:if test="${view.v_print eq 'satisfy'}">${list.satisfy }</c:if>
				
				<%-- 조회수 --%>
				<c:if test="${view.v_print eq 'hits'}">${list.hits }</c:if>
				
				<%-- 추천수 --%>
				<c:if test="${view.v_print eq 'recommend'}">${list.recommend }</c:if>
				
				</td>
				</c:if>
				</c:forEach>
			</tr>
			</c:forEach>
			<c:if test="${empty boardList }">
			<tr>
				<td colspan="${totcnt }" class="first last">조회된 내용이 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
</div>
<!--// list_table_area -->

<!-- mobile_list -->
<div id="mobile_list" class="mobile_list only_mobile_list marginb30">

	<ul class="mobile_list">
	
		<c:forEach items="${boardList }" var="list">
		
			<li><!-- class="announce" -->
			
				<div class="mobile_list_info">
				
					<%-- 카테고리 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}">
						<dl class="view">
							<dt class="vdt"><span>카테고리</span></dt>
							<dd class="vdd">${list.cate_nm }</dd>
						</dl>
					</c:if>
					<%--// 카테고리 --%>
					
					<%-- 제목 --%>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">
					
						<%-- 답글 여부 --%>
						<strong class="title
							<c:if test="${list.relevel_seq > 0}"> reply</c:if>
						">
						
						<%-- 제목링크 사용안함 --%>
						<c:if test="${empty list.title_link}">
						
							<%-- 디테일 사용 --%>
							<c:if test="${boardinfo.detail_yn eq 'Y'}">
								<a href="javascript:contentsView('${list.contents_id }')" >${contents_title}</a>
							</c:if>
							
							<%-- 디테일 사용안함 --%>
							<c:if test="${boardinfo.detail_yn eq 'N'}">
								${contents_title}
							</c:if>
							
							<%-- 댓글 사용여부 확인 --%>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">
								<c:if test="${list.comment_cnt > 0}">
									[<strong class="color_pointr">${list.comment_cnt }</strong>]
								</c:if>
							</c:if>
							
							<%-- 비밀글 여부 아이콘 --%>
							<c:if test="${list.secret eq 'Y'}"><img src="/images/web/icon/icon_lock.png" alt="비밀글" class="marginl5" /></c:if>
							
						</c:if>
						
						<%-- 제목링크 사용 --%>
						<c:if test="${not empty list.title_link}">
							<a href="javascript:contentsView('${list.title_link }')" >${contents_title}</a>
						</c:if>
						
						</strong>
					</c:if>					
					<%--// 제목 --%>
					
					<dl class="view">
					
						<%-- 작성자 --%>
						<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}">
							<dt class="vdt"><span>작성자</span></dt>
							<dd class="vdd">${list.name }</dd>
						</c:if>
						
						<%-- 작성일 --%>
						<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}">
							<dt class="vdt"><span>작성일</span></dt>
							<dd class="vdd">${list.reservation_date }</dd>
						</c:if>
						
					</dl>
					
					<%-- 첨부파일 --%>
					<c:if test="${view.v_print eq 'attach'}">
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
<!-- // moblie_list -->

<!-- button_area -->
<div class="button_area">

	<div class="float_right">
	
		<%-- 회원이면서 글쓰기 권한이 있는경우 --%>
		<c:if test="${not empty s_user_no }">
			<c:if test="${fn:indexOf(boardinfo.grant_write, 'M') != -1}">
				<button class="btn save" onclick="contentsWrite()" title="등록"><span>등록</span></button>
			</c:if>
		</c:if>
		
		<%-- 비회원이면서 글쓰기 권한이 있는경우 --%>
		<c:if test="${empty s_user_no }">
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