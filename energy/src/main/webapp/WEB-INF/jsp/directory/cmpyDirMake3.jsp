<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$(document).keydown(function(e){   
    if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){       
        if(e.keyCode === 8){   
        return false;
        }
    }
});

history.pushState(null, null, location.href);
window.onpopstate = function(event) {
	history.go(1);
};

//메인 로 이동
function goMain(){
  
  var f = document.cmpyDirMake3Form;
 
  f.target = "_self";
  f.action = "/web/user/main.do";
  f.submit();
	
}

</script>

<!-- step_area -->
<div class="step_area">
	<ul class="step_list">
		<li title="1. 기업 디렉토리 중복확인">1</li>
		<li title="2. 기업정보 입력">2</li>
		<li class="active" title="3. 기업 디렉토리 신청완료">
			<strong>3. 기업 디렉토리 신청완료</strong>
		</li>
	</ul>
</div>					
<!--// step_area -->

<form id="cmpyDirMake3Form" name="cmpyDirMake3Form" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' /> 
	
	<!-- table_area -->
	<div class="firm_add_area">
		<p class="firm_strong">기업 디렉토리 생성이 완료되었습니다.</p>
		<p class="firm_txt">관리자 승인완료 되시면 내용 보완 후 공개하실 수 있습니다.</p>
	</div>
	<!--// table_area -->
	
	 <!-- button_area -->
	 <div class="button_area">
	 	<div class="alignc">
	 		<button class="btn save" title="메인으로" onclick="javascript:goMain()">
	 			<span>메인으로</span>
	 		</button>
	 	</div>
	 </div>
	 <!--// button_area -->

</form>