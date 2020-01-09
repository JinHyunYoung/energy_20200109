<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<script type="text/javascript">
</script>

<!-- all_search_layer_pop -->
<div class="pop_search_wrap">

	<!-- header -->
	<div id="pop_search_header">
	<header>
		<h1 class="pop_search_title"><span>물산업종합정보시스템</span> 통합검색</h1>
		<a href="#" class="pop_search_close" title="페이지 닫기">
			<span>닫기</span>
		</a>
	</header>
	</div>
	<!-- //header -->
	
	<!-- search_form -->
	<div class="search_form">
	
		<div class="input_search_area">
			<input type="text" name="" id="keyword_txt" class="" />
			<label for="keyword_txt" class="hidden">검색어</label>
			<button class="btn search" title="검색">
				<span>검색</span>
			</button>
		</div>
		
		<div class="keyword_list_area">
			<strong>인기검색어</strong>
			<ul>
				<li>
					<a href="" title="생수 검색">생수</a>
				</li>
				<li>
					<a href="" title="벨브 검색">벨브</a>
				</li>
				<li>
					<a href="" title="상수도 검색">상수도</a>
				</li>
				<li>
					<a href="" title="하수도 검색">하수도</a>
				</li>
				<li class="last">
					...
				</li>
			</ul>
		</div>
		
	</div>
	<!-- //search_form -->
	
</div>
<!--// all_search_layer_pop -->