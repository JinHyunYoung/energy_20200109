<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript">

	var categoryWriteUrl = '<c:url value="/admin/wbiz/categoryWrite.do" />';
	var categoryLoadUrl = '<c:url value="/admin/wbiz/categoryLoad.do" />';
	var categoryInsertUrl = '<c:url value="/admin/wbiz/categoryInsert.do" />';	
	var categorySelectUrl = '<c:url value="/admin/wbiz/categorySelectList.do" />';
	var categoryUpdateUrl = '<c:url value="/admin/wbiz/categoryUpdate.do" />';
	var categoryDeleteUrl = '<c:url value="/admin/wbiz/categoryDelete.do" />';
	
	$( document ).ready( function(){
		
		categorySelect();
		
		$( '#btn_insert' ).bind( 'click' , function(){
			loadCategoryWrite( 'W' );
		});
	
	});	
	

	function popupShow(){
		$( "#modal-category-write" ).modal( 'show' );
	}

	function popupClose(){
		$( "#modal-category-write" ).modal( "hide" );
	}
	
	function loadCategoryWrite( _mode ,  _inds_tp_cd , _code , _wbiz_cd_tp ){
		
		$( '#pop_content' ).html( '' );		
		
	    $.ajax({
	        url: categoryWriteUrl,
	        dataType: "html",
	        type: "post",
	        data: {	           
	           mode : _mode,
	           code : _code , 
	           wbiz_cd_tp : _wbiz_cd_tp ,
	           inds_tp_cd : _inds_tp_cd
			},
	        success: function(data) {
	        	$( '#pop_content' ).html( data );
	        	popupShow();
	        },
	        error: function(e) {
	            alert( '데이터를 가져오는데 실패했습니다.' );
	        }
	    });

	}
	
	function categorySelect(){
		
	    $.ajax({
	        url: categorySelectUrl,
	        dataType: "html",
	        type: "post",
	        data: {	           
	           
			},
	        success: function(data) {
	        	$( 'table.list tbody' ).html( data );
	        },
	        error: function(e) {
	            alert( '데이터를 가져오는데 실패했습니다.' );
	        }
	    });

	}

	

</script>

<!-- content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">물산업 분류관리</h3>
		</div>
		<!--// main_title -->
		
	</div>	
	<!--// title_and_info_area -->
	
	
	
	<!-- table_search_area -->
	<div class="table_search_area">
		<div class="float_left">
			<button class="btn acti" id="btn_excel_kr" title="엑셀다운로드(국문)" onclick="location.href='/admin/wbiz/categorySelectListExcel.do';return false;">
				<span>엑셀다운로드(국문)</span>
			</button>
			<button class="btn acti" id="btn_excel_en" title="엑셀다운로드(영문)" onclick="location.href='/admin/wbiz/categorySelectListExcelEn.do';return false;">
				<span>엑셀다운로드(영문)</span>
			</button>
		</div>
		<div class="float_right">
			<button class="btn save" id="btn_insert" title="등록">
				<span>등록</span>
			</button>
		</div>
	</div>
	<!--// table_search_area -->
	
	<!-- title_area -->
	<div class="table_area">
		<table class="list">
			<caption>물산업 분류체계</caption>
			<colgroup>
				<col style="width: 8%;" />
				<col style="width: 6%;" />
				<col style="width: *;" />
				<col style="width: 6%;" />
				<col style="width: *;" />
				<col style="width: 6%;" />
				<col style="width: *;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">업종</th>
					<th scope="col">코드</th>
					<th scope="col">대분류명</th>
					<th scope="col">코드</th>
					<th scope="col">중분류명</th>
					<th scope="col">코드</th>
					<th scope="col">세분류명</th>
				</tr>
			</thead>
			<tbody>				
			</tbody>
		</table>
	</div>
	

	
</div>
<!--// content -->

<div class="modal fade" id="modal-category-write" >	
	<div class="modal-dialog modal-size-small">
	
		
		<div id="pop_header">
		<header>
			<h1 class="pop_title">물산업분류 등록/수정</h1>
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
			    <div  id="pop_content" >
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->	
				
	</div>
</div>

	