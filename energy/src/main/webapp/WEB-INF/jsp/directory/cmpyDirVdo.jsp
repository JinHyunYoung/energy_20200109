<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_vdo' ).bind( 'click' , function(){
		popupCmpyDirVdo();
	});
	
});	

</script>
				
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								PR Movie
								</c:if>
								<c:if test="${param.lang != 'en'}">
								기업 동영상
								</c:if>								
							</h2>
						</div>
						<div class="float_right">
							<button class="btn cancel" id="btn_cmpy_dir_vdo" title="수정">
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
					
					<!-- dvideo_area -->
					<div class="dvideo_area">
						<ul class="dvideo_list">
							<c:forEach items="${cmpyDirVdoList}" var="list" varStatus="status">
								<li>
									
									<div class="dvideo_box">
										<a title="동영상 시청" href="${list.vdo_path}" target="_blank"><img src="${ list.vdo_img_path }" height="147" style="width: 100%;"></a>
<%-- 										<iframe height="147" style="width: 100%;" src="${list.vdo_path}" frameborder="0" allowfullscreen></iframe> --%>
									</div>	
								</li>
							</c:forEach>
						</ul>
					</div>
					<!--// dvideo_area -->