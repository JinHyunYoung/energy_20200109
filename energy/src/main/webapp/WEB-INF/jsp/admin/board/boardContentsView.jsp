<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%
     //치환 변수 선언합니다.
   pageContext.setAttribute("cr", "\r"); //Space
   pageContext.setAttribute("cn", "\n"); //Enter
   pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
   pageContext.setAttribute("br", "<br/>"); //br 태그
%> 

<script language="javascript">

var boardContentsListPageUrl = "<c:url value='/admin/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/admin/board/boardContentsWrite.do'/>";
var saveBoardAnswerUrl = "<c:url value='/admin/board/saveBoardContentsAnswer.do'/>";
var boardContentsViewUrl = "<c:url value='/admin/board/boardContentsView.do'/>";
var deleteBoardContentsUrl = "<c:url value='/admin/board/deleteBoardContents.do'/>";
var saveCommentUrl = "<c:url value='/admin/board/saveComment.do'/>";
var deleteCommentUrl = "<c:url value='/admin/board/deleteComment.do'/>";
var boardCommentListUrl = "<c:url value='/admin/board/boardCommentList.do'/>";
var saveSatisfyUrl = "<c:url value='/admin/board/saveSatisfy.do'/>";
var saveRecommendUrl = "<c:url value='/admin/board/saveRecommend.do'/>";
var loadRecommendUrl = "<c:url value='/admin/board/loadRecommend.do'/>";

// 목록으로 
function goList(){
    
	var f = document.writeFrm;
	   
    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();	
}

//게시물 수정
function contentsEdit(){
    
	var f = document.writeFrm;
	
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

// 게시물 삭제
function contentsDelete(){
    
    var url = deleteBoardContentsUrl;
    
	if (confirm('게시물을 삭제하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#writeFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
				    goList();
				}
			}
		});
    }
}

//답글 쓰기
function contentsReply(){
    
	var f = document.writeFrm;
	
	$("#mode").val("R");
	
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
    
	var f = document.writeFrm;
	
	$("#contents_id").val(contentsid);
	   
    f.target = "_self";
    f.action = boardContentsViewUrl;
    f.submit();
}



//답변 등록
function answerSave(){
 
	var url = saveBoardAnswerUrl;
	
	if (confirm('답변을 등록하시겠습니까?')) {
 	
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#answerFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
				    goList();
				}	
			}
		});
		
 }
}

// 추천하기
function saveRecommend(){
    
	var url = saveRecommendUrl;
	
	$.ajax({
		type: "POST",
		url: url,
		data : {
			contents_id : "${param.contents_id}",
			recommend_yn : $("#recommend_yn").val()
		},
		dataType: 'json',
		success:function(data){
			alert(data.message);
			// 추천가져오기
			loadRecommend();
		}
	});
}

