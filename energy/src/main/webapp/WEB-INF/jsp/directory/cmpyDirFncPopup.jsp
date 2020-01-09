<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   

<script language="javascript">

$( document ).ready( function(){
	
// 	$( 'span.amount' ).number( true );
// 	$( '#amount' ).number( true );

	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirFncRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirFncRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirFncRow(row){	
	showUpdateBtn();
	selectedRow = row; 
	$("#yy").val(selectedRow.find("input[id='fnc_yy']").val());
	$("#amount").val(selectedRow.find("input[id='fnc_amount']").val());
	$("#cmpyDirFncFormRow").parsley().reset();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirFncRow(){

	if ( $("#cmpyDirFncFormRow").parsley().validate() ){
		
		if( !validateCmpyDirFncRow() ) {
			alert("같은 년도에 매출액이 두번 등록될 수 없습니다.");
			return false;
		}
		
		var fnc_yy = $("#yy").val();
		var fnc_amount = $("#amount").val();
		
		var str = "";

		str += '<tr>';
		str += '	<td id="fnc_yy_label" class="first alignc">' + fnc_yy + '년</td>';
		str += '	<td id="fnc_amount_label" class="last alignc"><span class="amount">' + fnc_amount + '</span></td>';
		str += '	<input type="hidden" id="fnc_yy" name="fnc_yy" value="' + fnc_yy + '" />';
		str += '	<input type="hidden" id="fnc_amount" name="fnc_amount" value="' + fnc_amount + '" />';
		str += '</tr>';
		
		$('#cmpyDirFncTable > tbody:last').append(str);		

		$( 'span.amount' ).number( true );
		
		if($("#emptyRow") != null){
			$("#emptyRow").remove();
		}
		
// 		cancelCmpyDirFncRow();
		updateCmpyDirFnc();
	}
}

function updateCmpyDirFncRow(){

	if ( $("#cmpyDirFncFormRow").parsley().validate() ){
		
		if( !validateCmpyDirFncRow() ) {
			alert("같은 년도에 매출액이 두번 등록될 수 없습니다.");
			return false;
		}
		
		if(selectedRow != null && selectedRow.attr("id") == null){
			
			var fnc_yy = $("#yy").val();
			var fnc_amount = $("#amount").val();

			selectedRow.find("td[id='fnc_yy_label']").html(fnc_yy + "년");
			selectedRow.find("td[id='fnc_amount_label'] > span").html(fnc_amount);
			selectedRow.find("input[id='fnc_yy']").val(fnc_yy);
			selectedRow.find("input[id='fnc_amount']").val(fnc_amount);

			$( 'span.amount' ).number( true );
			updateCmpyDirFnc();
		}
	}
}

function deleteCmpyDirFncRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){
		
		selectedRow.remove();
		selectedRow = null;
		
		if($('#cmpyDirFncTable > tbody').children().length == 0 ){
			
			var str = "";

			str += '<tr id="emptyRow">';
			str += '	<td colspan="2" class="first alignc last">등록된 재무현황이 없습니다.</td>';
			str += '</tr>';
			
			$('#cmpyDirFncTable > tbody:last').append(str);	
		}
// 		cancelCmpyDirFncRow();
		updateCmpyDirFnc();
	}
}

function cancelCmpyDirFncRow(){
	showInsertBtn();
	$("#yy option:eq(0)").prop("selected", true);
	$("#amount").val('');
	selectedRow = null;
	$("#cmpyDirFncFormRow").parsley().reset();
}

function validateCmpyDirFncRow() {
	
	var find = false;
	var yy = $("#yy").val();
	
	var _trs = $('#cmpyDirFncTable > tbody > tr');
	_trs.each(function( index ){
		if(yy == $(this).find("input[id='fnc_yy']").val()) {
			if(selectedRow == null) {
				find = true;
				return false;
			}
			
			if(index != $('#cmpyDirFncTable tbody tr').index(selectedRow)) {
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
		<h1 class="pop_title">재무현황</h1>
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
		
			<!-- pop_content -->
			<div id="pop_content">
			
				<!-- division -->
				<div class="division">

					<form id="cmpyDirFncForm" name="cmpyDirFncForm" method="post" onsubmit="return false;">
						
						<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
								
						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">재무현황</h2>
							</div>
						</div>
						<!--// dtitle_area -->
					
						<!-- dtable_area -->
						<div class="dtable_area">
							<table id="cmpyDirFncTable" class="dtable" style="min-width: 400px">
								<caption>재무현황 목록 화면</caption>
								<colgroup>
									<col style="width: 40%;" />
									<col style="width: *;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col" class="first">기준년도</th>
									<th scope="col" class="last">매출액(백만원)</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach items="${cmpyDirFncList}" var="list">	
										<tr>
											<td id="fnc_yy_label" class="first alignc"><span>${list.fnc_yy}년</span></td>
											<td id="fnc_amount_label" class="last alignc"><a title="매출상세" href="#" id="selectRow" name="selectRow"><span class="amount">${list.fnc_amount}</span></a></td>
											<input type='hidden' id="fnc_yy" name='fnc_yy' value="${list.fnc_yy}" /> 
											<input type='hidden' id="fnc_amount" name='fnc_amount' value="${list.fnc_amount}" />
											</a> 
										</tr>
									</c:forEach>
									<c:if test="${empty cmpyDirFncList}">
										<tr id="emptyRow">
											<td colspan="2" class="first alignc last">등록된 재무현황이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
						<!--// dtable_area -->
						
					</form>
					
					<!-- button_area -->
					<div class="button_area">
						<div class="alignr">
							<button id="btn_save" class="btn save" title="추가" onClick="javascript:showInsert()">
								<span>추가</span>
							</button>		
						</div>
					</div>
					<!--// button_area -->
					
				</div>
				<!--// division -->
				
				<!-- division -->
				<div id="dataRowDiv" class="division">
					<!-- dtitle_area -->
					<div id="dataRowTitleDiv" class="dtitle_area" style="display: none">
						<div class="float_left padt5">
							<h2 class="title">매출액 등록/수정</h2>
						</div>
					</div>
					<!--// dtitle_area -->
					
					<!-- dtable_area -->
					<div id="dataRowTableDiv" class="dtable_area" style="display: none">							
						<form id="cmpyDirFncFormRow" name="cmpyDirFncFormRow" method="post" onsubmit="return false;">
						<table id="test" class="dtable">
							<caption>매출액 등록/수정 화면</caption>
							<colgroup>
								<col style="width: 180px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="first">
									<label for="yy">기준년도<strong class="color_pointr">*</strong></label>
								</th>
								<td class="last">						
									<select id="yy" name="yy" data-parsley-required="true">
										<c:set var="now" value="<%=new java.util.Date()%>" />
         									<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
										<c:forEach begin="0" end="100" var="result" step="1">
											<option value="${yearStart - result}">${yearStart - result} 년</option>
										</c:forEach>
									</select>		
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<label for="amount">매출액(백만원)<strong class="color_pointr">*</strong></label>
								</th>
								<td class="last">
									<input type="text" id="amount" name="amount" class="in_w100" data-parsley-type="digits" data-parsley-required="true"/>
								</td>
							</tr>
							</tbody>
						</table>
						</form>
					</div>
					<!--// dtable_area -->
					
					<!-- button_area -->
					<div id="sub_btn" class="button_area">
						<div class="alignr">
							<button class="btn save" title="저장" onClick="javascript:insertCmpyDirFncRow()">
								<span>저장</span>
							</button>
							<button class="btn save" title="수정" onClick="javascript:updateCmpyDirFncRow()">
								<span>수정</span>
							</button>
							<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirFncRow()">
								<span>삭제</span>
							</button>
							<button class="btn cancel" title="취소" onClick="javascript:cancel()">
								<span>취소</span>
							</button>		
						</div>
					</div>
					<!--// button_area -->
					
					<!-- button_area -->
					<div class="button_area" style="display: none">
						<div class="alignr">
							<button class="btn save" title="저장" onClick="javascript:updateCmpyDirFnc()">
								<span>저장</span>
							</button>
							<button class="btn cancel" title="취소" onClick="javascript:popupClose()">
								<span>취소</span>
							</button>		
						</div>
					</div>
					<!--// button_area -->
					
				</div>
				<!--// division -->
				
			</div>
			<!--// pop_content -->
			
		</div>
	</article>	
	</div>
	<!-- //container -->
</div>