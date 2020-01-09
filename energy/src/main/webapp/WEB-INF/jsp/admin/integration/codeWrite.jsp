<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true">

	<!-- write_basic -->
	<div class="table_area">
		<table class="write">
		
			<caption>코드 등록화면</caption>
			
			<colgroup>
				<col style="width: 120px;" />
				<col style="width: *;" />
			</colgroup>
			
			<tbody>
				<tr>
					<th scope="row">코드구분ID</th>
					<td>${code.gubun}</td>
				</tr>
				<tr>
					<th scope="row">코드구분명</th>
					<td>${code.gubun_nm}</td>
				</tr>									
				<tr>
					<th scope="row">코드  <span class="asterisk">*</span></th>
					<td>
					     <input class="in_w100" type="text" id="code" name="code" value="${code.code}" placeholder="코드" data-parsley-required="true" data-parsley-maxlength="50" <c:if test="${param.mode == 'E' }">readOnly</c:if> />
					</td>
				</tr>
				<tr>
					<th scope="row">코드구분명  <span class="asterisk">*</span></th>
					<td>
	   								 <input class="in_w100" type="text" id="code_nm" name="code_nm" value="${code.code_nm}" placeholder="코드명" data-parsley-required="true" data-parsley-maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="row">설명</th>
					<td>
				        <textarea class="in_w100" id="code_desc" name="code_desc" placeholder="설명" rows="3" data-parsley-maxlength="1000" >${code.code_desc}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부</th>
					<td>
						<input type="radio" name="use_yn" value="Y" <c:if test="${code.use_yn == 'Y'}">checked</c:if>> 사용 
						<input type="radio" name="use_yn" value="N"  <c:if test="${code.use_yn == 'N'}">checked</c:if>> 미사용 
					</td>
				</tr>
				
				<c:if test="${param.mode == 'E' }">
				<tr>
					<th scope="row">등록자</th>
					<td>${code.reg_usernm}</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td>${code.reg_date}</td>
				</tr>
				</c:if>			
					
			</tbody>
		</table>
	</div>
	<!--// write_basic -->
	
	<!-- footer --> 
	<div id="footer">
		<footer>
			<div class="button_area alignc">
			
				<c:if test="${param.mode == 'W'}">
				<a href="javascript:codeInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
				</c:if>
				
				<c:if test="${param.mode == 'E' }">
				<a href="javascript:codeInsert()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:codeDelete()" class="btn save" title="삭제">
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