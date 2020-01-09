<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var selectUserUrl = "<c:url value='/admin/user/userPageList.do'/>";
var userWriteUrl =  "<c:url value='/admin/user/userWrite.do'/>";
var updatePasswordChangeUrl = "<c:url value='/admin/user/updatePasswordChange.do'/>";

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
		
	$('#user_list').jqGrid({
		datatype: 'json',
		url: selectUserUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 20, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', align : 'center', width:40, sortable:false},
			{ label: '이름', index: 'user_nm', name: 'user_nm', align : 'left', width:40, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '생년월일', index: 'birth', name: 'birth', width: 40, align : 'center', sortable:false},
			{ label: '휴대전화', index: 'user_mobile', name: 'user_mobile', width: 60, align : 'center', sortable:false},
			{ label: '이메일', index: 'user_email', name: 'user_email', width: 80, align : 'left', sortable:false},
			{ label: '가입일', index: 'reg_date', name: 'reg_date', width: 60, align : 'center', sortable:false },
			{ label: '비밀번호초기화', index: 'pwd_init', name: 'pwd_init', width: 80, align : 'center', sortable:false,formatter:jsBtnFormmater },
			{ label: 'user_id', index: 'user_id', name: 'user_id', width: 80, align : 'center', hidden:true }
		],
		postData :{	
			user_gb : "N",
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			reg_stadt : $("#p_reg_stadt").val(),
			reg_enddt : $("#p_reg_enddt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#user_pager',
		viewrecords : true,
		sortname : "user_nm",
		sortorder : "asc",
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
			var ret = jQuery("#user_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "user_list");
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
			showJqgridDataNon(data, "user_list",8);
		}
	});
	//jq grid 끝 
	
	jQuery("#user_list").jqGrid('navGrid', '#user_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("user_list", "user_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:userWrite('"+rowObject.user_no+"')\">"+rowObject.user_nm+"</a>";
	return str;
}

function jsBtnFormmater(cellvalue, options, rowObject) {
	var str = "";
 	str ="<a href=\"javascript:pwdInit('"+rowObject.user_no+"')\" class=\"btn look\" title=\"비밀번호초기화\"><span>비밀번호초기화</span></a>";
	return str;
}

function search() {
		
	jQuery("#user_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectUserUrl,
		page : 1,
		postData : {
			user_gb : "N",
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			reg_stadt : $("#p_reg_stadt").val(),
			reg_enddt : $("#p_reg_enddt").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function userWrite(userNo) {
    var f = document.listFrm;
    var mode = "W";
    if(userNo != "") mode = "E";
    
	$('#contentsArea').html("");
	
	$("#mode").val(mode);
	$("#user_no").val(userNo);
	
    f.action = userWriteUrl;
    f.submit();
}

function formReset(){
	$("#p_reg_stadt").val("");
	$("#p_reg_enddt").val("");
	$("#p_searchtxt").val("");
}

function pwdInit(userNo){
	   if(!confirm("회원의 비밀번호를 정말 초기화하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: updatePasswordChangeUrl,
	           data:{
	           	user_no : userNo
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
			}
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
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="user_no" name='user_no' value="" />
		<input type='hidden' id="mode" name='mode' value="W" />
		
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>팝업검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 50%;" />
					<col style="width: 40%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>가입기간</th>
					<td>
							<input type="text" id="p_reg_stadt" name="p_reg_stadt" class="in_wp100 datepicker" readonly value="${param.p_reg_stadt}">
							<span>~</span>
							<input type="text" id="p_reg_enddt" name="p_reg_enddt" class="in_wp100 datepicker" readonly value="${param.p_reg_enddt}">
					</td>
					<td></td>
				</tr>
	            <tr>
					<th>검색구분</th>
					<td>
		 				  <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
		                       <option value="user_nm" >이름</option>
		                       <option value="user_id" >아이디</option>
		                       <option value="user_mobile" >휴대전화</option>
		                       <option value="user_email" >이메일</option>
		                  </select>
		                  <label for="input_text" class="hidden">검색어 입력</label>
		                   <input type="input" id="p_searchtxt" name="p_searchtxt" value="${param.p_searchtxt}"  placeholder="검색어" class="in_w70">                      
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

		<!-- table 1dan list -->
		<div class="table_area" id="user_list_div" >
		    <table id="user_list"></table>
	        <div id="user_pager"></div>
		</div>
		<!--// table 1dan list -->
		
</div>
<!--// content -->

<script language="javascript">
	$('#datepicker_reg_stadt').datepicker({
		  format: "yyyy-mm-dd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true
		 });
	
	$('#datepicker_reg_enddt').datepicker({
		  format: "yyyy-mm-dd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true
		 });

</script>
