<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script type="text/javascript">

var selectStatsInfopageUrl = "<c:url value='/admin/stats/statsInfopagePageList.do'/>";
var loadStatsInfoMCodeUrl="<c:url value='/admin/stats/loadStatsInfoMCode.do' />";

$(document).ready(function(){
	// 통계 해설 콤보 이벤트
	/*
	$( '#stats_info_l_cd' ).bind( 'change' , function(){
		loadStats_info_m_cd( $( '#stats_info_m_cd' ) );			
	});
	*/
	
	$('#infopage_list').jqGrid({
		datatype: 'json',
		url: selectStatsInfopageUrl + '?reg_type=' + $("#reg_type").val(),
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum',  width: 50, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '주요통계코드', index: 'stats_info_l_cd', name: 'stats_info_l_cd', width: 50, align : 'center', sortable:false},
			{ label: '주요통계명', index: 'stats_info_l_nm', name: 'stats_info_l_nm', width: 100, align : 'center', sortable:false },
			{ label: '해설코드', index: 'stats_info_m_cd', name: 'stats_info_m_cd', align : 'center', width:50 },
			{ label: '해설명', index: 'stats_info_m_nm', name: 'stats_info_m_nm', align : 'center', width:200, formatter:jsTitleLinkFormmater},
			{ label: '등록구분', index: 'reg_type', name: 'reg_type',  hidden:true }
		],
		postData :{	
			bs_yy : $("#bs_yy").val(),
			stats_info_l_cd : $("#stats_info_l_cd").val(),
			stats_info_m_cd : $("#stats_info_m_cd").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#infopage_pager',
		viewrecords : true,
		sortname : "bs_yy desc, stats_info_l_cd, stats_info_m_cd",
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
			var ret = jQuery("#infopage_list").jqGrid('getRowData', rowid);
		},
		onSortCol : function(index, iCol, sortOrder) {
			 jqgridSortCol(index, iCol, sortOrder, "infopage_list");
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
			
			showJqgridDataNon(data, "infopage_list",4);

		}
	});
	//jq grid 끝 
	
 	jQuery("#infopage_list").jqGrid('navGrid', '#infopage_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
	});
	
	bindWindowJqGridResize("infopage_list", "infopage_list_div");
	
	$("#modifyBts").hide();

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:selectedStatsInfoPage('"+rowObject.bs_yy+"','"+rowObject.stats_info_l_cd+"','"+
			rowObject.stats_info_m_cd+"','"+rowObject.stats_info_m_nm+"')\">"+rowObject.stats_info_m_nm+"</a>";
	return str;
}

function jsRownumFormmater(cellvalue, options, rowObject) {	
	var str = (rowObject.total_cnt)-(rowObject.rnum-1);	
	return str;
}

