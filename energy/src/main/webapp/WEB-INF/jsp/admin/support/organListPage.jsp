<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectOrganPageListUrl = "<c:url value='/admin/organ/organPageList.do'/>";
var organWriteUrl =  "<c:url value='/admin/organ/organWrite.do'/>";
var organReorderUrl = "<c:url value='/admin/organ/updateOrganReorder.do'/>";

$(document).ready(function(){
    
	$('#organ_list').jqGrid({
		datatype: 'json',
		url: selectOrganPageListUrl,
		mtype: 'POST',
		colModel: [		
 			{ label: '순서', index: 'sort', name: 'sort', width: 20, align : 'center', edittype :"text", editable : true, sortable:false, editoptions : {dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '국내외구분', index: 'domestic_yn', name: 'domestic_yn', align : 'center', width:40, sortable:false, formatter:jsDomesticFormmater},
			{ label: '기관구분', index: 'organ_gb_nm', name: 'organ_gb_nm', align : 'center', width:40, sortable:false},
			{ label: '기관명', index: 'organ_nm', name: 'organ_nm', align : 'left', width:80, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', width: 20, align : 'center', sortable:false, formatter:jsUserYNFormmater},
			{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', width: 40, align : 'center', sortable:false},
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 40, align : 'center', sortable:false},
			{ label: '기관번호', index: 'organ_no', name: 'organ_no', width: 40, align : 'center', sortable:false, hidden:true }
		],
		postData :{	
			domestic_yn : $("#p_domestic_yn").val(),
			organ_gb : $("#p_organ_gb").val(),
			use_yn : $("#p_use_yn").val(),
			organ_nm : $("#p_organ_nm").val()
		},		
		page : "${LISTOP.ht.miv_pageNo}",
		// rowNum : "${LISTOP.ht.miv_pageSize}",
		rowNum : 5000,
		pager : '#organ_pager',
		viewrecords : true,
		sortname : "sort",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		editable: true,
		cellEdit : true,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#organ_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "organ_list");
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
			showJqgridDataNon(data, "organ_list", 7);
		}
	});
	//jq grid 끝 
	
	jQuery("#organ_list").jqGrid('navGrid', '#organ_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("organ_list", "organ_list_div");

});

function jsDomesticFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.domestic_yn == "Y"){
		str = "국내";
	}else{
		str = "해외";
	}
	return str;
}

function jsUserYNFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.use_yn == "Y"){
		str = "사용";
	}else if(rowObject.use_yn == "N"){
		str = "미사용";
	}
	return str;
}


function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:organWrite('"+rowObject.organ_no+"')\">"+rowObject.organ_nm+"</a>";
	return str;
}

function search() {
		
	jQuery("#organ_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectOrganPageListUrl,
		page : 1,
		postData : {
			domestic_yn : $("#p_domestic_yn").val(),
			organ_gb : $("#p_organ_gb").val(),
			use_yn : $("#p_use_yn").val(),
			organ_nm : $("#p_organ_nm").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function organWrite(organNo) {
	
    var f = document.listFrm;
    var mode = "W";
    
    if(organNo != ""){
    	mode = "E";
    }
    	
	$("#mode").val(mode);
	
	$("#organ_no").val(organNo);
	
    f.action = organWriteUrl;
    f.submit();
}

function organReorder(){
	
	var updateRow = new Array();
	var saveCnt = 0;
	
	jQuery('#organ_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#organ_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0){
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length > 0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("순서는 필수값입니다. 확인 후 다시입력해주세요");
					return;
				}
			}		
			arrrows[i].organ_nm ="";
			updateRow[saveCnt++] = arrrows[i];
		}
	} else {
		alert("순서를 저장할 코드가 없습니다.");
		return;
	}
		
	$.ajax
	({
		type: "POST",
           url: organReorderUrl,
           data:{
        	   organ_list : JSON.stringify(updateRow) 
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
	$("select[name=p_domestic_yn] option[value='']").attr("selected",true);
	$("select[name=p_organ_gb] option[value='']").attr("selected",true);
	$("select[name=p_use_yn] option[value='']").attr("selected",true);
	$("#p_organ_nm").val("");
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
		<input type='hidden' id="organ_no" name='organ_no' value="" />
		<input type='hidden' id="mode" name='mode' value="W" />
	
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>팝업검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 20%;" />
				    <col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: 20%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>국내외구분</th>
					<td>
						<select id="p_domestic_yn" name="p_domestic_yn">
							<option value="">- 전체 -</option>
							<option value="Y" <c:if test="${param.domestic_yn eq 'Y' }" >selected</c:if> >국내</option>
							<option value="N" <c:if test="${param.domestic_yn eq 'N' }" >selected</c:if> >해외</option>
						</select>
					</td>
					<th>기관구분</th>
					<td>       
						<g:select id="p_organ_gb" name="p_organ_gb" codeGroup="ORGAN_GB" selected="${param.p_organ_gb}" titleCode="전체" cls="form-control" />  	
					</td>
					<td></td>
				</tr>			
				<tr>
					<th>사용여부</th>
					<td>
						<select id="p_use_yn" name="p_use_yn">
							<option value="">- 전체 -</option>
							<option value="Y" <c:if test="${param.use_yn eq 'Y' }" >selected</c:if> >사용</option>
							<option value="N" <c:if test="${param.use_yn eq 'N' }" >selected</c:if> >미사용</option>
						</select>
					</td>
					<th>기관명</th>
					<td>
		            	<input type="input" id="p_organ_nm" name="p_organ_nm" value="<c:out value="${param.organ_nm}" escapeXml="true" />"  placeholder="기관명" class="in_w70">                      
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
	
		<!-- table 1dan list -->
		<div class="table_area" id="organ_list_div" >
		    <table id="organ_list"></table>
	        <div id="organ_pager" style="display: none;"></div>
		</div>
		<!--// table 1dan list -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:organReorder()" class="btn save" title="순서저장">
					<span>순서저장</span>
				</a>
				<a href="javascript:organWrite('')" class="btn save" title="관리자등록">
					<span>등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
</div>
<!--// content -->