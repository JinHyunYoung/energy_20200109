<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_vdo' ).bind( 'click' , function(){
		popupCmpyDirVdo();
	});
	
});	
</script>
	
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">기업 동영상</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_vdo" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<div class="product_photo_area">
			<ul class="product_list">
				<c:forEach items="${cmpyDirVdoList}" var="list" varStatus="status">
					<li>
						<div class="dvideo_box">
							<div class="dvideo_box">
								<c:choose>
									<c:when test="list.vdo_img_path != null && list.vdo_img_path != ''">
										<a title="동영상 시청" href="${list.vdo_path}" target="_blank"><img src="${ list.vdo_img_path }" height="147" style="width: 100%;"></a>
									</c:when>
									<c:otherwise>
										<a title="동영상 시청" href="${list.vdo_path}" target="_blank"><img src="/images/directory/vod_default.png" height="147" style="width: 100%;"></a>
									</c:otherwise>
								</c:choose>
								<c:if test="list.vdo_img_path == null || list.vdo_img_path == ''">
								</c:if>
<%-- 							<iframe height="147" style="width: 100%;" src="${list.vdo_path}" frameborder="0" allowfullscreen></iframe> --%>
						</div>
						<div class="product_txt">
							<strong>${list.vdo_title}</strong>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
