<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />
<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){

// 	$('#cmpyDirCertTable > tbody').on( 'click', 'tr', function () {	
// 		if($(this).attr("id") == null){
// 			seletedCmpyDirCertRow( $(this) );
// 		}
// 	} );

    $("#cert").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
    
	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirCertRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirCertRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirCertRow(row){	
	showUpdateBtn();
	selectedRow = row; 
	$("#cert").val(selectedRow.find("input[id='cert_date']").val());
	$("#demestic").val(selectedRow.find("input[id='domestic_yn']").val()).attr("selected", "selected");
	$("#agc").val(selectedRow.find("input[id='issu_agc']").val());
	$("#agc_en").val(selectedRow.find("input[id='issu_agc_en']").val());
	$("#nm").val(selectedRow.find("input[id='prdt_nm']").val());
	$("#nm_en").val(selectedRow.find("input[id='prdt_nm_en']").val());
	$("#cmpyDirCertFormRow").parsley().reset();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirCertRow(){

	if ( $("#cmpyDirCertFormRow").parsley().validate() ){
		
		if( !validateCmpyDirCertRow() ) {
			alert("동일한 검.인증명은 두번 등록될 수 없습니다.");
			return false;
		}
		
		var cert_date = $("#cert").val();
		var domestic_yn = $("#demestic").val();
		var issu_agc = $("#agc").val();
		var issu_agc_en = $("#agc_en").val();
		var prdt_nm = $("#nm").val();
		var prdt_nm_en = $("#nm_en").val();
		
		var str = "";

		str += '<tr>';		
		str += '	<td id="cert_date_label">' + cert_date + '</td>';
		if(domestic_yn == 'Y' )
			str += '	<td id="domestic_yn_label">국내</td>';
		else
			str += '	<td id="domestic_yn_label">국외</td>';
		str += '	<td id="issu_agc_label">' + issu_agc + '</td>';
		str += '	<td id="prdt_nm_label">' + prdt_nm + '</td>';
		str += '	<input type="hidden" id="cert_date" name="cert_date" value="' + cert_date + '" />';
		str += '	<input type="hidden" id="domestic_yn" name="domestic_yn" value="' + domestic_yn + '" />';
		str += '	<input type="hidden" id="issu_agc" name="issu_agc" value="' + issu_agc + '" />';
		str += '	<input type="hidden" id="issu_agc_en" name="issu_agc_en" value="' + issu_agc_en + '" />';
		str += '	<input type="hidden" id="prdt_nm" name="prdt_nm" value="' + prdt_nm + '" />';
		str += '	<input type="hidden" id="prdt_nm_en" name="prdt_nm_en" value="' + prdt_nm_en + '" />';
		str += '</tr>';
		
		$('#cmpyDirCertTable > tbody:last').append(str);		
		
		if($("#emptyRow") != null){
			$("#emptyRow").remove();
		}
		
// 		cancelCmpyDirCertRow();
		updateCmpyDirCert();
	}
}

function updateCmpyDirCertRow(){

	if ( $("#cmpyDirCertFormRow").parsley().validate() ){
		
		if( !validateCmpyDirCertRow() ) {
			alert("동일한 검.인증명은 두번 등록될 수 없습니다.");
			return false;
		}
		
		if(selectedRow != null && selectedRow.attr("id") == null){
			
			var cert_date = $("#cert").val();
			var domestic_yn = $("#demestic").val();
			var issu_agc = $("#agc").val();
			var issu_agc_en = $("#agc_en").val();
			var prdt_nm = $("#nm").val();
			var prdt_nm_en = $("#nm_en").val();			
			
			selectedRow.find("td[id='cert_date_label']").html(cert_date);
			if(domestic_yn == 'Y' )
				selectedRow.find("td[id='domestic_yn_label']").html("국내");
			else
				selectedRow.find("td[id='domestic_yn_label']").html("국외");
			selectedRow.find("td[id='issu_agc_label']").html(issu_agc);
			selectedRow.find("td[id='prdt_nm_label']").html(prdt_nm);
			selectedRow.find("input[id='cert_date']").val(cert_date);
			selectedRow.find("input[id='domestic_yn']").val(domestic_yn);
			selectedRow.find("input[id='issu_agc']").val(issu_agc);
			selectedRow.find("input[id='issu_agc_en']").val(issu_agc_en);
			selectedRow.find("input[id='prdt_nm']").val(prdt_nm);
			selectedRow.find("input[id='prdt_nm_en']").val(prdt_nm_en);
			
			updateCmpyDirCert();
		}
	}
}

function deleteCmpyDirCertRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){
		
		selectedRow.remove();
		selectedRow = null;
		
		if($('#cmpyDirCertTable > tbody').children().length == 0 ){
			
			var str = "";

			str += '<tr id="emptyRow">';
			str += '	<td colspan="4">등록된 인증 및 기술획득현황이 없습니다.</td>';
			str += '</tr>';
			
			$('#cmpyDirCertTable > tbody:last').append(str);	
		}
// 		cancelCmpyDirCertRow();
		updateCmpyDirCert();
	}
}

