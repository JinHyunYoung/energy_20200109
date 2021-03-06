<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link rel="stylesheet" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/js/jquery.sh-file-input-image.js"></script>

<script language="javascript">

var insertRequestUrl = '<c:url value="/web/request/insertRequest.do" />';

$( document ).ready( function(){
	
	if("${param.req_gb}" == ""){
		alert("잘못된 경로로 접근을 하였습니다.");
		document.location ="/web/request/requestCerti.do";
	}
	
	$(".onlynum").keyup( setNumberOnly );
	
});

function requestInsert(){
	
	if( ! $( '#agree1-1' ).get(0).checked ){
		alert( '약관과 개인정보의 수집 및 이용목적에 동의해 주셔야 합니다.' );
		$( '#agree1-1' ).focus();
		return;		
	}
	
	<c:if test="${param.req_gb == 'A'}">
	if($('#user_nm' ).val() == ""){
		alert( '이름은 필수 입력사항입니다' );
		$( '#user_nm' ).focus();
		return;		
	}
	</c:if>
	
	$("#email").val($("#email_1").val()+"@"+$("#email_2").val());
    if($("#email_1").val() == "" || $("#email_2").val() == ""){
 	   alert("email은 필수 입력사항입니다.");
	   $("#email_1").focus();
	   return;		   
    }else if(!isEmail($("#email").val())){
    	alert("Email 형식이 올바르지 않습니다.");
    	return;
    }
	
	<c:if test="${param.req_gb == 'B'}">
	   $('#user_nm' ).val("익명");
	</c:if>
	
	if($("#tel1").val() != "" || $("#tel2").val() != "" || $("#tel3").val() != ""){
    	if($("#tel1").val() == "" || $("#tel2").val() == "" || $("#tel3").val() == ""){
	    	alert("연락처를 정확히 입력해 주십시요.");
	 	    $("#tel1").focus();
		    return;		   
    	}else $("#handphone").val($("#tel1").val()+"-"+$("#tel2").val()+"-"+$("#tel3").val());    
    }
    
	if($('#title' ).val() == ""){
		alert( '제목은 필수 입력사항입니다' );
		$( '#title' ).focus();
		return;		
	}

	if($( '#contents' ).val() == ""){
		alert( '내용은 필수 입력사항입니다' );
		$( '#contents' ).focus();
		return;		
	}

    if ($("#uploadFile1").val() != "" && !$("#uploadFile1").val().toLowerCase().match(/\.(jpg|png|gif|ppt|pptx|xls|xlsx|doc|docx|hwp|txt|pdf|zip)$/)){
	   alert("확장자가 jpg,png,gif,ppt,pptx,xls,xlsx,doc,docx,hwp,txt,pdf,zip 파일만 업로드가 가능합니다.");
	   return;
    }  
   
   if ( $("#requestFrm").parsley().validate() ){	   
		// 데이터를 등록 처리해준다.
		$("#requestFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					document.requestFrm.action = "<c:url value='/web/request/requestComplete.do'/>";
					document.requestFrm.submit();
				}	
			},
			dataType: "json",
			url: insertRequestUrl
	    });	
   }	

}

function requestCancel(){
	document.location = "/web/request/requestInfo.do";
}

function changeEmailDomain(){
	$("#email_2").val($("#email_domain").val());
}
</script>

<form id="requestFrm" name="requestFrm" method="post" enctype="multipart/form-data" data-parsley-validate="true" onSubmit="return false">
<input type="hidden" id="req_gb" name="req_gb" value="${param.req_gb}" />
<input type="hidden" id="user_ci" name="user_ci" value="${param.user_ci}" />
<input type="hidden" id="email" name="email" value="" />
<input type="hidden" id="handphone" name="handphone" value="" />
		
		<center class="con_img2"><img src="../../../images/sub/civil/agree2.png" alt="본인인증"></center>
							
							<div class="alert_txt bold margint40">이용약관</div>
							<div class="border_div2 margint10">
								<textarea class="agree_textarea" style="width:100%;height:200px" readOnly>제 1장 일반사항

제 1 조 (목적)
이 약관은 한국에너지재단(이하 "재단")이 제공하는 “사이버신문고”의 온라인 서비스의 등록 및 이용에 관한 기본적인 사항을 규정함을 그 목적으로 합니다.

제 2 조 (약관의 효력 및 변경)
1. 이 약관의 내용은 서비스 화면에 게시하거나 기타의 방법으로 회원에게 공지함으로써 효력을 발생합니다.
2. 재단은 합당한 사유가 발생할 경우에는 이 약관을 변경할 수 있고, 변경된 약관은 홈페이지 내에 공지하며, 공지와 동시에 그 효력이 발생됩니다.

