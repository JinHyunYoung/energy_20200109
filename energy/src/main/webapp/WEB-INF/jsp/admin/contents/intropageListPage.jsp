<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var selectIntropageUrl = "<c:url value='/admin/intropage/intropagePageList.do'/>";
var intropageWriteUrl =  "<c:url value='/admin/intropage/intropageWrite.do'/>";

$(document).ready(function(){
	
	$('#intropage_list').jqGrid({
		datatype: 'json',
		url: selectIntropageUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '콘텐츠코드', index: 'page_id', name: 'page_id', align : 'center', width:100},
			{ label: '콘텐츠명', index: 'title', name: 'title', align : 'left', width:200, formatter:jsTitleLinkFormmater},
			{ label: '만족도사용여부', index: 'satis_yn', name: 'satis_yn', width: 120, align : 'center', formatter:jsUseynLinkFormmater},
			{ label: '만족도점수', index: 'satis_score', name: 'satis_score', align : 'center', width:80},
			{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', width: 40, align : 'center', sortable:false },
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 60, align : 'center', sortable:false }
		],
		postData :{	
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#intropage_pager',
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
			var ret = jQuery("#intropage_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "intropage_list");
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
			
			showJqgridDataNon(data, "intropage_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#intropage_list").jqGrid('navGrid', '#intropage_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("intropage_list", "intropage_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:intropageWrite('"+rowObject.page_id+"')\">"+rowObject.title+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {
		
	jQuery("#intropage_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectIntropageUrl,
		page : 1,
		postData : {
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function intropageWrite(pageId) {
    var f = document.listFrm;
    var mode = "W";
    if(pageId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#page_id").val(pageId);
	
    f.action = intropageWriteUrl;
    f.submit();
  
}

function formReset(){
	$("#p_searchtxt").val("");
	$("select[name=p_satis_yn] option[value='']").attr("selected",true);
}
</script>

<!-- content -->
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
		<input type='hidden' id="page_id" name='page_id' value="" />
		<input type='hidden' id="mode" name='mode' value="W" />
		
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>코드구분검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: 80px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>검색조건</th>
					<td>
	                  <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
	                       <option value="title" >콘텐츠명+내용</option>
	                  </select>
	                  <input type="input" class="in_wp200" id="p_searchtxt" name="p_searchtxt" value="<c:out value="${param.p_searchtxt}" escapeXml="true" />"  placeholder="콘텐츠명+내용">
					</td>
					<th>만족도여부</th>
					<td>
	                  <select id="p_satis_yn" name="p_satis_yn" class="form-control input-sm">
	                       <option value="">- 전체 -</option>
	                       <option value="Y" <c:if test="${param.p_satis_yn == 'Y'}">selected</c:if>>사용</option>
	                       <option value="N" <c:if test="${param.p_satis_yn == 'N'}">selected</c:if>>미사용</option>
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
				<a href="javascript:intropageWrite('')" class="btn acti" title="소개페이지 등록">
					<span>소개페이지등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->

		<!-- table 1dan list -->
		<div class="table_area" id="intropage_list_div" >
		    <table id="intropage_list"></table>
	        <div id="intropage_pager"></div>
		</div>
		<!--// table 1dan list -->
		
	</form>
	
</div>
<!--// content -->
