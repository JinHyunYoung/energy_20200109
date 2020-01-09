<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<% pageContext.setAttribute("LF", "\n"); %>

<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/js/announce.js"></script>
<script language="javascript">
var selectRequestUrl = '<c:url value="/admin/request/requestListPage.do" />';
var updateRequestUrl = "<c:url value='/admin/request/updateRequestAnswer.do'/>"
var deleteRequestUrl = "<c:url value='/admin/request/deleteRequest.do'/>";

$( document ).ready( function(){

	
});

function requestInsert(){

   if($("#answer").val() == ""){
	   alert("답변내용은 필수 입력사항입니다.");
	   $("#answer").focus();
	   return;
   }
	
   if ( $("#writeFrm").parsley().validate() ){	   

	   // 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					requestList();
				}	
			},
			dataType: "json",
			url: updateRequestUrl
	    });	
   }	

}

function requestDelete(){
	
	  if(!confirm("삭제하시겠습니까?")) return;
 	 
	    $.ajax({
	        url: deleteRequestUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	        	req_id : $("#req_id").val()
			},
	        success: function(data) {
	        	alert(data.message);
	        	if(data.success == "true") requestList();
	        },
	        error: function(e) {
	            alert("테이블을 가져오는데 실패하였습니다.");
	        }
	    });	
}

function requestList(){
	document.writeFrm.action = selectRequestUrl;
	document.writeFrm.submit();
}

</script>

<!--// content -->
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
		    <input type='hidden' id="req_id" name='req_id' value="${param.req_id}" />
		    <input type='hidden' id=p_req_gb name='p_administ_cd' value="${param.p_req_gb}" />
		    <input type='hidden' id="p_answer" name='p_answer' value="${param.p_answer}" />
		    <input type='hidden' id="p_searchkey" name='p_searchkey' value="${param.p_searchkey}" />
		    <input type='hidden' id="p_searchtxt" name='p_searchtxt' value="${param.p_searchtxt}" />
            
		<!--table_area-->
		<div class="table_area">
			<table class="write">
				<caption>신문고 수정</caption>
				<colgroup>
					<col style="width:180px;">
					<col style="width:*;">
					<col style="width:180px;">
					<col style="width:*;">
				</colgroup>
				<tbody>
					<tr style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
						<th scope="row">신청일시</th>
						<td>
							${request.reg_date}
							<input type="hidden" name="reg_date" value="${request.reg_date}" />
						</td>
						<th scope="row">
							<label for="req_nm">이름</label>
						</th>
						<td>
							${request.user_nm}
							<input type="hidden" name="user_nm" value="${request.user_nm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="req_nm">구분</label>
						</th>
						<td>
							${request.req_gb_nm}
						</td>
						<th scope="row">
							<label for="req_nm">답변상태</label>
						</th>
						<td>
						    <c:if test="${request.answer_no == ''}">답변대기</c:if>
							<c:if test="${request.answer_no != ''}">답변완료</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="req_nm">이메일</label>
						</th>
						<td>
							${request.email}
							<input type="hidden" name="email" value="${request.email}" />
						</td>
						<th scope="row">
							<label for="req_nm">연락처</label>
						</th>
						<td>
							${request.handphone}
							<input type="hidden" name="handphone" value="${request.handphone}" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="req_nm">제목</label>
						</th>
						<td colspan="3">
							${request.title}
							<input type="hidden" name="title" value="${request.title}" />
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="req_nm">첨부파일</label>
						</th>
						<td colspan="3">
						 <c:if test="${!empty request.attach_file}">
	                      <a class="btn btn-xs btn-info" href="/commonfile/fileidDownLoad.do?file_id=${request.attach_file}" >${request.attach_file_nm}</a></p>
	                     </c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="req_nm">내용</label>
						</th>
						<td colspan="3">
							<c:out escapeXml="false" value="${fn:replace(request.contents, LF, '<br>')}"></c:out>
							<input type="hidden" name="contents" value="${request.contents}" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>				
        <!--// table_area -->
	
		<div class="title_area">
			<h4 class="title">답변 내역</h4>
		</div>
		
		<div class="table_area">
			<table class="write">
				<caption>답변 내역</caption>
				<colgroup>
					<col style="width:180px;">
					<col style="width:*;">
				</colgroup>
				<tbody>
					<tr style="display:<c:if test="${empty request.answer_no}">none</c:if>">
						<th scope="row">답변자</th>
						<td>${request.answer_nm}</td>
					</tr>
					<tr>
						<th scope="row">
							<label for="answer">답변내용</label>
						</th>
						<td>
							<textarea id="answer" name="answer" cols="5" rows="10" class="in_w100" data-parsley-required="true" data-parsley-maxlength="2000">${request.answer}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div>	
	
		<!-- button_area -->
		<div class="button_area">
			<div class="float_right">
				<button type="button" class="btn save" title="답변하기" onClick="requestInsert()">
					<span>답변하기</span>
				</button>
				<button type="button" class="btn cancel" title="삭제하기" onClick="requestDelete()" style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
					<span>삭제</span>
				</button>
				<a href="javascript:requestList();" title="목록 페이지로 이동하기" class="btn list">
					<span>목록</span>
				</a>
			</div>
		</div>
		
</form>
</div>
<!--// content -->