<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/js/directory.js"></script>
	
<script language="javascript">

$( document ).ready( function(){
	
});	

//기업디렉토리 상세보기 로 이동
function goCmpyDir(){
    
    var f = document.cmpyDirApprovalForm;
   
    f.target = "_self";
    f.action = "/web/directory/cmpyDirView.do";
    f.submit();
	
}

function goMain(){
    
    var f = document.cmpyDirApprovalForm;
   
    f.target = "_self";
    f.action = "/web/user/main.do";
    f.submit();	
}

</script>

<form id="cmpyDirApprovalForm" name="cmpyDirApprovalForm" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
	<input type='hidden' id="myDirectory" name='myDirectory' value="${param.myDirectory}" /> 
	
		<!-- approval_area -->
		<div class="approval_area">
			<p class="approval_company">
				<strong>${param.cmpy_nm}</strong>
			</p>
			
			<c:if test="${param.app_stt_cd == '1'}">
			<p class="approval_txt">기업 디렉토리 생성이 승인 대기 중입니다.</p>
			</c:if>
			
			<c:if test="${param.app_stt_cd == '2'}">
			<p class="approval_txt">기업 디렉토리 생성이 승인완료 되었습니다.</p>
			</c:if>
			
			<c:if test="${param.app_stt_cd == '3'}">
			<p class="approval_txt">기업 디렉토리 생성이 반려 되었습니다.</p>
			<p class="approval_txt">반려 사유 : ${param.rjt_rsn}</p>
			</c:if>
		</div>
		<!--// approval_area -->
		
        <!-- button_area -->
        <div class="button_area">
        	<div class="alignc">
        		<button class="btn save" title="메인으로" onClick="javascript:goMain()">
        			<span>메인으로</span>
        		</button>
        		<c:if test="${param.app_stt_cd == '2'}">
        		<button class="btn list" title="마이 기업디렉토리" onClick="javascript:goCmpyDir()">
        			<span>마이 기업디렉토리</span>
        		</button>
        		</c:if>
        	</div>
        </div>
        <!--// button_area -->

</form>