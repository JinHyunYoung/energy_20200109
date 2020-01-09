<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/assets/jstree/dist/themes/default/style.min.css"/>

<script type="text/javascript" src="/assets/jstree/dist/jstree.js"></script>

<script language="javascript">

var selectMenuTreeListUrl = "<c:url value='/admin/menu/menuTreeList.do'/>";
var selectMenuListUrl = "<c:url value='/admin/menu/menuList.do'/>";
var menuWriteUrl = "<c:url value='/admin/menu/menuWrite.do'/>";
var insertMenuUrl = "<c:url value='/admin/menu/insertMenu.do'/>";
var updateMenuUrl = "<c:url value='/admin/menu/updateMenu.do'/>"
var deleteMenuUrl = "<c:url value='/admin/menu/deleteMenu.do'/>";
var menuReorderUrl = "<c:url value='/admin/menu/updateMenuReorder.do'/>";

var savedRow = null;
var savedCol = null;
var menu_jstree = null;
var menu_jqgrid = null;

$(document).ready(function(){
		
	menu_jstree = $('#menu_jstree').jstree({
		"core" : {
			"data" : {
				 'cache':false,
				'url' : selectMenuTreeListUrl,
				'data' : {
					homepage : $("#p_homepage").val()
				},
				"dataType" : "json",
				'success': function(res) {
				},
				'error' : function (e) {
				}
			},
			"check_callback" : true
		},
		'search' : {
			'fuzzy' : false
		},
        "types": {
        	   'default': {
                   'icon': 'jstree-folder'
               },
        	   'file': {
                   'icon': 'jstree-file'
               }
        },
		"plugins" : [ "types", "search","contextmenu" ],
		 "contextmenu" : {items: customMenu}
        
	}).bind("loaded.jstree refresh.jstree",function(event,data){
		menu_jstree.jstree("open_all");
		menu_jstree.jstree("select_node", '#'+$("#menu_id").val());
		
    }).bind("select_node.jstree", function (event, data) {
		$("#menu_id").val(data.node.id);
    	$("#depth").val(data.node.parents.length);
    	menuList();
	});
 
	menu_jqgrid = $('#menuList').jqGrid({
		datatype: 'json',
		url: selectMenuListUrl,
		mtype: 'POST',
		postData :{
			homepage : $("#p_homepage").val(),
			menu_id : $("#menu_id").val()
		},
		colModel: [
			{ label: '순서', index: 'sort', name: 'sort', width: 40, align : 'center' , sortable:false, editable:true,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '메뉴코드', index: 'menu_id', name: 'menu_id', align : 'center', width:160, sortable:false},
			{ label: '메뉴명', index: 'menu_nm', name: 'menu_nm', align : 'left', width:200, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', align : 'center', width:40, sortable:false},
			{ label: '상위메뉴id', index: 'up_menu_id', name: 'up_menu_id',  hidden:true}
		],
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
	    },
		loadComplete : function(data) {
			showJqgridDataNon(data, "menuList",4);
		} ,
		onCellSelect: function(rowid, iCol,	cellcontent, e) {
			var ret = menu_jqgrid.jqGrid('getRowData', rowid);
			//$("#ref_data_id").val(ret.ref_data_id);
		},
		onSelectRow: function(rowid, status) {
			//$('#menuList').resetSelection();
			//$("#menuList").jqGrid('setSelection',rowid);
		},  
		rowNum : -1,
		cellEdit: true,
		editable: true,
		edittype :"text",
		viewrecords : true,
		autowidth: true,
		forceFit : false,
		shrinkToFit : true,
		cellsubmit : 'clientArray',
		height:530
	});
	
	bindWindowJqGridResize("menuList", "menuList_Div");
 	
});

// 메뉴트리 조회
function searchMenuTree() {
	menu_jstree.jstree().settings.core.data.data = {'homepage' : $("#p_homepage").val() };
	menu_jstree.jstree().refresh();
}

// jqgrid 타이틀 링크 포맷
function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:menuWrite('E','"+rowObject.menu_id+"')\">"+rowObject.menu_nm+"</a>";
	return str;
}

// 사용자 메뉴
function customMenu(node){
   var items =  null
   items =  {
         "create" : {
             "separator_before" : false,
             "separator_after"  : false,
             "label"            : "추가",
             "action"           : function (obj) { 
             	create(obj); 
               }
         }
   }
   
   return items;
}


