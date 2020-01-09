<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@page import="kr.or.wabis.framework.util.StringUtil"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko">
<!--<![endif]-->
	
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" type="text/css" href="/assets/font-awesome/css/font-awesome.min.css" />
		<link rel="stylesheet" type="text/css" href="/assets/bootstrap/css/sticky-footer.css" />
		<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid-bootstarp.css" />
		<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
		
		<link rel="stylesheet" type="text/css" href="/css/admin/calendar.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/default.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/style.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/table.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/common.css" />
		<link rel="stylesheet" type="text/css" href="/css/modal.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />
		
		<script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
		<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
		
		<script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>	
		
		<script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>		
			
		<script type="text/javascript" src="/js/cms.js"></script>
	
	</head>
	<body>
		<tiles:insertAttribute name="body" />
	</body>
</html>