<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" />

<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="<c:url value='/smarteditor2/js/service/HuskyEZCreator.js' />" charset="utf-8"></script>


<script language="javascript">

var listUrl = "<c:url value='/admin/board/boardContentsListPage.do'/>";
var insertBoardContentsUrl = "<c:url value='/admin/board/insertBoardContents.do'/>";
var insertBoardContentsReplyUrl = "<c:url value='/admin/board/insertBoardContentsReply.do'/>";
var updateBoardContentsUrl = "<c:url value='/admin/board/updateBoardContents.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var maxNoti = "${boardinfo.noti_num}";
var notiCnt = "${boardinfo.noti_cnt}";

$(document).ready(function(){
    
	if($("#mode").val() != "E") {
	    
	 	// 현재날짜 선택
	    $("#reservation_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));	
	 	
	    $("#contents_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));	
	}
	
	// 첨부파일 갯수 확인
	chkMaxFile();
	
	//캡차 이미지 요청
	imgRefresh(); 

	//예약일 현재
	$("#reservationY").click(function() {
	    
	 // 현재날짜 선택
		$("#reservation_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));	
	 });
	
	//예약일 작성
	$("#reservationN").click(function() {
		$("#reservation_date").val("");
	 });
	
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
                        chkMaxFile();
                    } else {
                        alert(data.message);
                    }
                }
            );
        }
    });
		
	$('.personal_chk_btn button.close').hide(); 
	
	//개인정보 수집 및 이용에 동의 닫기
	$('.personal_chk_btn button.close').on("click",function(){
	    $(".personal_chk_btn").removeClass('on');
	    $(".personal_chk_open").removeClass('on');
	    $('.personal_chk_btn button.close').hide();
	    $('.personal_chk_btn button.open').show();
	});
	
	//개인정보 수집 및 이용에 동의 자세히보기
	$('.personal_chk_btn button.open').on("click",function(){
	    $(".personal_chk_btn").addClass('on');
	    $(".personal_chk_open").addClass('on');
	    $('.personal_chk_btn button.open').hide();
	    $('.personal_chk_btn button.close').show();
	});

});


// 컨텐츠 작성
function contentsWrite(){
	
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	
	if ( $("#writeFrm").parsley().validate() ){
		   
		// 썸네일은 이미지형식으로저장
		if ($("#thumb").val() != "" && !$("#thumb").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
			alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
			return;
		} 
		   
		var url = "";
		if($("#mode").val() == "E"){
			url = updateBoardContentsUrl;
		} else if($("#mode").val() == "R") {
			url = insertBoardContentsReplyUrl;
		} else { 
			url = insertBoardContentsUrl;
		}
	   
		$("#email").val($("#email_1").val()+"@"+$("#email_2").val());   
				
		if($("#mode").val() == "W" && $("#email_recvY").is(":checked")){
			
			if($("#agreement").is(":checked") == false ){
				alert("개인정보 수집 및 이용에 동의가 필요합니다.");
				return;			
			}
			
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			if(!regEmail.test($("#email").val())) {
				alert("이메일 주소가 유효하지 않습니다.");
				return;			
			}
		}
	   
		// 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success : function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
				    goList();
				}	
			},
			dataType: "json",
			url: url
	    });	
	}	   
}


// 리스트로 이동
function goList(){
    
	var f = document.writeFrm;
	   
    f.target = "_self";
    f.action = listUrl;
    f.submit();
}


// 첨부파일 삭제
function delFile(gubun){
	if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
		$("#image_file_id").val("");
		$("#uploadedFile").hide();
	}
}


