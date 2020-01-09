<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectEducationApplyUrl = "<c:url value='/admin/education/educationApplyPageList.do'/>";
var educationApplyWriteUrl =  "<c:url value='/admin/education/educationApplyWrite.do'/>";

$(document).ready(function(){
		
	changeYear();
	
	$('#educationApply_list').jqGrid({
		datatype: 'json',
		url: selectEducationApplyUrl,
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater },
			{ label: '회차', index: 'seq', name: 'seq', align : 'center', width:40, sortable:false },
			{ label: '성명', index: 'user_nm', name: 'user_nm', align : 'center', width:60, sortable:false, formatter:jsTitleLinkFormmater },
			{ label: '교육구분', index: 'edu_gb_nm', name: 'edu_gb_nm',width: 40, align : 'center', sortable:false },
			{ label: '수강상태', index: 'apply_status_nm', name: 'apply_status_nm', width: 40, align : 'center', sortable:false },
			{ label: '승인처리일', index: 'apply_proc_date_nm', name: 'apply_proc_date_nm', width: 40, align : 'center', sortable:false },
			{ label: '합격상태', index: 'pass_status_nm', name: 'pass_status_nm', width: 40, align : 'center', sortable:false },
			{ label: '합격처리일', index: 'pass_proc_date_nm', name: 'pass_proc_date_nm', width: 40, align : 'center', sortable:false },
			{ label: 'seq_id', index: 'seq_id', name: 'seq_id', hidden:true },
			{ label: 'user_ci', index: 'user_ci', name: 'user_ci', hidden:true }
		],
		postData :{	
			p_year : $("#p_year").val(),
			p_seq : $("#p_seq").val(),
			p_apply_status : $("#p_apply_status").val(),
			p_pass_status : $("#p_pass_status").val(),
			p_searchkey : $("#p_searchkey").val(),
			p_searchtxt : $("#p_searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#educationApply_pager',
		viewrecords : true,
		sortname : "reg_date",
		sortorder : "desc",
		height : "350px",
		gridview : true,
		multiselect: true,
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
			var ret = jQuery("#educationApply_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "educationApply_list");
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
			showJqgridDataNon(data, "educationApply_list",9);
		}
	});
	//jq grid 끝 
	
	jQuery("#educationApply_list").jqGrid('navGrid', '#educationApply_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("educationApply_list", "educationApply_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:educationApplyWrite('"+rowObject.seq_id+"','"+rowObject.user_ci+"')\">"+cellvalue+"</a>";
	
	return str;
}

function search() {
		
	jQuery("#educationApply_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectEducationApplyUrl,
		page : 1,
		postData : {
			p_year : $("#p_year").val(),
			p_seq : $("#p_seq").val(),
			p_apply_status : $("#p_apply_status").val(),
			p_pass_status : $("#p_pass_status").val(),
			p_searchkey : $("#p_searchkey").val(),
			p_searchtxt : $("#p_searchtxt").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function educationApplyWrite(seqId, userCi) {
    var f = document.listFrm;
    var mode = "W";
    if(seqId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#seq_id").val(seqId);
	$("#user_ci").val(userCi);
	
    f.action = educationApplyWriteUrl;
    f.submit();
}

function changeYear(){
	var year = $("#p_year").val();
	var param = {year : year};
	getCodeList("/admin/education/eduseqCodeList.do", param, "p_seq", "${param.p_seq}", "", "","Y");
}

var approvalGb = '1';
function approvalEducationApply(gubun, state){
	 approvalGb = gubun;
	 if(state == "F"){
		 var title = "수강반려 사유";
		 $("#approval_fail_reason").show();
		 $("#pass_fail_reason").hide();
		 if(gubun == '2') {
			 $("#approval_fail_reason").hide();
			 $("#pass_fail_reason").show();
			 title = "합격반려 사유";
		 }
		 $("#evalFailTitle").html(title);
		 var s = jQuery("#educationApply_list").jqGrid('getGridParam','selarrrow');
	
	     if(s.length < 1){
	     	alert("대상자를 선택해 주십시요.");
	     	return;
	     }
	     
		evalPopupShow();
	 }else updateEvalResult("P");
}

function updateEvalResult(state){
	var stateNm = "수강 승인";
	var failReason = "";
	var url = "/admin/education/approvalEducationApply.do";
    if(approvalGb == '1'){
	  if(state == "F"){ 
	    failReason = $("#approval_fail_reason").val();
	  	stateNm = "수강 반려";
	  }else{
		stateNm = "수강 승인";  
	  }
	}else{
	  url = "/admin/education/passEducationApply.do";
	  if(state == "F"){ 
		failReason = $("#pass_fail_reason").val();
	  	stateNm = "합격 반려";
	  }else{
		stateNm = "합격 승인";  
	  }
	}
	
	var s = jQuery("#educationApply_list").jqGrid('getGridParam','selarrrow');

    if(s.length < 1){
     	alert("대상자를 선택해 주십시요.");
     	return;
    }
     
  	var aplyRow = new Array();
 	var ret = null;
 	
	for (var i = 0; i < s.length; i++) {
		ret = jQuery("#educationApply_list").jqGrid('getRowData',s[i]);
 	    var tmp = {seq_id : ret.seq_id, user_ci : ret.user_ci };
		aplyRow.push(tmp);
    }    

    if(!confirm("선택한 대상자를 "+stateNm+" 처리하시겠습니까?")) return;
    	 
    $.ajax({
        url: url,
        dataType: "json",
        type: "post",
        data: {
           result : state,
  		   fail_reason : failReason,
  		   aply_list : JSON.stringify(aplyRow)
		},
        success: function(data) {
        	alert(data.message);
        	if(data.success == "true") search();
        	evalPopupClose(); 
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    	 
}

function evalPopupShow(){
	$('#modal-eval-write').modal('show');
}

function evalPopupClose(){
	$('#modal-eval-write').modal('hide');
}

function educationApplyExcelDown(){
	var f = document.listFrm;
	f.action = "/admin/education/educationApplyPageListExcel.do";
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
	<input type='hidden' id="seq_id" name='seq_id' value="" />
	<input type='hidden' id="user_ci" name='user_ci' value="" />
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
				<th>운영년도</th>
				<td>
                  <select id="p_year" name="p_year" class="form-control input-sm" onChange="changeYear()">
                     <c:forEach begin="0" end="10" var="idx" step="1">
                     	 <option value="${curYear-idx}" <c:if test="${(curYear-idx) == param.p_year}">selected</c:if>>${curYear-idx}</option>
                     </c:forEach>
                  </select>
                </td>
				<th>회차</th>
				<td>
                  <select id="p_seq" name="p_seq" class="form-control input-sm">
                      <option value="" >- 전체  -</option>
                  </select>
				</td>
			</tr>
			<tr>
				<th>수강상태</th>
				<td>
					<g:select id="p_apply_status" name="p_apply_status" codeGroup="EDU_APPROVAL" cls="in_wp130" titleCode="전체" selected="${param.p_apply_status}" /> 
				</td>
				<th>합격상태</th>
				<td>
                  <select id="p_pass_status" name="p_pass_status" class="form-control input-sm">
                      <option value="" >- 전체  -</option>
                      <option value="Y" <c:if test="${param.p_pass_status == 'Y'}">selected</c:if>>합격</option>
                      <option value="N" <c:if test="${param.p_pass_status == 'N'}">selected</c:if>>불합격</option>
                  </select>
				</td>
			</tr>
			<tr>
				<th>검색구분</th>
				<td colspan="3">
                   	<select name="p_searchkey" id="p_searchkey" class="in_wp130" data-parsley-required="true">
                   	     <option value="reg_nm" <c:if test="${param.p_searchkey == 'reg_nm'}">selected</c:if>>성명</option>
                   	     <option value="birth" <c:if test="${param.p_searchkey == 'birth'}">selected</c:if>>생년월일</option>
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
			<a href="javascript:educationApplyExcelDown()" class="btn acti" title="엑셀다운">
				<span>엑셀다운</span>
			</a>
		</div>		
		<div class="float_right">
			<a href="javascript:approvalEducationApply('1','P')" class="btn acti" title="수강승인">
				<span>수강승인</span>
			</a>
			<a href="javascript:approvalEducationApply('1','F')" class="btn acti" title="수강반려">
				<span>수강반려</span>
			</a>
			<a href="javascript:approvalEducationApply('2','P')" class="btn acti" title="합격">
				<span>합격</span>
			</a>			
			<a href="javascript:approvalEducationApply('2','F')" class="btn acti" title="불합격">
				<span>불합격</span>
			</a>
			<a href="javascript:educationApplyWrite('')" class="btn acti" title="등록" style="display:none">
				<span>등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->

	<!-- table 1dan list -->
	<div class="table_area" id="educationApply_list_div" >
	    <table id="educationApply_list"></table>
        <div id="educationApply_pager"></div>
	</div>
	<!--// table 1dan list -->
</div>
<!--// content -->
</form>
     <div class="modal fade" id="modal-eval-write" >
		<div class="modal-dialog modal-size-small">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title" id="evalFailTitle" >Fail 사유</h1>
				<a href="javascript:evalPopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="eval_pop_content" >
	<form id="evalFrm" name="evalFrm" method="post" data-parsley-validate="true">
					<!-- write_basic -->
					<div class="table_area">
						<table class="write">
							<caption>Fail 사유 등록화면</caption>
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">사유</th>
								<td>
								    <g:select id="approval_fail_reason" name="approval_fail_reason"  codeGroup="APPROVAL_REJECT_REASON" cls="in_wp300" style="display:none" />
								    <g:select id="pass_fail_reason" name="pass_fail_reason"  codeGroup="PASS_REJECT_REASON" cls="in_wp300" style="display:none" />
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// write_basic -->
					<!-- footer --> 
					<div id="footer">
					<footer>
						<div class="button_area alignc">
		                  	<a href="javascript:updateEvalResult('F')" class="btn save" title="저장">
								<span>저장</span>
							</a>
						</div>
					</footer>
					</div>
					<!-- //footer -->
</form>
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>