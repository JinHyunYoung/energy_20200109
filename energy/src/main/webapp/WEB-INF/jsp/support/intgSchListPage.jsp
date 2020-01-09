<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var intgSchListUrl = "<c:url value='/web/intgSch/intgSchList.do'/>";

$(document).ready(function(){
	if("${param.keyword_intgsch}" != "" ){
		$.ajax({
		      url: intgSchListUrl,
		      dataType: "html",
		      type: "post",
		      data: jQuery("#listFrm_first").serialize(),
		      success: function(data) {		    	  
				$("#contentsList").html(data);      	
		      },
		      error: function(e) {
		          alert("테이블을 가져오는데 실패하였습니다.");
		      }
		  });
	}else	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}
	
	
	

});


// 검색
function search(){
	if( $( '#keyword_txt' ).val() == '' ){
		alert( '검색어를 입력하십시오.' );
		$( '#keyword_txt' ).focus();
		return false;
	} 
	intgschList();
}

// 페이지 이동
function go_Page(page){
	$("#miv_pageNo").val(page);
	search();
}

// 페이징 사이즈 
function changePageSize(){	
	
	$("#miv_pageSize").val($("#select_num").val());
	$("#miv_pageNo").val(1);
	
	search();
}

// 조직 리스트 불러오기
function intgschList(){
	$.ajax({
      url: intgSchListUrl,
      dataType: "html",
      type: "post",
      data: jQuery("#listFrm").serialize(),
      success: function(data) {
      	$("#contentsList").html(data);      	
      },
      error: function(e) {
          alert("테이블을 가져오는데 실패하였습니다.");
      }
  });
}




</script>

<!-- search_area -->
<form id="listFrm_first" name="listFrm_first" method="post" onsubmit="return false;">

	<input type='hidden' id="miv_pageNo_first" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize_first" name='miv_pageSize' value="${param.miv_pageSize}" />
	<input type='hidden' id="total_cnt_first" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP_first" name='LISTOP' value="${LISTOP.value}" />	
	<input type='hidden' name='keyword' value="${param.keyword_intgsch}" />


</form>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">

	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${param.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	
	<!-- contentsList -->
	<div id="contentsList"></div>
	<!-- //contentsList -->

</form>
				

				
				
			
				
			