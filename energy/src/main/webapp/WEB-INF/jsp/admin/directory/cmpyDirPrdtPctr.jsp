<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_prdtPctr' ).bind( 'click' , function(){
		popupCmpyDirPrdtPctr();
	});
	
});	

</script>
	
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">제품사진</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_prdtPctr" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<div class="product_photo_area">
			<ul class="product_list" w>
				<c:forEach items="${cmpyDirPrdtPctrList}" var="list" varStatus="status">
					<li>
						<a href="#x" title="제품 상세보기">
							<div class="product_img">
								<c:if test="${not empty list.prdt_file_id_nm}">
									<img src="/contents/directory/${list.prdt_file_id_nm}" width="205" height="136" alt="${list.prdt_nm}" title="${list.prdt_nm}" />
								</c:if>
								<c:if test="${empty list.prdt_file_id_nm}">
									<img src="/images/admin/common/detail_no_img.png" width="205" height="136" alt="이미지 없음" class="info_img" />
								</c:if>
							</div>
							<div class="product_txt">
								<strong>${list.prdt_nm}</strong>
							</div>
						</a>
					</li>	
				</c:forEach>
			</ul>
		</div>