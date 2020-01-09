<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />
<link rel="stylesheet" type="text/css" href="/assets/bootstrap-datepicker/css/datepicker.css" />

<script type="text/javascript" src="/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

<script language="javascript">

var insertUserUrl = "<c:url value='/admin/user/insertUser.do'/>";
var updateUserUrl = "<c:url value='/admin/user/updateUser.do'/>"
var deleteUserUrl = "<c:url value='/admin/user/deleteUser.do'/>";
var userIdCheckUrl = "<c:url value='/admin/user/userIdCheck.do'/>";
var updatePasswordChangeUrl = "<c:url value='/admin/user/updatePasswordChange.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );	
});


// 사용자 리스트 조회
function userListPage() {
    
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/admin/user/managerListPage.do";
    f.submit();
}


// 사용자 추가
function userInsert(){ 
    
	var url = "";
	if ( $("#writeFrm").parsley().validate() ){

	<c:if test="${param.mode == 'W'}">
		
		var userId = $("#user_id").val(); 
		
		if(userId == "" || !(userId.length >= 5 &&  userId.length <= 15)){
			alert("아이디는 최소 5자 ~ 최대 15자 영문,숫자만 사용 가능합니다. ");
		  	return;
		}
		
		if($("#id_chk_yn").val() == "N" || userId != $("#checked_id").val()){
		   	alert("아이디 중복확인을 해주십시요.");
		   	return;
		}
		  
		var userPw = $("#user_pw").val();	
		if(userPw == ""){
		 	alert("패스워드를 입력해주십시요.");
		 	return;
		}   
		
		if(!checkPass(userPw)) {
		    return;
		}
		
	</c:if>
	     
		if(!(($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "") || 
			($("#tel_1").val() == "" && $("#tel_2").val() == "" && $("#tel_3").val() == ""))){
		    
			alert("내선번호를 정확히 입력해주십시요");
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
	   
	   	if ($('#managerAuth option').size() < 1){
		   	alert("권한을 선택해 주십시요.");
		   	return;
	   	} 		   
		   
	   	url = insertUserUrl;
	   	if($("#mode").val() == "E") {
	   	    url = updateUserUrl; 
	   	}
	   
		var authArr = new Array();
		if ($('#managerAuth option').size() > 0) {
			for (var i = 0; i < $('#managerAuth option').size(); i++){
				authArr.push($('#managerAuth option:eq('+i+')').val());
			}
		}
		   
	   // 데이터를 등록 처리해준다.
	   $("#writeFrm").ajaxSubmit({
			success: function(
				responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						userListPage();
					}	
 				},
 				dataType: "json",
 				data : {
 					 manager_auth : JSON.stringify(authArr)
 				},
 				url: url
		});	
			   
	}
}

