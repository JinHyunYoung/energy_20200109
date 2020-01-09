<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/js/jquery.sh-file-input-image.js"></script>

<script language="javascript">

var insertSupportreqUrl = '<c:url value="/web/education/insertEducationApply.do" />';

$( document ).ready( function(){
	
	if("${education.user_ci}" == ""){
		alert("잘못된 경로로 접근을 하였습니다.");
		document.location ="/web/education/educationApplyInfo.do";
	}
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
	
	var param = {};
	getCodeList("/web/education/eduseqCodeList.do", param, "seq_id", "", "", "","Y");
	
	$("#uploadFile1").shFileInputImage({
		image:"/images/common/btn_file.gif",
		filepath : true,
		filepath_selector: "#uploadFile1_path"
	});

	$("#uploadFile2").shFileInputImage({
		image:"/images/common/btn_file.gif",
		filepath : true,
		filepath_selector: "#uploadFile2_path"
	});

	$("#uploadFile3").shFileInputImage({
		image:"/images/common/btn_file.gif",
		filepath : true,
		filepath_selector: "#uploadFile3_path"
	});

	$('#pic_btn').click(function(e){
		e.preventDefault();             
		$("#picFile").click();               
		var ext = $("#picFile").val().split(".").pop().toLowerCase();
		if(ext.length > 0){
			if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) { 
				alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
				return false;  
			}                  
		}
		$("#picFile").val().toLowerCase();
	});  
	
});

