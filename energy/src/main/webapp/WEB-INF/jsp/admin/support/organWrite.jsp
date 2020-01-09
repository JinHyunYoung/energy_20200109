<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var insertOrganUrl = "<c:url value='/admin/organ/insertOrgan.do'/>";
var updateOrganUrl = "<c:url value='/admin/organ/updateOrgan.do'/>"
var deleteOrganUrl = "<c:url value='/admin/organ/deleteOrgan.do'/>";
var organListPageUrl = "<c:url value='/admin/organ/organListPage.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";

$(document).ready(function(){
	$(".onlynum").keyup( setNumberOnly );	
	
	// 파일 삭제
	$('.file_area .btn_file_delete').click(function() {
	    
        if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
            
            var el = this;
            
            $.post(        	    
           		deleteFileUrl,
                {file_id : $(el).data("file_id")},
                function(data) {
                    if (data.success == "true") {
                        var len =$(el).parent().siblings().length;
                        if (len <= 0) {
                            $(el).closest('div').siblings('input').val('');
                        }
                        $(el).parent().remove();
                    } else {
                        alert(data.message);
                    }
                }
            );
        }
    });
});


// 사용자 리스트 조회
function organListPage() {
    
    var f = document.searchForm;
    
    f.target = "_self";
    f.action = organListPageUrl;
    f.submit();
}


// 사용자 추가
function organInsert(mode){ 
	
	// 썸네일은 이미지형식으로저장
	if ($("#thumb").val() != "" && !$("#thumb").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
		alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
		return;
	} 
	    
	var url = "";
	if ( $("#writeFrm").parsley().validate() ){
	     
		if(!(($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "") || 
			($("#tel_1").val() == "" && $("#tel_2").val() == "" && $("#tel_3").val() == ""))){
		    
			alert("전화번호를 정확히 입력해주십시요");
			$("#tel_1").focus();
			return;
		}
				
		if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
			$("#organ_tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
		} else {
			$("#organ_tel").val("");
		}
		
				   
	   	url = insertOrganUrl;
	   	if($("#mode").val() == "E") {
	   	    url = updateOrganUrl; 
	   	}
	   		   
	   // 데이터를 등록 처리해준다.
	   $("#writeFrm").ajaxSubmit({
			success: function(
				responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						organListPage();
					}	
 				},
 				dataType: "json",
 				data : {
 				},
 				url: url
		});	
			   
	}
}

// 관리자 삭제
function organDelete(){
    
	if(!confirm("유관기관를 정말 삭제하시겠습니까?")) return;
	   
	$.ajax
	({
		type: "POST",
           url: deleteOrganUrl,
           data:{
           	organ_no : $("#organ_no").val()
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				organListPage();
			}	
		}
	});
}

//주소 설정
function setAddr(roadAddr, jibunAddr, zipNo, admCd){	
	$("#post").val(zipNo);
	$("#addr1").val(roadAddr);
	$("#addr2").val("");
}


</script>


