<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectSupportbusiStatListUrl = "<c:url value='/admin/support/supportbusiStatList.do'/>";
var insertSupportbusiStatUrl = "<c:url value='/admin/support/insertSupportbusiStat.do'/>";
$(document).ready(function(){
    
	$('#supportbusi_list').jqGrid({
		datatype: 'json',
		url: selectSupportbusiStatListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '지역', index: 'region_nm', name: 'region_nm', width: 50, sortable:false,align : 'center'},
			{ label: '지원금액(원)', index: 'amt', name: 'amt', sortable:false,align : 'center', width:50, formatter:jsAmtFormmater},
			{ label: '가구수(건)', index: 'house_num', name: 'house_num', width: 50, sortable:false,align : 'center',formatter:jsHouseNumFormmater}
		],
		postData :{	
			p_year : $("#p_year").val()
		},
		rowNum : -1,
		height:"100%",
		viewrecords : true,
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
			showJqgridDataNon(data, "supportbusi_list",3);
			$(".onlynum").keyup( setNumberOnly );
		}
	});
	//jq grid 끝 

	bindWindowJqGridResize("supportbusi_list", "supportbusi_list_div");

});

function jsAmtFormmater(cellvalue, options, rowObject) {
	var str = "";

	str +="<input type='hidden' name='region_cd' value='"+rowObject.region_cd+"' />";
	str +="<input type='text' name='amt' class='in_wp100 onlynum' value='"+cellvalue+"' />";

	return str;
}

function jsHouseNumFormmater(cellvalue, options, rowObject) {
	var str = "";
	
	str +="<input type='text' name='house_num' class='in_wp100 onlynum' value='"+cellvalue+"' />";

	return str;
}

function search() {
		
	jQuery("#supportbusi_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectSupportbusiStatListUrl,
		postData : {
			p_year : $("#p_year").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}

function insertSupportbusi() {
    var amtArr = $('input[name=amt]');
    var idx = 0;
    $('input[name=house_num]').each(function(){
	    if(this.value == "") this.value = "0";
    	if(amtArr[idx].value == "") amtArr[idx].value = 0; 
	});
	
    $("#listFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			if(responseText.success =="true"){
		}
		},
		dataType: "json",
		url: insertSupportbusiStatUrl
	});   
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
	
		<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>팝업검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>년도</th>
					<td>
					  <select id="p_year" name="p_year" class="form-control input-sm" onChange="search()">
	                     <c:forEach begin="0" end="10" var="idx" step="1">
	                     	 <option value="${curYear-idx}" >${curYear-idx}</option>
	                     </c:forEach>
	                  </select>
	                </td>
					<td></td>
				</tr>
				</tbody>
			</table>

		</div>
		<!--// search_area -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:insertSupportbusi()" class="btn acti" title="저장">
					<span>저장</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<!-- table 1dan list -->
		<div class="table_area" id="supportbusi_list_div" >
		    <table id="supportbusi_list"></table>
		</div>
		<!--// table 1dan list -->
		
</div>
<!--// content -->
	 		