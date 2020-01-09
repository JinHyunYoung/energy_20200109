<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_prdt' ).bind( 'click' , function(){
		popupCmpyDirPrdt();
	});
	
});	

</script>

						<!-- dtitle_area -->
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">
									<c:if test="${param.lang == 'en'}">
									Product and Technique Condition
									</c:if>
									<c:if test="${param.lang != 'en'}">
									주요제품 및 기술현황 화면
									</c:if>								
								</h2>
							</div>
							<div class="float_right">
								<button class="btn cancel" id="btn_cmpy_dir_prdt" title="수정">
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
						<!-- dtable_area -->
						<div class="dtable_area">
							<table class="dtable">
								<caption>Product and Technique Condition</caption>
								<colgroup>
									<col style="width: 17%;" />
									<col style="width: 17%;" />
									<col style="width: 17%;" />
									<col style="width: *;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col" class="first">
										<c:if test="${param.lang == 'en'}">
										1Depth
										</c:if>
										<c:if test="${param.lang != 'en'}">
										대분류
										</c:if>									
									</th>
									<th scope="col">
										<c:if test="${param.lang == 'en'}">
										2Depth
										</c:if>
										<c:if test="${param.lang != 'en'}">
										중분류
										</c:if>									
									</th>
									<th scope="col">
										<c:if test="${param.lang == 'en'}">
										3Depth
										</c:if>
										<c:if test="${param.lang != 'en'}">
										세분류
										</c:if>									
									</th>
									<th scope="col" class="last">
										<c:if test="${param.lang == 'en'}">
										Title of Product
										</c:if>
										<c:if test="${param.lang != 'en'}">
										세부 제품명
										</c:if>									
									</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach items="${cmpyDirPrdtList}" var="list">	
										<tr>
											<td class="first alignc">
												<c:if test="${param.lang == 'en'}">
												${list.wbiz_tp_l_cd_nm_en}
												</c:if>
												<c:if test="${param.lang != 'en'}">
												${list.wbiz_tp_l_cd_nm}
												</c:if>												
											</td>
											<td class="alignc">
												<c:if test="${param.lang == 'en'}">
												${list.wbiz_tp_m_cd_nm_en}
												</c:if>
												<c:if test="${param.lang != 'en'}">
												${list.wbiz_tp_m_cd_nm}
												</c:if>	
											</td>							
											<td class="alignc">
												<c:if test="${param.lang == 'en'}">
												${list.wbiz_tp_s_cd_nm_en}
												</c:if>
												<c:if test="${param.lang != 'en'}">
												${list.wbiz_tp_s_cd_nm}
												</c:if>
											</td>
												<td class="last">
												<c:if test="${param.lang == 'en'}">
												${list.prdt_nm_en}
												</c:if>
												<c:if test="${param.lang != 'en'}">
												${list.prdt_nm}
												</c:if>
											</td>
										</tr>
									</c:forEach>					
									<c:if test="${empty cmpyDirPrdtList}">
										<td colspan="4" class="first alignc last">
											<c:if test="${param.lang == 'en'}">
											No information available.
											</c:if>
											<c:if test="${param.lang != 'en'}">
											등록된 주요제품 및 기술현황이 없습니다.
											</c:if>										
										</td>
									</c:if>
								</tbody>
							</table>
						</div>
						<!--// dtable_area -->