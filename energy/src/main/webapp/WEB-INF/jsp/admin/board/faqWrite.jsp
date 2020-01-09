<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>

<script language="javascript">

var insertFaqUrl = "<c:url value='/admin/faq/insertFaq.do'/>";
var updateFaqUrl = "<c:url value='/admin/faq/updateFaq.do'/>"
var deleteFaqUrl = "<c:url value='/admin/faq/deleteFaq.do'/>";

$(document).ready(function(){
	
});

function faqListPage() {
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = "/admin/faq/faqListPage.do";
    f.submit();
}

function faqInsert(){
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

	if($("#contents").val() == ""){
	     alert("내용을 입력해주십시요.");
	     return;
   	}
   	var url = "";
   	if ( $("#writeFrm").parsley().validate() ){
	   
	   url = insertFaqUrl;
	   if($("#mode").val() == "E") url = updateFaqUrl; 

	   // 데이터를 등록 처리해준다.
	   $("#writeFrm").ajaxSubmit({
 				success: function(responseText, statusText){
 					alert(responseText.message);
 					if(responseText.success == "true"){
 						faqListPage();
 					}	
 				},
 				dataType: "json", 				
 				url: url
 		    });	
	   
   	}
}

function faqDelete(){
	
	if(!confirm("FAQ를 정말 삭제하시겠습니까?")) return;
   
	$.ajax
	({
		type: "POST",
           url: deleteFaqUrl,
           data:{
           	faq_id : $("#faq_id").val()
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				faqListPage();
			}	
		}
	});
}

</script>


<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true">

	<input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
	<input type='hidden' id="p_searchtxt" name='p_searchtxt' value="<c:out value="${param.p_searchtxt}" escapeXml="true" />" />
	<input type='hidden' id="p_satis_yn" name='p_satis_yn' value="${param.p_satis_yn}" />
	<input type='hidden' id="mode" name='mode' value="${param.mode}" />
	<input type='hidden' id="faq_id" name='faq_id' value="${faq.faq_id}" />
	
	<!--// content -->
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
			
		<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>FAQ 등록화면</caption>
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
					<td>
					    ${faq.reg_usernm}
					</td>
					<th scope="row">등록일</th>
					<td>
					    ${faq.reg_date}
					</td>
				</tr>
                         </c:if>
				<tr>
					<th scope="row">제목  <span class="asterisk">*</span></th>
					<td colspan="3">
					    <input class="form-control" type="text" id="title" name="title" value="${faq.title}" placeholder="제목" style="width:100%" data-parsley-required="true" data-parsley-maxlength="100" <c:if test="${!empty faq.gubun}">readOnly</c:if>  />
					</td>
				</tr>
				<%-- <tr>
					<th scope="row">만족도 사용여부</th>
					<td colspan="3">
                                 <input type="radio" name="satisfy_yn" value="Y" <c:if test="${faq.satisfy_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="satisfy_yn" value="N"  <c:if test="${faq.satisfy_yn == 'N'}">checked</c:if>> 미사용								
					</td>
				</tr> --%>
				<tr>
					<th scope="row">사용여부</th>
					<td colspan="3">
				        <input type="radio" name="use_yn" value="Y" <c:if test="${faq.use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="use_yn" value="N"  <c:if test="${faq.use_yn == 'N'}">checked</c:if>> 미사용 
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="4" style="text-align:center">내용</th>
				</tr>
				<tr>
					<td colspan="4">
					   <textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;" >${faq.contents}</textarea>
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
				<a href="javascript:faqInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  	</c:if>
			  	
               	<c:if test="${param.mode == 'E' }">
       			<a href="javascript:faqInsert()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:faqDelete()" class="btn save" title="등록">
					<span>삭제</span>
				</a>
				</c:if>
				
				<a href="javascript:faqListPage() " class="btn cancel" title="닫기">
					<span>취소</span>
				</a>
				
			</div>
		</div>
		<!--// button_area -->
		
	</div>			
</form>


<script language="JavaScript">

var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "contents",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=contents' />",
    htParams : {
    	bUseModeChanger : true
    }, 
    fCreator: "createSEditor2"
});

</script>