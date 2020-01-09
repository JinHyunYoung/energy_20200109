<%--
  Created by IntelliJ IDEA.
  User: my
  Date: 2017-10-23
  Time: 오전 5:42
  To change this template use File | Settings | File Templates.
--%>
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
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
    <meta name="HandheldFriendly" content="true">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="imagetoolbar" content="no">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    <title>한국에너지재단</title>
    <link rel="stylesheet" type="text/css" href="/css/font.css" />
    <link rel="stylesheet" type="text/css" href="/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="/css/table.css" />
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/css/main_slider.css" />
    <link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

    <script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/main.js"></script>
    <script type="text/javascript" src="/js/Banner_slider.js"></script>
    <script type="text/javascript" src="/js/jquery.sudoSlider.js"></script>
    <script type="text/javascript" src="/js/main_slider.js"></script>



    <%--<script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>--%>
    <%--<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>--%>
    <%--<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>--%>
    <%--<script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>--%>
    <%--<script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>--%>




    <!--[if lte IE 9]><script src="/js/html5.js"></script><![endif]-->
    <script type="text/javascript">
        // ready
        $(document).ready(function(){

            // 메뉴 조회
            loadMenu();

            <c:if test="${!empty web_g_submenu_id}">

            // 네이게이션의 서브 메뉴 조회
            loadNaviMenu();
            </c:if>

            // 배너 조회
            loadBanner(1);

            // 게시판 조회
            loadBoard(27 , 3, null);    // 공지사항
            loadBoard(28 , 3, null);    // 입찰정보
            loadBoard(29, 3, null);     // 보도자료
            //loadBoard(31, 3, null);     // 언론
            loadBoard(30, 3, null);     // 갤러리
            
            // 팝업공지 조회
            loadNotiPop();
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
                    createNaviSubmenu(data.naviSubmenuList);
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
        
		function loadNotiPop(){
			$.ajax({
				type: "POST",
				url: "/web/popnoti/popnotiList.do",
				dataType: 'json',
				success:function(data){
					makeNotiPop(data.list);
				}
			});
		}
		
		function makeNotiPop(data){
			var html = "";
			var cnt = 0;
			if(data != ""){
				$.each(data,function(key,obj){
					if (getCookie(obj.noti_id) != "done"){
						html = "";
						html += '<div id="layerPop_'+cnt+'" style="position:absolute; top: '+obj.top+'px; left: '+obj.left+'px; width: '+obj.width+'px; height: '+obj.height+'px;overflow:auth;z-index:1100;" >';
						html += '	<div id="pop_header">';
						html += '		<header>';
						html += '			<h1 class="pop_title">'+obj.title+'</h1>';
						html += '			<a href="#" class="pop_close" title="페이지 닫기" onClick="notiClose('+cnt+')">';
						html += '				<span>닫기</span>';
						html += '			</a>';
						html += '		</header>';
						html += '	</div>';
						html += '	<div id="pop_container" style="background-color: ivory">';
						html += '	<article>';
						if(obj.file_id != undefined){
							html += '		<div class="title_area">';
							html += '			<p> 첨부파일 : <a href="/commonfile/fileidDownLoad.do?file_id='+obj.file_id+'"  target="_blank" title="다운받기">'+obj.file_nm+'</a></p>';
							html += '		</div>';
						}
						html += '		<div class="pop_content_area">';
						html += '			<div id="pop_content" style="height: '+obj.height+'px;overflow:auto;">'+obj.contents+'</div>';
						html += '		</div>';
						html += '		<div class="table_search_area">';
						html += '			<div class="float_right">';
						html += '				<input type="checkbox" id="chk" name="chk" value="Y" onClick="weekNotShow(\''+obj.noti_id+'\',\''+cnt+'\')"><span>일주일 동안 보지 않기</span>';
						html += '			</div>';
						html += '		</div>';
						html += '	</article>';
						html += '	</div>';
						html += '</div>';
						
						$("body").append(html);

						cnt++;
					}
				});
			}
		}
		
		function weekNotShow(id, num){
			setCookie(id , "done" , 7);
			notiClose(num);
		}
		
		function notiClose(num){
			$('#layerPop_'+num).hide();
		}
		
		function moveUrl(target, url){
			if(target == "1") document.location = url
			else window.open(url);
		}
    </script>
</head>
<body>

<div id="wrap">

    <!-- skip_nav -->
    <div class="skip_nav" id="skip_to_container">
        <a href="#container" title="본문 바로가기" target="_self">본문 바로가기</a>
    </div>
    <!-- //skip -->



    <!-- nav_gnb -->
    <div id="nav">
        <h1>Nanigation</h1>
        <nav>
            <div class="gnb">
                <!-- 레이어 사이트맵 -->
                <div class="layer_sitemap"></div>

                <!-- //레이어 사이트맵 -->
                <div class="button_energy">
                    <a href="http://www.kew.or.kr" title="에너지효율개선사업 관리시스템" target="_blank">에너지효율개선사업 관리시스템</a>
                </div>

                <div class="ab_bt "><img src="/images/icon/ham_bt.png" class="sitemap_bt" alt="햄버거 메뉴"></div>
                <ul>
                    <li>
                        <h2>로고</h2>
                        <a href="/" title="한국에너지재단 로고" target="_self">
                            <img src="/images/common/logo.png" alt="한국에너지재단 로고">
                        </a>
                        <span class="mobile_menu"><img src="/images/icon/ham_bt.png" alt="햄버거 메뉴"></span>
                    </li>
                    <li class="gnb_menu">
                        <h2>1Depth 메뉴</h2>
                        <ul id="TopMenu">

                        </ul>
                    </li>
                </ul>
            </div>
            <div class="snb_hader_bg"></div>
        </nav>
    </div>
    <!-- //nav_gnb -->

    <tiles:insertAttribute name="content"/>
</div>
<script type="text/javascript" src="/js/web_main.js"></script>
<script type="text/javascript" src="/js/cms.js"></script>
</body>
</html>