// 첨부파일 추가
function addFile() {
    
    var maxFile = "${boardinfo.attach_num}";
    var len1 = $('#attach_file div.file_area').length;
    var len2 = $('#file_area1 ul li').length;
    var len = len1 + len2;
    if (len >= maxFile) {
        alert('파일 업로드는 최대 '+ maxFile +'개 까지 가능합니다');
        return;
    }

    var html = ''; 
    html += '<div class="file_area">';
    html += '	<label for="attached_file1" class="hidden">파일 선택하기</label>';
    html += '	<input id="attach[]" name="attach[]" type="file" class="in_wp400">';
    html += '	<button type="button" title="삭제하기" onclick="$(this).parent().remove();">';
    html += '		<span><img src="/images/admin/common/btn_file_delete.png" alt="파일삭제하기" /></span>';
    html += ' 	</button>';
    html += '</div>';

    $('#attach_file').append(html);
}


// 첨부파일 4개이상 숨김
function chkMaxFile(){
    
	var maxFile = "${boardinfo.attach_num}";
	var len = $('#file_area1 ul li').length;
	
	if (len >= maxFile) {
		$("#attach_file").hide();
	} else {
		$("#attach_file").show();
	}
	
	// 최대 첨부파일이 1개면 파일추가 숨기기 
	if(maxFile == 1){
		$("#addbtn").hide();
	}
}


// 고정 공지 체크
function chkNoti(){
	if(maxNoti > notiCnt){
	    
	} else{
		alert("고정 공지사항 갯수를 초과하였습니다.");
		$("#notiN").prop('checked', true) ;
	}
}


// 캡차 이미지 변경
function imgRefresh(){
	 $("#captchaImg").attr("src", "/captcha?id=" + Math.random());
}

