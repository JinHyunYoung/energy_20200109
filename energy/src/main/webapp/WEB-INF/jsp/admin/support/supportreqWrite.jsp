<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/js/announce.js"></script>

<script language="javascript">
var selectSupportreqUrl = '<c:url value="/admin/support/supportreqListPage.do" />';
var insertSupportreqUrl = '<c:url value="/admin/support/insertSupportreq.do" />';
var updateSupportreqUrl = "<c:url value='/admin/support/updateSupportreq.do'/>"
var deleteSupportreqUrl = "<c:url value='/admin/support/deleteSupportreq.do'/>";
var approvalSupportreqUrl = "<c:url value='/admin/support/approvalSupportreq.do'/>";

$( document ).ready( function(){
	
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

   if($("#req_nm").val() == ""){
	   alert("신청인(이름)은 필수 입력사항입니다.");
	   $("#req_nm").focus();
	   return;
   }
   
   if($("#birth").val() == ""){
	   alert("생년월일은 필수 입력사항입니다.");
	   $("#birth").focus();
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
	
   if ( $("#writeFrm").parsley().validate() ){	   
	   var url = insertSupportreqUrl;	
	   if($("#req_id").val() != "") url = updateSupportreqUrl;
		   
	   // 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					supportreqList();
				}	
			},
			dataType: "json",
			url: url
	    });	
   }	

}

function supportreqDelete(){
	
	  if(!confirm("삭제하시겠습니까?")) return;
 	 
	    $.ajax({
	        url: deleteSupportreqUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	        	req_id : $("#req_id").val()
			},
	        success: function(data) {
	        	alert(data.message);
	        	if(data.success == "true") supportreqList();
	        },
	        error: function(e) {
	            alert("테이블을 가져오는데 실패하였습니다.");
	        }
	    });	
}

