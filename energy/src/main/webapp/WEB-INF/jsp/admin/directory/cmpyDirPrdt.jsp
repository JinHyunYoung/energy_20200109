<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_prdt' ).bind( 'click' , function(){
		popupCmpyDirPrdt();
	});
	
});	
</script>
	
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">주요제품 및 기술현황</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_prdt" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<!-- table_area -->
		<div class="table_area">
			<table class="list">
				<caption>주요제품 및 기술현황 화면</caption>
				<colgroup>
					<col style="width: 23%;">
					<col style="width: 23%;">
					<col style="width: 23%;">
					<col style="width: *;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">대분류</th>
						<th scope="col">중분류</th>
						<th scope="col">세분류</th>
						<th scope="col">세부 제품명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cmpyDirPrdtList}" var="list">	
						<tr>
							<td>${list.wbiz_tp_l_cd_nm}</td>
							<td>${list.wbiz_tp_m_cd_nm}</td>							
							<td>${list.wbiz_tp_s_cd_nm}</td>
							<td>${list.prdt_nm}</td>
						</tr>
					</c:forEach>					
					<c:if test="${empty cmpyDirPrdtList}">
						<td colspan="4">등록된 주요제품 및 기술현황이 없습니다.</td>
					</c:if>
				</tbody>
			</table>
		</div>
		<!--// table_area -->