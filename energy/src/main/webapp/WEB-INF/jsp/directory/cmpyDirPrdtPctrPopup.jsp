<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
	$("#file_area").hide();

	// 파일 삭제
	$('.file_area .btn_file_delete').click(function() {
	    
        if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
            
            var el = this;
            
            $.post(        	    
            	"/commonFile/deleteOneCommonFile.do",
                {file_id : $(el).data("file_id")},
                function(data) {
                    if (data.success == "true") {
                    	deleteFileEvent();
                    	$("#file_area").hide();
                    } 
                    alert(data.message);
                }
            );
        }
    });
	
// 	$('#cmpyDirPrdtPctrTable > tbody').on( 'click', 'tr', function () {	
// 		if($(this).attr("id") == null){
// 			seletedCmpyDirPrdtPctrRow( $(this) );
// 		}
// 	} );

	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirPrdtPctrRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirPrdtPctrRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirPrdtPctrRow(row){	
	showUpdateBtn();
	selectedRow = row; 
	$("#prdt_pctr_sn").val(selectedRow.find("input[id='row_prdt_pctr_sn']").val());
	$("#prdt_nm").val(selectedRow.find("input[id='row_prdt_nm']").val());
	$("#prdt_nm_en").val(selectedRow.find("input[id='row_prdt_nm_en']").val());
	$("#pre_prdt_file_id").val(selectedRow.find("input[id='row_prdt_file_id']").val());

	var pre_prdt_file_id = selectedRow.find("input[id='row_prdt_file_id']").val();
	var pre_prdt_file_id_nm = selectedRow.find("input[id='row_prdt_file_id_nm']").val();

	if(pre_prdt_file_id_nm != ''){
		$("a[class='download']").attr("href", '/commonfile/fileidDownLoad.do?file_id='+pre_prdt_file_id);
		$("a[class='download']").html(pre_prdt_file_id_nm);		
		$("a[class='btn_file_delete']").removeData("file_id")		
		$("a[class='btn_file_delete']").data("file_id", pre_prdt_file_id);		
		$("#file_area").show();
	} else {
		$("a[class='download']").attr("href", "#");
		$("a[class='download']").html("");
		$("a[class='btn_file_delete']").removeData("file_id")
		$("#file_area").hide();
	}
	
	$("#cmpyDirPrdtPctrFormRow").parsley().reset();

	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirPrdtPctrRow(){

	if ( $("#cmpyDirPrdtPctrFormRow").parsley().validate() ){
		
		if ($("#file_id").val() != null && $("#file_id").val() != ""){
			if (!$("#file_id").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
				alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
				return;
			} 			
		}

		$("#cmpyDirPrdtPctrFormRow").ajaxSubmit({
			success: function(responseText, statusText){
					alert(responseText.message);
					
					if(responseText.success == "true"){

						var prdt_pctr_sn = responseText.prdt_pctr_sn;
						var prdt_nm = responseText.prdt_nm;
						var prdt_nm_en = responseText.prdt_nm_en == null? '':responseText.prdt_nm_en;
						var prdt_file_id = responseText.prdt_file_id == null? '':responseText.prdt_file_id;
						var prdt_file_id_nm = responseText.prdt_file_id_nm == null? '':responseText.prdt_file_id_nm;
						
						var str = "";
						
						str += '<tr>';
						str += '	<td id="prdt_file_id_label" class="first alignc">';
						str += '		<div class="dtable_img">';
						
						if(prdt_file_id_nm != null && prdt_file_id_nm != '' && prdt_file_id_nm != 'undefined'){
							str += '			<img src="/contents/directory/' + prdt_file_id_nm + '" width="100" height="100" alt="' + prdt_file_id_nm + '" title="' + prdt_file_id_nm + '" />';
						} else {
							str += '			<img src="/images/admin/common/detail_no_img.png" width="100" height="100" alt="이미지 없음" class="info_img" />';			
						}
						
						str += '		</div>';
						str += '	</td>';
						str += '	<td id="prdt_nm_label" class="last alignc"><p class="product_kor_name">' + prdt_nm + '</p><p class="product_eng_name">' + prdt_nm_en + '</p></td>';
						
						str += '	<input type="hidden" id="row_prdt_pctr_sn" name="row_prdt_pctr_sn" value="' + prdt_pctr_sn + '" />';
						str += '	<input type="hidden" id="row_prdt_nm" name="row_prdt_nm" value="' + prdt_nm + '" />';
						str += '	<input type="hidden" id="row_prdt_nm_en" name="row_prdt_nm_en" value="' + prdt_nm_en + '" />';
						str += '	<input type="hidden" id="row_prdt_file_id" name="row_prdt_file_id" value="' + prdt_file_id + '" />';
						str += '	<input type="hidden" id="row_prdt_file_id_nm" name="row_prdt_file_id_nm" value="' + prdt_file_id_nm + '" />';
						str += '</tr>';
						
						$('#cmpyDirPrdtPctrTable > tbody:last').append(str);		
						
						if($("#emptyRow") != null){
							$("#emptyRow").remove();
						}
						
// 						cancelCmpyDirPrdtPctrRow();		
						popupClose();
					}	
 				},
 				dataType: "json",
 				data : {
 				},
 				url: $('#homepage_tp').val() + "insertCmpyDirPrdtPctr.do"
		});	
	}
}

function updateCmpyDirPrdtPctrRow(){

	if ( $("#cmpyDirPrdtPctrFormRow").parsley().validate() ){
		
		if(selectedRow != null && selectedRow.attr("id") == null){

			$("#cmpyDirPrdtPctrFormRow").ajaxSubmit({
				success: function(responseText, statusText){
						alert(responseText.message);
						
						if(responseText.success == "true"){

							var prdt_pctr_sn = responseText.prdt_pctr_sn;
							var prdt_nm = responseText.prdt_nm;
							var prdt_nm_en = responseText.prdt_nm_en == null? '':responseText.prdt_nm_en;
							var prdt_file_id = responseText.prdt_file_id == null? '':responseText.prdt_file_id;
							var prdt_file_id_nm = responseText.prdt_file_id_nm == null? '':responseText.prdt_file_id_nm;
							
							var str = "";							
							str += '		<div class="dtable_img">';

							if(prdt_file_id_nm != null && prdt_file_id_nm != '' && prdt_file_id_nm != 'undefined'){
								str += '			<img src="/contents/directory/' + prdt_file_id_nm + '" width="100" height="100" alt="' + prdt_file_id_nm + '" title="' + prdt_file_id_nm + '" />';
							} else {
								str += '			<img src="/images/admin/common/detail_no_img.png" width="100" height="100" alt="이미지 없음" class="info_img" />';			
							}
							
							str += '		</div>';

							selectedRow.find("td[id='prdt_file_id_label']").html(str);
							selectedRow.find("td[id='prdt_nm_label']").html('<p class="product_kor_name">' + prdt_nm + '</p><p class="product_eng_name">' + prdt_nm_en + '</p>');

							selectedRow.find("input[id='row_prdt_pctr_sn']").val(prdt_pctr_sn);
							selectedRow.find("input[id='row_prdt_nm']").val(prdt_nm);
							selectedRow.find("input[id='row_prdt_nm_en']").val(prdt_nm_en);
							selectedRow.find("input[id='row_prdt_file_id']").val(prdt_file_id);
							selectedRow.find("input[id='row_prdt_file_id_nm']").val(prdt_file_id_nm);
							
							if(prdt_file_id_nm != ''){
								$("a[class='download']").attr("href", '/commonfile/fileidDownLoad.do?file_id='+prdt_file_id);
								$("a[class='download']").html(prdt_file_id_nm);		
								$("a[class='btn_file_delete']").removeData("file_id")		
								$("a[class='btn_file_delete']").data("file_id", prdt_file_id);		
								$("#file_area").show();
							} 
							popupClose();
						}	
						
	 				},
	 				dataType: "json",
	 				data : {
	 				},
	 				url: $('#homepage_tp').val() + "updateCmpyDirPrdtPctr.do"
			});							
		}
	}
}

function deleteCmpyDirPrdtPctrRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){

		$("#cmpyDirPrdtPctrFormRow").ajaxSubmit({
			success: function(responseText, statusText){
					alert(responseText.message);
					
					if(responseText.success == "true"){			
						
						selectedRow.remove();
						selectedRow = null;
						
						if($('#cmpyDirPrdtPctrTable > tbody').children().length == 0 ){
							
							var str = "";

							str += '<tr id="emptyRow">';
							str += '	<td colspan="2" class="first alignc">등록된 제품사진이 없습니다.</td>';
							str += '</tr>';
							
							$('#cmpyDirPrdtPctrTable > tbody:last').append(str);	
						}	
// 						cancelCmpyDirPrdtPctrRow();	
						popupClose();
					}	
 				},
 				dataType: "json",
 				data : {
 				},
 				url: $('#homepage_tp').val() + "deleteCmpyDirPrdtPctr.do"
		});	
	}
}

