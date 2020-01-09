<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page import="kr.or.wabis.framework.util.StringUtil"%>
<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, user-scalable=yes, target-densitydpi=medium-dpi" />
	<title><%=(String)ProjectConfigUtil.getProperty("project.site.name") %></title>
		
	<link rel="stylesheet" type="text/css" href="/css/web/about.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/calendar.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/default.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directory.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/layout.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/main.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/nanumgothic.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/service.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/sub.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/table.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/common.css" />
	
	<script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
    <script type="text/javascript" src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>   
	
    <script type="text/javascript" src="/assets/bootstrap/js/bootstrap.js"></script>
	
    <script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>
	
    <script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>
    <script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>
     
	<script type="text/javascript" src="/assets/tab/jquery-latest.js"></script>
	<script type="text/javascript" src="/assets/tab/tab.js"></script>	
			
	<script type="text/javascript" src="/assets/jquery/jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.bpopup.min.js"></script>
	
	<!--[if lt IE 9]>
		<script type="text/javascript" src="/assets/html5.js"></script>
	<![endif]-->
	
</head> 

<body>
	<tiles:insertAttribute name="body" />
</body>

</html>