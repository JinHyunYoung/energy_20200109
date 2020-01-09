<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/jstree/dist/themes/proton/style.min.css" />

<script type="text/javascript" src="/assets/jstree/dist/jstree.js"></script>

<script language="javascript">

var selectAuthListUrl = "<c:url value='/admin/auth/authList.do'/>";

var insertAuthMenuUrl = "<c:url value='/admin/menu/insertAuthMenu.do'/>";
var selectManagerMenuTreeListUrl = "<c:url value='/admin/menu/managerMenuTreeList.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#auth_list').jqGrid({
		datatype: 'json',
		url: selectAuthListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '권한그룹', index: 'grp_nm', name: 'grp_nm', align : 'left', sortable:false, width:80},
			{ label: '권한코드', index: 'auth_id', name: 'auth_id', align : 'center', sortable:false, width:100},
			{ label: '권한명', index: 'auth_nm', name: 'auth_nm', align : 'left', sortable:false, width:150}
		],
		postData :{	
			use_yn : "Y"
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
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
	    },
		onCellSelect: function(rowid, iCol,	cellcontent, e) {
			var ret = $('#auth_list').jqGrid('getRowData', rowid);
			managerMenuTreeList(ret.auth_id,ret.auth_nm);
		},
		loadComplete : function(data) {
			showJqgridDataNon(data, "auth_list",6);
		}
	});
	//jq grid 끝 
	
	bindWindowJqGridResize("auth_list", "auth_list_div");
	
	$('#menu_jstree').jstree({
		"core" : {
			"data" : {
				 'cache':false,
				'url' : selectManagerMenuTreeListUrl,
				'data' : {
				},
				"dataType" : "json",
				'success': function(res) {
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
    	getAllNodeData();
    	//$(this).jstree("select_node", '#'+$("#classify_id").val());
    }).bind("select_node.jstree", function (event, data) {
		//$("#classify_id").val(data.node.id);
    });

});

function getAllNodeData(){
	   var jstEdit = $.jstree.reference('#menu_jstree');

	   var v =$("#menu_jstree").jstree(true).get_json('#', { 'flat': true });

	   for(var i=0;i<v.length;i++){
		      var node = jstEdit.get_node(v[i].id);
		      if(node.original.auth_yn == "Y") jstEdit.check_node(v[i].id);
	   }
		
}  

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:managerMenuTreeList('"+rowObject.auth_id+"','"+rowObject.auth_nm+"')\">"+rowObject.auth_nm+"</a>";
	
	return str;
}

function managerMenuTreeList(authId, authNm){
	var treeJstree = $('#menu_jstree').jstree();
	treeJstree.uncheck_all();
	
	$("#auth_id").val(authId);
	$("#auth_nm").html(authNm);
	$('#menu_jstree').jstree().settings.core.data.data = {auth_id : authId};
	$('#menu_jstree').jstree().refresh();
}

function authMenuInsert(){
	   var url = "";
	   var insertRow = new Array();
	   var menu =  $("#menu_jstree").jstree("get_selected", true);
	   
	   var menuMap = new Map();
	   $.each(menu, function(i){		   		   		   		   
		   if(menu[i].parent != "0000000000") menuMap.put(menu[i].parent, "");
		   if(menu[i].id != "0000000000") menuMap.put(menu[i].id, ""); 
		});

       if(menuMap.size() < 1){
    	   alert("등록할 메뉴를 선택해 주십시요.");
    	   return;
       }

       var authid = $("#auth_id").val();
       if(authid == null || authid == '' || authid == 'undefined'){
    	   alert("권한을 선택해 주십시요.");
    	   return;
       }
       
       var menuKeys = menuMap.keys();
	   for(var i =0; i < menuMap.size();i++){
		   insertRow.push(menuKeys[i]);
	   }
	   
       if(!confirm("권한에 메뉴를 매핑하시겠습니까?")) return;

       $.ajax({
 	        url: insertAuthMenuUrl,
 	        dataType: "json",
 	        type: "post",
 	        data: {
 	  		   auth_id : authid,
 	  		   menu_list : JSON.stringify(insertRow)
 			},
 	        success: function(data) {
 	        	alert(data.message);
 	        },
 	        error: function(e) {
 	            alert("테이블을 가져오는데 실패하였습니다.");
 	        }
 	    });
		
}

function changeTab(idx){
	var url = "/admin/auth/authMenuListPage.do";
	if(idx == "2") url = "/admin/auth/managerAuthListPage.do";
	document.location.href = url;
}

</script>

<div id="content">

	<form id="listFrm" name="listFrm" method="post">
	
		<input type='hidden' id="mode" name='mode' value="W" />
		<input type='hidden' id="auth_id" name='"auth_id"' value="" />
		
		<!-- title_and_info_area -->
		<div class="title_and_info_area">
		
			<!-- main_title -->
			<div class="main_title">
				<h3 class="title">${admin_g_submenu_nm}</h3>
			</div>
			<!--// main_title -->
			
			<jsp:include page="/WEB-INF/jsp/admin/integration/menuDescInclude.jsp"/>
		
			<!-- area_tab -->
			<div class="tab_area">
				<ul class="tablist">
					<li id="tab_1" class="on">
						<a href="javascript:changeTab('1')">
							<span>메뉴별 권한배정</span>
						</a>
					</li>
					<li id="tab_2">
						<a href="javascript:changeTab('2')">
							<span>관리자 권한배정</span>
						</a>
					</li>
				</ul>
			</div>
			<!--// area_tab -->
		
		</div>	
		<!--// title_and_info_area -->
		
		<!-- area40 -->
		<div class="area40 marginr10">
		
			<!-- title_area -->
			<div class="title_area">
				<h4 class="title">권한목록</h4>
			</div>
			<!--// title_area -->
			
			<!-- table_area -->						
			<div class="table_area" id="auth_list_div" >
			    <table id="auth_list"></table>
			</div>
			<!--// table_area -->		
			
		</div>
		<!--// area40 -->
		
		<!-- division -->
		<div class="division">
		
			<!-- title_area -->
			<div class="title_area">
				<h4 class="title">메뉴목록</h4>
			</div>
			<!--// title_area -->
			
			<!-- title_area -->
			<div class="title_area marginb8">
			    <div class="float_left">
					<h5 class="title">권한명 : <strong class="color_pointr" id="auth_nm"></strong></h5>
				</div>	
				<div class="float_right">
					<a href="javascript:authMenuInsert()" class="btn acti" title="저장 버튼">
						<span>저장</span>
					</a>
				</div>
			</div>
			<!--// title_area -->
			
			<!-- tree_box_area -->
			<div id="menu_jstree" class="tree_box_area" style="height:345px;overflow:auto; border:1px solid silver;">
				
			</div>
			<!--// tree_box_area -->
		
		</div>
		<!--// division -->		

	</form>
</div>
<!--// content -->

	 		