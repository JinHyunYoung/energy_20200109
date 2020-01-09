<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var selectCmpyDirListPageList = "<c:url value='/admin/directory/cmpyDirListPageList.do'/>";
var cmpyDirViewUrl = "<c:url value='/admin/directory/cmpyDirView.do'/>";
var updateMemberUrl = "<c:url value='/admin/directory/updateMember.do'/>";
var approveCmpyDirUrl = "<c:url value='/admin/directory/approveCmpyDir.do'/>";
var rejectCmpyDirUrl = "<c:url value='/admin/directory/rejectCmpyDir.do'/>";
var deleteCmpyDirUrl = "<c:url value='/admin/directory/deleteCmpyDir.do'/>";
var categoryLoadUrl = '<c:url value="/admin/wbiz/categoryLoad.do" />';

$(document).ready(function(){
    
	$('#dir_list').jqGrid({
		datatype: 'json',
		url: selectCmpyDirListPageList,
		mtype: 'POST',
		colModel: [		
			{ label: '', index: 'dir_check', name: '', width: 10, align : 'center', sortable:false, formatter:jsCheckBoxFormmater},
			{ label: '번호', index: 'rnum', name: 'rnum', width: 10, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '기업명', index: 'cmpy_nm', name: 'cmpy_nm', align : 'left', width:100, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '사업자번호', index: 'biz_reg_no', name: 'biz_reg_no', align : 'center', width:30, sortable:false},
			{ label: '대표자명', index: 'ceo_nm', name: 'ceo_nm', align : 'left', width:30, sortable:false},
			{ label: '법인형태', index: 'cp_tp_cd_nm', name: 'cp_tp_cd_nm', width: 20, align : 'center', sortable:false},
			{ label: '회원사구분', index: 'member_yn_nm', name: 'member_yn_nm', width: 20, align : 'center', sortable:false},
			{ label: '승인상태', index: 'app_stt_cd_nm', name: 'app_stt_cd_nm', width: 20, align : 'center', sortable:false, formatter:jsAppSttCdLinkFormmater},
			{ label: '공개여부', index: 'opn_yn', name: 'opn_yn', width: 20, align : 'center', sortable:false, formatter:jsOpnYnFormmater},
			{ label: '디렉토리일련번호', index: 'dir_sn', name: 'dir_sn', hidden:true },
			{ label: '승인상태코드', index: 'app_stt_cd', name: 'app_stt_cd', hidden:true },
			{ label: '반려사유', index: 'rjt_rsn', name: 'rjt_rsn', hidden:true },
			{ label: 'email기업명', index: 'e_cmpy_nm', name: 'e_cmpy_nm', hidden:true, formatter:jsEmailCmpyNmFormmater },
			{ label: 'email기업명영문', index: 'cmpy_nm_en', name: 'cmpy_nm_en', hidden:true },
			{ label: 'email담당자이메일', index: 'manager_email', name: 'manager_email', hidden:true },
			{ label: 'email신청일', index: 'app_dt', name: 'app_dt', hidden:true },
			{ label: 'email담당자', index: 'manager_nm', name: 'manager_nm', hidden:true }
		],	
		
		postData :{	
			co_tp_cd : $("#p_co_tp_cd").val(),
			inds_tp_cd : $("#p_inds_tp_cd").val(),
			wbiz_tp_l_cd : $("#p_wbiz_tp_l_cd").val(),
			wbiz_tp_m_cd : $("#p_wbiz_tp_m_cd").val(),
			wbiz_tp_s_cd : $("#p_wbiz_tp_s_cd").val(),
			member_yn : $("#p_member_yn").val(),
			app_stt_cd : $("#p_app_stt_cd").val(),
			opn_yn : $("#p_opn_yn").val(),
			searchCondition : $("#p_searchCondition").val(),
			searchText : $("#p_searchText").val()
		},		
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#dir_pager',
		viewrecords : true,
		sortname : "dir_sn",
		sortorder : "desc",
		height : "350px",
		gridview : true,
		autowidth : true,
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			showJqgridDataNon(data, "dir_list", 10);
		}
	});
	//jq grid 끝 
	
	jQuery("#dir_list").jqGrid('navGrid', '#dir_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("dir_list", "dir_list_div");

	// 물산업 불류 콤보 이벤트
	$( '#p_inds_tp_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'L', $( '#p_wbiz_tp_l_cd' ) );			
	});
	
	$( '#p_wbiz_tp_l_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'M', $( '#p_wbiz_tp_m_cd' ) );			
	});
	
	$( '#p_wbiz_tp_m_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'S', $( '#p_wbiz_tp_s_cd' ) );			
	});
	
	$('#modal-cmpyDir').popup();
	
});

