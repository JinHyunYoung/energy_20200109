<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var searchCmpyDirPageListUrl = "<c:url value='/web/directory/searchCmpyDirPageList.do'/>";
var cmpyDirViewUrl = "<c:url value='/web/directory/cmpyDirView.do'/>";
var cmpyDirMakeUrl = "<c:url value='/web/directory/cmpyDirMake.do'/>";
var categoryLoadUrl = '<c:url value="/web/wbiz/categoryLoad.do" />';

$(document).ready(function(){
	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}
});


// 검색
function search(){
	cmpyDirList();
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
function cmpyDirList(){
	$.ajax({
      url: searchCmpyDirPageListUrl,
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


// 상세보기
function goCmpyDir(dir_sn){
	
    var f = document.listFrm; 		
	$("#dir_sn").val(dir_sn);	
    f.action = cmpyDirViewUrl;
    f.submit();
	
}

// 기업디렉토리 만들기
function goCmpyDirMake(){
	
    var f = document.listFrm;   	
    f.action = cmpyDirMakeUrl;
    f.submit();
	
}


</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">

	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />	
	<input type='hidden' id="mode" name='mode' value="E" />	
	<input type='hidden' id="lang" name='lang' value="${param.lang}" />
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" />	
	<input type="hidden" id="inds_tp_cd" name="inds_tp_cd" value="${param.inds_tp_cd}" />
						
	<!-- contentsList -->
	<div id="contentsList"></div>
	<!-- //contentsList -->

</form>