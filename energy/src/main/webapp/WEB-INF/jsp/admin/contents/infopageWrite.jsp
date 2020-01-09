<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script type="text/javascript">

var selectInfopageUrl = "<c:url value='/admin/infopage/infopagePageList.do'/>";

$(document).ready(function(){
	
	$('#infopage_list').jqGrid({
		datatype: 'json',
		url: selectInfopageUrl + '?info_type=' + $("#info_type").val(),
		mtype: 'POST',
		colModel: [
			{ label: '번호', index: 'rnum', name: 'rnum', hidden:true , formatter:jsRownumFormmater},
			{ label: '버전', index: 'version', name: 'version', width: 50, align : 'center', sortable:false, formatter:jsVersionFormmater },
			{ label: '개정변경일', index: 'revision_date', name: 'revision_date', align : 'center', width:100},
			{ label: '제목', index: 'title', name: 'title', align : 'left', width:200, sortable:false, formatter:jsTitleLinkFormmater},
			{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', width: 40, align : 'center', sortable:false },
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 60, align : 'center', sortable:false },
			{ label: '정보구분', index: 'info_type', name: 'info_type',  hidden:true }
		],
		postData :{	
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#infopage_pager',
		viewrecords : true,
		sortname : "version",
		sortorder : "desc",
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
			
			showJqgridDataNon(data, "infopage_list",7);

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
	
	$("#infoSaveBt").hide();

});

function jsVersionFormmater(cellvalue, options, rowObject) {
	return "1." + rowObject.version;
}

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:selectedInfoPage('"+rowObject.rnum+"','"+rowObject.info_type+"','"+rowObject.version+"')\">"+rowObject.title+"</a>";
	return str;
}


function jsRownumFormmater(cellvalue, options, rowObject) {	
	var str = $("#total_cnt").val()-(rowObject.rnum-1);	
	return str;
}

//jq grid 데이터 갱신
function reloadInfopageList(){
	jQuery("#infopage_list").jqGrid('navGrid', {
		datatype: 'json',
		url: selectInfopageUrl + '?info_type=' + $("#info_type").val(),
		mtype: 'POST',
		page : 1,
		postData : {
			searchkey : $("#p_searchkey").val(),
			searchtxt : $("#p_searchtxt").val(),
			satis_yn : $("#p_satis_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}


// 선택된 정보페이지를 가져온다.
function selectedInfoPage(rnum, info_type_, version_) {
        
    if(rnum == 1){
		$("#infoSaveBt").show();	
    } else {
		$("#infoSaveBt").hide();	
    }
    
    $.ajax({
        url: "/admin/infopage/selectInfopage.do",
        dataType: "json",
        type: "post",
        data: {
           info_type : info_type_,
           version : version_
		},
        success: function(data) {

            $("#info_type").val(data.infopage.info_type);
            $("#revision_date").val(data.infopage.revision_date);
            $("#title").val(data.infopage.title);
            $("#version").val(data.infopage.version);
            $("#contents").val(data.infopage.contents);  
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
	  			}	
	  		},
	  		dataType: "json", 				
	  		url: "/admin/infopage/insertInfopage.do"
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
	  		},
	  		dataType: "json", 				
	  		url: "/admin/infopage/updateInfopage.do"
		});	
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
		f.action ="/admin/infopage/infopagePreview.do";
		f.submit();
    }   
}

</script>


<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">
				<c:if test="${info_type == 'clause'}">이용약관관리</c:if>
				<c:if test="${info_type == 'privacy'}">개인정보처리방침</c:if>			
			</h3>
		</div>
		<!--// main_title -->
		
	</div>	
	<!--// title_and_info_area -->
	
	<form id="writeFrm" name="writeFrm" method="post"  onsubmit="return false;" data-parsley-validate="true">
	
		<input type='hidden' id="info_type" name='info_type' value="${info_type}" />
		<input type='hidden' id="version" name='version' value="" />
	
		<!-- table_area -->
		<div class="table_area">
		
			<table class="write">
				<caption>등록 화면</caption>
				
				<colgroup>
					<col style="width: 120px;">
					<col style="width: 150px;">
					<col style="width: 120px;">
					<col style="width: *;">
				</colgroup>
				
				<tbody>
				<tr>
					<th scope="row">
						계정변경일<strong class="color_pointr">*</strong>
					</th>
					<td>
						<input id="revision_date" name="revision_date" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="" readonly />
						<label for="revision_date"/>
					</td>
					<th scope="row">
						제목<strong class="color_pointr">*</strong>
					</th>
					<td>
						<label for="title"/>
						<input id="title" name="title" type="text" class="in_wp500" data-parsley-required="true" value="" />
					</td>
				</tr>
				</tbody>
			</table>
			
			<div class="editor_area view">
				<textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;">					
				</textarea>
			</div>			
			
		</div>
		<!--// table_area -->
		
	</form>
	
	
	<!-- button_area -->
	<div class="button_area">
		<div class="float_left">
			<a href="javascript:infopagePreview();" class="btn basic" title="정보페이지 미리보기">
				<span class="look">미리보기</span>
			</a>
		</div>
		<div class="float_right">
			<button id="infoSaveBt" onclick="javascript:infopageUpdate();" class="btn save" title="저장하기">
				<span>저장</span>
			</button>
		</div>
	</div>
	<!--// button_area -->
		
	
	<div class="table_area" id="infopage_list_div" >
	    <table id="infopage_list"></table>
        <div id="infopage_pager"></div>
	</div>
	
	<!-- button_area -->
	<div class="button_area">
		<div class="float_right">
			<button onclick="javascript:infopageInsert();" class="btn save" title="계정변경 생성">
				<span>계정변경 생성</span>
			</button>
		</div>
	</div>
	<!--// button_area -->
	
</div>
<!--// content -->

<script language="javascript">

$('.datepicker').each(function(){
    $(this).datepicker({
		  format: "yyyy-mm-dd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true,
		  showOn: "button",
		  buttonImage:"/images/admin/icon/icon_calendar.png",
		  buttonImageOnly:true,
		  changeMonth: true,
          changeYear: true,
          showButtonPanel:false
		 });
});
	
	
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