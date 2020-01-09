<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<div id="wrap">
		
	<!-- popup_content -->
	
	<!-- header -->
	<div id="pop_header">
		<header>
			<h1 class="pop_title">${intropage.title}</h1>
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
							${intropage.contents}
					</div>
					<!--// text -->
				
				</div>
			</div>
		</article>		
	</div>
	<!-- //container -->
    