<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/js/directory.js"></script>
	
<script language="javascript">

$( document ).ready( function(){
	
});	

//기업디렉토리 중복확인
function checkCmpyDir(){

	if ( $("#cmpyDirMake1Form").parsley().validate() ){
		
		if(!(($("#biz_reg_no_1").val() != "" && $("#biz_reg_no_2").val() != "" && $("#biz_reg_no_3").val() != "") || 
			($("#biz_reg_no_1").val() == "" && $("#biz_reg_no_2").val() == "" && $("#biz_reg_no_3").val() == ""))){
		    
			alert("사업자등록번호를 정확히 입력해주십시요");
			$("#biz_reg_no_1").focus();
			return;
		}
		
		$("#biz_reg_no").val($("#biz_reg_no_1").val() + "-" + $("#biz_reg_no_2").val() + "-" + $("#biz_reg_no_3").val());
			
		 $.ajax({
		     url: "/web/directory/checkCmpyDir.do",
			 data :jQuery("#cmpyDirMake1Form").serialize(),
		     dataType: "json",
		     type: "post",
		     async : false,
		     success: function(data) {	    
		    	 
		    	 if(data.result == 'none'){
		    		 
		    		 var str = "";
		    		 str += "신규로 기업디렉토리를 만들 수 있습니다.\n\n";
		    		 str += "기업디렉토리를 신청하시겠습니까?";
		    		 
		    		 if (confirm(str)){
		    			 goCmpyDirMake2();
		    		 } 
		    	 } 
		    	 
		    	 else if(data.cmpyDir.app_stt_cd == '1'){
		    		 alert("이미 신청된 기업이며, 현재 승인대기 상태입니다..");
		    	 }
		    	 
		    	 else if(data.cmpyDir.app_stt_cd == '2'){
		    		 alert("기업디렉토리가 생성되어 있습니다.");
		    	 }
		    	 
		    	 else if(data.cmpyDir.app_stt_cd == '3'){
		    		 
		    		 $("#dir_sn").val(data.cmpyDir.dir_sn);
		    		 
		    		 var str = data.cmpyDir.cmpy_nm;
		    		 str += "님은 기업디렉토리 신청이 반려되었습니다.\n\n";
		    		 str += "반려사유 : " + data.cmpyDir.rjt_rsn + "\n\n";
		    		 str += "기업디렉토리를 새로 신청하시겠습니까?";
		    		 	    		 
		    		 if (confirm(str)){
		    			 goCmpyDirMake2();
		    		 } 
		    	}	    	 
		     },
		     error: function(e) {
		    	 alert( '데이터를 가져오는데 실패했습니다.' );
		     }
		});	
	}
}


//기업디렉토리 만들기 2 로 이동
function goCmpyDirMake2(){
    
    var f = document.cmpyDirMake1Form;
   
    f.target = "_self";
    f.action = "/web/directory/cmpyDirMake2.do";
    f.submit();
	
}

</script>

<!-- step_area -->
<div class="step_area">
	<ul class="step_list">
		<li class="active" title="1. 기업 디렉토리 중복확인">
			<strong>1. 기업 디렉토리 중복확인</strong>
		</li>
		<li title="2. 기업정보 입력">2</li>
		<li title="3. 기업 디렉토리 신청완료">3</li>
	</ul>
</div>
<!--// step_area -->


<form id="cmpyDirMake1Form" name="cmpyDirMake1Form" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' /> 
	<input type='hidden' id="biz_reg_no" name='biz_reg_no' />
	<input type='hidden' id="inds_tp_cd" name='inds_tp_cd' value="${ inds_tp_cd }" /> 

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
					<input id="cmpy_nm" name="cmpy_nm" type="text" class="in_w50" data-parsley-maxlength="300" data-parsley-required="true" />
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
					<input id="ceo_nm" name="ceo_nm" type="text" class="in_w50" data-parsley-maxlength="300" data-parsley-required="true" />
				</td>
			</tr>
			</tbody>
			
		</table>
	</div>
	<!--// table_area -->
	
	<!-- button_area -->
	<div class="button_area">
		<div class="alignc">
			<button class="btn save" title="확인" onclick="javascript:checkCmpyDir()">
				<span>확인</span>
			</button>
		</div>
	</div>
	<!--// button_area -->

</form>