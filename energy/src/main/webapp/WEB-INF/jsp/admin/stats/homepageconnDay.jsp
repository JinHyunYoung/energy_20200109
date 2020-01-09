<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script language="javascript">

var selectHomepageconnDayListUrl = "<c:url value='/admin/stats/homepageconnDayList.do'/>";

$(document).ready(function(){
	$('.datepicker').each(function(){
	    $(this).datepicker({
			  format: "yyyy-mm-dd",
			  language: "kr",
			  keyboardNavigation: false,
			  forceParse: false,
			  autoclose: true,
			  todayHighlight: true,
			  showOn: "button",
			  buttonImage:"/images/admin/icon/icon_calendar.png",
			  buttonImageOnly:true,
			  changeMonth: true,
	          changeYear: true,
	          showButtonPanel:false
			 });
	});
	
	$('#day_list').jqGrid({
		datatype: 'json',
		url: selectHomepageconnDayListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '일자', index: 'conn_dd', name: 'conn_dd',  align : 'center', sortable:false, width:200},
			{ label: '방문자(명)', index: 'tot_user_cnt', name: 'tot_user_cnt', align : 'center', sortable:false, width:200},
			{ label: '점유율', index: 'avg_user_conn', name: 'avg_user_conn', align : 'center', sortable:false, width:200}
		],
		postData :{	
	           conn_stadt : $("#p_conn_stadt").val(),
	           conn_enddt : $("#p_conn_enddt").val()
	     },
		rowNum : -1,
		viewrecords : true,
		height : "400px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit: true,
		editable: true,
		edittype :"text",
		cellsubmit : 'clientArray',
		footerrow: true,
		loadComplete : function(data) {
			showJqgridDataNon(data, "day_list",3);
			
    	    var userData = $("#day_list").jqGrid('getCol', 'tot_user_cnt', false, '');
        	var usersum = 0;
    	    for(var i = 0; i < userData.length; i++){		
    	    	usersum += parseInt(userData[i]);
    	    }
			$("#day_list").footerData('set',{conn_dd: '합계', tot_user_cnt: usersum, avg_user_conn : "100.0%"});
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("day_list", "day_list_div");

});

function search() {
	
	jQuery("#day_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectHomepageconnDayListUrl,
		page : 1,
		postData : {
           conn_stadt : $("#p_conn_stadt").val(),
           conn_enddt : $("#p_conn_enddt").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function formReset(){
	$("#p_conn_stadt").val("");
	$("#p_conn_enddt").val("");
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

		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>일자별</caption>
				<colgroup>
					<col style="width: 100px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>접속기간</th>
					<td>
	                     <input type="text" id="p_conn_stadt" name="p_conn_stadt" class="in_wp100 datepicker" readonly value="${curdate}"> ~ 
	                     <input type="text" id="p_conn_enddt" name="p_conn_enddt" class="in_wp100 datepicker" readonly value="${curdate}">
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
		<div class="table_area" id="day_list_div" >
		    <table id="day_list"></table>
		</div>
		<!--// table 1dan list -->
		
	</form>
	
</div>
<!--// content -->
  
		 		