function changeProtGb(){
	var protGb = $("#prot_gb").val();
	selectbox_deletealllist("prot_type");
	getCommonCodeList("SAFE_CD_"+protGb, "prot_type", "${supportreq.prot_type}", "", "", true); 
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

function delFile(){
	$("#obj_prof_doc").val("");
	$("#uploadedFile1").hide();
}

function supportreqList(){
	document.writeFrm.action = selectSupportreqUrl;
	document.writeFrm.submit();
}

function approvalSupportreq(result){
	var resultNm = "승인";
	if(result == "N") resultNm = "반려";
	if(!confirm(resultNm+" 처리하시겠습니까?")) return;
	$.ajax
	({
		type: "POST",
         	url: approvalSupportreqUrl,
         	data:{
         		req_id : $("#req_id").val(),
         		eval_result : result,
         		eval_result_nm : resultNm
         	},
			success:function(data, dataType){					
				alert(data.message);					
				if(data.success == "true"){
					$("#eval_result").html(data.eval_result_nm);
					$("#eval_date").html(data.eval_date);
				}
			}
	});
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
       <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
			<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
			<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
			<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
			<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		    <input type='hidden' id="req_id" name='req_id' value="${param.req_id}" />
		    <input type='hidden' id=p_administ_cd name='p_administ_cd' value="${param.p_administ_cd}" />
		    <input type='hidden' id="p_sido" name='p_sido' value="${param.p_sido}" />
		    <input type='hidden' id="p_sigun" name='p_sigun' value="${param.p_sigun}" />
		    <input type='hidden' id="p_eval_result" name='p_eval_result' value="${param.p_eval_result}" />
		    <input type='hidden' id="p_prot_gb" name='p_prot_gb' value="${param.p_prot_gb}" />
		    <input type='hidden' id="p_prot_type" name='p_prot_type' value="${param.p_prot_type}" />
		    <input type='hidden' id="p_gener_type" name='p_gener_type' value="${param.p_gener_type}" />
			<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
			<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="${param.p_searchtxt}" />
			<input type="hidden" id="handphone" name="handphone" value="" />
			<input type="hidden" id="obj_prof_doc" name="obj_prof_doc" value="${supportreq.obj_prof_doc}" />
            <input type="hidden" id="administ_cd" name="administ_cd" value="${supportreq.administ_cd}" />
            
		<!--table_area-->
		<div class="table_area">
			<table class="write">
				<caption>지원신청서 수정</caption>
				<colgroup>
					<col style="width:180px;">
					<col style="width:*;">
				</colgroup>
				<tbody>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">지원신청동의여부</th>
						<td>
							<input id="table_label01_01" type="radio" class="marginr5" checked="checked" name="table_label01" disabled/>
							<label for="table_label01_01">동의</label>
							<input id="table_label01_02" type="radio" class="marginr5" name="table_label01" disabled/>
							<label for="table_label01_02">동의하지않음</label>
							<span class="padl5">(동의일 : ${supportreq.reg_date})</span>
						</td>
					</tr>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">신청일시</th>
						<td>${supportreq.reg_date}</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>
							<label for="req_nm">신청인(이름)</label>
						</th>
						<td>
							<input type="text" id="req_nm" name="req_nm" class="in_wp150" value="${supportreq.req_nm}" data-parsley-required="true" data-parsley-maxlength="30" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>
							<label for="birth">생년월일</label>
						</th>
						<td>
							<input id="birth" name="birth" type="text" class="in_wp100 datepicker" data-parsley-required="true" value="${supportreq.birth}" readonly />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>
							<label for="prot_gb">보호구분</label>
						</th>
						<td>
							<g:select id="prot_gb" name="prot_gb" codeGroup="SAFE_CD" cls="in_wp150" selected="${supportreq.prot_gb}" onChange="changeProtGb()" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>
							<label for="prot_type">보호유형</label>
						</th>
						<td>
							<select name="prot_type" id="prot_type" class="in_wp250" data-parsley-required="true">
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>
							<label for="gener_type">세대유형</label>
						</th>
						<td>
							<g:select id="gener_type" name="gener_type" codeGroup="FA_TYPE_CD" cls="in_wp130" selected="${supportreq.gener_type}" data-parsley-required="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>
							<label for="table_label08">세대원 수</label>
						</th>
						<td>
							<input type="text" name="gener_cnt" class="in_wp80 marginr5 onlynum" id="gener_cnt" value="${supportreq.gener_cnt}" data-parsley-required="true" /> 명
						</td>
					</tr>
					<tr>
						<th scope="row">아동/장애인 수</th>
						<td>
							<label for="child_cnt">아동</label> :
							<input type="text" name="child_cnt" class="in_wp80 onlynum" id="child_cnt"value="${supportreq.child_cnt}" data-parsley-required="true" /> 명
							/
							<label for="disable_cnt" class="marginl5 marginr5">장애인</label> :
							<input type="text" name="disable_cnt" class="in_wp70 onlynum" id="disable_cnt" value="${supportreq.disable_cnt}" data-parsley-required="true" /> 명 
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>주소
						</th>
						<td>
							<label for="zipcode" class="hidden">우편번호</label>
							<input type="text" name="zipcode" class="in_wp150 margint5" id="zipcode" value="${supportreq.zipcode}" readOnly>
							<button type="button" class="btn look" title="주소찾기" onClick="jusoPopupShow()">
								<span>주소찾기</span>
							</button>
							<label for="addr1" class="hidden">기본주소</label>
							<input type="text" name="addr1" class="in_w100 margint5" placeholder="기본주소" id="addr1" value="${supportreq.addr1}" readOnly>
							<label for="addr2" class="hidden">상세주소</label>
							<input type="text" name="addr2" class="in_w100 margint5" placeholder="상세주소" id="addr2" data-parsley-maxlength="200" value="${supportreq.addr2}">
						</td>
					</tr>
					<tr>
						<th scope="row">
							<strong class="color_pointr">*</strong>연락처
						</th>
						<td>
							<label for="mobile_1" class="hidden">휴대전화 앞번호 선택</label>
							<select name="mobile_1" id="mobile_1" class="in_wp60">
								<option value='010' <c:if test="${supportreq.mobile_1 == '010'}">selected</c:if>>010</option>
								<option value='011' <c:if test="${supportreq.mobile_1 == '011'}">selected</c:if>>011</option>
								<option value='016' <c:if test="${supportreq.mobile_1 == '016'}">selected</c:if>>016</option>
								<option value='017' <c:if test="${supportreq.mobile_1 == '017'}">selected</c:if>>017</option>
								<option value='018' <c:if test="${supportreq.mobile_1 == '018'}">selected</c:if>>018</option>
								<option value='019' <c:if test="${supportreq.mobile_1 == '019'}">selected</c:if>>019</option>
							</select>
							-
							<input type="text" name="mobile_2" class="in_wp70 onlynum" id="mobile_2" maxlength="4" value="${supportreq.mobile_2}">
							<label for="mobile_2" class="hidden">연락처 가운데 자리</label>
							-
							<input type="text" name="mobile_3" class="in_wp70 onlynum" id="mobile_3" maxlength="4" value="${supportreq.mobile_3}">
							<label for="mobile_3" class="hidden">연락처 마지막 자리</label>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="table_label12">주거실태</label>
						</th>
						<td>
                            <g:select id="live_type" name="live_type" codeGroup="LIVE_TYPE" cls="in_wp130" titleCode="선택" selected="${supportreq.live_type}" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="table_label13_01">난방종류</label>
						</th>
						<td>
						    <g:select id="heat_type" name="heat_type" codeGroup="HEAT_TYPE" cls="in_wp100"  selected="${supportreq.heat_type}" titleCode="선택" onChange="changeHeatType()" />
							<!--난방종류에서 "기타" 선택시 입력하는 창입니다.-->
							<label for="table_label13_02" class="hidden">난방종류에서 기타부분 입력창</label>
							<input type="text" name="heat_etc" class="in_wp200" id="heat_etc" value="${supportreq.heat_etc}" style="display:<c:if test="${supportreq.heat_type != 'ETC'}">none</c:if>" data-parsley-maxlength="100">
						</td>
					</tr>
					<tr>
						<th scope="row">대상가구 증명서류</th>
						<td>
							 <c:if test="${param.mode == 'E' && !empty supportreq.obj_prof_doc}">
		                      <p id="uploadedFile1"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${supportreq.obj_prof_doc}" >${supportreq.obj_prof_doc_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile()"></a></p>
		                     </c:if> 
		                     <input class="in_w100" type="file" id="uploadFile1" name="uploadFile1" value="" />
							<p class="color_point">※ 보호구분이 수급자, 차상위인 경우 3개월 이내의 대상가구 증명서류를 제출하셔야 합니다.</p>
						</td>
					</tr>
					<tr style="display:none">
						<th scope="row">복지가구 추천서류</th>
						<td>
							<div class="file_area">
								<label for="table_label15" class="hidden">파일 선택하기</label>
								<input id="table_label15" type="file" class="in_wp400">
							</div>
							<p class="color_point">※ 보호유형이 “저소득가구”인 경우 복지가구 추천서류를 제출하셔야 합니다.</p>
						</td>
					</tr>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">
							<label for="apply_org_nm">신청기관명</label>
						</th>
						<td>
							<input type="text" name="apply_org_nm" class="in_wp200" id="apply_org_nm" data-parsley-maxlength="100" value="${supportreq.apply_org_nm}">
						</td>
					</tr>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">
							<label for="apply_org_usernm">신청기관 담당자</label>
						</th>
						<td>
							<input type="text" name="apply_org_usernm" class="in_wp200" id="apply_org_usernm" data-parsley-maxlength="100" value="${supportreq.apply_org_usernm}">
						</td>
					</tr>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">심사결과</th>
						<td id="eval_result">${supportreq.eval_result_nm}</td>
					</tr>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">심사처리일</th>
						<td id="eval_date">${supportreq.eval_date}</td>
					</tr>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">
							<label for="memo">관리자메모</label>
						</th>
						<td>
							<textarea id="memo" name="memo" cols="5" rows="5" class="in_w100">${supportreq.memo}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>				
        <!--// table_area -->
	
		<!-- button_area -->
		<div class="button_area">
			<div class="float_left" style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
				<button type="button" class="btn save" title="승인" onClick="approvalSupportreq('Y')">
					<span>승인</span>
				</button>
				<button type="button" class="btn cancel" title="반려" onClick="approvalSupportreq('N')">
					<span>반려</span>
				</button>
			</div>
			<div class="float_right">
				<button type="button" class="btn save" title="저장하기" onClick="supportreqInsert()">
					<span>저장</span>
				</button>
				<button type="button" class="btn cancel" title="삭제하기" onClick="supportreqDelete()" style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
					<span>삭제</span>
				</button>
				<a href="javascript:supportreqList();" title="목록 페이지로 이동하기" class="btn list">
					<span>목록</span>
				</a>
			</div>
		</div>
		
</form>
</div>
<!--// content -->
<jsp:include page="/WEB-INF/jsp/common/jusoSearchPopup.jsp"/>