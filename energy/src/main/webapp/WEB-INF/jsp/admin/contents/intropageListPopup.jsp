<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var selectIntropageSearchListUrl = "<c:url value='/admin/intropage/intropageSearchList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectIntropageSearchListUrl,
		mtype: 'POST',
		colModel: [
	            { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},      
				{ label: '제목', index: 'title', name: 'title', width: 320, align : 'left',sortable:false },
				{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', align : 'center', width:80,sortable:false},
				{ label: '등록일', index: 'reg_date', name: 'reg_date', align : 'center', width:100,sortable:false},
				{ label: 'page_id', index: 'page_id', name: 'page_id', hidden:true}
		],
		postData :{	
		
		},
		viewrecords : true,
		height : "580px",
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
			showJqgridDataNon(data, "intropage_list",4);
		}
	});
	//jq grid 끝 

});

function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_intropage_id" name="chk_intropage_id" value="'+options.rowId+'")/>';
}

function selIntropage(){
	var idx = $(':radio[name="chk_intropage_id"]:checked').val();
	if(idx == undefined) {
		alert("콘텐츠를 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#intropage_list").jqGrid('getRowData',idx);
	$("#contents").val(ret.page_id);
	$("#contents_nm").html(ret.title);
	popupSearchClose();
}

</script>

<!-- tabel_search_area -->
<div class="table_search_area" style="margin-top:20px">
	<div class="float_right">
		<a href="javascript:selIntropage();" class="btn acti" title="선택" style="margin-right:20px;">
			<span>선택</span>
		</a>
	</div>
</div>
<!--// tabel_search_area -->

<div class="table_area" id="intropage_list_div" >
    <table id="intropage_list"></table>
</div>
