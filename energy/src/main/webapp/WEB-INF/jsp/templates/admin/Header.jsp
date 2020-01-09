<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ page import="kr.or.wabis.framework.util.DateUtil"%>
<%@ page import="kr.or.wabis.framework.util.StringUtil"%>
<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%> 

    <%
		String authId  = StringUtil.nvl(session.getAttribute("s_auth_id"));
		String auth  = StringUtil.nvl(session.getAttribute("s_auth"));
		String authNm  = StringUtil.nvl(session.getAttribute("s_authNm"));
		String[] authArr = StringUtil.split(auth, ",");
		String[] authNmArr = StringUtil.split(authNm, ",");
		String user_name  = StringUtil.nvl(session.getAttribute("s_user_name"));		
    %>
    
	<div id="wrap">
	
		<!-- skip_nav --> 
		<div id="skip_nav">  
			<a href="#nav">메인메뉴 바로가기</a>
			<a href="#content">본문내용 바로가기</a>
		</div>
		<!-- //skip --> 
		
		<!-- header -->
		<div id="header">
			<header>
			
				<!-- topheader_area -->
				<div class="topheader_area">
				
					<div class="logo_area">
						<%--<h1 class="home_logo"><img src="/contents/logo/${Logo.backsub_top_file_nm}" alt="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>" onClick="goMain()" style="cursor:pointer " /></h1>--%>
                            <h1 class="home_logo"><img src="/images/admin/main/logo.png" alt="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>" onClick="goMain()" style="cursor:pointer " /></h1>
						<span class="logotitle">${Logo.backsub_title}</span>
					</div>
					
					<!-- hsection -->
					<div class="hsection_area">
						<span style="line-height:24px"><%=user_name%></span>
		                <% if(authArr.length > 1){ %>
							<select id="AuthSelect" class="center_select" title="권한 구분" onChange="changeAuth()">
							     <%
							           for(int i =0; i < authArr.length;i++){
							     %>
								<option value="<%=authArr[i]%>" <%=(authArr[i].equals(authId)?"selected":"") %>><%=authNmArr[i]%></option>
								<% } %>
							</select>
						<% } %>
						
						<a href="/j_spring_security_logout" class="btn logout" title="로그아웃 하기">
							<span>로그아웃</span>
						</a>
						
						<!--<a href="/web/user/main.do" class="btn homepage" title="홈페이지로 페이지 이동">
							<span>홈페이지 바로가기</span>
						</a>-->
					</div>
					<!--// hsection -->
					
				</div>
				<!--// topheader_area -->
				
				<!-- gnb_menu -->
				<div id="nav">
				<nav>
					<ul id="TopMenu" class="menu">
		
					</ul>
				</nav>
				</div>
				<!--// gnb_menu -->
				
			</header>
		
		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="container">
			<article>
			
				<!-- left_area -->
				<div class="left_area" id="MenuArea" style="display:<c:if test="${admin_g_topmenu_id == '' }">none</c:if>">
				
					<!-- left_info_area -->
					<div class="left_info_area">
						<ul class="left_info">
							<li>
								<strong class="name">${s_user_name}</strong>님 반갑습니다.
							</li>
							<li><%=DateUtil.currentDateStr() %></li>
						</ul>
					</div>
					<!--// left_info_area -->
					
					<!-- lnb_area -->
					<div class="lnb_area">
						<h2 id="TopMenuNm" class="title">${admin_g_topmenu_nm}</h2>
						<ul id="SubMenu" class="lnb">
									
						 </ul>
					</div>
					<!--// lnb_area -->
					
				</div>
				<!--// left_area -->
				
				<!-- lnb_split -->
				<div id="lnb_split"  style="display:<c:if test="${admin_g_topmenu_id == '' }">none</c:if>">
				</div>
				<!--// lnb_split -->
				
				<!-- content_area -->
				<div class="content_area">
				
					<!-- location -->
					<div class="location">
						<ul>
							<c:out value="${g:toWEB_BOX(admin_g_menu_navi)}" escapeXml="false"/>
						</ul>
					</div>
					<!--//  location -->			