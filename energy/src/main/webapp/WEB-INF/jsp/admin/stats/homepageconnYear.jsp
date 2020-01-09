<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var selectHomepageconnYearListUrl = "<c:url value='/admin/stats/homepageconnYearList.do'/>";

$(document).ready(function(){

	$('#year_list').jqGrid({
		datatype: 'json',
		url: selectHomepageconnYearListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '연도', index: 'conn_yyyy', name: 'conn_yyyy',  align : 'center', sortable:false, width:200},
			{ label: '방문자(명)', index: 'tot_user_cnt', name: 'tot_user_cnt', align : 'center', sortable:false, width:200}
		],
		postData :{	
	     },
		rowNum : -1,
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
		loadComplete : function(data) {
			showJqgridDataNon(data, "year_list",3);
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("year_list", "year_list_div");

});

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
	
		<!-- table 1dan list -->
		<div class="table_area">
			<table class="list fixed">
				<caption>리스트 화면</caption>
				<colgroup>
					<col style="width: 50%;" />
					<col style="width: 50%;" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">오늘방문자(명)</th>
					<th class="last" scope="col">누적방문자(명)</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<th class="first">${conntot.today_cnt}</th>
					<td class="last">${conntot.whole_cnt}</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->

		<!-- table 1dan list -->
		<div class="table_area" id="year_list_div" >
		    <table id="year_list"></table>
		</div>
		<!--// table 1dan list -->
		
	</form>
	
</div>
<!--// content -->
  
		 		