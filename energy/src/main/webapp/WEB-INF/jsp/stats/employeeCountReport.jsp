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

	var indsTypeUrl = "<c:url value='/web/stats/employeeCountReport.do'/>";
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
		        		if( data != null &&data.industry != null ){
		            		drawChart("chart_container1", data.industry, "업종별", '#f68b12');
		        		}else{
		    	          	alert("업종별 데이타가 없습니다.");
		        		}
		        			
		        		if( data != null &&data.scale != null ){
		            		drawChart("chart_container2", data.scale, "규모별", "#42aeb8");
		        		}else{
		    	          	alert("규모별 데이타가 없습니다.");
		        		}
		        		if( data != null &&data.industry_year != null ){
		            		drawChart2("chart_container3", data.industry_year);
		        		}else{
		    	          	alert("연도별 업종 데이타가 없습니다.");
		        		}
		        		if( data != null &&data.scale_year != null ){
		            		drawChart2("chart_container4", data.scale_year);
		        		}else{
		    	          	alert("연도별 규모 데이타가 없습니다.");
		        		}
		        		if( data != null &&data.job_year != null ){
		            		drawChart2("chart_container5", data.job_year);
		        		}else{
		    	          	alert("직종별 종사자수 데이타가 없습니다.");
		        		}
			      	},
			      	error: function(e) {
			          	alert("테이블을 가져오는데 실패하였습니다.");
			      	}
			  	});
	}
	
	function drawChart(chart_container, list, type, color){
		$(chart_container).empty();
  		var rows = new google.visualization.DataTable();
  		rows.addColumn('string', '구분');
	    rows.addColumn('number',type);
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
		<h5 class="title">종사자 수</h5>
		<!-- graph_area -->
		<div class="division">
			<!-- left_area -->
			<div class="area48 float_left">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 명)</p>
					<div id="chart_container1" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 사업체 업종별 종사자 수 &gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '02-01'}">${item.contents}
						</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// left_area -->
			<!-- right_area -->
			<div class="area48 float_right">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 명)</p>
					<div id="chart_container2" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 사업체 규모별 종사자 수 &gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '02-02'}">${item.contents}
						</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// right_area -->
		</div>
	</div>	
	<div class="division50">
		<h5 class="title">종사자 수 추이</h5>
		<!-- graph_area -->
		<div class="division">
			<!-- left_area -->
			<div class="area48 float_left">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 명)</p>
					<div id="chart_container3" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 사업체 업종별 종사자 수  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '02-03'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// left_area -->
			<!-- right_area -->
			<div class="area48 float_right">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 명)</p>
					<div id="chart_container4" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 사업체 규모별 종사자 수  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '02-04'}">${item.contents}</c:if>
					</c:forEach>
				</div>
			</div>
			<!--// right_area -->
		</div>
		<!-- graph_area -->
		<div class="division">
				<div class="graph_box">
					<p class="graph_txt1">(단위 : 명)</p>
					<div id="chart_container5" >
						그래프 들어오는 영역
					</div>
					<p class="graph_txt2">&lt; 년도별 직군별 종사자 수  추이&gt;</p>
				</div>
				<div class="graph_infobox">
					<c:forEach var="item" items="${infoList}">
						<c:if test="${item.stats_info_m_cd eq '02-05'}">${item.contents}</c:if>
					</c:forEach>
				</div>
		</div>
		<!-- //graph_area -->
	</div>	
</div>
