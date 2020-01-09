<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script language="javascript">
var savedRow = null;
var savedCol = null;
var selectEduseqUrl = "<c:url value='/admin/education/eduseqPageList.do'/>";
var eduseqWriteUrl =  "<c:url value='/admin/education/eduseqWrite.do'/>";

$(document).ready(function(){
		
	$('#eduseq_list').jqGrid({
		datatype: 'json',
		url: selectEduseqUrl,
		mtype: 'POST',
		colModel: [
			{ label: '회차', index: 'seq', name: 'seq', width: 30, align : 'center', sortable:false, formatter:jsRownumFormmater },
			{ label: '운영년도', index: 'run_year', name: 'run_year', align : 'center', width:40, sortable:false, hidden:true },
			{ label: '신청기간', index: 'apply_data', name: 'apply_data', align : 'center', width:100, sortable:false, formatter:jsTitleLinkFormmater },
			{ label: '과목수', index: 'subj_cnt', name: 'subj_cnt', align : 'center', width:40, sortable:false },
			{ label: '교육상태', index: 'subj_stat', name: 'subj_stat', align : 'center', width:40, sortable:false },
			{ label: 'seq_id', index: 'seq_id', name: 'seq_id', hidden:true }
		],
		postData :{	
			p_year : $("#p_year").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#eduseq_pager',
		viewrecords : true,
		sortname : "run_year desc, seq",
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
			var ret = jQuery("#eduseq_list").jqGrid('getRowData', rowid);
		}, 
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			showJqgridDataNon(data, "eduseq_list",5);
		}
	});
	//jq grid 끝 
	
	jQuery("#eduseq_list").jqGrid('navGrid', '#eduseq_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("eduseq_list", "eduseq_list_div");

});

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	//var str = $("#total_cnt").val()-(rowObject.rnum-1);
	var str = cellvalue + "회";
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:eduseqWrite('"+rowObject.seq_id+"')\">"+cellvalue+"</a>";
	
	return str;
}

function search() {
		
	jQuery("#eduseq_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectEduseqUrl,
		page : 1,
		postData : {
			p_year : $("#p_year").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function eduseqWrite(seqId) {
    var f = document.listFrm;
    var mode = "W";
    if(seqId != "") mode = "E";
    
	$("#mode").val(mode);
	$("#seq_id").val(seqId);
	
    f.action = eduseqWriteUrl;
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
	<input type='hidden' id="mode" name='mode' value="W" />
	
			<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>자격검증운영검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>운영년도</th>
					<td>
					  <select id="p_year" name="p_year" class="form-control input-sm">
					     <option value="">- 전체 -</option>  
	                     <c:forEach begin="0" end="10" var="idx" step="1">
	                     	 <option value="${curYear-idx}" <c:if test="${(curYear-idx) == param.p_year}">selected</c:if>>${curYear-idx}</option>
	                     </c:forEach>
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
			</div>
		</div>
		<!--// search_area -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:eduseqWrite('')" class="btn acti" title="등록">
					<span>등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
	
		<!-- table 1dan list -->
		<div class="table_area" id="eduseq_list_div" >
		    <table id="eduseq_list"></table>
	        <div id="eduseq_pager"></div>
		</div>
		<!--// table 1dan list -->
	</div>
	<!--// content -->
	</form>
