<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
});

function requestWrite(reqGb){
	var url = "<c:url value='/web/request/requestWrite.do'/>"
	if(reqGb == "A") url = "<c:url value='/web/request/requestCerti.do'/>"
	document.requestFrm.action = url;
	document.requestFrm.submit();	
}

</script>

<form id="requestFrm" name="requestFrm" method="post" class="ajaxfrm">
<input type="hidden" id="req_gb" name="req_gb" value="B" /> 

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

</form>
