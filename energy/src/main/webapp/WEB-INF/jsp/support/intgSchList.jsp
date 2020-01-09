<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
</script>

<div class="search_area">
	<div class="search_form">
		<div class="input_search_area">
			<input id="keyword_txt" type="text" name="keyword" value="${param.keyword}">
			<label class="hidden" for="keyword_txt">검색어</label>
			<button title="검색" class="btn search" onclick="search();">
				<span>검색</span>
			</button>
		</div>
		<div class="keyword_list_area">
			<strong>인기검색어</strong>
			
			<ul>
			<c:forEach items="${top5}" var="term">
				<li>
					<a href="#" title="${term.sch_term} 검색">${term.sch_term}</a>
				</li>
			</c:forEach>		
			
			</ul>
		</div>
	</div>	
	<div class="search_result_area">
		<div class="search_result_category">
			<div class="category_title float_left">
				<strong>게시판</strong>
				(<span>${totalcnt}</span>건)
			</div>
			<div class="float_right">
				<select class="in_wp100" id="select_num">
					<option value="5" <c:if test="${pageSize == 5}">selected="selected"</c:if>>5개씩 보기</option>
					<option value="10" <c:if test="${pageSize == 10}">selected="selected"</c:if>>10개씩 보기</option>
					<option value="15" <c:if test="${pageSize == 15}">selected="selected"</c:if>>15개씩 보기</option>
					<option value="20" <c:if test="${pageSize == 20}">selected="selected"</c:if>>20개씩 보기</option>
					<option value="30" <c:if test="${pageSize == 30}">selected="selected"</c:if>>30개씩 보기</option>
					<option value="50" <c:if test="${pageSize == 50}">selected="selected"</c:if>>50개씩 보기</option>
					<option value="100" <c:if test="${pageSize == 100}">selected="selected"</c:if>>100개씩 보기</option>
				</select>
				<label class="hidden" for="select_num">검색결과 개수 선택</label>
			</div>
		</div>
		<ul class="search_result_detail">
			<c:forEach items="${intgSchList}" var="intgSch">
			<li class="search_list">
				<span class="board_name">홈 > ${fn:replace( fn:substring( intgSch.menu_navi , 0 , fn:length( intgSch.menu_navi ) -1 ) , '#' , ' > ' )}</span>
				<a title="${intgSch.board_title} 페이지로 이동" href="#" onclick="goPage( '${intgSch.menu_id}', 'contents_id=${intgSch.contents_id}', '/web/board/boardContentsView.do');return false;">
					<strong>${intgSch.title}</strong>
				</a>
				<div class="search_txt">
					<c:out value="${intgSch.contents}" escapeXml="false"></c:out>
					
				</div>
			</li>
			</c:forEach>
		</ul>
           <!-- paging_area -->
           ${intgSchPagging}
           <!--// paging_area -->
	</div>
</div>

<script type="text/javascript">

$( '#select_num' ).bind( 'change' , function(){
	changePageSize();
});

$( '.keyword_list_area a' ).bind( 'click' , function(){
	
	$( '#keyword_txt' ).val( $( this ).text() );
	search();
	
});

</script>