//jq grid 데이터 갱신
function reloadInfopageList(){
	loadStats_info_m_cd( $( '#stats_info_m_cd' ) );			
	jQuery("#infopage_list").jqGrid('navGrid', {
		datatype: 'json',
		url: selectStatsInfopageUrl ,
		mtype: 'POST',
		page : 1,
		postData : {
			bs_yy : $("#bs_yy").val(),
			stats_info_l_cd : $("#stats_info_l_cd").val()
//			stats_info_m_cd : $("#stats_info_m_cd").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}


function loadStats_info_m_cd(_obj ){
	$.ajax({
        url: loadStatsInfoMCodeUrl,
        dataType: "json",
        type: "post",
        data: {	           
        	bs_yy : $( '#bs_yy' ).val() ,
        	stats_info_l_cd : $( '#stats_info_l_cd' ).val() 
		},
        success: function( data ){
        	
        	var _option = '';
        	if( data.stats_info_m_list.length > 0 ){
        		for( var i = 0 ; i < data.stats_info_m_list.length ; i++ ){
       				_option += '<option value="' + data.stats_info_m_list[i].code + '">' + data.stats_info_m_list[i].codenm + '</option>';
        		}        		
        	}
        	
      		_obj.html( '<option value="">- 선택 -</option>' +_option );    			
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
    });		
	
}

// 선택된 정보페이지를 가져온다.
function selectedStatsInfoPage(bs_yy_, stats_info_l_cd_, stats_info_m_cd_, stats_info_m_nm_) {
  
	$("#modifyBts").show();	
	$("#addBts").hide();
	
    $.ajax({
        url: "/admin/stats/selectStatsInfopage.do",
        dataType: "json",
        type: "post",
        data: {
        	bs_yy : bs_yy_,
        	stats_info_l_cd : stats_info_l_cd_,
        	stats_info_m_cd : stats_info_m_cd_
		},
        success: function(data) {

//            $("#bs_yy").val(data.statsInfopage.bs_yy);
//            $("#stats_info_l_cd").val(data.statsInfopage.stats_info_l_cd);
          
            var _option = '<option value="'+stats_info_m_cd_ + '" selected >'+ stats_info_m_nm_ +'</option>';
            console.log('<option value="">- 선택 -</option>' +_option);
           
            $( '#stats_info_m_cd' ).html( '<option value="">- 선택 -</option>' +_option); 
            console.log($( '#stats_info_m_cd' ).html);
            $( '#stats_info_m_cd' ).val(stats_info_m_cd_);
            
            
            $("#contents").val(data.statsInfopage.contents);  
            oEditors.getById["contents"].exec("LOAD_CONTENTS_FIELD");          
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    
}


// 정보페이지 추가
function infopageInsert(){
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

	if($("#contents").val() == "<p>&nbsp;</p>"){
		alert("내용을 입력해주십시요.");
		return;
	}
	   
	if ( $("#writeFrm").parsley().validate() && confirm( '등록하시겠습니까?' )){
		   
		// 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
	  		success: function(responseText, statusText){
	  			alert(responseText.message);
	  			if(responseText.success == "true"){
	  			  	reloadInfopageList();
		  			oEditors.getById["contents"].exec("SET_IR", [""]);
		  			$("#addBts").show();
		  			$("#modifyBts").hide();
	  			}	
	  		},
	  		dataType: "json", 				
	  		url: "/admin/stats/insertStatsInfopage.do"
  		});	
	}
}



// 정보페이지 변경
function infopageUpdate(){
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

	if($("#contents").val() == "<p>&nbsp;</p>"){
		alert("내용을 입력해주십시요.");
		return;
	}
	   
	if ( $("#writeFrm").parsley().validate() && confirm( '저장하시겠습니까?' )){
		   
		// 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
	  		success: function(responseText, statusText){
	  			alert(responseText.message);
	  			if(responseText.success == "true"){
	  			  	reloadInfopageList();
	  			}	
	  			oEditors.getById["contents"].exec("SET_IR", [""]);
	  			$("#addBts").show();
	  			$("#modifyBts").hide();
	  		},
	  		dataType: "json", 				
	  		url: "/admin/stats/updateStatsInfopage.do"
		});
		
	}

}
//정보페이지 변경
function infopageCancel(){
	
   
	if ( $("#writeFrm").parsley().validate() && confirm( '취소하시겠습니까?' )){
		   
		$('#stats_info_m_cd').attr('disabled', false);
		
	  	reloadInfopageList();
		oEditors.getById["contents"].exec("SET_IR", [""]);

		$("#addBts").show();
		$("#modifyBts").hide();
	}

}


// 정보페이지 미리보기
function infopagePreview(){

	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	
	if($("#contents").val() == "<p>&nbsp;</p>"){
		alert("내용을 입력해주십시요.");
		return;
	}
	
    if ( $("#writeFrm").parsley().validate() ){

		var args = 'scrollbars=no,toolbar=no,location=no,left='+$("#left").val()+',top='+$("#top").val()+',width='+$("#width").val()+',height='+$("#height").val();
		openPopUp("about:blank", "Infopage_Preview", "700", "800"); 
    
		var f = document.writeFrm;  
	
		f.target = "Infopage_Preview";
		f.action ="/admin/stats/statsInfopagePreview.do";
		f.submit();
    }   
}

function search() {

  	jQuery("#infopage_list").jqGrid('setGridParam', {
  		datatype : 'json',
  		url : selectStatsInfopageUrl,
  		page : 1,
  		postData : {
  			bs_yy : $("#bs_yy").val(),
  			stats_info_l_cd : $("#stats_info_l_cd").val(),
  			stats_info_m_cd : $("#stats_info_m_cd").val(),
  		},
  		mtype : "POST"
  	}

  	).trigger("reloadGrid");

  	oEditors.getById["contents"].exec("SET_IR", [""]);
	$("#addBts").show();
	$("#modifyBts").hide();
  	
	loadStats_info_m_cd( $( '#stats_info_m_cd' ) );			
}
  
//초기화
function formReset(){
  	$("select[name=bs_yy] option[value='']").attr("selected",true);
  	$("select[name=stats_info_l_cd] option[value='']").attr("selected",true);
  	$("select[name=stats_info_m_cd] option[value='']").attr("selected",true);
	oEditors.getById["contents"].exec("SET_IR", [""]);
  	search();
}

</script>


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
	<form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" data-parsley-validate="true">
		<div class="search_area" >
			<table class="search_box">
				<caption>통계해설관리 조회</caption>
				<colgroup>
					<col style="width: 130px;">
					<col style="width: 30%;">
					<col style="width: 80px;">
					<col style="width: 30%;">
					<col style="width: *;" />
					
				</colgroup>
				
				<tbody>
				<tr>
					<th scope="row">
						발행년도(기준년도)<strong class="color_pointr">*</strong>
					</th>
					<td>
						<select class="in_wp100" id="bs_yy">
							<option value="" >전체선택</option>
							<c:forEach var="i" begin="2012" end="2017" >
							    <c:set var="yearOption" value="${2017-i+2012}" />
							    <option value="${yearOption}">${yearOption}(${yearOption-1})</option>
							</c:forEach>
						</select>

					</td>
					<th scope="row">
						주요통계<strong class="color_pointr">*</strong>
					</th>
					<td>
						<g:select id="stats_info_l_cd" name="stats_info_l_cd" codeGroup="STATS_INFO_L_CD"  titleCode="전체" cls="form-control" class="in_wp200"/>  	
					</td>
				</tr>
				</tbody>
			</table>
			<!--// table_area -->
			<div class="search_area_btnarea">
				<a href="javascript:search();" class="btn sch" title="조회">
					<span>조회</span>
				</a>
				<a href="javascript:formReset();" class="btn clear" title="초기화">
					<span>초기화</span>
				</a>
			</div>
		</div>
		<div class="editor_area view">
			<table id="table_add" class="write">
				<caption>통계해설관리 조회</caption>
				<colgroup>
					<col style="width: 130px;">
					<col style="width: *px;">
				</colgroup>
				
				<tbody>
				<tr>
					<th scope="row">
						통계별 해설 분류 <strong class="color_pointr">*</strong>
					</th>
					<td>
						<select class="in_wp400" id="stats_info_m_cd" name="stats_info_m_cd" >
							<option value="">- 선택 -</option>
							<c:forEach var="item" items="${stats_info_m_list}">
								<option value="${item.code}">${item.codenm}</option>
							</c:forEach>
	                     </select>
					</td>
				</tr>
				</tbody>
			</table>

			<textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;">					
			</textarea>
		</div>			
		
	</form>
	
	
	<!-- button_area -->
	<div class="button_area">
		<div class="float_left">
			<a href="javascript:infopagePreview();" class="btn basic" title="정보페이지 미리보기">
				<span class="look">미리보기</span>
			</a>
		</div>
		<div id="modifyBts" class="float_right">
			<button id="infoSaveBt" class="btn save" title="저장하기" onclick="javascript:infopageUpdate();" >
				<span>저장</span>
			</button>
			<button id-"infoCancelBt" class="btn cancel" title="취소" onClick="javascript:infopageCancel()">
				<span>취소</span>
			</button>
		</div>

		<div id="addBts" class="float_right">
			<button id="infoAddBt" onclick="javascript:infopageInsert();" class="btn save" title="등록">
				<span>등록</span>
			</button>
		</div>
	</div>
	<!--// button_area -->
		
	
	<div class="table_area" id="infopage_list_div" >
	    <table id="infopage_list"></table>
        <div id="infopage_pager"></div>
	</div>
	
	<!--// button_area -->
	
</div>
<!--// content -->

<script language="javascript">

var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "contents",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=contents' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
    }, 
    fCreator: "createSEditor2"
});

</script>