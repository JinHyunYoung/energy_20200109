<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
});	

//기업디렉토리 생성
function makeCmpyDir(){

	if ( $("#cmpyDirMake2Form").parsley().validate() ){
	     
		if(!(($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "") || 
			($("#tel_1").val() == "" && $("#tel_2").val() == "" && $("#tel_3").val() == ""))){
		    
			alert("전화번호를 정확히 입력해주십시요");
			$("#tel_1").focus();
			return;
		}
				
		if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
			$("#tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
		} else {
			$("#tel").val("");
		}
		
		if(!(($("#fax_1").val() != "" && $("#fax_2").val() != "" && $("#fax_3").val() != "") || 
			($("#fax_1").val() == "" && $("#fax_2").val() == "" && $("#fax_3").val() == ""))){
		    
			alert("팩스번호를 정확히 입력해주십시요");
			$("#fax_1").focus();
			return;
		}
				
		if($("#fax_1").val() != "" && $("#fax_2").val() != "" && $("#fax_3").val() != ""){
			$("#fax").val($("#fax_1").val()+"-"+$("#fax_2").val()+"-"+$("#fax_3").val());
		} else {
			$("#fax").val("");
		}
		
		var manager_tel_1 = $("#manager_tel_1").val();
		var manager_tel_2 = $("#manager_tel_2").val();
		var manager_tel_3 = $("#manager_tel_3").val();
	     
		if( manager_tel_1 == null || manager_tel_1 == ""){
			alert("휴대폰번호를 정확히 입력해주십시요");
			$("#manager_tel_1").focus();
			return;			
		} 
		if( manager_tel_2 == null || manager_tel_2 == ""){
			alert("휴대폰번호를 정확히 입력해주십시요");
			$("#manager_tel_2").focus();
			return;			
		} 
		if( manager_tel_3 == null || manager_tel_3 == ""){
			alert("휴대폰번호를 정확히 입력해주십시요");
			$("#manager_tel_3").focus();
			return;			
		} 
		
		$("#manager_tel").val(manager_tel_1 + "-" + manager_tel_2 + "-" + manager_tel_3);
		
		var manager_email_1 = $("#manager_email_1").val();
		var manager_email_2 = $("#manager_email_2").val();
	     
		if( manager_email_1 == null || manager_email_1 == ""){
			alert("이메일을 정확히 입력해주십시요");
			$("#manager_email_1").focus();
			return;			
		} 
		if( manager_email_2 == null || manager_email_2 == ""){
			alert("이메일을 정확히 입력해주십시요");
			$("#manager_email_2").focus();
			return;			
		} 
		
		$("#manager_email").val(manager_email_1 + "@" + manager_email_2);
		$("#co_tp_nm").val($("#co_tp_cd option:selected").text());
			
		 $.ajax({
		     url: "/web/directory/insertCmpyDir.do",
			 data :jQuery("#cmpyDirMake2Form").serialize(),
		     dataType: "json",
		     type: "post",
		     async : false,
		     success: function(data) {	
				if(data.success == "true"){
					goCmpyDirMake3();
				} else {
                    alert(data.message);
                }
		     },
		     error: function(e) {
		    	 alert( '데이터를 가져오는데 실패했습니다.' );
		     }
		});	
	}
}


//기업디렉토리 만들기 3 로 이동
function goCmpyDirMake3(){
  
  var f = document.cmpyDirMake2Form;
 
  f.target = "_self";
  f.action = "/web/directory/cmpyDirMake3.do";
  f.submit();
	
}

//주소 설정
function setAddr(roadAddr, jibunAddr, zipNo, admCd){	
	$("#post").val(zipNo);
	$("#addr1").val(roadAddr);
	$("#addr2").val("");
}

//이메일 도메인 변경
function changeEmailDomain(){
	var domain = $("#email_domain").val();
	
	if(domain == 'self'){
		$("#manager_email_2").val('');
	} else {
		$("#manager_email_2").val($("#email_domain").val());		
	}
}


</script>

<!-- step_area -->
<div class="step_area">
	<ul class="step_list">
		<li title="1. 기업 디렉토리 중복확인">1</li>
		<li class="active" title="2. 기업정보 입력">
			<strong>2. 기업정보 입력</strong>
		</li>
		<li title="3. 기업 디렉토리 신청완료">3</li>
	</ul>
</div>
<!--// step_area -->

