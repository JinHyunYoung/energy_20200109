<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_hstr' ).bind( 'click' , function(){
		popupCmpyDirHstr();
	});
	
});	

</script>

		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">연혁</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_hstr" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
				
		<!-- table_area -->
		<div class="table_area">
			<table class="list">
				<caption>연혁현황 화면</caption>
				<colgroup>
					<col style="width: 15%;" />
					<col style="width: 10%;" />
					<col style="width: *;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">년도</th>
						<th scope="col">월</th>
						<th scope="col">내용</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cmpyDirHstrList}" var="list" varStatus="status">
					
						<tr>																		
						<c:if test="${list.hstr_yy ne pre_hstr_yy}">
							<td rowspan="${list.hstr_yy_rowspan}" class="alignc">${list.hstr_yy}년</td>
						</c:if>
							<td class="alignc">${list.hstr_mm}월</td>
							<td class="alignl">${list.hstr_cn}</td>	
						</tr>				
								
						<c:set value="${list.hstr_yy}" var="pre_hstr_yy"/>		
							
					</c:forEach>					
					<c:if test="${empty cmpyDirHstrList}">
						<td colspan="3" class="first alignc">등록된 연혁이 없습니다.</td>
					</c:if>
				</tbody>
			</table>
		</div>
		<!--// table_area -->
