<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" href="/assets/bootstrap-datepicker/css/datepicker.css" />

<script type="text/javascript" src="/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

<script language="javascript">

var insertUserUrl = "<c:url value='/admin/user/insertUser.do'/>";
var updateUserUrl = "<c:url value='/admin/user/updateUser.do'/>"
var deleteUserUrl = "<c:url value='/admin/user/deleteUser.do'/>";
var updatePasswordChangeUrl = "<c:url value='/admin/user/updatePasswordChange.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );
	
});

function userListPage() {
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/admin/user/userListPage.do";
    f.submit();
}

// 사용자 등록
function userInsert(){
	   
	   if( ! ( ( $("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "") || 
		   ( $("#tel_1").val() == "" && $("#tel_2").val() == "" && $("#tel_3").val() == "") ) ){
	       
		   alert("자택전화를 정확히 입력해주십시요");
		   $("#tel_1").focus();
		   return;
	   }
	   
	   if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
		   $("#user_tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
	   } else {
		   $("#user_tel").val("");
	   }
	
	   if($("#mobile_1").val() == "" || $("#mobile_2").val() == "" || $("#mobile_3").val() == ""){
		   alert("휴대전화는 필수 입력사항입니다.");
		   $("#mobile_1").focus();
		   return;
	   } else {
		   $("#user_mobile").val($("#mobile_1").val()+"-"+$("#mobile_2").val()+"-"+$("#mobile_3").val());
	   }
	
	   if($("#email_1").val() == "" || $("#email_2").val() == ""){
		   alert("이메일을 정확히 입력해 주십시요.");
		   $("#email_1").focus();
		   return;
	   } else {
		   $("#user_email").val($("#email_1").val()+"@"+$("#email_2").val());
	   }
	   
	   if($("#post").val() != "" && $("#addr2").val() == ""){
		   alert("주민등록 주소를 정확히 입력해 주십시요.");
		   $("#addr2").focus();
		   return;		   
	   }
	   
	   var url = "";
	   if ( $("#writeFrm").parsley().validate() ){
		   
		   url = insertUserUrl;
		   if($("#mode").val() == "E") url = updateUserUrl; 

		   // 데이터를 등록 처리해준다.
		   $("#writeFrm").ajaxSubmit({
  				success: function(responseText, statusText){
  					alert(responseText.message);
  					if(responseText.success == "true"){
  						userListPage();
  					}	
  				},
  				dataType: "json", 				
  				url: url
  		    });	
		   
	   }
}

// 사용자 삭제
function userDelete(){
    
	   if(!confirm("사용자를 정말 삭제하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: deleteUserUrl,
	           data:{
	           	user_no : $("#user_no").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					userListPage();
				}	
			}
		});
}

// 패스워드 초기화
function pwdInit(){
    
	   if(!confirm("회원의 비밀번호를 정말 초기화하시겠습니까?")) return;
	   
		$.ajax
		({
			type: "POST",
	           url: updatePasswordChangeUrl,
	           data:{
	           	user_no : $("#user_no").val()
	           },
	           dataType: 'json',
			success:function(data){
				alert(data.message);
			}
		});
}

// 이메일 도메인 변경
function changeEmailDomain(){
	   $("#email_2").val($("#email_domain").val());
}

// 주소 설정
function setAddr(roadAddr, jibunAddr, zipNo, admCd){
	$("#post").val(zipNo);
	$("#addr1").val(roadAddr);
	$("#addr2").val("");
	$("#administ_cd").val(admCd);
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
	
	<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
		<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="${param.p_searchtxt}" />
		<input type='hidden' id="p_reg_stadt" name='p_reg_stadt' value="${param.p_reg_stadt}" />
		<input type='hidden' id="p_reg_enddt" name='p_reg_enddt' value="${param.p_reg_enddt}" />
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="user_gb" name='user_gb' value="N" />
	    <input type='hidden' id="user_no" name='user_no' value="${user.user_no}" />
	    <input type='hidden' id="user_nm" name='user_nm' value="${user.user_nm}" />
	    <input type='hidden' id="user_email" name='user_email' value="${user.user_email}" />
	    <input type='hidden' id="user_mobile" name='user_mobile' value="${user.user_mobile}" />
	    <input type='hidden' id="user_tel" name='user_tel' value="${user.user_tel}" />
	    <input type='hidden' id="administ_cd" name='administ_cd' value="${user.administ_cd}" />
	    <input type='hidden' id="auth" name='auth' value="${user.auth}" />
			     
		<!-- write_basic -->
		<div class="table_area">
			<table class="view">
				<caption>상세보기 화면</caption>
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">회원 일련번호</th>
					<td>${user.user_no}</td>
				</tr>
				<tr>
					<th scope="row">이름  <span class="asterisk">*</span></th>
					<td>${user.user_nm}</td>
				</tr>
				<tr>
					<th scope="row">생년월일  <span class="asterisk">*</span></th>
					<td>${user.birth_dt} (<g:select id="gender" name="gender" codeGroup="USER_GENDER" selected="${user.gender}" cls="form-control input-sm in_wp40" onChange="search()" />)</td>
				</tr>
				<tr>
					<th scope="row">아이디  <span class="asterisk">*</span></th>
					<td>${user.user_id}</td>
				</tr>	
				<tr>
					<th scope="row">비밀번호초기화</th>
					<td>
						<a href="javascript:pwdInit();" class="btn look" title="비밀번호초기화">
							<span>비밀번호초기화</span>
						</a>
					</td>
				</tr>																				
				<tr>
					<th scope="row">자택전화</th>
					<td>
						<select id='tel_1' name='tel_1' title='자택전화 첫번째자리' class="in_wp70">
							<option value='' >선택</option>
					    	<option value='02' <c:if test="${user.tel_1 == '02'}">selected</c:if>>02</option>
							<option value='051' <c:if test="${user.tel_1 == '051'}">selected</c:if>>051</option>
							<option value='053' <c:if test="${user.tel_1 == '053'}">selected</c:if>>053</option>
							<option value='032' <c:if test="${user.tel_1 == '032'}">selected</c:if>>032</option>
							<option value='062' <c:if test="${user.tel_1 == '062'}">selected</c:if>>062</option>
							<option value='042' <c:if test="${user.tel_1 == '042'}">selected</c:if>>042</option>
							<option value='052' <c:if test="${user.tel_1 == '052'}">selected</c:if>>052</option>
							<option value='044' <c:if test="${user.tel_1 == '044'}">selected</c:if>>044</option>
							<option value='031' <c:if test="${user.tel_1 == '031'}">selected</c:if>>031</option>
							<option value='033' <c:if test="${user.tel_1 == '033'}">selected</c:if>>033</option>
							<option value='043' <c:if test="${user.tel_1 == '043'}">selected</c:if>>043</option>
							<option value='041' <c:if test="${user.tel_1 == '041'}">selected</c:if>>041</option>
							<option value='063' <c:if test="${user.tel_1 == '063'}">selected</c:if>>063</option>
							<option value='061' <c:if test="${user.tel_1 == '061'}">selected</c:if>>061</option>
							<option value='054' <c:if test="${user.tel_1 == '054'}">selected</c:if>>054</option>
							<option value='055' <c:if test="${user.tel_1 == '055'}">selected</c:if>>055</option>
							<option value='064' <c:if test="${user.tel_1 == '064'}">selected</c:if>>064</option>
							<option value='070' <c:if test="${user.tel_1 == '070'}">selected</c:if>>070</option>
						</select>
                        - <input id="tel_2" name="tel_2" type="text" value="${user.tel_2}" class="in_wp40 onlynum" maxlength="4" />
                        - <input id="tel_3" name="tel_3" type="text" value="${user.tel_3}" class="in_wp40 onlynum" maxlength="4" />
					</td>
				</tr>
				<tr>
					<th scope="row">휴대전화  <span class="asterisk">*</span></th>
					<td>
					    <select id='mobile_1' name='mobile_1' title='휴대폰번호 첫번째자리' class="in_wp70">
							<option value='010' <c:if test="${user.mobile_1 == '010'}">selected</c:if>>010</option>
							<option value='011' <c:if test="${user.mobile_1 == '011'}">selected</c:if>>011</option>
							<option value='016' <c:if test="${user.mobile_1 == '016'}">selected</c:if>>016</option>
							<option value='017' <c:if test="${user.mobile_1 == '017'}">selected</c:if>>017</option>
							<option value='018' <c:if test="${user.mobile_1 == '018'}">selected</c:if>>018</option>
							<option value='019' <c:if test="${user.mobile_1 == '019'}">selected</c:if>>019</option>
					    </select>
				       - <input id="mobile_2" name="mobile_2" type="text" value="${user.mobile_2}" class="in_wp40 onlynum" maxlength="4" />
                          - <input id="mobile_3" name="mobile_3" type="text" value="${user.mobile_3}" class="in_wp40 onlynum" maxlength="4" />
					</td>
				</tr>
				<tr>
					<th scope="row">이메일  <span class="asterisk">*</span></th>
					<td>
					   	<input id="email_1" name="email_1" type="text" value="${user.email_1}" class="in_wp80" />@
					   	<input id="email_2" name="email_2" type="text" value="${user.email_2}" class="in_wp100" />
						<select id='email_domain' name='email_domain' title='이메일주소선택' class="in_wp80" onChange="changeEmailDomain()">
							<option value="self">직접입력</option>
							<option value="daum.net">한메일</option>
							<option value="naver.com">네이버</option>
							<option value="nate.com">네이트</option>
							<option value="gmail.com">구글</option>
							<option value="yahoo.co.kr">야후</option>
							<option value="lycos.co.kr">라이코스</option>
							<option value="hotmail.com">핫메일</option>
							<option value="paran.com">파란</option>
						</select>				
					</td>
				</tr>	
				<tr>
					<th scope="row">주민등록주소</th>
					<td>
						<input id="post" name="post" type="text" value="${user.post}" placeholder="우편번호" class="in_wp70"  />	
						<a href="javascript:jusoPopupShow();" class="btn look" title="주소찾기">
							<span>주소찾기</span>
						</a>
						</br>
						<input id="addr1" name="addr1" type="text" value="${user.addr1}" placeholder="기본주소"  class="in_w50" style="margin-top:5px" data-parsley-required="true"  readOnly /></br>	
						<input id="addr2" name="addr2" type="text" value="${user.addr2}" placeholder="상세주소" class="in_w50" style="margin-top:5px" data-parsley-required="true" data-parsley-maxlength="200" />	
					</td>
				</tr>	
				<tr>
					<th scope="row">약관동의일</th>
					<td>${user.agree_dt}</td>
				</tr>						
				<tr>
					<th scope="row">가입일</th>
					<td>${user.reg_date}</td>
				</tr>											
				</tbody>
			</table>
		</div>
		<!--// write_basic -->
			
		<!-- button_area -->
		<div class="button_area">
			<div class="float_right">
				<a href="javascript:userInsert('M');" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:userListPage();" class="btn cancel" title="취소">
					<span>취소</span>
				</a>
			</div>
		</div>
		<!--// button_area -->
		
	</form>
	
</div>
<!--// content -->

 <jsp:include page="/WEB-INF/jsp/admin/common/jusoSearchPopup.jsp"/>