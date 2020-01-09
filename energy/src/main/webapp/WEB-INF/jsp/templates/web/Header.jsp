<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.or.wabis.framework.util.StringUtil"%>
<%@page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>

<!-- page-container -->
 <div id="page-container" class="">
    
		<!-- header -->
		<div id="header">
		
			<header>
				<!-- header_area -->
				<div class="header_area">
					<div class="hsection">
						<a href="/web/user/main.do" title="홈페이지 이동" class="home_logo" onfocus="menuBlur()">
							<h1 class="home_logo"><img src="/contents/logo/${Logo.front_top_file_nm}" alt="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>"/></h1>
						</a>
						<div class="main_search_area">
							<label for="keyword_intgsch" class="hidden">검색어 입력</label>
							<input type="text" name="keyword_intgsch" id="keyword_intgsch" class="msearch_input" />
							<button class="btn_main_search" title="검색" onclick="goIntgSch();return false;">
								<span>검색</span>
							</button>
						</div>
						<div class="header_list">
							<!-- //search_form -->
							<ul>
								<li>
									<a href="javascript:goPage('b330d2879a2743c7aba0be3e481984c9', '', '')" title="뉴스레터" alt="뉴스레터" onfocus="menuBlur()">
										<span>뉴스레터</span>
									</a>
								</li>
								<li class="on">
									<a href="javascript:goPage('0c19a4bd483340e4a0da1b98e0afd6a2', '', '')" title="사이트맵" alt="사이트맵" onfocus="menuBlur()">
										<span>사이트맵</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
					
					<!-- mobile_gnb_area -->
					<div id="gnb_mobile">
						<a href="javascript:void(0)" title="전체매뉴 보기" class="gnb_mobile_menu" onclick="layer_popup('open')">
							<img src="/images/web/mobile/btn_mgnb.png" alt="전체메뉴 보기" />
						</a>
					</div>
					<!-- //mobile_gnb_area -->
					
					<!-- nav -->
					<div id="nav">
						<div class="gnb">
						<nav class="on">
							<ul id="TopMenu" class="menu7 directory_menu">					
							</ul>
						</nav>
						</div>
					</div>
					<!--// nav -->
					
				</div>
				<!--// header_area -->			
				
			</header>
		</div>
		<!--// header -->
		
		<hr class="hidden" />
		
		<!-- container -->
		<div id="container" style="">
		
		<article>
		
			<h3 class="hidden">메인 컨텐츠 화면</h3>
			
			<!-- location_area -->
			<div class="location_area">
				<ul class="location">					
					<c:out value="${g:toWEB_BOX(web_g_menu_navi)}" escapeXml="false"/>
				</ul>
			</div>
			<!--// location_area  -->
			
			
			<div class="content_area">
				<div id="content" class="sub">
					<!-- menu title area -->
					<div class="menu_title_area">
						<h4 class="menu_title">${web_g_submenu_nm}</h4>
						<p>${web_g_submenu_desc}</p>
					</div>
					<!--// menu title area -->
