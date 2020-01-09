<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var listUrl = "<c:url value='/admin/board/boardList.do'/>";
var boardWriteUrl = "<c:url value='/admin/board/boardWrite.do'/>";
var boardItemSetUrl = "<c:url value='/admin/board/boardItemSet.do'/>";
var boardViewSetUrl = "<c:url value='/admin/board/boardViewSet.do'/>";
var updateBoardViewSetUrl = "<c:url value='/admin/board/updateBoardViewSet.do'/>";

$(document).ready(function(){
    
	$(".onlyNum").keyup( setNumberOnly );
	
	// 요약형, 앨범형, 보고서형은 disabled 처리
	if($("#board_type").val() == "A" || $("#board_type").val() == "W" || $("#board_type").val() == "R"){
		$(".onlyNum").attr("disabled", true);
	}
		
});

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
	
	// 항목설정
	if(tab == "I"){	
		url = boardItemSetUrl;
	}
	
	// 목록뷰설정
	else if(tab == "V"){ 
		// 현재페이지
	}
	
	// 기본정보
	else{ 
		url = boardWriteUrl;
	}
	
    f.target = "_self";
    f.action = url;
    f.submit();
}

//체크박스 처리
function chkbox(val){
    
	var board_type = $("#board_type").val();
	
	// 일반형, QnA형
	if(board_type == "N" || board_type == "Q"){
	    
		// 출력선택 해제시 나머지 항목 Disabled 및 초기화
		if($("#view_print_"+val).is(":checked")) {
			$("#view_size_"+val).attr("disabled", false);
			$("#view_sort_"+val).attr("disabled", false);
		} else {
			$("#view_size_"+val).val("");
			$("#view_sort_"+val).val("");
			$("#view_size_"+val).attr("disabled", true);
			$("#view_sort_"+val).attr("disabled", true);
		}
	}
}

