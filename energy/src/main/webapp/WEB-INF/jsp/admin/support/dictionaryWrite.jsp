<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var insertDictionaryUrl = "<c:url value='/admin/dictionary/insertDictionary.do'/>";
var updateDictionaryUrl = "<c:url value='/admin/dictionary/updateDictionary.do'/>"
var deleteDictionaryUrl = "<c:url value='/admin/dictionary/deleteDictionary.do'/>";
var dictionaryListPageUrl = "<c:url value='/admin/dictionary/dictionaryListPage.do'/>";


$(document).ready(function(){

});


// 사용자 리스트 조회
function dictionaryListPage() {
    
    var f = document.writeFrm;
    
    f.target = "_self";
    f.action = dictionaryListPageUrl;
    f.submit();
}


// 사용자 추가
function dictionaryInsert(mode){	
	    
	var url = "";
	
	if ( $("#writeFrm").parsley().validate() ){
				   
	   	url = insertDictionaryUrl;
	   	if($("#mode").val() == "E") {
	   	    url = updateDictionaryUrl; 
	   	}	   		   
	   
	   $("#writeFrm").ajaxSubmit({
			success: function(
				responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						dictionaryListPage();
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
function dictionaryDelete(){
    
	if(!confirm("용어를 정말 삭제하시겠습니까?")) return;
	   
	$.ajax
	({
		type: "POST",
           url: deleteDictionaryUrl,
           data:{
           	term_sn : $("#term_sn").val()
           },
           dataType: 'json',
		success:function(data){
			alert(data.message);
			if(data.success == "true"){
				dictionaryListPage();
			}	
		}
	});
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
		
		<input type='hidden' id="p_kr_idx" name='p_kr_idx' value="${param.p_kr_idx}" />
		<input type='hidden' id="p_en_idx" name='p_en_idx' value="${param.p_en_idx}" />
		<input type='hidden' id="p_term_kr_nm" name='p_term_kr_nm' value="${param.p_term_kr_nm}" />
		<input type='hidden' id="p_term_en_nm" name='p_term_en_nm' value="${param.p_term_en_nm}" />
				
	    <input type='hidden' id="term_sn" name='term_sn' value="${dictionary.term_sn}" />
	    
			     
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
					
					<tr>
						<th scope="row">국문색인</th>
						<td>
							<select id="kr_idx" name="kr_idx" style="width:100px;">
								<option value="">- 국문전체 -</option>
								<option value="ㄱ" <c:if test="${dictionary.kr_idx eq 'ㄱ' }" >selected="selected"</c:if> >ㄱ</option>
								<option value="ㄴ" <c:if test="${dictionary.kr_idx eq 'ㄴ' }" >selected="selected"</c:if> >ㄴ</option>
								<option value="ㄷ" <c:if test="${dictionary.kr_idx eq 'ㄷ' }" >selected="selected"</c:if> >ㄷ</option>
								<option value="ㄹ" <c:if test="${dictionary.kr_idx eq 'ㄹ' }" >selected="selected"</c:if> >ㄹ</option>
								<option value="ㅁ" <c:if test="${dictionary.kr_idx eq 'ㅁ' }" >selected="selected"</c:if> >ㅁ</option>
								<option value="ㅂ" <c:if test="${dictionary.kr_idx eq 'ㅂ' }" >selected="selected"</c:if> >ㅂ</option>
								<option value="ㅅ" <c:if test="${dictionary.kr_idx eq 'ㅅ' }" >selected="selected"</c:if> >ㅅ</option>
								<option value="ㅇ" <c:if test="${dictionary.kr_idx eq 'ㅇ' }" >selected="selected"</c:if> >ㅇ</option>
								<option value="ㅈ" <c:if test="${dictionary.kr_idx eq 'ㅈ' }" >selected="selected"</c:if> >ㅈ</option>
								<option value="ㅊ" <c:if test="${dictionary.kr_idx eq 'ㅊ' }" >selected="selected"</c:if> >ㅊ</option>
								<option value="ㅋ" <c:if test="${dictionary.kr_idx eq 'ㅋ' }" >selected="selected"</c:if> >ㅋ</option>
								<option value="ㅌ" <c:if test="${dictionary.kr_idx eq 'ㅌ' }" >selected="selected"</c:if> >ㅌ</option>
								<option value="ㅍ" <c:if test="${dictionary.kr_idx eq 'ㅍ' }" >selected="selected"</c:if> >ㅍ</option>
								<option value="ㅎ" <c:if test="${dictionary.kr_idx eq 'ㅎ' }" >selected="selected"</c:if> >ㅎ</option>
							</select>		
						</td>
					</tr>
					
					<tr>
						<th scope="row">영문색인</th>
						<td>
							<select id="en_idx" name="en_idx" style="width:100px;">
								<option value="">- 영문전체 -</option>
								<option value="A" <c:if test="${dictionary.en_idx eq 'A' }" >selected="selected"</c:if> >A</option>
								<option value="B" <c:if test="${dictionary.en_idx eq 'B' }" >selected="selected"</c:if> >B</option>
								<option value="C" <c:if test="${dictionary.en_idx eq 'C' }" >selected="selected"</c:if> >C</option>
								<option value="D" <c:if test="${dictionary.en_idx eq 'D' }" >selected="selected"</c:if> >D</option>
								<option value="E" <c:if test="${dictionary.en_idx eq 'E' }" >selected="selected"</c:if> >E</option>
								<option value="F" <c:if test="${dictionary.en_idx eq 'F' }" >selected="selected"</c:if> >F</option>
								<option value="G" <c:if test="${dictionary.en_idx eq 'G' }" >selected="selected"</c:if> >G</option>
								<option value="H" <c:if test="${dictionary.en_idx eq 'H' }" >selected="selected"</c:if> >H</option>
								<option value="I" <c:if test="${dictionary.en_idx eq 'I' }" >selected="selected"</c:if> >I</option>
								<option value="J" <c:if test="${dictionary.en_idx eq 'J' }" >selected="selected"</c:if> >J</option>
								<option value="K" <c:if test="${dictionary.en_idx eq 'K' }" >selected="selected"</c:if> >K</option>
								<option value="L" <c:if test="${dictionary.en_idx eq 'L' }" >selected="selected"</c:if> >L</option>
								<option value="M" <c:if test="${dictionary.en_idx eq 'M' }" >selected="selected"</c:if> >M</option>
								<option value="N" <c:if test="${dictionary.en_idx eq 'N' }" >selected="selected"</c:if> >N</option>
								<option value="O" <c:if test="${dictionary.en_idx eq 'O' }" >selected="selected"</c:if> >O</option>
								<option value="P" <c:if test="${dictionary.en_idx eq 'P' }" >selected="selected"</c:if> >P</option>
								<option value="Q" <c:if test="${dictionary.en_idx eq 'Q' }" >selected="selected"</c:if> >Q</option>
								<option value="R" <c:if test="${dictionary.en_idx eq 'R' }" >selected="selected"</c:if> >R</option>
								<option value="S" <c:if test="${dictionary.en_idx eq 'S' }" >selected="selected"</c:if> >S</option>
								<option value="T" <c:if test="${dictionary.en_idx eq 'T' }" >selected="selected"</c:if> >T</option>
								<option value="U" <c:if test="${dictionary.en_idx eq 'U' }" >selected="selected"</c:if> >U</option>
								<option value="V" <c:if test="${dictionary.en_idx eq 'V' }" >selected="selected"</c:if> >V</option>
								<option value="W" <c:if test="${dictionary.en_idx eq 'W' }" >selected="selected"</c:if> >W</option>
								<option value="X" <c:if test="${dictionary.en_idx eq 'X' }" >selected="selected"</c:if> >X</option>
								<option value="Y" <c:if test="${dictionary.en_idx eq 'Y' }" >selected="selected"</c:if> >Y</option>
								<option value="Z" <c:if test="${dictionary.en_idx eq 'Z' }" >selected="selected"</c:if> >Z</option>
								<option value="etc" <c:if test="${dictionary.en_idx eq 'etc' }" >selected="selected"</c:if> >etc</option>
							</select>		
						</td>
					</tr>
										
					<tr>
						<th scope="row">한글명 <span class="asterisk">*</span></th>
						<td colspan="3">
			            	<input class="form-control" type="text" id="term_kr_nm" name="term_kr_nm" value="${dictionary.term_kr_nm}" style="width:100%" placeholder="한글명" data-parsley-required="true" data-parsley-maxlength="100" />  	                      
						</td>
					</tr>
										
					<tr>
						<th scope="row">영문명 </th>
						<td colspan="3">
						    <input class="form-control" type="text" id="term_en_nm" name="term_en_nm" value="${dictionary.term_en_nm}" style="width:100%" placeholder="영문명" data-parsley-required="false" data-parsley-maxlength="200" />						    
						</td>
					</tr>
																															
					<tr>
						<th scope="row">용어정의 <span class="asterisk">*</span></th>
						<td colspan="3">
                           <textarea name="term_dfn" id="term_dfn" style="width:100%;height:100px;" placeholder="용어정의" data-parsley-required="true" data-parsley-maxlength="2000">${dictionary.term_dfn}</textarea>
						</td>
					</tr>										
							
					<c:if test="${param.mode eq 'E'}">
					<tr>
						<th scope="row">등록자</th>
						<td colspan="3">${dictionary.reg_usernm}</td>
					</tr>
					</c:if>
							
					<c:if test="${param.mode eq 'E'}">
					<tr>
						<th scope="row">등록일</th>
						<td colspan="3">${dictionary.reg_date}</td>
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
				<a href="javascript:dictionaryInsert('W');" class="btn save" title="등록">
					<span>등록</span>
				</a>
               </c:if>
               
               <c:if test="${param.mode == 'E' }">
				<a href="javascript:dictionaryInsert('M');" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:dictionaryDelete();" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
				</c:if>
				
				<a href="javascript:dictionaryListPage();" class="btn cancel" title="취소">
					<span>취소</span>
				</a>
			</div>
		</div>
		<!--// button_area -->
		
	</form>
	
</div>
<!--// content -->

 <jsp:include page="/WEB-INF/jsp/admin/common/jusoSearchPopup.jsp"/>