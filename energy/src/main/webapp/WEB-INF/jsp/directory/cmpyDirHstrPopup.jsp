<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){

// 	$('#cmpyDirHstrTable > tbody').on( 'click', 'tr', function () {	
// 		if($(this).attr("id") == null){
// 			seletedCmpyDirHstrRow( $(this) );
// 		}
// 	} );

	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirHstrRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirHstrRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirHstrRow(row){	
	showUpdateBtn();
	selectedRow = row; 
	$("#yy").val(selectedRow.find("input[id='hstr_yy']").val());
	$("#mm").val(selectedRow.find("input[id='hstr_mm']").val());
	$("#cn").val(selectedRow.find("input[id='hstr_cn']").val());
	$("#cn_en").val(selectedRow.find("input[id='hstr_cn_en']").val());
	$("#cmpyDirHstrFormRow").parsley().reset();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirHstrRow(){

	if ( $("#cmpyDirHstrFormRow").parsley().validate() ){
		
		var hstr_yy = $("#yy").val();
		var hstr_mm = $("#mm").val();
		var hstr_cn = $("#cn").val();
		var hstr_cn_en = $("#cn_en").val();
		
		var str = "";

		str += '<tr>';
		str += '	<td id="hstr_yy_label" class="first alignc">' + hstr_yy + '년</td>';
		str += '	<td id="hstr_mm_label" class="last alignc">' + hstr_mm + '월</td>';
		str += '	<td id="hstr_cn_label" class="last">' + hstr_cn + '</td>';
		str += '	<input type="hidden" id="hstr_yy" name="hstr_yy" value="' + hstr_yy + '" />';
		str += '	<input type="hidden" id="hstr_mm" name="hstr_mm" value="' + hstr_mm + '" />';
		str += '	<input type="hidden" id="hstr_cn" name="hstr_cn" value="' + hstr_cn + '" />';
		str += '	<input type="hidden" id="hstr_cn_en" name="hstr_cn_en" value="' + hstr_cn_en + '" />';
		str += '</tr>';
		
		$('#cmpyDirHstrTable > tbody:last').append(str);		

		if($("#emptyRow") != null){
			$("#emptyRow").remove();
		}
		
// 		cancelCmpyDirHstrRow();
		updateCmpyDirHstr();
	}
}

function updateCmpyDirHstrRow(){

	if ( $("#cmpyDirHstrFormRow").parsley().validate() ){
		
		if(selectedRow != null && selectedRow.attr("id") == null){
			
			var hstr_yy = $("#yy").val();
			var hstr_mm = $("#mm").val();
			var hstr_cn = $("#cn").val();
			var hstr_cn_en = $("#cn_en").val();

			selectedRow.find("td[id='hstr_yy_label']").html(hstr_yy + "년");
			selectedRow.find("td[id='hstr_mm_label']").html(hstr_mm + "월");
			selectedRow.find("td[id='hstr_cn_label']").html(hstr_cn);
			selectedRow.find("input[id='hstr_yy']").val(hstr_yy);
			selectedRow.find("input[id='hstr_mm']").val(hstr_mm);
			selectedRow.find("input[id='hstr_cn']").val(hstr_cn);
			selectedRow.find("input[id='hstr_cn_en']").val(hstr_cn_en);
			updateCmpyDirHstr();
		}
	}
}

function deleteCmpyDirHstrRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){
		
		selectedRow.remove();
		selectedRow = null;
		
		if($('#cmpyDirHstrTable > tbody').children().length == 0 ){
			
			var str = "";

			str += '<tr id="emptyRow">';
			str += '	<td colspan="3" class="first alignc">등록된 연혁이 없습니다.</td>';
			str += '</tr>';
			
			$('#cmpyDirHstrTable > tbody:last').append(str);	
		}
// 		cancelCmpyDirHstrRow();
		updateCmpyDirHstr();
	}
}

function cancelCmpyDirHstrRow(){
	showInsertBtn();
	$("#yy option:eq(0)").prop("selected", true);
	$("#mm option:eq(0)").prop("selected", true);
	$("#cn").val('');
	$("#cn_en").val('');
	selectedRow = null;
	$("#cmpyDirHstrFormRow").parsley().reset();
}

