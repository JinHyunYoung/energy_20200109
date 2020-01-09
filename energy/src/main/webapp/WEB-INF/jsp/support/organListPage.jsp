<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var organListUrl = "<c:url value='/web/organ/organList.do'/>";

$(document).ready(function(){
	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}
});


// 검색
function search(){
	organList();
}

// 페이지 이동
function go_Page(page){
	$("#miv_pageNo").val(page);
	search();
}

// 페이징 사이즈 
function changePageSize(){	
	
	$("#miv_pageSize").val($("#pageSize").val());
	$("#miv_pageNo").val(1);
	
	search();
}

// 조직 리스트 불러오기
function organList(){
	$.ajax({
      url: organListUrl,
      dataType: "html",
      type: "post",
      data: jQuery("#listFrm").serialize(),
      success: function(data) {
      	$("#contentsList").html(data);
      	selectedCondition();
      },
      error: function(e) {
          alert("테이블을 가져오는데 실패하였습니다.");
      }
  });
}

function selectedCondition(){
	var organ_gb = $("#p_organ_gb").val();
	if(organ_gb != null && organ_gb != ""){
		$("#organ_gb").val(organ_gb).attr("selected", "selected");
		$("#p_organ_gb").val("");
	}
	
}

</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">

	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="organ_no" name='organ_no' value="${param.organ_no}" />
	<input type='hidden' id="p_organ_gb" name='p_organ_gb' value="${param.organ_gb}" />
	
	<!-- contentsList -->
	<div id="contentsList"></div>
	<!-- //contentsList -->

</form>