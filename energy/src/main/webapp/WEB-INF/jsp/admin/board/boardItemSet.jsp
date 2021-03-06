<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%-- 
	1. 번호, 제목,  작성자(이름), 작성일(현재, 지정중 선택), IP, 추천수는 시스템 필수값 단 게시판유형이 QnA일경우 답변상태 출력여부, 답변상태, 답변내용, 답변일이 추가 필수값
	2. 고정공지 및 첨부파일은 1~5개 설정할 수 있다. 최대용량 (20Mb)
--%>

<script language="javascript">
var listUrl = "<c:url value='/admin/board/boardList.do'/>";
var boardWriteUrl = "<c:url value='/admin/board/boardWrite.do'/>";
var boardItemSetUrl = "<c:url value='/admin/board/boardItemSet.do'/>";
var boardViewSetUrl = "<c:url value='/admin/board/boardViewSet.do'/>";
var updateBoardItemSetUrl = "<c:url value='/admin/board/updateBoardItemSet.do'/>";

//목록
function goList(){
    
    var f = document.writeFrm;
   
    f.target = "_self";
    f.action = listUrl;
    f.submit();
}

//탭이동
function tabLink(tab){
	var f = document.writeFrm;
	var url = "";
	
	if(tab == "I"){	// 항목설정
		// 현재페이지
	}else if(tab == "V"){ // 목록뷰설정
		url = boardViewSetUrl;
	}else{ // 기본정보
		url = boardWriteUrl;
	}
	
    f.target = "_self";
    f.action = url;
    f.submit();
}

