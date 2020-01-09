<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript">

$(document).ready(function(){
    
	search();	
	
});
	


function search() {
    var f = document.listFrm;
 
	$('#list_div').html("");
	
    $.ajax({
        url: "/admin/stats/menuconnMonthList.do",
        dataType: "json",
        type: "post",
        data: {
           conn_year : $("#p_conn_year").val(),
		},
        success: function(data) {    	
            searchResult(data.dataList);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}



//조회 결과를 설정
function searchResult(list){    
 	
	var str = "", menu_nm_2level = "", pre_menu_id = "";
	var menu;
				
	// 메뉴 구성
	for(var i = 0; i < list.length; i++){
	    
	    menu = list[i];
	    
	    // Top 메뉴 일 경우 (1 레벨)
	    if(menu.menu_level == 1){
		    str += '<tr class="title">';
			str += '	<td colspan="14">'+menu.menu_nm+'</td>';	
		    str += '</tr">';
	    } 

	    // Sub 메뉴 일 경우 (2 레벨)
	    else if(menu.menu_level == 2){       
		
			if(menu.sub_cnt == 0){
			    
			    str += '<tr>';
				str += '	<td>'+menu.menu_nm+'</td>';	
				str += '	<td></td>';					

			    for(var k = 1; k <= 12; k++){
					str += '	<td>'+ getMonthConnCount (menu, k)+'</td>';	
				}
			    
			    str += '</tr">'; 
			    
		    } else {
				menu_nm_2level = menu.menu_nm;
		    }
	    }
		
	    // Sub 메뉴 일 경우 (3 레벨)
	    else if(menu.menu_level == 3){   
		
		    str += '<tr>';
			str += '	<td>'+menu_nm_2level+'</td>';	
			str += '	<td>'+menu.menu_nm+'</td>';	
			
			for(var k = 1; k <= 12; k++){
				str += '	<td>'+ getMonthConnCount (menu, k)+'</td>';	
			}
			
		    str += '</tr">';    
	    }
	}
	
	$('#list_div').html(str);

};


//월별 접속 갯수를 리턴한다.
function getMonthConnCount(menu, month){
   if(month == 1) return menu.conn_cnt_1;
   else if(month == 2) return menu.conn_cnt_2;
   else if(month == 3) return menu.conn_cnt_3;
   else if(month == 4) return menu.conn_cnt_4;
   else if(month == 5) return menu.conn_cnt_5;
   else if(month == 6) return menu.conn_cnt_6;
   else if(month == 7) return menu.conn_cnt_7;
   else if(month == 8) return menu.conn_cnt_8;
   else if(month == 9) return menu.conn_cnt_9;
   else if(month == 10) return menu.conn_cnt_10;
   else if(month == 11) return menu.conn_cnt_11;
   else if(month == 12) return menu.conn_cnt_12;
   else return "0";
}; 

</script>


<form id="listFrm" name="listFrm" method="post">

	<!-- content -->
	<div id="content">
	
		<!-- title_and_info_area -->
		<div class="title_and_info_area">
		
			<!-- main_title -->
			<div class="main_title">
				<h3 class="title">월별</h3>
			</div>
			<!--// main_title -->
			
		</div>	
		<!--// title_and_info_area -->
		
		<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>월별 통계 목록 화면</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>년도</th>
					<td>
						<label for="p_conn_year" class="hidden">연도선택</label>
						<select class="in_wp100" id="p_conn_year">
							<c:forEach var="i" begin="2016" end="2025">
							    <c:set var="yearOption" value="${i}" />
							    <option value="${yearOption}" <c:if test="${yearOption == curYear}">selected</c:if> >${yearOption}년</option>
							</c:forEach>
						</select>
					</td>
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
				
		<!-- table_area -->
		<div class="table_area">
			<table class="list">
				<caption>월별 통계 목록 화면</caption>
				<colgroup>
					<col style="width: 15%;">
					<col style="width: 15%;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">2Depth</th>
						<th scope="col">3Depth</th>
						<th scope="col">1월</th>
						<th scope="col">2월</th>
						<th scope="col">3월</th>
						<th scope="col">4월</th>
						<th scope="col">5월</th>
						<th scope="col">6월</th>
						<th scope="col">7월</th>
						<th scope="col">8월</th>
						<th scope="col">9월</th>
						<th scope="col">10월</th>
						<th scope="col">11월</th>
						<th scope="col">12월</th>
					</tr>
				</thead>
				<tbody id="list_div">
				</tbody>
			</table>
		</div>
		
	</div>
	<!--// content -->
	
</form>