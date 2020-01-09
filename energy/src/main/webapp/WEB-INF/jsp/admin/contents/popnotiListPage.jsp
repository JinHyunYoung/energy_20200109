<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var selectPopnotiUrl = "<c:url value='/admin/popnoti/popnotiPageList.do'/>";
var popnotiWriteUrl =  "<c:url value='/admin/popnoti/popnotiWrite.do'/>";
var insertPopnotiUrl = "<c:url value='/admin/popnoti/insertPopnoti.do'/>";
var updatePopnotiUrl = "<c:url value='/admin/popnoti/updatePopnoti.do'/>"
var deletePopnotiUrl = "<c:url value='/admin/popnoti/deletePopnoti.do'/>";

$(document).ready(function(){
    
	$('#popnoti_list').jqGrid({
		datatype: 'json',
		url: selectPopnotiUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '제목', index: 'title', name: 'title', align : 'left', width:200, formatter:jsTitleLinkFormmater},
			{ label: '첨부파일', index: 'file_id', name: 'file_id', width: 60, align : 'center', formatter:jsImageLinkFormmater},
			{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', width: 40, align : 'center', sortable:false },
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 60, align : 'center', sortable:false },
			{ label: 'noti_id', index: 'noti_id', name: 'noti_id', width: 80, align : 'center', hidden:true }
		],
		postData :{	
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			use_yn : $("#p_useyn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#popnoti_pager',
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
			var ret = jQuery("#popnoti_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "popnoti_list");
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
			showJqgridDataNon(data, "popnoti_list",5);
		}
	});
	//jq grid 끝 
	
	jQuery("#popnoti_list").jqGrid('navGrid', '#popnoti_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("popnoti_list", "popnoti_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:popnotiWrite('"+rowObject.noti_id+"')\">"+rowObject.title+"</a>";
	
	return str;
}

function jsImageLinkFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(cellvalue != undefined) {
		str = "<a class=\"btn btn-xs btn-info\" href=\"/commonfile/fileidDownLoad.do?file_id="+ cellvalue +"\" ><image src=\"/images/admin/icon/icon_file.png\" /></a>";
	}
	
	return str;
}

function search() {
		
	jQuery("#popnoti_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectPopnotiUrl,
		page : 1,
		postData : {
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			use_yn : $("#p_useyn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function popnotiWrite(popnoti) {
    var f = document.listFrm;
    var mode = "W";
    if(popnoti != "") mode = "E";
    
	$("#mode").val(mode);
	$("#noti_id").val(popnoti);
	
    f.action = popnotiWriteUrl;
    f.submit();
}

function formReset(){
	$("#p_searchtxt").val("");
	$("select[name=p_use_yn] option[value='']").attr("selected",true);
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
		<input type='hidden' id="noti_id" name='noti_id' value="" />
		<input type='hidden' id="mode" name='mode' value="W" />
	
		<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>팝업검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: 80px;" />
					<col style="width: 20%;" />
					<col style="width: 30%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>검색값</th>
					<td>
					  <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
	                       <option value="title" >제목+내용</option>
	                  </select>
	                  <label for="input_text" class="hidden">검색어 입력</label>
	                   <input type="input" class="form-control input-sm" id="p_searchtxt" name="p_searchtxt" value="<c:out value="${param.p_searchtxt}" escapeXml="true" />"  placeholder="제목+내용">
					</td>
					<th>사용여부</th>
					<td>
	                  <select id="p_use_yn" name="p_use_yn" class="form-control input-sm">
	                       <option value="">- 전체 -</option>
	                       <option value="Y" <c:if test="${param.p_use_yn == 'Y'}">selected</c:if>>사용</option>
	                       <option value="N" <c:if test="${param.p_use_yn == 'N'}">selected</c:if>>미사용</option>
	                  </select>
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
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:popnotiWrite('')" class="btn acti" title="팝업등록">
					<span>팝업등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<!-- table 1dan list -->
		<div class="table_area" id="popnoti_list_div" >
		    <table id="popnoti_list"></table>
	        <div id="popnoti_pager"></div>
		</div>
		<!--// table 1dan list -->
		
</div>
<!--// content -->
	 		