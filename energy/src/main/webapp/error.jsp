<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%> 
<%
     String url = request.getRequestURL().toString();
     String frontYn = "Y";
     if(url.indexOf("admin") > -1) frontYn = "N";
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title><%=(String)ProjectConfigUtil.getProperty("project.site.name") %></title>
		
		<link rel="stylesheet" type="text/css" href="/css/web/error.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/nanumgothic.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/default.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/common.css" />
		
	</head>

	<body>
	<div id="wrap">
		<!-- error_area -->
		<div class="error_area">
			<!-- content start -->
			<div class="error_box">
				<h1 class="logo"><span><%=(String)ProjectConfigUtil.getProperty("project.site.name") %></span></h1>
				<strong class="title">잘못된 주소이거나 일시적으로 사용할 수 없습니다.</strong>
				<p class="txt">
					찾으시는 페이지의 주소가 잘못되었거나 현재 시스템의 문제상의 문제로 인해 사용하실 수 없는 상태입니다.<br />
					잠시 후 접속하여 주시거나 다시 한번 확인하여 주시기 바랍니다.
				</p>
				<% if(frontYn.equals("Y")){ %>
				<div class="button_area">
					<a href="/web/user/main.do" class="btn save" title="메인 바로가기">
						<span>메인 바로가기</span>
					</a>
					<a href="javascript:history.back(-1)" class="btn cancel" title="이전으로">
						<span>이전으로</span>
					</a>
				</div>
				<% }else{ %>
				<div class="button_area">
					<a href="/login.do" class="btn save" title="관리자 로그인페이지 바로가기">
						<span>관리자 로그인페이지 바로가기</span>
					</a>
					<a href="javascript:history.back(-1)" class="btn cancel" title="이전으로">
						<span>이전으로</span>
					</a>
				</div>				
				<% } %>
			</div>
			<!--// content end -->
		</div>
		<!--// error_area -->
		<div class="error_footer_area">
			<strong class="title"><%=(String)ProjectConfigUtil.getProperty("project.site.name") %></strong>
			<div class="error_address">
				<address>
					<ul>
						<li><%=(String)ProjectConfigUtil.getProperty("project.site.address") %> | <%=(String)ProjectConfigUtil.getProperty("project.site.contact") %></li>
					</ul>
				</address>
			</div>
			<p class="error_copyright">© <%=(String)ProjectConfigUtil.getProperty("project.site.copyright") %></p>
		</div>
	</div>
	</body>
</html>