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

	<center class="con_img2"><img src="../../../images/sub/imp/imp-05-02-01.png" alt="접수안내 > 교육신청서 작성 > 접수완료 > 교육비 납부 및 확인"></center>

	<ul class="sub_content3">
		<li class="title_area">접수 가능한 사진 범위</li>
	</ul>


	<div class="table_area_01 margint20">
		<table>
			<caption>접수 가능한 사진 범위</caption>
			<colgroup>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>구분</th>
					<th>내용</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>접수 가능사진</td>
					<td>6개월 이내 촬영한 (3×4cm) 칼라사진, 상반신 정면, 무배경</td>
				</tr>
				<tr>
					<td>접수 불가능 사진</td>
					<td>스냅사진, 선글라스, 스티커사진, 측면사진, 모자착용 기타 신분확인이 불가한 사진</td>
				</tr>
				<tr>
					<td>본인사진이 아닐 경우 조치</td>
					<td>본인사진이 아니고, 신분증 미지참시 시험응시 불가(퇴실)조치</td>
				</tr>
			</tbody>
		</table>
	</div>


	<ul class="sub_content3">
		<li class="title_area">신분증 인정법위</li>
	</ul>


	<div class="table_area_01 margint20">
		<table>
			<caption>신분증 인정법위</caption>
			<colgroup>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>신분증 인정범위 (모든 수험자 적용)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>주민등록증, 운전면허증(국내), 여권, 주민센터 발급 주민등록 발급 신청서</td>
				</tr>
				<tr>
					<td>
						* 시험에 응시하는 수험자는 위에서 저하는 신분증 중 1개를 반드시 지참하여야 하며, 신분 미확인 등에 따른 불이익은 수험자 책임입니다.<BR />
						* 상기 신분증은 유효기간 이내의 것만 가능하며 위에서 정하는 신분증 외에는 인정하지 않습니다.
					
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<ul class="sub_content3">
		<li class="title_area">자격검정 재시험의 제한</li>
		<li class="contents_txt2">
			관리·운영규정 제20조<BR />
			자격검정 재시험 응시자격은 양성과정 교육 이수 1년 이내에만 유효하며, 기간이 지나면 재시험 응시자격은 소멸
		</li>
	</ul>

	<ul class="sub_content3">
		<li class="title_area">자격검정비</li>
		<li class="contents_txt2">
			관리 · 운영규정 제15조 <BR />
			양성과정 교육 신규 이수 500,000원, 재교육 100,000원, 재시험 100,000원 <BR />
			자격증 재교부 수수료 10,000원
		</li>
	</ul>


	<ul class="sub_content3">
		<li class="title_area">자격검정비의 환불</li>
		<li class="contents_txt2"> 관리 · 운영규정 제15조 </li>
	</ul>

	<div class="table_area_01 margint5">
		<table>
			<caption>신분증 인정법위</caption>
			<colgroup>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>구분</th>
					<th>내용</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>자격검정비 환불</td>
					<td class="alignl">
						자격검정비를 과오납한 경우 : 과오납 금액 환불<BR />
						접수기간 내 취소를 한 경우 : 전액 환불<BR />
						검정기관의 귀책사유로 인하여 검정에 응하지 못한 경우 : 전액 환불<BR />
						양성과정 교육 및 검정시행 전일까지 접수를 취소한 경우 : 전액 환불
					</td>
				</tr>
				<tr>
					<td>자격검정비 환불 불가</td>
					<td class="alignl">
						양성과정 교육을 무단으로 불참한 경우<BR />
						자격검정시험에 무단으로 불참한 경우
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="button_area">
		<a href="/web/education/educationApplyCerti.do" title="교육신청서 작성"  style="background: #bea214;" target="_self">교육신청서 작성</a>
	</div>