<!-- content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">${admin_g_submenu_nm}</h3>
		</div>
		<!--// main_title -->
		
		<jsp:include page="/WEB-INF/jsp/admin/integration/menuDescInclude.jsp"/>
		
	</div>	
	
	<form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		
		<input type='hidden' id="p_domestic_yn" name='p_domestic_yn' value="${param.p_domestic_yn}" />
		<input type='hidden' id="p_organ_gb" name='p_organ_gb' value="${param.p_organ_gb}" />
		<input type='hidden' id="p_use_yn" name='p_use_yn' value="${param.p_use_yn}" />
		<input type='hidden' id="p_organ_nm" name='p_organ_nm' value="${param.p_organ_nm}" />
				
	    <input type='hidden' id="organ_no" name='organ_no' value="${organ.organ_no}" />
	    <input type='hidden' id="organ_tel" name='organ_tel' value="${organ.organ_no}" />
		<input type='hidden' id="image_file_id" name='image_file_id' value="${organ.image_file_id }" />
			     
		<!-- write_basic -->
		<div class="table_area">
			  <table class="write">
			  
				<caption>상세보기 화면</caption>
				
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				
					<%-- 국내외구분 --%>
					<tr>
						<th scope="row">국내외구분</th>
						<td>
							<input id="domestic_yn_yes" name="domestic_yn" value="Y" type="radio" class="marginl10" <c:if test="${organ.domestic_yn == 'Y' or organ.domestic_yn == null}">checked="checked"</c:if>>
							<label for="domestic_yn_yes">국내</label>
							<input id="domestic_yn_no" name="domestic_yn" value="N" type="radio"  class="marginl10" <c:if test="${organ.domestic_yn == 'N'}">checked="checked"</c:if>>
							<label for="domestic_yn_no">해외</label>
						</td>
					</tr>
										
					<%-- 기관구분 --%>
					<tr>
						<th>구분 <span class="asterisk">*</span></th>
						<td>
			            	<g:select id="organ_gb" name="organ_gb" codeGroup="ORGAN_GB" selected="${organ.organ_gb}" cls="form-control" />  	                      
						</td>
					</tr>
					
					
					<%-- 기관명 --%>					
					<tr>
						<th scope="row">기관명  <span class="asterisk">*</span></th>
						<td colspan="3">
						    <input class="form-control" type="text" id="organ_nm" name="organ_nm" value="${organ.organ_nm}" style="width:100%" placeholder="이름" data-parsley-required="true" data-parsley-maxlength="200" />						    
						</td>
					</tr>
					 			
					 				
					<%-- 전화번호 --%>																										
					<tr>
						<th scope="row">전화번호</th>
						<td colspan="3">
                            <select id='tel_1' name='tel_1' title='자택전화 첫번째자리' class="in_wp70">
								<option value='' >선택</option>
								<option value='02' <c:if test="${organ.tel_1 == '02'}">selected</c:if>>02</option>
								<option value='051' <c:if test="${organ.tel_1 == '051'}">selected</c:if>>051</option>
								<option value='053' <c:if test="${organ.tel_1 == '053'}">selected</c:if>>053</option>
								<option value='032' <c:if test="${organ.tel_1 == '032'}">selected</c:if>>032</option>
								<option value='062' <c:if test="${organ.tel_1 == '062'}">selected</c:if>>062</option>
								<option value='042' <c:if test="${organ.tel_1 == '042'}">selected</c:if>>042</option>
								<option value='052' <c:if test="${organ.tel_1 == '052'}">selected</c:if>>052</option>
								<option value='044' <c:if test="${organ.tel_1 == '044'}">selected</c:if>>044</option>
								<option value='031' <c:if test="${organ.tel_1 == '031'}">selected</c:if>>031</option>
								<option value='033' <c:if test="${organ.tel_1 == '033'}">selected</c:if>>033</option>
								<option value='043' <c:if test="${organ.tel_1 == '043'}">selected</c:if>>043</option>
								<option value='041' <c:if test="${organ.tel_1 == '041'}">selected</c:if>>041</option>
								<option value='063' <c:if test="${organ.tel_1 == '063'}">selected</c:if>>063</option>
								<option value='061' <c:if test="${organ.tel_1 == '061'}">selected</c:if>>061</option>
								<option value='054' <c:if test="${organ.tel_1 == '054'}">selected</c:if>>054</option>
								<option value='055' <c:if test="${organ.tel_1 == '055'}">selected</c:if>>055</option>
								<option value='064' <c:if test="${organ.tel_1 == '064'}">selected</c:if>>064</option>
								<option value='070' <c:if test="${organ.tel_1 == '070'}">selected</c:if>>070</option>
                           </select>
                           - <input id="tel_2" name="tel_2" type="text" value="${organ.tel_2}" class="in_wp40 onlynum" maxlength="4" />
                           - <input id="tel_3" name="tel_3" type="text" value="${organ.tel_3}" class="in_wp40 onlynum" maxlength="4" />
						</td>
					</tr>
					
					
					<%-- 홈페이지 --%>		
					<tr>
						<th scope="row">홈페이지 URL</th>
						<td colspan="3">
						    <input class="form-control" type="text" id="organ_homepage" name="organ_homepage" value="${organ.organ_homepage}" style="width:100%" placeholder="홈페이지 URL" />						    
						</td>
					</tr>
					
					
					<%-- 주소 --%>		
					<tr>
						<th scope="row">주소</th>
						<td>
							<input id="post" name="post" type="text" value="${organ.post}" placeholder="우편번호" class="in_wp70"  />	
							<a href="javascript:jusoPopupShow();" class="btn look" title="주소찾기">
								<span>주소찾기</span>
							</a>
							</br>
							<input id="addr1" name="addr1" type="text" value="${organ.addr1}" placeholder="기본주소"  class="in_w50" style="margin-top:5px" readOnly /></br>	
							<input id="addr2" name="addr2" type="text" value="${organ.addr2}" placeholder="상세주소" class="in_w50" style="margin-top:5px" data-parsley-maxlength="200" />	
						</td>
					</tr>	
					
					
					<%-- 관리기관 --%>		
					<tr>
						<th scope="row">관리기관</th>
						<td colspan="3">
						    <input class="form-control" type="text" id="mt_organ_nm" name="mt_organ_nm" value="${organ.mt_organ_nm}" style="width:100%" placeholder="관리기관" />						    
						</td>
					</tr>
					
					
					<%-- 기관로고 --%>
					<tr>
						<th scope="row">이미지 <span class="asterisk">*</span></th>
						<td>
							<div class="file_area">
								<label for="thumb" class="hidden">파일 선택하기</label>
								<input class="form-control in_w50" type="file" id="thumb" name="thumb" value="" <c:if test="${param.mode eq 'W'}">data-parsley-required="true"</c:if> />
							</div>
							<c:if test="${param.mode eq 'E' && not empty organ.image_file_nm}">
							<div class="file_area" id="uploadedFile">
								<ul class="file_list">
									<li>
										<a href="#" title="기관로고">${organ.image_file_nm}</a>
										<a href="javascript:;" class="btn_file_delete" data-file_id="${organ.image_file_id}" title="파일 삭제">
											<img src="/images/admin/icon/icon_delete.png" alt="삭제" />
										</a>
									</li>
								</ul>
							</div>
							</c:if>
						</td>
					</tr>
				
				
					<%-- 사용여부 --%>
					<tr>
						<th scope="row">사용여부</th>
						<td>
							<input id="use_yn_yes" name="use_yn" value="Y" type="radio" class="marginl10" <c:if test="${organ.use_yn == 'Y' or organ.use_yn == null}">checked="checked"</c:if>>
							<label for="use_yn_yes">사용</label>
							<input id="use_yn_no" name="use_yn" value="N" type="radio"  class="marginl10" <c:if test="${organ.use_yn == 'N'}">checked="checked"</c:if>>
							<label for="use_yn_no">미사용</label>
						</td>
					</tr>
					
					
					<%-- 등록자 --%>		
					<c:if test="${param.mode eq 'E'}">
					<tr>
						<th scope="row">등록자</th>
						<td colspan="3">${organ.reg_usernm}</td>
					</tr>
					</c:if>
					
					
					<%-- 등록일 --%>		
					<c:if test="${param.mode eq 'E'}">
					<tr>
						<th scope="row">등록일</th>
						<td colspan="3">${organ.reg_date}</td>
					</tr>	
					</c:if>				
					
				</tbody>
			</table>
		</div>
		<!--// write_basic -->
			
		<!-- button_area -->
		<div class="button_area">
			<div class="float_right">
			
		        <c:if test="${param.mode == 'W'}">
				<a href="javascript:organInsert('W');" class="btn save" title="등록">
					<span>등록</span>
				</a>
               </c:if>
               
               <c:if test="${param.mode == 'E' }">
				<a href="javascript:organInsert('M');" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:organDelete();" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
				</c:if>
				
				<a href="javascript:organListPage();" class="btn cancel" title="취소">
					<span>취소</span>
				</a>
			</div>
		</div>
		<!--// button_area -->
		
	</form>
	<form id="searchForm" name="searchForm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
	</form>
	
</div>
<!--// content -->

 <jsp:include page="/WEB-INF/jsp/admin/common/jusoSearchPopup.jsp"/>