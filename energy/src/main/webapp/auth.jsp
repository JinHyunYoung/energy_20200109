<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%> 
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
				<strong class="title">관리자 페이지로 접근하실 수 있는 권한이 없습니다.</strong>

				<div class="button_area">
					<a href="/web/user/main.do" class="btn save" title="메인 바로가기">
						<span>메인 바로가기</span>
					</a>
					<a href="javascript:history.back(-1)" class="btn cancel" title="이전으로">
						<span>이전으로</span>
					</a>
				</div>
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