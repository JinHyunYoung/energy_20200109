<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/js/jquery.sh-file-input-image.js"></script>

<script language="javascript">

var insertEducationApplyUrl = '<c:url value="/admin/education/insertEducationApply.do" />';
var updateEducationApplyUrl = '<c:url value="/admin/education/updateEducationApply.do" />';
var deleteEducationApplyUrl = '<c:url value="/admin/education/deleteEducationApply.do" />';

$( document ).ready( function(){

	$(".onlynum").keyup( setNumberOnly );

	$('#modal-juso-write').popup();
	
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

});

function educationApplyInsert(){
	
	if($( '#seq_id' ).val() == ""){
		alert( '교육회차를 선택해 주십시요. 진행중인 회차가 없을 시 교육신청을 할 수 없습니다.' );
		$( '#seq_id' ).focus();
		return;		
	}
	
	$("#email").val($("#email_1").val()+"@"+$("#email_2").val());
    if($("#email_1").val() == "" || $("#email_2").val() == ""){
 	   alert("email은 필수 입력사항입니다.");
	   $("#email_1").focus();
	   return;		   
    }else if(!isEmail($("#email").val())){
    	alert("Email 형식이 올바르지 않습니다.");
    	return;
    }
	
    if($("#zipcode").val() == "" || $("#address2").val() == ""){
	   alert("주소를 정확히 입력해 주십시요.");
	   $("#address").focus();
	   return;		   
    }
   
	if($("#mobile_2").val() == "" || $("#mobile_3").val() == ""){
		alert( '휴대폰은 필수 입력사항입니다' );
		$( '#mobile_2' ).focus();
		return;		
	} else {
		$("#handphone").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
	}
	
	if($("#tele_1").val() == "" || $("#tele_2").val() == "" || $("#tele_3").val() == ""){
		alert( '유선전화는 필수 입력사항입니다' );
		$( '#tele_1' ).focus();
		return;		
	} else {
		$("#telephone").val($("#tele_1").val()+"-"+$("#tele_2").val()+"-"+$("#tele_3").val());
	}

	if($( '#busi_nm' ).val() == ""){
		alert( '업체명은 필수 입력사항입니다' );
		$( '#busi_nm' ).focus();
		return;		
	}

    if($("#busi_no1").val() == "" || $("#busi_no2").val() == "" || $("#busi_no3").val() == ""){
 	   alert("사업자등록번호는 정확히 입력해 주십시요.");
 	   $("#busi_no1").focus();
 	   return;		   
     }else{
     	$("#busi_no").val($("#busi_no1").val()+"-"+$("#busi_no2").val()+"-"+$("#busi_no3").val());
     }
	
	if($( '#repre_nm' ).val() == ""){
		alert( '대표자명은 필수 입력사항입니다' );
		$( '#repre_nm' ).focus();
		return;		
	}
	
	if($( '#busi_reg_date' ).val() == ""){
		alert( '등록연월일은 필수 입력사항입니다' );
		$( '#busi_reg_date' ).focus();
		return;		
	}
    
    if($("#busi_tel1").val() == "" || $("#busi_tel2").val() == "" || $("#busi_tel3").val() == ""){
	   alert("업체전화번호를 정확히 입력해 주십시요.");
	   $("#busi_tel1").focus();
	   return;		   
    }else{
    	$("#busi_tel").val($("#busi_tel1").val()+"-"+$("#busi_tel2").val()+"-"+$("#busi_tel3").val());
    }
    
    if($("#fax1").val() == "" || $("#fax2").val() == "" || $("#fax3").val() == ""){
 	   alert("fax를 정확히 입력해 주십시요.");
 	   $("#fax1").focus();
 	   return;		   
     }else{
     	$("#fax").val($("#fax1").val()+"-"+$("#fax2").val()+"-"+$("#fax3").val());
     }
	
   if($("#busi_zipcode").val() == "" || $("#busi_address2").val() == ""){
	   alert("업체주소를 정확히 입력해 주십시요.");
	   $("#busi_address").focus();
	   return;		   
    }

    for(var i = 1; i <= 3; i++){
	   if ($("#uploadFile"+i).val() != "" && !$("#uploadFile"+i).val().toLowerCase().match(/\.(jpg|png|gif|ppt|pptx|xls|xlsx|doc|docx|hwp|txt|pdf|zip)$/)){
		   alert("확장자가 jpg,png,gif,ppt,pptx,xls,xlsx,doc,docx,hwp,txt,pdf,zip 파일만 업로드가 가능합니다.");
		   return;
	   }  
    }
    
   if ( $("#educationFrm").parsley().validate() ){
	    var url = insertEducationApplyUrl;
	    if($("#seq_id").val() != "" && $("#user_ci").val() != "") url = updateEducationApplyUrl;
	   
		// 데이터를 등록 처리해준다.
		$("#educationFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					educationApplyListPage();
				}	
			},
			dataType: "json",
			url: url
	    });	
   }	

}

