<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/js/directory.js"></script>
	
<script language="javascript">

$( document ).ready( function(){
	
});	

//기업디렉토리 중복확인
function controlCmpyDir(){

	if ( $("#cmpyDirControlForm").parsley().validate() ){
		
		if(!(($("#biz_reg_no_1").val() != "" && $("#biz_reg_no_2").val() != "" && $("#biz_reg_no_3").val() != "") || 
			($("#biz_reg_no_1").val() == "" && $("#biz_reg_no_2").val() == "" && $("#biz_reg_no_3").val() == ""))){
		    
			alert("사업자등록번호를 정확히 입력해주십시요");
			$("#biz_reg_no_1").focus();
			return;
		}
		
		$("#biz_reg_no").val($("#biz_reg_no_1").val() + "-" + $("#biz_reg_no_2").val() + "-" + $("#biz_reg_no_3").val());
			
		 $.ajax({
		     url: "/web/directory/controlCmpyDir.do",
			 data :jQuery("#cmpyDirControlForm").serialize(),
		     dataType: "json",
		     type: "post",
		     async : false,
		     success: function(data) {	    
		    	 
		    	 if(data.result == 'none'){
		    		 alert("일치하는 기업 디렉토리가 없습니다.");
		    	 } 
		    	 
		    	 else if(data.result == 'auth_fail'){
		    		 alert("인증번호가 틀렸습니다.");
		    	 } 
		    	 
		    	 else {		   
		    		 
		    		 $("#dir_sn").val(data.cmpyDir.dir_sn);		
		    		 $("#cmpy_nm").val(data.cmpyDir.cmpy_nm);		
		    		 $("#app_stt_cd").val(data.cmpyDir.app_stt_cd);		
		    		 $("#rjt_rsn").val(data.cmpyDir.rjt_rsn);			
		    		 $("#myDirectory").val(data.myDirectory);		     		 
		    		 goCmpyDirApproval();
		    	 } 
		     },
		     error: function(e) {
		    	 alert( '데이터를 가져오는데 실패했습니다.' );
		     }
		});	
	}
}


//기업디렉토리 승인화면 로 이동
function goCmpyDirApproval(){
    
    var f = document.cmpyDirControlForm;
   
    f.target = "_self";
    f.action = "/web/directory/cmpyDirApproval.do";
    f.submit();
	
}

</script>

<form id="cmpyDirControlForm" name="cmpyDirControlForm" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' /> 
	<input type='hidden' id="app_stt_cd" name='app_stt_cd' /> 
	<input type='hidden' id="rjt_rsn" name='rjt_rsn' /> 
	<input type='hidden' id="myDirectory" name='myDirectory' /> 
	<input type='hidden' id="biz_reg_no" name='biz_reg_no' /> 

	<!-- table_area -->
	<div class="table_area">
	
		<table class="write">
		
			<caption>기업 디렉토리 중복확인 화면</caption>
			<colgroup>
				<col style="width: 200px;" />
				<col style="width: *;" />
			</colgroup>
			
			<tbody>
			<tr>
				<th scope="row">
					<label for="cmpy_nm">
						<strong class="color_pointr">*</strong> 기업명(국문)
					</label>
				</th>
				<td>
					<input id="cmpy_nm" name="cmpy_nm" type="text" class="in_w50" data-parsley-required="true" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<strong class="color_pointr">*</strong> 사업자번호
				</th>
				<td>
					<label for="biz_reg_no_1" class="hidden">사업자번호 첫번째 구간 입력</label>
					<input id="biz_reg_no_1" name="biz_reg_no_1" type="text" class="in_wp100" maxlength="3" data-parsley-errors-container='#errMsg' data-parsley-required="true"/>
					-
					<label for="biz_reg_no_2" class="hidden">사업자번호 두번째 구간 입력</label>
					<input id="biz_reg_no_2" name="biz_reg_no_2" type="text" class="in_wp80" maxlength="2" data-parsley-errors-container='#errMsg' data-parsley-required="true"/>
					-
					<label for="biz_reg_no_3" class="hidden">사업자번호 세번째 구간 입력</label>
					<input id="biz_reg_no_3" name="biz_reg_no_3" type="text" class="in_wp100" maxlength="5" data-parsley-errors-container='#errMsg' data-parsley-required="true"/>
					<div class="parsely-single-error" id="errMsg" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="ceo_nm">
						<strong class="color_pointr">*</strong> 대표자명(국문)
					</label>
				</th>
				<td>
					<input id="ceo_nm" name="ceo_nm" type="text" class="in_w50" data-parsley-required="true" />
				</td>
			</tr>
			<tr>
				<th scope="row">
					<label for="auth_no">
						<strong class="color_pointr">*</strong> 인증번호
					</label>
				</th>
				<td>
					<input id="auth_no" name="auth_no" type="text" class="in_w50" data-parsley-required="true" />
				</td>
			</tr>
			</tbody>
			
		</table>
	</div>
	<!--// table_area -->
	
	<!-- button_area -->
	<div class="button_area">
		<div class="alignc">
			<button class="btn save" title="확인" onclick="javascript:controlCmpyDir()">
				<span>확인</span>
			</button>
		</div>
	</div>
	<!--// button_area -->

</form>