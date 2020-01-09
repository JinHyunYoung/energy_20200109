<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />
<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>	     
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>

<script language="javascript">

$( document ).ready( function(){
	
	$( '.datepicker' ).each( function(){
	    $( this ).datepicker( {
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

	$('#reg_file_layer').hide();	
	
	$('#file_list').jqGrid({
		datatype: "json",
		url : '/admin/support/scheduleFileList.do'+'?group_id='+$('#group_id').val() ,
		mtype: 'POST',
	    colModel:[
  	    	{label: '원본파일명', name:'ori_file_nm',index:'ori_file_nm', align : 'center', width:500},  
	    	{label: '파일크기', name:'file_size',index:'file_size', align : 'right', width:100},
	    	{label: '파일종류', name:'file_type',index:'file_type', align : 'center', width:100},
	    	{label: '파일', name:'file_nm',index:'file_nm', align : 'center', width:80, formatter:formatFile},
	    	{label: '파일ID', name:'file_id',index:'file_id', align : 'center', width:60,  hidden: true},
	    	{label: '파일ID', name:'group_id',index:'group_id', align : 'center', width:60,  hidden: true},
	    ],
		rowNum : -1,
		rownumbers : true,
		viewrecords : true,	
		sortname : "file_title",
		height : 150, 
		sortorder : "asc",
		edittype :"text",
		onCellSelect: function(rowid, index, contents, event)
		{
				viewRegFileLayer();
				var cel_file_id =  $('#file_list').jqGrid ('getRowData',rowid).file_id;
				var cel_file_nm = $('#file_list').jqGrid ('getRowData',rowid).ori_file_nm;
				
				$("#input_file_id").val(cel_file_id);
				$("#attached_file").val('');
				$("#del_file_btn").show();
				
				var file_download_html = '<div class="file_area" id="file_area1"><ul class="file_list"><li>'
										+'<a href="/commonfile/fileidDownLoad.do?file_id='+cel_file_id+'"  target="_blank" class="download" title="다운받기">'+cel_file_nm+'</a>'
										+'</li></ul></div>';				
				
				$("#file_area1").remove();
				$("#attach_file").after(file_download_html);
		},
		beforeEditCell : function(rowid, cellname, value, iRow, iCol) {
			savedRow = iRow; 							
			savedCol = iCol;
	    },
		loadComplete : function(data) {
			showJqgridDataNon(data, "file_list",5);
		}
		
	});
	//jq grid 끝 
	
	$( '#save' ).bind( 'click' , function(){		
		
		var valid = false;
		
		if( $.trim( $( '#first_day' ).val() ) == '' && $.trim( $( '#last_day' ).val() ) == '' ){
			$( '#first_day' ).addClass( 'parsley-error' );
			$( '#last_day' ).addClass( 'parsley-error' );
			$( '#first_day' ).focus();
			valid = false;			
		}else if( $.trim( $( '#first_day' ).val() ) == '' ){
			$( '#last_day' ).addClass( 'parsley-success' );
			$( '#first_day' ).addClass( 'parsley-error' );
			$( '#first_day' ).focus();
			valid = false;
		}else if( $.trim( $( '#last_day' ).val() ) == '' ){
			$( '#first_day' ).addClass( 'parsley-success' );
			$( '#last_day' ).addClass( 'parsley-error' );
			$( '#last_day' ).focus();
			valid = false;
		}else{
			$( '#first_day' ).addClass( 'parsley-success' );
			$( '#last_day' ).addClass( 'parsley-success' );
			valid = true;
		}
		
		$( '#first_day , #last_day' ).unbind( 'change , keyup , keypress , blur' );
		$( '#first_day , #last_day' ).bind( 'change , keyup , keypress , blur' , function(){
			if( $( this ).val() == '' ){
				$( this ).addClass( 'parsley-error' );
				$( this ).removeClass( 'parsley-success' );
			}else{
				$( this ).addClass( 'parsley-success' );
				$( this ).removeClass( 'parsley-error' );
			}
		});
		
		if( valid == true ){
			if ( ! $("#form_schedule" ).parsley().validate() ){
				valid = false;
			}		
			
			if( $( '#first_day' ).val().replace( /-/g , '' ) > $( '#last_day' ).val().replace( /-/g , '' ) ){
				alert( '행사종료일자가 행사시작일자보다 빠를 수 없습니다.' );
				valid = false;
				return false;				
			}
		}
		
		if( valid == true && confirm( '행사일정을 저장하시겠습니까?' ) ){
			
			if( $( 'input[name=evt_sn]' ).val() == '' ){
				submitSchedule( '<c:url value="/admin/support/insertSchedule.do" />' );
			}else{
				submitSchedule( '<c:url value="/admin/support/updateSchedule.do" />' );
			}
		}
		
		return false;
	});
	
});


function submitSchedule( _url ){
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	
	// 데이터를 등록 처리해준다.
	$("#form_schedule").ajaxSubmit({
  		success: function(responseText, statusText){
        	if( responseText.success == 'true' ){
        		alert( "행사일정 등록을 성공하였습니다." );
        		schedule.make();
        		popupClose();
        	}else if( responseText.success == 'false' ){
        		alert( "행사일정 등록을 실패하였습니다." );
        	}
  		},
        error: function(e) {
            alert( "일정을 저장하는데 실패하였습니다." );
        },
  		dataType: "json", 		
        type: 'post' ,		
  		url: _url
	});	
}

//jq grid 데이터 갱신
function reloadFileList(){
	jQuery("#file_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : '/admin/support/scheduleFileList.do'+'?group_id='+$('#group_id').val(),
		page : 1,
		postData : {
			region : $("#p_region").val(),
			use_yn : $("#p_use_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
}

function deleteFile(){
	console.log($('#input_file_id').val());
	$.ajax
	({
		type: "POST",
           url: '/admin/support/deleteScheduleFile.do',
           data:{
        	   file_id : $('#input_file_id').val(),
        	   group_id : $('#group_id').val()
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				hideRegFileLayer();
				reloadFileList();
			}	
		}
	});
}

//파일 저장 ( 추가 / 수정 )
function saveFile(){
	
	var url;
	if($('#input_file_id').val() == ''){
		url = '/admin/support/insertScheduleFile.do';
	}else{
		url = '/admin/support/updateScheduleFile.do';
	}
	
	// 데이터를 등록 처리해준다.
	$('#fileUploadFrm').ajaxSubmit({
		enctype: "multipart/form-data", 
		dataType: "json",
		url: url ,
		success: function(responseText, statusText){
			alert(responseText.message);
			hideRegFileLayer();
			if($('#group_id').val() == ''){
				$('#group_id').val(responseText.group_id);
				$('#file_group_id').val(responseText.group_id);
			}
			console.log()
			reloadFileList();
		},
		error: function(data){ 
		}
	});	
} 

//파일 등록 페이지 보기
function viewRegFileLayer(){ 	
	$("#reg_file_layer").show();
	$("#file_area1").remove();
	$("#attached_file").val('');
	$("#input_file_id").val('');
	$("#del_file_btn").hide();
} 

//파일 등록 페이지 닫기
function hideRegFileLayer(){ 
	$('#reg_file_layer').hide();
}




//jqgrid 파일 첨부 이미지 출력 format
function formatFile(cellvalue, options, rowObject){
	var str ="";
	var opt = rowObject[1]; 
	
	//이미지 추가
	  if( opt != "" ){                      
	   str += "<img src=\"/images/admin/icon/icon_file2.png\" />";   
	  }
	  return str;
}

</script>
<div id="wrap">		

	<!-- popup_content -->
	
	<!-- header -->
	<div id="pop_header">
		<header>
			<h1 class="pop_title">행사일정 등록/수정</h1>
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
			<div id="pop_content">
			
				<!-- division -->
				<div class="division">
				
					<!-- table_area -->
					<form name="form_schedule" id="form_schedule">
					
						<input type="hidden" name="evt_sn" value="${schedule.evt_sn}" />
						<input type='hidden' id="group_id" name='group_id' value="${schedule.group_id}" />
						
						<div class="table_area">
							<table class="write fixed">
								<caption>행사일정 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 120px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">국내외구분</th>
										<td>
											<input id="kor" name="domestic_yn" type="radio" value="Y" <c:if test="${ schedule.domestic_yn eq 'Y' || empty schedule.domestic_yn }">checked="checked"</c:if> />
											<label for="kor">국내</label>
											<input id="foreign" name="domestic_yn" type="radio" value="N" <c:if test="${ schedule.domestic_yn eq 'N' }">checked="checked"</c:if> class="marginl15" />
											<label for="foreign">해외</label>
										</td>
									</tr>
									<tr>
										<th scope="row">일정<strong class="color_pointr">*</strong></th>
										<td>
											<input id="first_day" name="evt_strt_dt" type="text" value="${schedule.evt_strt_dt}" class="in_wp100 datepicker" />
											 ~ 
											<input id="last_day" name="evt_end_dt" type="text" value="${schedule.evt_end_dt}" class="in_wp100 datepicker" />
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="input_title">제목<strong class="color_pointr">*</strong></label>
										</th>
										<td>
											<input type="text" name="evt_ttle" id="input_title" value="${schedule.evt_ttle}" class="in_w98" data-parsley-required="true" />
										</td>
									</tr>
									<tr>
										<th scope="row">아이콘</th>
										<td>
											<input id="red" name="evt_tp_icon" value="RED" type="radio" <c:if test="${ schedule.evt_tp_icon eq 'RED' || empty schedule.evt_tp_icon }">checked="checked"</c:if> />
											<label for="red">빨강</label>
											<input id="orange" name="evt_tp_icon" value="ORANGE" type="radio" class="marginl15" <c:if test="${ schedule.evt_tp_icon eq 'ORANGE' }">checked="checked"</c:if> />
											<label for="orange">주황</label>
											<input id="yellow" name="evt_tp_icon" value="YELLOW" type="radio" class="marginl15" <c:if test="${ schedule.evt_tp_icon eq 'YELLOW' }">checked="checked"</c:if> />
											<label for="yellow">노랑</label>
											<input id="green" name="evt_tp_icon" value="GREEN" type="radio" class="marginl15" <c:if test="${ schedule.evt_tp_icon eq 'GREEN' }">checked="checked"</c:if> />
											<label for="green">녹색</label>
											<input id="blue" name="evt_tp_icon" value="BLUE" type="radio" class="marginl15" <c:if test="${ schedule.evt_tp_icon eq 'BLUE' }">checked="checked"</c:if> />
											<label for="blue">파랑</label>
											<input id="navy" name="evt_tp_icon" value="NAVY" type="radio" class="marginl15" <c:if test="${ schedule.evt_tp_icon eq 'NAVY' }">checked="checked"</c:if> />
											<label for="navy">남색</label>
											<input id="purple" name="evt_tp_icon" value="PURPLE" type="radio" class="marginl15" <c:if test="${ schedule.evt_tp_icon eq 'PURPLE' }">checked="checked"</c:if> />
											<label for="purple">보라</label>
										</td>
									</tr>
									<tr>
										<th scope="row">내용</th>
										<td>
											<div class="division20" style="width:700px !important;">
												<textarea id="contents" name="contents" class="in_w98" rows="10" title="내용입력">${schedule.evt_cn}</textarea>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>					
					
					</form>
					<!--// table_area -->
						<!-- title_area -->
					<div class="title_area">
						<h4 class="title">첨부파일</h4>
					</div>
					<!--// title_area -->
					
					<div class="division20" style="padding: 20px; border: 1px solid #d2d2d2;" id="file_list_div" >
						<table id="file_list"></table>
					</div>
					<!-- button_area -->
					<div class="button_area margint20">
						<div class="float_right">
							<button type="button" class="btn acti" title="등록" onclick="viewRegFileLayer();">
								<span>등록</span>
							</button>
						</div>
					</div>
					<form id="fileUploadFrm" name="fileUploadFrm" method="post" enctype="multipart/form-data">
					
						<input type="hidden" name="file_group_id" id="file_group_id" value="${schedule.group_id}" />
						<input type="hidden" name="input_file_id" id="input_file_id" value="${schedule.file_id}" />
						
						<!-- table_area -->
						<div class="table_area" id="reg_file_layer">
						
							<table class="write">
								<caption>첨부파일 등록 화면</caption>
								<colgroup>
									<col style="width: 120px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">첨부파일</th>
										<td>
											<div id="attach_file">
												<div class="file_area">
													<label for="attached_file" class="hidden">파일 선택하기</label>
													<input id="attached_file" name="attached_file" type="file" class="in_wp400" />
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							
							<!-- button_area -->
							<div class="button_area">
								<div class="float_right">
									<button type="button" class="btn acti" title="저장" onclick="saveFile();">
										<span>저장</span>
									</button>
									<button type="button" id="del_file_btn" class="btn acti" title="삭제" onclick="deleteFile();">
										<span>삭제</span>
									</button>
									<button type="button" class="btn acti" title="목록" onclick="hideRegFileLayer();">
										<span>목록</span>
									</button>
								</div>
							</div>
							
						</div>
					</form>
					
					<!-- button_area -->
					<div class="button_area">
						<div class="float_right">
							<button id="save" class="btn save" title="저장">
								<span>저장</span>
							</button>
						</div>
					</div>
					<!--// button_area -->		
									
				</div>
				<!--// division -->
				
			</div>
		</div>
	</article>	
	</div>
	<!--// popup_content -->
	
</div>


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