function changeProtGb(){
	var protGb = $("#prot_gb").val();
	selectbox_deletealllist("prot_type");
	getCommonCodeList("SAFE_CD_"+protGb, "prot_type", "", "", "-선택-", true); 
}

function changeHeatType(){
	var heatType = $("#heat_type").val();
	if(heatType == "ETC") $("#heat_etc").show();
	else $("#heat_etc").hide();
}

var addrPos = 1;
function findAddress(idx){
	addrPos = idx;
	jusoPopupShow();
}

function setAddr(roadAddr,jibunAddr,zipNo,admCd){
   if(addrPos == 1){
		$("#zipcode").val(zipNo);
		$("#address").val(roadAddr);
		$("#address2").val("");
		$("#administ_cd").val(admCd);
		$("#address2").focus();
   }else{
		$("#busi_zipcode").val(zipNo);
		$("#busi_address").val(roadAddr);
		$("#busi_address2").val("");
		$("#busi_address2").focus();	   
   }	
}

function changeEduSeq(){
	var seqId = $("#seq_id").val();
	var userCi = $("#user_ci").val();
	
	if(seqId != ""){
	  $.ajax({
			type : "POST",
			url : "/web/education/educationApplyCheck.do",
			data : {
	        	seq_id : seqId,
	        	user_ci : userCi
			},
			success : function(data, dataType) {
				if (data != null && data.check_val > 0) {
					alert("이미 신청한 교육회차이므로 신청하실 수 없습니다.");
					return;
				}
			}
		});
	} 
}

function changeEmailDomain(){
	$("#email_2").val($("#email_domain").val());
}

function educationApplyListPage(){
	document.educationFrm.action = "<c:url value='/admin/education/educationApplyListPage.do'/>";
	document.educationFrm.submit();
}

function delFile(idx){
	if(idx == '1'){
		$("#picture").val("");
		$("#picFile").hide();
	}else if(idx == '2'){
		$("#busi_license").val("");
		$("#uploadedFile1").hide();
	}else if(idx == '3'){
		$("#unemp_ins_list").val("");
		$("#uploadedFile2").hide();
	}else if(idx == '4'){
		$("#etc_doc").val("");
		$("#uploadedFile3").hide();
	}
}

var approvalGb = '1';
function approvalEducationApply(gubun, state){
	 approvalGb = gubun;
	 if(state == "F"){
		 var title = "수강반려 사유";
		 $("#approval_fail_reason").show();
		 $("#pass_fail_reason").hide();
		 if(gubun == '2') {
			 $("#approval_fail_reason").hide();
			 $("#pass_fail_reason").show();
			 title = "합격반려 사유";
		 }
		 $("#evalFailTitle").html(title);
	
		 evalPopupShow();
	 }else updateEvalResult("P");
}

