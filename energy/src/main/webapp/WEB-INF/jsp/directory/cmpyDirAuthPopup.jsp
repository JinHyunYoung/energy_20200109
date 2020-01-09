<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

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
			<h1 class="pop_title">기업정보 수정 인증하기</h1>
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
				
					<!-- dtable_area -->
					<div class="dtable_area">
						<table class="dtable">
							<caption>기본정보 화면</caption>
							<colgroup>
								<col style="width: 180px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="first">
									<label for="input_num"><strong class="color_pointr">*</strong>인증번호</label>
								</th>
								<td class="last">
									<input type="text" id="auth_no" name="auth_no" class="in_w100" data-parsley-required="true" />
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// dtable_area -->
					
				</div>
				<!--// pop_content -->
				
			</div>
		</article>	
		</div>
		<!-- //container -->
		
		<!-- footer --> 
		<div id="pop_footer">
		<footer>
		
			<!-- dbutton_area -->
			<div class="dbutton_area alignc">
				<button class="btn save" title="확인" onClick="javascript:checkCmpyDirAuth()">
					<span>확인</span>
				</button>
			</div>
			<!--// dbutton_area -->
			
		</footer>
		</div>
		<!-- //footer -->
		
	</div>
	
</form>