function cancelCmpyDirCertRow(){
	showInsertBtn();
	$("#cert").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));	
	$("#demestic option:eq(0)").prop("selected", true);
	$("#agc").val('');
	$("#agc_en").val('');
	$("#nm").val('');
	$("#nm_en").val('');
	selectedRow = null;
	$("#cmpyDirCertFormRow").parsley().reset();
}

function validateCmpyDirCertRow() {
	
	var find = false;
	var nm = $("#nm").val();
	var agc = $("#agc").val();
	
	var _trs = $('#cmpyDirCertTable > tbody > tr');
	_trs.each(function( index ){
		if(nm == $(this).find("input[id='prdt_nm']").val() && agc == $(this).find("input[id='issu_agc']").val()) {
			
			if(selectedRow == null) {
				find = true;
				return false;
			}
			
			if(index != $('#cmpyDirCertTable tbody tr').index(selectedRow)) {
				find = true;
				return false;
			}
		}
	});
	return !find;	
}

function popupCertClose(){
	$("#modal-cmpyDirCert").popup('hide');
}

</script>

<div id="wrap">
	
	<!-- popup_content -->
	
	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">인증 및 기술획득현황</h1>
		<a href="javascript:popupCertClose()" class="pop_close" title="페이지 닫기">
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
				
					<form id="cmpyDirCertForm" name="cmpyDirCertForm" method="post" onsubmit="return false;">
						
						<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
				
						<!-- title_area -->
						<div class="title_area">
							<h2 class="pop_title">인증 및 기술획득현황</h4>
						</div>
						<!--// title_area -->
						
						<!-- table_area -->
						<div class="table_area">
							<table id="cmpyDirCertTable" class="list" style="min-width: 500px">
								<caption>인증 및 기술획득현황 화면</caption>
								<colgroup>
									<col style="width: 18%;">
									<col style="width: 15%;">
									<col style="width: 25%;">
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
											<td id="cert_date_label">${list.cert_date}</td>
											<td id="domestic_yn_label">${list.domestic_yn_nm}</td>
											<td id="issu_agc_label">${list.issu_agc}</td>							
											<td id="prdt_nm_label"><a title="인증 및 기술획득현황" href="#" id="selectRow" name="selectRow">${list.prdt_nm}</a></td>
											<input type="hidden" id="cert_date" name="cert_date" value="${list.cert_date}" />
											<input type="hidden" id="domestic_yn" name="domestic_yn" value="${list.domestic_yn}" />
											<input type="hidden" id="issu_agc" name="issu_agc" value="${list.issu_agc}" />
											<input type="hidden" id="issu_agc_en" name="issu_agc_en" value="${list.issu_agc_en}" />
											<input type="hidden" id="prdt_nm" name="prdt_nm" value="${list.prdt_nm}" />
											<input type="hidden" id="prdt_nm_en" name="prdt_nm_en" value="${list.prdt_nm_en}" />
										</tr>
									</c:forEach>					
									<c:if test="${empty cmpyDirCertList}">
										<tr id="emptyRow">
											<td colspan="4">등록된 인증 및 기술획득현황이 없습니다.</td>
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
							<h2 class="pop_title">인증 및 기술획득 등록/수정</h4>
						</div>
						<!--// title_area -->
						
						<!-- table_area -->
						<div id="dataRowTableDiv" class="table_area" style="display: none">
							<form id="cmpyDirCertFormRow" name="cmpyDirCertFormRow" method="post" onsubmit="return false;">
							<table class="write">
								<caption>인증 및 기술획득 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 180px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">
											<label for="cert">취득일자<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" id="cert" name="cert" class="in_wp100 datepicker" data-parsley-required="true">
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="demestic">구분<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<g:select id="demestic" name="demestic" codeGroup="DOMESTIC_YN" cls="form-control" class="in_wp100" data-parsley-required="true"/>											
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="agc">명칭/발행처(국문)<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" id="agc" name="agc" class="in_w98" data-parsley-maxlength="300" data-parsley-required="true"/>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="agc_en">명칭/발행처(영문)<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" id="agc_en" name="agc_en" class="in_w98" data-parsley-maxlength="300" data-parsley-required="true"/>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="nm">제품 또는 기술명(국문)<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" id="nm" name="nm" class="in_w98" data-parsley-maxlength="300" data-parsley-required="true"/>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="nm_en">제품 또는 기술명(영문)<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" id="nm_en" name="nm_en" class="in_w98" data-parsley-maxlength="300" data-parsley-required="true"/>
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
								<button class="btn save" title="저장" onClick="javascript:insertCmpyDirCertRow()">
									<span>저장</span>
								</button>
								<button class="btn save" title="수정" onClick="javascript:updateCmpyDirCertRow()">
									<span>수정</span>
								</button>
								<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirCertRow()">
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
						<div class="float_right">
							<button class="btn save" title="저장" onClick="javascript:updateCmpyDirCert()">
								<span>저장</span>
							</button>
							<button class="btn cancel" title="취소" onclick="javascript:popupCertClose()">
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

<script language="javascript">

$('.datepicker').each(function(){
    $(this).datepicker({
		  format: "yyyy-mm-dd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true,
		  showOn: "button",
		  buttonImage:"/images/admin/icon/icon_calendar.png",
		  buttonImageOnly:true,
		  changeMonth: true,
          changeYear: true,
          showButtonPanel:false
		 });
});

</script>