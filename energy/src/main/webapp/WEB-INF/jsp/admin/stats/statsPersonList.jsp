
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%@ page import="kr.or.wabis.framework.util.SystemUtil"%> 

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">

var selectListUrl = "<c:url value='/admin/stats/statsPersonListPage.do'/>";

$(document).ready(function(){

	$('#personList').jqGrid({
		datatype: 'json',
		url: selectListUrl,
		mtype: 'post',
		colModel: [		
		 			{ label: '표본여부', index: 'smpl_nm', name: 'smpl_nm', width: 60, align : 'center', sortable:false},
					{ label: '업종구분', index: 'inds_tp_nm', name: 'inds_tp_nm', align : 'center', width:120, sortable:false},
					{ label: '코드', index: 'wbiz_tp_l_cd', name: 'wbiz_tp_l_cd', width: 80, align : 'center', sortable:false},
					{ label: '코드명', index: 'wbiz_tp_l_nm', name: 'wbiz_tp_l_nm', width: 240, align : 'left', sortable:false},
					{ label: '코드', index: 'wbiz_tp_m_cd', name: 'wbiz_tp_m_cd', width: 80, align : 'center', sortable:false},
					{ label: '코드명', index: 'wbiz_tp_m_nm', name: 'wbiz_tp_m_nm', width: 240, align : 'left', sortable:false},
					{ label: '코드', index: 'wbiz_tp_s_cd', name: 'wbiz_tp_s_cd', width: 80, align : 'center', sortable:false},
					{ label: '코드명', index: 'wbiz_tp_s_nm', name: 'wbiz_tp_s_nm', width: 240, align : 'left', sortable:false},
					{ label: '*사업자번호', index: 'biz_reg_no', name: 'biz_reg_no', width: 120, align : 'center', sortable:false},
					{ label: '사업체명', index: 'cmpy_nm', name: 'cmpy_nm', width: 200, align : 'left', sortable:false},
					{ label: '시도', index: 'addr1', name: 'addr1', width: 100, align : 'left', sortable:false},
					{ label: '군구', index: 'addr2', name: 'addr2', width: 100, align : 'left', sortable:false},
					{ label: '읍면동', index: 'addr3', name: 'addr3', width: 100, align : 'left', sortable:false},
					{ label: '산업분류', index: 'biz_cate_cd', name: 'biz_cate_cd', width: 100, align : 'center', sortable:false},
					{ label: '종사자수', index: 'empl_cnt', name: 'empl_cnt', width: 100, align : 'right', sortable:false},
					{ label: '종사자규모', index: 'scale_cd', name: 'scale_cd', width: 200, align : 'center', sortable:false}
				],
		postData :{	
			bs_yy : $("#p_bs_yy").val(),
			smpl_cd : $("#p_smpl_cd").val(),
			inds_tp_cd : $("#p_inds_tp_cd").val(),
			wbiz_tp_l_cd : $("#p_wbiz_tp_l_cd").val(),
			wbiz_tp_m_cd : $("#p_wbiz_tp_m_cd").val(),
			wbiz_tp_s_cd : $("#p_wbiz_tp_s_cd").val(),
			addr : $("#p_addr").val(),
			scale_cd : $("#p_scale_cd").val(),
			cmpy_nm : $("#p_cmpy_nm").val()

		},
		page : "${LISTOP.ht.miv_pageNo}",
		rownumbers : true, 
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#excel_pager',
		viewrecords : true,
		sortname : "sort",
		sortorder : "desc",
		height : "350px",
		scrollerbar :true,
		viewrecords : true,
		gridview : true,
		autowidth : true,
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },	
		loadComplete : function(data) {
			showJqgridDataNon(data, "personList", 16);
		}
	}).trigger("reloadGrid");
	//jq grid 끝
	// jQgrid Header Setting
	$("#personList").jqGrid('setGroupHeaders', {
		useColSpanStyle : true,
		groupHeaders : [
		                {startColumnName: 'wbiz_tp_l_cd', numberOfColumns:2, titleText: '* 대분류'},
		                {startColumnName: 'wbiz_tp_m_cd', numberOfColumns:2, titleText: '* 중분류'},
		                {startColumnName: 'wbiz_tp_s_cd', numberOfColumns:2, titleText: '* 소분류'}
		]
	
	});
		
	bindWindowJqGridResize("personList", "personList_div");
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
	

});

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
        url: "/admin/wbiz/categoryLoad.do",
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


