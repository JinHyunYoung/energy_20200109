<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){

// 	$('#cmpyDirVdoTable > tbody').on( 'click', 'tr', function () {	
// 		if($(this).attr("id") == null){
// 			seletedCmpyDirVdoRow( $(this) );
// 		}
// 	} );

	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirVdoRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirVdoRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirVdoRow(row){	
	showUpdateBtn();
	selectedRow = row; 
	$("#title").val(selectedRow.find("input[id='vdo_title']").val());
	$("#title_en").val(selectedRow.find("input[id='vdo_title_en']").val());
	$("#path").val(selectedRow.find("input[id='vdo_path']").val());
	$("#cmpyDirVdoFormRow").parsley().reset();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirVdoRow(){

	if ( $("#cmpyDirVdoFormRow").parsley().validate() ){
		
		var vdo_title = $("#title").val();
		var vdo_title_en = $("#title_en").val();
		var vdo_path = $("#path").val();
		
		var str = "";

		str += '<tr>';
		str += '	<td id="vdo_title_label" class="first alignc"><p>' + vdo_title + '</p><p>' + vdo_title_en + '</p></td>';
		str += '	<td id="vdo_path_label" class="last alignl">' + vdo_path + '</td>';
		str += '	<input type="hidden" id="vdo_title" name="vdo_title" value="' + vdo_title + '" />';
		str += '	<input type="hidden" id="vdo_title_en" name="vdo_title_en" value="' + vdo_title_en + '" />';
		str += '	<input type="hidden" id="vdo_path" name="vdo_path" value="' + vdo_path + '" />';
		str += '</tr>';
		
		$('#cmpyDirVdoTable > tbody:last').append(str);

		if($("#emptyRow") != null){
			$("#emptyRow").remove();
		}
		
// 		cancelCmpyDirVdoRow();
		updateCmpyDirVdo();
	}
}

function updateCmpyDirVdoRow(){

	if ( $("#cmpyDirVdoFormRow").parsley().validate() ){
		
		if(selectedRow != null && selectedRow.attr("id") == null){
			
			var vdo_title = $("#title").val();
			var vdo_title_en = $("#title_en").val();
			var vdo_path = $("#path").val();

			selectedRow.find("td[id='vdo_title_label']").html('<p>' + vdo_title + '</p><p>' + vdo_title_en + '</p>');
			selectedRow.find("td[id='vdo_path_label']").html(vdo_path);
			selectedRow.find("input[id='vdo_title']").val(vdo_title);
			selectedRow.find("input[id='vdo_title_en']").val(vdo_title_en);
			selectedRow.find("input[id='vdo_path']").val(vdo_path);
			
			updateCmpyDirVdo();
		}
	}
}

function deleteCmpyDirVdoRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){
		
		selectedRow.remove();
		selectedRow = null;
		
		if($('#cmpyDirVdoTable > tbody').children().length == 0 ){
			
			var str = "";

			str += '<tr id="emptyRow">';
			str += '	<td colspan="2" class="first alignc">등록된 동영상이 없습니다.</td>';
			str += '</tr>';
			
			$('#cmpyDirVdoTable > tbody:last').append(str);	
		}
// 		cancelCmpyDirVdoRow();
		updateCmpyDirVdo();
	}
}

function cancelCmpyDirVdoRow(){
	showInsertBtn();
	$("#title").val('');
	$("#title_en").val('');
	$("#path").val('');
	selectedRow = null;
	$("#cmpyDirVdoFormRow").parsley().reset();
}

</script>

<div id="wrap">

	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">기업 동영상</h1>
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

					<form id="cmpyDirVdoForm" name="cmpyDirVdoForm" method="post" onsubmit="return false;">
						
						<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" />
				
						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">기업 동영상</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div class="dtable_area">
							<table id="cmpyDirVdoTable" class="dtable" style="min-width: 500px">
								<caption>기업 동영상 목록 화면</caption>
								<colgroup>
									<col style="width: 20%;" />
									<col style="width: *;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col" class="first">제목</th>
									<th scope="col" class="last">URL</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach items="${cmpyDirVdoList}" var="list" varStatus="status">
										<tr>
											<td id="vdo_title_label" class="first alignc"><p>${list.vdo_title}</p><p>${list.vdo_title_en}</p></td>
											<td id="vdo_path_label" class="last alignl"><a title="인증상세" href="#" id="selectRow" name="selectRow">${list.vdo_path}</a></td>
											<input type="hidden" id="vdo_title" name="vdo_title" value="${list.vdo_title}" />
											<input type="hidden" id="vdo_title_en" name="vdo_title_en" value="${list.vdo_title_en}" />
											<input type="hidden" id="vdo_path" name="vdo_path" value="${list.vdo_path}" />
										</tr>
									</c:forEach>
									<c:if test="${empty cmpyDirVdoList}">
										<tr id="emptyRow">
											<td colspan="2" class="first alignc">등록된 동영상이 없습니다.</td>
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
								<h2 class="title">제품사진 등록/수정</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div id="dataRowTableDiv" class="dtable_area" style="display: none">
							<form id="cmpyDirVdoFormRow" name="cmpyDirVdoFormRow" method="post" onsubmit="return false;">
							<table class="dtable">
								<caption>제품사진 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 200px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" class="first">
										<label for="title">
											<strong class="color_pointr">*</strong>제품명(국문)
										</label>
									</th>
									<td class="last">
										<input type="text" id="title" name="title" class="in_w100" data-parsley-required="true"/>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="title_en">
											제품명(영문)
										</label>
									</th>
									<td class="last">
										<input type="text" id="title_en" name="title_en" class="in_w100" />
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="path">
											<strong class="color_pointr">*</strong>URL
										</label>
									</th>
									<td class="last">
										<input type="text" id="path" name="path" class="in_w100" data-parsley-maxlength="300" data-parsley-required="true"/>
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
							<button class="btn save" title="수정" onClick="javascript:insertCmpyDirVdoRow()">
								<span>저장</span>
							</button>
							<button class="btn save" title="수정" onClick="javascript:updateCmpyDirVdoRow()">
								<span>수정</span>
							</button>
							<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirVdoRow()">
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
							<button class="btn save" title="저장" onClick="javascript:updateCmpyDirVdo()">
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