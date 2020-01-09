<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
</script>

<div class="sub_content">
	<table class="contents_list fixed __se_tbl_ext">
		<caption>물산업 분류체계</caption>
		<colgroup>
			<col style="width: 8%;">
			<col style="width: 6%;">
			<col>
			<col style="width: 6%;">
			<col>
			<col style="width: 8%;">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">업종</th>
				<th scope="col">코드</th>
				<th scope="col">대분류명</th>
				<th scope="col">코드</th>
				<th scope="col">중분류명</th>
				<th scope="col">코드</th>
				<th scope="col">세분류명</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="inds_tp_cd" value="" />
		<c:set var="wbiz_tp_l_cd" value="" />
		<c:set var="wbiz_tp_m_cd" value="" />
		<c:forEach var="category" items="${categoryList}">
		<tr>
			<c:if test="${category.inds_tp_cd != inds_tp_cd}">
			<td rowspan="${category.cnt_l}" class="bdnone">${category.code_nm}</td>
			<c:set var="inds_tp_cd" value="${category.inds_tp_cd}" />
			</c:if>
			<c:if test="${category.wbiz_tp_l_cd != wbiz_tp_l_cd}">
			<td rowspan="${category.cnt_m}">${category.wbiz_tp_l_cd}</td>
			<td rowspan="${category.cnt_m}">${category.wbiz_tp_l_nm}</td>
			<c:set var="wbiz_tp_l_cd" value="${category.wbiz_tp_l_cd}" />
			</c:if>
			<c:if test="${category.wbiz_tp_m_cd != wbiz_tp_m_cd}">
			<td rowspan="${category.cnt_s}">${category.wbiz_tp_m_cd}</td>
			<td rowspan="${category.cnt_s}">${category.wbiz_tp_m_nm}</td>
			<c:set var="wbiz_tp_m_cd" value="${category.wbiz_tp_m_cd}" />
			</c:if>
			<td>${category.wbiz_tp_s_cd}</td>
			<td>${category.wbiz_tp_s_nm}</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
</div>