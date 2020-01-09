<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<c:set var="inds_tp_cd" value="" />
<c:set var="wbiz_tp_l_cd" value="" />
<c:set var="wbiz_tp_m_cd" value="" />
<c:forEach var="category" items="${categoryList}">
<tr>
	<c:if test="${category.inds_tp_cd != inds_tp_cd}">
	<td rowspan="${category.cnt_l}">${category.code_nm}</td>
	<c:set var="inds_tp_cd" value="${category.inds_tp_cd}" />
	</c:if>
	<c:if test="${category.wbiz_tp_l_cd != wbiz_tp_l_cd}">
	<td rowspan="${category.cnt_m}">${category.wbiz_tp_l_cd}</td>
	<td rowspan="${category.cnt_m}">
	<c:if test="${category.use_yn_l == 'Y'}">
	<a href="#대분류명" onclick="loadCategoryWrite( 'E' , '${category.inds_tp_cd}'  , '${category.wbiz_tp_l_cd}' , 'L' );return false;">${category.wbiz_tp_l_nm}</a>
	</c:if>
	<c:if test="${category.use_yn_l == 'N'}">
	<a href="#대분류명" onclick="loadCategoryWrite( 'E' , '${category.inds_tp_cd}'  , '${category.wbiz_tp_l_cd}' , 'L' );return false;" style="color:#f00;"><del>${category.wbiz_tp_l_nm}</del></a>
	</c:if>
	</td>
	<c:set var="wbiz_tp_l_cd" value="${category.wbiz_tp_l_cd}" />
	</c:if>
	<c:if test="${category.wbiz_tp_m_cd != wbiz_tp_m_cd}">
	<td rowspan="${category.cnt_s}">${category.wbiz_tp_m_cd}</td>
	<td rowspan="${category.cnt_s}">
	<c:if test="${category.use_yn_m == 'Y'}">
	<a href="#중분류명" onclick="loadCategoryWrite( 'E' , '${category.inds_tp_cd}'  , '${category.wbiz_tp_m_cd}' , 'M' );return false;">${category.wbiz_tp_m_nm}</a>
	</c:if>
	<c:if test="${category.use_yn_m == 'N'}">
	<a href="#중분류명" onclick="loadCategoryWrite( 'E' , '${category.inds_tp_cd}'  , '${category.wbiz_tp_m_cd}' , 'M' );return false;" style="color:#f00;"><del>${category.wbiz_tp_m_nm}</del></a>
	</c:if>
	</td>
	<c:set var="wbiz_tp_m_cd" value="${category.wbiz_tp_m_cd}" />
	</c:if>
	<td>${category.wbiz_tp_s_cd}</td>
	<td>
	<c:if test="${category.use_yn_s == 'Y'}">
	<a href="#세분류명" onclick="loadCategoryWrite( 'E' , '${category.inds_tp_cd}'  , '${category.wbiz_tp_s_cd}' , 'S' );return false;">${category.wbiz_tp_s_nm}</a>
	</c:if>
	<c:if test="${category.use_yn_s == 'N'}">
	<a href="#세분류명" onclick="loadCategoryWrite( 'E' , '${category.inds_tp_cd}'  , '${category.wbiz_tp_s_cd}' , 'S' );return false;" style="color:#f00;"><del>${category.wbiz_tp_s_nm}</del></a>
	</c:if>
	</td>
</tr>
</c:forEach>