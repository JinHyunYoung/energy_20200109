<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir_manager' ).bind( 'click' , function(){
		popupCmpyDirManager(true);
	});
	
});	
</script>

		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">담당자 정보</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_manager" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<div class="table_area">
			<table class="write">
				<caption>담당자 정보 화면</caption>
				<colgroup>
					<col style="width: 140px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">이름<strong class="color_pointr">*</strong>
						</th>
						<td id="dir_manager_nm">${cmpyDir.manager_nm}</td>
					</tr>
					<tr>
						<th scope="row">휴대전화<strong class="color_pointr">*</strong>
						</th>
						<td id="dir_manager_tel">${cmpyDir.manager_tel}</td>
					</tr>
					<tr>
						<th scope="row">이메일<strong class="color_pointr">*</strong>
						</th>
						<td><a id="dir_manager_email" href="mailto:${cmpyDir.manager_email}" title="${cmpyDir.manager_email}로 메일보내기">${cmpyDir.manager_email}</a></td>
					</tr>
					<tr>
						<th scope="row">부서<strong class="color_pointr">*</strong>
						</th>
						<td id="dir_manager_dept">${cmpyDir.manager_dept}</td>
					</tr>
					<tr>
						<th scope="row">공개여부</th>
						<td>
						<input type="radio" id="dir_manager_opn_yn_y" name="dir_manager_opn_yn" value="Y" <c:if test="${cmpyDir.manager_opn_yn eq 'Y'}">checked="checked"</c:if> /> 
						<label for="dir_manager_opn_yn_y" class="marginr10">공개</label> 
						<input type="radio" id="dir_manager_opn_yn_n" name="dir_manager_opn_yn" value="N" <c:if test="${cmpyDir.manager_opn_yn ne 'Y'}">checked="checked"</c:if> /> 
						<label for="dir_manager_opn_yn_n">비공개</label></td>
					</tr>
					<tr>
						<th scope="row">뉴스레터 수신여부</th>
						<td>
						<input type="radio" id="dir_newsltr_rcv_yn_y" name="dir_newsltr_rcv_yn" value="Y" <c:if test="${cmpyDir.newsltr_rcv_yn eq 'Y'}">checked="checked"</c:if> /> 
						<label for="dir_newsltr_rcv_yn_y" class="marginr10">예</label> 
						<input type="radio" id="dir_newsltr_rcv_yn_n" name="dir_newsltr_rcv_yn" value="N" <c:if test="${cmpyDir.newsltr_rcv_yn ne 'Y'}">checked="checked"</c:if> /> 
						<label for="dir_newsltr_rcv_yn_n">아니오</label></td>
					</tr>
				</tbody>
			</table>
		</div>