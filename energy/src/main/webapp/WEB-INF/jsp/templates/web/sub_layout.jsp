<%--
  Created by IntelliJ IDEA.
  User: my
  Date: 2017-10-23
  Time: 오전 5:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
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
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
    <meta name="HandheldFriendly" content="true">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="imagetoolbar" content="no">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    <title><%=(String)ProjectConfigUtil.getProperty("project.site.name")%></title>
    
    <link rel="stylesheet" type="text/css" href="/assets/font-awesome/css/font-awesome.min.css"/>
	<link rel="stylesheet" type="text/css" href="/assets/bootstrap/css/sticky-footer.css" />
	<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" href="/assets/jqgrid/css/ui.jqgrid-bootstarp.css" />
	<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
		
    <link rel="stylesheet" type="text/css" href="/css/font.css" />
    <link rel="stylesheet" type="text/css" href="/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="/css/table.css" />
    <link rel="stylesheet" type="text/css" href="/css/sub.css" />
    <link rel="stylesheet" type="text/css" href="/css/web/table.css" />
    <link rel="stylesheet" type="text/css" href="/css/modal.css" />
    
    <script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
	<script type="text/javascript" src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>  
	    
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/sub.js"></script>
    <script type="text/javascript" src="/js/Banner_slider.js"></script>
    <script type="text/javascript" src="/js/jquery.sudoSlider.js"></script>

    <script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
    <script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>
    <script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
    <script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>
    <script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>

	<script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>
	<script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>	    

    <!--[if lte IE 9]><script src="/js/html5.js"></script><![endif]-->
    <script type="text/javascript">
        // ready
        var web_g_up_menu_id = '${web_g_up_menu_id}';
        var web_g_submenu_id ='${web_g_submenu_id}';
        var web_g_topmenu_id = '${web_g_topmenu_id}';
        $(document).ready(function(){

            // 메뉴 조회
            loadMenu();

            <c:if test="${!empty web_g_submenu_id}">

            // 네이게이션의 서브 메뉴 조회
//            loadNaviMenu();
            // 네이게이션의 서브(3level) 메뉴 조회
            loadNaviSubMenu();
            </c:if>
        });
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
                    createLeftSubmenu(data.naviSubmenuList);
                }
            });
        }
        //3레벨 포함 서브 메뉴 조회
        function loadNaviSubMenu(){

            $.ajax ({

                type: "POST",
                url: "/web/user/homepageMenuList.do",
                dataType: 'json',
                async:false,
                success:function(data){
                	debugger;
                    createSubMenu(data.topMenuList,'${web_g_up_menu_id}');
                    // createMobileMenu(data.topMenuList);
                    $("ul.sub3level > li.active" ).closest("ul").toggle( 100 );

                }

            });
        }
        //메뉴 조회
        function loadMenu(){

            $.ajax ({

                type: "POST",
                url: "/web/user/homepageMenuList.do",
                dataType: 'json',
                async:false,
                success:function(data){
                    createTopMenu(data.topMenuList);
                    // createMobileMenu(data.topMenuList);
                }

            });
        }
        $(document).ready(function(){
            $( ".bgbea214" ).click(function() {
                goSubMenu('undefined');
            });
        });

    </script>
</head>
<body>
<%--<input type="hidden" name="web_g_submenu_id" id="web_g_submenu_id" value="${web_g_submenu_id}">--%>
<div id="wrap">
    <tiles:insertAttribute name="header"/>
    <!-- container_본문 전체 영역 표시 -->
    <div id="container">
        <article>

            <!-- container_area -->
            <div class="container_area">

                <!-- left menu layout -->
                <div class="lnb_area">
                    <h2>좌측메뉴</h2>
                    <!-- 왼쪽 매뉴 -->
                    <div id="lnb">
                        <div class="lnb_title">${web_g_topmenu_nm}</div>

                        <ul class="lnb_list">
                            <%--<li class="active"><a href="#link" title="인사말" target="_self">인사말</a></li>--%>
                            <%--<li><a href="#link" title="설립목적/비전" target="_self">설립목적/비전</a></li>--%>
                            <%--<li><a href="#link" title="연혁" target="_self">연혁</a></li>--%>
                            <%--<li><a href="#link" title="조직/연락처" target="_self">조직/연락처</a></li>--%>
                            <%--<li><a href="#link" title="CI" target="_self">CI</a></li>--%>
                            <%--<li><a href="#link" title="오시는 길" target="_self">오시는 길</a></li>--%>
                            <%--<li><a href="#link" title="윤리경영" target="_self">윤리경영</a></li>--%>
                            <%--<li><a href="#link" title="재단 출연기관" target="_self">재단 출연기관</a></li>--%>

                        </ul>
                    </div>
                    <!--// 왼쪽 매뉴 -->
                </div>
                <!--// left menu layout -->

                <!-- content_area 본문 전체 묶음 -->
                <div class="content_area">
                    <!-- content -->
                    <div id="content">
                        <div class="sub_title">
                            ${web_g_submenu_nm}
                            <!-- location_area -->
                            <div class="location_area">
                                <c:out value="${g:toWEB_BOX(web_g_menu_navi)}" escapeXml="false"/>
                            </div>
                        </div>

                        <!--// contents_area -->
                        <div class="contents_area">
                            <tiles:insertAttribute name="content"/>
                        </div>
                        <!--// contents_area -->
                    </div>
                    <!--// content -->
                </div>
                <!--// content_area -->
            </div>
            <!--// container_area -->
        </article>
    </div>
    <!--// container -->

    <!-- footer -->
    <tiles:insertAttribute name="footer"/>
    <!-- //footer -->
</div>
<script type="text/javascript" src="/js/web_main.js"></script>
<script type="text/javascript" src="/js/cms.js"></script>
</body>
</html>