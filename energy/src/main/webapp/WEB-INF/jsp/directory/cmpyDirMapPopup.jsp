<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>

<script language="javascript">

$( document ).ready( function(){
		
});	

function saveCmpyDirMap( homepage_tp ){	
	
	oEditors.getById["map_cn"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["map_cn_en"].exec("UPDATE_CONTENTS_FIELD", []);
	
	updateCmpyDirMap(homepage_tp);
}

</script>

<form id="cmpyDirMapForm" name="cmpyDirMapForm" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 

	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">찾아오시는 길</h1>
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
			
				<!-- pop_content -->
				<div id="pop_content">
				
					<!-- division -->
					<div class="division">
					
						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">국문</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- division -->
						<div class="division20" style="width:700px !important;">
							<textarea id="map_cn" name="map_cn" cols="5" rows="10" class="in_w100">${cmpyDir.map_cn}</textarea>
						</div>
						<!--// division -->
						
					</div>
					<!--// division -->
					
					<!-- division -->
					<div class="division">
					
						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">영문</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- division -->
						<div class="division20" style="width:700px !important;">
							<textarea id="map_cn_en" name="map_cn_en" cols="5" rows="10" class="in_w100">${cmpyDir.map_cn_en}</textarea>
						</div>
						<!--// division -->
						
					</div>
					<!--// division -->
					
					<!-- button_area -->
					<div class="button_area">
						<div class="alignr">
							<button class="btn save" title="수정" onclick="javascript:saveCmpyDirMap()">
								<span>수정</span>
							</button>
							<button class="btn cancel" title="취소" onClick="javascript:popupClose()">
								<span>취소</span>
							</button>
						</div>
					</div>
					
					<!--// button_area -->
				</div>
				<!--// pop_content -->
				
			</div>
		</article>	
		</div>
		<!-- //container -->
	</div>

</form>

<script language="javascript">
	
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "map_cn",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=map_cn' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
    }, 
    fCreator: "createSEditor2"
});

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "map_cn_en",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=map_cn_en' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
    }, 
    fCreator: "createSEditor2"
});

</script>