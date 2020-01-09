<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
</script>


<form id="cmpyDirAuthForm" name="cmpyDirAuthForm" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
	
	<div id="wrap">

		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">반려사유</h1>
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
			
				<!-- pop_content -->
				<div id="pop_content">
				
					<div class="division">
				
						<!-- table_area -->
						<div class="table_area">
							<table class="write">
								<caption>반려사유 화면</caption>
								<colgroup>
									<col style="width: 140px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">
										<label for="p_rjt_rsn"><strong class="color_pointr">*</strong>사유</label>
									</th>
									<td>
										<input type="text" id="p_rjt_rsn" name="p_rjt_rsn" value="<c:out value="${param.rjt_rsn}" escapeXml="true" />" class="in_wp300" data-parsley-required="true" />
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
		
						<!-- button_area -->
						<div class="button_area">
						
							<div class="float_right">
								<c:if test="${empty param.rjt_rsn}">
								<button class="btn save" title="저장" onClick="javascript:rejectCmpyDir()">
									<span>저장</span>
								</button>
								</c:if>
								<c:if test="${not empty param.rjt_rsn}">
								<button class="btn save" title="확인" onClick="javascript:popupClose()">
									<span>확인</span>
								</button></c:if>
							</div>
							
						</div>
						<!--// button_area -->
						
					</div>
					
				</div>
				<!--// pop_content -->
				
			</div>
		</article>	
		</div>
		<!-- //container -->
		
	</div>
	
</form>