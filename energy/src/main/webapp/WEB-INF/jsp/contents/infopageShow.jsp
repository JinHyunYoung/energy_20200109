<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var listUrl = "<c:url value='/web/infopage/selectInfopageShow.do'/>";

$(document).ready(function(){
	search();
});


function search(){
	 $.ajax({
	     url: listUrl,
		 data : {
			 info_type : $("#info_type").val(),
			 version : $("#version").val()
		 },
	     dataType: "json",
	     type: "post",
	     async : false,
	     success: function(data) {
	    	 
	    	$("#contents").html(data.infopage.contents);	    		
	    	$("#info_type").val(data.infopage.info_type);    		
	    	$("#version").val(data.infopage.version - 1);

	     },
	     error: function(e) {
	     }
	 });
}

</script>
	
</div>

<div class="editor" id="contents">
</div>

<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
	<input type='hidden' id="info_type" name='version' value="${info_type}" />
	<input type='hidden' id="version" name='version' value="none" />
</form>
