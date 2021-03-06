<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>

<script language="javascript">

$( document ).ready( function(){
		
});	

function saveCmpyDirBrec( homepage_tp ){	
	
	oEditors.getById["brec_cn"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["brec_cn_en"].exec("UPDATE_CONTENTS_FIELD", []);
	
	updateCmpyDirBrec( homepage_tp);
}

</script>

<form id="cmpyDirBrecForm" name="cmpyDirBrecForm" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 

	<div id="wrap">
		
		<!-- popup_content -->
		
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">국내외 주요공사 및 납품실적현황</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
				<div id="pop_content">
				
					<!-- division -->
					<div class="division">
					
						<!-- title_area -->
						<div class="title_area">
							<h2 class="pop_title">국문</h4>
						</div>
						<!--// title_area -->
						
						<div class="division40" style="width:700px !important;">
							<textarea id="brec_cn" name="brec_cn" cols="5" rows="10" class="in_w100">${cmpyDir.brec_cn}</textarea>						
						</div>
						
						<!-- title_area -->
						<div class="title_area">
							<h2 class="pop_title">영문</h4>
						</div>
						<!--// title_area -->
						
						<div class="division20" style="width:700px !important;">
							<textarea id="brec_cn_en" name="brec_cn_en" cols="5" rows="10" class="in_w100">${cmpyDir.brec_cn_en}</textarea>
						</div>
												
						<!-- button_area -->
						<div class="button_area">
							<div class="float_right">
								<button class="btn save" title="저장" onclick="javascript:saveCmpyDirBrec()">
									<span>수정</span>
								</button>
								<button class="btn cancel" title="취소" onclick="javascript:popupClose()">
									<span>취소</span>
								</button>
							</div>
						</div>
						<!--// button_area -->
						
					</div>
					<!--// division -->
					
				</div>
			</div>
		</article>	
		</div>
		<!--// popup_content -->
		
	</div>

</form>

<script language="javascript">	
	
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "brec_cn",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=brec_cn' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
    }, 
    fCreator: "createSEditor2"
});

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "brec_cn_en",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=brec_cn_en' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
    }, 
    fCreator: "createSEditor2"
});

</script>