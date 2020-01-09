<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   
	
<script language="javascript">

$( document ).ready( function(){
	
	$( 'span.amount' ).number( true );
	
	$( '#btn_cmpy_dir_fnc' ).bind( 'click' , function(){
		popupCmpyDirFnc();
	});
	
});	

</script>

						<div class="division marginr10">
						
							<!-- dtitle_area -->
							<div class="dtitle_area">
								<div class="float_left padt5">
									<h2 class="title">
										<c:if test="${param.lang == 'en'}">
										Financial Position
										</c:if>
										<c:if test="${param.lang != 'en'}">
										재무현황
										</c:if>
									</h2>
								</div>
								<div class="float_right">
									<button class="btn cancel" id="btn_cmpy_dir_fnc" title="수정">
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
									<caption>재무현황 목록 화면</caption>
									<colgroup>
										<col style="width: 40%;" />
										<col style="width: *;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" class="first">
												<c:if test="${param.lang == 'en'}">
												Baseline Year
												</c:if>
												<c:if test="${param.lang != 'en'}">
												기준년도
												</c:if>											
											</th>
											<th scope="col" class="last">
												<c:if test="${param.lang == 'en'}">
												Revenue(KRW million)
												</c:if>
												<c:if test="${param.lang != 'en'}">
												매출액(백만원)
												</c:if>		
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cmpyDirFncList}" var="list">	
											<tr>
												<c:if test="${param.lang == 'en'}">
													<td class="first alignc">${list.fnc_yy}Year</td>
												</c:if>
												<c:if test="${param.lang != 'en'}">
													<td class="first alignc">${list.fnc_yy}년</td>
												</c:if>
												<td class="last alignc"><span class="amount">${list.fnc_amount}</span></td>
											</tr>
										</c:forEach>					
										<c:if test="${empty cmpyDirFncList}">
											<td colspan="2" class="first alignc last">
												<c:if test="${param.lang == 'en'}">
												No information available.
												</c:if>
												<c:if test="${param.lang != 'en'}">
												등록된 재무현황이 없습니다.
												</c:if>													
											</td>
										</c:if>
									</tbody>
								</table>
							</div>
							<!--// dtable_area -->
							
						</div>