// 체크박스
function jsCheckBoxFormmater(cellvalue, options, rowObject){
    var dir_sn = rowObject['dir_sn'];
    var str = "<input type=\"checkbox\" name=\"dir_check\" value="+dir_sn+">";
    
    return str;
}

//번호 정렬
function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#total_cnt").val() - (rowObject.rnum-1);
	return str;
}

// 타이틀
function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:goCmpyDir('"+rowObject.dir_sn+"')\">"+rowObject.cmpy_nm+"</a>";
	return str;
}

//타이틀
function jsAppSttCdLinkFormmater(cellvalue, options, rowObject) {
	if(rowObject.app_stt_cd == '3') {
		var str = "<a href=\"javascript:popupCmpyDirReject('"+rowObject.rjt_rsn+"')\">"+rowObject.app_stt_cd_nm+"</a>";
		return str;
	}
	return rowObject.app_stt_cd_nm;
}

//타이틀
function jsEmailCmpyNmFormmater(cellvalue, options, rowObject) {
	return rowObject.cmpy_nm;
}

// 공개여부
function jsOpnYnFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.opn_yn == "Y"){
		str = "공개";
	}else{
		str = "비공개";
	}
	return str;
}

// 조회
function search() {
		
	jQuery("#dir_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectCmpyDirListPageList,
		page : 1,
		postData : {
			co_tp_cd : $("#p_co_tp_cd").val(),
			inds_tp_cd : $("#p_inds_tp_cd").val(),
			wbiz_tp_l_cd : $("#p_wbiz_tp_l_cd").val(),
			wbiz_tp_m_cd : $("#p_wbiz_tp_m_cd").val(),
			wbiz_tp_s_cd : $("#p_wbiz_tp_s_cd").val(),
			member_yn : $("#p_member_yn").val(),
			app_stt_cd : $("#p_app_stt_cd").val(),
			opn_yn : $("#p_opn_yn").val(),
			searchCondition : $("#p_searchCondition").val(),
			searchText : $("#p_searchText").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

// 상세보기 이동
function goCmpyDir(dir_sn) {
	
    var f = document.listFrm;
    var mode = "W";
    
    if(dir_sn != ""){
    	mode = "E";
    }
    	
	$("#mode").val(mode);
	
	$("#dir_sn").val(dir_sn);
	
    f.action = cmpyDirViewUrl;
    f.submit();
}

//회원사 / 비회원사 등록
function updateMemberY(){
	$("#member_yn").val('Y');	
	updateMember();
}

//회원사 / 비회원사 등록
function updateMemberN(){
	$("#member_yn").val('N');	
	updateMember();	
}

// 회원사 / 비회원사 등록
function updateMember(){
    
    var dir_sn_list = new Array();    
    $('[name=dir_check]').each(function(index,result){
        if(result.checked){
        	dir_sn_list.push(result.value);
        }
    });
	if(dir_sn_list.length == 0){
		alert("선택된 기업이 없습니다.");
		return;
	}
	$("#dir_sn").val(dir_sn_list);	
	
	$("#listFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			if(responseText.success == "true"){
			    search();
			}	
		},
		dataType: "json",
		url: updateMemberUrl
	});
}

