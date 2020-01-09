<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>
<script language="javascript">
var excelValidUrl = '<c:url value="/admin/stats/statsResearchValid.do" />';
var excelUploadUrl = '<c:url value="/admin/stats/statsResearchResult.do" />';
var excelUploadListUrl = '<c:url value="/admin/stats/statsExcelUploadList.do" />';
	$(document).ready(function(){
		$("#addBts").hide();	
		validBtnChange("hide");
	});
	
	function validBtnChange(_param){
		if (_param ="show") {
			$("#search_area_btnarea").show();
		} else if (_param ="hide"){
			$("#search_area_btnarea").hide();
		}
	}
	
	function excelUpload(){
		if($("#bs_yy").val() == ""){
			alert("기준 년도를 선택해 주십시요.");
			return;
		}
		if($("#excel_file").val() == ""){
			alert("업로드 파일을 선택해 주십시요.");
			return;
		}
		
		if($("#excel_file").val() != "" && !$("#excel_file").val().toLowerCase().match(/\.(xls|xlsx)$/)){
		    alert("확장자가 xls,xlsx 파일만 업로드가 가능합니다.");
		    return;
		}
		
	   // 데이터를 등록 처리해준다.
	   $("#excelFrm").ajaxSubmit({
			success: function(data){
	        	$('div.excelUploadResult').html( data );
	    		$("#addBts").hide();	
			},
			dataType: "html",
			url: excelUploadUrl
	    });
	}
	
	function excelValid(){
		if($("#bs_yy").val() == ""){
			alert("기준 년도를 선택해 주십시요.");
			return;
		}
		if($("#excel_file").val() == ""){
			alert("업로드 파일을 선택해 주십시요.");
			return;
		}
		
		if($("#excel_file").val() != "" && !$("#excel_file").val().toLowerCase().match(/\.(xls|xlsx)$/)){
		    alert("확장자가 xls,xlsx 파일만 업로드가 가능합니다.");
		    return;
		}
		
		
	   // 데이터를 등록 처리해준다.
	   $("#excelFrm").ajaxSubmit({
			success: function(data){
				console.log(data);
				
				if(data.industry == "" && data.scale == "") {
					alert("정합성 검증에 성공하였습니다.");
					$("#addBts").show();					
				} else {
		        	$('div.excelUpValidResult').html( data );
				}
			},
			dataType: "html",
			url: excelValidUrl
	    });
	}
	
	function excelCancel(){
		var f= document.excelFrm;
		f.target = "_self";
		f.action = excelUploadListUrl;
		f.submit();
	}
</script>
<!-- content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">통계조사결과 일괄등록</h3>
		</div>
		<!--// main_title -->
		<jsp:include page="/WEB-INF/jsp/admin/integration/menuDescInclude.jsp"/>
		
	</div>	

	<form id="excelFrm" name="excelFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">
		<!-- table_area -->
		<div class="search_area">
			<table class="search_box">
				<caption>통계데이터 일괄등록 화면</caption>
				<colgroup>
					<col style="width: 150px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">기준 년도 선택<strong class="color_pointr">*</strong></th>
					<td >
						<label for="bs_yy" class="hidden">기준 년도 선택</label>
						<select class="in_wp120" id="bs_yy" name="bs_yy">
							<option value="" >전체선택</option>
							<c:forEach var="i" begin="2012" end="2017" >
							    <c:set var="yearOption" value="${2017-i+2012}" />
							    <option value="${yearOption}">${yearOption}(${yearOption-1})</option>
							</c:forEach>
						</select>
					</td>

				</tr>
				<tr>
					<th scope="row">통계데이터 선택<strong class="color_pointr">*</strong></th>
					<td>
						<label for="excel_file" class="hidden">파일 선택하기</label>
						<input id="excel_file" name="excel_file" type="file" class="in_wp400" onchange="javascript:validBtnChange('show')")/>
					</td>
				</tr>
				</tbody>
			</table>
			<div id="search_area_btnarea" class="search_area_btnarea">
				<a href="javascript:excelValid()" class="btn save" title="데이터 정합성 검증">
					<span>정합성 검증</span>
				</a>
			</div>
			
		</div>
	<!--// table_area -->		
	</form>
	<!-- information_area -->
	<div class="information_area">
		<section>
			<h5 class="infor_title">주의사항</h5>
			<ul class="information">
				<li>
					<span>1.  업로드시 반드시 엑셀 형식으로 저장해주십시오.</span>
				</li>
				<li>
					<span>2. 샘플 양식 폼을 변경할 시 등록이 불가능합니다. 주의하여 주십시오.</span>
				</li>
				<li>
					<span>3. 엑셀 버전은 2003이하의 버전을 사용하여 주십시오.(확장자 .xls 사용)</span>
				</li>
				<li>
					<span>4. 샘플파일의 필수항목 "*"은 꼭 입력하여 주십시오.</span>
				</li>
				<li>
					<span>5. 샘플파일을 참고하여 작성하여 주십시요. (<a href="/contents/template/template_excel_data.xlsx" title="샘플파일다운로드">샘플파일다운</a>)</span>
				</li>
			</ul>
		</section>
	</div>
	<br/>
	<div class="excelUpValidResult">
	
	</div>
	<!-- button_area -->
	<div id="addBts" class="button_area">
		<div class="alignc">
			<a href="javascript:excelUpload()" class="btn save" title="등록">
				<span>등록</span>
			</a>
			<a href="javascript:excelCancel()" class="btn cancel" title="취소">
				<span>취소</span>
			</a>
		</div>
	</div>
	<!--// button_area -->

	<!--// information_area -->
	<!-- table_area -->
		<!-- title_area -->
	<div class="excelUploadResult">
	
	</div>
			
</div>