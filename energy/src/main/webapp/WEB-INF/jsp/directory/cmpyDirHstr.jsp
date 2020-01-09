<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_hstr' ).bind( 'click' , function(){
		popupCmpyDirHstr();
	});
	
});	

</script>
				
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								History
								</c:if>
								<c:if test="${param.lang != 'en'}">
								연혁
								</c:if>							
							</h2>
						</div>
						<div class="float_right">
							<button class="btn cancel" id="btn_cmpy_dir_hstr" title="수정">
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
							<caption>연혁 목록 화면</caption>
							<colgroup>
								<col style="width: 15%;" />
								<col style="width: 10%;" />
								<col style="width: *;" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="first">
										<c:if test="${param.lang == 'en'}">
										Year
										</c:if>
										<c:if test="${param.lang != 'en'}">
										년도
										</c:if>									
									</th>
									<th scope="col">
										<c:if test="${param.lang == 'en'}">
										Month
										</c:if>
										<c:if test="${param.lang != 'en'}">
										월
										</c:if>									
									</th>
									<th scope="col" class="last">
										<c:if test="${param.lang == 'en'}">
										Content
										</c:if>
										<c:if test="${param.lang != 'en'}">
										내용
										</c:if>									
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cmpyDirHstrList}" var="list" varStatus="status">
								
									<tr>																		
									<c:if test="${list.hstr_yy ne pre_hstr_yy}">
										<td rowspan="${list.hstr_yy_rowspan}" class="first alignc">
											<c:if test="${param.lang == 'en'}">
												${list.hstr_yy} Year
											</c:if>
											<c:if test="${param.lang != 'en'}">
												${list.hstr_yy} 년도
											</c:if>
										</td>
									</c:if>
										<td class="alignc">
											<c:if test="${param.lang == 'en'}">
											${list.hstr_mm} Month
											</c:if>
											<c:if test="${param.lang != 'en'}">
											${list.hstr_mm} 월
											</c:if>
										</td>
										<td class="last">
											<c:if test="${param.lang == 'en'}">
											${list.hstr_cn_en}
											</c:if>
											<c:if test="${param.lang != 'en'}">
											${list.hstr_cn}
											</c:if>										
										</td>	
									</tr>				
											
									<c:set value="${list.hstr_yy}" var="pre_hstr_yy"/>		
										
								</c:forEach>					
								<c:if test="${empty cmpyDirHstrList}">
									<td colspan="3" class="first alignc">
										<c:if test="${param.lang == 'en'}">
										No information available.
										</c:if>
										<c:if test="${param.lang != 'en'}">
										등록된 연혁이 없습니다.
										</c:if>
									</td>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// dtable_area -->
					