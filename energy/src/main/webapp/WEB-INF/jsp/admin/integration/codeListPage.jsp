<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var selectCodeListUrl = "<c:url value='/admin/code/codeList.do'/>";
var codeWriteUrl =  "<c:url value='/admin/code/codeWrite.do'/>";
var insertCodeUrl = "<c:url value='/admin/code/insertCode.do'/>";
var updateCodeUrl = "<c:url value='/admin/code/updateCode.do'/>"
var deleteCodeUrl = "<c:url value='/admin/code/deleteCode.do'/>";
var codeReorderUrl = "<c:url value='/admin/code/updateCodeReorder.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#modal-code-write').popup();
	
	$('#code_list').jqGrid({
		datatype: 'json',
		url: selectCodeListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '순서', index: 'sort', name: 'sort', width: 50, align : 'center', editable : true, sortable:false,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '코드', index: 'code', name: 'code', width: 80, align : 'center', sortable:false },
			{ label: '코드명', index: 'code_nm', name: 'code_nm', align : 'left', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			{ label: '설명', index: 'code_desc', name: 'code_desc', align : 'left', sortable:false, width:200},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', align : 'center', width:40, sortable:false, formatter:jsUseynLinkFormmater},
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 100, align : 'center', sortable:false },
		],
		postData :{	
			gubun : $("#gubun").val(),
			code_nm : $("#p_code_nm").val()
		   },
		rowNum : -1,
		viewrecords : true,
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
	    },
		loadComplete : function(data) {
			showJqgridDataNon(data, "code_list",6);
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("code_list", "code_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:codeWrite('"+rowObject.code+"')\">"+rowObject.code_nm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {
		
	jQuery("#code_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectCodeListUrl,
		page : 1,
		postData : {
			code_nm : $("#p_code_nm").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function codeWrite(code) {
    var f = document.listFrm;
    var mode = "W";
    if(code != "") mode = "E";                
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: codeWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   gubun : $("#gubun").val(),
  		   gubun_nm : $("#gubun_nm").val(),
  		   code : code
		},
        success: function(data) {
        	$('#pop_content').html(data);
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}

function codeInsert(){
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertCodeUrl;
		   if($("#mode").val() == "E") url = updateCodeUrl; 
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						search();
  						popupClose();
  					}	
  				},
  				dataType: "json",
  				data : {
  					gubun : $("#gubun").val()
  				},
  				url: url
  		    });	
		   
	   }
}

function codeDelete(){
	   if(!confirm("정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteCodeUrl,
	           data:{
	           	gubun : $("#gubun").val(),
	           	code : $("#code").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					search();
					popupClose();
				}	
			}
		});
}

function codeReorder(){
	var updateRow = new Array();
	var saveCnt = 0;
	
	jQuery('#code_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#code_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("순서는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].code_nm="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("순서를 저장할 코드가 없습니다.");
		return;
	}
		
	$.ajax
	({
		type: "POST",
           url: codeReorderUrl,
           data:{
           	gubun : $("#gubun").val(),
            code_list : JSON.stringify(updateRow) 
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search();
			}	
		}
	});
}

function formReset(){
	$("#p_code_nm").val("");
}

function popupShow(){
	$('#modal-code-write').popup('show');
}

function popupClose(){
	$('#modal-code-write').popup('hide');
}

function codegubunListPage(){
    var f = document.listFrm;
   
    f.target = "_self";
    f.action = "/admin/code/codegubunListPage.do";
    f.submit();
}

</script>

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
	
	<form id="listFrm" name="listFrm" method="post">
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="gubun" name='gubun' value="${codegubun.gubun}" />
		<input type='hidden' id="gubun_nm" name='gubun_nm' value="${codegubun.gubun_nm}" />
		<input type='hidden' id="p_gubun_nm" name='p_gubun_nm' value="${param.p_gubun_nm}" />
		<input type='hidden' id="p_use_yn" name='p_use_yn' value="${param.p_use_yn}" />
		<input type='hidden' id="mode" name='mode' value="W" />

		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box" border=1">
				<caption>코드검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 20%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>코드명</th>
					<td>
	                     <input type="input" class="form-control input-sm" id="p_code_nm" name="p_code_nm" value="${param.p_code_nm}" placeholder="코드명"  />
					</td>
					<td></td>
				</tr>
				</tbody>
			</table>
			<div class="search_area_btnarea">
				<a href="javascript:search();" class="btn sch" title="조회">
					<span>조회</span>
				</a>
				<a href="javascript:formReset();" class="btn clear" title="초기화">
					<span>초기화</span>
				</a>
			</div>
		</div>
		<!--// search_area -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
		    <div class="float_left">
		         <h5>코드구분ID : ${codegubun.gubun},  코드구분명 : ${codegubun.gubun_nm}</h5>
		    </div>
			<div class="float_right">
				<a href="javascript:codeReorder()" class="btn acti" title="순서저장">
					<span>순서저장</span>
				</a>
				<a href="javascript:codeWrite('')" class="btn acti" title="코드등록">
					<span>코드등록</span>
				</a>
				<a href="javascript:codegubunListPage()" class="btn acti" title="코드구분목록">
					<span>코드구분목록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
	
		<!-- table 1dan list -->
		<div class="table_area" id="code_list_div" >
		    <table id="code_list"></table>
		</div>
		<!--// table 1dan list -->
		
	</form>
	
</div>
<!--// content -->

<div id="modal-code-write" style="width:600px;background-color:white">

	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
			<header>
				<h1 class="pop_title">코드 등록</h1>
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
					</div>    
				</div>
			</article>	
		</div>
		<!-- //container -->
			
	</div>
</div>
	 		