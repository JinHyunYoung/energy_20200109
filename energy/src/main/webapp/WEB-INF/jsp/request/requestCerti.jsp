<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
});

function authTunnel(data,type){
	$("#user_nm").val(data['name']);
	$("#gender").val(data['gender']);
	$("#birth").val(data['birth']);

	if(type=="phone"){
		$("#phone").val(data['phone']);
	}	
	
	$("#user_ci").val(data['di']);
	document.requestFrm.action = "<c:url value='/web/request/requestWrite.do'/>";
	document.requestFrm.submit();
}

window.name ="master_window";
function openAuth(url,type){

	if(type == 'ipin'){
		var url = "<c:url value = '/web/common/ipin.do'/>";
		var win = window.open(null,"ipin", 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	 }else{
		var url = "<c:url value = '/web/common/phone.do'/>";
		var win = window.open(url, 'checkPlus', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	}
	win.document.write('<iframe width="100%" height="100%" src="'+url+'" frameborder="0"></iframe>');
}

function requestWrite(reqGb){
    $("#req_gb").val(reqGb);
	if(reqGb == "A"){
		$("#certi_div").show();
	}else{
		document.requestFrm.action = "<c:url value='/web/request/requestWrite.do'/>";
		document.requestFrm.submit();	
	}
    
}
</script>

<form id="requestFrm" name="requestFrm" method="post" class="ajaxfrm">
<input type="hidden" id="req_gb" name="req_gb" value="" />
<input type="hidden" id="user_nm" name="user_nm" value="" />
<input type="hidden" id="birth" name="birth" value="" />
<input type="hidden" id="gender" name="gender" value="" />
<input type="hidden" id="phone" name="phone" value="" />
<input type="hidden" id="user_ci" name="user_ci" value="" />

	   <center class="con_img2"><img src="../../../images/sub/civil/agree1.png" alt="본인인증"></center>

			<div class="border_div2 margint10">
				한국에너지재단은 홈페이지를 통해 재단 임직원의 비리행위, 재단 사업과 관련된 애로사항, 공익침해 신고행위 등을 청취하기 위해 사이버 
				신문고를 운영하고 있습니다. 보내주신 민원사항은 비밀이 철저히 보장되며, 접수된 내용을 최대한 신속하고 공정하게 처리하여 결과를 알려 드리도록 하겠습니다.<br>
		(성희롱 고충상담, 갑질, 인권, 윤리경영, 부정청탁, 채용비리 등 상담은 본 게시판을 활용하여 주시기 바랍니다.)
			</div>
		
			<div class="button_area">
				<!-- <a href="javascript:requestWrite('A')" title="외부 민원인용" class="bg80bb60" target="_self">외부 민원인용</a> -->
				<a href="javascript:requestWrite('B')" title="등록" class="bg239fd3" target="_self">등록</a>
			</div>
			
        <div id="certi_div" style="display:none">
		<center class="alert_txt2 margint50">
			사이버 신문고를 접수하기 위해 본인 실명인증 절차가 필요합니다.<BR /><BR />

			원하시는 실명인증 절차를 선택해 주시기 바랍니다.
		</center>

		<ul class="imp03_01area">
			<li>
				<ul>
					<li><img src="../../../images/icon/phone_icon.png" alt="핸드폰 이미지"></li>
					<li>
						<div class="title_txt">휴대전화 인증</div>
						<div class="comment_txt">
							휴대폰 인증으로 본인 확인을 합니다. <BR />
							본인인증을 위해 입력하신 정보는 본인인증 외 다른
							용도로 이용되지 않습니다.
						</div>

						<div class="area_bt">
							<a href="javascript:openAuth('','phone');" title="휴대폰으로 인증하기" target="_self">휴대폰으로 인증하기</a>
						</div>

					</li>
				</ul>
			</li>
			<li>
				<ul>
					<li><img src="../../../images/icon/ipin_icon.png" alt="아이핀 이미지"></li>
					<li>
						<div class="title_txt">아이핀(i-PIN) 인증</div>
						<div class="comment_txt">
							아이핀은 이용자의 개인정보 보호를 위해 주민등록
							번호를 제공하지 않고 실명인증 업체로부터 본인임을 
							확인 받을 수 있는 인터넷상 개인 식별 번호입니다.
						</div>

						<div class="area_bt">
							<a href="javascript:openAuth('','ipin');" title="아이핀으로 인증하기" target="_self">아이핀으로 인증하기</a>
						</div>
					</li>
				</ul>
			</li>
		</ul>	
		</div>						
</form>