// 관리자 삭제
function userDelete(){
    
	if(!confirm("관리자를 정말 삭제하시겠습니까?")) return;
	   
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


// 비밀번호 초기화
function pwdInit(){
    
   if(!confirm("관리자의 비밀번호를 정말 초기화하시겠습니까?")) return;
   
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


// 아이디 체크
function idValidate(){
    
	var userId = $("#user_id").val(); 
	if(userId == "" || !(userId.length >= 5 &&  userId.length <= 15) || onOnlyAlphaNumber(userId)){
		alert("아이디는 최소 5자 ~ 최대 15자 영문,숫자만 사용 가능합니다. ");
		return;
	}
	 
	 $.ajax
	 ({
		type: "POST",
           url: userIdCheckUrl,
           data:{
           	user_id : userId
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				$("#id_chk_yn").val("Y"); 
				$("#checked_id").val(userId); 
			}
		}
	});
	 
}


// 권한 추가
function addAuth(){
    
	if($('#authList option').index($('#authList option:selected')) < 0){
		alert("추가할 권한을 선택해 주세요.");
		return;
	}
	
	var map = new Map();
	var options = $('#managerAuth option');
	for(var i =0; i < options.length;i++){
		map.put(options.eq(i).val(), "");
	}
	
	var sellist = $('#authList option:selected');
	for(var i =0; i < sellist.length; i++){
		if (map.containsKey(sellist[i].value)){
			alert('이미 설정된 권한입니다.');
			return;
		}else{
			selectbox_insert(document.getElementById('managerAuth'), sellist[i].text, sellist[i].value, false);
		}
	}
}


// 권한 삭제
function delAuth(){
    
	if($("#managerAuth option").index($("#managerAuth option:selected")) < 0){
		 alert("삭제할 권한을 선택해 주세요.");
		 return;
	}

	$("#managerAuth option:selected").each(function () {
		$("#managerAuth").children("[value='"+$(this).val()+"']").remove();
	});  
	
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
		<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
		<input type='hidden' id="p_reg_stadt" name='p_reg_stadt' value="${param.p_reg_stadt}" />
		<input type='hidden' id="p_reg_enddt" name='p_reg_enddt' value="${param.p_reg_enddt}" />
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="user_gb" name='user_gb' value="M" />
	    <input type='hidden' id="user_no" name='user_no' value="${user.user_no}" />
	    <input type='hidden' id="user_email" name='user_email' value="${user.user_email}" />
	    <input type='hidden' id="user_mobile" name='user_mobile' value="${user.user_mobile}" />
	    <input type='hidden' id="administ_cd" name='administ_cd' value="${user.administ_cd}" />
	    <input type='hidden' id="user_tel" name='user_tel' value="${user.user_tel}" />
		<input type='hidden' id="gender" name='gender' value="M" />
			     
		<!-- write_basic -->
		<div class="table_area">
			  <table class="view">
			  
				<caption>상세보기 화면</caption>
				
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				
					<c:if test="${param.mode == 'E' }">
                    <tr>
						<th scope="row">등록자</th>
						<td>${user.reg_usernm}</td>
						<th scope="row">등록일</th>
						<td>${user.reg_date}</td>
					</tr>
					<tr>
						<th scope="row">회원 일련번호</th>
						<td colspan="3">${user.user_no}</td>
					</tr>
					</c:if>
					
					<tr>
						<th scope="row">이름  <span class="asterisk">*</span></th>
						<td colspan="3">
						    <input class="form-control in_w20" type="text" id="user_nm" name="user_nm" value="${user.user_nm}" placeholder="이름" data-parsley-required="true" data-parsley-maxlength="30" />
						    <!-- 
						    <c:if test="${param.mode != 'E' }">
						    <input class="form-control in_w20" type="text" id="user_nm" name="user_nm" value="${user.user_nm}" placeholder="이름" data-parsley-required="true" data-parsley-maxlength="30" />
						    </c:if>
						    <c:if test="${param.mode == 'E' }">
						       ${user.user_nm}
						       <input type="hidden" id="user_nm" name="user_nm" value="${user.user_nm}" />
						    </c:if>
						     -->
						</td>
					</tr>
					
					<tr>
						<th scope="row">아이디  <span class="asterisk">*</span></th>
						<td colspan="3">
							<c:if test="${param.mode != 'E' }">
							    <input class="form-control in_w20" type="text" id="user_id" name="user_id" value="${user.user_id}" data-parsley-required="true" data-parsley-errors-container="#id_error_message" placeholder="아이디"  />
							    <input type="hidden" id="id_chk_yn" name="id_chk_yn"  value="N" />
							    <input type="hidden" id="checked_id" name="checked_id"  value="" />
							    <a href="javascript:idValidate();" class="btn look" title="중복확인">
									<span>중복확인</span>
								</a>
								<div id="id_error_message"></div> 
								* 최소 5자 ~ 최대 15자 영문,숫자만 사용 가능합니다.	
							</c:if>
							<c:if test="${param.mode == 'E' }">
						       ${user.user_id}
						       <input type="hidden" id="user_id" name="user_id" value="${user.user_id}" />
						    </c:if>
						</td>
					</tr>
					
					<c:if test="${param.mode == 'W' }">		
					<tr>
						<th scope="row">패스워드  <span class="asterisk">*</span></th>
						<td colspan="3">
						    <input class="form-control in_w20" type="password" id="user_pw" name="user_pw" value="" placeholder="패스워드" data-parsley-required="true" data-parsley-maxlength="30" data-parsley-errors-container="#pwd_error_message" />
                            <div id="pwd_error_message">
                            </div>							
							<p class="color_point margint10">* 10~15자의 영문소문자와 대문자, 숫자, 특수문자를 혼용하여 사용 가능합니다.</p>
							<p class="color_point margint2">특수문자는 `~`,`!`,`@`,`#`,`$`,`*`,`(`,`)`,`=`,`_`,`.`,`|` 만 사용 가능합니다.</p>
							<p class="color_point margint2">영문소문자와 대문자, 숫자,특수문자 중 2가지 이상 문자 조합하여 사용하시기 바랍니다.</p>
						</td>
					</tr>	
					</c:if>
					
					<!-- SMS를 사용할 경우 비밀번호 초기화를 활성화
					<c:if test="${param.mode == 'E' }">					
					<tr>
						<th scope="row">비밀번호초기화</th>
						<td colspan="3">
							<a href="javascript:pwdInit();" class="btn look" title="비밀번호초기화">
								<span>비밀번호초기화</span>
							</a>
						</td>
					</tr>
					</c:if>
					 -->
					 
					<c:if test="${param.mode == 'E' }">					
					<tr>
						<th scope="row">비밀번호변경</th>
						<td colspan="3">
							<a href="javascript:pwPopupShow();" class="btn look" title="비밀번호 변경">
								<span>비밀번호 변경</span>
							</a>
						</td>
					</tr>
					</c:if>
					 																												
					<tr>
						<th scope="row">내선전화</th>
						<td colspan="3">
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
						<td colspan="3">
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
						<td colspan="3">
							<input id="email_1" name="email_1" type="text" value="${user.email_1}" class="in_wp80"  data-parsley-maxlength="30" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />@
							<input id="email_2" name="email_2" type="text" value="${user.email_2}" class="in_wp100" data-parsley-maxlength="30"  />
							<select id='email_domain' name='email_domain' title='이메일주소선택' class="in_wp80" onChange="changeEmailDomain()">
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
							<div id="email_error_message"></div>		
						</td>
					</tr>	
					
					<tr>
						<th scope="row">부서</th>
						<td colspan="3">
							<input class="form-control in_w20" type="text" id="dept" name="dept" value="${user.dept}" placeholder="부서" data-parsley-required="false" data-parsley-maxlength="100" />
						</td>
					</tr>	
					
					<tr>
						<th scope="row">권한</th>
						<td colspan="3">
							<div class="pull-left m-r-5">
								<select id="authList" name="authList" class="in_wp200" style="height:100px;margin-bottom:10px;margin-right:10px"multiple="multiple">
									<c:forEach var="row" items="${authList}">
									<option value="${row.code}">${row.codenm}</option>
									</c:forEach>	
								</select>
								</br>
								<select id="managerAuth" name="managerAuth" class="in_wp200" style="height:100px" multiple="multiple">
									<c:forEach var="row" items="${managerAuthList}">
									<option value="${row.auth_Id}">${row.auth_nm}</option>
									</c:forEach>	
								</select>
							</div>
							<div class="pull-left">
								<a href="javascript:addAuth();" class="btn look" title="추가">
									<span>추가</span>
								</a>
								<a href="javascript:delAuth();" class="btn look" title="삭제">
									<span>삭제</span>
								</a>
							</div>
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
		<!--// write_basic -->
			
		<!-- button_area -->
		<div class="button_area">
			<div class="float_right">
			
		        <c:if test="${param.mode == 'W'}">
				<a href="javascript:userInsert('W');" class="btn save" title="등록">
					<span>등록</span>
				</a>
               </c:if>
               
               <c:if test="${param.mode == 'E' }">
				<a href="javascript:userInsert('M');" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:userDelete();" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
				</c:if>
				
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
<jsp:include page="/WEB-INF/jsp/admin/user/pwdChangePopup.jsp"/>