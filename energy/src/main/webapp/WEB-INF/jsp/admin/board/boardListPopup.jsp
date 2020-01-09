<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var selectBoardSearchListUrl = "<c:url value='/admin/board/boardSearchList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#board_list').jqGrid({
		datatype: 'json',
		url: selectBoardSearchListUrl,
		mtype: 'POST',
		colModel: [
	            { label: '선택', index: 'sel_box', name: 'sel_box', width: 40, align : 'center', sortable:false,formatter:jsRadioFormmater},      
				{ label: '제목', index: 'title', name: 'title', width: 200, align : 'left',sortable:false },
				{ label: '타입', index: 'board_type_nm', name: 'board_type_nm', width: 120, align : 'center',sortable:false },
				{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', align : 'center', width:80,sortable:false},
				{ label: '등록일', index: 'reg_date2', name: 'reg_date2', align : 'center', width:100,sortable:false},
				{ label: 'board_id', index: 'board_id', name: 'board_id', hidden:true}
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
			showJqgridDataNon(data, "board_list",4);
		}
	});
	//jq grid 끝 

});

function jsRadioFormmater(cellvalue, options, rowObject){
	return '<input type="radio" id="chk_board_id" name="chk_board_id" value="'+options.rowId+'")/>';
}

function selBoard(){
	var idx = $(':radio[name="chk_board_id"]:checked').val();
	if(idx == undefined) {
		alert("게시판을 선택해 주십시요.");
		return;
	}
	var ret = jQuery("#board_list").jqGrid('getRowData',idx);
	$("#board").val(ret.board_id);
	$("#board_nm").html(ret.title);
	popupSearchClose();
}

</script>

	<!-- tabel_search_area -->
	<div class="table_search_area" style="margin-top:20px">
		<div class="float_right">
			<a href="javascript:selBoard();" class="btn acti" title="선택" style="margin-right:20px;">
				<span>선택</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<div class="table_area" id="board_list_div" >
	    <table id="board_list"></table>
	</div>
