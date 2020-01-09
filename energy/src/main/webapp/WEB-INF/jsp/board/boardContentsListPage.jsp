<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var boardContentsListPageUrl = "<c:url value='/web/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/web/board/boardContentsWrite.do'/>";
var boardContentsListUrl = "<c:url value='/web/board/boardContentsList.do'/>";
var boardContentsViewUrl = "<c:url value='/web/board/boardContentsView.do'/>";

$(document).ready(function(){
	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}
	
});

// 검색
function search(){
    boardList();
}

//게시물 등록
function contentsWrite(){
	if($("#board_id").val() != "38") return;
	// 회원 비회원 확인후 등록페이지 이동
	
	var f = document.listFrm;
	   
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
	var f = document.listFrm;
	
	$("#contents_id").val(contentsid);
	   
    f.target = "_self";
    f.action = boardContentsViewUrl;
    f.submit();
}

//초기화
function formReset(){
	$("#reply_ststus").val("");
	$("#cate_id").val("");
	$("#searchkey").val("T");
	$("#searchtxt").val("");
}

//페이징 사이즈 
function changePageSize(){
	$("#miv_pageSize").val($("#pageSize").val());
	$("#miv_pageNo").val(1);
	search();
}

// 페이지 이동
function go_Page(page){
	$("#miv_pageNo").val(page);
	search();
}

//게시판 리스트 불러오기
function boardList(){
	$.ajax({
        url: boardContentsListUrl,
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
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">

	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	<input type='hidden' id="mode" name='mode' value="W" />
	<input type='hidden' id="contents_id" name='contents_id' value="" />
	<input type='hidden' id="board_id" name='board_id' value="${param.board_id }" />
	
	<!-- contentsList -->
	<div id="contentsList"></div>
	<!-- //contentsList -->

</form>