// 생성
function create(obj){
	var seq = 0;
	var arrrows = $("#menuList").getRowData(); //그리드에 있는 데이터를 배열화해 갖고온다
	seq = arrrows.length;
	
	menuWrite("W", $("#menu_id").val(), seq);
}

// 메뉴 리스트 조회
function menuList(){
        
	menu_jqgrid.jqGrid(
		'setGridParam', {
			datatype : 'json',
			url : selectMenuListUrl,
			page : 1,
			postData :{
				homepage : $("#p_homepage").val(),
				up_menu_id : $("#menu_id").val()
			},
			mtype : "POST"
		}

	).trigger("reloadGrid");
}


// 메뉴 작성
function menuWrite(mode, menuId) {

	var f = document.listFrm;
    
    if($("#depth").val() > 3){
    	alert("메뉴는 3단계까지 생성이 가능합니다.");
    	return;
    }
    
    if(menuId != "") $("#sel_menu_id").val(menuId);
    	
    if($("#menu_id").val() == ""){
    	alert("상위 메뉴를 선택해 주십시요.");
    	return;
    }
    
    if(menuId == '0000000000') menuId = "";
    
	$('#pop_content').html("");
	$("#mode").val(mode);
	
    $.ajax({
        url: menuWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           homepage : $("#p_homepage").val(),
           mode : mode,
       	   menu_id : menuId
		},
        success: function(data) {
        	$('#pop_content').html(data);
        	popupShow();
        	$(".onlynum").keyup( setNumberOnly );
        	//$("[id^='parsley-id-multiple-menu_type']").attr("display","none");
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}

// 메뉴 추가
function menuInsert(){
    
	   var url = "";
	   var target = $('input:radio[name=target_set]:checked').val();
	   
		if(target == "3"){
			$('#width').attr('data-parsley-required', 'true');
			$('#height').attr('data-parsley-required', 'true');
			$('#top').attr('data-parsley-required', 'true');
			$('#left').attr('data-parsley-required', 'true');
		}else{ 
			$('#width').attr('data-parsley-required', 'false');
			$('#height').attr('data-parsley-required', 'false');
			$('#top').attr('data-parsley-required', 'false');
			$('#left').attr('data-parsley-required', 'false');
		}
		
	   if ( $("#writeFrm").parsley().validate() ){

			if ($("#uploadFile").val() != "" && !$("#uploadFile").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
			    alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
			    return;
			} 
			
			// 게시판일경우 URL 처리
			if($("#board").val() != "") {
				if($("#p_homepage").val() == "B"){
					$("#url").val("/admin/board/boardContentsListPage.do?board_id="+$("#board").val());
				}else{					
					$("#url").val("/web/board/boardContentsListPage.do?board_id="+$("#board").val());
				}
			}
			
		   url = insertMenuUrl;
		   if($("#mode").val() == "E") url = updateMenuUrl;
		   
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						searchMenuTree();
  						menuList();
  						popupClose();
  					}	
  				},
  				dataType: "json",
  				url: url,
  				data : {
  		        	homepage : $("#p_homepage").val(),
  		           	menu_id : $("#sel_menu_id").val(),
  		            up_menu_id : $("#menu_id").val() 
  				}
  		    });	
		   
	   }
}

// 메뉴 삭제
function menuDelete(itemId){
    
	   if(!confirm("선택하신 메뉴 삭제 시 하부의 모든 메뉴도 삭제됩니다. 정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteMenuUrl,
	           data:{
 		        	homepage : $("#p_homepage").val(),
  		           	menu_id : $("#sel_menu_id").val(),
  		            up_menu_id : $("#menu_id").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					searchMenuTree();
					menuList();
					popupClose();
				}	
			}
		});
}

// 메뉴 순서 저장
function menuReorder(){
    
	var updateRow = new Array();
	var saveCnt = 0;
	
	jQuery('#menuList').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#menuList').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("순서는 필수값입니다. 확인후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].menu_nm="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("순서를 저장할 코드가 없습니다.");
		return;
	}
	
	$.ajax
	({
		type: "POST",
           url: menuReorderUrl,
           data:{
            menu_list : JSON.stringify(updateRow)
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				searchMenuTree();
				menuList();
			}	
		}
	});
}

// 팝업 보여주기
function popupShow(){
	$("#modal-menu-write").modal('show');
}

// 팝업 닫기
function popupClose(){
	$("#modal-menu-write").modal("hide");
}

// 팝업 조회 보여주기
function popupSearchShow(){
	$("#modal-menutype-list").modal('show');
}