function popupApproveCmpyDir(){
	
	$( '#pop_content_mgt' ).html( '' );		
	
	 $.ajax({
	     url: "/admin/directory/approveCmpyDirPopup.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_content_mgt' ).html( data );
      		popupShow();
	     },
	     error: function(e) {
	         alert( '승인 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

// 승인
function approveCmpyDir(){
    
	var flag = false;
    var dir_sn_list = new Array();
    
    var cmpy_nm_list = new Array();
    var cmpy_nm_en_list = new Array();
    var biz_reg_no_list = new Array();
    var ceo_nm_list = new Array();
    var manager_email_list = new Array();
    
    $('[name=dir_check]').each(function(index,result){
        if(result.checked){
        	dir_sn_list.push(result.value);
        	
        	cmpy_nm_list.push($('#dir_list').jqGrid('getRowData', index + 1).e_cmpy_nm);
        	cmpy_nm_en_list.push($('#dir_list').jqGrid('getRowData', index + 1).cmpy_nm_en);
        	biz_reg_no_list.push($('#dir_list').jqGrid('getRowData', index + 1).biz_reg_no);
        	ceo_nm_list.push($('#dir_list').jqGrid('getRowData', index + 1).ceo_nm);
        	manager_email_list.push($('#dir_list').jqGrid('getRowData', index + 1).manager_email);
        	
        	var app_stt_cd = $('#dir_list').jqGrid('getRowData', index + 1).app_stt_cd;
        	if( app_stt_cd != 1 ) {
        		flag = true;
        	}
        }
    });
	
    if(flag){
		alert("선택된 기업에 이미 승인 또는 반려인 기업이 있습니다.");
		popupClose();
		return;
	}
	
    if(dir_sn_list.length == 0){
		alert("선택된 기업이 없습니다.");
		popupClose();
		return;
	}
	
	$("#listFrm #dir_sn").val(dir_sn_list);	
	
	$("#listFrm #cmpy_nm").val(cmpy_nm_list);
	$("#listFrm #cmpy_nm_en").val(cmpy_nm_en_list);
	$("#listFrm #biz_reg_no").val(biz_reg_no_list);
	$("#listFrm #ceo_nm").val(ceo_nm_list);
	$("#listFrm #manager_email").val(manager_email_list);
	
	$('#app_stt_cd').val('2');
	$("#auth_no").val($("#p_auth_no").val());
	
	$("#listFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			if(responseText.success == "true"){
				popupClose();
			    search();
			}	
		},
		dataType: "json",
		url: approveCmpyDirUrl
	});
}

function popupCmpyDirReject(_rjt_rsn){
	
	$( '#pop_content_mgt' ).html( '' );		
	
	 $.ajax({
	     url: "/admin/directory/rejectCmpyDirPopup.do",
	     dataType: "html",
	     type: "post",
	     data: {
	    	   rjt_rsn : _rjt_rsn, 
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_content_mgt' ).html( data );
      		popupShow();
	     },
	     error: function(e) {
	         alert( '반려 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

// 반려
function rejectCmpyDir(){
	var flag = false;
    var dir_sn_list = new Array();   
    
    var cmpy_nm_list = new Array();
    var cmpy_nm_en_list = new Array();
    var biz_reg_no_list = new Array();
    var ceo_nm_list = new Array();
    
    var app_dt_list = new Array();
    var manager_nm_list = new Array();
    
    var manager_email_list = new Array();
    
    $('[name=dir_check]').each(function(index,result){
        if(result.checked){
        	dir_sn_list.push(result.value);
        	
        	cmpy_nm_list.push($('#dir_list').jqGrid('getRowData', index + 1).e_cmpy_nm);
        	cmpy_nm_en_list.push($('#dir_list').jqGrid('getRowData', index + 1).cmpy_nm_en);
        	biz_reg_no_list.push($('#dir_list').jqGrid('getRowData', index + 1).biz_reg_no);
        	ceo_nm_list.push($('#dir_list').jqGrid('getRowData', index + 1).ceo_nm);
        	
        	app_dt_list.push($('#dir_list').jqGrid('getRowData', index + 1).app_dt);
        	manager_nm_list.push($('#dir_list').jqGrid('getRowData', index + 1).manager_nm);
        	
        	manager_email_list.push($('#dir_list').jqGrid('getRowData', index + 1).manager_email);
        	
        	var app_stt_cd = $('#dir_list').jqGrid('getRowData', index + 1).app_stt_cd;
        	if( app_stt_cd != 1 ) {
        		flag = true;
        	}
        }
    });
	
    if(flag){
		alert("선택된 기업에 이미 승인 또는 반려인 기업이 있습니다.");
		popupClose();
		return;
	}
    
	if(dir_sn_list.length == 0){
		alert("선택된 기업이 없습니다.");
		popupClose();
		return;
	}
	
	$("#listFrm #dir_sn").val(dir_sn_list);	
	$("#rjt_rsn").val($("#p_rjt_rsn").val());
	$("#app_stt_cd").val(3);
	
	$("#listFrm #cmpy_nm").val(cmpy_nm_list);
	$("#listFrm #cmpy_nm_en").val(cmpy_nm_en_list);
	$("#listFrm #biz_reg_no").val(biz_reg_no_list);
	$("#listFrm #ceo_nm").val(ceo_nm_list);
	
	$("#listFrm #app_dt").val(app_dt_list);
	$("#listFrm #manager_nm").val(manager_nm_list);
	
	$("#listFrm #manager_email").val(manager_email_list);
	
	$("#listFrm").ajaxSubmit({
		success: function(responseText, statusText){
			alert(responseText.message);
			if(responseText.success == "true"){
				popupClose();
			    search();
			}	
		},
		dataType: "json",
		url: rejectCmpyDirUrl
	});
}

// 삭제
function deleteCmpyDir(){
    
    var dir_sn_list = new Array();    
    $('[name=dir_check]').each(function(index,result){
        if(result.checked){
        	dir_sn_list.push(result.value);
        }
    });
    
	if(dir_sn_list.length == 0){
		alert("선택된 기업이 없습니다.");
		return;
	}
	
	$("#dir_sn").val(dir_sn_list);

	if (confirm('선택한 기업 디렉토리를 삭제하시겠습니까?')) {
			$("#listFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
				    search();
				}	
			},
			dataType: "json",
			url: deleteCmpyDirUrl
		});
	}
 
}

// 초기화
function formReset(){
	$("select[name=p_co_tp_cd] option[value='']").attr("selected",true);
	$("select[name=p_inds_tp_cd] option[value='']").attr("selected",true);
	$("select[name=p_wbiz_tp_l_cd] option[value='']").attr("selected",true);
	$("select[name=p_wbiz_tp_m_cd] option[value='']").attr("selected",true);
	$("select[name=p_wbiz_tp_s_cd] option[value='']").attr("selected",true);
	$("select[name=p_member_yn] option[value='']").attr("selected",true);
	$("select[name=p_app_stt_cd] option[value='']").attr("selected",true);
	$("select[name=p_opn_yn] option[value='']").attr("selected",true);
	$("select[name=p_searchCondition] option[value='cmpy_nm']").attr("selected",true);
	$("#p_searchText").val("");
}

function loadWbizTypeCode( _tp, _obj ){		
	
	if( _tp == 'L' ){
		$( '#p_wbiz_tp_l_cd' ).html( '<option value="">1Depth</option>' );
		$( '#p_wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' );			
		$( '#p_wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );
	}else if( _tp == 'M' ){
		$( '#p_wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' );			
		$( '#p_wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );
	}else if( _tp == 'S' ){
		$( '#p_wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );			
	}
	
	 $.ajax({
        url: categoryLoadUrl,
        dataType: "json",
        type: "post",
        data: {	           
        	inds_tp_cd : $( '#p_inds_tp_cd' ).val() ,
        	wbiz_tp_l_cd : $( '#p_wbiz_tp_l_cd' ).val() , 
        	wbiz_tp_m_cd : $( '#p_wbiz_tp_m_cd' ).val() ,	        	
        	wbiz_cd_tp : _tp
		},
        success: function( data ){
        	
        	var _option = '';
        	if( data.list != null && data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
        			if( _tp == 'L' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_l_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'M' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_m_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'S' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_s_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        		}        		
        	}
        	
        	if( _tp == 'L' ){
    			$( '#p_wbiz_tp_l_cd' ).html( '<option value="">1Depth</option>' + _option );
    		}
        	else if( _tp == 'M' ){
    			$( '#p_wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' +_option );
    		}
    		else if( _tp == 'S' ){
    			$( '#p_wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' +_option );
    		}
    		else if(_obj != null){
        		_obj.html( '<option value="">-전체-</option>' +_option );    			
    		}
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
    });		
	
}

//팝업 열기
function popupShow(){	
	$("#modal-cmpyDir").popup('show');
}


// 팝업 닫기
function popupClose(){
	$("#modal-cmpyDir").popup('hide');
}

// 엑셀다운로드 (국문)
function downloadExcelKr() {	
	location.href='/admin/directory/cmpyDirListPageListExcel.do?lang=kr';
}

// 엑셀다운로드 (영문)
function downloadExcelEn() {	
	location.href='/admin/directory/cmpyDirListPageListExcel.do?lang=en';
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
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="mode" name='mode' value="W" />
		<input type='hidden' id="dir_sn" name='dir_sn' value="" />
		<input type='hidden' id="app_stt_cd" name='app_stt_cd' value="" />
		<input type='hidden' id="member_yn" name='member_yn' value="" />
		<input type='hidden' id="auth_no" name='auth_no' value="" />
		<input type='hidden' id="rjt_rsn" name='rjt_rsn' value="" />
		
		<input type='hidden' id="cmpy_nm" name='cmpy_nm' value="" />
		<input type='hidden' id="cmpy_nm_en" name='cmpy_nm_en' value="" />
		<input type='hidden' id="biz_reg_no" name='biz_reg_no' value="" />
		<input type='hidden' id="ceo_nm" name='ceo_nm' value="" />
		
		<input type='hidden' id="app_dt" name='app_dt' value="" />
		<input type='hidden' id="manager_nm" name='manager_nm' value="" />
		
		<input type='hidden' id="manager_email" name='manager_email' value="" />
		
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>팝업검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 20%;" />
				    <col style="width: 80px;" />
					<col style="width: 50%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>법인형태</th>
					<td>
						<g:select id="p_co_tp_cd" name="p_co_tp_cd" codeGroup="CO_TP_CD" selected="${param.p_co_tp_cd}" titleCode="전체" cls="form-control" />  	
					</td>
					<th>물산업 분류</th>
					<td>       
						<g:select id="p_inds_tp_cd" name="p_inds_tp_cd" codeGroup="INDS_TP_CD" selected="${param.p_inds_tp_cd}" titleCode="전체" cls="form-control" />  	
						<select class="in_wp120" id="p_wbiz_tp_l_cd" name="p_wbiz_tp_l_cd">
							<option value="">1Depth</option>
						</select>
						<select class="in_wp120" id="p_wbiz_tp_m_cd" name="p_wbiz_tp_m_cd">
							<option value="">2Depth</option>
						</select>
						<select class="in_wp120" id="p_wbiz_tp_s_cd" name="p_wbiz_tp_s_cd">
							<option value="">3Depth</option>
						</select>
					</td>
				</tr>			
				<tr>
					<th>회원사구분</th>
					<td>
						<g:select id="p_member_yn" name="p_member_yn" codeGroup="MEMBER_YN" selected="${param.p_member_yn}" titleCode="전체" cls="form-control" />  	
					</td>
					<th>승인상태</th>
					<td>
						<g:select id="p_app_stt_cd" name="p_app_stt_cd" codeGroup="APP_STT_CD" selected="${param.p_app_stt_cd}" titleCode="전체" cls="form-control" />  	                
					</td>
				</tr>				
				<tr>
					<th>공개여부</th>
					<td>
						<g:select id="p_opn_yn" name="p_opn_yn" codeGroup="OPN_YN" selected="${param.p_opn_yn}" titleCode="전체" cls="form-control" />  	
					</td>
					<th>검색구분</th>
					<td>
						<select id="p_searchCondition" name="p_searchCondition">
							<option value="cmpy_nm">기업명</option>
							<option value="biz_reg_no">사업자등록번호</option>
							<option value="ceo_nm">대표자명</option>
						</select>            
		            	<input type="input" id="p_searchText" name="p_searchText" value="<c:out value="${param.p_searchText}" escapeXml="true" />" class="in_w50">   
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
			
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_left">
				<a class="btn acti" id="btn_excel_kr" title="엑셀다운로드(국문)" onClick="javascript:downloadExcelKr()">
					<span>엑셀다운로드(국문)</span>
				</a>
				<a class="btn acti" id="btn_excel_en" title="엑셀다운로드(영문)" onClick="javascript:downloadExcelEn()">
					<span>엑셀다운로드(영문)</span>
				</a>
			</div>
		</div>
		<!--// table_search_area -->
	
		<!-- table 1dan list -->
		<div class="table_area" id="dir_list_div" >
		    <table id="dir_list"></table>
	        <div id="dir_pager"></div>
		</div>
		<!--// table 1dan list -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:updateMemberY()" class="btn save" title="회원사">
					<span>회원사</span>
				</a>
				<a href="javascript:updateMemberN()" class="btn save" title="비회원사">
					<span>비회원사</span>
				</a>
				<a href="javascript:popupApproveCmpyDir()" class="btn save" title="승인">
					<span>승인</span>
				</a>
				<a href="javascript:popupCmpyDirReject()" class="btn save" title="반려">
					<span>반려</span>
				</a>
				<a href="javascript:deleteCmpyDir()" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
	</form>
		
</div>

<!--// content -->
<div id="modal-cmpyDir" style="background-color:white">
	<div id="wrap">
	
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			    <div  id="pop_content_mgt" >
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->
		
	</div>
 </div>
 