function itemSave(){
	
	var url = "";
	var item_uses = "";
	var item_requireds = "";
	
	if ( $("#writeFrm").parsley().validate() ){
		url = updateBoardItemSetUrl;
	
		$("[id^=item_use]:checked").each(function(){
			item_uses = item_uses + $(this).val() + ",";
		});
		
		$("[id^=item_required]:checked").each(function(){
			item_requireds = item_requireds + $(this).val() + ",";
		});
		
		item_uses = item_uses.substring(0, item_uses.length-1);
		item_requireds = item_requireds.substring(0, item_requireds.length-1);
		
		$("#item_use").val(item_uses);
		$("#item_required").val(item_requireds);
		
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

// 체크박스 처리
function chkbox(val){
    
	// 사용선택 해제시 필수체크도 해제
	if(!$("#item_use_"+val).is(":checked")) {
		$("#item_required_"+val).prop('checked', false) ;
	}
	
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
	
	<!-- area_tab -->
	<div class="tab_area">
		<ul class="tablist">
			<li><a href="javascript:tabLink('B')"><span>기본정보</span></a></li>
			<li class="on"><a href="#"><span>항목설정</span></a></li>
			<li><a href="javascript:tabLink('V')"><span>목록 뷰설정</span></a></li>
		</ul>
	</div>
	<!--// area_tab -->
	
	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">게시판<span class="color_pointr">${boardinfo.title }(${boardinfo.board_id })</span></h4>
	</div>
	<!--// title_area -->
	
	<!-- division20 -->
	<div class="division20">
		<p class="txt01">- 선택한 항목만 입력 가능하며, 필수체크 된 항목은 필수 입력 정보입니다.</p>
	</div>
	<!--// division20 -->
	
	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">항목설정</h4>
	</div>
	<!--// title_area -->
	
	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	
		<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
		<input type='hidden' id="mode" name='mode' value="E" />
		<input type='hidden' id="item_use" name='item_use' value="" />
		<input type='hidden' id="item_required" name='item_required' value="" />
		
		<!-- table 1dan list -->
		<div class="table_area">
			<table class="list fixed">
				<caption>항목설정 화면</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 20%;" />
					<col style="width: *;" />
					<col style="width: 20%;" />
					<col style="width: 10%;" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">사용선택</th>
					<th scope="col">항목코드</th>
					<th scope="col">항목명</th>
					<th scope="col">설정</th>
					<th class="last" scope="col">필수체크</th>
				</tr>
				</thead>
				<tbody>
				
				
				<%-- 번호 --%>
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="item_use_number" onclick="return false;" value="number" checked /></td>
					<td>number</td>
					<td class="alignl">번호</td>
					<td></td>
					<td class="last"><input type="checkbox" id="item_required_number" onclick="return false;" value="number" checked />	</td>
				</tr>
				
				
				<%-- 국내외구분 --%>
				<tr>
					<td class="first">
						<input type="checkbox"  id="item_use_domestic_yn" value="domestic_yn" onclick="chkbox('domestic_yn')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>domestic_yn</td>
					<td class="alignl">국내외구분</td>
					<td class="alignl">
						탭메뉴 사용여부
						<input id="tabmenu_use_yes" name="tabmenu_use_yn" value="Y" type="radio" class="marginl10" <c:if test="${boardinfo.tabmenu_use_yn == 'Y'}">checked="checked"</c:if>>
						<label for="tabmenu_use_yes">사용</label>
						<input id="tabmenu_use_no" name="tabmenu_use_yn" value="N" type="radio"  class="marginl10" <c:if test="${boardinfo.tabmenu_use_yn == 'N'}">checked="checked"</c:if>>
						<label for="tabmenu_use_no">미사용</label>
					</td>
					<td class="last">
						<input type="checkbox" id="item_required_domestic_yn" value="domestic_yn" onclick="if(!$('#item_use_domestic_yn').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'domestic_yn') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 카테고리 --%>
				<tr>
					<td class="first">
						<input type="checkbox"  id="item_use_cate" value="cate" onclick="chkbox('cate')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>cate</td>
					<td class="alignl">카테고리</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_cate" value="cate" onclick="if(!$('#item_use_cate').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'cate') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 제목 --%>
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox"  id="item_use_title" onclick="return false;" value="title" checked /></td>
					<td>title</td>
					<td class="alignl">제목</td>
					<td></td>
					<td class="last"><input type="checkbox" id="item_required_title" onclick="return false;" value="title" checked /></td>
				</tr>
				
				
				<%-- 제목링크 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_link" value="link" onclick="chkbox('link')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'link') != -1}">checked="checked"</c:if>
						/> 
					</td>
					<td>link</td>
					<td class="alignl">제목링크</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_link" value="link" onclick="if(!$('#item_use_link').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'link') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 고정공지는 목록형게시판에만 적용 --%>
				<c:if test="${boardinfo.board_type eq 'N' }">
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_noti" value="noti" onclick="chkbox('noti')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'noti') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>noti</td>
					<td class="alignl">고정공지</td>
					<td>개수
						<select class="in_wp40" id="noti_num" name="noti_num">
							<option value="1" <c:if test="${boardinfo.noti_num eq 1 }">selected</c:if>>1</option>
							<option value="2" <c:if test="${boardinfo.noti_num eq 2 }">selected</c:if>>2</option>
							<option value="3" <c:if test="${boardinfo.noti_num eq 3 }">selected</c:if>>3</option>
							<option value="4" <c:if test="${boardinfo.noti_num eq 4 }">selected</c:if>>4</option>
							<option value="5" <c:if test="${boardinfo.noti_num eq 5 }">selected</c:if>>5</option>
						</select>
					</td>
					<td class="last">
						<input type="checkbox" id="item_required_noti" value="noti" onclick="if(!$('#item_use_noti').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'noti') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr>
				</c:if> 
				
				
				<%-- 비밀글 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_secret" value="secret" onclick="chkbox('secret')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'secret') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>secret</td>
					<td class="alignl">비밀글</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_secret" value="secret" onclick="if(!$('#item_use_secret').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'secret') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--URL --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_url" value="url" onclick="chkbox('url')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'url') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>url</td>
					<td class="alignl">URL</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_url" value="url" onclick="if(!$('#item_use_url').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'url') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--출처 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_origin" value="origin" onclick="chkbox('origin')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'origin') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>origin</td>
					<td class="alignl">출처</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_origin" value="origin" onclick="if(!$('#item_use_origin').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'origin') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--국가 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_country" value="country" onclick="chkbox('country')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'country') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>country</td>
					<td class="alignl">국가</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_country" value="country" onclick="if(!$('#item_use_country').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'country') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr>
				
				
				<%--기타 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_etc" value="etc" onclick="chkbox('etc')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'etc') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>etc</td>					
					<td class="alignl">
						<label for="etc_label_nm">기타</label>
						<select name="etc_label_nm" id="etc_label_nm" class="in_wp100 marginl10">
							<option value="1" <c:if test="${boardinfo.etc_label_nm eq 1 }">selected</c:if>>기타</option>
							<option value="2" <c:if test="${boardinfo.etc_label_nm eq 2 }">selected</c:if>>출원번호</option>
							<option value="3" <c:if test="${boardinfo.etc_label_nm eq 3 }">selected</c:if>>발행처</option>
							<option value="4" <c:if test="${boardinfo.etc_label_nm eq 4 }">selected</c:if>>운영기관</option>
						</select>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_etc" value="etc" onclick="if(!$('#item_use_etc').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'etc') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr>
				
				
				<%--날짜 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_contents_date" value="contents_date" onclick="chkbox('contents_date')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'contents_date') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>contents_date</td>				
					<td class="alignl">
						<label for="contents_date_label_nm">날짜</label>
						<select name="contents_date_label_nm" id="etc_label_nm" class="in_wp100 marginl10">
							<option value="1" <c:if test="${boardinfo.contents_date_label_nm eq 1 }">selected</c:if>>날짜</option>
							<option value="2" <c:if test="${boardinfo.contents_date_label_nm eq 2 }">selected</c:if>>출원일</option>
							<option value="3" <c:if test="${boardinfo.contents_date_label_nm eq 3 }">selected</c:if>>발간일</option>
						</select>
					<td></td>
					<td class="last">					
						<input type="checkbox" id="item_required_contents_date" value="contents_date" onclick="if(!$('#item_use_contents_date').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'contents_date') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr>
				
				
				<%--내용 --%>
				<tr style='background:#e9e9e9'>
					<td class="first">
						<input type="checkbox" id="item_use_contents" value="contents" onclick="return false;" checked />
					</td>
					<td>contents</td>
					<td class="alignl">내용</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_contents" value="contents" onclick="if(!$('#item_use_contents').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'contents') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--답변상태 사용여부 --%>
				<c:if test="${boardinfo.board_type eq 'Q' }">
				<tr <c:if test="${boardinfo.board_type eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="item_use_reply_yn" value="reply_yn" 
							<c:if test="${boardinfo.board_type eq 'Q' }">onclick="return false;" checked="checked"</c:if> 
							<c:if test="${boardinfo.board_type ne 'Q' }">
								 <c:if test="${fn:indexOf(boardinfo.item_use, 'reply_yn') != -1}">onclick="chkbox('reply_yn')"  checked="checked"</c:if>
							</c:if> 
						/>
					</td>
					<td>reply_yn</td>
					<td class="alignl">답변상태 사용여부</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_reply_yn" value="reply_yn" onclick="if(!$('#item_use_reply_yn').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'reply_yn') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--답변상태 --%>
				<tr <c:if test="${boardinfo.board_type eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="item_use_reply_status" value="reply_status" 
							<c:if test="${boardinfo.board_type eq 'Q' }">onclick="return false;" checked="checked"</c:if>
							<c:if test="${boardinfo.board_type ne 'Q' }">
							 	<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_status') != -1}">onclick="chkbox('reply_status')" checked="checked"</c:if>
							</c:if>
						 />
					</td>
					<td>reply_status</td>
					<td class="alignl">답변상태(답변을 사용한 게시판에서 자동출력)</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_reply_status" value="reply_status" onclick="if(!$('#item_use_reply_status').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'reply_status') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--답변내용 --%>
				<tr <c:if test="${boardinfo.board_type eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="item_use_reply_contents" value="reply_contents" 
							<c:if test="${boardinfo.board_type eq 'Q' }">onclick="return false;" checked="checked"</c:if>
							<c:if test="${boardinfo.board_type ne 'Q' }">
							 	<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_contents') != -1}">onclick="chkbox('reply_contents')" checked="checked"</c:if>
							</c:if>
						 />
					</td>
					<td>reply_contents</td>
					<td class="alignl">답변내용</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_reply_contents" value="reply_contents" onclick="if(!$('#item_use_reply_contents').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'reply_contents') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--답변일 --%>
				<tr <c:if test="${boardinfo.board_type eq 'Q' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="item_use_reply_date" value="reply_date" 
							<c:if test="${boardinfo.board_type eq 'Q' }">onclick="return false;" checked="checked"</c:if>
							 <c:if test="${boardinfo.board_type ne 'Q' }">
							 	<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_date') != -1}">onclick="chkbox('reply_date')" checked="checked"</c:if>
							</c:if>
						/>
					</td>
					<td>reply_date</td>
					<td class="alignl">답변일</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_reply_date" value="reply_date" onclick="if(!$('#item_use_reply_date').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'reply_date') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				</c:if>
				
				
				<%--썸네일 --%>
				<tr <c:if test="${boardinfo.board_type eq 'W' or boardinfo.board_type eq 'A' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="item_use_thumb" value="thumb"
							<c:if test="${boardinfo.board_type eq 'W' or boardinfo.board_type eq 'A' }">onclick="return false;" checked="checked"</c:if>
							<c:if test="${boardinfo.board_type ne 'W' and boardinfo.board_type ne 'A' }">
							 	<c:if test="${fn:indexOf(boardinfo.item_use, 'thumb') != -1}">onclick="chkbox('thumb')" checked="checked"</c:if>
							</c:if> 
						/>
					</td>
					<td>thumb</td>
					<td class="alignl">썸네일</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_thumb" value="thumb" onclick="if(!$('#item_use_thumb').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'thumb') != -1}">checked="checked"</c:if>
						/>
					</td>
				</tr>
				
				
				<%--첨부파일 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_attach" value="attach" onclick="chkbox('attach')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'attach') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>attach</td>
					<td class="alignl">첨부파일</td>
					<td>개수
						<select class="in_wp40" id="attach_num" name="attach_num">
							<option value="1" <c:if test="${boardinfo.attach_num eq 1 }">selected</c:if>>1</option>
							<option value="2" <c:if test="${boardinfo.attach_num eq 2 }">selected</c:if>>2</option>
							<option value="3" <c:if test="${boardinfo.attach_num eq 3 }">selected</c:if>>3</option>
							<option value="4" <c:if test="${boardinfo.attach_num eq 4 }">selected</c:if>>4</option>
							<option value="5" <c:if test="${boardinfo.attach_num eq 5 }">selected</c:if>>5</option>
						</select>
					</td>
					<td class="last">
						<input type="checkbox" id="item_required_attach" value="attach" onclick="if(!$('#item_use_attach').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'attach') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 작성자 --%>
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="item_use_name" onclick="return false;" value="name" checked /></td>
					<td>name</td>
					<td class="alignl">작성자(이름)</td>
					<td></td>
					<td class="last"><input type="checkbox" id="item_required_name" onclick="return false;" value="name" checked /></td>
				</tr>
				
				
				<%-- 휴대전화 
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_phone" value="phone" onclick="chkbox('phone')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'phone') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>phone</td>
					<td class="alignl">휴대전화</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_phone" value="phone" onclick="if(!$('#item_use_phone').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'phone') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				--%>
				
				
				<%-- 이메일 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_email" value="email" onclick="chkbox('email')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>email</td>
					<td class="alignl">이메일</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_email" value="email" onclick="if(!$('#item_use_email').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'email') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 작성일 --%>
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="item_use_reg_date" onclick="return false;" value="reg_date" checked /></td>
					<td>reg_date</td>
					<td class="alignl">작성일(현재, 지정중 선택)</td>
					<td></td>
					<td class="last"><input type="checkbox" id="item_required_reg_date" onclick="return false;" value="reg_date" checked /></td>
				</tr>
				
				
				<%-- 아이피 --%>
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="item_use_ip_addr" onclick="return false;" value="ip_addr" checked /></td>
					<td>ip_addr</td>
					<td class="alignl">IP</td>
					<td></td>
					<td class="last"><input type="checkbox" id="item_required_ip_addr" onclick="return false;" value="ip_addr" checked /></td>
				</tr>
				
				
				<%--공공저작물 사용 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_cpr_use_yn" value="cpr_use_yn" onclick="chkbox('cpr_use_yn')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'cpr_use_yn') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>cpr_use_yn</td>
					<td class="alignl">공공저작물 사용</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_cpr_use_yn" value="cpr_use_yn" onclick="if(!$('#item_use_cpr_use_yn').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'cpr_use_yn') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%--담당정보 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_charge_info_use_yn" value="charge_info_use_yn" onclick="chkbox('charge_info_use_yn')" 
							<c:if test="${fn:indexOf(boardinfo.item_use, 'charge_info_use_yn') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>charge_info_use_yn</td>
					<td class="alignl">담당정보</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_charge_info_use_yn" value="charge_info_use_yn" onclick="if(!$('#item_use_charge_info_use_yn').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'charge_info_use_yn') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 추천 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_recommend" value="recommend" onclick="chkbox('recommend')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'recommend') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>recommend</td>
					<td class="alignl">추천</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_recommend" value="recommend" onclick="if(!$('#item_use_recommend').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'recommend') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 만족도 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_satisfy" value="satisfy" onclick="chkbox('satisfy')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'satisfy') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>satisfy</td>
					<td class="alignl">만족도</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_satisfy" value="satisfy" onclick="if(!$('#item_use_satisfy').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'satisfy') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 댓글 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_comment" value="comment" onclick="chkbox('comment')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>comment</td>
					<td class="alignl">댓글</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_comment" value="comment" onclick="if(!$('#item_use_comment').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'comment') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- SNS공유 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_sns" value="sns"  onclick="chkbox('sns')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'sns') != -1}">checked="checked"</c:if> 
						/>
					</td>
					<td>sns</td>
					<td class="alignl">SNS공유</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_sns" value="sns" onclick="if(!$('#item_use_sns').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'sns') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 인쇄 --%>
				<tr>
					<td class="first">
						<input type="checkbox" id="item_use_print" value="print" onclick="chkbox('print')"
							<c:if test="${fn:indexOf(boardinfo.item_use, 'print') != -1}">checked="checked"</c:if>
						/>
					</td>
					<td>print</td>
					<td class="alignl">인쇄</td>
					<td></td>
					<td class="last">
						<input type="checkbox" id="item_required_print" value="print" onclick="if(!$('#item_use_print').is(':checked')) return false;" 
							<c:if test="${fn:indexOf(boardinfo.item_required, 'print') != -1}">checked="checked"</c:if> 
						/>
					</td>
				</tr>
				
				
				<%-- 조회수 --%>
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="item_use_hits" onclick="return false;" value="hits" checked /></td>
					<td>hits</td>
					<td class="alignl">조회수</td>
					<td></td>
					<td class="last"><input type="checkbox" id="item_required_hits" onclick="return false;" value="hits" checked /></td>
				</tr>
				
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->
		
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button onClick="itemSave()" class="btn save" title="저장하기">
					<span>저장</span>
				</button>
				<a href="javascript:goList()" class="btn list" title="목록 페이지로 이동">
					<span>목록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
	</form>

</div>