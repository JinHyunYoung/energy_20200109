<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectSupportreqUrl = "<c:url value='/admin/support/supportreqPageList.do'/>";
var supportreqWriteUrl =  "<c:url value='/admin/support/supportreqWrite.do'/>";

$(document).ready(function(){
		
	changeSido();
	changeProtGb();
	
	$('#supportreq_list').jqGrid({
		datatype: 'json',
		url: selectSupportreqUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater },
			{ label: '신청인(이름)', index: 'req_nm', name: 'req_nm', align : 'center', width:40, sortable:false, formatter:jsTitleLinkFormmater },
			{ label: '생년월일', index: 'birth', name: 'birth', align : 'center', width:60, sortable:false },
			{ label: '보호구분', index: 'prot_gb_nm', name: 'prot_gb_nm', width:40, sortable:false },
			{ label: '보호유형', index: 'prot_type_nm', name: 'prot_type_nm', width:40, sortable:false },
			{ label: '세대유형', index: 'gener_type_nm', name: 'gener_type_nm', width: 40, align : 'center', sortable:false },
			{ label: '세대원수', index: 'gener_cnt', name: 'gener_cnt', width: 40, align : 'center', sortable:false },
			{ label: '시/도', index: 'sido', name: 'sido', width: 40, align : 'center', sortable:false },
			{ label: '시/군/구', index: 'sigun', name: 'sigun', width: 40, align : 'center', sortable:false },
			{ label: '신청일', index: 'reg_date', name: 'reg_date', width: 40, align : 'center', sortable:false },
			{ label: '심사결과', index: 'eval_result_nm', name: 'eval_result_nm', width: 40, align : 'center', sortable:false},
			{ label: 'req_id', index: 'req_id', name: 'req_id', hidden:true }
		],
		postData :{	
			p_administ_cd : $("#p_administ_cd").val(),
			p_evalresult : $("#p_evalresult").val(),
			p_prot_gb : $("#p_prot_gb").val(),
			p_prot_type : $("#p_prot_type").val(),
			p_gener_type : $("#p_gener_type").val(),
			p_searchkey : $("#p_searchkey").val(),
			p_searchtxt : $("#p_searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#supportreq_pager',
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
			var ret = jQuery("#supportreq_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "supportreq_list");
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
			
			showJqgridDataNon(data, "supportreq_list",9);

		}
	});
	//jq grid 끝 
	
	jQuery("#supportreq_list").jqGrid('navGrid', '#supportreq_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("supportreq_list", "supportreq_list_div");

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
	$("#p_administ_cd").val("");
	if($("#p_sido").val() != "") $("#p_administ_cd").val($("#p_sido").val());	
	if($("#p_sigun").val() != "") $("#p_administ_cd").val($("#p_sigun").val());
	jQuery("#supportreq_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectSupportreqUrl,
		page : 1,
		postData : {
			p_administ_cd : $("#p_administ_cd").val(),
			p_eval_result : $("#p_eval_result").val(),
			p_prot_gb : $("#p_prot_gb").val(),
			p_prot_type : $("#p_prot_type").val(),
			p_gener_type : $("#p_gener_type").val(),
			p_searchkey : $("#p_searchkey").val(),
			p_searchtxt : $("#p_searchtxt").val()
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

function changeSido(){
	var sido = $("#p_sido").val();
	var param = {sido : sido};
	getCodeList("/admin/support/sigunCodeList.do", param, "p_sigun", "${param.p_sigun}", "", "","Y");
}

function changeProtGb(){
	var protGb = $("#p_prot_gb").val();
	selectbox_deletealllist("p_prot_type");
	getCommonCodeList("SAFE_CD_"+protGb, "p_prot_type", "${param.p_prot_type}", "", "- 전체 -", true); 
}

function supportreqExcelDown(){
	var f = document.listFrm;
	f.action = "/admin/support/supportreqPageListExcel.do";
	f.submit();
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
			<caption>지원신청서검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: 35%;" />
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<tr>
				<th>지역</th>
				<td>
				  <g:select id="p_sido" name="p_sido" codeGroup="SIDO_CD" cls="in_wp130" titleCode="시/군 전체" onChange="changeSido()" selected="${param.p_sido}" />
                  <select id="p_sigun" name="p_sigun" class="form-control input-sm">
                      <option value="" >- 시/군/구 전체 -</option>
                  </select>                  
				</td>
				<th>심사결과</th>
				<td>
                    <g:select id="p_eval_result" name="p_eval_result" codeGroup="EVAL_RESULT" cls="in_wp130" titleCode="전체" selected="${param.p_eval_result}" />
				</td>
			</tr>
			<tr>
				<th>보호구분</th>
				<td>
                 <g:select id="p_prot_gb" name="p_prot_gb" codeGroup="SAFE_CD" cls="in_wp130" onChange="changeProtGb()" titleCode="전체" selected="${param.p_prot_gb}" />               
				</td>
				<th>보호유형</th>
				<td>
                   	<select name="p_prot_type" id="p_prot_type" class="in_wp130" data-parsley-required="true">
					<option value="" >- 전체 -</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>세대유형</th>
				<td>
                 <g:select id="p_gener_type" name="p_gener_type" codeGroup="FA_TYPE_CD" cls="in_wp130" titleCode="전체" selected="${param.p_gener_type}"/>              
				</td>
				<th>검색구분</th>
				<td>
                   	<select name="p_searchkey" id="p_searchkey" class="in_wp130" data-parsley-required="true">
                   	     <option value="reg_nm" <c:if test="${param.p_searchkey == 'reg_nm'}">selected</c:if>>신청인(이름)</option>
                   	     <option value="birth" <c:if test="${param.p_searchkey == 'birth'}">selected</c:if>>생년월일</option>
                   	     <option value="apply_org_nm" <c:if test="${param.p_searchkey == 'apply_org_nm'}">selected</c:if>>신청기관명</option>
                   	     <option value="apply_org_usernm" <c:if test="${param.p_searchkey == 'apply_org_usernm'}">selected</c:if>>담당자</option>
					</select>
					<label for="p_searchtxt" class="hidden">검색어 입력</label>
					<input type="input" class="in_w50" id="p_searchtxt" name="p_searchtxt" value="${param.p_searchtxt}"  placeholder="검색어 입력">
					
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
			<a href="javascript:supportreqExcelDown()" class="btn acti" title="엑셀다운">
				<span>엑셀다운</span>
			</a>
		</div>
		<div class="float_right">
			<a href="javascript:supportreqWrite('')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="supportreq_list_div" >
	    <table id="supportreq_list"></table>
        <div id="supportreq_pager"></div>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>
