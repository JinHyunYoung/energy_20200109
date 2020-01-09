
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%@ page import="kr.or.wabis.framework.util.SystemUtil"%> 

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">

var selectExcelListUrl = "<c:url value='/admin/stats/statsExcelUploadListPage.do'/>";
	
$(document).ready(function(){

	$('#excel_list').jqGrid({
		datatype: 'json',
		url: selectExcelListUrl,
		mtype: 'post',
		colModel: [		
		 			{ label: '발행년도', index: 'issue_yy', name: 'issue_yy', width: 50, align : 'center', sortable:false},
					{ label: '기준년도', index: 'bs_yy', name: 'bs_yy', align : 'center', width:50, sortable:false},
					{ label: '엑셀다운로드', index: 'research_file_id', name: 'research_file_id', align : 'center', width:100, sortable:false, formatter:jsBtn01Formatter},
					{ label: '삭제', index: 'research_delete', name: 'research_delete', align : 'center', width:100, sortable:false, formatter:jsBtn02Formatter},
					{ label: 'research_group_id', index: 'research_group_id', name: 'research_group_id', align : 'center', width:100, sortable:false, hidden:true},
					{ label: '등록일', index: 'research_reg_date', name: 'research_reg_date', align : 'center', width:100, sortable:false},
					{ label: '엑셀다운로드', index: 'person_file_id', name: 'person_file_id', width: 100, align : 'center', sortable:false, formatter:jsBtn03Formatter},
					{ label: '등록일', index: 'person_reg_date', name: 'person_reg_date', width: 100, align : 'center', sortable:false},
					{ label: '삭제', index: 'person_delete', name: 'person_delete', align : 'center', width:100, sortable:false, formatter:jsBtn04Formatter},
					{ label: 'person_group_id', index: 'person_group_id', name: 'person_group_id', align : 'center', width:100, sortable:false, hidden:true},
				],
		postData :{	
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#excel_pager',
		viewrecords : true,
		sortname : "sort",
		sortorder : "desc",
		height : "350px",
		viewrecords : true,
		gridview : true,
		autowidth : true,
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		loadComplete : function(data) {
			showJqgridDataNon(data, "excel_list", 9);
		}
	});
	//jq grid 끝

	// jQgrid Header Setting
	$("#excel_list").jqGrid('setGroupHeaders', {
		useColSpanStyle : true,
		groupHeaders : [
		                {startColumnName: 'research_file_id', numberOfColumns:4, titleText: '통계조사결과'},
		                {startColumnName: 'person_file_id', numberOfColumns:4, titleText: '모집단명부'}
		]
	
	});
	
	bindWindowJqGridResize("excel_list", "excel_list_div");

});

//jq grid 데이터 갱신
function reloadFileList(){
	jQuery("#excel_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectExcelListUrl,
		page : 1,
		postData : {
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}

function excelUploadResearch(){
	    var f = document.listFrm;
	    f.action = '/admin/stats/statsResearchUpload.do';
	    f.submit();
}

function excelUploadPerson(){
    var f = document.listFrm;
    f.action = '/admin/stats/statsPersonUpload.do';
    f.submit();
}

// 엑셀다운로드
function jsBtn01Formatter(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.research_file_id != null && rowObject.research_file_id != ""){
		str ="   <a class=\"btn look\" title=\"엑셀다운로드\" href=\"/commonfile/fileidDownLoad.do?file_id="+rowObject.research_file_id+"\"'>엑셀다운로드</a>  ";
	}
	return str;
}

//삭제
function jsBtn02Formatter(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.research_file_id != null && rowObject.research_file_id != ""){
		str ='   <a class="btn look" title="삭제" href="javascript:excelDelete(\''+rowObject.bs_yy+'\',\'1' +'\',\''+rowObject.research_group_id+'\');">삭제</a>  ';
	}
	return str;
}

//엑셀다운로드
function jsBtn03Formatter(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.person_file_id != null && rowObject.person_file_id != ""){
		str ="   <a class=\"btn look\" title=\"엑셀다운로드\" href=\"/commonfile/fileidDownLoad.do?file_id="+rowObject.person_file_id+"\"'>엑셀다운로드</a>  ";
	}
	return str;
}

//삭제
function jsBtn04Formatter(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.person_file_id != null && rowObject.person_file_id != ""){
		str ='   <a class="btn look" title="삭제" href="javascript:excelDelete(\''+rowObject.bs_yy+'\',\'2' +'\',\''+rowObject.person_group_id+'\');">삭제</a>  ';
	}
	return str;
}

//업로드한 엑셀을 삭제
function excelDelete( _bs_yy, _xls_tp, _group_id){
	var title = _bs_yy +'년도 통계조사결과 ';
	var deleteUrl="/admin/stats/deleteExcelUpload.do";

	if (_xls_tp=="2") {
		title =  _bs_yy +'년도 모집단명부 ';
		deleteUrl = "/admin/stats/deleteExcelUpload.do";
	}
	
	if (confirm("엑셀 파일을 삭제하시겠습니까?")) {
	    $.ajax({
	        url: deleteUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	        	bs_yy : _bs_yy,
	        	xls_tp : _xls_tp,
	        	group_id : _group_id
	        	
	        },           
	        success: function(data) {
	        	reloadFileList();
	        },
	        error: function(e) {
	            alert( '데이터를 가져오는데 실패했습니다.' );
	        }
	    });
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
	<!--// title_and_info_area -->
	
	<form id="listFrm" name="listFrm" method="post">
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="bs_yy" name='bs_yy' value="" />
	
	<!--// search_area -->
	</form>
	
	<!-- table 1dan list -->
	<div class="table_area" id="excel_list_div" >
	    <table id="excel_list"></table>
        <div id="excel_pager" style="display: none;"></div>
	</div>
	<!--// table 1dan list -->
	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<a href="javascript:excelUploadResearch()" class="btn acti" title="통계조사결과 일괄등록">
				<span>통계조사결과 일괄등록</span>
			</a>
			<a href="javascript:excelUploadPerson()" class="btn acti" title="모집단 명부 일괄등록">
				<span>모집단 명부 일괄등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->	
</div>
