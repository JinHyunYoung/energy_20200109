<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   

<script type="text/javascript">

	// 차트를 사용하기 위한 준비입니다.
	google.charts.load('current', {packages : [ 'corechart', 'bar' ]});

	$( document ).ready(function(){
		google.charts.setOnLoadCallback(statistics);
		$( 'span.amount' ).number( true );

	});

	var indsTypeUrl = "<c:url value='/web/stats/rndReport.do'/>";
	// 조직 리스트 불러오기
	function statistics(){
		$.ajax(
				{
			    	url: indsTypeUrl,
			    	dataType: "json",
			    	type: "post",
			    	async: false,
			    	data: jQuery("#listFrm").serialize(),
			    	success: function( data )
			      	{
			    		console.log(data);
		        		if( data != null &&data.list_1 != null ){
		            		drawChart2("chart_container1", data.list_1);
		        		}else{
		    	          	alert("연도별 업종별 연구개발비 데이타가 없습니다.");
		        		}
		        			
		        		if( data != null &&data.list_2 != null ){
		            		drawChart2("chart_container2", data.list_2);
		        		}else{
		    	          	alert("연도별 규모별 연구개발비 데이타가 없습니다.");
		        		}

		        		if( data != null &&data.list_3 != null ){
		            		drawChart("chart_container3", data.list_3,"업종별", "#f68b12");
		        		}else{
		    	          	alert("업종별 연구개발비 데이타가 없습니다.");
		        		}
		        		
		        		if( data != null &&data.list_4 != null ){
		            		drawChart("chart_container4", data.list_4,"규모별", "#42aeb8");
		        		}else{
		    	          	alert("규모별 연구개발비 데이타가 없습니다.");
		        		}
		        		
		        		if( data != null &&data.list_5 != null ){
		            		drawChart2("chart_container5", data.list_5);
		        		}else{
		    	          	alert("연도별 업종별 자체 연구개발비 데이타가 없습니다.");
		        		}

		        		if( data != null &&data.list_6 != null ){
		            		drawChart2("chart_container6", data.list_6);
		        		}else{
		    	          	alert("연도별 규모별 자체 연구개발비 데이타가 없습니다.");
		        		}

		        		if( data != null &&data.list_7 != null ){
		            		drawChart2("chart_container7", data.list_7);
		        		}else{
		    	          	alert("연도별 업종별 자체 연구개발비 데이타가 없습니다.");
		        		}

		        		if( data != null &&data.list_8 != null ){
		            		drawChart2("chart_container8", data.list_8);
		        		}else{
		    	          	alert("연도별 규모별 자체 연구개발비 데이타가 없습니다.");
		        		}
			      	},
			      	error: function(e) {
			          	alert("테이블을 가져오는데 실패하였습니다.");
			      	}
			  	}
			);
	}

	function drawChart(chart_container, list, type, color){
		$(chart_container).empty();
  		var rows = new google.visualization.DataTable();
  		rows.addColumn('string', '구분');
	    rows.addColumn('number', type);
		for( var i = 0 ; i < list.length ; i++ ){
			var row = list[i];
			var arRow = new Array();
			arRow.push(row.nm );
			arRow.push(row.point );

			rows.addRow(arRow);
		}//for	

		var classicOptions = {
//			width: 500,
			height: 400,
			colors:[color],
			legend: {position: 'none'}
		};
		
		var classicChart = new google.visualization.ColumnChart(document.getElementById(chart_container));
		classicChart.draw(rows, classicOptions);
	}
	
	function drawChart2(chart_container, list){
		$(chart_container).empty();
  		var rows = new google.visualization.DataTable();
  		rows.addColumn('string', '구분');
	    rows.addColumn('number', '합계');
	    rows.addColumn('number', '2016');
	    rows.addColumn('number', '2015');
	    rows.addColumn('number', '2014');
		for( var i = 0 ; i < list.length ; i++ ){
			var row = list[i];
			var arRow = new Array();
			arRow.push(row.nm );
			arRow.push(row.point_0 );
			arRow.push(row.point_1 );
			arRow.push(row.point_2 );
			arRow.push(row.point_3 );

			rows.addRow(arRow);
		}//for	

		var classicOptions = {
			height: 400,
			colors:['#f68b12','#043d58','#42aeb8','#e5415c'],
			legend: {position: 'bottom'}
		
		};
		var classicChart = new google.visualization.ColumnChart(document.getElementById(chart_container));
		classicChart.draw(rows, classicOptions);

	}		

	function frmSubmit(){
		listFrm.submit();
		
	}
	
	//인쇄하기
	function graph_print(){
		var initBody  = document.body.innerHTML;
        document.body.innerHTML = contents.innerHTML;
     	
		window.print();  

        document.body.innerHTML = initBody;
	}
	