//jq grid 데이터 갱신
function search(){
	if ($("#p_bs_yy").val() =="") {
		alert("기준년도는 필수입니다.");
		return ;
	}
	jQuery("#personList").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectListUrl,
		page : 1,
		postData : {
			bs_yy : $("#p_bs_yy").val(),
			smpl_cd : $("#p_smpl_cd").val(),
			inds_tp_cd : $("#p_inds_tp_cd").val(),
			wbiz_tp_l_cd : $("#p_wbiz_tp_l_cd").val(),
			wbiz_tp_m_cd : $("#p_wbiz_tp_m_cd").val(),
			wbiz_tp_s_cd : $("#p_wbiz_tp_s_cd").val(),
			addr : $("#p_addr").val(),
			scale_cd : $("#p_scale_cd").val(),
			cmpy_nm : $("#p_cmpy_nm").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}

//초기화
function formReset(){
	$("select[name=p_bs_yy] option[value='']").attr("selected",true);
	$("select[name=p_smpl_cd] option[value='']").attr("selected",true);
	$("select[name=p_inds_tp_cd] option[value='']").attr("selected",true);
	$("select[name=p_wbiz_tp_l_cd] option[value='']").attr("selected",true);
	$("select[name=p_wbiz_tp_m_cd] option[value='']").attr("selected",true);
	$("select[name=p_wbiz_tp_s_cd] option[value='']").attr("selected",true);
	$("select[name=p_scale_cd] option[value='']").attr("selected",true);
	$("#p_addr").val("");
	$("#p_cmpy_nm").val("");
}
//엑셀다운로드
function downloadExcel() {	
	var url = '/admin/stats/statsPersonListExcelDownload.do?bs_yy='+$("#p_bs_yy").val();
	if ($("#p_bs_yy").val() =="") {
		alert("기준년도는 필수입니다.");
		return ;
	}

	location.href=url;
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
	<!--// title_and_info_area -->
	
	<form id="listFrm" name="listFrm" method="post">
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	

		<!-- search_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>모집단 명단 조회</caption>
				<colgroup>
					<col style="width: 150px;" />
					<col style="width: 40%;" />
					<col style="width: 150px;" />
					<col style="width: 30%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>발행년도(기준년도) <strong class="color_pointr">*</strong></th>
					<td>
						<select class="in_wp100" id="p_bs_yy">
							<option value="" >선택</option>
							<c:forEach var="i" begin="2012" end="2017" >
							    <c:set var="yearOption" value="${2017-i+2012}" />
							    <option value="${yearOption}">${yearOption}(${yearOption-1})</option>
							</c:forEach>
						</select>
					</td>
					<th>표본여부</th>
					<td>
						<g:select id="p_smpl_cd" name="p_smpl_cd" codeGroup="SMPL_CD"  titleCode="전체" cls="form-control" class="in_wp100"/>  	
					</td>
				</tr>
				<tr>
					<th>물산업 분류</th>
					<td>       
						<g:select id="p_inds_tp_cd" name="p_inds_tp_cd" codeGroup="INDS_TP_CD"  titleCode="전체" cls="form-control" />  	
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
					<th>사업장소재지</th>
					<td>       
		            	<input type="input" id="p_addr" name="p_addr" value="" class="in_wp300">   
					</td>
					
				</tr>
				<tr>
					<th>사업장규모</th>
					<td>       
						<g:select id="p_scale_cd" name="p_scale_cd" codeGroup="SCALE_CD"  titleCode="전체" cls="form-control" class="in_wp200"/>  	
					</td>
					<th>사업체명</th>
					<td>       
		            	<input type="input" id="p_cmpy_nm" name="p_cmpy_nm" value="" class="in_wp300">   
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
	</form>
	

	<!-- table_search_area -->
	<div class="table_search_area">
		<div class="float_left">
			<a class="btn acti" id="btn_excel_kr" title="엑셀다운로드(국문)" onClick="javascript:downloadExcel()">
				<span>엑셀다운로드</span>
			</a>
		</div>
	</div>
	<!--// table_search_area -->
	
	<!-- table 1dan list -->
	<div class="table_area" id="personList_div" >
	    <table id="personList"></table>
<!--         <div id="excel_pager" style="display: none;"></div>  -->
        <div id="excel_pager" ></div>
	</div>
	<!--// table 1dan list -->
	<!-- 파일 생성중 보여질 진행막대를 포함하고 있는 다이얼로그 입니다. --> 
	<div title="Data Download" id="preparing-file-modal" style="display: none;"> 
		<div id="progressbar" style="width: 100%; height: 22px; margin-top: 20px;">	</div> 
	</div> 
	<!-- 에러발생시 보여질 메세지 다이얼로그 입니다. --> 
	<div title="Error" id="error-modal" style="display: none;"> 
		<p>생성실패.</p>
	</div>


	
</div>
