<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/jstree/dist/themes/proton/style.min.css" />
<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script type="text/javascript" src="/assets/jstree/dist/jstree.js"></script>

<script language="javascript">

var selectAuthListUrl = "<c:url value='/admin/auth/authList.do'/>";
var insertAuthMenuUrl = "<c:url value='/admin/menu/insertAuthMenu.do'/>";
var selectManagerAuthPageListUrl = "<c:url value='/admin/auth/managerAuthPageList.do'/>";
var selectAuthUserPageListUrl  = "<c:url value='/admin/user/authUserPageList.do'/>";
var insertManagerAuthUrl  = "<c:url value='/admin/auth/insertManagerAuth.do'/>";
var deleteManagerAuthUrl  = "<c:url value='/admin/auth/deleteManagerAuth.do'/>";

var savedRow = null;
var savedCol = null;

$(document).ready(function(){
	
	$('#modal-manager-list').popup();
	
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
	
	$('#manager_list').jqGrid({
		datatype: 'json',
		url: selectManagerAuthPageListUrl,
		mtype: 'POST',
		colModel: [
            { label: '선택', index: 'sel_box', name: 'sel_box', width: 30, align : 'center', formatter:jsManagerCheckboxFormmater},      
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 60, align : 'center' },
			{ label: '이름', index: 'user_nm', name: 'user_nm', align : 'center', width:60},
			{ label: '지자체', index: 'orgn_nm', name: 'orgn_nm', align : 'left', width:100},
			{ label: '부서', index: 'dept_nm', name: 'dept_nm', align : 'left', width:100},
			{ label: 'user_no', index: 'user_no', name: 'user_no', width: 50, align : 'center', hidden:true }
		],
		postData :{	
			auth_id : $("#auth_id").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#manager_pager',
		viewrecords : true,
		sortname : "user_nm",
		sortorder : "asc",
		height : "290px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#manager_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "manager_list");
		   return 'stop';
		},   
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			
			showJqgridDataNon(data, "manager_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#manager_list").jqGrid('navGrid', '#manager_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("manager_list", "manager_list_div");
	
	$('#search_list').jqGrid({
		datatype: 'json',
		url: selectAuthUserPageListUrl,
		mtype: 'POST',
		colModel: [
            { label: '선택', index: 'sel_box', name: 'sel_box', width: 30, align : 'center', formatter:jsUserCheckboxFormmater},      
			{ label: '번호', index: 'rnum', name: 'rnum', width: 50, align : 'center', formatter:jsSearchRownumFormmater},
			{ label: '아이디', index: 'user_id', name: 'user_id', width: 60, align : 'center' },
			{ label: '이름', index: 'user_nm', name: 'user_nm', align : 'center', width:60},
			{ label: '지자체', index: 'orgn_nm', name: 'orgn_nm', align : 'left', width:100},
			{ label: '부서', index: 'dept_nm', name: 'dept_nm', align : 'left', width:100},
			{ label: 'user_no', index: 'user_no', name: 'user_no', width: 50, align : 'center', hidden:true }
		],
		postData :{	
			auth_id : $("#auth_id").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#search_pager',
		viewrecords : true,
		sortname : "user_nm",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		forceFit : false,
		shrinkToFit : true,
		cellEdit : false,
		cellsubmit : 'clientArray',
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
		},
		onSelectRow : function(rowid, status, e) {
			var ret = jQuery("#search_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "search_list");
		   return 'stop';
		},   
		beforeProcessing: function (data) {
			$("#srch_LISTOP").val(data.LISTOPVALUE);
			$("#srch_miv_pageNo").val(data.page);
			$("#srch_miv_pageSize").val(data.size);
			$("#srch_total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			
			showJqgridDataNon(data, "search_list",7);

		}
	});
	//jq grid 끝 
	
	jQuery("#search_list").jqGrid('navGrid', '#search_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});

});

function jsManagerCheckboxFormmater(cellvalue, options, rowObject){
	return '<input type="checkbox" id="chk_manager_no" name="chk_manager_no" value="'+rowObject.user_no+'")/>';
}

function jsUserCheckboxFormmater(cellvalue, options, rowObject){
	return '<input type="checkbox" id="chk_user_no" name="chk_user_no" value="'+rowObject.user_no+'")/>';
}

function jsRownumFormmater(cellvalue, options, rowObject) {
	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);
	
	return str;
}

function jsSearchRownumFormmater(cellvalue, options, rowObject) {
	
	var str = ($("#srch_total_cnt").val()-(($("#srch_miv_pageNo").val()-1)*$("#srch_miv_pageSize").val()))-(rowObject.rnum-1);
	
	return str;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:managerMenuTreeList('"+rowObject.auth_id+"','"+rowObject.auth_nm+"')\">"+rowObject.auth_nm+"</a>";
	
	return str;
}


function managerMenuTreeList(authId, authNm){
	$("#auth_id").val(authId);
	$("#auth_nm").html(authNm);
	managerList();
}

function managerList() {
	
	jQuery("#manager_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectManagerAuthPageListUrl,
		page : 1,
		postData : {
			auth_id : $("#auth_id").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function search() {
	
	jQuery("#search_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectAuthUserPageListUrl,
		page : 1,
		postData : {
			auth_id : $("#auth_id").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function managerAuthInsert(){
	   var url = "";

	  if($('input:checkbox[name="chk_user_no"]:checked').length < 1){
		    alert("권한에 매핑할 관리자를 선택해 주십시요.");
		    return;
	  }

	  var insertRow = new Array();
      $('input:checkbox[name="chk_user_no"]').each(function(){
		      if(this.checked){
		         insertRow.push(this.value);
		      }
		});
      
      if(!confirm("관리자 권한을 등록하시겠습니까?")) return;
	  
      $.ajax({
	        url: insertManagerAuthUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	  		   auth_id : $("#auth_id").val(),
	  		   user_list : JSON.stringify(insertRow)
			},
	        success: function(data) {
	        	alert(data.message);
				if(data.success == "true"){
					managerList();
					popupClose();
				}	
	        },
	        error: function(e) {
	            alert("테이블을 가져오는데 실패하였습니다.");
	        }
	    });
		
}

function managerAuthDelete(){
	   var url = "";

	  if($('input:checkbox[name="chk_manager_no"]:checked').length < 1){
		    alert("권한에 매핑할 관리자를 선택해 주십시요.");
		    return;
	  }

	  var deleteRow = new Array();
      $('input:checkbox[name="chk_manager_no"]').each(function(){
		      if(this.checked){
		    	  deleteRow.push(this.value);
		      }
		});
	  
      if(!confirm("관리자 권한을 삭제하시겠습니까?")) return;
      
	  $.ajax({
	        url: deleteManagerAuthUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	  		   auth_id : $("#auth_id").val(),
	  		   user_list : JSON.stringify(deleteRow)
			},
	        success: function(data) {
	        	alert(data.message);
				if(data.success == "true"){
					managerList();
				}	
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

function popupShow(){
	$('#modal-manager-list').popup('show');
	bindWindowJqGridResize("search_list", "search_list_div");
	search();
}

function popupClose(){
	$('#modal-manager-list').popup('hide');
}

</script>

<div id="content">

	<form id="listFrm" name="listFrm" method="post">
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="auth_id" name='auth_id' value="" />
		
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
					<li id="tab_1">
						<a href="javascript:changeTab('1')">
							<span>메뉴별 권한배정</span>
						</a>
					</li>
					<li id="tab_2" class="on">
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
				<h4 class="title">관리자 목록</h4>
			</div>
			<!--// title_area -->
			
			<!-- title_area -->
			<div class="title_area marginb8">
			    <div class="float_left">
					<h5 class="title">권한명 : <strong class="color_pointr" id="auth_nm"></strong></h5>
				</div>	
				<div class="float_right">
					<a href="javascript:popupShow()" class="btn acti" title="추가">
						<span>추가</span>
					</a>
					<a href="javascript:managerAuthDelete();" class="btn acti" title="삭제">
						<span>삭제</span>
					</a>	
				</div>
			</div>
			<!--// title_area -->
			
	        	<!-- table 1dan list -->
			<div class="table_area" id="manager_list_div" >
			    <table id="manager_list"></table>
			    <div id="manager_pager"></div>
			</div>
			<!--// table 1dan list -->
		
		</div>
		<!--// division -->	
		
	</form>	

</div>
<!--// content -->


 <div id="modal-manager-list" style="width:600px;background-color:white">
 
		<div id="wrap">
		
			<!-- header -->
			<div id="pop_header">
				<header>
					<h1 class="pop_title">관리자 목록</h1>
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
					    
						    <form id="srchFrm" name="srchFrm" method="post">
						    
								<input type='hidden' id="srch_miv_pageNo" name='srch_miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
								<input type='hidden' id="srch_miv_pageSize" name='srch_miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
								<input type='hidden' id="srch_total_cnt" name='srch_total_cnt' value="" />
								<input type='hidden' id="srch_LISTOP" name='srch_LISTOP' value="${LISTOP.value}" />
								
								<!-- search_area -->
								<div class="search_area">
									 <table class="search_box">
										<caption>관리자검색</caption>
										<colgroup>
											<col style="width: 80px;" />
											<col style="width: 90%;" />
											<col style="width: *;" />
										</colgroup>
										<tbody>
										<tr>
											<th>검색구분</th>
											<td>
								               <select id="p_searchkey" name="p_searchkey" class="form-control input-sm">
							                       <option value="user_nm" >이름</option>
							                       <option value="user_id" >아이디</option>
							                       <option value="user_mobile" >휴대전화</option>
							                       <option value="user_email" >이메일</option>
							                  </select>
							                  <label for="input_text" class="hidden">검색어 입력</label>
							                   <input type="input" id="p_searchtxt" name="p_searchtxt" value="${param.p_searchtxt}"  placeholder="검색어" class="in_wp150">                      
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
									
								<!-- tabel_search_area -->
								<div class="table_search_area">
									<div class="float_right">
										<a href="javascript:managerAuthInsert('')" class="btn acti" title="권한등록">
											<span>권한등록</span>
										</a>
									</div>
								</div>
								<!--// tabel_search_area -->
			
								<div class="table_area" id="search_list_div" >
								    <table id="search_list"></table>
								    <div id="search_pager"></div>
								</div>
								
						    </form>
					    </div>
					</div>
				</article>	
				
			</div>
			<!-- //container -->
		</div>
  </div>