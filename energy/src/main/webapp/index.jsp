<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String url = request.getRequestURL().toString();

    String frontYn = "Y";
    if(url.indexOf("admin") > -1) frontYn = "N";     
%>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html lang="ko">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
</head>
<body class="pace-top">
	<%
	if(frontYn.equals("Y")){
	%>
		<c:set var="prgeUrl" value="/web/user/main.do"/>
	<% 
	} else {  
	%>
		<c:if test="${SESSION_USER != null}">
			<c:set var="prgeUrl" value="/admin/user/main.do"/>
		</c:if>
		<c:if test="${SESSION_USER == null }">
			<c:set var="prgeUrl" value="/login.do"/>
		</c:if>
	<% } %>

	<c:redirect url="${prgeUrl}"/>

</body>
</html>