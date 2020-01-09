<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var insertLogoUrl = "<c:url value='/admin/logo/insertLogo.do'/>";
var updateLogoUrl = "<c:url value='/admin/logo/updateLogo.do'/>"
var deleteLogoUrl = "<c:url value='/admin/logo/deleteLogo.do'/>";

$(document).ready(function(){
	
});

function reload() {
    location.href = "/admin/logo/logoWrite.do";
}

function logoInsert(){
	
	   for(var i =1; i < 5; i++ ){
				if ($("#uploadFile"+i).val() != "" && !$("#uploadFile"+i).val().toLowerCase().match(/\.(jpg|png|gif)$/)){
				    alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
				    return;
				}  
	   }
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){
		   
		   url = insertLogoUrl;
		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						reload();
  					}	
  				},
  				dataType: "json", 				
  				url: url
  		    });	
		   
	   }
}

function delFile(gubun){
	   if(gubun == "1") $("#front_top").val("");
	   else	if(gubun == "2") $("#front_bottom").val("");
	   else	if(gubun == "3") $("#back_top").val("");
	   else	if(gubun == "4") $("#backsub_top").val("");
	   
		$("#frontTopFile"+gubun).hide();
}

</script>

<!-- content -->
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
	
	<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true"  enctype="multipart/form-data">
       
		<input type='hidden' id="front_top" name='front_top' value="${logo.front_top}" />
	    <input type='hidden' id="front_bottom" name='front_bottom' value="${logo.front_bottom}" />
	    <input type='hidden' id="back_top" name='back_top' value="${logo.back_top}" />
	    <input type='hidden' id="backsub_top" name='backsub_top' value="${logo.backsub_top}" />
    
		<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>로고 등록</caption>
				<colgroup>
				    <col style="width: 120px;" />
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
				    <th scope="row" rowspan="2" >사용모드</br>(Frontend)</th>
					<th scope="row">Top 로고</th>
					<td>
					  <c:if test="${!empty logo.front_top}">
	                      <p id="frontTopFile1"><a href="/commonfile/fileidDownLoad.do?file_id=${logo.front_top}" >${logo.front_top_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('1')"></a></p>
                      </c:if>
                      <input class="in_w50" type="file" id="uploadFile1" name="uploadFile1" value="" />
					</td>
				</tr>
				<tr>
					<th scope="row">Bottom 로고</th>
					<td>
					  <c:if test="${!empty logo.front_bottom}">
	                      <p id="frontTopFile2"><a href="/commonfile/fileidDownLoad.do?file_id=${logo.front_bottom}" >${logo.front_bottom_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('2')"></a></p>
                      </c:if>
                      <input class="in_w50" type="file" id="uploadFile2" name="uploadFile2" value="" />
					</td>
				</tr>
				<tr>
				    <th scope="row" rowspan="3">관리모드 Gate</th>
					<th scope="row">타이틀</th>
					<td>
                         <input class="in_w50" type="text" id="back_title" name="back_title" value="${logo.back_title}" placeholder="관리모드 타이틀" data-parsley-required="false" data-parsley-maxlength="100" />
				    </td>
				</tr>
				<tr>
					<th scope="row">Top 로고</th>
					<td>
                         <c:if test="${!empty logo.back_top}">
                      	   <p id="frontTopFile3"><a href="/commonfile/fileidDownLoad.do?file_id=${logo.back_top}" >${logo.back_top_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('3')"></a></p>
                      </c:if>
                      <input class="in_w50" type="file" id="uploadFile3" name="uploadFile3" value="" />
					</td>
				</tr>
				<tr>
					<th scope="row">문의처</th>
					<td>
                   	   <textarea class="in_w100" id="back_refer" name="back_refer" placeholder="관리모드 문의처" rows="4" data-parsley-maxlength="1000" >${logo.back_refer}</textarea>
					</td>
				</tr>
				<tr>
				    <th scope="row" rowspan="2">관리모드 Sub</th>
					<th scope="row">타이틀</th>
					<td>
                   	    <input class="in_w100" type="text" id="backsub_title" name="backsub_title" value="${logo.backsub_title}" placeholder="관리모드sub 타이틀" data-parsley-required="false" data-parsley-maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="row">Top 로고</th>
					<td>
                   	  <c:if test="${!empty logo.backsub_top}">
                      <p id="frontTopFile4"><a href="/commonfile/fileidDownLoad.do?file_id=${logo.backsub_top}" >${logo.backsub_top_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('4')"></a></p>
                      </c:if>
                      <input class="in_w50" type="file" id="uploadFile4" name="uploadFile4" value="" />
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// write_basic -->
		
  		<!-- footer --> 
		<div id="footer">
			<footer>
				<div class="button_area alignc">
					<a href="javascript:logoInsert()" class="btn save" title="저장">
						<span>저장</span>
					</a>
				</div>
			</footer>
		</div>
		<!-- //footer -->
		
	</form>
	
</div>