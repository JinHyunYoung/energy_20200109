<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true">

	<input type='hidden' id="auth_id" name='auth_id' value="${auth.auth_id}" />
	
	<!-- 권한 그룹이 필요없어 기본 "관리자" 권한 으로 설정 -->
	<input type='hidden' id="grp" name='grp' value="1" />
	
	<!-- 권한적용그룹이 필요없어 기본 "전체지자체" 권한적용그룹으로 설정 -->
	<input type='hidden' id="range" name='range' value="1" />
	
	<!-- write_basic -->
	<div class="table_area" style="margin-top:10px;padding-left:10px;padding-right:10px;">
		<table class="write">
			<caption>권한 등록화면</caption>
			<colgroup>
				<col style="width: 120px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>	
			
			<!-- 권한 그룹이 필요하지 않아 주석처리	
			<tr>
				<th scope="row">권한그룹</th>
				<td>
				    <g:radio id="grp" name="grp" codeGroup="AUTH_GROUP" checked="30" cls="text-middle" curValue="${auth.grp}"  /> 
				</td>
			</tr>	
			 -->			
			
			<tr>
				<th scope="row">권한명  <span class="asterisk">*</span></th>
				<td>
   								 <input class="in_w100" type="text" id="auth_nm" name="auth_nm" value="${auth.auth_nm}" placeholder="권한명" data-parsley-required="true" data-parsley-maxlength="100" />
				</td>
			</tr>
			<tr>
				<th scope="row">권한설명</th>
				<td>
			        <textarea class="in_w100" id="auth_desc" name="auth_desc" placeholder="권한설명" rows="3" data-parsley-maxlength="1000" >${auth.auth_desc}</textarea>
				</td>
			</tr>
			<tr>
				<th scope="row">사용여부</th>
				<td>
					   <input type="radio" name="use_yn" value="Y" <c:if test="${auth.use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="use_yn" value="N"  <c:if test="${auth.use_yn == 'N'}">checked</c:if>> 미사용 
				</td>
			</tr>
			
			
			<!-- 권한적용그룹이 필요하지 않아 주석처리
			<tr>
				<th scope="row">권한적용그룹</th>
				<td>
				    <g:radio id="range" name="range" codeGroup="AUTH_RANGE" checked="30" cls="text-middle" curValue="${auth.range}"  onChange="changeRange()" />
				    
				    <c:set var="orgnview" value="none"/>
				    <c:if test="${auth.range != '1' }">
				    <c:set var="orgnview" value=""/>
				    </c:if> 
					<g:select id="orgn" name="orgn" codeGroup="ADMINISTRATOR_CD" selected="${auth.orgn}" titleCode="선택" cls="in_w20" style="display:${orgnview};" />
				</td>
			</tr>	
			-->
			
			</tbody>
		</table>
	</div>	
	<!--// write_basic -->
		
	<!-- footer --> 
	<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode == 'W'}">
				<a href="javascript:authInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
                 <c:if test="${param.mode == 'E' }">
                 	<a href="javascript:authInsert()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:authDelete()" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
				</c:if>
				<a href="javascript:popupClose()" class="btn cancel" title="닫기">
					<span>취소</span>
				</a>
			</div>
		</footer>
	</div>
	<!-- //footer -->
	
</form>