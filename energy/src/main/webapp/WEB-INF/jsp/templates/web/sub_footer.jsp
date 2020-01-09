<%--
  Created by IntelliJ IDEA.
  User: my
  Date: 2017-10-23
  Time: 오전 5:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>

<div id="footer">
    <h1>Footer</h1>
    <footer>
        <ul class="area_footer_01">
            <li>
                <h2>하단 로고</h2>
                <a href="/" title="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>" target="_self">
                    <img src="/images/common/logo.png" alt="<%=(String)ProjectConfigUtil.getProperty("project.site.name") %>"/>
                </a>
            </li>
            <li>
                <div class="foot_link">
                    <h2>하단 링크</h2>
					<a href="javascript:goSubMenu('/web/infopage/clauseShow.do','66532170e21f4bd28b8f54da5c1b4ce5','1','///');" title="이용약관" target="_self">이용약관</a>
					<a href="javascript:goSubMenu('/web/infopage/privacyShow.do','4c5810db9ca9477796162f004f1a0b16','1','///');" title="개인정보처리방침" target="_self">개인정보처리방침</a>
					<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=8042f3dc855b4216ad30df5169b136e9','b3695e6983bf4816a8d0252c1cb8ee67','1','///');" title="찾아오시는 길" target="_self">찾아오시는 길</a>
                </div>

                <!-- address_주소 내용 영역 -->
                <address>
                    <ul class="area_footer_02">
                        <h2>주소</h2>
                        <li>
                            (우:04337) 서울특별시 용산구 신흥로 152 FAX 02-6913-2119 | <b>콜센터 1670-7653</b><br/>
                            Copyright 2010. 한국에너지재단 All rights reserved.
                        </li>
                        <li>
                            본 페이지에 게시된 이메일 주소가 자동수집 되는것을 거부하며 이를 위반시 정보통신법에 의해 처벌됨을 유념하시기 바랍니다.
                        </li>
                    </ul>
                </address>
                <!-- //address -->
            </li>
        </ul>

        <div class="family_site_area" style="display:none">
            <h2>패밀리사이트</h2>
            <select name="family_site" id="family_site" title="패밀리사이트">
                <option value="" selected>패밀리사이트
                <option value="http://naver.com">네이버
            </select>
            <button type="button" id="family_site_bt">이동</button>
        </div>
    </footer>
</div>