function cancelCmpyDirPrdtPctrRow(){
	showInsertBtn();
	$("#prdt_nm").val('');
	$("#prdt_nm_en").val('');
	$("#file_area").html('');
	selectedRow = null;
	$("#cmpyDirPrdtPctrFormRow").parsley().reset();
}

function deleteFileEvent(){

	if(selectedRow != null && selectedRow.attr("id") == null){
		
		var str = "";
		str += '		<div class="dtable_img">';
		str += '			<img src="/images/admin/common/detail_no_img.png" alt="이미지 없음" class="info_img" />';
		str += '		</div>';
		
		selectedRow.find("td[id='prdt_file_id_label']").html(str);
		
		selectedRow.find("input[id='row_prdt_file_id']").val('');
		selectedRow.find("input[id='row_prdt_file_id_nm']").val('');
	}
	
}

</script>

<div id="wrap">

	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">제품사진</h1>
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

					<form id="cmpyDirPrdtPctrForm" name="cmpyDirPrdtPctrForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
				
						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">제품사진</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div class="dtable_area">
							<table id="cmpyDirPrdtPctrTable" class="dtable" style="min-width: 500px">
								<caption>제품사진 목록 화면</caption>
								<colgroup>
									<col style="width: 20%;" />
									<col style="width: *;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col" class="first">제품사진</th>
									<th scope="col" class="last">제품명(국문/영문)</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach items="${cmpyDirPrdtPctrList}" var="list" varStatus="status">
										<tr>
											<td id="prdt_file_id_label" class="first alignc">
												<a title="제품사진상세" href="#" id="selectRow" name="selectRow">
												<div class="dtable_img">													
													<c:if test="${not empty list.prdt_file_id_nm}">
														<img src="/contents/directory/${list.prdt_file_id_nm}" width="100" height="100" alt="${list.prdt_nm}" title="${list.prdt_nm}" />
													</c:if>
													<c:if test="${empty list.prdt_file_id_nm}">
														<img src="/images/web/common/no_album_img.png" width="100" height="100" alt="이미지 없음" />
													</c:if>
												</div>
												</a>
											</td>
											<td id="prdt_nm_label" class="last alignl">
												<p>${list.prdt_nm}</p>
												<p>${list.prdt_nm_en}</p>
											</td>
											<input type="hidden" id="row_prdt_pctr_sn" name="row_prdt_pctr_sn" value="${list.prdt_pctr_sn}" />
											<input type="hidden" id="row_prdt_nm" name="row_prdt_nm" value="${list.prdt_nm}" />
											<input type="hidden" id="row_prdt_nm_en" name="row_prdt_nm_en" value="${list.prdt_nm_en}" />
											<input type="hidden" id="row_prdt_file_id" name="row_prdt_file_id" value="${list.prdt_file_id}" />
											<input type="hidden" id="row_prdt_file_id_nm" name="row_prdt_file_id_nm" value="${list.prdt_file_id_nm}" />		
										</tr>										
										<c:if test="${status.index ne 0}">
											<div class="tab hidden">												
												<c:if test="${not empty list.prdt_file_id_nm}">
													<img src="/contents/directory/${list.prdt_file_id_nm}" alt="${list.prdt_nm}" title="${list.prdt_nm}" />
												</c:if>
												<c:if test="${empty list.prdt_file_id_nm}">
													<img src="/images/web/common/no_album_img.png" alt="이미지 없음" />
												</c:if>
											</div>			
										</c:if>
									</c:forEach>
									<c:if test="${empty cmpyDirPrdtPctrList}">
										<tr id="emptyRow">
											<td colspan="2" class="first alignc">등록된 제품사진이 없습니다.</td>
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
							<form id="cmpyDirPrdtPctrFormRow" name="cmpyDirPrdtPctrFormRow" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" />
							<table class="dtable">
								<caption>제품사진 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 200px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" class="first">
										<label for="prdt_nm">
											<strong class="color_pointr">*</strong>제품명(국문)
										</label>
									</th>
									<td class="last">
										<input type="text" id="prdt_nm" name="prdt_nm" class="in_w100" data-parsley-maxlength="300" data-parsley-required="true"/>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="prdt_nm_en">
											제품명(영문)
										</label>
									</th>
									<td class="last">
										<input type="text" id="prdt_nm_en" name="prdt_nm_en" class="in_w100" data-parsley-maxlength="300" />
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="prdt_file_id">
											<strong class="color_pointr">*</strong>제품사진
										</label>
									</th>
									<td class="last">
										<div class="file_area">
											<label for="file_id" class="hidden">파일 선택하기</label>
											<input id="file_id" name="file_id" type="file" class="in_w100" />													
										</div>									
										<div id="file_area" class="file_area">		
											<ul class="file_list">
												<li>
													<a href="#" target="_blank" class="download" title="다운받기">sample</a>
													<a href="javascript:;" class="btn_file_delete" data-file_id="sample" title="파일 삭제">
														<img src="/images/admin/icon/icon_delete.png" alt="삭제" />
													</a>
												</li>
											</ul>
										</div>
									</td>		
								</tr>
								<input type="hidden" id="prdt_pctr_sn" name="prdt_pctr_sn" />
								<input type="hidden" id="pre_prdt_file_id" name="pre_prdt_file_id"  />
								</tbody>
							</table>
							</form>
						</div>
						<!--// dtable_area -->
					<!-- button_area -->
					<div id="sub_btn" class="button_area">
						<div class="alignr">
							<button class="btn save" title="저장" onClick="javascript:insertCmpyDirPrdtPctrRow()">
								<span>저장</span>
							</button>
							<button class="btn save" title="수정" onClick="javascript:updateCmpyDirPrdtPctrRow()">
								<span>수정</span>
							</button>
							<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirPrdtPctrRow()">
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
							<button class="btn save" title="저장" onClick="javascript:updateCmpyDirPrdtPctr()">
								<span>저장</span>
							</button>
							<button class="btn cancel" title="취소" onclick="javascript:updateCmpyDirPrdtPctr()">
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