function educationApplyInsert(){
	
	if( ! $( '#agree1-1' ).get(0).checked ){
		alert( '개인정보 수집 및 이용에 동의해 주셔야 합니다.' );
		$( '#agree1-1' ).focus();
		return;		
	}

	if( ! $( '#agree2-1' ).get(0).checked ){
		alert( '개인정보의 제3자 제공에 관한 사항에 동의해 주셔야 합니다.' );
		$( '#agree2-1' ).focus();
		return;		
	}

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
	
    if($("#busi_no1").val() == "" || $("#busi_no2").val() == "" || $("#busi_no3").val() == ""){
 	   alert("사업자등록번호를 정확히 입력해 주십시요.");
 	   $("#busi_no").focus();
 	   return;		   
     }else{
     	$("#busi_no").val($("#busi_no1").val()+"-"+$("#busi_no2").val()+"-"+$("#busi_no3").val());
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
		// 데이터를 등록 처리해준다.
		$("#educationFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					document.educationFrm.action = "<c:url value='/web/education/educationApplyComplete.do'/>";
					document.educationFrm.submit();
				}	
			},
			dataType: "json",
			url: insertSupportreqUrl
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

function showMyImage(fileInput) {
    var files = fileInput.files;
    for (var i = 0; i < files.length; i++) {           
        var file = files[i];
        var imageType = /image.*/;     
        if (!file.type.match(imageType)) {
            continue;
        }           
        var img=document.getElementById("thumbnil");            
        img.file = file;    
        var reader = new FileReader();
        reader.onload = (function(aImg) { 
            return function(e) { 
                aImg.src = e.target.result; 
            }; 
        })(img);
        reader.readAsDataURL(file);
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

function educationApplyCancel(){
	document.location = "/web/education/educationApplyCerti.do";
}

</script>

<form id="educationFrm" name="educationFrm" method="post" enctype="multipart/form-data" data-parsley-validate="true" onSubmit="return false">
<input type="hidden" id="user_ci" name="user_ci" value="${education.user_ci}" />
<input type="hidden" id="administ_cd" name="administ_cd" value="" />
<input type="hidden" id="picture" name="picture" value="" />
<input type="hidden" id="email" name="email" value="" />
<input type="hidden" id="handphone" name="handphone" value="" />
<input type="hidden" id="telephone" name="telephone" value="" />
<input type="hidden" id="busi_no" name="busi_no" value="" />
<input type="hidden" id="busi_tel" name="busi_tel" value="" />
<input type="hidden" id="fax" name="fax" value="" />

			<center class="con_img2"><img src="../../../images/sub/imp/imp-03-02.png" alt="약관동의 및 신청서 작성"></center>

							
							<div class="alert_txt bold margint40">개인정보 수집 및 이용에 대한 동의</div>
							<div class="border_div2 margint10">
								[ 개인정보의 수집 · 이용 목적 ]<BR />
								주택에너지진단사 양성과정 및 자격검정시험의 신규·재교육·재시험의 신청 접수 및 시험 실시시 본인확인, 자격 취득자에 대한 
								보수교육 및 주택에너지진단 관련 활동에 대한 관리<BR /><BR />

								[ 수집하려는 개인정보 항목 ]<BR />
								가. 교육 신청자 본인의 성명<BR />
								나. 생년월일<BR />
								다. 사진<BR />
								라. 전화번호(휴대폰, 유선전화)<BR />
								마. 주소(주민등록거주지, 실제 거주지)<BR />
								바. 이메일 주소<BR /><BR />

								[ 개인정보 보유 및 이용기간 : 접수 년도 후 5년간 보유 ]<BR />
								* 동의를 거부할 권리가 있으나, 거부시 주택에너지진단사 양성과정 및 자격검정시험의 신규ㆍ재교육ㆍ재시험의 신청 접수 및 
								시험 응시가 제한됨
							</div>
			
							<div class="alignr margint10">
								<input type="radio" name="agree1" id="agree1-1"> <label for="agree1-1">동의함</label>　
								<input type="radio" name="agree1" id="agree1-2" checked> <label for="agree1-2">동의하지 않음</label>	
							</div>
														
							<div class="alert_txt bold margint40">개인정보의 제3자 제공에 관한 사항 동의</div>
							<div class="border_div2 margint10">
- 제공 받는자 : 한국에너지기술연구원(주관기관), 한국주택에너지진단사협회(협력기관)<BR />
- 제공 목적 : 주택에너지진단사 양성과정 및 자격검정시험의 신규·재교육·재시험의 시험 실시, 시험결과의 채점 및 합격여부 판정·통보시 본인 확인, 자격 취득자에 대한 보수교육 및 주택에너지진단 관련 활동에 대한 관리
- 제공 항목 : 교육신청자 본인의 성명, 생년월일, 사진, 전화번호(휴대폰, 유선전화), 주소(주민등록거주지, 실제거주지), 이메일주소<BR />
- 제공 및 이용기간 : 접수 년도 후 5년간 보유<BR />
* 동의를 거부할 권리가 있으나, 거부시 주택에너지진단사 양성과정 및 자격검정시험의 신규·교육·재시험의 신청 접수 및 시험응시가 제한됨

							</div>

							<div class="alignr margint10">
								<input type="radio" name="agree2" id="agree2-1"> <label for="agree2-1">동의함</label>　
								<input type="radio" name="agree2" id="agree2-2" checked> <label for="agree2-2">동의하지 않음</label>	
							</div>
	
							<div class="alert_txt bold margint40">
								<label for="input1">교육회차 선택</label>　

								<select name="seq_id" id="seq_id" class="in_wp300" onChange="changeEduSeq()">
									<option value="" selected>선택</option>
								</select>

							</div>

							<div class="table_area_02 margint10">
								<table>
									<caption>교육회차 선택</caption>
		<colgroup>
			<col style="width: 15%">
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
		</colgroup>
		<tbody>
			<tr>
				<td class="title_td alignc" rowspan="2">교육구분<span class="color_cd5500">*</span></td>
				<td rowspan="2" style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb1" value="A" checked> <label for="edu_gb1">신규</label>　</td>
				<td class="title_td alignc" colspan="3">재교육</td>
				<td class="title_td alignc" colspan="3">재시험</td>
			</tr>
			<tr>
				<td style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb2" value="B"> <label for="edu_gb2">필기</label></td>
				<td style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb3" value="C"> <label for="edu_gb3">실기</label></td>
				<td style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb4" value="D"> <label for="edu_gb4">필기 / 실기</label></td>
				<td style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb5" value="E"> <label for="edu_gb5">필기</label></td>
				<td style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb6" value="F"> <label for="edu_gb6">실기</label></td>
				<td style="text-align:center"><input type="radio" name="edu_gb" id="edu_gb7" value="G"> <label for="edu_gb7">필기 / 실기</label></td>
			</tr>

		</tbody>
	</table>
</div>	

<div class="alert_txt bold margint40">기본정보</div>
<div class="alert_txt2 alignr margint20">* 필수 입력항목</div>

<div class="table_area_02 margint10">
	<table>
		<caption>기본정보</caption>
		<colgroup>
			<col style="width: 15%">
			<col style="width: 15%">
			<col>
			<col style="width: 15%">
			<col>
			<col>
		</colgroup>
		<tbody>
			<tr>
				<td rowspan="5" class="alignc">
					사진 * <BR /> (3X4) <BR /> <BR />
					<img id="thumbnil" style="width:100px;height:100px;"  src="" /> 
					<input type="file" id="picFile" name="picFile" accept="image/*"  onchange="showMyImage(this)" style="width:0px;height:0px;"/>
					<a href="#none" id="pic_btn" title="사진 찾아보기" class="input_bt" target="_self">사진 찾아보기</a>
				</td>
				<td class="title_td"><label for="user_nm">성명 <span class="color_cd5500">*</span></label></td>
				<td><input type="text" name="user_nm" class="in_w100" id="user_nm" value="${education.user_nm}" readOnly></td>
			</tr>
			<tr>
				<td class="title_td"><label for="email_1">e-mail <span class="color_cd5500">*</span></label></td>
				<td colspan="3">
				     <label for="email_1" class="hidden">이메일 앞 주소 직접입력</label>
					<input type="text" name="email_1" class="in_wp100" id="email_1" data-parsley-required="true" data-parsley-maxlength="30"/>
					@
					<input type="text" name="email_2" class="in_wp100" id="email_2" data-parsley-required="true" data-parsley-maxlength="50"/>
					<label for="email_2" class="hidden">이메일 뒷정보</label>
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
				<td class="title_td"><label for="birth">생년월일 / 성별 <span class="color_cd5500">*</span></label></td>
				<td colspan="3">
					<input id="birth" name="birth" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="${education.birth}" readonly />
					<input type="radio" name="gender" id="gender_1" value="1" <c:if test="${education.gender == '1'}">checked</c:if>> <label for="gender_1">남</label>　
					<input type="radio" name="gender" id="gender_2" value="0" <c:if test="${education.gender == '0'}">checked</c:if>> <label for="gender_2">여</label>	
				</td>
			</tr>

			<tr>
				<td class="title_td">주소 <span class="color_cd5500">*</span></td>
				<td colspan="3">
						<input type="text" name="zipcode" class="in_wp100" id="zipcode" readOnly>
						<label for="zipcode" class="hidden">우편번호 </label>
						<a href="javascript:findAddress(1);" title="주소찾기" class="input_bt" target="_self">주소찾기</a>
						<input type="text" name="address" class="in_w100 margint5" placeholder="기본주소" id="address" readOnly>
						<label for="addr1" class="hidden">기본주소</label>
						<input type="text" name="address2" class="in_w100 margint5" placeholder="상세주소" id="address2" data-parsley-required="true" data-parsley-maxlength="200" >
						<label for="addr2" class="hidden">상세주소</label>
				</td>
			</tr>

			<tr>
				<td class="title_td">전화번호 <span class="color_cd5500">*</span></td>
				<td colspan="3">
					휴대폰 <span class="color_cd5500">*</span>
						<select name="mobile_1" id="mobile_1" class="in_wp60">
							<option value='010'>010</option>
							<option value='011'>011</option>
							<option value='016'>016</option>
							<option value='017'>017</option>
							<option value='018'>018</option>
							<option value='019'>019</option>
						</select>
						<label for="mobile_1" class="hidden">휴대폰 첫번째 자리</label>
						-
						<input type="text" name="mobile_2" class="in_wp70 onlynum" id="mobile_2" maxlength="4">
						<label for="mobile_2" class="hidden">휴대폰 가운데 자리</label>
						-
						<input type="text" name="mobile_3" class="in_wp70 onlynum" id="mobile_3" maxlength="4">
						<label for="mobile_3" class="hidden">휴대폰 마지막 자리</label>
					<div style="margin-top:5px;">
					유선전화 <span class="color_cd5500">*</span>
						<input type="text" name="tele_1" class="in_wp70 onlynum" id="tele_1" maxlength="4">
						<label for="tele_1" class="hidden">유선전화 첫번째 자리</label>
						-
						<input type="text" name="tele_2" class="in_wp70 onlynum" id="tele_2" maxlength="4">
						<label for="tele_2" class="hidden">유선전화 가운데 자리</label>
						-
						<input type="text" name="tele_3" class="in_wp70 onlynum" id="tele_3" maxlength="4">
						<label for="tele_3" class="hidden">유선전화 마지막 자리</label>
					</div>	
				</td>
			</tr>

		</tbody>
	</table>
</div>	


<div class="alert_txt bold margint40">소속업체 정보</div>

<div class="table_area_02 margint10">
	<table>
		<caption>소속업체 정보</caption>
		<colgroup>
			<col style="width: 15%">
			<col>
			<col style="width: 15%">
			<col>
			<col>
		</colgroup>
		<tbody>

			<tr>
				<td class="title_td">사업자구분 <span class="color_cd5500">*</span></td>
				<td colspan="3">
					<g:radio id="license_gb" name="license_gb" codeGroup="LICENSE_GUBUN" curValue="A"  />
				</td>
			</tr>

			<tr>
				<td class="title_td"><label for="busi_nm">업체명(상호) <span class="color_cd5500">*</span></label></td>
				<td colspan="3">
					<input type="text" name="busi_nm" class="in_w100" id="busi_nm" data-parsley-required="true" data-parsley-maxlength="100">
				</td>
			</tr>

			<tr>
				<td class="title_td"><label for="busi_no">사업자등록번호 <span class="color_cd5500">*</span></label></td>
				<td>
					<input type="text" name="busi_no1" class="in_wp70 onlynum" id="busi_no1" maxlength="3" value="">
					<label for="busi_no1" class="hidden">사업자등록번호 첫번째 자리</label>
					-
					<input type="text" name="busi_no2" class="in_wp70 onlynum" id="busi_no2" maxlength="2" value="">
					<label for="busi_no2" class="hidden">사업자등록번호 가운데 자리</label>
					-
					<input type="text" name="busi_no3" class="in_wp70 onlynum" id="busi_no3" maxlength="5" value="">
					<label for="busi_no3" class="hidden">사업자등록번호 마지막 자리</label>
				</td>
				<td class="title_td"><label for="repre_nm">대표자명 <span class="color_cd5500">*</span></label></td>
				<td><input type="text" name="repre_nm" class="in_w100" id="repre_nm" data-parsley-required="true" data-parsley-maxlength="40"></td>
			</tr>

			<tr>
				<td class="title_td"><label for="busi_field">등록업종</label></td>
				<td><input type="text" name="busi_field" class="in_w100" id="busi_field" data-parsley-maxlength="50"></td>
				<td class="title_td"><label for="busi_reg_date">등록연월일 <span class="color_cd5500">*</span></label></td>
				<td><input id="busi_reg_date" name="busi_reg_date" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="" readonly /></td>
			</tr>
			<tr>
				<td class="title_td">전화번호 <span class="color_cd5500">*</span></td>
				<td>
					<input type="text" name="busi_tel1" class="in_wp70 onlynum" id="busi_tel1" maxlength="3" data-parsley-required="true" >
					<label for="busi_tel1" class="hidden">전화번호 천번째 자리</label>
					-
					<input type="text" name="busi_tel2" class="in_wp70 onlynum" id="busi_tel2" maxlength="4" data-parsley-required="true" >
					<label for="busi_tel2" class="hidden">전화번호 가운데 자리</label>
					-
					<input type="text" name="busi_tel3" class="in_wp70 onlynum" id="busi_tel3" maxlength="4" data-parsley-required="true" >
					<label for="busi_tel3" class="hidden">전화번호 마지막 자리</label>											
				</td>
				<td class="title_td"><label for="fax">FAX <span class="color_cd5500">*</span></label></td>
				<td>
					<input type="text" name="fax1" class="in_wp70 onlynum" id="fax1" maxlength="3" data-parsley-required="true" >
					<label for="fax1" class="hidden">fax 천번째 자리</label>
					-
					<input type="text" name="fax2" class="in_wp70 onlynum" id="fax2" maxlength="4" data-parsley-required="true" >
					<label for="fax2" class="hidden">fax 가운데 자리</label>
					-
					<input type="text" name="fax3" class="in_wp70 onlynum" id="fax3" maxlength="4" data-parsley-required="true" >
					<label for="fax3" class="hidden">fax 마지막 자리</label>	
			</tr>

			<tr>
				<td class="title_td">주소 <span class="color_cd5500">*</span></td>
				<td colspan="3">
					<input type="text" name="busi_zipcode" class="in_wp100" id="busi_zipcode" readOnly>
					<label for="busi_zipcode" class="hidden">우편번호 </label>
					<a href="javascript:findAddress(2);" title="주소찾기" class="input_bt" target="_self">주소찾기</a>
					<input type="text" name="busi_address" class="in_w100 margint5" placeholder="기본주소" id="busi_address" readOnly>
					<label for="busi_address" class="hidden">기본주소</label>
					<input type="text" name="busi_address2" class="in_w100 margint5" placeholder="상세주소" id="busi_address2" data-parsley-maxlength="200">
					<label for="busi_address2" class="hidden">상세주소</label>
				</td>
			</tr>

		</tbody>
	</table>
</div>	



<div class="alert_txt bold margint40">증빙서류 등록</div>

<div class="table_area_01 margint10">
	<table>
		<caption>증빙서류 등록</caption>
		<colgroup>
			<col>
			<col>
			<col>
		</colgroup>

		<thead>
			<tr>
				<th>사업자 등록증</th>
				<th>고용보험목록</th>
				<th>기타서류</th>
			</tr>
		</thead>
		<tbody>

			<tr>
				<td><input type="file" id="uploadFile1" name="uploadFile1" class="fileupload" style="width:147px;height:31px;"/><br><span id="uploadFile1_path"></span></td>
				<td><input type="file" id="uploadFile2" name="uploadFile2" class="fileupload" style="width:147px;height:31px;"/><br><span id="uploadFile2_path"></span></td>
				<td><input type="file" id="uploadFile3" name="uploadFile3" class="fileupload" style="width:147px;height:31px;"/><br><span id="uploadFile3_path"></span></td>
			</tr>

		</tbody>
	</table>
</div>	

<div class="button_area">
	<a href="javascript:educationApplyInsert()" style="background: #bea214;" title="확인" target="_self">확인</a>
	<a href="javascript:educationApplyCancel()" title="취소" target="_self">취소</a>
</div>
</form>

<jsp:include page="/WEB-INF/jsp/common/jusoSearchPopup.jsp"/>