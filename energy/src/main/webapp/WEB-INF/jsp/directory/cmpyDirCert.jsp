<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_cert' ).bind( 'click' , function(){
		popupCmpyDirCert();
	});
	
});	

</script>

					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								Acquisition of Certifications and Technique
								</c:if>
								<c:if test="${param.lang != 'en'}">
								인증 및 기술획득 현황
								</c:if>							
							</h2>
						</div>
						<div class="float_right">
							<button class="btn cancel" id="btn_cmpy_dir_cert" title="수정">
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
							<caption>인증 및 기술획득 현황 목록 화면</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 12%;" />
								<col style="width: 20%;" />
								<col style="width: *;" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="first">
										<c:if test="${param.lang == 'en'}">
										Certification Date
										</c:if>
										<c:if test="${param.lang != 'en'}">
										취득일자
										</c:if>									
									</th>
									<th scope="col">
										<c:if test="${param.lang == 'en'}">
										Type
										</c:if>
										<c:if test="${param.lang != 'en'}">
										구분
										</c:if>									
									</th>
									<th scope="col">
										<c:if test="${param.lang == 'en'}">
										Publication
										</c:if>
										<c:if test="${param.lang != 'en'}">
										명칭/발행처
										</c:if>									
									</th>
									<th scope="col" class="last">
										<c:if test="${param.lang == 'en'}">
										Title of Product and Original Technology
										</c:if>
										<c:if test="${param.lang != 'en'}">
										제품 또는 기술명
										</c:if>									
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cmpyDirCertList}" var="list">	
									<tr>
										<td class="first alignc">${list.cert_date}</td>
										<td class="alignc">
											<c:if test="${param.lang == 'en'}">
											${list.domestic_yn_nm_en}
											</c:if>
											<c:if test="${param.lang != 'en'}">
											${list.domestic_yn_nm}
											</c:if>
										</td>
										<td class="alignc">
											<c:if test="${param.lang == 'en'}">
											${list.issu_agc_en}
											</c:if>
											<c:if test="${param.lang != 'en'}">
											${list.issu_agc}
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
								<c:if test="${empty cmpyDirCertList}">
									<td colspan="4" class="first alignc">
										<c:if test="${param.lang == 'en'}">
										No information available.
										</c:if>
										<c:if test="${param.lang != 'en'}">
										등록된 인증 및 기술획득현황이 없습니다.
										</c:if>									
									</td>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// dtable_area -->
					