<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var selectCodegubunUrl = "<c:url value='/admin/code/codegubunPageList.do'/>";
var codegubunWriteUrl =  "<c:url value='/admin/code/codegubunWrite.do'/>";
var insertCodegubunUrl = "<c:url value='/admin/code/insertCodegubun.do'/>";
var updateCodegubunUrl = "<c:url value='/admin/code/updateCodegubun.do'/>"
var deleteCodegubunUrl = "<c:url value='/admin/code/deleteCodegubun.do'/>";

$(document).ready(function(){
	
	$('#modal-codegubun-write').popup();
	
	$('#gubun_list').jqGrid({
		datatype: 'json',
		url: selectCodegubunUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '코드구분ID', index: 'gubun', name: 'gubun', width: 120, align : 'center', sortable:false },
			{ label: '코드구분명', index: 'gubun_nm', name: 'gubun_nm', align : 'left', width:200, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '설명', index: 'gubun_desc', name: 'gubun_desc', align : 'left', width:200, sortable:false},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', align : 'center', width:40, sortable:false, formatter:jsUseynLinkFormmater},
			{ label: '코드수', index: 'code_cnt', name: 'code_cnt', width: 50, align : 'center' , sortable:false},
			{ label: '코드관리', index: 'code_btn', name: 'code_btn' , width: 100, align : 'center', sortable:false, formatter:jsBtnFormmater}
		],
		postData :{	
			gubun_nm : $("#p_gubun_nm").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#gubun_pager',
		viewrecords : true,
		sortname : "gubun_nm",
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
			var ret = jQuery("#gubun_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "gubun_list");
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
			
			showJqgridDataNon(data, "gubun_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#gubun_list").jqGrid('navGrid', '#gubun_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("gubun_list", "gubun_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:codegubunWrite('"+rowObject.gubun+"')\">"+rowObject.gubun_nm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function jsBtnFormmater(cellvalue, options, rowObject) {

	var str = "";

 	str ="<a href=\"javascript:codeListPage('"+rowObject.gubun+"')\" class=\"btn look\" title=\"코드상세\"><span>코드상세</span></a>";
		
	return str;
}

function search() {
		
	jQuery("#gubun_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectCodegubunUrl,
		page : 1,
		postData : {
			gubun_nm : $("#p_gubun_nm").val(),
			use_yn : $("#p_use_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function codegubunWrite(gubun) {
    var f = document.listFrm;
    var mode = "W";
    if(gubun != "") mode = "E";
    
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: codegubunWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   gubun : gubun
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

function codegubunInsert(){
   var url = "";
   if ( $("#writeFrm").parsley().validate() ){

	   url = insertCodegubunUrl;
	   if($("#mode").val() == "E") url = updateCodegubunUrl; 
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

function codegubunDelete(gubun){
	
   if(!confirm("선택하신 대코드 하위의 모든 소코드가 삭제됩니다. 정말 삭제하시겠습니까?")) return;
   
	$.ajax
	({
		type: "POST",
           url: deleteCodegubunUrl,
           data:{
           	gubun : gubun
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

function codeListPage(gubun) {
    var f = document.listFrm;
  
    $("#gubun").val(gubun);
 
    f.target = "_self";
    f.action = "/admin/code/codeListPage.do";
    f.submit();
}

function formReset(){
	$("#p_gubun_nm").val("");
	$('#p_use_yn option[value=""').attr('selected','selected');
}

function popupShow(){
	$('#modal-codegubun-write').popup('show');
}

function popupClose(){
	$('#modal-codegubun-write').popup('hide');
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
		<input type='hidden' id="gubun" name='gubun' value="" />
		<input type='hidden' id="mode" name='mode' value="W" />
		
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>코드구분검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 20%;" />
					<col style="width: 70px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>코드구분명</th>
					<td>
	                     <input type="input" class="form-control input-sm" id="p_gubun_nm" name="p_gubun_nm" value="${param.p_gubun_nm}"  placeholder="대코드명" />
					</td>
					<th>사용여부</th>
					<td>
	                  <select id="p_use_yn" name="p_use_yn" class="form-control input-sm">
	                       <option value="">- 전체 -</option>
	                       <option value="Y" <c:if test="${param.p_use_yn == 'Y'}">selected</c:if>>사용</option>
	                       <option value="N" <c:if test="${param.p_use_yn == 'N'}">selected</c:if>>미사용</option>
	                  </select>
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
			<div class="float_right">
				<a href="javascript:codegubunWrite('')" class="btn acti" title="코드구분 등록">
					<span>코드구분등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
	
		<!-- table 1dan list -->
		<div class="table_area" id="gubun_list_div" >
		    <table id="gubun_list"></table>
	        <div id="gubun_pager"></div>
		</div>
		<!--// table 1dan list -->
		
	</form>
		
</div>
<!--// content -->
	
	
	
<div id="modal-codegubun-write" style="width:600px;background-color:white">

	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
			<header>
				<h1 class="pop_title">코드구분 등록</h1>
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
		 		