</script>
<div id="contents" class="sub_contents">
	<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
	
<!-- stati_search_area -->
		<div class="stati_search_area">
			<dl class="srh_dl">
				<dt class="srh_dt">
					<label for="select_gubun2">
						<strong class="color_pointr">*</strong> 보고년도(기준년도)
					</label>
				</dt>
				<dd class="srh_dd">
					<select id="select_gubun2" class="in_wp130" id="bs_yy" name="bs_yy" onchange="javascript:frmSubmit()">
						<c:forEach var="years" items="${list}">
							<option value="${years.bs_yy}" <c:if test="${years.bs_yy eq params.bs_yy }" >selected</c:if> >${years.issue_yy}(${years.bs_yy})</option>
						</c:forEach>
                     </select>
				</dd>
			</dl>
			<div class="topbtn_area">
					<button class="btn_download" title="통계표 다운로드" 
					<c:forEach var="years" items="${list}">
						<c:if test="${years.bs_yy eq params.bs_yy}"> onclick="window.location.href='/commonfile/fileidDownLoad.do?file_id=${years.stats_file_id}'"
						</c:if>
					</c:forEach>
					>
						<span>통계표 다운로드</span>
					</button>
				<a href="javascript:graph_print();" title="해당 게시물 프린트 하기">
					<img src="/images/web/icon/icon_print.png" alt="프린트" />
				</a>
			</div>
		</div>
		<!--// stati_search_area -->
	</form>
	
	<!-- stati_list_area -->
	<!-- division -->
	<div class="division50">
		<h5 class="title">연구개발비 현황 현황</h5>
		<!-- graph_area -->
		<div class="division">
			<!-- left_area -->
			<div class="area48 float_left">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 백만원)</p>
					<div id="chart_container1" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 업종별 연구개발비 추이 &gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-01'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// left_area -->
			<!-- right_area -->
			<div class="area48 float_right">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 백만원)</p>
					<div id="chart_container2" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 규모별 연구개발비 추이 &gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-02'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// right_area -->
		</div>
	</div>	
	<div class="division50">
		<h5 class="title">연구개발비 지출 비율</h5>
		<!-- graph_area -->
		<div class="division">
			<!-- left_area -->
			<div class="area48 float_left">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : %)</p>
					<div id="chart_container3" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 사업체 업종별 연구개발비 지출 비율&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-03'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// left_area -->
			<!-- right_area -->
			<div class="area48 float_right">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : %)</p>
					<div id="chart_container4" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 사업체 규모별 연구개발비 지출 비율&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-04'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// right_area -->
		</div>
		<!-- graph_area -->
	</div>	
	<div class="division50">
		<h5 class="title">자체 연구개발비 추이</h5>
		<!-- graph_area -->
		<div class="division">
			<!-- left_area -->
			<div class="area48 float_left">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 백만원)</p>
					<div id="chart_container5" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 업종별 자체 연구개발비  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-05'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// left_area -->
			<!-- right_area -->
			<div class="area48 float_right">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 건)</p>
					<div id="chart_container6" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 자체연구개발비 수입액  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-06'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// right_area -->
		</div>
		<!-- graph_area -->
	</div>	
	<div class="division50">
		<h5 class="title">수탁 연구개발비 추이</h5>
		<!-- graph_area -->
		<div class="division">
			<!-- left_area -->
			<div class="area48 float_left">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 백만원)</p>
					<div id="chart_container7" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 업종별 수탁 연구개발비  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-07'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// left_area -->
			<!-- right_area -->
			<div class="area48 float_right">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 건)</p>
					<div id="chart_container8" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 규모별 수탁 연구개발비  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '04-08'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// right_area -->
		</div>
		<!-- graph_area -->
	</div>	
</div>

