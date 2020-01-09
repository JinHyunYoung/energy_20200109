<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var selectAuthPageListUrl = "<c:url value='/admin/auth/authPageList.do'/>";
var authWriteUrl =  "<c:url value='/admin/auth/authWrite.do'/>";
var insertAuthUrl = "<c:url value='/admin/auth/insertAuth.do'/>";
var updateAuthUrl = "<c:url value='/admin/auth/updateAuth.do'/>"
var deleteAuthUrl = "<c:url value='/admin/auth/deleteAuth.do'/>";
var authReorderUrl = "<c:url value='/admin/auth/updateAuthReorder.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#modal-auth-write').popup();
	
	$('#auth_list').jqGrid({
		datatype: 'json',
		url: selectAuthPageListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 40, align : 'center', sortable:false },
			{ label: '권한그룹', index: 'grp_nm', name: 'grp_nm', align : 'left', sortable:false, width:60},
			{ label: '권한코드', index: 'auth_id', name: 'auth_id', align : 'center', sortable:false, width:100},
			{ label: '권한명', index: 'auth_nm', name: 'auth_nm', align : 'left', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', align : 'center', width:40, formatter:jsUseynLinkFormmater}
		],
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#auth_pager',
		sortname : "grp",
		sortorder : "asc",
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
	    beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		loadComplete : function(data) {
			showJqgridDataNon(data, "auth_list",6);
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("auth_list", "auth_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:authWrite('"+rowObject.auth_id+"')\">"+rowObject.auth_nm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {
	
	jQuery("#auth_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectAuthPageListUrl,
		page : 1,
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function authWrite(authId) {
    var f = document.listFrm;
    var mode = "W";
    if(authId != "") mode = "E";                
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: authWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   auth_id : authId
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

function authInsert(){
	    var range = $(':radio[name="range"]:checked').val();
	    
	    if(range != "1" && $("#orgn").val() == ""){
	    	alert("소속지자체를 선택해 주십시요.");
	    	return;
	    }
	    
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertAuthUrl;
		   if($("#mode").val() == "E") url = updateAuthUrl; 
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
  				url: url
  		    });	
		   
	   }
}

function authDelete(){
	   if(!confirm("정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteAuthUrl,
	           data:{
	           	auth_id : $("#auth_id").val()
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

function changeRange(){
	var range = $(':radio[name="range"]:checked').val();
	if(range == "1"){
		$('#orgn option[value=""').attr('selected','selected');
		$("#orgn").hide();
	}else{
		$("#orgn").show();
	}
}

function formReset(){
	$("#p_auth_nm").val("");
}

function popupShow(){
	$('#modal-auth-write').popup('show');
}

function popupClose(){
	$('#modal-auth-write').popup('hide');
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
	
		<input type='hidden' id="mode" name='mode' value="W" />
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:authWrite('')" class="btn acti" title="권한등록">
					<span>권한등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
		<!-- table 1dan list -->
		<div class="table_area" id="auth_list_div" >
		    <table id="auth_list"></table>
		    <div id="auth_pager"></div>
		</div>
		<!--// table 1dan list -->
		
	</form>
	
</div>
<!--// content -->


 <div id="modal-auth-write" style="width:600px;background-color:white">
	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
			<header>
				<h1 class="pop_title">권한 등록</h1>
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
				    <div  id="pop_content" >
				    </div>
				</div>
			</article>	
		</div>
		<!-- //container -->
		
	</div>
 </div>
	 		