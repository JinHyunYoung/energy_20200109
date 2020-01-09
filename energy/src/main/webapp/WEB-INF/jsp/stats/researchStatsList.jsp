<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, user-scalable=yes, target-densitydpi=medium-dpi" />
	
	<title></title>
	
	<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
	
	<link rel="stylesheet" type="text/css" href="/css/web/default.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/nanumgothic.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/common.css" />
	<link rel="stylesheet" type="text/css" href="/css/modal.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directory.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directorySub.css" />

	<script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
    <script type="text/javascript" src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   
    
   	<script type="text/javascript" src="/assets/bootstrap/js/bootstrap.js"></script>
    
	<script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>
	
	<script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>
	<script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>
	
	<script type="text/javascript" src="/js/directory.js"></script>	
	
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=5_eIOVdKRzwrAXq79hRn&callback=initMap&submodules=geocoder"></script>
	
	<!--[if lt IE 9]>
		<script type="text/javascript" src="/js/html5.js"></script>
	<![endif]-->	
	
<script language="javascript">
var bPopup = false;
$(document).ready(function(){
	
	$('#btn_setting').on("click",function(){
		if (bPopup == false) {
			$( '#pop_itemSetting' ).html( "" );
		    $.ajax({
		        url: "/web/stats/researchStatsItemPop.do",
		        dataType: "html",
		        type: "post",
		    	data: jQuery("#itemListFrm").serialize(),
		        success: function(data) {
		        	$( '#pop_itemSetting' ).html( data );
		    	    makeJsTree();
		    	    
		    		load_stat_s_cd();
		    		bPopup = true;
		        },
		        error: function(e) {
		            alert( '데이터를 가져오는데 실패했습니다.' );
		        }
		    });
		}
		popupShow();
	    
	});

	$('#btn_download').on("click",function(){
		alert("개발중");
	});
	
	$('#btn_list').on("click",function(){
		var f = document.itemListFrm;
		f.action = "/web/stats/researchStatsTable.do";
		f.submit();
	});
});

function makeJsTree(){	
	$('#menu_jstree').jstree({
		"core" : {
			"data" : {
				 'cache':false,
				'url' : "<c:url value='/web/stats/wbizTreeList.do'/>" ,
				'data' : {
					inds_tp_cd : $("#inds_tp_cd").val()
				},
				"dataType" : "json",
				'success': function(res) {
//					console.log(res);
				},
				'error' : function (e) {
				}
			},
            'themes': {
                'name': 'proton',
                'responsive': true
            },
			"check_callback" : true
		},
		'search' : {
			'fuzzy' : false
		},
	    'checkbox': {
            "keep_selected_style": false
         },
		"plugins" : [ "types", "search", "checkbox"]
	}).bind("loaded.jstree refresh.jstree",function(event,data){
    	$(this).jstree("open_all");
//    	$(this).jstree("check_all");
    	getAllNodeData();
    	$(this).jstree("select_node", '#'+$("#wbiz_tp_s_cd").val());
    }).bind("select_node.jstree", function (event, data) {
		$("#wbiz_tp_s_cd").val(data.node.id);
    });
};

function load_stat_s_cd(){
    $.ajax({
        url: "/web/stats/researchCodeList.do",
        dataType: "json",
        type: "post",
    	data: {
    		gubun : "STATS_S_CD",
    		code : $("#stats_m_cd").val()
    	},
        success: function(data) {
    		var str = "";
        	if( data.list != null && data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
		    		str += '<li>';
		    		str += '	<input id="stats_s_cd_'+i+'" name="stats_s_cd" type="checkbox" ';
		    		
		    		str += ' value="'+data.list[i].code+'" />';
		    		str += '	<label for="stats_s_cd_'+i+'" >'+data.list[i].code_nm+'</label>';
		    		str += '</li>';
        		}
        	}
        	$('#stats_s_list').html(str);
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
    });

}

function getAllNodeData(){
	var jstEdit = $.jstree.reference('#menu_jstree');
	
	var v =$("#menu_jstree").jstree(true).get_json('#', { 'flat': true });
	
	for(var i=0;i<v.length;i++){
	    var node = jstEdit.get_node(v[i].id);
	    if(node.original.auth_yn == "Y") jstEdit.check_node(v[i].id);
	}
}  

function popupShow(){
	$("#modal-stat-research").popup('show');
}

function popupClose(){
	$("#modal-stat-research").popup('hide');
}

function resetCondition(){
	$('#menu_jstree').jstree("uncheck_all");
	$("input[name=stats_s_cd]").removeAttr("checked");
	
}

