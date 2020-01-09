<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var statInspPageListUrl = "<c:url value='/admin/wbiz/statInspApplyPageList.do'/>";
var statInspWriteUrl =  "<c:url value='/admin/wbiz/statInspApplyWrite.do'/>";
var statInspDeleteUrl =  "<c:url value='/admin/wbiz/statInspApplyDelete.do'/>";

$(document).ready(function(){
    
	$('#statInsp_list').jqGrid({
		datatype: 'json',
		url: statInspPageListUrl,
		mtype: 'POST',
		colModel: [		
 			{ label: '번호', index: 'rnum', name: 'rnum', width: 40, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '이름', index: 'pic_nm', name: 'pic_nm', align : 'center', width:50, sortable:false,formatter:jsTitleLinkFormmater},
			{ label: '소속기업명', index: 'cmpy_nm', name: 'cmpy_nm', align : 'left', width:80, sortable:false},
			{ label: '휴대전화', index: 'pic_clph_no', name: 'pic_clph_no', align : 'center', width:50, sortable:false},
			{ label: '이메일', index: 'pic_email', name: 'pic_email', width: 100, align : 'left', sortable:false},
			{ label: '신청일', index: 'reg_date', name: 'reg_date', width: 50, align : 'center', sortable:false},
			{ label: 'stats_app_sn', index: 'stats_app_sn', name: 'stats_app_sn', hidden : true , sortable:false}			
		],
		multiselect:true , 
		postData :{	
			invg_yy : $("#p_invg_yy").val(),
			searchField : $("#p_searchField").val(),
			searchText : $("#p_searchText").val()
		},		
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",		
		pager : '#statInsp_pager',
		viewrecords : true,
		sortname : "stats_app_sn",
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
			showJqgridDataNon(data, "statInsp_list", 7);
		}
	});
	 
	
	jQuery("#statInsp_list").jqGrid('navGrid', '#statInsp_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("statInsp_list", "statInsp_list_div");

});

//번호 정렬
function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#total_cnt").val() - (rowObject.rnum-1);
	return str;
}


function jsTitleLinkFormmater(cellvalue, options, rowObject) {	
	var str = "<a href=\"javascript:statInspWrite('"+rowObject.stats_app_sn+"')\">"+rowObject.pic_nm+"</a>";
	return str;
}

function search() {
		
	jQuery("#statInsp_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : statInspPageListUrl,
		page : 1,
		postData : {
			invg_yy : $("#p_invg_yy").val(),
			searchField : $("#p_searchField").val(),
			searchText : $("#p_searchText").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function statInspWrite(stats_app_sn) {
	
    var f = document.listFrm;
    var mode = "W";
    
    if(stats_app_sn != ""){
    	mode = "E";
    }
	
	goUrl( '3' , '<c:url value="/admin/wbiz/statInspApplyWrite.do" />?mode=E&stats_app_sn=' + stats_app_sn , 1280 ,700, 0, 0);	
	
}

function formReset(){
	$("select[name=p_invg_yy] option[value='']").attr("selected",true);
	$("select[name=p_searchField] option[value='']").attr("selected",true);	
	$("#p_searchText").val("");	
}

function statInspApplyDelete(){
	
    var ids = jQuery("#statInsp_list").jqGrid('getGridParam','selarrrow');
    var param = [];
    var str_param = '';
    
    if( ids.length == 0 ){
    	alert( '삭제할 데이터가 없습니다.' );
    	return false;
    }
        
    for(var i = 0 ; i < ids.length ; i++){
        var rowObject = $("#statInsp_list").getRowData(ids[i]);
        param.push( rowObject.stats_app_sn );        
    }
    
    if( ! confirm("통계조사 신청내역을 삭제하시겠습니까?")) return;
    str_param = param.join( ',' );
    
    //alert( str_param );
	   
	$.ajax
	({
		type: "POST",
           url: statInspDeleteUrl,
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
		<input type='hidden' id="stats_app_sn" name='stats_app_sn' value="" />
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
					<th>신청년도</th>
					<td>
						<select id="p_invg_yy" name="p_invg_yy">
							<option value="">- 전체 -</option>
							<option value="2018" <c:if test="${param.invg_yy eq '2018' }" >selected="selected"</c:if> >2018</option>
							<option value="2019" <c:if test="${param.invg_yy eq '2019' }" >selected="selected"</c:if> >2019</option>
							<option value="2020" <c:if test="${param.invg_yy eq '2020' }" >selected="selected"</c:if> >2020</option>
							<option value="2021" <c:if test="${param.invg_yy eq '2021' }" >selected="selected"</c:if> >2021</option>
							<option value="2022" <c:if test="${param.invg_yy eq '2022' }" >selected="selected"</c:if> >2022</option>
							<option value="2023" <c:if test="${param.invg_yy eq '2023' }" >selected="selected"</c:if> >2023</option>
							<option value="2024" <c:if test="${param.invg_yy eq '2024' }" >selected="selected"</c:if> >2024</option>
							<option value="2025" <c:if test="${param.invg_yy eq '2025' }" >selected="selected"</c:if> >2025</option>
							<option value="2026" <c:if test="${param.invg_yy eq '2026' }" >selected="selected"</c:if> >2026</option>
							<option value="2027" <c:if test="${param.invg_yy eq '2027' }" >selected="selected"</c:if> >2027</option>
							<option value="2028" <c:if test="${param.invg_yy eq '2028' }" >selected="selected"</c:if> >2028</option>
							<option value="2029" <c:if test="${param.invg_yy eq '2029' }" >selected="selected"</c:if> >2029</option>							
							<option value="2030" <c:if test="${param.invg_yy eq '2030' }" >selected="selected"</c:if> >2030</option>
						</select>
						
					</td>					
					<th>검색구분</th>
					<td>
						<select id="p_searchField" name="p_searchField">
							<option value="pic_nm" <c:if test="${param.searchField eq 'pic_nm' }" >selected="selected"</c:if>>이름</option>
							<option value="pic_clph_no" <c:if test="${param.searchField eq 'pic_clph_no' }" >selected="selected"</c:if>>휴대전화</option>														
							<option value="pic_email" <c:if test="${param.searchField eq 'pic_email' }" >selected="selected"</c:if>>이메일</option>
						</select>						
						<input type="input" id="p_searchText" name="p_searchText" value="<c:out value="${param.searchText}" escapeXml="true" />"  placeholder="검색어" class="in_w70">						
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
				<button class="btn acti" id="btn_excel_kr" title="엑셀다운로드" onclick="location.href='/admin/wbiz/statInspApplySelectListExcel.do';return false;">
					<span>엑셀다운로드</span>
				</button>
			</div>
		</div>
	
		<!-- table 1dan list -->
		<div class="table_area" id="statInsp_list_div" >
		    <table id="statInsp_list"></table>
	        <div id="statInsp_pager" style="display: none;"></div>
		</div>
		<!--// table 1dan list -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:statInspApplyDelete('')" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
</div>
<!--// content -->