// 팝업 조회 닫기
function popupSearchClose(){
	$("#modal-menutype-list").modal("hide");
}

// 메뉴 리스트 페이지 조회
function menuListPage() {
    var f = document.listFrm;
    
    f.target = "_self";
    f.action = "/admin/menu/menuListPage.do";
    f.submit();
}

// 업로드 파일 삭제
function delFile(){
	$("#image").val("");
	$("#uploadedFile").hide();
}

// 홈페이지구분 변경
function changeHomepage(){
	$("#menu_id").val("0000000000");
	searchMenuTree();
	menuList();
}

// 타겟 변경
function changeTargetSet(){
	var target = $('input:radio[name=target_set]:checked').val();

	if(target == "3"){
		setIdDisp("popup_field","S");
	}else{
		setIdDisp("popup_field","H");
	}
}

// 메뉴 타입 변경
function changeMenuType(){
	var type = $('input:radio[name=menu_type]:checked').val();

	$("input[name='menu_type']").each(function(){
	     if(type == $(this).val()) setIdDisp("menu_type_"+$(this).val(),"S");
	     else setIdDisp("menu_type_"+$(this).val(),"H");
	 });	
}

// 메뉴 트리 열기
function treeExpand(){ 
	menu_jstree.jstree("open_all");
}

// 메뉴 트리 닫기
function treeClose(){ 
	menu_jstree.jstree("close_all");
}

// 메뉴 팝업
function menuPopup(type){
	var title = "";
	var url = "";
	
	if(type == 'F'){
		title = "참조메뉴";
		url = "/admin/menu/menuSearchPopup.do";
	}else if(type == 'C'){
		title = "콘텐츠";
		url = "/admin/intropage/intropageSearchPopup.do";
	}else if(type == 'B'){
		title = "게시판";
		url = "/admin/board/boardSearchPopup.do";		
	}
	
	$("#menutype_title").html(title);
	
    $.ajax({
        url: url,
        dataType: "html",
        type: "post",
        data: {
        	homepage : $("#p_homepage").val()
		},
        success: function(data) {
        	$('#pop_menutype').html(data);
        	popupSearchShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

</script>

<form id="listFrm" name="listFrm" method="post" >

    <input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
   	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="menu_id" name='menu_id' value="0000000000" />
	<input type='hidden' id="up_menu_id" name='up_menu_id' value="" />
    <input type='hidden' id="sel_menu_id" name='sel_menu_id' value="" />
    <input type='hidden' id="depth" name='depth' value="0" />

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
		<!--// title_and_info_area -->
		
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>메뉴타이틀</caption>
				<colgroup>
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>
					홈페이지구분 : <g:select id="p_homepage" name="p_homepage" codeGroup="HOMEPAGE_GB" selected="${param.p_homepage}" cls="in_wp200" onChange="changeHomepage()" />
					</th>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// search_area -->
		
		<!-- area40 -->
		<div class="area40 marginr10">
			<div id="menu_jstree" style="height:630px;overflow:auto; border:1px solid silver; min-height:565px;">
			</div>	
      		<a href="javascript:treeExpand()" class="btn acti" title="모두열기">
				<span>모두열기</span>
			</a>
      		<a href="javascript:treeClose()" class="btn acti" title="모두닫기">
				<span>모두닫기</span>
			</a>			
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
				<div class="float_right">
					<a href="javascript:menuReorder()" class="btn acti" title="순서저장">
						<span>순서저장</span>
					</a>
					<a href="javascript:menuWrite('W', '')" class="btn acti" title="등록">
						<span>등록</span>
					</a>					
				</div>
			</div>
			<!--// title_area -->
			
			<div class="panel-body"  id="menuList_Div" style="padding:2px">
				<table id="menuList"></table>
			</div>
		
		</div>
		<!--// division -->		

	</div>
	<!--// content -->
	
	</form>

	<div class="modal fade" id="modal-menu-write" >
	
		<div class="modal-dialog modal-size-small">
		
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title">메뉴등록</h1>
				<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="pop_content" >
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->	
					
		</div>
	</div>
	  
	<div class="modal fade" id="modal-menutype-list" >
	
		<div class="modal-dialog modal-size-small">
		
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 id="menutype_title" class="pop_title">메뉴리스트</h1>
				<a href="javascript:popupSearchClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area" style="text-align:center">
				    <div  id="pop_menutype"  style="margin:10px;">
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->	
					
		</div>
	</div>