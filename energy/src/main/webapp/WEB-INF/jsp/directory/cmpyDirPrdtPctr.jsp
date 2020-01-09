<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/assets/tab/tab.js"></script>		

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_prdtPctr' ).bind( 'click' , function(){
		popupCmpyDirPrdtPctr();
	});
	
});	

function changeCmpyDirPrdtPctr( _index ) {
	
	$('div.dimg_area div.tab').attr('class','tab hidden');
	$('div.dimg_area div:eq(' + _index + ')').attr('class','tab');
} 


</script>
				
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								Product Archive
								</c:if>
								<c:if test="${param.lang != 'en'}">
								제품사진
								</c:if>	
							</h2>
						</div>
						<div class="float_right">
							<button class="btn cancel" id="btn_cmpy_dir_prdtPctr" title="수정">
								<span>
									<c:if test="${param.lang == 'en'}">
									Update
									</c:if>
									<c:if test="${param.lang != 'en'}">
									수정
									</c:if>									
								</span>
							</button>
						</div>
					</div>
					<!--// dtitle_area -->
					
					<!-- dphoto_gallery -->
					<div class="dphoto_gallery">
						<ul class="dimg_tablist">
							<c:forEach items="${cmpyDirPrdtPctrList}" var="list" varStatus="status">
								<li class="on">
									<a href="javascript:changeCmpyDirPrdtPctr( ${status.index} )" >
										<c:if test="${not empty list.prdt_file_id_nm}">
											<img src="/contents/directory/${list.prdt_file_id_nm}" alt="${list.prdt_nm}" title="${list.prdt_nm}" />
										</c:if>
										<c:if test="${empty list.prdt_file_id_nm}">
											<img src="/images/web/common/no_album_img.png" alt="이미지 없음" />
										</c:if>
									</a>
								</li>				
							</c:forEach>
						</ul>
						<div class="dimg_area">	
							<c:forEach items="${cmpyDirPrdtPctrList}" var="list" varStatus="status">
								<c:if test="${status.index eq 0}">
									<div class="tab">
								</c:if>
								<c:if test="${status.index ne 0}">
									<div class="tab hidden">
								</c:if>
										<c:if test="${not empty list.prdt_file_id_nm}">
										<img src="/contents/directory/${list.prdt_file_id_nm}" alt="${list.prdt_nm}" title="${list.prdt_nm}" />
										</c:if>
										<c:if test="${empty list.prdt_file_id_nm}">
											<img src="/images/web/common/no_album_img.png" alt="이미지 없음" />
										</c:if>
									</div>			
							</c:forEach>
						</div>
					</div>
					<!--// dphoto_gallery -->