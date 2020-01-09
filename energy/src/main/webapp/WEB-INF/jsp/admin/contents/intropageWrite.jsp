<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var insertIntropageUrl = "<c:url value='/admin/intropage/insertIntropage.do'/>";
var updateIntropageUrl = "<c:url value='/admin/intropage/updateIntropage.do'/>"
var deleteIntropageUrl = "<c:url value='/admin/intropage/deleteIntropage.do'/>";

var selectFileListUrl = "<c:url value='/admin/intropage/fileList.do'/>";
var insertFileurl = "<c:url value='/admin/intropage/insertIntropageFile.do'/>";
var updateFileurl = "<c:url value='/admin/intropage/updateIntropageFile.do'/>";
var deleteFileurl = "<c:url value='/admin/intropage/deleteIntropageFile.do'/>";
var fileListReorderUrl = "<c:url value='/admin/intropage/updateFileListReorder.do'/>";

$(document).ready(function(){
	$('#reg_file_layer').hide();	
	
	$('#file_list').jqGrid({
		datatype: "json",
		url : selectFileListUrl+'?group_id='+$('#group_id').val() ,
		mtype: 'POST',
	    colModel:[
 			{ label: '순서', index: 'sort', name: 'sort', width: 50, align : 'center', edittype :"text", editable : true, sortable:false,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
	      {label: '파일명', name:'file_title',index:'file_title', align : 'left', width:420, sortable:false, editable : false, edittype:'text'},
	      {label: '사용여부', name:'use_yn_nm',index:'use_yn', align : 'center', width:80, sortable:false, editable : false, edittype:'text', formatter:jsUseYnFormmater},
	      {label: '사용여부', name:'use_yn',index:'use_yn', align : 'center', width:80, sortable:false, editable : false, edittype:'text', hidden: true},
	      {label: '파일ID', name:'file_id',index:'stock', align : 'center', width:60, sortable:false, editable : false, edittype:'text', hidden: true},
	      {label: '파일', name:'file_nm',index:'stock', align : 'center', width:60, sortable:false, editable : false, edittype:'text',formatter:formatFile},
	      {label: '원본파일명', name:'ori_file_nm',index:'stock', align : 'center', width:60, sortable:false, editable : false, edittype:'text', hidden: true}  
	    ],
		rowNum : -1,
		viewrecords : true,	
		height: "200px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		cellsubmit : 'clientArray',
		onCellSelect: function(rowid, index, contents, event)
		{
//			if(index == 1){
				viewRegFileLayer();
				var cel_file_id =  $('#file_list').jqGrid ('getRowData',rowid).file_id;
				var cel_file_nm = $('#file_list').jqGrid ('getRowData',rowid).ori_file_nm;
				var use_yn = $('#file_list').jqGrid ('getRowData',rowid).use_yn;
				
				if (use_yn =="Y") {
					$("#file_use_yes").attr("checked", true);
					$("#file_use_no").attr("checked", false);
				} else {
					$("#file_use_yes").attr("checked", false);
					$("#file_use_no").attr("checked", true);
				}
				
				$("#input_file_title").val(contents);
				$("#input_file_id").val(cel_file_id);
				$("#attached_file").val('');
				$("#del_file_btn").show();
				
				var file_download_html = '<div class="file_area" id="file_area1"><ul class="file_list"><li>'
										+'<a href="/commonfile/fileidDownLoad.do?file_id='+cel_file_id+'"  target="_blank" class="download" title="다운받기">'+cel_file_nm+'</a>'
										+'</li></ul></div>';				
				
				$("#file_area1").remove();
				$("#attach_file").after(file_download_html);
//			}
		},
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
	    },
		loadComplete : function(data) {
			showJqgridDataNon(data, "file_list",6);
		}
		
	});
	//jq grid 끝 	
});

//사용여부
function jsUseYnFormmater(cellvalue, options, rowObject) {
	var str = "";
	console.log(rowObject);
	if(rowObject.use_yn != null && rowObject.use_yn == "N"){
		str = "미사용";
	}else{
		str = "사용";
	}
	return str;
}
//jqgrid 파일 첨부 이미지 출력 format
function formatFile(cellvalue, options, rowObject){
	var str ="";
	var opt = rowObject[3]; 
	
	//이미지 추가
	  if( opt != "" ){                      
	   str += "<img src=\"/images/admin/icon/icon_file2.png\" />";   
	  }
	  return str;
}

