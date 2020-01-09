<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var supportreqInsertUrl = '<c:url value="/web/support/supportreqInsert.do" />';

$( document ).ready( function(){
	

	
});

function authTunnel(data,type){
	$("#req_nm").val(data['name']);
	$("#gender").val(data['gender']);
	$("#birth").val(data['birth']);

	if(type=="phone"){
		$("#phone").val(data['phone']);
	}	
	
	$("#vDupCode").val(data['di']);
	document.supportFrm.action = "<c:url value='/web/support/supportreqWrite.do'/>";
	document.supportFrm.submit();
}

window.name ="master_window";
function openAuth(url,type){
       
	document.supportFrm.action = "<c:url value='/web/support/supportreqWrite.do'/>";
	document.supportFrm.submit();
	/*
	 if(type == 'ipin'){
		var url = "<c:url value = '/web/common/ipin.do'/>";
		var win = window.open(null,"ipin", 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	 }else{
		var url = "<c:url value = '/web/common/phone.do'/>";
		var win = window.open(url, 'checkPlus', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	}
	win.document.write('<iframe width="100%" height="100%" src="'+url+'" frameborder="0"></iframe>');
    */
}


</script>


	<div class="alert_txt bold margint40">${param.user_nm} 님의 교육 신청 및 이수 내역입니다.</div>
	<div class="table_area_01 margint10">
		<table>
			<caption>증빙서류 등록</caption>
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>

			<thead>
				<tr>
					<th>NO.</th>
					<th>회차</th>
					<th>일자</th>
					<th>신청일</th>
					<th>교육구분</th>
					<th>상태</th>
					<th>결과</th>
				</tr>
			</thead>
			<tbody>
                <c:forEach items="${applyList }" var="list" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${list.seq }</td>
					<td>${list.apply_priod }</td>
					<td>${list.reg_date }</td>
					<td>${list.edu_gb_nm }</td>
					<td>${list.apply_status_nm }</td>
					<td>${list.pass_status_nm }</td>
				</tr>
               </c:forEach> 

			</tbody>
		</table>
	</div>
