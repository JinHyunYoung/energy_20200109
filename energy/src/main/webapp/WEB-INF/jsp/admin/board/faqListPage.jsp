<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var selectFaqListUrl = "<c:url value='/admin/faq/faqList.do'/>";
var faqWriteUrl =  "<c:url value='/admin/faq/faqWrite.do'/>";
var faqReorderUrl = "<c:url value='/admin/faq/updateFaqReorder.do'/>";

$(document).ready(function(){
    
	$('#faq_list').jqGrid({
		datatype: 'json',
		url: selectFaqListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '순서', index: 'sort', name: 'sort', width: 50, align : 'center', editable : true, sortable:false,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '제목', index: 'title', name: 'title', align : 'left', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			/* { label: '만족도사용여부', index: 'satisfy_yn', name: 'satisfy_yn', align : 'center', sortable:false, width:60, formatter:jsUseynLinkFormmater},
			{ label: '만족도점수', index: 'satisfy_point', name: 'satisfy_point', align : 'center', width:40, sortable:false}, */
			{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', width: 40, align : 'center', sortable:false },
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 60, align : 'center', sortable:false },
			{ label: 'faq_id', index: 'faq_id', name: 'faq_id', width: 80, align : 'center', hidden:true }
		],
		postData :{	
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			use_yn : $("#p_use_yn").val()
		   },
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
		loadComplete : function(data) {
			showJqgridDataNon(data, "faq_list",6);
		}
	});
	//jq grid 끝 

	bindWindowJqGridResize("faq_list", "faq_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:faqWrite('"+rowObject.faq_id+"')\">"+rowObject.title+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {
		
	jQuery("#faq_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectFaqListUrl,
		page : 1,
		postData : {
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			use_yn : $("#p_use_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function faqWrite(faqId) {
    var f = document.listFrm;
    var mode = "W";
    if(faqId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#faq_id").val(faqId);
	
    f.action = faqWriteUrl;
    f.submit();
  
}

function faqReorder(){
	var updateRow = new Array();
	var saveCnt = 0;
	
	jQuery('#faq_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#faq_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("순서는 필수값입니다. 확인 후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].title="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("순서를 저장할 코드가 없습니다.");
		return;
	}
		
	$.ajax
	({
		type: "POST",
           url: faqReorderUrl,
           data:{
            faq_list : JSON.stringify(updateRow) 
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search();
			}	
		}
	});
}

function formReset(){
	$("#p_searchtxt").val("");
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
	
		<input type='hidden' id="mode" name='mode' value="W" />
		<input type='hidden' id="faq_id" name='faq_id' value="" />
		
		<!-- search_area -->
		<div class="search_area">
		
			 <table class="search_box">
				<caption>FAQ검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: 70px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>검색구분</th>
					<td>
	                   <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
	                       <option value="title" >제목+내용</option>
	                  </select>
	                  <input type="input" class="in_wp200" id="p_searchtxt" name="p_searchtxt" value="<c:out value="${param.p_searchtxt}" escapeXml="true" />"  placeholder="제목+내용">
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
				<a href="javascript:faqReorder()" class="btn acti" title="순서저장">
					<span>순서저장</span>
				</a>
				<a href="javascript:faqWrite('')" class="btn acti" title="FAQ등록">
					<span>FAQ등록</span>
				</a>			
			</div>
		</div>
		<!--// tabel_search_area -->

		<!-- table 1dan list -->
		<div class="table_area" id="faq_list_div" >
		    <table id="faq_list"></table>
		</div>
		<!--// table 1dan list -->
		
	</form>
	
</div>
<!--// content -->
	 		