// 목록 저장
function viewSave(){
    
	var url = "";
    var view_prints = "";
    var view_sizes = "";
    var view_sorts = "";
    var totalSize = 0;
    var totalCnt = 0;
    var chkSize = true;
    var chkSort = true;
    
    var val = "";
    
    if ( $("#writeFrm").parsley().validate() ){
	
		url = updateBoardViewSetUrl;
    
	    $("[id^=view_print]:checked").each(function(){
		
	    	val = $(this).val();
	    	view_prints = view_prints + val + ",";
	    	
	    	// 제목링크, 비밀글, 답변상태, 댓글은 사이즈와 순서를 지정하지 않습니다.
	    	if(val != "secret" && val != "reply_status" && val != "link" && val != "comment"){
	    	    
	    		size_val = $("[name=view_size_"+val+"]").val();
		    	sort_val = $("[name=view_sort_"+val+"]").val();
		    	
		    	if(size_val == ""){
		    		chkSize = false;
		    		$("[name=view_size_"+val+"]").focus();
		    	}
		    	
		    	if(sort_val == ""){
		    		chkSort = false;
		    		$("[name=view_sort_"+val+"]").focus();
		    	}
		    	
		    	view_sizes = view_sizes + size_val + ",";
				view_sorts = view_sorts + sort_val + ",";
				totalSize = totalSize+parseInt(size_val);
		    	totalCnt++;
	    	}
		});
	    
	    // 일반형, QnA형
	    if($("#board_type").val() == "N" || $("#board_type").val() == "Q"){
		
		    if (!chkSize) {
	            alert('가로 크기를 입력해주세요');
	            return;
	        }
		    
		    if (!chkSort) {
	            alert('순서를 입력해주세요');
	            return;
	        }
		    
		    if (totalSize != 100) {
	            alert('가로 크기의 합이 100이 되어야 합니다.[현재:'+totalSize+']');
	            return;
	        }
		    
		    if (totalCnt > 8) {
	            alert('목록 뷰는 8개까지 설정이 가능합니다.[현재:'+totalCnt+']');
	            return;
	        }
	    }    
	    
	 	// 비밀글, 답변상태, 제목링크, 댓글, 국내외구분, 국가, 기타, 날짜, 공공저작물 사용, 담당정보 는 사이즈와 순서를 지정하지 않습니다.
	    if($("#secret_chk").is(":checked")) view_prints = view_prints + "secret,";
	    if($("#reply_status_chk").is(":checked")) view_prints = view_prints + "reply_status,";
	    if($("#link_chk").is(":checked")) view_prints = view_prints + "link,";
	    if($("#comment_chk").is(":checked")) view_prints = view_prints + "comment,";
	    if($("#domestic_yn").is(":checked")) view_prints = view_prints + "domestic_yn,";
	    if($("#country").is(":checked")) view_prints = view_prints + "country,";
	    if($("#etc").is(":checked")) view_prints = view_prints + "etc,";
	    if($("#contents_date").is(":checked")) view_prints = view_prints + "contents_date,";
	    if($("#cpr_use_yn").is(":checked")) view_prints = view_prints + "cpr_use_yn,";
	    if($("#charge_info_use_yn").is(":checked")) view_prints = view_prints + "charge_info_use_yn,";
	    
	    view_prints = view_prints.substring(0, view_prints.length-1);
	    view_sizes = view_sizes.substring(0, view_sizes.length-1);
	    view_sorts = view_sorts.substring(0, view_sorts.length-1);
	    
	    $("#view_print").val(view_prints);

	    // 일반형, QnA형
	    if($("#board_type").val() == "N" || $("#board_type").val() == "Q"){
	    	$("#view_size").val(view_sizes);
	    	$("#view_sort").val(view_sorts);
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
			<li><a href="javascript:tabLink('I')"><span>항목설정</span></a></li>
			<li class="on"><a href="#"><span>목록 뷰설정</span></a></li>
		</ul>
	</div>
	<!--// area_tab -->
	
	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">게시판<span class="color_pointr">${boardinfo.title }(${boardinfo.board_id })</span></h4>
	</div>
	<!--// title_area -->
	
	<!-- title_area -->
	<div class="title_area">
		<h4 class="title">Front 목록 뷰설정</h4>
	</div>
	<!--// title_area -->
	
	<!-- division20 -->
	<div class="division20">
		<p class="txt01">- 선택한 항목만 목록에 표시되며, 가로사이즈, 순서는 일반형, Q&A형 게시판 타입의 PC버전에서만 적용됩니다.<br/></p>
		<p class="txt01">- 최대 8개 항목만 출력 설정할 수 있습니다.<br/></p>
	</div>
	<!--// division20 -->
	
	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	
		<input type='hidden' id="board_id" name="board_id" value="${param.board_id}" />
		<input type='hidden' id="board_type" name="board_type" value="${boardinfo.board_type}" />
		<input type='hidden' id="mode" name="mode" value="E" />
		<input type='hidden' id="view_print" name="view_print" value="" />
		<input type='hidden' id="view_size" name="view_size" value="" />
		<input type='hidden' id="view_sort" name="view_sort" value="" />
		
		<!-- table 1dan list -->
		<div class="table_area">
			<table class="list fixed">
				<caption>항목설정 화면</caption>
				<colgroup>
					<col style="width: 15%;" />
					<col style="width: 15%;" />
					<col style="width: 40%;" />
					<col style="width: 15%;" />
					<col style="width: 15%;" />
				</colgroup>
				<thead>
				<tr>
					<th class="first" scope="col">출력선택</th>
					<th scope="col">항목코드</th>
					<th scope="col">항목명</th>
					<th scope="col">가로사이즈(%)</th>
					<th class="last" scope="col">순서</th>
				</tr>
				</thead>
				<tbody>
				
				<c:set var="arr_num" value="0" />
				<c:set var="arr_size" value="${fn:split(boardinfo.view_size, ',') }" />
				<c:set var="arr_sort" value="${fn:split(boardinfo.view_sort, ',') }" />
				
				
				<%-- 번호 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'number') != -1}">
				<tr <c:if test="${boardinfo.board_type eq 'A' }">style='background:#e9e9e9'</c:if>>
					${boardinfo.board_type} ${fn:indexOf(boardinfo.view_print, 'number') != -1}
					<td class="first">
						<input type="checkbox" id="view_print_number" value="number"
							<c:if test="${boardinfo.board_type eq 'A' or boardinfo.board_type eq 'R' or boardinfo.board_type eq 'W'}">
								onclick="return false;"
							</c:if>
							<c:if test="${boardinfo.board_type eq 'N' or boardinfo.board_type eq 'Q'}">
							 	onclick="chkbox('number')" <c:if test="${fn:indexOf(boardinfo.view_print, 'number') != -1}"> checked="checked"</c:if>
							</c:if>
						/>
					</td>
					<td>number</td>
					<td class="alignl">번호</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_number" name="view_size_number" style="text-align:center; ime-mode:disabled"  maxlength="3" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'number') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'number') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_number" name="view_sort_number" style="text-align:center" maxlength="3" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'number') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'number') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'number') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 국내외구분 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox"  id="view_print_domestic_yn" value="domestic_yn" onclick="chkbox('domestic_yn')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1}">checked</c:if> 
						/>
					</td>
					<td>domestic_yn</td>
					<td class="alignl">국내외구분</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_domestic_yn" name="view_size_domestic_yn" style="text-align:center;ime-mode:disabled"  maxlength="3" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_domestic_yn" name="view_sort_domestic_yn" style="text-align:center" maxlength="3" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'domestic_yn') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 카테고리 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox"  id="view_print_cate" value="cate" onclick="chkbox('cate')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}">checked</c:if> 
						/>
					</td>
					<td>cate</td>
					<td class="alignl">카테고리</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_cate" name="view_size_cate" style="text-align:center;ime-mode:disabled"  maxlength="3" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_cate" name="view_sort_cate" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'cate') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 제목 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'title') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox"  id="view_print_title" value="title" onclick="chkbox('title')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">checked</c:if> 
						/>
					</td>
					<td>title</td>
					<td class="alignl">제목</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_title" name="view_size_title" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'title') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_title" name="view_sort_title" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'title') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'title') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 제목링크 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'link') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="link_chk" value="link" <c:if test="${fn:indexOf(boardinfo.view_print, 'link') != -1}">checked</c:if> />
					</td>
					<td>link</td>
					<td class="alignl">제목링크</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_link" name="view_size_link" style="text-align:center;ime-mode:disabled"  maxlength="3" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_link" name="view_sort_link" style="text-align:center" maxlength="3" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 고정공지는 목록형게시판에만 적용 --%>
				<c:if test="${boardinfo.board_type eq 'N'}">
				<c:if test="${fn:indexOf(boardinfo.item_use, 'noti') != -1}">
				<tr>
					<td class="first"><input type="checkbox" id="noti_chk" value="noti" onclick="chkbox('noti')"/></td>
					<td>noti</td>
					<td class="alignl">고정공지</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_noti" name="view_size_noti" style="text-align:center;ime-mode:disabled"  maxlength="3" value=""  disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_noti" name="view_sort_noti" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				</c:if>
				
				
				<%-- 비밀글 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'secret') != -1}">
				<tr>
					<td class="first"><input type="checkbox" id="secret_chk" value="secret" <c:if test="${fn:indexOf(boardinfo.view_print, 'secret') != -1}">checked</c:if> /></td>
					<td>secret</td>
					<td class="alignl">비밀글</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_secret" style="text-align:center;ime-mode:disabled"  maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_secret" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- URL --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'url') != -1}">
				<tr <c:if test="${boardinfo.board_type eq 'A' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="view_print_url" value="url"
							<c:if test="${boardinfo.board_type eq 'A' }">onclick="return false;"</c:if>
							<c:if test="${boardinfo.board_type ne 'A' }">
							 	<c:if test="${fn:indexOf(boardinfo.view_print, 'url') != -1}"> onclick="chkbox('url')" checked="checked"</c:if>
							</c:if>
						/>
					</td>
					<td>url</td>
					<td class="alignl">URL</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_url" name="view_size_url" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'url') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'url') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_url" name="view_sort_url" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'url') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'url') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'url') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 출처 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'origin') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_origin" value="origin" onclick="chkbox('origin')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') != -1}">checked</c:if> 
						/>
					</td>
					<td>origin</td>
					<td class="alignl">출처</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_origin" name="view_size_origin" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_origin" name="view_sort_origin" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'origin') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 국가 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'country') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_country" value="country" onclick="chkbox('country')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'country') != -1}">checked</c:if> 
						/>
					</td>
					<td>country</td>
					<td class="alignl">국가</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_country" name="view_size_country" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'country') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'country') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_country" name="view_sort_country" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'country') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'country') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'country') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 기타 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'etc') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_etc" value="etc" onclick="chkbox('etc')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1}">checked</c:if> 
						/>
					</td>
					<td>etc</td>
					<td class="alignl">기타</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_etc" name="view_size_etc" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_etc" name="view_sort_etc" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'etc') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 날짜 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'contents_date') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_contents_date" value="contents_date" onclick="chkbox('contents_date')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">checked</c:if> 
						/>
					</td>
					<td>contents_date</td>
					<td class="alignl">날짜</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_contents_date" name="view_size_contents_date" style="text-align:center;ime-mode:disabled"  maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_contents_date" name="view_sort_contents_date" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'contents_date') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 내용 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'contents') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first">
						<input type="checkbox" id="view_print_contents" value="contents" onclick="return false;"/>
					</td>
					<td>contents</td>
					<td class="alignl">내용</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_contents" name="view_size_contents" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_contents" name="view_sort_contents" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'contents') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'contents') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 답변상태 사용여부 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_yn') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="view_print_reply_yn" value="reply_yn" onclick="return false;" /></td>
					<td>reply_yn</td>
					<td class="alignl">답변상태 사용여부</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_reply_yn" name="view_size_reply_yn" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_reply_yn" name="view_sort_reply_yn" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 답변상태 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_status') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="reply_status_chk" value="reply_status"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reply_status') != -1}">checked</c:if>  
						/>
					</td>
					<td>reply_status</td>
					<td class="alignl">답변상태(답변을 사용한 게시판에서 자동출력)</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_print_reply_status" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_reply_status" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 답변내용 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_contents') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="view_print_reply_contents" value="reply_contents" onclick="return false;" /></td>
					<td>reply_contents</td>
					<td class="alignl">답변내용</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_reply_contents" name="view_size_reply_contents" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_reply_contents" name="view_sort_reply_contents" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 답변일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_date') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="view_print_reply_date" value="reply_date" onclick="return false;" /></td>
					<td>reply_date</td>
					<td class="alignl">답변일</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_reply_date" name="view_size_reply_date" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_reply_date" name="view_sort_reply_date" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 썸네일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'thumb') != -1}">
				<tr <c:if test="${boardinfo.board_type eq 'W' or boardinfo.board_type eq 'A' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="view_print_thumb" value="thumb"
							<c:if test="${boardinfo.board_type eq 'W' or boardinfo.board_type eq 'A' }">onclick="return false;" checked="checked"</c:if>
							<c:if test="${boardinfo.board_type ne 'W' and boardinfo.board_type ne 'A' }">
							 	<c:if test="${fn:indexOf(boardinfo.view_print, 'thumb') != -1}">onclick="chkbox('thumb')" checked="checked"</c:if>
							</c:if> 
						/>
					</td>
					<td>thumb</td>
					<td class="alignl">썸네일</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_thumb" name="view_size_thumb" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'thumb') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'thumb') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_thumb" name="view_sort_thumb" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'thumb') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'thumb') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'thumb') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'attach') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_attach" value="attach" onclick="chkbox('attach')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}">checked</c:if> 
						/>
					</td>
					<td>attach</td>
					<td class="alignl">첨부파일</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_attach" name="view_size_attach" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_attach" name="view_sort_attach" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'attach') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 작성자(이름) --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'name') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_name" value="name" onclick="chkbox('name')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}">checked</c:if> 
						/>
					</td>
					<td>name</td>
					<td class="alignl">작성자(이름)</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_name" name="view_size_name" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'name') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_name" name="view_sort_name" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'name') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'name') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 휴대전화 
				<c:if test="${fn:indexOf(boardinfo.item_use, 'phone') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_phone" value="phone" onclick="chkbox('phone')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') != -1}">checked</c:if> 
						/>
					</td>
					<td>phone</td>
					<td class="alignl">휴대전화</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_phone" name="view_size_phone" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_phone" name="view_sort_phone" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'phone') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				--%>
				
				
				<%-- 이메일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_email" value="email" onclick="chkbox('email')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'email') != -1}">checked</c:if> 
						/>
					</td>
					<td>email</td>
					<td class="alignl">이메일</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_email" name="view_size_email" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'email') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'email') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_email" name="view_sort_email" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'email') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'email') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'email') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 작성일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reg_date') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_reg_date" value="reg_date" onclick="chkbox('reg_date')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}">checked</c:if> 
						/>
					</td>
					<td>reg_date</td>
					<td class="alignl">작성일(현재, 지정중 선택)</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_reg_date" name="view_size_reg_date"  style="text-align:center" maxlength="3"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_reg_date" name="view_sort_reg_date" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'reg_date') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 아이피 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'ip_addr') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_ip_addr" value="ip_addr" onclick="chkbox('ip_addr')"  
							<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">checked</c:if> 
						/>
					</td>
					<td>ip_addr</td>
					<td class="alignl">IP</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_ip_addr" name="view_size_ip_addr" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_ip_addr" name="view_sort_ip_addr" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 공공저작물 사용 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cpr_use_yn') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first">
						<input type="checkbox" id="view_print_cpr_use_yn" value="cpr_use_yn" onclick="return false;" />
					</td>
					<td>cpr_use_yn</td>
					<td class="alignl">공공저작물 사용</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_cpr_use_yn" name="view_size_cpr_use_yn" style="text-align:center;ime-mode:disabled" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cpr_use_yn') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cpr_use_yn') == -1}">disabled="disabled"</c:if> 
						disabled />
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_cpr_use_yn" name="view_sort_cpr_use_yn" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cpr_use_yn') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'cpr_use_yn') == -1}">disabled="disabled"</c:if> 
						disabled />
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'cpr_use_yn') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 담당자 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'charge_info_use_yn') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first">
						<input type="checkbox" id="view_print_charge_info_use_yn" value="charge_info_use_yn" onclick="return false;" />
					</td>
					<td>charge_info_use_yn</td>
					<td class="alignl">담당자</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_charge_use_yn" name="view_size_charge_use_yn" style="text-align:center;ime-mode:disabled" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'charge_info_use_yn') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'charge_info_use_yn') == -1}">disabled="disabled"</c:if> 
						disabled />
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_charge_use_yn" name="view_sort_charge_use_yn" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'charge_info_use_yn') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'charge_info_use_yn') == -1}">disabled="disabled"</c:if> 
						disabled />
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'charge_info_use_yn') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 추천 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'recommend') != -1}">
				<tr <c:if test="${boardinfo.board_type eq 'A' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="view_print_recommend" value="recommend"
							<c:if test="${boardinfo.board_type eq 'A' }">onclick="return false;"</c:if>
							<c:if test="${boardinfo.board_type ne 'A' }">
							 	<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') != -1}">onclick="chkbox('recommend')" checked="checked"</c:if>
							</c:if>
						/>
					</td>
					<td>recommend</td>
					<td class="alignl">추천</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_recommend" name="view_size_recommend" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_recommend" name="view_sort_recommend" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'recommend') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 만족도 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'satisfy') != -1}">
				<tr <c:if test="${boardinfo.board_type eq 'A' }">style='background:#e9e9e9'</c:if>>
					<td class="first">
						<input type="checkbox" id="view_print_satisfy" value="satisfy"
							<c:if test="${boardinfo.board_type eq 'A' }">onclick="return false;"</c:if>
							<c:if test="${boardinfo.board_type ne 'A' }">
							 	<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') != -1}">onclick="chkbox('satisfy')" checked="checked"</c:if>
							</c:if>
						/>
					</td>
					<td>satisfy</td>
					<td class="alignl">만족도</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_satisfy" name="view_size_satisfy" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_satisfy" name="view_sort_satisfy" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'satisfy') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				
				<%-- 댓글 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="comment_chk" value="comment" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">checked</c:if>
						/>
					</td>
					<td>comment</td>
					<td class="alignl">댓글</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_comment" style="text-align:center" maxlength="3" disabled />
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_comment" style="text-align:center" maxlength="3" disabled />
					</td>
				</tr>
				</c:if>
				
				
				<%-- SNS공유 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'sns') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="view_print_sns" value="sns" onclick="return false;" /></td>
					<td>sns</td>
					<td class="alignl">SNS공유</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_sns" name="view_size_sns" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_sns" name="view_sort_sns" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 인쇄 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'print') != -1}">
				<tr style='background:#e9e9e9'>
					<td class="first"><input type="checkbox" id="view_print_print" value="print" onclick="return false;" /></td>
					<td>print</td>
					<td class="alignl">인쇄</td>
					<td><input type="text" class="in_w100 onlyNum" id="view_size_print" name="view_size_print" style="text-align:center" maxlength="3" value="" disabled /></td>
					<td class="last"><input type="text" class="in_w100 onlyNum" id="view_sort_print" name="view_sort_print" style="text-align:center" maxlength="3" value="" disabled /></td>
				</tr>
				</c:if>
				
				
				<%-- 조회수 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'hits') != -1}">
				<tr>
					<td class="first">
						<input type="checkbox" id="view_print_hits" value="hits" onclick="chkbox('hits')" 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}">checked</c:if> 
						/>
					</td>
					<td>hits</td>
					<td class="alignl">조회수</td>
					<td>
						<input type="text" class="in_w100 onlyNum" id="view_size_hits" name="view_size_hits" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}">value="${arr_size[arr_num]}"</c:if> 
							<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') == -1}">disabled="disabled"</c:if>
						/>
					</td>
					<td class="last">
						<input type="text" class="in_w100 onlyNum" id="view_sort_hits" name="view_sort_hits" style="text-align:center" maxlength="3"
							<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}">value="${arr_sort[arr_num]}"</c:if>
							<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') == -1}">disabled="disabled"</c:if>
						/>
					</td>
				</tr>
					<c:if test="${fn:indexOf(boardinfo.view_print, 'hits') != -1}"><c:set var="arr_num" value="${arr_num+1 }" /></c:if>
				</c:if>
				
				</tbody>
			</table>
		</div>
		<!--// table 1dan list -->
		
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button onclick="viewSave()" class="btn save" title="저장하기">
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