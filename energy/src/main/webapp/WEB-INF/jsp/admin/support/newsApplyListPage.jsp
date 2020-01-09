<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var newsApplyPageListUrl = "<c:url value='/admin/newsApply/newsApplyPageList.do'/>";
var newsApplyDeleteUrl =  "<c:url value='/admin/newsApply/newsApplyDelete.do'/>";

$(document).ready(function(){
    
	$('#newsApply_list').jqGrid({
		datatype: 'json',
		url: newsApplyPageListUrl,
		mtype: 'POST',
		colModel: [		
 			{ label: '번호', index: 'rnum', name: 'rnum', width: 40, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '이름', index: 'name', name: 'name', align : 'center', width:70, sortable:false},
			{ label: '이메일', index: 'email', name: 'email', align : 'center', width:100, sortable:false},
			{ label: '신청/해지', index: 'app_stt_cd', name: 'app_stt_cd', align : 'center', width:50, sortable:false, formatter:jsDomesticFormmater},
			{ label: '신청일', index: 'reg_date', name: 'reg_date', width: 80, align : 'center', sortable:false},
			{ label: 'app_sn', index: 'app_sn', name: 'app_sn', hidden : true , sortable:false}						
		],
		multiselect:true , 
		postData :{	
			searchField : $("#searchField").val(),
			searchText : $("#searchText").val()
		},		
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",		
		pager : '#newsApply_pager',
		viewrecords : true,
		sortname : "app_sn",
		sortorder : "desc",
		height : "350px",
		gridview : true,
		autowidth : true,
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },		
		loadComplete : function(data) {
			showJqgridDataNon(data, "newsApply_list", 7);
		}
	});
	 
	
	jQuery("#newsApply_list").jqGrid('navGrid', '#newsApply_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("newsApply_list", "newsApply_list_div");

});

//번호 정렬
function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#total_cnt").val() - (rowObject.rnum-1);
	return str;
}


function jsDomesticFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.app_stt_cd == "Y"){
		str = "신청";
	}else{
		str = "해지";
	}
	return str;
}


function search() {
		
	jQuery("#newsApply_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : newsApplyPageListUrl,
		page : 1,
		postData : {
			searchField : $("#searchField").val(),
			searchText : $("#searchText").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function formReset(){
	$("select[name=searchField] option[value='name']").attr("selected",true);
	$("#searchText").val("");
}

function newsApplyDelete(){
	
    var ids = jQuery("#newsApply_list").jqGrid('getGridParam','selarrrow');
    var param = [];
    var str_param = '';
    
    if( ids.length == 0 ){
    	alert( '삭제할 데이터가 없습니다.' );
    	return false;
    }
        
    for(var i = 0 ; i < ids.length ; i++){
        var rowObject = $("#newsApply_list").getRowData(ids[i]);
        param.push( rowObject.app_sn );        
    }
    
    if( ! confirm("뉴스레터 신청내역을 삭제하시겠습니까?")) return;
    str_param = param.join( ',' );
	   
	$.ajax
	({
		type: "POST",
           url: newsApplyDeleteUrl,
           data:{
           	list_app_sn : str_param
           },
           dataType: 'json',
		success:function(data){
			//alert(data.message);
			if(data.success == "true"){
				search();
			}	
		}
	});
    
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
					<th>검색구분</th>
					<td colspan="3">
						<select id="searchField" name="searchField">
							<option value="name" <c:if test="${param.searchField eq 'name' }" >selected="selected"</c:if>>이름</option>
							<option value="email" <c:if test="${param.searchField eq 'email' }" >selected="selected"</c:if>>이메일</option>														
						</select>						
						<input type="input" id="searchText" name="searchText" value="<c:out value="${param.searchText}" escapeXml="true" />"  placeholder="검색어" class="in_w70">
						
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
		<div class="table_search_area">
			<div class="float_left">
				<button class="btn acti" id="btn_excel_kr" title="엑셀다운로드" onclick="location.href='/admin/newsApply/newsApplyPageListExcel.do';return false;">
					<span>엑셀다운로드</span>
				</button>
			</div>
		</div>
	
		<!-- table 1dan list -->
		<div class="table_area" id="newsApply_list_div" >
		    <table id="newsApply_list"></table>
	        <div id="newsApply_pager" ></div>
		</div>
		<!--// table 1dan list -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:newsApplyDelete()" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
</div>
<!--// content -->