function updateEvalResult(state){
	var stateNm = "수강 승인";
	var failReason = "";
	var url = "/admin/education/approvalEducationApply.do";
    if(approvalGb == '1'){
	  if(state == "F"){ 
	    failReason = $("#approval_fail_reason").val();
	  	stateNm = "수강 반려";
	  }else{
		stateNm = "수강 승인";  
	  }
	}else{
	  url = "/admin/education/passEducationApply.do";
	  if(state == "F"){ 
		failReason = $("#pass_fail_reason").val();
	  	stateNm = "합격 반려";
	  }else{
		stateNm = "합격 승인";  
	  }
	}
     
  	var aplyRow = new Array();
 	var ret = null;
 	
	var tmp = {seq_id : $("#seq_id").val(), user_ci : $("#user_ci").val() };
	aplyRow.push(tmp);
 

    if(!confirm("선택한 대상자를 "+stateNm+" 처리하시겠습니까?")) return;
    	 
    $.ajax({
        url: url,
        dataType: "json",
        type: "post",
        data: {
           result : state,
  		   fail_reason : failReason,
  		   aply_list : JSON.stringify(aplyRow)
		},
        success: function(data) {
        	alert(data.message);
        	if(data.success == "true") document.location.reload();
        	evalPopupClose(); 
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
    	 
}

function educationApplyDelete(){
	
	if($("#apply_status").val() == "Y"){
		alert("수강승인자는 삭제할 수 없습니다."); 
		return;
	}
	
    if(!confirm("신청자를 삭제하시겠습니까?")) return;
	 
    $.ajax({
        url: deleteEducationApplyUrl,
        dataType: "json",
        type: "post",
        data: {
        	seq_id : $("#seq_id").val(), 
        	user_ci : $("#user_ci").val()
		},
        success: function(data) {
        	alert(data.message);
        	if(data.success == "true") educationApplyListPage()
        	  
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function evalPopupShow(){
	$('#modal-eval-write').modal('show');
}

function evalPopupClose(){
	$('#modal-eval-write').modal('hide');
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
	
<form id="educationFrm" name="educationFrm" method="post" enctype="multipart/form-data" data-parsley-validate="true" onSubmit="return false">
<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
<input type='hidden' id="mode" name='mode' value="${param.mode}" />
<input type='hidden' id="seq_id" name='seq_id' value="${param.seq_id}" />
<input type="hidden" id="user_ci" name="user_ci" value="${education.user_ci}" />
<input type="hidden" id="administ_cd" name="administ_cd" value="${education.administ_cd}" />
<input type="hidden" id="picture" name="picture" value="${education.picture}" />
<input type="hidden" id="busi_license" name="busi_license" value="${education.busi_license}" />
<input type="hidden" id="unemp_ins_list" name="unemp_ins_list" value="${education.unemp_ins_list}" />
<input type="hidden" id="etc_doc" name="etc_doc" value="${education.etc_doc}" />
<input type="hidden" id="email" name="email" value="${education.email}" />
<input type="hidden" id="handphone" name="handphone" value="${education.handphone}" />
<input type="hidden" id="telephone" name="telephone" value="${education.telephone}" />
<input type="hidden" id="busi_no" name="busi_no" value="${education.busi_no}" />
<input type="hidden" id="busi_tel" name="busi_tel" value="${education.busi_tel}" />
<input type="hidden" id="fax" name="fax" value="${education.fax}" />
<input type="hidden" id="apply_status" name="apply_status" value="${education.apply_status}" />

	<!--table_area-->
	<div class="table_area">
		<table class="write">
			<caption>수강신청 및 합격관리 수정</caption>
			<colgroup>
				<col style="width:60px;">
				<col style="width:120px;">
				<col style="width:*;">
			</colgroup>
			<tbody>
				<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
					<th scope="row" colspan="2">약관 동의여부</th>
					<td>
						<label for="table_label01_01">동의</label>
						<input id="table_label01_01" type="radio" checked="checked" name="table_label01" class="marginr5" disabled />
						<label for="table_label01_02">동의하지 않음</label>
						<input id="table_label01_02" type="radio" name="table_label01" disabled />
						<span class="padl5">( 동의일 : ${education.reg_date} )</span>
					</td>
				</tr>
				<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
					<th scope="row" colspan="2">신청일시</th>
					<td>${education.reg_date}</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">
						<strong class="color_pointr">*</strong>
						<label for="table_label03">교육구분</label>
					</th>
					<td>
						<g:select id="edu_gb" name="edu_gb" codeGroup="EDU_GUBUN" cls="in_wp130" selected="${education.edu_gb}" />
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">
						<strong class="color_pointr">*</strong>
						<label for="user_nm">성명</label>
					</th>
					<td><input type="text" name="user_nm" class="in_w100" id="user_nm" value="${education.user_nm}" data-parsley-required="true" data-parsley-maxlength="30" ></td>
				</tr>
				<tr>
					<th colspan="2" scope="row">
						<strong class="color_pointr">*</strong>생년월일(성별)
					</th>
					<td>
						<input id="birth" name="birth" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="${education.birth}" readonly />
						(
						<input type="radio" name="gender" id="gender_1" value="1" <c:if test="${education.gender == '1'}">checked</c:if>>
						<label for="gender_1" class="marginr5">남</label>
						<input type="radio" name="gender" id="gender_2" value="0" <c:if test="${education.gender == '0'}">checked</c:if>>
						<label for="gender_2" class="marginr5">여</label>
						)
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">휴대전화</th>
					<td>
						<select name="mobile_1" id="mobile_1" class="in_wp60">
							<option value='010' <c:if test="${education.mobile_1 == '010'}">checked</c:if>>010</option>
							<option value='011' <c:if test="${education.mobile_1 == '011'}">checked</c:if>>011</option>
							<option value='016' <c:if test="${education.mobile_1 == '016'}">checked</c:if>>016</option>
							<option value='017' <c:if test="${education.mobile_1 == '017'}">checked</c:if>>017</option>
							<option value='018' <c:if test="${education.mobile_1 == '018'}">checked</c:if>>018</option>
							<option value='019' <c:if test="${education.mobile_1 == '019'}">checked</c:if>>019</option>
						</select>
						<label for="mobile_1" class="hidden">휴대폰 첫번째 자리</label>
						-
						<input type="text" name="mobile_2" class="in_wp70 onlynum" id="mobile_2" maxlength="4" value="${education.mobile_2}">
						<label for="mobile_2" class="hidden">휴대폰 가운데 자리</label>
						-
						<input type="text" name="mobile_3" class="in_wp70 onlynum" id="mobile_3" maxlength="4" value="${education.mobile_3}">
						<label for="mobile_3" class="hidden">휴대폰 마지막 자리</label>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">유선전화</th>
					<td>
						<input type="text" name="tele_1" class="in_wp70 onlynum" id="tele_1" maxlength="4" value="${education.tele_1}">
						<label for="tele_1" class="hidden">유선전화 첫번째 자리</label>
						-
						<input type="text" name="tele_2" class="in_wp70 onlynum" id="tele_2" maxlength="4" value="${education.tele_2}">
						<label for="tele_2" class="hidden">유선전화 가운데 자리</label>
						-
						<input type="text" name="tele_3" class="in_wp70 onlynum" id="tele_3" maxlength="4" value="${education.tele_3}">
						<label for="tele_3" class="hidden">유선전화 마지막 자리</label>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">이메일</th>
					<td>
						<label for="email_1" class="hidden">이메일 앞 주소 직접입력</label>
						<input type="text" name="email_1" class="in_wp100" id="email_1" value="${education.email_1}" data-parsley-required="true" data-parsley-maxlength="30"/>
						@
						<label for="email_2" class="hidden">이메일 뒷정보</label>
						<input type="text" name="email_2" class="in_wp100" id="email_2" value="${education.email_2}" data-parsley-required="true" data-parsley-maxlength="50"/>
						<label for="mail_select" class="hidden">이메일 뒷자리 선택</label>
						<select class="in_wp100 m_mb10 m_w100" id="email_domain" title="이메일주소선택" name="email_domain" onChange="changeEmailDomain()">
	                        <option value="self">직접입력</option>
							<option value="hanmail.net">한메일</option>
							<option value="naver.com">네이버</option>
							<option value="nate.com">네이트</option>
							<option value="gmail.com">구글</option>
							<option value="yahoo.co.kr">야후</option>
							<option value="lycos.co.kr">라이코스</option>
							<option value="chollian.net">천리안</option>
							<option value="empal.com">엠팔</option>
							<option value="hotmail.com">핫메일</option>
							<option value="dreamwiz.com">드림위즈</option>
							<option value="paran.com">파란</option>
						</select>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">주소</th>
					<td>
						<input type="text" name="zipcode" class="in_wp100" id="zipcode" value="${education.zipcode}" readOnly>
						<label for="zipcode" class="hidden">우편번호 </label>
						<button type="button" class="btn look" title="주소찾기" onClick="findAddress(1)"><span>주소찾기</span></button>
						<input type="text" name="address" class="in_w100 margint5" placeholder="기본주소" id="address"  value="${education.address}" readOnly>
						<label for="addr1" class="hidden">기본주소</label>
						<input type="text" name="address2" class="in_w100 margint5" placeholder="상세주소" id="address2"  value="${education.address2}" data-parsley-required="true" data-parsley-maxlength="200" >
						<label for="addr2" class="hidden">상세주소</label>
					</td>
				</tr>
				<tr>
					<th colspan="2" scope="row">사진</th>
					<td>
					  <c:if test="${param.mode == 'E' && !empty education.picture}">
                      <p id="picFile"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${education.picture}" >${education.picture_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile(1)"></a></p>
                      </c:if> 
                      <input class="in_w100" type="file" id="picFile" name="picFile" value="" />

					</td>
				</tr>
				<tr>
					<th rowspan="9" scope="col">소속<br/>업체<br/>정보</th>
					<th scope="row" class="borderl">
						<label for="table_label11">사업자구분</label>
					</th>
					<td>
						<g:radio id="license_gb" name="license_gb" codeGroup="LICENSE_GUBUN" curValue="${education.license_gb}" />
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">
						<strong class="color_pointr">*</strong>
						<label for="table_label12">업체명(상호)</label>
					</th>
					<td>
						<input type="text" name="busi_nm" class="in_w100" id="busi_nm" value="${education.busi_nm}" data-parsley-required="true" data-parsley-maxlength="100">
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">사업자등록번호</th>
					<td>
						<input type="text" name="busi_no1" class="in_wp70 onlynum" id="busi_no1" maxlength="3" value="${education.busi_no1}">
						<label for="busi_no1" class="hidden">사업자등록번호 첫번째 자리</label>
						-
						<input type="text" name="busi_no2" class="in_wp70 onlynum" id="busi_no2" maxlength="2" value="${education.busi_no2}">
						<label for="busi_no2" class="hidden">사업자등록번호 가운데 자리</label>
						-
						<input type="text" name="busi_no3" class="in_wp70 onlynum" id="busi_no3" maxlength="5" value="${education.busi_no3}">
						<label for="busi_no3" class="hidden">사업자등록번호 마지막 자리</label>
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row"><label for="repre_nm">대표자명</label></th>
					<td>
						<input type="text" name="repre_nm" class="in_w100" id="repre_nm" value="${education.repre_nm}" data-parsley-required="true" data-parsley-maxlength="40">
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row"><label for="busi_field">등록업종</label></th>
					<td>
						<input type="text" name="busi_field" class="in_w100" id="busi_field" value="${education.busi_field}" data-parsley-maxlength="50">
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row"><label for="busi_reg_date">등록연월일</label></th>
					<td>
						<input id="busi_reg_date" name="busi_reg_date" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="${education.busi_reg_date}" readonly />
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">전화번호</th>
					<td>
						<input type="text" name="busi_tel1" class="in_wp70 onlynum" id="busi_tel1" value="${education.busi_tel1}" maxlength="3" data-parsley-required="true" >
						<label for="busi_tel1" class="hidden">전화번호 천번째 자리</label>
						-
						<input type="text" name="busi_tel2" class="in_wp70 onlynum" id="busi_tel2" value="${education.busi_tel2}" maxlength="4" data-parsley-required="true" >
						<label for="busi_tel2" class="hidden">전화번호 가운데 자리</label>
						-
						<input type="text" name="busi_tel3" class="in_wp70 onlynum" id="busi_tel3" value="${education.busi_tel3}" maxlength="4" data-parsley-required="true" >
						<label for="busi_tel3" class="hidden">전화번호 마지막 자리</label>
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">팩스</th>
					<td>
						<input type="text" name="fax1" class="in_wp70 onlynum" id="fax1" value="${education.fax1}" maxlength="3" data-parsley-required="true" >
						<label for="fax1" class="hidden">fax 천번째 자리</label>
						-
						<input type="text" name="fax2" class="in_wp70 onlynum" id="fax2" value="${education.fax2}" maxlength="4" data-parsley-required="true" >
						<label for="fax2" class="hidden">fax 가운데 자리</label>
						-
						<input type="text" name="fax3" class="in_wp70 onlynum" id="fax3" value="${education.fax3}" maxlength="4" data-parsley-required="true" >
						<label for="fax3" class="hidden">fax 마지막 자리</label>
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">주소</th>
					<td>
						<input type="text" name="busi_zipcode" class="in_wp100" id="busi_zipcode" value="${education.busi_zipcode}" readOnly>
						<label for="busi_zipcode" class="hidden">우편번호 </label>
						<button type="button" class="btn look" title="주소찾기" onClick="findAddress(2)"><span>주소찾기</span></button>
						<input type="text" name="busi_address" class="in_w100 margint5" value="${education.busi_address}" placeholder="기본주소" id="busi_address" readOnly>
						<label for="busi_address" class="hidden">기본주소</label>
						<input type="text" name="busi_address2" class="in_w100 margint5" value="${education.busi_address2}" placeholder="상세주소" id="busi_address2" data-parsley-maxlength="200">
						<label for="busi_address2" class="hidden">상세주소</label>
					</td>
				</tr>
				<tr>
					<th rowspan="3" scope="row">증빙<br/>서류</th>
					<th class="borderl">사업자등록증</th>
					<td>
						 <c:if test="${param.mode == 'E' && !empty education.busi_license}">
	                      <p id="uploadedFile1"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${education.busi_license}" >${education.busi_license_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('2')"></a></p>
	                     </c:if> 
	                     <input class="in_w100" type="file" id="uploadFile1" name="uploadFile1" value="" />
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">고용보험목록</th>
					<td>
						 <c:if test="${param.mode == 'E' && !empty education.unemp_ins_list}">
	                      <p id="uploadedFile2"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${education.unemp_ins_list}" >${education.unemp_ins_list_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('3')"></a></p>
	                     </c:if> 
	                     <input class="in_w100" type="file" id="uploadFile2" name="uploadFile2" value="" />
					</td>
				</tr>
				<tr>
					<th class="borderl" scope="row">기타서류</th>
					<td>
						 <c:if test="${param.mode == 'E' && !empty education.etc_doc}">
	                      <p id="uploadedFile3"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${education.etc_doc}" >${education.etc_doc_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile('4')"></a></p>
	                     </c:if> 
	                     <input class="in_w100" type="file" id="uploadFile3" name="uploadFile3" value="" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="title_area">
		<h4 class="title">수강 및 합격처리</h4>
	</div>
	
	<div class="table_area">
		<table class="write">
			<caption>수강 및 합격처리 수정</caption>
			<colgroup>
				<col style="width:180px;">
				<col style="width:*;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">수강상태</th>
					<td>${education.apply_status_nm}</td>
				</tr>
				<tr>
					<th scope="row">승인처리일</th>
					<td>${education.apply_proc_date}</td>
				</tr>
				<tr>
					<th scope="row">합격상태</th>
					<td>${education.pass_status_nm}</td>
				</tr>
				<tr>
					<th scope="row">합격처리일</th>
					<td>${education.pass_proc_date}</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="memo">관리자 메모</label>
					</th>
					<td>
						<textarea id="memo" name="memo" cols="5" rows="5" class="in_w100" data-parsley-maxlength="2000">${education.memo}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- button_area -->
	<div class="button_area">
		<div class="float_left">
			<button type="button" class="btn save" title="수강승인" onClick="approvalEducationApply('1','P')">
				<span>수강승인</span>
			</button>
			<button type="button" class="btn cancel" title="수강반려" onClick="approvalEducationApply('1','F')">
				<span>수강반려</span>
			</button>
			<button type="button" class="btn save" title="합격" onClick="approvalEducationApply('2','P')">
				<span>합격</span>
			</button>
			<button type="button" class="btn cancel" title="불합격" onClick="approvalEducationApply('2', 'F')">
				<span>불합격</span>
			</button>
		</div>
		<div class="float_right">
			<button type="button" class="btn save" title="저장" onClick="educationApplyInsert()" style="display:<c:if test="${education.edu_stat == 'F'}">none</c:if>">
				<span>저장</span>
			</button>
			<button type="button" class="btn save" title="삭제" onClick="educationApplyDelete()" style="display:<c:if test="${education.edu_stat == 'F'}">none</c:if>">
				<span>삭제</span>
			</button>			
			<button type="button" class="btn list" title="목록" onClick="educationApplyListPage()">
				<span>목록</span>
			</button>
		</div>
	</div>
</form>
</div>

<jsp:include page="/WEB-INF/jsp/common/jusoSearchPopup.jsp"/>
     <div class="modal fade" id="modal-eval-write" >
		<div class="modal-dialog modal-size-small">
			<!-- header -->
			<div id="pop_header">
			<header>
				<h1 class="pop_title" id="evalFailTitle" >Fail 사유</h1>
				<a href="javascript:evalPopupClose()" class="pop_close" title="페이지 닫기">
					<span>닫기</span>
				</a>
			</header>
			</div>
			<!-- //header -->
			<!-- container -->
			<div id="pop_container">
			<article>
				<div class="pop_content_area">
				    <div  id="eval_pop_content" >
	<form id="evalFrm" name="evalFrm" method="post" data-parsley-validate="true">
					<!-- write_basic -->
					<div class="table_area">
						<table class="write">
							<caption>Fail 사유 등록화면</caption>
							<colgroup>
								<col style="width: 120px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">사유</th>
								<td>
								    <g:select id="approval_fail_reason" name="approval_fail_reason"  codeGroup="APPROVAL_REJECT_REASON" cls="in_wp300" style="display:none" />
								    <g:select id="pass_fail_reason" name="pass_fail_reason"  codeGroup="PASS_REJECT_REASON" cls="in_wp300" style="display:none" />
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
		                  	<a href="javascript:updateEvalResult('F')" class="btn save" title="저장">
								<span>저장</span>
							</a>
						</div>
					</footer>
					</div>
					<!-- //footer -->
</form>
				    </div>
				</div>
			</article>	
			</div>
			<!-- //container -->			
		</div>
	</div>