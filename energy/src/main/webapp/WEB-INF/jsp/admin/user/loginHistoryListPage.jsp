<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectLoginHistoryUrl = "<c:url value='/admin/user/loginHistoryList.do'/>";

$(document).ready(function(){
	
	$('.datepicker').each(function(){
	    $(this).datepicker({
			  format: "yyyy-mm-dd",
			  language: "kr",
			  keyboardNavigation: false,
			  forceParse: false,
			  autoclose: true,
			  todayHighlight: true,
			  showOn: "button",
			  buttonImage:"/images/admin/icon/icon_calendar.png",
			  buttonImageOnly:true,
			  changeMonth: true,
	          changeYear: true,
	          showButtonPanel:false
			 });
	});	
	
	$('#loginHistory_list').jqGrid({
		datatype: 'json',
		url: selectLoginHistoryUrl,
		mtype: 'POST',
		colModel: [
			//{ label: '번호', index: 'rownum', name: 'rownum', width: 30, align : 'center', sortable:false},
			{ label: '아이디', index: 'user_id', name: 'user_id', align : 'center', width:40, sortable:false},
			{ label: '이름', index: 'user_nm', name: 'user_nm', align : 'center', width:40, sortable:false},
			{ label: '아이피', index: 'ip', name: 'ip', align : 'center', width:60, sortable:false },
			{ label: '로그인여부', index: 'access_yn', name: 'access_yn', align : 'center', width:40, sortable:false },
			{ label: '시스템', index: 'system', name: 'system', align : 'center', width:40, sortable:false },
			{ label: '로그인일시', index: 'login_date', name: 'login_date', width: 40, align : 'center', sortable:false }
		],
		postData :{	
			p_conn_stadt : $("#p_conn_stadt").val(),
			p_conn_enddt : $("#p_conn_enddt").val(),
			p_user_id : $("#p_user_id").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#loginHistory_pager',
		viewrecords : true,
		sortname : "reg_date",
		sortorder : "desc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#loginHistory_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "loginHistory_list");
		   return 'stop';
		},   
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			
			showJqgridDataNon(data, "loginHistory_list",6);

		}
	});
	//jq grid 끝 
	
	jQuery("#loginHistory_list").jqGrid('navGrid', '#loginHistory_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("loginHistory_list", "loginHistory_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:supportreqWrite('"+rowObject.req_id+"')\">"+cellvalue+"</a>";
	
	return str;
}

function search() {
	jQuery("#loginHistory_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectLoginHistoryUrl,
		page : 1,
		postData : {
			p_conn_stadt : $("#p_conn_stadt").val(),
			p_conn_enddt : $("#p_conn_enddt").val(),
			p_user_id : $("#p_user_id").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function supportreqWrite(reqId) {
    var f = document.listFrm;
    var mode = "W";
    if(reqId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#req_id").val(reqId);
	
    f.action = supportreqWriteUrl;
    f.submit();
  
}

function loginHistoryExcelDown(){
	var f = document.listFrm;
	f.action = "/admin/user/loginHistoryListExcel.do";
	f.submit();
}

function formReset(){
	var today = getCurrentDate();
	
	$("#p_conn_stadt").val(today);
	$("#p_conn_enddt").val(today);
	$("#p_user_id").val('');
}

function getCurrentDate(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1;
	var yyyy = today.getFullYear();

	if(dd < 10) {
	    dd = '0' + dd
	} 

	if(mm < 10) {
	    mm = '0' + mm
	} 

	return yyyy + '-' + mm + '-' + dd;
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
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="req_id" name='req_id' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="p_administ_cd" name='p_administ_cd' value="${param.p_administ_cd}" />
	
	<!-- search_area -->
	<div class="search_area">
		 <table class="search_box">
			<caption>로그인 이력 검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 35%;" />
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>검색기간</th>
				<td>
	                <input type="text" id="p_conn_stadt" name="p_conn_stadt" class="in_wp100 datepicker" readonly value="${curdate}"> ~ 
	                <input type="text" id="p_conn_enddt" name="p_conn_enddt" class="in_wp100 datepicker" readonly value="${curdate}">              
				</td>
				<th>아이디</th>
				<td>
                    <input type="text" id="p_user_id" name="p_user_id" class="in_wp200" value="${userid}">
				</td>
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
			<a href="javascript:loginHistoryExcelDown()" class="btn acti" title="엑셀다운">
				<span>엑셀다운</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="loginHistory_list_div" >
	    <table id="loginHistory_list"></table>
        <div id="loginHistory_pager"></div>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>
