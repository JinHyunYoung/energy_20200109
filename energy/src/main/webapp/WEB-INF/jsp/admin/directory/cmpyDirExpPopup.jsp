<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script> 

<script language="javascript">

$( document ).ready( function(){
	
// 	$('#cmpyDirExpTable > tbody').on( 'click', 'tr', function () {	
// 		if($(this).attr("id") == null){
// 			seletedCmpyDirExpRow( $(this) );
// 		}
// 	} );

	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirExpRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirExpRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirExpRow(row){	
	showUpdateBtn();
	selectedRow = row; 
	$("#yy").val(selectedRow.find("input[id='exp_yy']").val());
	$("#amount").val(selectedRow.find("input[id='exp_amount']").val());
	$("#cmpyDirExpFormRow").parsley().reset();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirExpRow(){

	if ( $("#cmpyDirExpFormRow").parsley().validate() ){

		if( !validateCmpyDirExpRow() ) {
			alert("같은 년도에 수출액이 두번 등록될 수 없습니다.");
			return false;
		}
		
		var exp_yy = $("#yy").val();
		var exp_amount = $("#amount").val();
		
		var str = "";

		str += '<tr>';
		str += '	<td id="exp_yy_label">' + exp_yy + '년</td>';
		str += '	<td id="exp_amount_label"><span class="amount">' + exp_amount + '</span></td>';
		str += '	<input type="hidden" id="exp_yy" name="exp_yy" value="' + exp_yy + '" />';
		str += '	<input type="hidden" id="exp_amount" name="exp_amount" value="' + exp_amount + '" />';
		str += '</tr>';
		
		$('#cmpyDirExpTable > tbody:last').append(str);		

		$( 'span.amount' ).number( true );
		
		if($("#emptyRow") != null){
			$("#emptyRow").remove();
		}
		
// 		cancelCmpyDirExpRow();
		updateCmpyDirExp();
	}
}

function updateCmpyDirExpRow(){

	if ( $("#cmpyDirExpFormRow").parsley().validate() ){
		
		if( !validateCmpyDirExpRow() ) {
			alert("같은 년도에 수출액이 두번 등록될 수 없습니다.");
			return false;
		}
		
		if(selectedRow != null && selectedRow.attr("id") == null){

			var exp_yy = $("#yy").val();
			var exp_amount = $("#amount").val();
			var exp_country = $("#country").val();
			var exp_country_en = $("#country_en").val();

			selectedRow.find("td[id='exp_yy_label']").html(exp_yy + "년");
			selectedRow.find("td[id='exp_amount_label'] > span").html(exp_amount);
			selectedRow.find("input[id='exp_yy']").val(exp_yy);
			selectedRow.find("input[id='exp_amount']").val(exp_amount);

			$( 'span.amount' ).number( true );
			updateCmpyDirExp();
		}
	}
}

function deleteCmpyDirExpRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){
		
		selectedRow.remove();
		selectedRow = null;
		
		if($('#cmpyDirExpTable > tbody').children().length == 0 ){
			
			var str = "";

			str += '<tr id="emptyRow">';
			str += '	<td colspan="2">등록된 수출현황이 없습니다.</td>';
			str += '</tr>';
			
			$('#cmpyDirExpTable > tbody:last').append(str);	
		}
// 		cancelCmpyDirExpRow();
		updateCmpyDirExp();
	}
}

function cancelCmpyDirExpRow(){
	showInsertBtn();
	$("#yy option:eq(0)").prop("selected", true);
	$("#amount").val('');
	selectedRow = null;
	$("#cmpyDirExpFormRow").parsley().reset();
}

function validateCmpyDirExpRow() {
	
	var find = false;
	var yy = $("#yy").val();
	
	var _trs = $('#cmpyDirExpTable > tbody > tr');
	_trs.each(function( index ){
		if(yy == $(this).find("input[id='exp_yy']").val()) {
			if(selectedRow == null) {
				find = true;
				return false;
			}
			
			if(index != $('#cmpyDirExpTable tbody tr').index(selectedRow)) {
				find = true;
				return false;
			}
		}
	});
	return !find;	
}

</script>

<div id="wrap">		
	
	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">수출현황</h1>
		<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
			<span>닫기</span>
		</a>
	</header>
	</div>
	<!-- //header -->
	
	<!-- container -->
	<div id="pop_container">
	<article>
		<div class="pop_content_area">

			<div id="pop_content">
			
				<!-- division -->
				<div class="division">
					
					<form id="cmpyDirExpForm" name="cmpyDirExpForm" method="post" onsubmit="return false;">
						
						<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
						<input type='hidden' id="exp_country" name='exp_country' value="${cmpyDirExpCountry.exp_country}" /> 
						<input type='hidden' id="exp_country_en" name='exp_country_en' value="${cmpyDirExpCountry.exp_country_en}" />
						<input type='hidden' id="update_type" name='update_type' value="" />
						 
						<!-- title_area -->
						<div class="title_area">
							<h2 class="pop_title">수출현황</h4>
						</div>
						<!--// title_area -->

						<!-- table_area -->
						<div class="table_area">
							<table id="cmpyDirExpTable" class="list" style="min-width: 500px">
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
											<td id="exp_yy_label"><span>${list.exp_yy}년</span></td>
											<td id="exp_amount_label"><a title="수출현황상세" href="#" id="selectRow" name="selectRow"><span class="amount">${list.exp_amount}</span></a></td>
											<input type='hidden' id="exp_yy" name='exp_yy' value="${list.exp_yy}" /> 
											<input type='hidden' id="exp_amount" name='exp_amount' value="${list.exp_amount}" /> 
										</tr>
									</c:forEach>					
									<c:if test="${empty cmpyDirExpList}">
										<tr id="emptyRow">
											<td colspan="2">등록된 수출현황이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
						<!--// table_area -->

					</form>
					
						<!-- button_area -->
						<div class="button_area">
							<div class="float_right">
								<button id="btn_save" class="btn save" title="추가" onClick="javascript:showInsert()">
									<span>추가</span>
								</button>
							</div>
						</div>
						<!--// button_area -->							
						<!-- title_area -->
						<div id="dataRowTitleDiv" class="title_area" style="display: none">
							<h2 class="pop_title">수출액 등록/수정</h4>
						</div>
						<!--// title_area -->						
											
						<!-- table_area -->
						<div id="dataRowTableDiv" class="table_area" style="display: none">
							<form id="cmpyDirExpFormRow" name="cmpyDirExpFormRow" method="post" onsubmit="return false;">
							<table class="write">
								<caption>수출액 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 140px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">
											<label for="yy">기준년도<strong class="color_pointr">*</strong></label>
										</th>
										<td>					
											<select id="yy" name="yy" class="in_wp100" data-parsley-required="true">
												<c:set var="now" value="<%=new java.util.Date()%>" />
	          									<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
												<c:forEach begin="0" end="100" var="result" step="1">
													<option value="${yearStart - result}">${yearStart - result} 년</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="input_sales">매출액<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" id="amount" name="amount" class="in_wp200" data-parsley-type="digits" data-parsley-required="true"/>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
						</div>
						<!--// table_area -->
						
						<!-- button_area -->
						<div id="sub_btn" class="button_area">
							<div class="float_right">
								<button class="btn save" title="저장" onClick="javascript:insertCmpyDirExpRow()">
									<span>저장</span>
								</button>
								<button class="btn save" title="수정" onClick="javascript:updateCmpyDirExpRow()">
									<span>수정</span>
								</button>
								<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirExpRow()">
									<span>삭제</span>
								</button>
								<button class="btn cancel" title="취소" onClick="javascript:cancel()">
									<span>취소</span>
								</button>	
							</div>
						</div>
						<!--// button_area -->
					
					
					<form id="countryForm" name="countryForm" method="post" onsubmit="return false;">
						<!-- title_area -->
						<div class="title_area">
							<h2 class="pop_title">주요 수출국</h4>
						</div>
						<!--// title_area -->
						
						<!-- table_area -->
						<div class="table_area">
							<table class="write">
								<caption>주요 수출국 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 140px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">
											<label for="country">주요 수출국(국문)</label>
										</th>
										<td>
											<input type="text" id="country" id="country" class="in_w98" value="${cmpyDirExpCountry.exp_country}" data-parsley-maxlength="300"/>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="country_en">주요 수출국(영문)</label>
										</th>
										<td>
											<input type="text" id="country_en" id="country_en" class="in_w98" value="${cmpyDirExpCountry.exp_country_en}" data-parsley-maxlength="300"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
					</form>
					
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<button class="btn save" title="저장" onClick="javascript:updateCountry()">
								<span>저장</span>
							</button>
							<button class="btn cancel" title="취소" onclick="javascript:popupClose()">
								<span>취소</span>
							</button>
						</div>
					</div>
					<!--// button_area -->
					
				</div>
				<!--// division -->
				
			</div>
		</div>
	</article>	
	</div>
	<!--// popup_content -->
	
</div>