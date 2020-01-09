<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_cert' ).bind( 'click' , function(){
		popupCmpyDirCert();
	});
	
});	

</script>
	
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">인증 및 기술획득현황</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_cert" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<!-- table_area -->
		<div class="table_area">
			<table class="list">
				<caption>인증 및 기술획득현황 화면</caption>
				<colgroup>
					<col style="width: 18%;">
					<col style="width: 15%;">
					<col style="width: 18%;">
					<col style="width: *;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">취득일자</th>
						<th scope="col">구분</th>
						<th scope="col">명칭/발행처</th>
						<th scope="col">제품 또는 기술명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cmpyDirCertList}" var="list">	
						<tr>
							<td>${list.cert_date}</td>
							<td>${list.domestic_yn_nm}</td>
							<td>${list.issu_agc}</td>							
							<td>${list.prdt_nm}</td>
						</tr>
					</c:forEach>					
					<c:if test="${empty cmpyDirCertList}">
						<td colspan="4">등록된 인증 및 기술획득현황이 없습니다.</td>
					</c:if>
				</tbody>
			</table>
		</div>
		<!--// table_area -->