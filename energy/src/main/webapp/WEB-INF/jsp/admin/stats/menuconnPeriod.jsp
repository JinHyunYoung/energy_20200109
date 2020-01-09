<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script type="text/javascript">

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
        url: "/admin/stats/menuconnPeriodList.do",
        dataType: "json",
        type: "post",
        data: {
           conn_startdt : $("#p_conn_startdt").val(),
           conn_enddt : $("#p_conn_enddt").val()
		},
        success: function(data) {    	
            searchResult(data.dataList);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}


function searchResult(list){    
	
	var str = "", menu_nm_2level = "";
	var menu;
				
	// 메뉴 구성
	for(var i = 0; i < list.length; i++){
	    
	    menu = list[i];
	    
	    if(menu.conn_cnt == null || menu.conn_cnt == 'undefined'){
			menu.conn_cnt = 0;
	    }
	    
	    // Top 메뉴 일 경우 (1 레벨)
	    if(menu.menu_level == 1){
		    str += '<tr class="title">'
			str += '	<td colspan="3">'+menu.menu_nm+'</td>';	
		    str += '</tr">'
	    } 

	    // Sub 메뉴 일 경우 (2 레벨)
	    else if(menu.menu_level == 2){       
		
			if(menu.sub_cnt == 0){
			    str += '<tr>'
				str += '	<td>'+menu.menu_nm+'</td>';	
				str += '	<td></td>';	
				str += '	<td>'+menu.conn_cnt+'</td>';	
			    str += '</tr">'					
		    } else {
				menu_nm_2level = menu.menu_nm;
		    }
	    }
		
	    // Sub 메뉴 일 경우 (3 레벨)
	    else if(menu.menu_level == 3){   
		    str += '<tr>'
			str += '	<td>'+menu_nm_2level+'</td>';	
			str += '	<td>'+menu.menu_nm+'</td>';	
			str += '	<td>'+menu.conn_cnt+'</td>';	
		    str += '</tr">'		
	    }		    		
	}
	
	$('#list_div').html(str);
    
}


function formReset(){
	$("#p_conn_startdt").val("");
	$("#p_conn_enddt").val("");
}
</script>

	
<form id="listFrm" name="listFrm" method="post">

	<!-- content -->
	<div id="content">
	
		<!-- title_and_info_area -->
		<div class="title_and_info_area">
		
			<!-- main_title -->
			<div class="main_title">
				<h3 class="title">기간별</h3>
			</div>
			<!--// main_title -->
			
		</div>	
		<!--// title_and_info_area -->
		
		<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>기간별 통계 목록 화면</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>기간</th>
					<td>
                     	<input type="text" id="p_conn_startdt" name="p_conn_startdt" class="in_wp100 datepicker" readonly value="${curdate}"> ~ 
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
			
		<!-- table_area -->
		<div class="table_area">
		
			<table class="list">
				<caption>기간별 통계 목록 화면</caption>
				<colgroup>
					<col style="width: 33%;" />
					<col style="width: 33%;" />
					<col style="width: *;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">2Depth</th>
						<th scope="col">3Depth</th>
						<th scope="col">페이지뷰</th>
					</tr>
				</thead>
				<tbody id="list_div">
				</tbody>
			</table>
		</div>
	</div>
	<!--// content -->

</form>