// 추천가져오기
function loadRecommend(){
    
	var url = loadRecommendUrl;
	
	$.ajax({
		type: "POST",
		url: url,
		data : {
			contents_id : "${param.contents_id}",
		},
		dataType: 'json',
		success:function(data){
			if(data.recommend_yn == "Y"){
				$("#recommend_cnt").html(data.recommend_cnt);
				$("#recommend_yn").val(data.recommend_yn);
				$(".btn_recommend").addClass("pick");
			}else{
				$("#recommend_cnt").html(data.recommend_cnt);
				$("#recommend_yn").val(data.recommend_yn);
				$(".btn_recommend").removeClass("pick");
			}
		}
	});
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
	
	<!-- sns_btn_area -->
	<div class="sns_btn_area">
		<button class="btn_recommend " onclick="saveRecommend()"> <!-- 내가 클릭했을때 -->
			<span id="recommend_cnt">0</span>
		</button>
		<a href="javascript:;" onclick="goTwitter('${contentsinfo.title }','http://localhost/admin/board/boardContentsView.do?contents_id=${param.contents_id}&board_id=${param.board_id}')" title="해당 게시물 트위터로 공유하기">
			<img src="/images/admin/icon/sns_twitter.png" alt="" />
		</a>
		<a href="javascript:;" onclick="goFacebook('http://localhost/admin/board/boardContentsView.do?contents_id=${param.contents_id}&board_id=${param.board_id}')" title="해당 게시물 페이스북으로 공유하기">
			<img src="/images/admin/icon/sns_facebook.png" alt="" /> 
		</a>
		<a href="javascript:;" onclick="contentsPrint('content');" title="해당 게시물 프린트 하기">
			<img src="/images/admin/icon/sns_print.png" alt="" />
		</a>
	</div>
	<!--// sns_btn_area -->
	
	<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">
	
		<input type='hidden' id="grant_write" name='grant_write' value="" />
		<input type='hidden' id="grant_reply" name='grant_reply' value="" />
		<input type='hidden' id="mode" name='mode' value="E" />
		<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
		<input type='hidden' id="contents_id" name='contents_id' value="${param.contents_id}" />
		<input type='hidden' id="gubun" name='gubun' value="${param.gubun}" />
		<input type='hidden' id="recommend_yn" name='recommend_yn' value="" />
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="s_reply_ststus" name='s_reply_ststus' value="${param.reply_ststus }" />
		<input type='hidden' id="s_searchkey" name='s_searchkey' value="${param.searchkey }" />
		<input type='hidden' id="s_searchtxt" name='s_searchtxt' value="${param.searchtxt }" />
		<input type='hidden' id="s_cate_id" name='s_cate_id' value="${param.cate_id }" />
		
		<!-- view_title_area -->
		<h4 class="view_title">
			<span>
			
				<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}">
					<c:if test="${domestic_yn ne 'Y'}">[국내]	</c:if>
					<c:if test="${domestic_yn eq 'N'}">[해외]	</c:if>
				</c:if>
				
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">
					<c:if test="${not empty contentsinfo.cate_nm}">[${contentsinfo.cate_nm }]</c:if>
				</c:if>
				
				${contentsinfo.title}
				
			</span>
			
			<c:if test="${fn:indexOf(boardinfo.item_use, 'hits') != -1}">
				<span style="float:right">조회수 : ${contentsinfo.hits }</span>
			</c:if>
			
		</h4>
		<!--// view_title_area -->

		<!-- division view_area -->
		<div class="view_area" id="contentsView">
		
			<!-- dl_view -->
			<div class="dl_view viewdlpad">
			
				<dl class="view">
					<dt class="vdt"><span>작성자</span></dt>
					<dd class="vdd">${contentsinfo.name }</dd>
				
					<!--
					<dt class="vdt"><span>휴대전화</span></dt>
					<dd class="vdd">${contentsinfo.handphone }</dd>
				
					<dt class="vdt"><span>sms수신여부</span></dt>
					<dd class="vdd">
						<c:if test="${contentsinfo.sms_recv eq 'Y'}">사용</c:if>
						<c:if test="${contentsinfo.sms_recv ne 'Y'}"><dd class="vdd">사용안함</c:if>
					</dd>
					-->
				
					<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1}">
					<dt class="vdt"><span>이메일</span></dt>
					<dd class="vdd">${contentsinfo.email }</dd>
				
					<dt class="vdt"><span>이메일수신여부</span></dt>
					<dd class="vdd">
						<c:if test="${contentsinfo.email_recv_yn eq 'Y'}">사용</c:if>
						<c:if test="${contentsinfo.email_recv_yn ne 'Y'}"><dd class="vdd">사용안함</c:if>
					</dd>
					</c:if>
				
					<dt class="vdt"><span>작성일</span></dt>
					<dd class="vdd">${contentsinfo.reservation_date }</dd>
					
					<dt class="vdt"><span>IP</span></dt>
					<dd class="vdd">${contentsinfo.ip_addr }</dd>
				</dl>
				
				
				<c:if test="${
				fn:indexOf(boardinfo.item_use, 'url') != -1 or 
				fn:indexOf(boardinfo.item_use, 'origin') != -1 or 
				fn:indexOf(boardinfo.item_use, 'country') != -1 or 
				fn:indexOf(boardinfo.item_use, 'etc') != -1 or 
				fn:indexOf(boardinfo.item_use, 'contents_date') != -1}">
				<dl class="view">
				
					<%--URL --%>
					<c:if test="${fn:indexOf(boardinfo.item_use, 'url') != -1}">
						<c:if test="${not empty contentsinfo.url_title }">
							<dt class="vdt"><span>URL명</span></dt>
							<dd class="vdd">
								<a href="${contentsinfo.url_link }" title="URL 링크" target="_blank">${contentsinfo.url_title }</a>
							</dd>
						</c:if>
					</c:if>
			
					<%--출처 --%>
					<c:if test="${fn:indexOf(boardinfo.item_use, 'origin') != -1}">
						<dt class="vdt"><span>출처</span></dt>
						<dd class="vdd">${contentsinfo.origin }</dd>
					</c:if>
					
					<%--국가 --%>
					<c:if test="${fn:indexOf(boardinfo.item_use, 'country') != -1}">
						<dt class="vdt"><span>국가</span></dt>
						<dd class="vdd">${contentsinfo.country }</dd>
					</c:if>
					
					<%--기타 --%>
					<c:if test="${fn:indexOf(boardinfo.item_use, 'etc') != -1}">
						<dt class="vdt"><span>
							<c:if test="${boardinfo.etc_label_nm eq 1 }">기타</c:if>
							<c:if test="${boardinfo.etc_label_nm eq 2 }">출원번호</c:if>
							<c:if test="${boardinfo.etc_label_nm eq 3 }">발행처</c:if>
							<c:if test="${boardinfo.etc_label_nm eq 4 }">운영기관</c:if>
						</span></dt>
						<dd class="vdd">${contentsinfo.etc }</dd>
					</c:if>
					
					<%--날짜 --%>
					<c:if test="${fn:indexOf(boardinfo.item_use, 'contents_date') != -1}">
						<dt class="vdt"><span>
							<c:if test="${boardinfo.contents_date_label_nm eq 1 }">날짜</c:if>
							<c:if test="${boardinfo.contents_date_label_nm eq 2 }">출원일</c:if>
							<c:if test="${boardinfo.contents_date_label_nm eq 3 }">발간일</c:if>
						</span></dt>
						<dd class="vdd">${contentsinfo.contents_date }</dd>
					</c:if>
					
				</dl>
				</c:if>
				
				<%--첨부파일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'attach') != -1}">
					<c:if test="${not empty fileList}">
					<dl class="view">
						<dt class="vdt"><span>첨부파일</span></dt>
						<dd class="vdd file">
							<c:forEach items="${fileList}" var="list">
								
								<c:set var="file_size" value="${list.file_size/1024}" />
								<fmt:formatNumber value="${file_size}" var="size" pattern="0" />
								
								<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
									<c:choose>
										<c:when test="${list.file_type eq 'hwp'}"><img src="/images/admin/icon/icon_hwp.png" alt="한글파일" /></c:when>
										<c:when test="${list.file_type eq 'pdf'}"><img src="/images/admin/icon/icon_pdf.png" alt="pdf파일" /></c:when>
										<c:when test="${list.file_type eq 'xls'}"><img src="/images/admin/icon/icon_excel.png" alt="엑셀파일" /></c:when>
										<c:when test="${list.file_type eq 'xlsx'}"><img src="/images/admin/icon/icon_excel.png" alt="엑셀파일" /></c:when>
										<c:otherwise><img src="/images/admin/icon/icon_file.png" alt="파일" /></c:otherwise>
									</c:choose>
									${list.origin_file_nm}(${size}KB)
								</a>
								
							</c:forEach>
						</dd>
					</dl>
					</c:if>
				</c:if>
				
			</div>
			<!--// dl_view -->

			<!-- editor -->
			<c:if test="${fn:indexOf(boardinfo.item_use, 'contents') != -1}">
			<div class="editor_area view">${fn:replace(contentsinfo.contents, cn, br)}</div>
			</c:if>
			<!--// editor -->
			
		</div>
		<!--// division view_area -->
	</form>
	</br>
	
	<%-- 답변사용여부 --%>
	<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_yn') != -1}">
	
	<div class="title_area margint40">
		<h4 class="title">답변</h4>
	</div>
	
	<!-- division view_area -->
	<form id="answerFrm" name="answerFrm" onsubmit="return false;">
	
		<input type="hidden" name="board_id" value="${param.board_id}" />
		<input type="hidden" name="contents_id" value="${param.contents_id}" />
		<input type='hidden' name='writer_name' value="${contentsinfo.name}" />
		<input type="hidden" name="questions_title" value="${contentsinfo.title}" />
		<input type="hidden" name="questions_contents" value="${contentsinfo.contents}" />
		
		<!-- answer_area -->
		<div class="answer_area">
			<!-- answer -->
			<dl class="answer">
				<dt class="adt"><span>답변일</span></dt>
				<dd class="add">${contentsinfo.contents_date}</dd>
			</dl>
			<!--// answer -->
			<!-- editor -->
			<div class="editor_area">
				<textarea class="in_w100" cols="5" rows="7" id="contents_txt" name="contents_txt">${contentsinfo.contents_txt}</textarea>
			</div>
			<!--// editor -->
		</div>
		<!--// answer_area -->
		
	</form>
	<!--// division view_area -->
	
	</c:if>
	
	<!-- button_area -->
	<div class="button_area">
	
		<div class="float_left">
			<c:if test="${not empty prenext.pre_id }">
			<a href="javascript:contentsView('${prenext.pre_id }')" title="${prenext.pre_title }">
				<img src="/images/admin/common/btn_prev.png" alt="이전글 보기" />
			</a>
			</c:if>
			<c:if test="${not empty prenext.next_id }">
			<a href="javascript:contentsView('${prenext.next_id }')" title="${prenext.next_title }">
				<img src="/images/admin/common/btn_next.png" alt="다음글 보기" />
			</a>
			</c:if>
		</div>
		
		<div class="float_right">
			<%-- 답변은 관리자만 저장할 수 있음(front 제거) --%>
			<c:if test="${fn:indexOf(boardinfo.item_use, 'reply_yn') != -1}">
			<button id="answerSave" class="btn save" onclick="answerSave()" title="답변저장하기">
				<span>답변저장</span>
			</button>
			</c:if>
			<c:if test="${boardinfo.board_type ne 'Q' }">
			<button id="replyBtn" onclick="contentsReply()" class="btn save" title="답글쓰기" >
				<span>답글</span>
			</button>
			</c:if>
			<button id="modBtn" onclick="contentsEdit()" class="btn save" title="수정하기">
				<span>수정</span>
			</button>
			<button id="delBtn" onclick="contentsDelete()" class="btn cancel" title="삭제하기">
				<span>삭제</span>
			</button>
			<a href="javascript:goList()" class="btn list" title="목록 페이지로 이동">
				<span>목록</span>
			</a>
		</div>
		
	</div>
	<!--// button_area -->

	<%-- 공공저작물사용여부 
	<c:if test="${fn:indexOf(boardinfo.item_use, 'cpr_use_yn') != -1}">
		<c:if test="${contentsinfo.cpr_use_yn eq 'Y' && contentsinfo.cpr_cmrc_use_yn eq 'Y' && contentsinfo.cpr_chng_use_yn eq 'Y'}">
		<div class="kogl_area kogl_01">
			<p>본 저작물은 <strong>"공공누리 제1유형 : 출처표시"</strong> 조건에 따라 이용할 수 있습니다.</p>
		</div>
		</c:if>
		
		<c:if test="${contentsinfo.cpr_use_yn eq 'Y' && contentsinfo.cpr_cmrc_use_yn eq 'N' && contentsinfo.cpr_chng_use_yn eq 'Y'}">
		<div class="kogl_area kogl_02">
			<p>본 저작물은 <strong>"공공누리 제2유형 : 출처표시+상업적이용금지"</strong> 조건에 따라 이용할 수 있습니다.</p>
		</div>
		</c:if>
		
		<c:if test="${contentsinfo.cpr_use_yn eq 'Y' && contentsinfo.cpr_cmrc_use_yn eq 'Y' && contentsinfo.cpr_chng_use_yn eq 'N'}">
		<div class="kogl_area kogl_03">
			<p>본 저작물은 <strong>"공공누리 제3유형 : 출처표시+변경금지"</strong> 조건에 따라 이용할 수 있습니다.</p>
		</div>
		</c:if>
		
		<c:if test="${contentsinfo.cpr_use_yn eq 'Y' && contentsinfo.cpr_cmrc_use_yn eq 'N' && contentsinfo.cpr_chng_use_yn eq 'N'}">
		<div class="kogl_area kogl_04">
			<p>본 저작물은 <strong>"공공누리 제4유형 : 출처표시+상업적이용금지+변경금지"</strong> 조건에 따라 이용할 수 있습니다.</p>
		</div>
		</c:if>
	</c:if>
	--%>
		
	<%-- 담당정보 
	<c:if test="${fn:indexOf(boardinfo.item_use, 'charge_info_use_yn') != -1}">
		<div class="list_foot_area">
		<c:if test="${contentsinfo.charge_info != '' || contentsinfo.charge_info ne null}">
			<div class="responsibility_area">
				<ul>
					<li>
						<strong>${contentsinfo.charge_info}</strong>
					</li>
				</ul>
			</div>
		</c:if>
		</div>
	</c:if>
	--%>
	
	<%-- 댓글 사용여부 --%>
	<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
	<div class="comment_area">
	
		<div class="comment_title_area">
			<h5 class="comment_title">댓글</h5><strong class="number"><span id="commentCnt">0</span></strong>
		</div>
		<div class="commentbox_area">
		
		<!-- 댓글 입력 -->
		<form id="commentFrm" name="commentFrm" method="post" onsubmit="saveComment(this); return false;">
			
			<input type="hidden" name="mode" value="W" />
			<input type='hidden' id="contents_id" name="contents_id" value="${param.contents_id}" />
			<input type='hidden' id="comment_id" name="comment_id" value="" />
			<input type='hidden' id="name" name="name" value="${name}" />
			<input type='hidden' id="grp" name="grp" value="0" />
			<input type='hidden' id="sort" name="sort" value="0" />
			<input type='hidden' id="depth" name="depth" value="0" />
			
			<div class="txtinput_area">
				<div class="txtbox">
					<textarea class="txtinput" id="contents" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)"></textarea>
					<div class="float_right margin5">
						<div class="count_number">
							<strong id="strCnt">0</strong> / 300 Byte
						</div>
						<button id="commentSave" class="btn s_save_btn" title="등록하기">
							<span>등록하기</span>
						</button>
					</div>
				</div>
			</div>
		</form>
		<!--// 댓글 입력 -->

		<!--- list -->
		<div id="commentList"><div>
	</c:if>
	