제 3 조 (약관 외 준칙)

1. 본 약관에 명시되지 않은 사항은 정보통신윤리위원회 심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다. 

제 4 조 (용어의 정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1. 사용자 : 사이버신문고 글쓰기 양식에 해당 정보를 기입하고, 본 약관에 동의하여 글을 게시한 자를 말함
2. 비밀번호 : 사용자가 게시한 글이 맞는지 확인하고 통신상의 자신의 비밀보호를 
위하여 이용자 자신이 선정한 문자와 숫자의 조합을 말함


제 2 장   사용자 등록 신청과 승인
제 5 조 (사용자등록)
“동의함” 의 물음에 신청자가 클릭 하시어 게시글 등록을 신청하면 사용자 등록이 되는 것으로 합니다. 

제 6 조 (게시글 등록)
등록 하고자 하는 내용은 관리자의 승인절차를 통하여 한국에너지재단의 고객센터 DateBase에 등록됩니다. 

제 7 조 (등록신청의 승인) 
재단은 신청자가 제6조에서 정한 모든 사항을 정확히 기재하여 신청을 하였을 때 승인합니다. 

제 8 조 (등록사항의 변경) 
회원은 등록 신청시 기재한 사항이 변경되었을 경우에는 해당 게시판 담당자를 통하여 변경하여야 합니다. 





제 3 장  고객센터의 이용 및 정보제공 

제 9 조 (재단의 의무) 
1. 재단은 사용자의 개인신상 정보를 본인의 승낙없이 타인이게 누설, 배포하지 않습니다.  
다만, 관계법령에 의하여 관계 국가기관 등의 요구가 있는 
경우에는 그리하지 아니합니다. 

제 10 조 (사용자의 의무)
1. 게시글 등록 시에 요구되는 정보는 정확하게 기입하여야 합니다. 비밀번호에 
관한 모든 관리책임은 본인에게 있습니다. 비밀번호의 관리 
소홀, 부정 사용에 의하여 발생하는 모든 결과에 대한 책임은 사용자에게 있습니다. 
비밀번호가 부정하게 사용된 경우는 반드시 재단에 그 사실을 통보해야 
합니다. 


제 4 장   기 타 

제 11 조 (등록취소 및 이용제한) 
회원이 등록을 취소하고자 하는 때에는 회원 본인이 게시판 담당자를 통해 
게시글 등록취소를 하여야 합니다. 재단은 사용자가 다음 각 호에 해당하는 행위를 하였을 경우
사전 통지 없이 등록을 취소하거나 또는 기간을 정하여 서비스 이용을 중지할 수 있습니다.
1) 타인의 비밀번호를 도용한 경우 
2) 서비스 운영을 고의로 방해한 경우 
3) 가입한 이름이 실명이 아닌 경우 
4) 같은 사용자가 다른 이름, 별명으로 이중등록을 한 경우 
5) 공공질서 및 미풍양속에 저해되는 내용을 고의로 유포시킨 경우 
6) 회원이 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 
실행하는 경우 
7) 타인의 명예를 손상시키거나 불이익을 주는 행위를 한 경우 
8) 기타 재단이 정한 등록 및 이용조건에 위반한 경우 


제 5 장   손해배상 등  

제 12 조 (손해배상) 
재단은 서비스 이용과 관련하여 회원에게 발생한 어떠한 손해에 관하여도 책임을 지지 않습니다. 

제 13 조 (면책조항) 
1. 재단은 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다. 
2. 재단은 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다. 
3. 재단은 회원이 서비스를 이용하여 제공한 정보로 인하여 기대되는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다. 

4. 재단은 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을 지지  않습니다. 

제 14 조 (관할법원) 
서비스 이용으로 발생한 분쟁에 대해 소송이 제기될 경우 재단의 본사 소재지를 관할하는 법원을 관할법원으로 합니다. 


[부 칙] 

(시행일) 이 약관은 2017년 11월 1일부터 시행합니다.</textarea>
							</div>
							
														
							<div class="alert_txt bold margint40">개인정보 수집 및 이용</div>
							<div class="border_div2 margint10">
								<textarea class="agree_textarea" style="width:100%;height:200px" readOnly>한국에너지재단(이하 “재단”이라 함) 홈페이지에서 수집하게 될 개인정보는 [개인정보보호법] 제15조에 따라 개인정보의 수집,이용 시 본인의 동의를 얻어야 하는 정보입니다. 이에 재단은 아래 내용과 같이 개인정보를 수집·이용하고자 합니다. 홈페이지 이용자는 동의를 거부할 수 있습니다. 

