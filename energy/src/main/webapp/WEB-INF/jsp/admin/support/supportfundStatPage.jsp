<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectSupportfundStatListUrl = "<c:url value='/admin/support/supportfundStatList.do'/>";
var insertSupportfundStatUrl = "<c:url value='/admin/support/insertSupportfundStat.do'/>";
var deleteSupportfundStatUrl = "<c:url value='/admin/support/deleteSupportfundStat.do'/>";

$(document).ready(function(){
 	
	$('#supportfund_list').jqGrid({
		datatype: 'json',
		url: selectSupportfundStatListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '년도', index: 'year', name: 'year', width: 50, sortable:false,align : 'center', formatter:jsSelectFormmater},
			{ label: '후원금액(원)', index: 'amt', name: 'amt', sortable:false,align : 'center', width:50, formatter:jsAmtFormmater},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', width: 30, sortable:false,align : 'center', formatter:jsUseYnFormmater},
			{ label: '삭제', index: 'delete', name: 'delete', width: 20, align : 'center', sortable:false , formatter:jsBtnLinkFormmater },
			{ label: 'fund_id', index: 'fund_id', name: 'fund_id', hidden:true }
		],
		rowNum : -1,
		viewrecords : true,
		height:"600px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
	    }, 
		loadComplete : function(data) {
			showJqgridDataNon(data, "supportfund_list",4);
			$(".onlynum").keyup( setNumberOnly );
		}
	});
	//jq grid 끝 

	bindWindowJqGridResize("supportfund_list", "supportfund_list_div");

});

function search() {
		
	jQuery("#supportfund_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectSupportfundStatListUrl,
		postData : {
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}

function jsSelectFormmater(cellvalue, options, rowObject) {
	var str = "";
	
	str +="<select name='year' class='in_wp100'>";
    <c:forEach begin="0" end="10" var="idx" step="1">
    str +="<option value='${curYear-idx}'"+(cellvalue=='${curYear-idx}'?"selected":"")+" >${curYear-idx}</option>";
    </c:forEach>
	str +="</select>";
	
	return str;
}

function jsBtnLinkFormmater(cellvalue, options, rowObject) {
	var str = "";
	
	str ="<a href=\"javascript:deleteSupportfund('"+options.rowId+"')\" class=\"btn look\" title=\"삭제\"><span>삭제</span></a>";

	return str;
}

function jsAmtFormmater(cellvalue, options, rowObject) {
	var str = "";
	str +="<input type='hidden' name='fund_id' value='"+rowObject.fund_id+"' />";
	str +="<input type='hidden' name='row_id' value='"+options.rowId+"' />";
	str +="<input type='text' name='amt' class='in_wp100 onlynum' value='"+cellvalue+"' />";

	return str;
}

function jsUseYnFormmater(cellvalue, options, rowObject) {
	var str = "";
	str +="<input type='radio' name='use_yn"+options.rowId+"' value='Y' "+(cellvalue=='Y'?"checked":"")+" /> 사용 ";
	str +="<input type='radio' name='use_yn"+options.rowId+"' value='N' "+(cellvalue=='N'?"checked":"")+" /> 미사용";

	return str;
}

function insertSupportfund() {
    var yearDupCheck = true;
    var yearMap = new Map();
    var amtArr = $('input[name=amt]');
    var idx = 0;

    $('select[name=year]').each(function(){
	    if(yearMap.containsKey(this.value)){
	    	alert("중복된 년도가 있습니다.");
	    	dupcheck = false;
	    	return;
	    }
	    yearMap.put(this.value,"");
	    if(amtArr[idx].value == "") amtArr[idx].value =0; 
	});
	
    $("#listFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			if(responseText.success =="true"){
				search();	
		    }
		},
		dataType: "json",
		url: insertSupportfundStatUrl
    }); 

}

function insertRow(){
	//새로운 행에 넣어줄 임시 데이터
    var tmpData = {
			fund_id:""
		    ,year : "${curYear}"	
		    ,amt:"0"
			,use_yn:"Y"
    };
    var newRowid = makeNewRowId(jQuery('#supportfund_list').jqGrid('getDataIDs'));
    var su=jQuery("#supportfund_list").jqGrid('addRowData',newRowid ,tmpData,"first");
    $(".onlynum").keyup( setNumberOnly );
}

function makeNewRowId(rowids){ //그리드 rowid배열을 파라메터로 받는다
	   var max = 0;
	   for(var i=0; i<rowids.length; i++){
	      if(max <= eval(rowids[i])){
	         max = eval(rowids[i]);
	      }
	   }
	   return eval(max) + 1;
}

function deleteSupportfund(id){
	var ret = jQuery("#supportfund_list").jqGrid('getRowData',id);		//선택한 열의 데이터를 갖고온디
	
	if(!confirm("정말 삭제하시겠습니까?")) return;
	
	if(ret.fund_id != ""){
		$.ajax
		({
			type: "POST",
             	url: deleteSupportfundStatUrl,
             	data:{
             		fund_id : ret.fund_id					
             	},
				success:function(data, dataType){					
					alert(data.message);					
					if(data.success == "true"){
						search();         
					}
				}
		});
	}else{
		jQuery("#supportfund_list").jqGrid('delRowData',id);
		alert("삭제 되었습니다.");
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
	
	<form id="listFrm" name="listFrm" method="post">
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:insertRow()" class="btn acti" title="년도추가">
					<span>년도추가</span>
				</a>
				<a href="javascript:insertSupportfund()" class="btn acti" title="저장">
					<span>저장</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<!-- table 1dan list -->
		<div class="table_area" id="supportfund_list_div" >
		    <table id="supportfund_list"></table>
		</div>
		<!--// table 1dan list -->
		
</div>
<!--// content -->
	 		