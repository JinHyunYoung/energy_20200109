<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var savedRow = null;
var savedCol = null;
var selectBannerListUrl = "<c:url value='/admin/banner/bannerList.do'/>";
var bannerWriteUrl =  "<c:url value='/admin/banner/bannerWrite.do'/>";
var insertBannerUrl = "<c:url value='/admin/banner/insertBanner.do'/>";
var updateBannerUrl = "<c:url value='/admin/banner/updateBanner.do'/>"
var deleteBannerUrl = "<c:url value='/admin/banner/deleteBanner.do'/>";
var bannerReorderUrl = "<c:url value='/admin/banner/updateBannerReorder.do'/>";

$(document).ready(function(){
	
	$('#modal-banner-write').popup();
	
	$('#banner_list').jqGrid({
	    
		datatype: 'json',
		url: selectBannerListUrl,
		mtype: 'POST',
		colModel: [
			{ label: '순서', index: 'sort', name: 'sort', width: 50, align : 'center', editable : true, sortable:false,editoptions:{dataInit: function(element) {
				$(element).keyup(function(){
					chkNumber(element);
				});
			}}  },
			{ label: '코드', index: 'banner_id', name: 'banner_id', align : 'center', width:100, sortable:false},
			{ label: '이미지/타이틀명', index: 'titl_nm', name: 'titl_nm', align : 'left', sortable:false, width:200, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', index: 'use_yn', name: 'use_yn', align : 'center', sortable:false, width:60, formatter:jsUseynLinkFormmater}
			/*{ label: '클릭수', index: 'click_cnt', name: 'click_cnt', width: 40, align : 'center', sortable:false }*/
		],
		postData :{	
			region : $("#p_region").val(),
			use_yn : $("#p_use_yn").val()
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
		loadComplete : function(data) {
			showJqgridDataNon(data, "banner_list",6);
		}
	});
	//jq grid 끝 

	bindWindowJqGridResize("banner_list", "banner_list_div");

});

function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "<a href=\"javascript:bannerWrite('"+rowObject.banner_id+"')\">"+rowObject.titl_nm+"</a>";
	
	return str;
}

function jsUseynLinkFormmater(cellvalue, options, rowObject) {
	
	var str = "사용";
	
	if(cellvalue == "N") str = "미사용";
	
	return str;
}

function search() {
		
	jQuery("#banner_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : selectBannerListUrl,
		page : 1,
		postData : {
			region : $("#p_region").val(),
			use_yn : $("#p_use_yn").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function bannerWrite(bannerId) {
    var f = document.listFrm;
    var mode = "W";
    if(bannerId != "") mode = "E";
    
	$('#pop_content').html("");
	
	$("#mode").val(mode);
    $.ajax({
        url: bannerWriteUrl,
        dataType: "html",
        type: "post",
        data: {
           mode : mode,
  		   banner_id : bannerId,
  		   region : $("#p_region").val()
		},
        success: function(data) {
        	$('#pop_content').html(data);
        	popupShow();
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
  
}

function bannerInsert(){
	   var url = "";
	   
		if ($("#uploadFile").val() != "" && !$("#uploadFile").val().toLowerCase().match(/\.(jpg|png|gif|mp4|avi|mp3)$/)){
		    alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
		    return;
		}  
	   
	   if ( $("#writeFrm").parsley().validate() ){

		   url = insertBannerUrl;
		   if($("#mode").val() == "E") url = updateBannerUrl; 
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						search();
  						popupClose();
  					}	
  				},
  				dataType: "json",
  				url: url
  		    });	
		   
	   }
}

function bannerDelete(bannerId){
	   if(!confirm("선택하신 배너를 정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteBannerUrl,
	           data:{
	           	banner_id : bannerId
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					search();
					popupClose();
				}	
			}
		});
}


function bannerReorder(){
	var updateRow = new Array();
	var saveCnt = 0;
	debugger;
	jQuery('#banner_list').jqGrid('saveCell', savedRow, savedCol);
	
	var arrrows = $('#banner_list').getRowData();
	if(arrrows != undefined && arrrows.length > 0)
		for(var i=0;i<arrrows.length;i++){
			//필수값 체크
			if(arrrows.length>0){
				if(arrrows[i].sort == '' || arrrows[i].sort == null){
					alert("순서는 필수값입니다. 확인 후 다시입력해주세요");
					return;
				}
			}
			arrrows[i].title="";
			arrrows[i].titl_nm="";
			updateRow[saveCnt++] = arrrows[i];
		}
	else {
		alert("순서를 저장할 코드가 없습니다.");
		return;
	}
		
	$.ajax
	({
		type: "POST",
           url: bannerReorderUrl,
           data:{
            banner_list : JSON.stringify(updateRow) 
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				search();
			}	
		}
	});
}

function formReset(){
	$("select[name=p_use_yn] option[value='']").attr("selected",true);
}

function popupShow(){
	$("#modal-banner-write").popup('show');
}

function popupClose(){
	$("#modal-banner-write").popup('hide');
}

function delFile(){
	$("#image").val("");
	$("#uploadedFile").hide();
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
	
		<input type='hidden' id="mode" name='mode' value="W" />
	
		<!-- main_list_box -->
		<div class="main_list_box">
			<img class="main_img" src="/images/admin/common/main_list_img.png" alt="메인 레이아웃 이미지" />
			
			<!-- main_list_area -->
			<div class="main_list_area">
			
				<!-- search_area -->
				<div class="search_area">
					 <table class="search_box">
						<caption>배너검색</caption>
						<colgroup>
							<col style="width: 40px;" />
							<col style="width: *;" />
							<col style="width: 60px;" />
							<col style="width: *;" />
						</colgroup>
						<tbody>
						<tr>
							<th>영역</th>
							<td>
			                       <g:select id="p_region" name="p_region" codeGroup="BANNER_REGION" selected="${param.p_region}" cls="form-control input-sm in_w90" onChange="search()" />  
							</td>
							<th>사용여부</th>
							<td>
			                  <select id="p_use_yn" name="p_use_yn" class="form-control input-sm in_w90">
			                       <option value="">- 전체 -</option>
			                       <option value="Y" <c:if test="${param.p_use_yn == 'Y'}">selected</c:if>>사용</option>
			                       <option value="N" <c:if test="${param.p_use_yn == 'N'}">selected</c:if>>미사용</option>
			                  </select>
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
						<a href="javascript:bannerReorder()" class="btn acti" title="순서저장">
							<span>순서저장</span>
						</a>
						<a href="javascript:bannerWrite('')" class="btn acti" title="배너등록">
							<span>배너등록</span>
						</a>
					</div>
				</div>
				<!--// tabel_search_area -->
	
				<!-- table 1dan list -->
				<div class="table_area" id="banner_list_div" >
				    <table id="banner_list"></table>
				</div>
				<!--// table 1dan list -->
		
			</div>
			<!--// main_list_area -->
			
		</div>
		<!--// main_list_box -->	

	</form>
	
</div>
<!--// content -->


 <div id="modal-banner-write" style="width:600px;background-color:white">
	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">배너 등록</h1>
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
	 		