</script>

<div id="wrap">

	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">연혁</h1>
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

					<form id="cmpyDirHstrForm" name="cmpyDirHstrForm" method="post" onsubmit="return false;">
						
						<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
				
						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">연혁</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div class="dtable_area">
							<table id="cmpyDirHstrTable" class="dtable" style="min-width: 500px">
								<caption>연혁 목록 화면</caption>
								<colgroup>
									<col style="width: 20%;" />
									<col style="width: 10%;" />
									<col style="width: *;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col" class="first">년도</th>
									<th scope="col">월</th>
									<th scope="col" class="last">내용</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach items="${cmpyDirHstrList}" var="list" varStatus="status">
										<tr>										
											<td id="hstr_yy_label" class="first alignc">${list.hstr_yy}년</td>
											<td id="hstr_mm_label" class="alignc">${list.hstr_mm}월</td>
											<td id="hstr_cn_label" class="last"><a title="연혁상세" href="#" id="selectRow" name="selectRow">${list.hstr_cn}</a></td>	
											<input type="hidden" id="hstr_yy" name="hstr_yy" value="${list.hstr_yy}" />
											<input type="hidden" id="hstr_mm" name="hstr_mm" value="${list.hstr_mm}" />
											<input type="hidden" id="hstr_cn" name="hstr_cn" value="${list.hstr_cn}" />
											<input type="hidden" id="hstr_cn_en" name="hstr_cn_en" value="${list.hstr_cn_en}" />
										</tr>				
												
										<c:set value="${list.hstr_yy}" var="pre_hstr_yy"/>		
											
									</c:forEach>					
									<c:if test="${empty cmpyDirHstrList}">
										<tr id="emptyRow">
											<td colspan="3" class="first alignc">등록된 연혁이 없습니다.</td>
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
				<div class="division">
						<!-- dtitle_area -->
						<div id="dataRowTitleDiv" class="dtitle_area" style="display: none">
							<div class="float_left padt5">
								<h2 class="title">연혁 등록/수정</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div id="dataRowTableDiv" class="dtable_area" style="display: none">
							<form id="cmpyDirHstrFormRow" name="cmpyDirHstrFormRow" method="post" onsubmit="return false;">
							<table class="dtable">
								<caption>연혁 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 200px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" class="first">
										<strong class="color_pointr">*</strong>년도/월
									</th>
									<td class="last">
										<select class="in_wp100" id="yy" name="yy" data-parsley-required="true">
											<c:set var="now" value="<%=new java.util.Date()%>" />
	         								<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
											<c:forEach begin="0" end="100" var="result" step="1">
												<option value="${yearStart - result}" <c:if test="${(yearStart - result) eq cmpyDir.est_yy}">selected</c:if> >${yearStart - result}년</option>
											</c:forEach>
										</select>
										<label for="yy" class="hidden">연도선택</label>
										
										<select class="in_wp100" id="mm" name="mm" data-parsley-required="true">
											<c:forEach var="i" begin="1" end="12">
												<option value="${i}" <c:if test="${i eq cmpyDir.est_mm}">selected</c:if> >${i}월</option>
											</c:forEach>
										</select>
										<label for="mm" class="hidden">월선택</label>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="cn">
											<strong class="color_pointr">*</strong>내용(국문)
										</label>
									</th>
									<td class="last">
										<textarea cols="5" rows="5" id="cn" name="cn" class="in_w100" title="내용(국문) 입력" data-parsley-maxlength="300" data-parsley-required="true"></textarea>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="cn_en">
											내용(영문)
										</label>
									</th>
									<td class="last">
										<textarea cols="5" rows="5" id="cn_en" name="cn_en" class="in_w100" title="내용(영문) 입력" data-parsley-maxlength="300" ></textarea>
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
							<button class="btn save" title="수정" onClick="javascript:insertCmpyDirHstrRow()">
								<span>저장</span>
							</button>
							<button class="btn save" title="수정" onClick="javascript:updateCmpyDirHstrRow()">
								<span>수정</span>
							</button>
							<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirHstrRow()">
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
							<button class="btn save" title="저장" onClick="javascript:updateCmpyDirHstr()">
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