<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">
function weekNotShow(){
	setCookie( "Popnoti_Preview", "done" , 7); 
	window.close();
}
</script>

<div id="wrap">
	
	<!-- popup_content -->
	
	<!-- header -->
	<div id="pop_header">
		<header>
			<h1 class="pop_title">${popnoti.title}</h1>
			<a href="javascript:closePopup()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
	</div>
	<!-- //header -->
		
	<!-- container -->
	<div id="pop_container">
		<article>
			<div class="pop_content_area">
			
				<div id="pop_content">
	
					<!-- text -->
					<div class="text_area marginb20">
							${popnoti.contents}
					</div>
					<!--// text -->
					
					<c:if test="${param.mode == 'E' && !empty popnoti.file_id}">
					첨부파일 : 
					<div class="file_area">
						<ul class="file_list">
							<li>
								<a href="/commonfile/fileidDownLoad.do?file_id=${popnoti.file_id}" >${popnoti.file_nm}</a>
							</li>
						</ul>
					</div>
					</c:if>
					
					<div class="table_search_area">
						 <div class="float_right">
							<input type="checkbox" id="chk" name="chk" value="Y" onClick="weekNotShow()"><span>일주일 동안 보지 않기
						</div>
					</div>
					
				</div>
				
			</div>
		</article>		
	</div>
	<!-- //container -->
	
</div>