//이메일 도메인 변경
function changeEmailDomain(){
	   $("#email_2").val($("#email_domain").val());
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
	<!--// title_and_info_area -->
	
	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
		<input type='hidden' id="contents_id" name='contents_id' value="<c:if test="${param.mode eq 'E'}">${contentsinfo.contents_id }</c:if>" />
		<input type='hidden' id="gubun" name='gubun' value="${param.gubun}" />
		<input type='hidden' id="image_file_id" name='image_file_id' value="${contentsinfo.image_file_id }" />
		<input type='hidden' id="group_id" name='group_id' value="${contentsinfo.group_id }" />
		<input type='hidden' id="ref_seq" name='ref_seq' value="${contentsinfo.ref_seq }" />
		<input type='hidden' id="restep_seq" name='restep_seq' value="${contentsinfo.restep_seq }" />
		<input type='hidden' id="relevel_seq" name='relevel_seq' value="${contentsinfo.relevel_seq }" />
	    <input type='hidden' id="email" name='email' value="${contentsinfo.email}" />
		<input type='hidden' id='s_userip' name='s_userip' value="<%= request.getRemoteAddr() %>"/>
		<input type='hidden' id="writer_name" name='writer_name' value="${contentsinfo.name}" />
		<input type='hidden' id="writer_email" name='writer_email' value="${contentsinfo.email}" />
		<input type='hidden' id="writer_email_recv_yn" name='writer_email_recv_yn' value="${contentsinfo.email_recv_yn}" />
		<input type='hidden' id="contents_title" name='contents_title' value="${contentsinfo.title}" />
		<input type='hidden' id="contents_info" name='contents_info' value="${contentsinfo.contents}" />

		<!-- write_basic -->
		<div class="table_area">
		
			<table class="view">
				<caption>등록 화면</caption>
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				
				<%-- 국내외구분 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}">
				<tr>
					<th scope="row">국내외구분 <c:if test="${fn:indexOf(boardinfo.item_required, 'domestic_yn') != -1}">*</c:if></th>
					<td>
						<select class="in_wp150" title="구분 선택" id="domestic_yn" name="domestic_yn" 
							 <c:if test="${fn:indexOf(boardinfo.item_required, 'domestic_yn') != -1}">data-parsley-required="true"</c:if>
						>
							<option value="" >- 선택 -</option>
							<option value="Y" <c:if test="${contentsinfo.domestic_yn eq 'Y'}">selected</c:if>>국내</option>
							<option value="N" <c:if test="${contentsinfo.domestic_yn eq 'N'}">selected</c:if>>해외</option>
						</select>
					</td>
				</tr>
				</c:if>
				
				<%-- 카테고리 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">
				<tr>
					<th scope="row">카테고리 <c:if test="${fn:indexOf(boardinfo.item_required, 'cate') != -1}">*</c:if> </th>
					<td>
						<select class="in_wp150" title="구분 선택" id="cate_id" name="cate_id" 
							 <c:if test="${fn:indexOf(boardinfo.item_required, 'cate') != -1}">data-parsley-required="true"</c:if>
						>
							<option value="" >- 선택 -</option>
							<c:forEach items="${category }" var="list">
								<option value="${list.cate_id }" <c:if test="${list.cate_id eq contentsinfo.cate_id && param.mode eq 'E'}">selected</c:if>>${list.title }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				</c:if>
				
				
				<%-- 제목 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'title') != -1}">
				<tr>
					<th scope="row">제목 <c:if test="${fn:indexOf(boardinfo.item_required, 'title') != -1}">*</c:if></th>
					<td>
						<c:set var="titleEscape" value="${contentsinfo.title}"/>
						<input id="title" name="title" type="text" class="in_w60" value="<c:if test="${param.mode eq 'R'}">RE : </c:if><c:if test="${param.mode ne 'W'}">${fn:escapeXml(titleEscape)}</c:if>"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'title') != -1}"> data-parsley-required="true"</c:if> 
						/>
					</td>
				</tr>
				</c:if>
				
			
				<%-- 제목링크 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'link') != -1}">
				<tr>
					<th scope="row">제목링크 <c:if test="${fn:indexOf(boardinfo.item_required, 'link') != -1}">*</c:if></th>
					<td>
						<input id="title_link" name="title_link" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.title_link }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'link') != -1}">data-parsley-required="true"</c:if>
						/>
					</td>
				</tr>
				</c:if>
				
			
				<%-- 고정공지  --%>
				<c:if test="${param.mode ne 'R'}">
				<c:if test="${fn:indexOf(boardinfo.item_use, 'noti') != -1}">
				<tr>
					<th scope="row">고정공지 <c:if test="${fn:indexOf(boardinfo.item_required, 'noti') != -1}">*</c:if></th>
					<td>
						<input id="notiY" name="noti" type="radio" value="Y" onclick="chkNoti();" <c:if test="${contentsinfo.noti eq 'Y'}">checked="checked"</c:if> />
						<label for="notiY">사용</label>
						<input id="notiN" name="noti" type="radio" value="N" <c:if test="${contentsinfo.noti ne 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="notiN">미사용</label>
					</td>
				</tr>
				</c:if>
				</c:if>
				
			
				<%-- 비밀글  --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'secret') != -1}">
				<tr>
					<th scope="row">비밀글 <c:if test="${fn:indexOf(boardinfo.item_required, 'secret') != -1}">*</c:if></th>
					<td>
						<input id="secret" name="secret" value="Y" type="radio" <c:if test="${contentsinfo.secret eq 'Y'}">checked="checked"</c:if> />
						<label for="use">사용</label>
						<input id="secret" name="secret" value="N" type="radio" <c:if test="${contentsinfo.secret ne 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="not">미사용</label>
					</td>
				</tr>
				</c:if>
				
				
				<%-- URL  --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'url') != -1}">
				<tr>
					<th scope="row" rowspan="2">URL <c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}">*</c:if></th>
					<td>
						<label for="use">URL 명</label>
						<input id="url_title" name="url_title" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.url_title }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}">data-parsley-required="true"</c:if>
						/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="use">URL 주소</label>
						<input id="url_link" name="url_link" type="text" class="in_w60"  value="<c:if test="${param.mode eq 'E'}">${contentsinfo.url_link }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}">data-parsley-required="true"</c:if> 
						/>
					</td>
				</tr>
				</c:if>
				
				
				<%-- 출처 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'origin') != -1}">
				<tr>
					<th scope="row">출처 <c:if test="${fn:indexOf(boardinfo.item_required, 'origin') != -1}">*</c:if></th>
					<td><input id="origin" name="origin" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.origin }</c:if>" /></td>
				</tr>
				</c:if>
				
				
				<%-- 국가 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'country') != -1}">
				<tr>							
					<th scope="row">국가	<c:if test="${fn:indexOf(boardinfo.item_required, 'country') != -1}">*</c:if>
					</th>
					<td>
						<input id="country" name="country" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.country }</c:if>" />
					</td>
				</tr>
				</c:if>
				
				
				<%-- 기타 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'etc') != -1}">
				<tr>							
					<th scope="row">
						<c:if test="${boardinfo.etc_label_nm eq '1' }">기타</c:if>
						<c:if test="${boardinfo.etc_label_nm eq '2' }">출원번호</c:if>
						<c:if test="${boardinfo.etc_label_nm eq '3' }">발행처</c:if>
						<c:if test="${boardinfo.etc_label_nm eq '4' }">운영기관</c:if>
						<c:if test="${fn:indexOf(boardinfo.item_required, 'etc') != -1}">*</c:if>
					</th>
					<td>
						<input id="etc" name="etc" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.etc }</c:if>" />
					</td>
				</tr>
				</c:if>
				
				
				<%-- 날짜 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'contents_date') != -1}">
				<tr>							
					<th scope="row">
						<c:if test="${boardinfo.contents_date_label_nm eq '1' }">날짜</c:if>
						<c:if test="${boardinfo.contents_date_label_nm eq '2' }">출원일</c:if>
						<c:if test="${boardinfo.contents_date_label_nm eq '3' }">발간일</c:if>
						<c:if test="${fn:indexOf(boardinfo.item_required, 'contents_date') != -1}">*</c:if>
					</th>
					<td>
						<input type="text" id="contents_date" name="contents_date" class="in_wp100 datepicker" 
						value="<c:if test="${param.mode eq 'E'}">${contentsinfo.contents_date}</c:if>" readonly />
					</td>
				</tr>
				</c:if>
				
				
				<%-- 썸네일 --%>
				<tr style="<c:if test="${fn:indexOf(boardinfo.item_use, 'thumb') == -1}">display:none</c:if>" >
					<th scope="row">썸네일 <c:if test="${fn:indexOf(boardinfo.item_required, 'thumb') != -1}">*</c:if></th>
					<td>
						<div class="file_area">
							<label for="attached_file" class="hidden">파일 선택하기</label>
							<input class="form-control in_w50" type="file" id="thumb" name="thumb" value=""
								<c:if test="${fn:indexOf(boardinfo.item_required, 'thumb') != -1}">data-parsley-required="true"</c:if> 
							/>
						</div>
						<c:if test="${param.mode eq 'E' && not empty contentsinfo.image_file_nm}">
						<div class="file_area" id="uploadedFile">
							<ul class="file_list">
								<li>
									<a href="#" title="썸네일">${contentsinfo.image_file_nm}</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${contentsinfo.image_file_id}" title="파일 삭제">
										<img src="/images/admin/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
							</ul>
						</div>
						</c:if>
					</td>
				</tr>
				
			
				<%-- 첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'attach') != -1}">
				<tr>
					<th scope="row">첨부파일 <c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">*</c:if></th>
					<td>
						<div id="attach_file">
							<div class="file_area">
								<label for="attached_file" class="hidden">파일 선택하기</label>
								<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
									<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> 
								/>
								<button class="marginl20" title="추가하기" id="addbtn" onclick="addFile()">
									<span><img src="/images/admin/common/btn_file_add.png" alt="파일추가하기" /></span>
								</button>
							</div>
						</div>
						<c:if test="${param.mode eq 'E'}">
						<div class="file_area" id="file_area1">
							<ul class="file_list">
								<c:forEach items="${fileList }" var="list">
								<li>
									<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
										${list.origin_file_nm }(${size }KB)
									</a>
									<a href="javascript:;" class="btn_file_delete" data-file_id="${list.file_id}" title="파일 삭제">
										<img src="/images/admin/icon/icon_delete.png" alt="삭제" />
									</a>
								</li>
								</c:forEach>
							</ul>
						</div>
						</c:if>
					</td>
				</tr>
				</c:if>
				
				
				<%-- 작성자 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'name') != -1}">
				<tr>
					<th scope="row">작성자 <c:if test="${fn:indexOf(boardinfo.item_required, 'name') != -1}">*</c:if>
					</th>
					<td>
						<input id="name" name="name" type="text" class="in_w15" value="${name }" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'name') != -1}">data-parsley-required="true"</c:if> readonly 
						/>
					</td>
				</tr>
				</c:if>
				
			
				<%-- 휴대전화 
				<c:if test="${fn:indexOf(boardinfo.item_use, 'phone') != -1}">
				<tr>
					<th scope="row">휴대전화 <c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}">*</c:if></th>
					<td>
						<c:set var="phone1" value="010" />
						<c:set var="phone2" value="" />
						<c:set var="phone3" value="" />
						<c:if test="${not empty contentsinfo.handphone }">
							<c:set var="phone" value="${contentsinfo.handphone }" />
							<c:set var="phone_split" value="${fn:split(phone, '-')}" />
							<c:forEach var="p1" items="${phone_split }" varStatus="s">
								<c:if test="${s.count == 1 }"><c:set var="phone1" value="${p1 }" /></c:if>
								<c:if test="${s.count == 2 }"><c:set var="phone2" value="${p1 }" /></c:if>
								<c:if test="${s.count == 3 }"><c:set var="phone3" value="${p1 }" /></c:if>
							</c:forEach>
						</c:if>
						<select class="in_wp60" title="구분 선택" id="phone1" name="phone1"> 
							<option value="010" <c:if test="${phone1 eq '010' }" >selected</c:if>>010</option>							
							<option value="011" <c:if test="${phone1 eq '011' }" >selected</c:if>>011</option>
							<option value="016" <c:if test="${phone1 eq '016' }" >selected</c:if>>016</option>
							<option value="017" <c:if test="${phone1 eq '017' }" >selected</c:if>>017</option>
							<option value="018" <c:if test="${phone1 eq '018' }" >selected</c:if>>018</option>
							<option value="019" <c:if test="${phone1 eq '019' }" >selected</c:if>>019</option>
						</select>
						- <input type="text" class="in_wp60" id="phone2" name="phone2" value="${phone2 }" maxlength="4"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}">data-parsley-required="true" data-parsley-errors-messages-disabled="true"</c:if>
						/>
						- <input type="text" class="in_wp60" id="phone3" name="phone3" value="${phone3 }" maxlength="4"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}">data-parsley-required="true"</c:if>
						/>
						<div class="color_point">
							* 답신여부를 SMS로 받으시겠습니까?(
								<input id="sms_recvY" name="sms_recv" value="Y" type="radio" <c:if test="${contentsinfo.sms_recv eq 'Y'}">checked="checked"</c:if> />
								<label for="use">예</label>
								<input id="sms_recvN" name="sms_recv" value="N" type="radio" <c:if test="${contentsinfo.sms_recv ne 'Y'}">checked="checked"</c:if> class="marginl15" />
								<label for="not">아니요</label>
							)
						</div>
					</td>
				</tr>
				</c:if>
				--%>					
			
				<%-- 이메일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1 and param.mode ne 'R' }">
				<tr>
					<th scope="row">이메일 <c:if test="${fn:indexOf(boardinfo.item_required, 'email') != -1}">*</c:if>
					</th>
					<td>
					   	<input id="email_1" name="email_1" type="text" value="${contentsinfo.email_1}" class="in_wp80" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'email') != -1}"> data-parsley-required="true"</c:if> 
						/>@
					   	<input id="email_2" name="email_2" type="text" value="${contentsinfo.email_2}" class="in_wp100" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'email') != -1}"> data-parsley-required="true"</c:if> 
						/>
						<select id='email_domain' name='email_domain' title='이메일주소선택' class="in_wp80" onChange="changeEmailDomain()">
							<option value="self">직접입력</option>
							<option value="daum.net">한메일</option>
							<option value="naver.com">네이버</option>
							<option value="nate.com">네이트</option>
							<option value="gmail.com">구글</option>
							<option value="yahoo.co.kr">야후</option>
							<option value="lycos.co.kr">라이코스</option>
							<option value="hotmail.com">핫메일</option>
							<option value="paran.com">파란</option>
						</select>
						
						<div class="color_point">
							* 답신여부를 이메일로 받으시겠습니까?(
								<input id="email_recvY" name="email_recv_yn" value="Y" type="radio" <c:if test="${contentsinfo.email_recv_yn eq 'Y'}">checked="checked"</c:if> />
								<label for="use">예</label>
								<input id="email_recvN" name="email_recv_yn" value="N" type="radio" <c:if test="${contentsinfo.email_recv_yn ne 'Y'}">checked="checked"</c:if> class="marginl15" />
								<label for="not">아니요</label>
							)
						</div>
					</td>
				</tr>
				</c:if>
				
				
				<%-- 작성일(고정 숨김) --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reg_date') != -1}">
				<tr>
					<th scope="row">작성일 <c:if test="${fn:indexOf(boardinfo.item_required, 'reg_date') != -1}">*</c:if></th>
					<td>
						<input id="reservationN" name="reservation" type="radio" value="N" <c:if test="${contentsinfo.reservation ne 'Y'}">checked="checked"</c:if> />
						<label for="now">현재</label>
						<input id="reservationY" name="reservation" type="radio" value="Y" <c:if test="${contentsinfo.reservation eq 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="target">지정</label>
						
						<input type="text" id="reservation_date" name="reservation_date" class="in_wp100 datepicker"  
							value="<c:if test="${param.mode eq 'E'}">${contentsinfo.reservation_date }</c:if>" readonly
						/>
					</td>
				</tr>
				</c:if>
				
								
				<%-- 공공저작물 사용여부 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cpr_use_yn') != -1}">				
				<tr>
					<th scope="row">공공저작물<br />사용여부<c:if test="${fn:indexOf(boardinfo.item_required, 'cpr_use_yn') != -1}">*</c:if></th>
					<td colspan="3">
						<input id="cpr_use_yes" name="cpr_use_yn" value="Y" type="radio" <c:if test="${contentsinfo.cpr_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="cpr_use_yes">사용</label>
						<input id="cpr_use_no" name="cpr_use_yn" value="N" type="radio" class="marginl15" <c:if test="${contentsinfo.cpr_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="cpr_use_no">미사용</label>
					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="2">공공저작물<br />유형선택</th>
					<td>
						<p class="bold marginb10">상업적 이용 표시를 허락하시겠습니까?</p>
						<input id="cpr_cmrc_use_yes" name="cpr_cmrc_use_yn" value="Y" type="radio" <c:if test="${contentsinfo.cpr_cmrc_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="cpr_cmrc_use_yes">상업적, 비상업적 이용 가능</label>
						<input id="cpr_cmrc_use_no" name="cpr_cmrc_use_yn" value="N" type="radio" class="marginl15" <c:if test="${contentsinfo.cpr_cmrc_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="cpr_cmrc_use_no">비상업적만 이용 가능</label>
					</td>
				</tr>
				<tr>
					<td>
						<p class="bold marginb10">변경을 허용하시겠습니까?</p>
						<input id="cpr_chngc_use_yes" name="cpr_chng_use_yn" value="Y" type="radio" <c:if test="${contentsinfo.cpr_chng_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="cpr_chngc_use_yes">변형 등 2차적 저작물 작성이 가능</label>
						<input id="cpr_chngc_use_no" name="cpr_chng_use_yn" value="N" type="radio" class="marginl15" <c:if test="${contentsinfo.cpr_chng_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="cpr_chngc_use_no">변형 등 2차적 저작물 작성 금지</label>
					</td>
				</tr>				
				</c:if>
				
				
				<%-- 담당정보 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'charge_info_use_yn') != -1}">
				<tr>
					<th scope="row">담당정보 <c:if test="${fn:indexOf(boardinfo.item_required, 'charge_info_use_yn') != -1}">*</c:if></th>
					<td>
						<input id="charge_info" name="charge_info" type="text" class="in_w60" value="${contentsinfo.charge_info }" />
					</td>
				</tr>
				</c:if>
				
			
				<%-- 내용 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'contents') != -1}">
				<tr>
					<th scope="row" colspan="2">내용 <c:if test="${fn:indexOf(boardinfo.item_required, 'contents') != -1}">*</c:if></th>
				</tr>
				</c:if>
				
				</tbody>
				
			</table>

			<div class="editor_area view" style="<c:if test="${fn:indexOf(boardinfo.item_use, 'contents') == -1}">display:none</c:if>">
				<textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="20" style="width:100%;height:400px;"  >
					<c:if test="${param.mode eq 'E'}">${contentsinfo.contents }</c:if>
				</textarea>
			</div>
						
			<!-- 개인정보수집동의 -->
	 		<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1 and param.mode eq 'W'}">
			<div class="personal_chk_area marginb20">
			
				<div class="personal_chk_close on">
				
					<div class="personal_chk_txt">
						<input type="checkbox" name="" id="agreement" />
						<label for="agreement">개인정보 수집 및 이용에 동의 <span>(필수)</span></label>
					</div>

					<div class="personal_chk_btn on">
						<button title="자세히 보기" class="open">자세히 보기 ▼</button>
						<button title="닫기" class="close">닫기 ▲</button>
					</div>
				</div>

				<div class="personal_chk_open">
					<strong>개인정보 수집·이용 목적</strong>
					<p>- 게시자 의견 확인을 위해 참고용으로 수집 이용됩니다.(상담 또는 문의에 대한 답변 등)</p>
					<p>- 게시자 등록 내용 확인/수정/삭제 등 게시판 이용에 필요한 최소한의 정보를 수집합니다.</p>
					<br/>
					<p><strong>수집 항목 </strong>: 성명, 이메일 등</p>
					<p><strong>보유·이용 기간</strong> : 본 게시판 서비스 종료 시 보유 정보 폐기</p>
					<p><strong>동의 거부 권리 안내 </strong> : 개인정보 수집·이용 동의를 거부할 수 있습니다. 다만, 이 경우 글 게시가 제한됩니다.</p>
					<br/>
					<strong>※ 수집된 개인정보는 위 목적 이외의 용도로는 이용되지 않으며, 제3자에게 제공하지 않습니다.</strong>					
				</div>
				
			</div>
			</c:if>
			<!--// 개인정보수집동의 -->

		</div>
		<!--// write_basic -->
	</form>
	
	<!-- tabel_search_area -->
	<div class="table_search_area">
		<div class="float_right">
			<button onclick="contentsWrite()" class="btn save" title="저장하기">
				<span>저장</span>
			</button>
			<a href="javascript:goList()" class="btn list" title="목록 페이지로 이동">
				<span>목록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->
	
</div>

<script language="javascript">

$('.datepicker').each(function(){
    $(this).datepicker({
		  format: "yyyy-mm-dd",
		  language: "kr",
		  keyboardNavigation: false,
		  forceParse: false,
		  autoclose: true,
		  todayHighlight: true,
		  showOn: "button",
		  buttonImage:"/images/admin/icon/icon_calendar.png",
		  buttonImageOnly:true,
		  changeMonth: true,
          changeYear: true,
          showButtonPanel:false
		 });
});
	
	
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "contents",
    sSkinURI: "<c:url value='/smarteditor2/SmartEditor2Skin.html?editId=contents' />",
    htParams : {
    	bUseModeChanger : true ,     	 
        bSkipXssFilter : true
         
    }, 
    fCreator: "createSEditor2"
});

</script>