<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<script language="javascript">
	$(document).ready(function(){
		if($("#p_region").val() == "1"){
			$("#img_txt").html("※ 물산업 바로가기 : 가로 50px  x  세로 50px");
		}else if($("#p_region").val() == "2"){
			$("#img_txt").html("※ 바로가기 : 가로 352px  x  세로 190px");
		}else{
			$("#img_txt").html("");
		}
		
	});
</script>

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true" enctype="multipart/form-data">

	<input type="hidden" id="image" name="image" value="${banner.image}" /> 
	<input type='hidden' id="banner_id" name='banner_id' value="${banner.banner_id}" />
	<input type='hidden' id="region" name='region' value="${banner.region}" />
	
	<!-- write_basic -->
	<div class="table_area">
		<table class="write">
			<caption>배너 등록화면</caption>
			<colgroup>
				<col style="width: 140px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			<c:if test="${param.mode == 'E' }">
			<tr>
				<th scope="row">코드</th>
				<td>
                         ${banner.banner_id}
				</td>
			</tr>
			</c:if>				
			<tr>
				<th scope="row">이미지/타이틀명 <span class="asterisk">*</span></th>
				<td>
				    <input class="in_w100" type="text" id="titl_nm" name="titl_nm" value="${banner.titl_nm}" placeholder="이미지/타이틀명"  data-parsley-required="true" data-parsley-maxlength="100"  />
				</td>
			</tr>
			<tr>
				<th scope="row">이미지/타이틀 ALT</th>
				<td>
                        <input class="in_w100" type="text" id="titl_alt" name="titl_alt" value="${banner.titl_alt}" placeholder="이미지/타이틀 ALT"  data-parsley-required="false" data-parsley-maxlength="100"  />
                    </td>
			</tr>
			<tr>
				<th scope="row">이미지</th>
				<td>
				    <c:if test="${param.mode == 'E' && !empty banner.image}">
                      <p id="uploadedFile"><a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${banner.image}" >${banner.image_nm}</a> <a class="fa fa-1x fa-trash-o" style="cursor:pointer" onClick="delFile()"></a>
                            <image src="/contents/banner/${banner.image_nm}" width="100" height="50" /> 
                      </p>
                     </c:if> 
                     <input class="in_w100" type="file" id="uploadFile" name="uploadFile" value="" />
                     <span id="img_txt"></span>
				</td>
			</tr>
			<tr>
				<th scope="row">URL</th>
				<td>
					  <input class="in_w100" type="text" id="url" name="url" value="${banner.url}" placeholder="URL" data-parsley-required="false" data-parsley-maxlength="200" /> 
				</td>
			</tr>
			<tr>
				<th scope="row">타겟설정</th>
				<td>
					 <g:radio id="target" name="target" codeGroup="BANNER_TARGET" checked="30" cls="text-middle" curValue="${banner.target}" />
				</td>
			</tr>	
			<tr>
				<th scope="row">사용여부</th>
				<td>
					 <input type="radio" name="use_yn" value="Y" <c:if test="${banner.use_yn == 'Y'}">checked</c:if>> 사용 <input type="radio" name="use_yn" value="N"  <c:if test="${banner.use_yn == 'N'}">checked</c:if>> 미사용 
				</td>
			</tr>							
			<c:if test="${param.mode == 'E' }">
			<tr>
				<th scope="row">등록자</th>
				<td>
                              ${banner.reg_usernm}
				</td>
			</tr>
			<tr>
				<th scope="row">등록일</th>
				<td>
                              ${banner.reg_date}
				</td>
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
				<a href="javascript:bannerInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
	                <c:if test="${param.mode == 'E' }">
	                	<a href="javascript:bannerInsert()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:bannerDelete('${banner.banner_id}')" class="btn save" title="등록">
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