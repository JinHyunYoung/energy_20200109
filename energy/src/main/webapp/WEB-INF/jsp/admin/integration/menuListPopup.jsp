<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">

var selectMenuSearchListUrl = "<c:url value='/admin/menu/menuSearchList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#menu_list').jqGrid({
		datatype: 'json',
		url: selectMenuSearchListUrl,
		mtype: 'POST',
		colModel: [
	            { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},      
				{ label: '메뉴코드', index: 'menu_id', name: 'menu_id', width: 150, align : 'center',sortable:false },
				{ label: '메뉴명', index: 'menu_nm', name: 'menu_nm', align : 'left', width:270,sortable:false},
				{ label: '형태', index: 'menu_type_nm', name: 'menu_type_nm', align : 'center', width:100,sortable:false}
		],
		postData :{	
			homepage :"${param.homepage}"
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
			showJqgridDataNon(data, "menu_list",4);
		}
	});
	//jq grid 끝 

});

function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_menu_id" name="chk_menu_id" value="'+options.rowId+'")/>';
}

function selMenu(){
	var idx = $(':radio[name="chk_menu_id"]:checked').val();
	if(idx == undefined) {
		alert("메뉴를 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#menu_list").jqGrid('getRowData',idx);
	$("#ref_menu").val(ret.menu_id);
	$("#ref_menu_nm").html(ret.menu_nm);
	popupSearchClose();
}

</script>


		<!-- tabel_search_area -->
		<div class="table_search_area" style="margin-top:20px">
			<div class="float_right">
				<a href="javascript:selMenu();" class="btn acti" title="선택" style="margin-right:20px;">
					<span>선택</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<div class="table_area" id="menu_list_div" >
		    <table id="menu_list"></table>
		</div>