</div>

<script language="javascript">

$(document).ready(function(){
	
	// 추천수 가져오기
	loadRecommend(); 
	
	<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
	
	// 댓글 불러오기	
	loadCommentList(); 	
	
	</c:if>
});

//댓글 리스트 불러오기
function loadCommentList(){
	$.ajax({
        url: boardCommentListUrl,
        dataType: "html",
        type: "post",
        data: {
        	contents_id : "${param.contents_id}"
		},
        success: function(data) {
        	$("#commentList").html(data);
        	$("#commentCnt").text($(".comment_list li").length);   	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

// 댓글 저장
function saveComment(frm) {
	
	if(frm.contents.value == ""){
		alert("댓글을 입력하여야 합니다.");
		return;
	}
	
    if (confirm('저장하시겠습니까?')) {
        $.ajax({
            type: 'post',
            url: saveCommentUrl,
            dataType: 'json',
            data: $(frm).serialize(),
            success: function(data) {
            	if(data.success == "true"){
                    frm.contents.value = "";
                    loadCommentList();
                } else {
                    alert(data.message);
                }
            }
        });
    }
}

function delComment(idx) {
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            type: 'post',
            url: deleteCommentUrl,
            dataType: 'json',
            data: {
            	contents_id : "${param.contents_id}",
            	comment_id : idx
            },
            success: function(data) {
            	if(data.success == "true"){
                    loadCommentList();
                } else {
                	alert(data.message);
                }
            }
        });
    }
}

function reComment(el, idx, grp, sort) {
    var fid = "reFrm"+idx;
    var contents_id = "${param.contents_id}";
    var name = "${name }";
    
    if ($('.'+fid).length>0) return;
    var date = getTimeStamp();

    var html = '<li class="' + fid + '">';
    html += '<div class="info_arae"><strong>'+name+'</strong><span>' + date + '</span></div>';
    html += '<form id="modFrm_'+idx+'" method="post" onsubmit="saveComment(this); return false;">';
    html += '<input type="hidden" name="mode" value="R" />';
    html += '<input type="hidden" id="contents_id" name="contents_id" value="'+contents_id+'" />';
    html += '<input type="hidden" id="name" name="name" value="'+name+'" />';
    html += '<input type="hidden" id="grp" name="grp" value="'+grp+'" />';
    html += '<input type="hidden" id="sort" name="sort" value="'+sort+'" />';
    html += '<input type="hidden" id="depth" name="depth" value="1" />';    
    html += '<div class="txtinput_area">';
    html += '    <div class="txtbox">';
    html += '        <textarea class="txtinput" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)"></textarea>';
    html += '        <div class="float_right margin5">';
    html += '        	<div class="count_number">';
    html += '            	<strong>0</strong> / 300 Byte';
    html += '        	</div>';
    html += '    	 	<button class="btn s_save_btn" title="등록하기">';
    html += '        		<span>등록하기</span>';
    html += '    	 	</button>';
    html += '    	 	<button type="button" class="btn_comment_cancel" title="취소" onclick="$(\'.' + fid + '\').remove();">';
    html += '        		<span><img src="/images/admin/common/btn_comment_delete.png" alt="삭제하기" /></span>';
    html += '    	 	</button>';
    html += '        </div>';
    html += '    </div>';
    html += '</div>';
    html += '</form></li>';
    

    if ($('#child_'+idx).length) {
        $('#child_'+idx).append(html);
    } else {
        var div = '<li class="' + fid + '"><div class="recommentbox">';
            div += '<ul class="comment_list">' + html + '<ul></div></li>';

        $(el).parent().parent().after(div);
    }
}

function modComment(el, idx) {
    if ($("#modFrm_"+idx).length>0) return;
    
    var cont = $(el).parent().siblings(".contents");
    var contents_id = "${param.contents_id}";
    
    var txt = $(cont).text();
    txt = $.trim(txt);

    var html = '<form id="modFrm_'+idx+'" method="post" onsubmit="saveComment(this); return false;">';
    html += '<input type="hidden" name="mode" value="E" />';
    html += '<input type="hidden" id="contents_id" name="contents_id" value="'+contents_id+'" />';
    html += '<input type="hidden" id="comment_id" name="comment_id" value="'+idx+'" />';
    html += '<div class="txtinput_area">';
    html += '    <div class="txtbox">';
    html += '        <textarea class="txtinput" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)">' + txt + ' </textarea>';
    html += '		 <div class="float_right margin5">';
    html += '        	<div class="count_number">';
    html += '            	<strong>0</strong> / 300 Byte';
    html += '        	</div>';
    html += '    	 	<button class="btn s_save_btn" title="등록하기">';
    html += '        		<span>등록하기</span>';
    html += '    	 	</button>';
    html += '    	 	<button type="button" class="btn_comment_cancel" title="취소" onclick="removeFrm(this);">';
    html += '        		<span><img src="/images/admin/common/btn_comment_delete.png" alt="삭제하기" /></span>';
    html += '    	 	</button>';
    html += '        </div>';
    html += '    </div>';
    html += '</div>';
    html += '</form>';

    $(cont).hide();
    $(el).parent().after(html);
}

function removeFrm(el) {
    $(el).parent().parent().siblings('.contents').show();
    $(el).parent().parent().remove();
}

function getTimeStamp() {
  var d = new Date();
  var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2) + ':' +
    leadingZeros(d.getSeconds(), 2);

  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


// byte check
function pubByteCheckTextarea(obj) {
    var byteTxt = "";
    var byte = function(str){
        var byteNum=0;
        for(i=0;i<str.length;i++){
            byteNum+=(str.charCodeAt(i)>127)?2:1;
            if(byteNum < 600){
                byteTxt+=str.charAt(i);
            };
        };
        return Math.round( byteNum/2 );
    };

    if(byte($(obj).val()) > 300){
        alert("300자 이상 입력할수 없습니다.");
        $(obj).val("");
        $(obj).val(byteTxt);
    } else {
		$(obj).next().children("div").children("strong").html( byte($(obj).val()) );
    }
}
</script>