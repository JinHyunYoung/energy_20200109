<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var insertBoardUrl = "<c:url value='/admin/board/insertBoard.do'/>";
var updateBoardUrl = "<c:url value='/admin/board/updateBoard.do'/>";
var deleteBoardUrl = "<c:url value='/admin/board/deleteBoard.do'/>";
var listUrl = "<c:url value='/admin/board/boardList.do'/>";
var boardItemSetUrl = "<c:url value='/admin/board/boardItemSet.do'/>";
var boardViewSetUrl = "<c:url value='/admin/board/boardViewSet.do'/>";

$(document).ready(function(){
	
	if($("#mode").val() == "E"){
	    
		$("[id^=type]").attr("disabled", true); //설정
		
	} else {
	    
		$("#type").attr("checked", true); //설정
		$("[name=detail_yn]").eq(0).attr("checked", true); //설정
		$("[name=use_yn]").eq(0).attr("checked", true); //설정
		
	}
	
});

// 게시판 생성
function boardInsert(){
    
	var url = "";
	var grant_writes = "";
	var grant_replys = "";
	
	if ( $("#writeFrm").parsley().validate() ){
	    
		url = insertBoardUrl;
		
		if($("#mode").val() == "E") url = updateBoardUrl;
		
		// 글쓰기, 답글쓰기 처리
		$("[id^=gwrite]:checked").each(function(){
			grant_writes = grant_writes + $(this).val() + ",";
		});
		
		$("[id^=greply]:checked").each(function(){
			grant_replys = grant_replys + $(this).val() + ",";
		});
		
		grant_writes = grant_writes.substring(0, grant_writes.length-1);
		grant_replys = grant_replys.substring(0, grant_replys.length-1);
		
		$("#grant_write").val(grant_writes);
		$("#grant_reply").val(grant_replys);
		// 글쓰기, 답글쓰기 처리 끝
		
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

// 게시판 삭제
function boardDelete(){
    
	var url = deleteBoardUrl;
	if(!confirm("게시판이 삭제됩니다. 정말 삭제하시겠습니까?")) return;
	
	// 데이터를 삭제 처리해준다.
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

// 목록
function goList(){
    
    var f = document.writeFrm;
   
    f.target = "_self";
    f.action = listUrl;
    f.submit();
}

// 탭이동
function tabLink(tab){
    
	var f = document.writeFrm;
	var url = "";
	
	// 항목설정
	if(tab == "I"){	
		url = boardItemSetUrl;
	} 
	
	// 목록뷰설정
	else if(tab == "V"){ 
		url = boardViewSetUrl;
	} 
	
	// 기본정보
	else { 
		// 현재페이지
	}
	
    f.target = "_self";
    f.action = url;
    f.submit();
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
	
		<input type='hidden' id="grant_write" name='grant_write' value="" />
		<input type='hidden' id="grant_reply" name='grant_reply' value="" />
		<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		
		<c:if test="${param.mode == 'E' }">
			<!-- area_tab -->
			<div class="tab_area">
				<ul class="tablist">
					<li class="on"><a href="#"><span>기본정보</span></a></li>
					<li><a href="javascript:tabLink('I')"><span>항목설정</span></a></li>
					<li><a href="javascript:tabLink('V')"><span>목록 뷰설정</span></a></li>
				</ul>
			</div>
			<!--// area_tab -->
		</c:if>
		
		<!-- write_basic -->
		<div class="table_area">
			<table class="write">
				<caption>게시판 등록 화면</caption>
				<colgroup>
					<col style="width: 120px;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<c:if test="${param.mode == 'E' }">
				<tr>
					<th scope="row">등록자</th>
					<td>
						${boardinfo.reg_usernm }(${boardinfo.reg_userno })
					</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td>
						${boardinfo.reg_date }
					</td>
				</tr>
				</c:if>
				
				<tr>
					<th scope="row">게시판코드 <span class="asterisk">*</span></th>
					<td>
						<c:if test="${param.mode == 'W' }">
							(등록시 자동생성)
						</c:if>
						<c:if test="${param.mode == 'E' }">
							${boardinfo.board_id }
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row">타입  <span class="asterisk">*</span></th>
					<td>
						<g:radio id="board_type" name="board_type" codeGroup="BOARD_TYPE" checked="30" cls="text-middle" curValue="${boardinfo.board_type }"  />
					</td>
				</tr>
				<tr>
					<th scope="row">게시판명  <span class="asterisk">*</span></th>
					<td>
						<input class="form-control" type="text" id="title" name="title" value="${boardinfo.title}" placeholder="게시판명"  style="width:100%" data-parsley-required="true" data-parsley-maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="row">설명</th>
					<td>
						<textarea class="form-control" id="contents" name="contents" placeholder="게시판설명" rows="3" style="width:100%" data-parsley-maxlength="1000" >${boardinfo.contents}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">Detail 사용여부</th>
					<td>
						<input name="detail_yn" type="radio" value="Y" <c:if test="${boardinfo.detail_yn != 'N'}">checked="checked"</c:if> />
						<label for="use">사용</label>
						<input name="detail_yn" type="radio" value="N" <c:if test="${boardinfo.detail_yn == 'N'}">checked="checked"</c:if> class="marginl15" />
						<label for="not">미사용</label>
						<p class="color_point margint10">* “미사용”인 경우 사용모드(Frontend)는 제공되지 않으며, 첨부파일이 있는 경우 목록에서 다운로드 가능합니다.</p>
					</td>
				</tr>
				<tr>
					<th scope="row">권한사용여부</th>
					<td>
						<div class="table_area">
                            <table class="list fixed">
                                <%-- <caption>권한 리스트 화면</caption> --%>
                                <colgroup>
                                    <col style="width: 15%;">
                                    <col style="width: 10%;">
                                    <col style="width: 10%;">
                                    <col style="width: *;">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col" class="alignc">구분</th>
                                    <th scope="col" class="alignc">회원</th>
                                    <th scope="col" class="alignc">비회원</th>
                                    <th scope="col" class="alignc">비고</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="alignc">글쓰기</td>
                                    <td class="alignc"><input type="checkbox" id="gwrite01" name="grant_write[]" value="M" <c:if test="${fn:indexOf(boardinfo.grant_write, 'M') != -1}">checked="checked"</c:if>></td>
                                    <td class="alignc"><input type="checkbox" id="gwrite02" name="grant_write[]" value="G" <c:if test="${fn:indexOf(boardinfo.grant_write, 'G') != -1}">checked="checked"</c:if>></td>
                                    <td>“체크” 인 경우 사용모드(Frontend)에 등록/수정/삭제 권한이 부여됩니다.</td>
                                </tr>
                                <tr>
                                    <td  class="alignc">답글쓰기</td>
                                    <td  class="alignc"><input type="checkbox" id="greply01" name="grant_reply[]" value="M"  <c:if test="${fn:indexOf(boardinfo.grant_reply, 'M') != -1}">checked="checked"</c:if>></td>
                                    <td  class="alignc"><input type="checkbox" id="greply02" name="grant_reply[]" value="G"  <c:if test="${fn:indexOf(boardinfo.grant_reply, 'G') != -1}">checked="checked"</c:if>></td>
                                         <td>“체크” 인 경우 사용모드(Frontend)에 답글 등록 권한이 부여됩니다.(목록형만 해당)</td>
                                     </tr>
                                 </tbody>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부</th>
					<td>
						<input name="use_yn" type="radio" value="Y" <c:if test="${boardinfo.detail_yn != 'N'}">checked="checked"</c:if> />
						<label for="use">사용</label>
						<input name="use_yn" type="radio" value="N" <c:if test="${boardinfo.detail_yn == 'N'}">checked="checked"</c:if> class="marginl15" />
						<label for="not">미사용</label>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!--// write_basic -->
		
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button onclick="boardInsert()" class="btn save" title="저장하기">
					<span>저장</span>
				</button>
				<c:if test="${param.mode == 'E' }">
				<button onclick="boardDelete()" class="btn cancel" title="삭제">
					<span>삭제</span>
				</button>
				</c:if>
				<a href="javascript:goList()" class="btn list" title="목록 페이지로 이동">
					<span>목록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
	</form>
</div>