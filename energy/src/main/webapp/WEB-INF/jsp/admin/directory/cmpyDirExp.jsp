<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   
	
<script language="javascript">

$( document ).ready( function(){
	
	$( 'span.amount' ).number( true );
	
	$( '#btn_cmpy_dir_exp' ).bind( 'click' , function(){
		popupCmpyDirExp();
	});
});	

</script>
	
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">수출현황</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_exp" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<!-- table_area -->
		<div class="table_area">
			<table class="list">
				<caption>수출현황 화면</caption>
				<colgroup>
					<col style="width: 20%;">
					<col style="width: *;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">기준년도</th>
						<th scope="col">매출액(백만원)</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cmpyDirExpList}" var="list">	
						<tr>
							<td>${list.exp_yy}년</td>
							<td><span class="amount">${list.exp_amount}</span></td>
						</tr>
					</c:forEach>					
					<c:if test="${empty cmpyDirExpList}">
						<td colspan="2">등록된 수출현황이 없습니다.</td>
					</c:if>
				</tbody>
			</table>
			<p class="margint5 color_pointo alignr">* 주요수출국 : ${cmpyDirExpCountry.exp_country}</p>
		</div>
		<!--// table_area -->
		