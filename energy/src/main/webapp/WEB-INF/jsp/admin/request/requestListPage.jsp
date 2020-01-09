<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script language="javascript">

var selectRequestUrl = "<c:url value='/admin/request/requestPageList.do'/>";
var requestWriteUrl =  "<c:url value='/admin/request/requestWrite.do'/>";

$(document).ready(function(){
		
	$('#request_list').jqGrid({
		datatype: 'json',
		url: selectRequestUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater },
			{ label: '구분', index: 'req_gb_nm', name: 'req_gb_nm', align : 'center', width:40, sortable:false },
			{ label: '제목', index: 'title', name: 'title', align : 'left', width:100, sortable:false, formatter:jsTitleLinkFormmater },
			{ label: '첨부파일', index: 'attach_file', name: 'attach_file',width: 40, align : 'center', sortable:false, formatter:jsAttachFormmater },
			{ label: '이름', index: 'user_nm', name: 'user_nm', width: 40, align : 'center', sortable:false },
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 50, align : 'center', sortable:false },
			{ label: 'req_id', index: 'req_id', name: 'req_id', hidden:true },
			{ label: 'answer_no', index: 'answer_no', name: 'answer_no', hidden:true }
		],
		postData :{	
			p_req_gb : $("#p_req_gb").val(),
			p_answer : $("#p_answer").val(),
			p_searchkey : $("#p_searchkey").val(),
			p_searchtxt : $("#p_searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#request_pager',
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
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#request_list").jqGrid('getRowData', rowid);
		}, 
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			showJqgridDataNon(data, "request_list",9);
		}
	});
	//jq grid 끝 
	
	jQuery("#request_list").jqGrid('navGrid', '#request_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("request_list", "request_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var val = cellvalue;
	if(rowObject.answer_no != undefined) val += "<span style='color:blue;'>[답변완료]</span>";
	else  val += "<span style='color:red;'>[답변대기]</span>";
	var str = "<a href=\"javascript:requestWrite('"+rowObject.req_id+"')\">"+val+"</a>";
	
	return str;
}

//첨부파일
function jsAttachFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.attach_file != undefined) {
		str = '<img src="/images/admin/icon/icon_file.png" alt="첨부파일" />';
	}
	return str;
}

function search() {
		
	jQuery("#request_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectRequestUrl,
		page : 1,
		postData : {
			p_req_gb : $("#p_req_gb").val(),
			p_answer : $("#p_answer").val(),
			p_searchkey : $("#p_searchkey").val(),
			p_searchtxt : $("#p_searchtxt").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function requestWrite(reqId) {
    var f = document.listFrm;
    var mode = "W";
    if(reqId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#req_id").val(reqId);
	
    f.action = requestWriteUrl;
    f.submit();
}

function requestExcelDown(){
	var f = document.listFrm;
	f.action = "/admin/request/requestPageListExcel.do";
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
				<th>구분</th>
				<td>
                  <g:select id="p_req_gb" name="p_req_gb" codeGroup="REQ_GUBUN" cls="in_wp130" titleCode="전체" selected="${param.p_req_gb}" />
                </td>
				<th>답변상태</th>
				<td>
                  <select id="p_answer" name="p_answer" class="form-control input-sm">
                      <option value="" >- 전체  -</option>
                      <option value="N" <c:if test="${param.p_answer == 'N'}">selected</c:if>>답변대기</option>
                      <option value="Y" <c:if test="${param.p_answer == 'Y'}">selected</c:if>>답변완료</option>
                  </select>
				</td>
			</tr>
			<tr>
				<th>검색구분</th>
				<td colspan="3">
                   	<select name="p_searchkey" id="p_searchkey" class="in_wp130" data-parsley-required="true">
                   	     <option value="user_nm" <c:if test="${param.p_searchkey == 'user_nm'}">selected</c:if>>이름</option>
                   	     <option value="handphone" <c:if test="${param.p_searchkey == 'handphone'}">selected</c:if>>연락처</option>
                   	     <option value="email" <c:if test="${param.p_searchkey == 'email'}">selected</c:if>>이메일</option>
                   	     <option value="title" <c:if test="${param.p_searchkey == 'title'}">selected</c:if>>제목</option>
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
			<a href="javascript:requestExcelDown()" class="btn acti" title="엑셀다운">
				<span>엑셀다운</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->
	
	<!-- table 1dan list -->
	<div class="table_area" id="request_list_div" >
	    <table id="request_list"></table>
        <div id="request_pager"></div>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>