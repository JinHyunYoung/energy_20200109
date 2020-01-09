<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page import="kr.or.wabis.framework.util.StringUtil"%>
<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>
<%
	response.setHeader("Cache-Control","no-store");   
	response.setHeader("Pragma","no-cache");   
	response.setDateHeader("Expires",0);   
	 

%>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="expires" content="-1"> 
	<meta http-equiv="pragma" content="no-cache"> 
	<meta http-equiv="cache-control" content="no-cache"> 
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, user-scalable=yes, target-densitydpi=medium-dpi" />
	<title><%=(String)ProjectConfigUtil.getProperty("project.site.name")%></title>
	
	<link rel="stylesheet" type="text/css" href="/css/web/about.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/calendar.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/default.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directory.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directorySub.css" />
	
	<link rel="stylesheet" type="text/css" href="/css/web/layout.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/main.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/nanumgothic.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/service.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/sub.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/table.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/common.css" />	
	<link rel="stylesheet" type="text/css" href="/css/modal.css" />
	
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
     
	<script type="text/javascript" src="/assets/tab/tab.js"></script>	
			
	<script type="text/javascript" src="/assets/jquery/jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.bpopup.min.js"></script>
	
	
	<script type="text/javascript" src="/assets/jquery/jquery.cookie.js"></script>
	
	<!--[if lt IE 9]>
		<script type="text/javascript" src="/assets/html5.js"></script>
	<![endif]-->

	<script type="text/javascript">
	
        // ready
		$(document).ready(function(){
		                
		    // 메뉴 조회
			loadMenu();
		    
			<c:if test="${!empty web_g_submenu_id}"> 
			
				// 네이게이션의 서브 메뉴 조회
				loadNaviMenu();
	     	</c:if>

			
			// 유관기관 조회
			loadOrgan();
			
			//javascript:goPage('af227e1e89a64e88a1dba71c218f825d', '', '')
			
		});
        
        function openIntgSch(){
        	
        	var intgSchTop5tUrl = "<c:url value='/web/intgSch/intgSchTop5.do'/>";
        	$( '#keyword_intgsch_top5 ul' ).html( '' );
        	
        	 $.ajax
 		    ({
 		    	type: "POST",
 		       url: intgSchTop5tUrl,
 		       dataType: 'json',
 		    	  success:function(data){
 		    		var _html = '';  
 		    		if( data.top5 != null && data.top5.length > 0 ){
 		    			for( var i = 0 ; i < data.top5.length ; i++ ){
 		    				_html += '<li><a href="#" title="' + data.top5[i].sch_term + ' 검색">' + data.top5[i].sch_term + '</a></li>';
 		    			} 		    			
 		    			_html += '<li class="last">...</li>';
 		    		}
 		    		$( '#keyword_intgsch_top5 ul' ).html( _html );
 		    		setTop5IntgSch();
 		    		
 		          }
 		    });
        	 
        	$( '.pop_search_wrap' ).show();
        }
        
        function closeIntgSch(){
        	$( '.pop_search_wrap' ).hide();
        }
        
        function setTop5IntgSch(){
        	$( '#keyword_intgsch_top5 ul a' ).bind( 'click' , function(){        		
        		$( '#keyword_intgsch' ).val( $( this ).text() );
        		goPage('af227e1e89a64e88a1dba71c218f825d', 'keyword_intgsch=' + encodeURIComponent( $( this ).text() ) , '');
        	});
        }
        
        function goIntgSch(){
        	if( $( '#keyword_intgsch' ).val() == '' ){
        		alert( '검색어를 입력하십시오.' );
        		$( '#keyword_intgsch' ).focus();
        		return false;        		
        	}
        	
        	goPage('af227e1e89a64e88a1dba71c218f825d', 'keyword_intgsch=' + encodeURIComponent( $( '#keyword_intgsch' ).val() ) , '');
        	
        }
		
		// 네비게이션 서브 메뉴 조회
		function loadNaviMenu(){
		    $.ajax
		    ({
		    	type: "POST",
		       url: "/web/user/naviSubmenuList.do",
		       dataType: 'json',
		       data: {
		       	up_menu_id : "${web_g_up_menu_id}"
		    		},
		    	  success:function(data){
		    		createNaviSubmenu(data.naviSubmenuList);
		          }
		    });
		}
		
	</script>
</head> 

<body>

	
</body>
  
</html>