// jq grid 데이터 갱신
function reloadFileList(){
	jQuery("#file_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectFileListUrl+'?group_id='+$('#group_id').val(),
		page : 1,
		postData : {
			region : $("#p_region").val(),
			use_yn : $("#p_use_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}

// 파일 목록 순서저장
function fileListReorder(){
	var updateRow = new Array();
	var saveCnt = 0;
	
	jQuery('#file_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#file_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("순서는 필수값입니다. 확인 후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].title="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("순서를 저장할 코드가 없습니다.");
		return;
	}
	
		
	$.ajax
	({
		type: "POST",
           url: fileListReorderUrl,
           data:{
        	   file_list : JSON.stringify(updateRow) 
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				reloadFileList();
			}	
		}
	});
}

function deleteFile(){
	$.ajax
	({
		type: "POST",
           url: deleteFileurl,
           data:{
        	   file_id : $('#input_file_id').val()
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				hideRegFileLayer();
				reloadFileList();
			}	
		}
	});
}

//파일 저장 ( 추가 / 수정 )
function saveFile(){
	
	var url;
	if($('#input_file_id').val() == ''){
		//등록 시, 마지막 row의 sort 값을 가져와서 +1  자동 설정 함.
		var last_row = $('#file_list').find(">tbody>tr.jqgrow:last");
		var selRowId = last_row.attr('id');
		var celValue = $('#file_list').jqGrid ('getCell', selRowId, 'sort');

		$('#input_file_sort').val(parseInt(celValue) + 1);
		if($('#input_file_sort').val() == 'NaN') $('#input_file_sort').val(1);
		
		url = insertFileurl;
	}else{
		url = updateFileurl;
	}
	
	// 데이터를 등록 처리해준다.
	$('#fileUploadFrm').ajaxSubmit({
		enctype: "multipart/form-data", 
		dataType: "json",
		url: url ,
		success: function(responseText, statusText){
			alert(responseText.message);
			hideRegFileLayer();
			if($('#group_id').val() == ''){
				$('#group_id').val(responseText.group_id);
				$('#file_group_id').val(responseText.group_id);
			}
			reloadFileList();
		},
		error: function(data){ 
		}
	});	
} 

// 파일 등록 페이지 보기
function viewRegFileLayer(){ 	
	$("#reg_file_layer").show();
	$("#file_area1").remove();
	$("#attached_file").val('');
	$("#input_file_title").val('');
	$("#input_file_id").val('');
	$("#del_file_btn").hide();
} 

//파일 등록 페이지 닫기
function hideRegFileLayer(){ 
	$('#reg_file_layer').hide();
}

// 소개페이지 리스트 조회
function intropageListPage() {
    
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/admin/intropage/intropageListPage.do";
    f.submit();
}

// 소개페이지 추가
function intropageInsert(){
	
	   oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

	   if($("#contents").val() == ""){
		     alert("내용을 입력해주십시요.");
		     return;
	   }
	   
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){
		   
		   url = insertIntropageUrl;
		   if($("#mode").val() == "E") url = updateIntropageUrl; 

		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						intropageListPage();
  					}	
  				},
  				dataType: "json", 				
  				url: url
  		    });	
		   
	   }
}

// 소개페이지 삭제
function intropageDelete(){
    
	   if(!confirm("소개페이지를 정말 삭제하시겠습니까?")) return;
	   
		$.ajax ({
			type : "POST",
			url : deleteIntropageUrl,
			data : {
	           	page_id : $("#page_id").val()
			},
			dataType : 'json',
			success : function(data) {
				alert(data.message);
				if(data.success == "true"){
					intropageListPage();
				}	
			}
		});
}

// 소개페이지 미리보기
function intropagePreview(){

	   oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

	   if($("#contents").val() == ""){
		     alert("내용을 입력해주십시요.");
		     return;
	   }

	   var args = 'scrollbars=no,toolbar=no,location=no,left='+$("#left").val()+',top='+$("#top").val()+',width='+$("#width").val()+',height='+$("#height").val();
	   openPopUp("about:blank", "Intropage_Preview", "700", "800"); 
       var f = document.writeFrm;  
       
       if ( $("#writeFrm").parsley().validate() ){
		   f.target = "Intropage_Preview";
		   f.action ="/admin/intropage/intropagePreview.do";
		   f.submit();
       }   
}

