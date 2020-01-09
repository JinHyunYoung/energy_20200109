<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script language="javascript">

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
	search();
});

function search() {
    var f = document.listFrm;
 
	$('#list_div').html("");
	
    $.ajax({
        url: "/admin/stats/homepageconnHourTable.do",
        dataType: "html",
        type: "post",
        data: {
           conn_stadt : $("#p_conn_stadt").val(),
           conn_enddt : $("#p_conn_enddt").val()
		},
        success: function(data) {
        	$('#list_div').html(data);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
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
				<caption>시간대별</caption>
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
		<div class="table_area" id="list_div" >
	
		</div>
		<!--// table 1dan list -->
		
	</form>

</div>
<!--// content -->
  
		 		