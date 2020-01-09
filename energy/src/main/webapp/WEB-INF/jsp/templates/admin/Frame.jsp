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
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title><%=(String)ProjectConfigUtil.getProperty("project.site.name") %></title>
		
		<link rel="stylesheet" type="text/css" href="/assets/font-awesome/css/font-awesome.min.css"/>
		<link rel="stylesheet" type="text/css" href="/assets/bootstrap/css/sticky-footer.css" />
		<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid-bootstarp.css" />
		<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
		
		<link rel="stylesheet" type="text/css" href="/css/admin/calendar.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/default.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/style.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/table.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/layout.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/sub.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/common.css" />
		<link rel="stylesheet" type="text/css" href="/css/modal.css" />
		<link rel="stylesheet" type="text/css" href="/css/admin/directorySub.css" />
		

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
			
		
		<!--[if lt IE 9]>
			<script type="text/javascript" src="/assets/html5.js"></script>
		<![endif]-->		
		
		<script type="text/javascript">
			var admin_g_up_menu_id = '${admin_g_up_menu_id}';
			var admin_g_submenu_id ='${admin_g_submenu_id}';
			var admin_g_topmenu_id = '${admin_g_topmenu_id}';
			$(document).ready(function(){
			    
			    // 메뉴를 생성해준다.			    
		    	loadMenu('${s_auth_id}', '${admin_g_topmenu_id}', '${admin_g_submenu_id}');				
				
			});			
			
		</script>
	</head>

	<body>
		<tiles:insertAttribute name="header"/>
		<tiles:insertAttribute name="body"/>
		<tiles:insertAttribute name="footer"/>
	</body>
	
	<script type="text/javascript" src="/js/admin_main.js"></script>
	<script type="text/javascript" src="/js/cms.js"></script>
	
	
	
</html>