<form id="cmpyDirMake2Form" name="cmpyDirMake2Form" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}"/> 
	<input type='hidden' id="cmpy_nm" name='cmpy_nm' value="${param.cmpy_nm}" />
	<input type='hidden' id="biz_reg_no" name='biz_reg_no' value="${param.biz_reg_no}" />
	<input type='hidden' id="ceo_nm" name='ceo_nm' value="${param.ceo_nm}" />
	<input type='hidden' id="tel" name='tel' value="${cmpyDir.tel}" />
	<input type='hidden' id="fax" name='fax' value="${cmpyDir.fax}" />
	<input type='hidden' id="manager_tel" name='manager_tel' value="${cmpyDir.manager_tel}" />
	<input type='hidden' id="manager_email" name='manager_email' value="${cmpyDir.manager_email}" />
	<input type='hidden' id="inds_tp_cd" name='inds_tp_cd' value="${ param.inds_tp_cd }" /> 
	<input type='hidden' id="co_tp_nm" name='co_tp_nm' value="" />
	
	
	<!-- division -->
	<div class="division40">
		<h5 class="title">기업정보</h5>
		<!-- table_area -->
		<div class="table_area">
			<table class="write">
				<caption>기업정보 입력 화면</caption>
				<colgroup>
					<col style="width: 200px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong> 기업명(국문)
					</th>
					<td>
						${param.cmpy_nm}					
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="firm_name">
							<strong class="color_pointr">*</strong> 기업명(영문)
						</label>
					</th>
					<td>
						<input type="text" name="cmpy_nm_en" id="cmpy_nm_en" value="${cmpyDir.cmpy_nm_en}" class="in_w80" data-parsley-maxlength="300" data-parsley-required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong> 사업자번호
					</th>
					<td>${param.biz_reg_no}</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong> 대표자명(국문)
					</th>
					<td>${param.ceo_nm}</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="ceo_name_en">
							<strong class="color_pointr">*</strong> 대표자명(영문)
						</label>
					</th>
					<td>
						<input type="text" name="ceo_nm_en" id="ceo_nm_en" value="${cmpyDir.ceo_nm_en}" class="in_w80" data-parsley-maxlength="300" data-parsley-required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong>법인형태
					</th>
					<td>
						<g:select id="co_tp_cd" name="co_tp_cd" codeGroup="CO_TP_CD" selected="${cmpyDir.co_tp_cd}" cls="form-control" titleCode="선택" data-parsley-required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="homepage">홈페이지 주소</label>
					</th>
					<td>
						<input type="text" class="in_w80" name="url" id="url" value="${cmpyDir.url}" data-parsley-maxlength="300" />
					</td>
				</tr>
				<tr>
					<th scope="row">회사 전화번호</th>
					<td>
						<select id="tel_1" name="tel_1" class="in_wp100">	
							<option value="" <c:if test="${cmpyDir.tel_1 == ''}">selected="selected"</c:if>>-선택-</option>
							<option value="02" <c:if test="${cmpyDir.tel_1 == '02'}">selected="selected"</c:if>>02</option>
							<option value="031" <c:if test="${cmpyDir.tel_1 == '031'}">selected="selected"</c:if>>031</option>
							<option value="032" <c:if test="${cmpyDir.tel_1 == '032'}">selected="selected"</c:if>>032</option>
							<option value="033" <c:if test="${cmpyDir.tel_1 == '033'}">selected="selected"</c:if>>033</option>
							<option value="041" <c:if test="${cmpyDir.tel_1 == '041'}">selected="selected"</c:if>>041</option>
							<option value="042" <c:if test="${cmpyDir.tel_1 == '042'}">selected="selected"</c:if>>042</option>
							<option value="043" <c:if test="${cmpyDir.tel_1 == '043'}">selected="selected"</c:if>>043</option>
							<option value="051" <c:if test="${cmpyDir.tel_1 == '051'}">selected="selected"</c:if>>051</option>
							<option value="052" <c:if test="${cmpyDir.tel_1 == '052'}">selected="selected"</c:if>>052</option>
							<option value="053" <c:if test="${cmpyDir.tel_1 == '053'}">selected="selected"</c:if>>053</option>
							<option value="054" <c:if test="${cmpyDir.tel_1 == '054'}">selected="selected"</c:if>>054</option>
							<option value="055" <c:if test="${cmpyDir.tel_1 == '055'}">selected="selected"</c:if>>055</option>
							<option value="061" <c:if test="${cmpyDir.tel_1 == '061'}">selected="selected"</c:if>>061</option>
							<option value="062" <c:if test="${cmpyDir.tel_1 == '062'}">selected="selected"</c:if>>062</option>
							<option value="063" <c:if test="${cmpyDir.tel_1 == '063'}">selected="selected"</c:if>>063</option>
							<option value="064" <c:if test="${cmpyDir.tel_1 == '064'}">selected="selected"</c:if>>064</option>
							<option value="070" <c:if test="${cmpyDir.tel_1 == '070'}">selected="selected"</c:if>>070</option>
						</select>
						<label for="tel_1" class="hidden">회사 앞번호 선택</label> - 
						
						<label for="tel_2" class="hidden">회사 중간번호 입력</label>
						<input type="text" id="tel_2" name="tel_2" value="${cmpyDir.tel_2}" class="in_wp100" maxlength="4" /> - 
						
						<label for="tel_3" class="hidden">회사 뒷번호 입력</label>
						<input type="text" id="tel_3" name="tel_3" value="${cmpyDir.tel_3}" class="in_wp100" maxlength="4" />
					</td>
				</tr>
				<tr>
					<th scope="row">회사 팩스번호</th>
					<td>
						<select id="fax_1" name="fax_1" class="in_wp100">
							<option value="" <c:if test="${cmpyDir.fax_1 == ''}">selected="selected"</c:if>>-선택-</option>
							<option value="02" <c:if test="${cmpyDir.fax_1 == '02'}">selected="selected"</c:if>>02</option>
							<option value="031" <c:if test="${cmpyDir.fax_1 == '031'}">selected="selected"</c:if>>031</option>
							<option value="032" <c:if test="${cmpyDir.fax_1 == '032'}">selected="selected"</c:if>>032</option>
							<option value="033" <c:if test="${cmpyDir.fax_1 == '033'}">selected="selected"</c:if>>033</option>
							<option value="041" <c:if test="${cmpyDir.fax_1 == '041'}">selected="selected"</c:if>>041</option>
							<option value="042" <c:if test="${cmpyDir.fax_1 == '042'}">selected="selected"</c:if>>042</option>
							<option value="043" <c:if test="${cmpyDir.fax_1 == '043'}">selected="selected"</c:if>>043</option>
							<option value="051" <c:if test="${cmpyDir.fax_1 == '051'}">selected="selected"</c:if>>051</option>
							<option value="052" <c:if test="${cmpyDir.fax_1 == '052'}">selected="selected"</c:if>>052</option>
							<option value="053" <c:if test="${cmpyDir.tel_1 == '053'}">selected="selected"</c:if>>053</option>
							<option value="054" <c:if test="${cmpyDir.fax_1 == '054'}">selected="selected"</c:if>>054</option>
							<option value="055" <c:if test="${cmpyDir.fax_1 == '055'}">selected="selected"</c:if>>055</option>
							<option value="061" <c:if test="${cmpyDir.fax_1 == '061'}">selected="selected"</c:if>>061</option>
							<option value="062" <c:if test="${cmpyDir.fax_1 == '062'}">selected="selected"</c:if>>062</option>
							<option value="063" <c:if test="${cmpyDir.fax_1 == '063'}">selected="selected"</c:if>>063</option>
							<option value="064" <c:if test="${cmpyDir.fax_1 == '064'}">selected="selected"</c:if>>064</option>
							<option value="070" <c:if test="${cmpyDir.fax_1 == '070'}">selected="selected"</c:if>>070</option>
						</select>										
						<label for="fax_1" class="hidden">회사 팩스번호 앞번호 선택</label> - 
						
						<input type="text" id="fax_2" name="fax_2" value="${cmpyDir.fax_2}" class="in_wp100" maxlength="4" /> - 
						<label for="fax_2" class="hidden">회사 팩스번호 중간번호 입력</label>
						
						<input type="text" id="fax_3" name="fax_3" value="${cmpyDir.fax_3}" class="in_wp100" maxlength="4"/>
						<label for="fax_3" class="hidden">회사 팩스번호 뒷번호 입력</label>
					</td>
				</tr>
				<tr>
					<th scope="row">회사 주소(국문)</th>
					<td>
						<input type="text" name="post" id="post" value="${cmpyDir.post}" class="in_wp100" maxlength="5" />
						<label for="post" class="hidden">주소 우편번호 찾기</label>
						<button class="btn basic" title="주소찾기" onclick="javascript:jusoPopupShow();">
							<span>주소찾기</span>
						</button>
						<div class="margint5">
							<input type="text" name="addr1" id="addr1" value="${cmpyDir.addr1}" class="in_w40" placeholder="기본주소" data-parsley-maxlength="300" />
							<label for="addr1" class="hidden">기본주소 입력</label>
							<input type="text" name="addr2" id="addr2" value="${cmpyDir.addr2}" class="in_w40" placeholder="상세주소" data-parsley-maxlength="300" />
							<label for="addr2" class="hidden">상세주소 입력</label>
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// table_area -->
		
	</div>
	<!--// division -->
						
	<!-- division -->
	<div class="division40">
		<h5 class="title">담당자정보</h5>
		
		<!-- table_area -->
		<div class="table_area">
			<table class="write">
				<caption>담당자정보 입력 화면</caption>
				<colgroup>
					<col style="width: 200px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">
						<label for="name">
							<strong class="color_pointr">*</strong> 이름
						</label>
					</th>
					<td>
						<input type="text" name="manager_nm" id="manager_nm" class="in_w30" value="${cmpyDir.manager_nm}" data-parsley-maxlength="30" data-parsley-required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong> 휴대전화
					</th>
					<td>
						<label for="manager_tel_1" class="hidden">휴대전화 앞자리 선택</label>
						<select class="in_wp100" id="manager_tel_1" name="manager_tel_1" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true">
							<option value="" <c:if test="${cmpyDir.manager_tel_1 eq ''}">selected</c:if> >-선택-</option>
							<option value="010" <c:if test="${cmpyDir.manager_tel_1 eq '010'}">selected</c:if> >010</option>
							<option value="011" <c:if test="${cmpyDir.manager_tel_1 eq '011'}">selected</c:if> >011</option>
							<option value="016" <c:if test="${cmpyDir.manager_tel_1 eq '016'}">selected</c:if> >016</option>
							<option value="017" <c:if test="${cmpyDir.manager_tel_1 eq '017'}">selected</c:if> >017</option>
							<option value="018" <c:if test="${cmpyDir.manager_tel_1 eq '018'}">selected</c:if> >018</option>
						</select>
						
						<label for="manager_tel_2" class="hidden">휴대전화 중간자리 입력</label>
						<input type="text" id="manager_tel_2" name="manager_tel_2" class="in_wp100" value="${cmpyDir.manager_tel_2}" maxlength="4" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true"/>
						
						<label for="manager_tel_3" class="hidden">휴대전화 마지막자리 입력</label>
						<input type="text" id="manager_tel_3" name="manager_tel_3" class="in_wp100" value="${cmpyDir.manager_tel_3}" maxlength="4" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true"/>
						<div class="parsely-single-error" id="errMsgManagerTel" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong> 이메일
					</th>
					<td>
						<label for="manager_email_1" class="hidden">이메일 앞주소</label>
						<input type="text" class="in_wp100" id="manager_email_1" name="manager_email_1" value="${cmpyDir.manager_email_1}" data-parsley-maxlength="30" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
						
						<span class="marginr5 marginl5">@</span>
						
						<label for="manager_email_2" class="hidden">이메일 마지막 주소 입력</label>
						<input type="text" class="in_wp100" id="manager_email_2" name="manager_email_2" value="${cmpyDir.manager_email_2}" data-parsley-maxlength="30" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
						
						<label for="email_domain" class="hidden">이메일 마지막 주소 선택</label>
						<select id="email_domain" name="email_domain" onChange="changeEmailDomain()" class="in_wp120">
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
						<div class="parsely-single-error" id="email_error_message"></div>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="departments">
							<strong class="color_pointr">*</strong> 부서
						</label>
					</th>
					<td>
						<input type="text" class="in_w30" name="manager_dept" id="manager_dept" class="in_wp200" value="${cmpyDir.manager_dept}" data-parsley-maxlength="300" data-parsley-required="true" />
					</td>
				</tr>
				<tr>
					<th scope="row">공개여부</th>
					<td>															
						<input type="radio" name="manager_opn_yn" id="manager_opn_yn_y" class="" value="Y" <c:if test="${cmpyDir.manager_opn_yn eq 'Y'}">checked="checked"</c:if> />
						<label for="manager_opn_yn_y" class="marginr10">공개</label>	
						<input type="radio" name="manager_opn_yn" id="manager_opn_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.manager_opn_yn ne 'Y'}">checked="checked"</c:if> />
						<label for="manager_opn_yn_n">비공개</label>
					</td>
				</tr>
				<tr>
					<th scope="row">뉴스레터 수신여부</th>
					<td>
						<input type="radio" name="newsltr_rcv_yn" id="newsltr_rcv_yn_y" class="" value="Y" <c:if test="${cmpyDir.newsltr_rcv_yn eq 'Y'}">checked="checked"</c:if> />
						<label for="newsltr_rcv_yn_y" class="marginr10">예</label>
						<input type="radio" name="newsltr_rcv_yn" id="newsltr_rcv_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.newsltr_rcv_yn ne 'Y'}">checked="checked"</c:if> />
						<label for="newsltr_rcv_yn_n">아니오</label>	
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// table_area -->
		
	</div>
	<!--// division -->
						
	<!-- button_area -->
	<div class="button_area">
		<div class="alignc">
			<button class="btn save" title="생성완료" onclick="javascript:makeCmpyDir()">
				<span>생성완료</span>
			</button>
		</div>
	</div>
	<!--// button_area -->

</form>


