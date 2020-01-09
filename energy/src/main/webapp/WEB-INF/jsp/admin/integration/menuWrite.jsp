<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">

	<input type="hidden" id="file_id" name="file_id" value="${menu.file_id}" />
	<input type="hidden" id="seq" name="seq" value="${menu.seq}" /> 
	<input type="hidden" id="image" name="image" value="${menu.image}" /> 
	
	<!-- write_basic -->
	<div class="table_area" style="margin-top:10px;padding-left:10px;padding-right:10px;">
	
		<table class="write">
			<caption>메뉴 등록화면</caption>
			<colgroup>
				<col style="width: 120px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>			
			<c:if test="${param.mode == 'E'}">			
			<tr>
				<th scope="row">메뉴코드</th>
				<td>
				    ${menu.menu_id}
				</td>
			</tr>
			</c:if>
			<tr>
				<th scope="row">메뉴명  <span class="asterisk">*</span></th>
				<td>
 						       <input class="in_w100" type="text" id="menu_nm" name="menu_nm" value="${menu.menu_nm}" placeholder="메뉴명" data-parsley-required="true" data-parsley-maxlength="100" />
				</td>
			</tr>
			<tr>
				<th scope="row">메뉴설명</th>
				<td>
			         <textarea class="in_w100" id="menu_desc" name="menu_desc" placeholder="메뉴설명" rows="2" data-parsley-maxlength="1000" >${menu.menu_desc}</textarea>
				</td>
			</tr>
			<tr style="display:none">
				<th scope="row">메뉴설명이미지</th>
				<td>
		   			  <c:if test="${param.mode == 'E' && !empty menu.image}">
                      <p id="uploadedFile"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${menu.image}" >${menu.image_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile()"></a></p>
                     </c:if> 
                      <input class="in_w100" type="file" id="uploadFile" name="uploadFile" value="" /> 
				</td>
			</tr>
			<tr>
				<th scope="row">메뉴형태</th>
				<td>
				     <g:radio id="menu_type" name="menu_type" codeGroup="MENU_TYPE" checked="30" cls="text-middle" curValue="${menu.menu_type}"  onChange="changeMenuType()" />
				</td>
			</tr>	
			<tr id="menu_type_F" style="display:<c:if test="${menu.menu_type != 'F'}">none</c:if>">
				<th scope="row">참조메뉴</th>
				<td>
					<a href="javascript:menuPopup('F')" class="btn acti" title="선택">
						<span>선택</span>
					</a>	
				    <input type="hidden" id="ref_menu" name="ref_menu" value="${menu.ref_menu}" />
					<span id="ref_menu_nm">${menu.ref_menu_nm}</span>
				</td>
			</tr>	
			<tr id="menu_type_C" style="display:<c:if test="${menu.menu_type != 'C'}">none</c:if>">
				<th scope="row">콘텐츠</th>
				<td>
					<a href="javascript:menuPopup('C')" class="btn acti" title="선택">
						<span>선택</span>
					</a>	
				    <input type="hidden" id="contents" name="contents" value="${menu.contents}" />
					<span id="contents_nm">${menu.contents_nm}</span>
				</td>
			</tr>	
			<tr id="menu_type_B" style="display:<c:if test="${menu.menu_type != 'B'}">none</c:if>">
				<th scope="row">게시판</th>
				<td>
					<a href="javascript:menuPopup('B')"class="btn acti" title="선택">
						<span>선택</span>
					</a>
					<input type="hidden" id="board" name="board" value="${menu.board}" />
					<span id="board_nm">${menu.board_nm}</span>	
				</td>
			</tr>	
			<tr id="menu_type_L" style="display:<c:if test="${menu.menu_type != 'L'}">none</c:if>">
				<th scope="row">URL</th>
				<td>
					 <input class="in_w100" type="text" id="url" name="url" value="${menu.url}" placeholder="URL" data-parsley-required="false" data-parsley-maxlength="100" />
				</td>
			</tr>											
			<tr>
				<th scope="row">GNB 사용여부</th>
				<td>
				     <input type="radio" name="gnb_use_yn" value="Y" <c:if test="${menu.gnb_use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="gnb_use_yn" value="N"  <c:if test="${menu.gnb_use_yn == 'N'}">checked</c:if>> 미사용
				</td>
			</tr>	
			<tr style="display:none">
				<th scope="row">Footer 사용여부</th>
				<td>
				    <%-- <input type="radio" name="footer_use_yn" value="Y" <c:if test="${menu.footer_use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="footer_use_yn" value="N"  <c:if test="${menu.footer_use_yn == 'N'}">checked> 미사용 --%>
				    <input type="hidden" name="footer_use_yn" value="N" /> 
				</td>
			</tr>	
			<tr>
				<th scope="row">사이트맵 사용여부</th>
				<td>
				     <input type="radio" name="sitemap_use_yn" value="Y" <c:if test="${menu.sitemap_use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="sitemap_use_yn" value="N"  <c:if test="${menu.sitemap_use_yn == 'N'}">checked</c:if>> 미사용
				</td>
			</tr>	
			<tr style="display:none">
				<th scope="row">https 지원여부</th>
				<td>
				     <input type="radio" name="https_support_yn" value="Y" <c:if test="${menu.https_support_yn == 'Y'}">checked</c:if>> 지원 <input type="radio" name="https_support_yn" value="N"  <c:if test="${menu.https_support_yn == 'N'}">checked</c:if>> 미지원
				</td>
			</tr>														
			<c:if test="${param.homepage == 'F'}">
			<tr>
				<th scope="row">로그인여부</th>
				<td>
				     <input type="radio" name="login_yn" value="Y" <c:if test="${menu.login_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="login_yn" value="N"  <c:if test="${menu.login_yn == 'N'}">checked</c:if>> 미사용
				</td>
			</tr>														
			</c:if>
			<c:if test="${param.homepage == 'B'}">
			       <input type="hidden" name="login_yn" value="Y" />
			</c:if>		
			<tr>
				<th scope="row">타겟설정</th>
				<td>
				     <g:radio id="target_set" name="target_set" codeGroup="MENU_TARGET" checked="30" cls="text-middle" curValue="${menu.target_set}" onChange="changeTargetSet()" />
				</td>
			</tr>																
			<tr id="popup_field" style="display:<c:if test="${menu.target_set != '3'}">none</c:if>">
				<th scope="row">팝업크기  <span class="asterisk">*</span></th>
				<td>
				     가로 <input class="form-control onlynum" type="text" id="width" name="width" value="${menu.width}" placeholder="팝업크기 가로" data-parsley-type="number" style="width:50px"/> X 
					 세로 <input class="form-control onlynum" type="text" id="height" name="height" value="${menu.height}" placeholder="팝업크기 세로" data-parsley-type="number" style="width:50px"/>
				</td>
			</tr>																
			<tr id="popup_field" style="display:<c:if test="${menu.target_set != '3'}">none</c:if>">
				<th scope="row">팝업위치  <span class="asterisk">*</span></th>
				<td>
	    			Top <input class="form-control onlynum" type="text" id="top" name="top" value="${menu.top}" placeholder="팝업위치 Top" style="width:50px"/> X 
					 Left <input class="form-control onlynum" type="text" id="left" name="left" value="${menu.left}" placeholder="팝업위치 Left" style="width:50px"/>
				</td>
			</tr>																
			<tr>
				<th scope="row">사용여부</th>
				<td>
					   <input type="radio" name="use_yn" value="Y" <c:if test="${menu.use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="use_yn" value="N"  <c:if test="${menu.use_yn == 'N'}">checked</c:if>> 미사용 
				</td>
			</tr>																
			</tbody>
		</table>
	</div>
	<!--// write_basic -->
	
	<!-- footer --> 
	<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode == 'W'}">
				<a href="javascript:menuInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
	                <c:if test="${param.mode == 'E' }">
	                	<a href="javascript:menuInsert()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:menuDelete()" class="btn save" title="삭제">
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