</script>

<!--// content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">${admin_g_submenu_nm}</h3>
		</div>
		<!--// main_title -->
		
		<jsp:include page="/WEB-INF/jsp/admin/integration/menuDescInclude.jsp"/>
		
	</div>
	
	<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
		<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
		<input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="page_id" name='page_id' value="${intropage.page_id}" />
		<input type='hidden' id="group_id" name='group_id' value="${intropage.group_id}" />
			    
		<!-- write_basic -->
		<div class="table_area">
			<table class="view">
				<caption>상세보기 화면</caption>
				<colgroup>
					<col style="width: 140px;" />
					<col style="width: *;" />
					<col style="width: 140px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				
				<c:if test="${param.mode == 'E' }">
				<tr>
					<th scope="row">등록자</th>
					<td>${intropage.reg_usernm}</td>
					<th scope="row">등록일</th>
					<td>${intropage.reg_date}</td>
				</tr>
				<tr>
					<th scope="row">콘텐츠 코드</th>
					<td colspan="3">
						${intropage.page_id}
					</td>
				</tr>
				</c:if>
				
				<tr>
					<th scope="row">콘텐츠명  <span class="asterisk">*</span></th>
					<td colspan="3">
						<input id="title" name="title" value="${intropage.title}" type="text" class="in_w100" placeholder="콘텐츠명" data-parsley-required="true" data-parsley-maxlength="100" />
						<label for="title">콘텐츠명</label>
					</td>
				</tr>					
				<tr>
					<th scope="row">공공저작물<br />사용여부</th>
					<td colspan="3">
						<input id="cpr_use_yes" name="cpr_use_yn" value="Y" type="radio" <c:if test="${intropage.cpr_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="cpr_use_yes">사용</label>
						<input id="cpr_use_no" name="cpr_use_yn" value="N" type="radio" class="marginl15" <c:if test="${intropage.cpr_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="cpr_use_no">미사용</label>
					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="2">공공저작물<br />유형선택</th>
					<td>
						<p class="bold marginb10">상업적 이용 표시를 허락하시겠습니까?</p>
						<input id="cpr_cmrc_use_yes" name="cpr_cmrc_use_yn" value="Y" type="radio" <c:if test="${intropage.cpr_cmrc_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="cpr_cmrc_use_yes">상업적, 비상업적 이용 가능</label>
						<input id="cpr_cmrc_use_no" name="cpr_cmrc_use_yn" value="N" type="radio" class="marginl15" <c:if test="${intropage.cpr_cmrc_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="cpr_cmrc_use_no">비상업적만 이용 가능</label>
					</td>
				</tr>
				<tr>
					<td>
						<p class="bold marginb10">변경을 허용하시겠습니까?</p>
						<input id="cpr_chngc_use_yes" name="cpr_chng_use_yn" value="Y" type="radio" <c:if test="${intropage.cpr_chng_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="cpr_chngc_use_yes">변형 등 2차적 저작물 작성이 가능</label>
						<input id="cpr_chngc_use_no" name="cpr_chng_use_yn" value="N" type="radio" class="marginl15" <c:if test="${intropage.cpr_chng_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="cpr_chngc_use_no">변형 등 2차적 저작물 작성 금지</label>
					</td>
				</tr>
				<tr>
					<th scope="row">만족도 사용여부</th>
					<td colspan="3">
                     		  <input id="satis_yes" name="satis_yn" value="Y" type="radio" <c:if test="${intropage.satis_yn == 'Y'}">checked="checked"</c:if>>  
                     		  <label for="title">사용</label>                      		  
                     		  <input id="satis_no" name="satis_yn" value="N"  type="radio" class="marginl15" <c:if test="${intropage.satis_yn == 'N'}">checked="checked"</c:if>>  
                     		  <label for="satis_no">미사용</label>
					</td>
				</tr>				
				<tr>
					<th scope="row">
						<label for="charge_info">담당정보</label>
					</th>
					<td colspan="3">
					    <input id="charge_info" name="charge_info" value="${intropage.charge_info}" type="text" class="in_w100" placeholder="담당정보" data-parsley-required="false" data-parsley-maxlength="1000" />						
					</td>
				</tr>
				<tr>
					<th scope="row">포탈 Meta Keyword</th>
					<td colspan="3">
                             <input id="meta_keyword" name="meta_keyword" value="${intropage.meta_keyword}" type="text" class="in_w100" placeholder="포탈 Meta Keyword" data-parsley-required="false" data-parsley-maxlength="1000" />
					</td>
				</tr>	
				<tr>
					<th scope="row" colspan="4">내용</th>
				</tr>
				</tbody>
			</table>
			
			<div class="editor_area view">
			     <textarea id="contents" name="contents" class="form-control" placeholder="내용" rows="20" style="width:100%;height:400px;" >${intropage.contents}</textarea>
			</div>
		</div>
		<!--// write_basic -->

	</form>
	
	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">첨부파일</h4>
	</div>
	<!--// title_area -->
	
	<div class="division20" style="padding: 20px; border: 1px solid #d2d2d2;" id="file_list_div" >
		<table id="file_list"></table>
	</div>
	
	<!-- button_area -->
	<div class="button_area margint20">
		<div class="float_right">
			<button type="button" class="btn acti" title="순서저장" onclick="fileListReorder();">
				<span>순서저장</span>
			</button>
			<button type="button" class="btn acti" title="등록" onclick="viewRegFileLayer();">
				<span>등록</span>
			</button>
		</div>
	</div>
	<!--// button_area -->	
		
	<form id="fileUploadFrm" name="fileUploadFrm" method="post" enctype="multipart/form-data">
	
		<input type="hidden" name="file_group_id" id="file_group_id" value="${intropage.group_id}" />
		<input type='hidden' id="file_page_id" name='file_page_id' value="${intropage.page_id}" />
		<input type="hidden" name="input_file_sort" id="input_file_sort" />
		
		<!-- table_area -->
		<div class="table_area" id="reg_file_layer">
		
			<table class="write">
				<caption>첨부파일 등록 화면</caption>
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">
							<label for="input_file_title">파일명<strong class="color_pointr">*</strong></label>
						</th>
						<td>
							<input type="hidden" name="input_file_id" id="input_file_id"/>
							<input type="text" id="input_file_title" name="input_file_title" class="in_wp300 marginr10" />
							<span class="color_pointo">* 20자 이하로 작성하세요</span>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="input_file_use_yn">사용여부<strong class="color_pointr">*</strong></label>
						</th>
						<td>
							<input id="file_use_yes" name="use_yn" value="Y" type="radio" <c:if test="${intropage.use_yn == 'Y'}">checked="checked"</c:if>>
							<label for="file_use_yes">사용</label>
							<input id="file_use_no" name="use_yn" value="N" type="radio" class="marginl15" <c:if test="${intropage.use_yn == 'N'}">checked="checked"</c:if>>
							<label for="file_use_no">미사용</label>
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td>
							<div id="attach_file">
								<div class="file_area">
									<label for="attached_file" class="hidden">파일 선택하기</label>
									<input id="attached_file" name="attached_file" type="file" class="in_wp400" />
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			
			<!-- button_area -->
			<div class="button_area">
				<div class="float_right">
					<button type="button" class="btn acti" title="저장" onclick="saveFile();">
						<span>저장</span>
					</button>
					<button type="button" id="del_file_btn" class="btn acti" title="삭제" onclick="deleteFile();">
						<span>삭제</span>
					</button>
					<button type="button" class="btn acti" title="목록" onclick="hideRegFileLayer();">
						<span>목록</span>
					</button>
				</div>
			</div>
			
		</div>
	</form>

			
	<!-- button_area -->
	<div class="button_area">
	
		<div class="float_right">

			<c:if test="${param.mode == 'W' }">
			<a href="javascript:intropageInsert('W');" class="btn save" title="저장">
				<span>저장</span>
			</a>
			</c:if>
			
			<c:if test="${param.mode == 'E' }">
			<a href="javascript:intropageInsert('M');" class="btn save" title="수정">
				<span>수정</span>
			</a>
			
			<a href="javascript:intropageDelete();" class="btn save" title="삭제">
				<span>삭제</span>
			</a>
			</c:if>
			
			<a href="javascript:intropageListPage();" class="btn cancel" title="취소">
				<span>취소</span>
			</a>
			
		</div>
	</div>
	<!--// button_area -->
		
</div>
<!--// content -->

<script language="javascript">
	
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "contents",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=contents' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
    }, 
    fCreator: "createSEditor2"
});

</script>