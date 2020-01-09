<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
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
    <link rel="stylesheet" type="text/css" href="/css/main_slider2.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script type="text/javascript" src="/js/main.js"></script>
    <script type="text/javascript" src="/js/Banner_slider.js"></script>
    <script type="text/javascript" src="/js/jquery.sudoSlider.js"></script>
    <script type="text/javascript" src="/js/main_slider.js"></script>
    <script type="text/javascript" src="/js/jquery.counterup.min.js"></script>
    <!--[if lte IE 9]><script src="/js/html5.js"></script><![endif]-->

	<script type="text/javascript">
		function moveUrl(target, url){
			if(target == "1") document.location = url
			else window.open(url);
		}
	</script>

</head>
<body>

<style>
    .swiper-container{position:relative; width:100%;height:384px;}
    .swiper-slide{
        background-position:center center;background-size:cover; color:#fff;
    }


</style>

<div class="swiper-container">
    <div class="swiper-wrapper">
       <c:forEach items="${list}" var="list">
       <div class="swiper-slide" style="background-image:url('/contents/banner/${list.image_nm}')">
			<c:if test="${not empty list.url }">
			  <c:if test="${fn:indexOf(list.url, 'javascript') < 0 }">
				<a href="javascript:moveUrl('${list.target}', '${list.url}')" target="_top" class="slider_link" title="${list.titl_nm}">
					<span class="hidden">${list.titl_nm}</span>
				</a>
			  </c:if>
			  <c:if test="${fn:indexOf(list.url, 'javascript') > -1 }">
				<a href="${list.url}" target="_top" class="slider_link" title="${list.titl_nm}">
					<span class="hidden">${list.titl_nm}</span>
				</a>
			  </c:if>			   	
			</c:if>
		</div>
       </c:forEach>
    </div>
		
    <div class="swiper-pagination swiper-pagination-white"></div>
	<div class="swiper-button-next swiper-button-white"></div>
	<div class="swiper-button-prev swiper-button-white"></div>
</div>


<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        loop: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 0,
        effect: 'slider',
        autoplay: 5000,
        autoplayDisableOnInteraction: false
    });
</script>

</body>
</html>
