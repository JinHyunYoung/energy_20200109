<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/assets/parsley/src/parsley.css" />

<script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>
<script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>	    
		
<script language="javascript">

var listUrl = "<c:url value='/web/board/boardContentsListPage.do'/>";
var insertBoardContentsUrl = "<c:url value='/web/board/insertBoardContents.do'/>";
var insertBoardContentsReplyUrl = "<c:url value='/web/board/insertBoardContentsReply.do'/>";
var updateBoardContentsUrl = "<c:url value='/web/board/updateBoardContents.do'/>";
var deleteFileUrl = "<c:url value='/commonFile/deleteOneCommonFile.do'/>";
var maxNoti = "${boardinfo.noti_num}";
var notiCnt = "${boardinfo.noti_cnt}";

$(document).ready(function(){
	
	// 첨부파일 갯수 확인
	chkMaxFile();
	
	imgRefresh(); //캡차 이미지 요청

	// 파일 삭제
	$('.file_area .btn_file_delete').click(function() {
        if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
            var el = this;
            $.post(
           		deleteFileUrl,
                {file_id: $(el).data("file_id")},
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
	
	if ( $("#writeFrm").parsley().validate() ){
		   
		// 썸네일은 이미지형식으로저장
		if ($("#thumb").val() != "" && !$("#thumb").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
			alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
			return;
		}	
		
		var url = "";		   
		if($("#mode").val() == "E"){
			url = updateBoardContentsUrl;
		} else if($("#mode").val() == "R"){
			url = insertBoardContentsReplyUrl;
		} else { 
			url = insertBoardContentsUrl;
		}
       
		// 로그인 여부 확인하기
		var sid = "${s_user_no }";
		
		$("#email").val($("#email_1").val()+"@"+$("#email_2").val());   
				
		if($("#mode").val() == "W"){
			
			if(sid == ""){
				
				if($("#email_recvY").is(":checked")){
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
			    
				// 개인정보 동의 여부 확인
				//if($("#phone2").val() != undefined && $("#phone3").val() != undefined){
				//	if(!$("#agreement").is(":checked")){
				//		alert("개인정보 동의가 필요합니다.");
				//		return;
				//	}
				//}
			}
		}		
	   
		if(sid == ""){ 
		    
		    // 비회원인경우 캡챠인증
			if(!chkCaptcha()){
				alert("자동등록 방지 문자를 잘못 입력하셨습니다.");
				return;
			}
		}
	   	   
		// 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
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
    html += '	<label class="hidden">파일 선택하기</label>';
    html += '	<input id="attach[]" name="attach[]" type="file" class="in_wp400">';
    html += '	<button type="button" title="삭제하기" onclick="$(this).parent().remove();">';
    html += '		<span><img src="/images/web/common/btn_minus.png" alt="첨부파일 삭제" /></span>';
    html += ' 	</button>';
    html += '</div>';

    $('#attach_file').append(html);
}


// 첨부파일 체크
function chkMaxFile(){
	var maxFile = "${boardinfo.attach_num}";
	var len = $('#file_area1 ul li').length;
	if (len >= maxFile) {
		$("#attach_file").hide();
	}else{
		$("#attach_file").show();
	}
	
	// 최대 첨부파일이 1개면 파일추가 숨기기 
	if(maxFile == 1){
		$("#addbtn").hide();
	}
}


// 캡차 이미지 변경
function imgRefresh(){
	 $("#captchaImg").attr("src", "/captcha.do?id=" + Math.random());
}


// 캡차 체크
function chkCaptcha(){
	var answer = "";
    $.ajax({
        url: "/web/board/getCaptcharAnswer.do",
        dataType: "json",
        type: "post",
        async : false,
        success: function(data) {
        	answer = data.answer;
        },
        error: function(e) {
        }
    });
    
	if(answer != $("#answer").val()){
		return false;
	}else{
		return true;
	}

}


//이메일 도메인 변경
function changeEmailDomain(){
	   $("#email_2").val($("#email_domain").val());
}

</script>

			
<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;" data-parsley-validate="true" enctype="multipart/form-data">

	<input type='hidden' id="mode" name='mode' value="${param.mode}" />
	<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
	<input type='hidden' id="contents_id" name='contents_id' value="<c:if test="${param.mode eq 'E'}">${contentsinfo.contents_id }</c:if>" />
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
			
	<!-- table_area -->
	<div class="table_area">
	
		<table class="write fixed">
		
			<caption>등록 화면</caption>
			<colgroup>
				<col style="width: 120px;">
				<col style="width: *;">
			</colgroup>
			
			<tbody>			
				
				<%-- 국내외구분 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}">
				<tr>
					<th scope="row" class="first">
						<label for="domestic_yn">
							<c:if test="${fn:indexOf(boardinfo.item_required, 'domestic_yn') != -1}"><strong class="color_pointr">*</strong></c:if>
							국내외구분
						</label>
					<td class="first">
						<select class="in_wp150" title="구분 선택" id="domestic_yn" name="domestic_yn" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'cate') != -1}">data-parsley-required="true"</c:if> >
							<option value="">선택</option>
							<option value="Y" <c:if test="${contentsinfo.domestic_yn eq 'Y'}">selected</c:if>>국내</option>
							<option value="N" <c:if test="${contentsinfo.domestic_yn eq 'N'}">selected</c:if>>해외</option>
						</select>
					</td>
				</tr>
				</c:if>
				
				<%-- 카테고리 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">			
				<tr>
					<th scope="row" class="first">
						<label for="cate_id">
							<c:if test="${fn:indexOf(boardinfo.item_required, 'cate') != -1}"><strong class="color_pointr">*</strong></c:if>
							카테고리
						</label>
					</th>
					<td class="first">
						<select class="in_wp150" title="구분 선택" id="cate_id" name="cate_id" 
							 <c:if test="${fn:indexOf(boardinfo.item_required, 'cate') != -1}">data-parsley-required="true"</c:if> >
							<option value="">선택</option>
							<c:forEach items="${category }" var="list">
								<option value="${list.cate_id }" <c:if test="${list.cate_id eq contentsinfo.cate_id && param.mode eq 'E'}">selected</c:if>>${list.title }</option>
							</c:forEach>
						</select>
					</td>
				</tr>			
				</c:if>
				
				
				<%-- 제목 --%>
				<tr>
					<th scope="row">
						<label for="title">
							<c:if test="${fn:indexOf(boardinfo.item_required, 'title') != -1}"><strong class="color_pointr">*</strong></c:if>
							제목
						</label>
					</th>
					<td>
						<c:set var="titleEscape" value="${contentsinfo.title}"/>
						<input id="title" name="title" type="text" class="in_w100" value="<c:if test="${param.mode eq 'R'}">RE : </c:if><c:if test="${param.mode ne 'W'}">${fn:escapeXml(titleEscape)}</c:if>" <c:if test="${fn:indexOf(boardinfo.item_required, 'title') != -1}"> data-parsley-required="true"</c:if> />
					</td>
				</tr>
				
				
				<%-- 제목링크 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'link') != -1}">
				<tr>
					<th scope="row">
						<label for="title_link">
							<c:if test="${fn:indexOf(boardinfo.item_required, 'link') != -1}"><strong class="color_pointr">*</strong></c:if>
							제목링크
						</label>
					</th>
					<td>
						<input id="title_link" name="title_link" type="text" class="in_w100" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.title_link }</c:if>"
							<c:if test="${fn:indexOf(boardinfo.item_required, 'link') != -1}">data-parsley-required="true"</c:if> />
					</td>
				</tr>
				</c:if>
				
				
				<%-- 비밀글  --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'secret') != -1}">
				<tr>
					<th scope="row">
						<c:if test="${fn:indexOf(boardinfo.item_required, 'secret') != -1}"><strong class="color_pointr">*</strong></c:if>
						비밀글
					</th>
					<td>
						<input id="secretY" name="secret" value="Y" type="radio" <c:if test="${contentsinfo.secret eq 'Y'}">checked="checked"</c:if> />
						<label for="secretY">사용</label>
						<input id="secretN" name="secret" value="N" type="radio" <c:if test="${contentsinfo.secret ne 'Y'}">checked="checked"</c:if> class="marginl15" />
						<label for="secretN">미사용</label>
					</td>
				</tr>
				</c:if>
				
						<%-- 비밀번호 (비회원인경우 노출) --%>
				<c:if test="${empty s_user_no }">
				<tr>
					<th scope="row">
						<label for="pass"><strong class="color_pointr">*</strong> 비밀번호</label>
					</th>
					<td>
						<input type="password" class="in_w100" id="pass" name="pass" data-parsley-required="true" />									
					</td>
				</tr>
				</c:if>	
				
				
				
				<%-- URL  --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'url') != -1}">
				<tr>
					<th scope="row">
						<c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}"><strong class="color_pointr">*</strong></c:if>
						URL 
					</th>
					<td>
						<div class="url_area">
							<label for="url_name">
								<strong>URL명</strong>
							</label>
							<input id="url_title" name="url_title" type="text" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.url_title }</c:if>"
								<c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}">data-parsley-required="true"</c:if> />
						</div>
						<div class="url_area margint5">
							<label for="url_link">
								<strong>URL링크</strong>
							</label>
							<input id="url_link" name="url_link" type="text"value="<c:if test="${param.mode eq 'E'}">${contentsinfo.url_link }</c:if>"
								<c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}">data-parsley-required="true"</c:if> />
						</div>
					</td>
				</tr>
				</c:if>
				
				
				<%-- 출처 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'origin') != -1}">
				<tr>
					<th scope="row">
						<label for="origin">
							<c:if test="${fn:indexOf(boardinfo.item_required, 'origin') != -1}"><strong class="color_pointr">*</strong></c:if>
							출처
						</label>
					</th>
					<td>
						<input id="origin" name="origin" type="text" class="in_w60" value="<c:if test="${param.mode eq 'E'}">${contentsinfo.origin }</c:if>" />
					</td>
				</tr>
				</c:if>
				
								
				<%-- 썸네일 --%>
				<tr style="<c:if test="${fn:indexOf(boardinfo.item_use, 'thumb') == -1}">display:none</c:if>" >
					<th scope="row">
						<c:if test="${fn:indexOf(boardinfo.item_required, 'thumb') != -1}"><strong class="color_pointr">*</strong></c:if>
						썸네일
					</th>
					<td>
						<div class="file_area">
							<div class="file_input_area">
								<label for="thumb" class="hidden">썸네일</label>
								<input type="file" id="thumb" name="thumb" <c:if test="${fn:indexOf(boardinfo.item_required, 'thumb') != -1}">data-parsley-required="true"</c:if> />
							</div>
							<!-- <div class="file_btn_area"> 
								<button class="btn s_save_btn" title="찾아보기">
									<span>찾아보기</span>
								</button>
							</div> -->
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
					<th scope="row">
						<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}"><strong class="color_pointr">*</strong></c:if>
						첨부파일
					</th>
					
					<td>
					
						<div id="attach_file">
							<div class="file_area">
								<label for="attached_file" class="hidden">파일 선택하기</label>
								<input id="attached_file" name="attached_file" type="file" class="in_wp400" 
									<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">data-parsley-required="true"</c:if> />
								<a href="javascript:addFile();" title="추가하기" id="addbtn">
									<span><img src="/images/web/common/btn_plus.png" alt="첨부파일 추가" /></span>
								</a>
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
											<img src="/images/web/common/btn_minus.png" alt="첨부파일 삭제" />
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
					<th scope="row">
						<label for="name">
							<c:if test="${fn:indexOf(boardinfo.item_required, 'name') != -1}"><strong class="color_pointr">*</strong></c:if>
							작성자
						</label>
					</th>
					<td>
						<input id="name" name="name" type="text" class="in_w100" value=
							<c:if test="${param.mode eq 'E'}">"${contentsinfo.name }"</c:if>
							<c:if test="${param.mode ne 'E'}">"${name }"</c:if>
							<c:if test="${fn:indexOf(boardinfo.item_required, 'name') != -1}">data-parsley-required="true"</c:if>
							<c:if test="${not empty s_user_no }">readonly</c:if> />
					</td>
				</tr>
				</c:if>
				
				
				<%-- 휴대전화 
				<c:if test="${fn:indexOf(boardinfo.item_use, 'phone') != -1}">
				<tr>
					<th scope="row">
						<c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}"><strong class="color_pointr">*</strong></c:if>
						휴대전화
					</th>
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
						<div class="m_phone_area">
							<label for="phone1" class="hidden">휴대전화 앞자리</label>
							<select class="in_wp80" title="구분 선택" id="phone1" name="phone1"> 
								<option value="010" <c:if test="${phone1 eq '010' }" >selected</c:if>>010</option>							
								<option value="011" <c:if test="${phone1 eq '011' }" >selected</c:if>>011</option>
								<option value="016" <c:if test="${phone1 eq '016' }" >selected</c:if>>016</option>
								<option value="017" <c:if test="${phone1 eq '017' }" >selected</c:if>>017</option>
								<option value="018" <c:if test="${phone1 eq '018' }" >selected</c:if>>018</option>
								<option value="019" <c:if test="${phone1 eq '019' }" >selected</c:if>>019</option>
							</select>
							-
							<label for="phone2" class="hidden">휴대전화 중간자리</label>
							<input type="text" class="in_wp80" id="phone2" name="phone2" value="${phone2 }" maxlength="4"
								<c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}">data-parsley-required="true" data-parsley-errors-messages-disabled="true"</c:if> />
							-
							<label for="phone3" class="hidden">휴대전화 뒷자리</label>
							<input type="text" class="in_wp80" id="phone3" name="phone3" value="${phone3 }" maxlength="4"
								<c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}">data-parsley-required="true"</c:if> />
						</div>
						<div class="color_point">
							* 답신여부를 SMS로 받으시겠습니까?(
								<input type="radio" id="sms_recvY" name="sms_recv" value="Y" <c:if test="${contentsinfo.sms_recv eq 'Y'}">checked="checked"</c:if> />
								<label for="sms_recvY" class="marginr10">예</label>
								<input type="radio" id="sms_recvN" name="sms_recv" value="N" <c:if test="${contentsinfo.sms_recv ne 'Y'}">checked="checked"</c:if> />
								<label for="sms_recvN">아니오</label>
							)
						</div>
					</td>
				</tr>
				</c:if>
				--%>
				
				
				<%-- 이메일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1 and param.mode ne 'R'  }">
				<tr>
					<th scope="row">
						<label for="email">이메일</label>
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
								<input type="radio" id="email_recvY" name="email_recv_yn" value="Y" <c:if test="${contentsinfo.email_recv_yn eq 'Y'}">checked="checked"</c:if> />
								<label for="email_recvY" class="marginr10">예</label>
								<input type="radio" id="email_recvN" name="email_recv_yn" value="N" <c:if test="${contentsinfo.email_recv_yn ne 'Y'}">checked="checked"</c:if> />
								<label for="email_recvN">아니오</label>
							)
						</div>
					</td>
				</tr>
				</c:if>
				
				
				<%-- 작성일(고정 숨김) --%>
				<tr style="display:none" >
					<th scope="row">
						<label for="reservation_date">작성일</label>
					</th>
					<td>
						<input type="text" id="reservation_date" name="reservation_date" class="form-control input-sm"  
							value="<c:if test="${param.mode eq 'E'}">${contentsinfo.reservation_date }</c:if>" readonly />					
					</td>
				</tr>
				
				
		
						
				
				<%-- 내용 --%>
				<tr style="<c:if test="${fn:indexOf(boardinfo.item_use, 'contents') == -1}">display:none</c:if>">
					<td class="td_bg" colspan="2">
						<label for="contents" class="hidden">내용작성</label>
						<textarea id="contents" name="contents" rows="15" style="width:100%;height:100;border:1;overflow:visible;text-overflow:ellipsis;"><c:if test="${param.mode != 'R'}">${contentsinfo.contents}</c:if></textarea>
					</td>
				</tr>
				
				
				<%-- 캡챠 (비회원인경우 노출) --%>
				<c:if test="${empty s_user_no }">
				<tr>
					<th scope="row">
						<label for="pass"><strong class="color_pointr">*</strong> 자동등록방지</label>
					</th>
					<td>
						<div class="auto_x_area">
							<img id="captchaImg" alt="captcha img" style="width:137px;height:32px;">
							<button id="refreshBtn" title="다른이미지 보기" onclick="imgRefresh();">
								<img src="/images/web/common/btn_auto_write_num.png" alt="이미지 리셋">
							</button>
							<input class="in_w20" name="answer" id="answer" type="text" placeholder="보안문자를 입력하세요">			
						</div>	
					</td>
				</tr>
				</c:if>	
			
			</tbody>
		</table>
	</div>
	
</form>

<!-- division30 -->	
<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1 and param.mode eq 'W'}">
	<div class="division30">
			
		<!-- 개인정보수집동의 -->
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
		<!--// 개인정보수집동의 -->		
		
	</div>
</c:if> 	
<!--// division30 -->


<!-- button_area -->
<div class="button_area">
	<div class="float_right">
		<button onclick="contentsWrite()" class="btn save" title="저장">
			<span>저장</span>
		</button>
		<button onclick="goList()" class="btn list" title="목록">
			<span>목록</span>
		</button>
	</div>
</div>
<!--// button_area -->