function selectStatsListResult(){
	var url = "";
	var wbiz_tp_s_items = new Array();
	var tree =  $("#menu_jstree").jstree("get_selected", true);
	  
	$.each(tree, function(i){	
		if((tree[i].id != "0000000000") && (tree[i].original.lvl == "3")){
			wbiz_tp_s_items.push(tree[i].id); 
		}
	});
	  
	var stats_s_items = new Array();
	$("input[name=stats_s_cd]:checked").each(function(){
		stats_s_items.push($(this).val());	 
	});
	
	if(wbiz_tp_s_items.length < 1){
	   alert("조회할 물산업분류체계를 선택해 주십시요.");
	   return;
	}
	
	if(stats_s_items.length < 1){
		   alert("조회할 통계표를 선택해 주십시요.");
		   return;
	}
		
	$.ajax({
	        url: "/web/stats/loadResearchData.do",
	        dataType: "html",
	        type: "post",
	        data: {
	  		   bs_yy : $("#bs_yy").val(),
	  		   inds_tp_cd : $("#inds_tp_cd").val(),
	  		   stats_m_cd : $("#stats_m_cd").val(),
	  		   stats_m_nm : $("#stats_m_nm").val(),
//	  		   stats_s_list : stats_s_items,
//	  		   wbiz_tp_s_list : wbiz_tp_s_items
	  		   stats_s_list : JSON.stringify(stats_s_items),
	  		   wbiz_tp_s_list : JSON.stringify(wbiz_tp_s_items)
			},
	        success: function(data) {
	        	$('#researchResult').html(data);
	        },
	        error: function(e) {
	            alert("테이블을 가져오는데 실패하였습니다.");
	        }
		});
 	popupClose();
}//function refreshStatsData(){
	
//엑셀다운로드
function downloadExcel() {	
	alert("개발중");
	var url = '/web/stats/statsResearchtExcelDownload.do?bs_yy='+$("#p_bs_yy").val();
	if ($("#p_bs_yy").val() =="") {
		alert("기준년도는 필수입니다.");
		return ;
	}

	location.href=url;
}
	
//인쇄하기
function graph_print(){
	var initBody = document.body.innerHTML;
    document.body.innerHTML = sub_content.innerHTML;
	window.print();  
    document.body.innerHTML = initBody;
}	
	
</script>
</head>

<body>
<div id="sub_content" class="sub_content">
	<!--// stati_search_area -->
	<div class="statistics_search_area">
		<a href="/web/stats/researchStatsTable.do" class="statistics_btn">
			<span>통계표 찾기</span>
		</a>
	</div>
	<!-- search_area -->
	<div class="stati_search_area">
		<ul class="stati_location_list">
			<li>${params.inds_tp_nm}</li>
			<li>${params.stats_l_nm}</li>
			<li>
				<strong>${params.stats_m_nm}</strong>
			</li>
		</ul>
		<div class="topbtn_area">
			<button type="button" id="btn_setting" class="btn_setting" title="항목설정">
				<span>항목설정</span>
			</button>
			
			<button id="btn_download" class="btn_download" title="통계표 다운로드" onClick="javascript:downloadExcel()">
				<span>통계표 다운로드</span>
			</button>
				<a href="javascript:graph_print();" title="해당 게시물 프린트 하기">
					<img src="/images/web/icon/icon_print.png" alt="프린트" />
				</a>
		</div>
	</div>
	<!-- division -->
	<div class="area_xscroll marginb10">
		<form id="itemListFrm" name="itemListFrm" method="post" onsubmit="return false;">
			<input type='hidden' id="inds_tp_cd" name="inds_tp_cd" value="${params.inds_tp_cd}"/> 
			<input type='hidden' id="wbiz_tp_s_cd" name="wbiz_tp_s_cd" value="${params.wbiz_tp_s_cd}"/> 
			<input type='hidden' id="bs_yy" name="bs_yy" value="${params.bs_yy}"/> 
			<input type='hidden' id="stats_m_cd" name='stats_m_cd' value="${params.stats_m_cd}" />
			<input type='hidden' id="stats_m_nm" name='stats_m_nm' value="${params.stats_m_nm}" />
			<table id="researchResult" class="statistics_list fixed">
				<caption>리스트 화면</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 180px;" />
					<col style="width: 180px;" />
					<col style="width: 180px;" />
					<c:forEach var="item" items="${stats_title}" >
						<c:forEach var="i" items="${item.name}" varStatus="status">
							<col style="width: 70px;" />
						</c:forEach>
					</c:forEach>
						<c:if test="${empty stats_title}">
								<col style="width: *;" />
						</c:if>
				</colgroup>
				<thead>
					<tr>
						<th scope="col" rowspan="2" class="first">업종</th>
						<th scope="col" rowspan="2">대분류</th>
						<th scope="col" rowspan="2">중분류</th>
						<th scope="col" rowspan="2">소분류</th>
						<th scope="col" colspan="1" class="last">통계표</th> 
					</tr>
				</thead>
			</table>
		</form>
	</div>
</div>

<div id="modal-stat-research" style="background-color:white">
	<div id="wrap">
	
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			    <div  id="pop_itemSetting" >
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->
	</div>
 </div>
 <iframe id="hiddenExcelDownloadFrm" style="display:none">
 </iframe>
</body>
</html>