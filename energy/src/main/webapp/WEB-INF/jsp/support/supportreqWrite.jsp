<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>

<script language="javascript">

var insertSupportreqUrl = '<c:url value="/web/support/insertSupportreq.do" />';

$( document ).ready( function(){
	
	if("${supportreq.vDupCode}" == ""){
		alert("잘못된 경로로 접근을 하였습니다.");
		document.location ="/web/support/supportreqCerti.do";
	}
	
	$('#modal-juso-write').popup();
	
	$(".onlynum").keyup( setNumberOnly );
	
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
	
	changeProtGb();
	
});

function supportreqInsert(){

	if( ! $( '#agree1-1' ).get(0).checked ){
		alert( '개인정보활용에 동의해 주셔야 합니다.' );
		$( '#agree1-1' ).focus();
		return;		
	}

	if( ! $( '#agree2-1' ).get(0).checked ){
		alert( '개인정보 제3자 제공에 동의해 주셔야 합니다.' );
		$( '#agree2-1' ).focus();
		return;		
	}

   if($("#mobile_2").val() == "" || $("#mobile_3").val() == ""){
	   alert("연락처는 필수 입력사항입니다.");
	   $("#mobile_2").focus();
	   return;
   } else {
	   $("#handphone").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
   }
	   
   if($("#zipcode").val() == "" || $("#addr2").val() == ""){
	   alert("주소를 정확히 입력해 주십시요.");
	   $("#addr2").focus();
	   return;		   
   }
   
   var heatType = $("#heat_type").val();
   if(heatType == "ETC" && $("#heat_type").val() == ""){
	  alert("기타 난방종류를 입력해주십시요.");
	  return;
   }
   
   if ($("#uploadFile1").val() != "" && !$("#uploadFile1").val().toLowerCase().match(/\.(jpg|png|gif|ppt|pptx|xls|xlsx|doc|docx|hwp|txt|pdf|zip)$/)){
	   alert("확장자가 jpg,png,gif,ppt,pptx,xls,xlsx,doc,docx,hwp,txt,pdf,zip 파일만 업로드가 가능합니다.");
	   return;
   }  
	
   if ( $("#supportFrm").parsley().validate() ){	   
		// 데이터를 등록 처리해준다.
		$("#supportFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					document.supportFrm.action = "<c:url value='/web/support/supportreqComplete.do'/>";
					document.supportFrm.submit();
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

function setAddr(roadAddr,jibunAddr,zipNo,admCd){
	$("#zipcode").val(zipNo);
	$("#addr1").val(roadAddr);
	$("#addr2").val("");
	$("#administ_cd").val(admCd);
	$("#addr2").focus();
}

function showWriteMethod(){
	$("#write_method").show();
}

function supportreqCancel(){
	document.location = "/web/support/supportreqCerti.do";
}
</script>

<form id="supportFrm" name="supportFrm" method="post" enctype="multipart/form-data" data-parsley-validate="true" onSubmit="return false">
<input type="hidden" id="gender" name="gender" value="${supportreq.gender}" />
<input type="hidden" id="handphone" name="handphone" value="" />
<input type="hidden" id="administ_cd" name="administ_cd" value="" />

	<center class="con_img2"><img src="../../../images/sub/imp/imp-03-02.png" alt="약관동의 및 신청서 작성"></center>

	<div class="alert_txt bold margint40">[개인정보활용동의]</div>
	<div class="border_div2 margint10">
		· 수집하는 개인정보의 항목 : 주소, 성명(한글), 생년월일, 보호 구분, 보호 유형, 세대 유형, 세대 원수, 아동 및 장애인 수, 연락처, 주거 실태, 난방 종류 <BR />
		· 수집·이용 목적 : 저소득층 에너지효율개선사업 신청을 목적으로 개인정보 수집<BR />
		· 보유 및 이용기간 : 지원 확정 후 5년간 보유하며 만료 후 파기<BR />
		· 수집 동의 거부의 권리 : 개인정보 수집 및 활용에 관해 동의 거부할 수 있으나, 거부 시 지원대상자 선정이 불가합니다.							
	</div>
	
	<div class="alignr margint10">
		<input type="radio" name="agree1" id="agree1-1"> <label for="agree1-1">동의함</label>　
		<input type="radio" name="agree1" id="agree1-2" checked> <label for="agree1-2">동의하지 않음</label>	
	</div>
	
	<div class="alert_txt bold margint40">[개인정보 제3자 제공 동의]</div>
	<div class="border_div2 margint10">
		· 개인정보를 제공받는 자 : 한국에너지재단(사업 주관기관)<BR />
		· 개인정보를 제공받는 자의 개인정보 이용 목적 : 저소득층 에너지효율개선사업 진행<BR />
		· 제공하는 개인정보의 항목 : 주소, 성명(한글), 생년월일, 보호 구분, 보호 유형, 세대 유형, 세대 원수, 아동 및 장애인 수, 연락처, 주거 실태, 
		난방 종류<BR />
		· 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 지원 연도 후 5년 간 보유 <BR />
		· 개인정보의 제3자 제공에 동의하지 않을 권리가 있으며, 동의하지 않을 경우 시공 및 물품지원이 불가합니다.
	</div>
	
	<div class="alignr margint10">
		<input type="radio" name="agree2" id="agree2-1"> <label for="agree2-1">동의함</label>　
		<input type="radio" name="agree2" id="agree2-2" checked> <label for="agree2-2">동의하지 않음</label>	
	</div>


	<div class="alert_txt bold margint40">대상가구 지원신청서</div>
	<div class="alert_txt margint20 color_227ab3 font13p">
		※ 모든 입력 항목은 필수 입니다.<BR />
		※ 위 신청은 해당 기초지자체 요건 확인과 해당 시공업체에서 지원내역에 대한 조사를 거쳐 확정될 예정입니다.<BR />
		※ 사업안내가 필요할 경우 한국에너지재단으로 연락주시기 바랍니다. (☎1670-7653)
	</div>


	<div class="table_area_02 margint20">
		<table>
			<caption>2016</caption>
			<colgroup>
				<col style="width: 15%">
				<col style="width: 35%">
				<col style="width: 15%">
				<col style="width: 35%">
			</colgroup>
			<tbody>
				<tr>
					<td class="title_td"><label for="req_nm">신청인</label></td>
					<td><input type="text" id="req_nm" name="req_nm" class="in_w100" value="${supportreq.req_nm}" readOnly></td>
					<td class="title_td"><label for="birth">생년월일</label></td>
					<td><input id="birth" name="birth" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="${supportreq.birth}" readonly /></td>
				</tr>
				<tr>
					<td class="title_td"><label for="prot_gb">보호구분</label></td>
					<td>
						<g:select id="prot_gb" name="prot_gb" codeGroup="SAFE_CD" cls="in_wp130" onChange="changeProtGb()"/>
					</td>
					<td class="title_td"><label for="prot_type">보호유형</label></td>
					<td>
						<select name="prot_type" id="prot_type" class="in_wp130" data-parsley-required="true">
						</select>											
					</td>
				</tr>
				<tr>
					<td class="title_td"><label for="gener_type">세대유형</label></td>
					<td>
						<g:select id="gener_type" name="gener_type" codeGroup="FA_TYPE_CD" cls="in_wp130" titleCode="선택"/>
					</td>
					<td class="title_td"><label for="gener_cnt">세대원수</label></td>
					<td>
						<input type="text" name="gener_cnt" class="in_wp70 onlynum" id="gener_cnt" value="0" data-parsley-required="true" /> 명
					</td>
				</tr>

				<tr>
					<td class="title_td"><label for="child_cnt">아동 수</label></td>
					<td>
						<input type="text" name="child_cnt" class="in_wp70 onlynum" id="child_cnt"value="0" data-parsley-required="true" /> 명
					</td>
					<td class="title_td"><label for="disable_cnt">장애인 수</label></td>
					<td>
						<input type="text" name="disable_cnt" class="in_wp70 onlynum" id="disable_cnt" value="0" data-parsley-required="true" /> 명
					</td>
				</tr>


				<tr>
					<td class="title_td"><label for="zipcode">주소</label></td>
					<td colspan="3">
						<input type="text" name="zipcode" class="in_wp100" id="zipcode" readOnly>
						<a href="javascript:jusoPopupShow();" title="주소찾기" class="input_bt" target="_self">주소찾기</a>

						<input type="text" name="addr1" class="in_w100 margint5" placeholder="기본주소" id="addr1" readOnly>
						<label for="addr1" class="hidden">기본주소</label>
						<input type="text" name="addr2" class="in_w100 margint5" placeholder="상세주소" id="addr2" data-parsley-maxlength="200">
						<label for="addr2" class="hidden">상세주소</label>
					</td>
				</tr>


				<tr>
					<td class="title_td"><label for="mobile_1">연락처</label></td>
					<td colspan="3">
						<select name="mobile_1" id="mobile_1" class="in_wp60">
							<option value='010'>010</option>
							<option value='011'>011</option>
							<option value='016'>016</option>
							<option value='017'>017</option>
							<option value='018'>018</option>
							<option value='019'>019</option>
						</select>
						-
						<input type="text" name="mobile_2" class="in_wp70 onlynum" id="mobile_2" maxlength="4">
						<label for="mobile_2" class="hidden">연락처 가운데 자리</label>
						-
						<input type="text" name="mobile_3" class="in_wp70 onlynum" id="mobile_3" maxlength="4">
						<label for="mobile_3" class="hidden">연락처 마지막 자리</label>
					</td>
				</tr>


				<tr>
					<td class="title_td"><label for="live_type">주거실태</label></td>
					<td colspan="3">
						<g:select id="live_type" name="live_type" codeGroup="LIVE_TYPE" cls="in_wp130" titleCode="선택"/>
					</td>
				</tr>

				<tr>
					<td class="title_td"><label for="heat_type">난방종류</label></td>
					<td colspan="3">
						<g:select id="heat_type" name="heat_type" codeGroup="HEAT_TYPE" cls="in_wp130" titleCode="선택" onChange="changeHeatType()" />
						<input type="text" name="heat_etc" class="in_wp200" id="heat_etc" style="display:none" data-parsley-maxlength="100">
						<label for="heat_etc" class="hidden">난방기타</label>
					</td>
				</tr>


				<tr>
					<td class="title_td"><label for="input17">대상가구<BR />증명서류</label></td>
					<td colspan="3">
	 				    <label for="uploadFile1" class="hidden">파일 선택하기</label>
						<input class="in_w60 marginb10" type="file" id="uploadFile1" name="uploadFile1" value="" data-parsley-required="false" data-parsley-maxlength="100" />
						<div class="alert_txt2 color_227ab3 font13p">※ 보호구분이 “수급자, 차상위인” 경우 3개월 이내의 대상가구 증명서류를 제출하셔야 합니다.</div>
					</td>
				</tr>


				<!-- <tr>
					<td class="title_td"><label for="input17">복지가구<BR />추천서류</label></td>
					<td colspan="3">
						<input type="text" name="" class="in_w30" id="input17">
						<a href="#link" title="주소찾기" class="input_bt" target="_self">찾아보기</a>
						<div class="alert_txt2 color_227ab3 font13p">※ 보호유형이 “저소득가구”인 경우 복지가구 추천서류를 제출하셔야 합니다.</div>
					</td>
				</tr> -->

			</tbody>
		</table>
	</div>	
	<div class="alignr margint10">
		<a href="javascript:showWriteMethod()" title="항목별 작성방법" target="_self">
		<img src="../../../images/sub/imp/imp_bt_off.png" alt="항목별 작성방법">
		</a>

		<div class="button_area">
			<a href="javascript:supportreqInsert()" style="background: #bea214;" title="신청" target="_self">신청</a>
			<a href="javascript:supportreqCancel()" title="취소" target="_self">취소</a>
		</div>
	</div>	
</form>
     <div id="write_method" style="display:none">   
       <div class="alert_txt bold margint40">항목별 작성방법</div>
		<div class="table_area_01 margint20">
			<table>
				<caption>저소득층 에너지효율개선사업 추진 실적</caption>
				<colgroup>
					<col style="width: 200px;">
					<col>
				</colgroup>
				<thead>
					<tr>
						<th>구분</th>
						<th>작성 내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>시ㆍ도</td>
						<td class="alignl">해당 주소지의 시ㆍ도 (ex. 서울)</td>
					</tr>
					<tr>
						<td>시ㆍ군ㆍ구</td>
						<td class="alignl">해당 주소지의 시ㆍ군ㆍ구(ex. 서초구)</td>
					</tr>
					<tr>
						<td>신청인</td>
						<td class="alignl">신청인 성명 기입</td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td class="alignl">신청인 생년월일 기입</td>
					</tr>
					<tr>
						<td>보호구분</td>
						<td class="alignl">수급자, 차상위<!-- , 저소득가구 --> 중 선택하여 체크</td>
					</tr>
					<tr>
						<td>보호유형</td>
						<td class="alignl">
							수급자 : 일반수급자, 조건부수급자 중 기입<BR />
							차상위 : 차상위자활, 차상위장애(아동)수당 및 장애연금, 차상위본인부담경감 중 기입<!-- <BR />
							저소득가구의 경우 : 수급자 또는 차상위가 아닌 일반저소득가구 <BR />
							* 일반저소득가구는 복지사각지대 추천서 반드시 필요						 -->					
						</td>
					</tr>
					<tr>
						<td>세대유형</td>
						<td class="alignl">
							홀몸노인세대, 노인세대, 소년소녀세대, 한부모세대, 장애인세대, <BR />
							일반세대, 조손세대, 기타
						</td>
					</tr>
					<tr>
						<td>아동 및 장애인수</td>
						<td class="alignl">
							세대원 중 18세 미만의 아동수를 기재(아동복지법 제3조 참조)<BR />
							세대원 중 장애인이 있을 경우 장애인 수를 기재
						
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td class="alignl">상세주소(도로명 주소) 기입</td>
					</tr>
					<tr>
						<td>주거실태</td>
						<td class="alignl">
							자가, 전세, 월세, 보증부월세, 전체무료임차, 부분무료임차, 기타<BR />
							* 수급가구인 경우 주거급여 자가 집수리 지원가구는 지원 대상에서 제외<BR />
							* 차상위의 경우 자가 소유자도 지원											
						</td>
					</tr>
					<tr>
						<td>난방종류</td>
						<td class="alignl">기름, 심야전기, 도시가스, LPG, 연탄, 기타</td>
					</tr>
					<tr>
						<td>신청기관 명</td>
						<td class="alignl">지원신청서 제출 기관명</td>
					</tr>
					<tr>
						<td>신청기관 담당자</td>
						<td class="alignl">지원신청서 접수담당자 성명</td>
					</tr>
					<tr>
						<td>기초생활수급자</td>
						<td class="alignl">『국민기초생활보장법』제2조제1호의 수급권자 중 주거급여 자가 집수리 대상자를 제외한 수급자</td>
					</tr>
					<tr>
						<td>차상위계층</td>
						<td class="alignl">
							『국민기초생활보장법』제2조제11호에 따른 차상위계층 및 다음의 어느 하나에 해당하는 사람이 속한 가구의 세대주<BR />
							- 차상위자활, 차상위장애(아동)수당 및 장애인연금, 차상위본임부담경감, 차상위한부모, 차상위우선돌봄		
						</td>
					</tr>
					<!-- <tr>
						<td>복지사각지대 일반저소득가구</td>
						<td class="alignl">기초지자체장의 추천을 받은 에너지복지 사각지대의 일반 저소득층 가구</td>
					</tr> -->
				</tbody>
			</table>
		</div>	
	</div>
 <jsp:include page="/WEB-INF/jsp/common/jusoSearchPopup.jsp"/>