다만, 이 경우 제공 서비스에 제한이 있을 수 있습니다.


[개인정보의 처리 목적]

재단은 사이버신문고 운영을 위해 개인정보를 수집,이용합니다. 수집된 개인정보는 정해진 목적 이외의 용도로는 이용되지 않으며, 수집 목적 등이 변경될 경우에는 이용자에게 알리고 동의를 받을 예정입니다.


[수집하는 개인정보의 항목]

가. 재단은 필요한 최소한의 개인정보를 수집하며, 이에 대한 동의를 얻고 있습니다. 수집하는 개인정보 항목은 다음과 같습니다.

&lt일반 게시등록&gt
 - 필수항목 : 비밀번호, 이메일
 - 선택항목 : 연락처


[개인정보 수집 및 이용 목적]

재단은 다음과 같은 이유로 개인정보를 수집합니다. 

가. 민원처리
 - 사이버신문고 등 민원 처리 및 답변 제공
 - 게시글 답변 전달 및 민원처리

나. 기타 원활한 양질의 서비스 제공 

[개인정보 보유 및 이용기간]

정보주체 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 
단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
가. 보존근거 : 서비스 정보 제공
나. 보존기간 : 답변통보일로부터 5년

[동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익]

게시글 등록 시 개인정보 수집 동의를 거부하실 수 있으며, 동의를 거부하실 경우 서비스 이용이 불가능함을 알려 드립니다.</textarea>
							</div>
							
							<div class="alignr margint10">
								<input type="radio" name="agree1" id="agree1-1"> <label for="agree1-1">동의함</label>　
								<input type="radio" name="agree1" id="agree1-2" checked> <label for="agree1-2">동의하지 않음</label>	
							</div>





							<div class="alert_txt bold margint40">
								* 필수입력사항
							</div>

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

							<tr style="display:<c:if test="${param.req_gb == 'B'}">none</c:if>">
								<td class="title_td"><label for="user_nm">이름<span class="color_cd5500">*</span></label></td>
								<td colspan="3">
									<input type="text" name="user_nm" class="in_w20" id="user_nm" value="${param.user_nm}" maxlength="20">
								</td>
							</tr>

							

							<tr>
								<td class="title_td"><label for="title">제목<span class="color_cd5500">*</span></label></td>
								<td colspan="3">
									<input type="text" name="title" class="in_w100" id="title" data-parsley-required="true" data-parsley-maxlength="100">
								</td>
							</tr>

							<tr>
								<td class="title_td"><label for="contents">내용<span class="color_cd5500">*</span></label></td>
								<td colspan="3">
									<textarea name="contents" id="contents" class="in_w100" style="height: 200px;" data-parsley-required="true" ></textarea>
								</td>
							</tr>

							<tr>
								<td class="title_td">연락처</td>
								<td colspan="3">
									<select name="tel1" id="tel1" class="in_wp80">
									    <option value=''>- 선택 -</option>
										<option value='010'>010</option>
										<option value='011'>011</option>
										<option value='016'>016</option>
										<option value='017'>017</option>
										<option value='018'>018</option>
										<option value='019'>019</option>
									</select>
									<label for="tel1" class="hidden">전화번호 천번째 자리</label>
									-
									<input type="text" name="tel2" class="in_wp70 onlynum" id="tel2" maxlength="4" >
									<label for="tel2" class="hidden">전화번호 가운데 자리</label>
									-
									<input type="text" name="tel3" class="in_wp70 onlynum" id="tel3" maxlength="4" >
									<label for="tel3" class="hidden">전화번호 마지막 자리</label>
								</td>
							</tr>
							<tr>
								<td class="title_td"><label for="email_1">이메일<span class="color_cd5500">*</span></label></td>
								<td colspan="3">
									<input type="text" name="email_1" class="in_wp100" id="email_1">
									@
									<input type="text" name="email_2" class="in_wp140" id="email_2">
									<label for="email_2" class="hidden">이메일 뒷정보</label>
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
									* 이메일을 통해 답변이 회신됩니다.
								</td>
							</tr>
							<tr>
								<td class="title_td"><label for="input11">첨부파일</label></td>
								<td colspan="3">
				   			        <label for="uploadFile1" class="hidden">파일 선택하기</label>
									<input class="in_w60 marginb10" type="file" id="uploadFile1" name="uploadFile1" value="" data-parsley-required="false" data-parsley-maxlength="100" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>	

				<div class="button_area">
					<a href="javascript:requestInsert()" style="background: #bea214;" title="확인" target="_self">확인</a>
			        <a href="javascript:requestCancel()" title="취소" target="_self">취소</a>
				</div>
</form>
