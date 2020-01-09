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
			<h1 class="pop_title">승인인증번호</h1>
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
								<caption>승인인증번호 화면</caption>
								<colgroup>
									<col style="width: 140px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">
										<label for="p_auth_no"><strong class="color_pointr">*</strong>인증번호</label>
									</th>
									<td>
										<input type="text" id="p_auth_no" name="p_auth_no" value="<c:out value="${param.p_auth_no}" escapeXml="true" />" class="in_wp300" data-parsley-maxlength="100" data-parsley-required="true" />
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
		
						<!-- button_area -->
						<div class="button_area">
						
							<div class="float_right">
								<button class="btn save" title="저장" onClick="javascript:approveCmpyDir()">
									<span>저장</span>
								</button>
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