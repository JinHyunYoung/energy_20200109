<%--
  Created by IntelliJ IDEA.
  User: my
  Date: 2017-10-23
  Time: 오전 5:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@page import="kr.or.wabis.framework.util.StringUtil"%>
<%@page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>
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
            <div class="ab_bt "><img src="/images/icon/ham_bt.png" class="sitemap_bt2" alt="햄버거 메뉴"></div>
            <ul>
                <li>
                    <h2>로고</h2>
                    <a href="/" title="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>" target="_self">
                        <img src="/images/common/logo.png" alt="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>"/>
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

<!-- 서브 비쥬얼 -->
<div class="sub_visual_area"></div>
<!-- //서브 비쥬얼 -->
