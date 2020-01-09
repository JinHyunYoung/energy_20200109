<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript">

$(document).ready(function(){
    
	search();	

});
	
// 통계 조회
function search() {
    var f = document.listFrm;
 
	$('#list_div').html("");
	
    $.ajax({
        url: "/admin/stats/menuconnDayList.do",
        dataType: "json",
        type: "post",
        data: {
           conn_year : $("#p_conn_year").val(),
           conn_month : $("#p_conn_month").val(),
		},
        success: function(data) {    	
            searchResult(data.dataList);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}


// 조회 결과를 설정
function searchResult(list){    
    
	var year = $("#p_conn_year").val();
	var month = $("#p_conn_month").val();	
	var lastDay = new Date(year, month, 0).getDate();
		
	makeHeader(lastDay);
	
	var str = "", menu_nm_2level = "", pre_menu_id = "";
	var menu;
				
	// 메뉴 구성
	for(var i = 0; i < list.length; i++){
	    
	    menu = list[i];
	    
	    // Top 메뉴 일 경우 (1 레벨)
	    if(menu.menu_level == 1){
		    str += '<tr class="title">';
			str += '	<td colspan="'+(lastDay+2)+'">'+menu.menu_nm+'</td>';	
		    str += '</tr">';
	    } 

	    // Sub 메뉴 일 경우 (2 레벨)
	    else if(menu.menu_level == 2){       
		
			if(menu.sub_cnt == 0){
			    
			    str += '<tr>';
				str += '	<td>'+menu.menu_nm+'</td>';	
				str += '	<td></td>';					

			    for(var k = 1; k <= lastDay; k++){
					str += '	<td>'+ getDayConnCount (menu, k)+'</td>';	
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
			
			for(var k = 1; k <= lastDay; k++){
				str += '	<td>'+ getDayConnCount (menu, k)+'</td>';	
			}
			
		    str += '</tr">';    
	    }
	}
	
	$('#list_div').html(str);

};


//그리드 헤더의 일자를 설정
function makeHeader(lastDay){   

	$('#list_header_div').html("");
	
	var str = "";
	
	str += '<th scope="col">2Depth</th>';
	str += '<th scope="col">3Depth</th>';

	for(var i = 1; i <= lastDay; i++){
		str += '<th scope="col">'+i+'일</th>';
	}
	
	$('#list_header_div').html(str);
}


// 일자별 접속 갯수를 리턴한다.
function getDayConnCount(menu, day){
   if(day == 1) return menu.conn_cnt_1;
   else if(day == 2) return menu.conn_cnt_2;
   else if(day == 3) return menu.conn_cnt_3;
   else if(day == 4) return menu.conn_cnt_4;
   else if(day == 5) return menu.conn_cnt_5;
   else if(day == 6) return menu.conn_cnt_6;
   else if(day == 7) return menu.conn_cnt_7;
   else if(day == 8) return menu.conn_cnt_8;
   else if(day == 9) return menu.conn_cnt_9;
   else if(day == 10) return menu.conn_cnt_10;
   else if(day == 11) return menu.conn_cnt_11;
   else if(day == 12) return menu.conn_cnt_12;
   else if(day == 13) return menu.conn_cnt_13;
   else if(day == 14) return menu.conn_cnt_14;
   else if(day == 15) return menu.conn_cnt_15;
   else if(day == 16) return menu.conn_cnt_16;
   else if(day == 17) return menu.conn_cnt_17;
   else if(day == 18) return menu.conn_cnt_18;
   else if(day == 19) return menu.conn_cnt_19;
   else if(day == 20) return menu.conn_cnt_20;
   else if(day == 21) return menu.conn_cnt_21;
   else if(day == 22) return menu.conn_cnt_22;
   else if(day == 23) return menu.conn_cnt_23;
   else if(day == 24) return menu.conn_cnt_24;
   else if(day == 25) return menu.conn_cnt_25;
   else if(day == 26) return menu.conn_cnt_26;
   else if(day == 27) return menu.conn_cnt_27;
   else if(day == 28) return menu.conn_cnt_28;
   else if(day == 29) return menu.conn_cnt_29;
   else if(day == 30) return menu.conn_cnt_30;
   else if(day == 31) return menu.conn_cnt_31;
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
				<h3 class="title">일자별</h3>
			</div>
			<!--// main_title -->
			
		</div>	
		<!--// title_and_info_area -->
		
		<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>일자별 통계 목록 화면</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>년도/월</th>
					<td>
						<label for="p_conn_year" class="hidden">연도선택</label>
						<select class="in_wp100" id="p_conn_year">
							<c:forEach var="i" begin="2016" end="2025">
							    <c:set var="yearOption" value="${i}" />
							    <option value="${yearOption}" <c:if test="${yearOption == curYear}">selected</c:if> >${yearOption}년</option>
							</c:forEach>
						</select>
						
						<label for="p_conn_month" class="hidden">월선택</label>
						<select class="in_wp100" id="p_conn_month">
							<c:forEach var="i" begin="1" end="12">
							    <c:set var="monthOption" value="${i}" />
							    <option value="${monthOption}" <c:if test="${monthOption == curMonth}">selected</c:if> >${monthOption}월</option>
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
					<col style="width: 10%;">
					<col style="width: 10%;">
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
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
					<col style="width: *;">
				</colgroup>
				<thead>
					<tr id="list_header_div">
					</tr>
				</thead>
				<tbody id="list_div">
				</tbody>
			</table>
		</div>
		
	</div>
	<!--// content -->
	
</form>