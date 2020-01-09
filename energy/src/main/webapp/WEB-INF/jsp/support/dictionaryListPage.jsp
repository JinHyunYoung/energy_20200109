<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var dictionaryListUrl = "<c:url value='/web/dictionary/dictionaryList.do'/>";

$(document).ready(function(){
	if("${param.miv_pageNo}" != null ){
		go_Page("${param.miv_pageNo}");
	}else{
		search();
	}
	

});


// 검색
function search(){
	dictionaryList();
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
function dictionaryList(){
	$.ajax({
      url: dictionaryListUrl,
      dataType: "html",
      type: "post",
      data: jQuery("#listFrm").serialize(),
      success: function(data) {
      	$("#contentsList").html(data);
      	bindSearch();
      },
      error: function(e) {
          alert("테이블을 가져오는데 실패하였습니다.");
      }
  });
}

function bindSearch(){
	$( '.dictionary_keyword_list a' ).bind( 'click' , function(){
		
		$( '.dictionary_keyword_list li' ).removeClass( 'on' );
		
		if( $( 'input[name=kr_idx]' ).val() ==  $( this ).find( 'span' ).html() ){
			$( 'input[name=kr_idx]' ).val( '' );
		}else{
			$( 'input[name=kr_idx]' ).val( $( this ).find( 'span' ).html() );
			$( this ).parent().addClass( 'on' );
		}
		search();
		return false;
	});
	
	$( '.dictionary_keyword_list_en a' ).bind( 'click' , function(){
		
		$( '.dictionary_keyword_list_en li' ).removeClass( 'on' );
		
		if( $( 'input[name=en_idx]' ).val() ==  $( this ).find( 'span' ).html() ){
			$( 'input[name=en_idx]' ).val( '' );
		}else{
			$( 'input[name=en_idx]' ).val( $( this ).find( 'span' ).html() );
			$( this ).parent().addClass( 'on' );
		}
		search();
		return false;
	});
	
	$( '.dictionary_recommend_list a' ).bind( 'click' , function(){
		
		$( '#dic_keyword' ).val( $( this ).text() );
		$( 'input[name=kr_idx]' ).val( '' );
		$( 'input[name=en_idx]' ).val( '' );
		search();
		
	});
}




</script>

<!-- search_area -->
<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">

	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
	<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
	<input type='hidden' id="total_cnt" name='total_cnt' value="" />
	<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
	
	<input type="hidden" name="kr_idx" value="${param.kr_idx}" />
	<input type="hidden" name="en_idx" value="${param.en_idx}" />
	
	<!-- contentsList -->
	<div id="contentsList"></div>
	<!-- //contentsList -->

</form>
				
			