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

var boardContentsListPageUrl = "<c:url value='/web/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/web/board/boardContentsWrite.do'/>";
var boardContentsViewUrl = "<c:url value='/web/board/boardContentsView.do'/>";
var deleteBoardContentsUrl = "<c:url value='/web/board/deleteBoardContents.do'/>";
var chkCommentUrl = "<c:url value='/web/board/chkComment.do'/>";
var saveCommentUrl = "<c:url value='/web/board/saveComment.do'/>";
var deleteCommentUrl = "<c:url value='/web/board/deleteComment.do'/>";
var boardCommentListUrl = "<c:url value='/web/board/boardCommentList.do'/>";
var saveSatisfyUrl = "<c:url value='/web/board/saveSatisfy.do'/>";
var saveRecommendUrl = "<c:url value='/web/board/saveRecommend.do'/>";
var loadRecommendUrl = "<c:url value='/web/board/loadRecommend.do'/>";
var passPopupUrl = "<c:url value='/web/board/boardContentsPassPopup.do'/>";
var chkCommentUrl = "<c:url value='/web/board/chkComment.do'/>";

var cmt_el;
var cmt_commentid;
var mode;


//목록으로 
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
	var f = document.writeFrm;
	
	// 패스워드가 있는 경우 페이지로 보낸다.
	<c:if test="${contentsinfo.pass_yn eq 'Y'}">
	$("#mode").val("D");
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
	</c:if>
	
	<c:if test="${empty contentsinfo.pass_yn}">
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
	</c:if>
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

// 만족도 저장
function saveSatisfy(){
	
// 기존 소스 - 시작 /////////////////
// 	// 로그인 여부 확인하기
// 	var sid = "${s_user_no }";	
// 	if(sid == ""){
// 		alert("로그인이 후 참여 가능합니다.");
// 		return;
// 	}

// 	var yn = "${contentsinfo.satisfy_yn}";	
// 	if(yn == "Y"){
// 		alert("이미 참여하였습니다.");
// 		return;
// 	}
// 기존 소스 - 끝 /////////////////

// 변경 소스 - 시작 /////////////////
	var sid = "${s_user_no }";	
	var contents_id_sati = $("#contents_id").val() + '_s';
	if(sid == ""){
		if($.cookie(contents_id_sati) == 'Y'){
			alert("이미 참여하였습니다.");
			return;
		}
	}else{
		var yn = "${contentsinfo.satisfy_yn}";	
	 	if(yn == "Y"){
	 		alert("이미 참여하였습니다.");
	 		return;
	 	}
	}
// 변경 소스 - 끝 /////////////////
	
	
	var url = saveSatisfyUrl;
	if (confirm('만족도를 저장하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: url,
			data :jQuery("#satisfyFrm").serialize(),
			dataType: 'json',
			success:function(data){
				alert(data.message);
				if(data.success == "true"){
					$(".satisfaction_area").hide();
					// 변경 소스 - 시작 /////////////////
					if(sid == ""){
						$.cookie(contents_id_sati, 'Y',{expires:365});
					}
					// 변경 소스 - 끝 /////////////////
				}	
			}
		});
    }
}

// 추천하기
function saveRecommend(){
	
// 기존 소스 - 시작 /////////////////
// 	// 로그인 여부 확인하기
// 	var sid = "${s_user_no }";	
// 	if(sid == ""){
// 		alert("로그인이 후 참여 가능합니다.");
// 		goPage('7d8de154663840ad83ae6d93bf539c5c', '', '');
// 		return;
// 	}
// 기존 소스 - 끝 /////////////////
	
	var url = saveRecommendUrl;
	$.ajax({
		type: "POST",
		url: url,
		data : {
			contents_id : "${param.contents_id}",
			s_userip : $("#s_userip").val(),// 변경 소스 
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

<!-- sns_btn_area -->
<c:if test="${
fn:indexOf(boardinfo.item_use, 'recommend') != -1 or 
fn:indexOf(boardinfo.item_use, 'sns') != -1 or 
fn:indexOf(boardinfo.item_use, 'print') != -1 }">	
<div class="sns_btn_area">

	<%-- 추천사용여부 --%>
	<c:if test="${fn:indexOf(boardinfo.item_use, 'recommend') != -1}">
		<button class="btn_recommend" onclick="saveRecommend()"> 
			<span id="recommend_cnt">0</span>
		</button>
	</c:if>
	
	<%--SNS공유 사용여부 --%>
	<c:if test="${fn:indexOf(boardinfo.item_use, 'sns') != -1}">
		<a href="javascript:;" onclick="goTwitter('${contentsinfo.title }','http://${pageContext.request.serverName}/web/board/boardContentsView.do?contents_id=${param.contents_id}&board_id=${param.board_id}')" title="해당 게시물 트위터로 공유하기">
			<img src="/images/web/icon/sns_twitter.png" alt="트위터 이동">
		</a>
		<a href="javascript:;" onclick="goFacebook('http://${pageContext.request.serverName}/web/board/boardContentsView.do?contents_id=${param.contents_id}&board_id=${param.board_id}')" title="해당 게시물 페이스북으로 공유하기">
			<img src="/images/web/icon/sns_facebook.png" alt="페이스북 이동">
		</a>
	</c:if>
	
	<%-- 프린트사용여부 --%>
	<c:if test="${fn:indexOf(boardinfo.item_use, 'print') != -1}">
		<a href="javascript:;" onclick="contentsPrint('contentsView');" title="해당 게시물 프린트 하기">
			<img src="/images/web/icon/sns_print.png" alt="프린트">
		</a>
	</c:if>
	
</div>
</c:if>
<!--// sns_btn_area -->

<form id="writeFrm" name="writeFrm" method="post" onsubmit="return false;">

	<input type='hidden' id="mode" name='mode' value="E" />
	<input type='hidden' id="board_id" name='board_id' value="${contentsinfo.board_id}" />
	<input type='hidden' id="contents_id" name='contents_id' value="${param.contents_id}" />
	<input type='hidden' id="recommend_yn" name='recommend_yn' value="" />
	<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${param.miv_pageNo }" />
	<input type='hidden' id="s_reply_ststus" name='s_reply_ststus' value="${param.reply_ststus }" />
	<input type='hidden' id="s_searchkey" name='s_searchkey' value="${param.searchkey }" />
	<input type='hidden' id="s_searchtxt" name='s_searchtxt' value="${param.searchtxt }" />
	<input type='hidden' id="s_cate_id" name='s_cate_id' value="${param.cate_id }" />	
	
</form>

<!-- view_title -->
<div id="contentsView">

	<h4 class="view_title">
		<span>
			<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}">
				<c:if test="${domestic_yn ne 'Y'}">[국내]	</c:if>
				<c:if test="${domestic_yn eq 'N'}">[해외]	</c:if>
			</c:if>
			<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}">
				<c:if test="${not empty contentsinfo.cate_nm}">[${contentsinfo.cate_nm }]</c:if>
			</c:if>		
			${contentsinfo.title }
		</span>
		<c:if test="${fn:indexOf(boardinfo.item_use, 'hits') != -1}">
			<span class="count_num">조회수 : ${contentsinfo.hits }</span>
		</c:if>
	</h4>
	<!--// view_title -->

	<!-- view_area -->
	<div class="view_area" >
	
		<!-- dl_view -->
		<div class="dl_view viewdlpad">
				
			<c:if test="${
			fn:indexOf(boardinfo.item_use, 'name') != -1 or 
			fn:indexOf(boardinfo.item_use, 'email') != -1 or 
			fn:indexOf(boardinfo.item_use, 'reg_date') != -1 or 
			fn:indexOf(boardinfo.view_print, 'ip_addr') != -1 }">	
			<dl class="view">
			
				<%--작성자 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'name') != -1}">
					<dt class="vdt"><span>작성자</span></dt>
					<dd class="vdd">${contentsinfo.name }</dd>
				</c:if>
				
				
				<%--휴대전화 
				<c:if test="${fn:indexOf(boardinfo.item_use, 'phone') != -1}">
				
					<c:set var="phone1" value="" />
					<c:set var="phone2" value="" />
					<c:set var="phone3" value="" />
					
					<c:if test="${not empty contentsinfo.handphone}">
						<c:set var="phone" value="${contentsinfo.handphone}" />
						<c:set var="phone_split" value="${fn:split(phone, '-')}" />
						<c:forEach var="p1" items="${phone_split }" varStatus="s">
							<c:if test="${s.count == 1 }"><c:set var="phone1" value="${p1}" /></c:if>
							<c:if test="${s.count == 3 }"><c:set var="phone3" value="${p1}" /></c:if>
						</c:forEach>
					</c:if>
					
					<dt class="vdt"><span>휴대전화</span></dt>
					
					<c:if test="${not empty phone1}">				
						<dd class="vdd">${phone1}-****-${phone3}
					</c:if>	
					
					</dd>
					
				</c:if>
				--%>
				
				<%--이메일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'email') != -1}">
					<dt class="vdt"><span>이메일</span></dt>
					<dd class="vdd"><c:if test="${contentsinfo.email != '' || contentsinfo.email ne null}">${contentsinfo.email}</c:if></dd>
				</c:if>
				
				
				<%--작성일 --%>
				<c:if test="${fn:indexOf(boardinfo.item_use, 'reg_date') != -1}">
					<dt class="vdt"><span>작성일</span></dt>
					<dd class="vdd">${contentsinfo.reservation_date}</dd>
				</c:if>
				
				
				<%-- IP --%>
				<c:if test="${fn:indexOf(boardinfo.view_print, 'ip_addr') != -1}">
					<dt class="vdt"><span>IP</span></dt>
					<dd class="vdd">${contentsinfo.ip_addr}</dd>
				</c:if>
				
			</dl>
			</c:if>
			
				
			<c:if test="${
			fn:indexOf(boardinfo.item_use, 'url') != -1 or 
			fn:indexOf(boardinfo.item_use, 'origin') != -1 or 
			fn:indexOf(boardinfo.item_use, 'country') != -1 or 
			fn:indexOf(boardinfo.item_use, 'etc') != -1 or 
			fn:indexOf(boardinfo.item_use, 'contents_date') != -1 }">	
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
			<c:if test="${not empty fileList }">				
			<dl class="view">
			
				<dt class="vdt"><span>첨부파일</span></dt>
				<dd class="vdd file">
				
					<c:forEach items="${fileList }" var="list">
					
						<c:set var="file_size" value="${list.file_size/1024}" />
						<fmt:formatNumber value="${file_size}" var="size" pattern="0" />
						
						<a href="/commonfile/fileidDownLoad.do?file_id=${list.file_id}"  target="_blank" class="download" title="다운받기">
						
						<c:choose>
							<c:when test="${list.file_type eq 'hwp'}"><img src="/images/web/icon/icon_hwp.png" alt="한글파일" /></c:when>
							<c:when test="${list.file_type eq 'pdf'}"><img src="/images/web/icon/icon_pdf.png" alt="pdf파일" /></c:when>
							<c:when test="${list.file_type eq 'xls' or list.file_type eq 'xlsx'}"><img src="/images/web/icon/icon_excel.png" alt="엑셀파일" /></c:when>
							<c:otherwise>
								<img src="/images/web/icon/icon_disc.png" alt="파일" />
							</c:otherwise>
						</c:choose>
						
						${list.origin_file_nm }(${size }KB)
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
		<div class="editor">${fn:replace(contentsinfo.contents, cn, cn)}</div>	
		</c:if>
		<!--// editor -->
		
		<!-- reply_area -->
		<c:if test="${not empty contentsinfo.contents_txt }">
		<div class="reply_area">
			<strong>답변</strong>
			<div class="reply_detail_box">
				<div class="reply_date">
					<span class="reply_date_tt">답변일</span>
					<span>${contentsinfo.contents_date}</span>
				</div>
				<div class="reply_txt">
					<p>
						${contentsinfo.contents_txt}
					</p>
				</div>
			</div>
		</div>
		</c:if>
		<!--// reply_area -->
		
		<%-- 댓글 사용여부 --%>
		<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
		
		<!-- comment_area -->
		<div class="comment_area marginb30">
		
			<div class="comment_title_area">
				<h5 class="comment_title">댓글</h5><strong class="number"><span id="commentCnt"></span></strong>
			</div>
			
			<div class="commentbox_area">
			
				<!-- 댓글 입력 -->
				<form id="commentFrm" name="commentFrm" method="post" onsubmit="return false;">
				
					<input type="hidden" name="mode" value="W" />
					<input type='hidden' name="contents_id" value="${param.contents_id}" />
					<input type='hidden' id="comment_id" name="comment_id" value="" />
					<input type='hidden' id="grp" name="grp" value="0" />
					<input type='hidden' id="sort" name="sort" value="0" />
					<input type='hidden' id="depth" name="depth" value="0" />
										
					<div class="txtinput_area">
					
						<%-- 회원 --%>
						<c:if test="${not empty s_user_no}">
							<strong class="name"><input type='hidden' id="name" name="name" value="${name}" /></strong>
						</c:if>
						
						<%-- 비회원 --%>
						<c:if test="${empty s_user_no}">
							<input type="text" class="" name="name" id="name2" value="" data-parsley-required="true" placeholder="이름 *" />
							<label for="name2" class="hidden">이름 등록</label>
							<input type="password" class="" style="height: 23px;" name="pass" id="pass2" value="" data-parsley-required="true" placeholder="비밀번호 *" />
							<label for="pass2" class="hidden">비밀번호 등록</label>
						</c:if>
					
					
						<div class="txtbox">
							<textarea class="txtinput" id="contents" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this, 1)"></textarea>
							<div class="float_right margin5">
								<div class="count_number">
									<strong>0Byte</strong> /300Byte
								</div>
								<button id="commentSave" onclick="saveComment(document.getElementById('commentFrm')); return false;" class="btn s_save_btn" title="등록하기">
									<span>등록하기</span>
								</button>
							</div>
						</div>
					</div>
				</form>
				<!--// 댓글 입력 -->
				
				<!-- comment_list -->
				<div id="commentList"><div>
				<!--// comment_list -->
				
			</div>
		</div>
		<!--// comment_area -->
		
		</c:if>
	</div>
	<!--// view_area -->
	
</div>

<!-- button_area -->
<div class="button_area">

	<div class="float_left">
	
		<c:if test="${not empty prenext.pre_id }">
       		<a href="javascript:contentsView('${prenext.pre_id }')" title="${prenext.pre_title }">
       			<img src="/images/web/common/btn_prev.png" alt="이전글 보기" />
       		</a>
       		<!--
			<button class="btn_prev" onclick="contentsView('${prenext.pre_id }')" title="${prenext.pre_title }">
				<span>아랫글</span>
			</button>
			-->
		</c:if>
		
		<c:if test="${not empty prenext.next_id }">
    		<a href="javascript:contentsView('${prenext.next_id }')" title="${prenext.next_title }">
    			<img src="/images/web/common/btn_next.png" alt="다음글 보기" />
    		</a>
       		<!--
			<button class="btn_next" onclick="contentsView('${prenext.next_id }')" title="${prenext.next_title }">
				<span>윗글</span>
			</button>
			-->
		</c:if>		
		
	</div>
	
	<div class="float_right">
		<c:if test="${boardinfo.board_type eq 'N' }">
		
			<%-- 회원이면서 답글쓰기 권한이 있는경우 --%>
			<c:if test="${not empty s_user_no }">
				<c:if test="${fn:indexOf(boardinfo.grant_reply, 'M') != -1}">
					<button class="btn save" onclick="contentsReply()" title="답글"><span>답글</span></button>
				</c:if>
			</c:if>
			
			<%-- 비회원이면서 답글쓰기 권한이 있는경우 --%>
			<c:if test="${empty s_user_no }">
				<c:if test="${fn:indexOf(boardinfo.grant_reply, 'G') != -1}">
					<button class="btn save" onclick="contentsReply()" title="답글"><span>답글</span></button>
				</c:if>
			</c:if>
		</c:if>
		
		<%-- 회원이면서 답글쓰기 권한이 있는경우 --%>
		<c:if test="${not empty s_user_no }">
			<c:if test="${s_user_no  eq contentsinfo.REG_USERNO}">
			<button class="btn save" onclick="contentsEdit()" title="수정">
				<span>수정</span>
			</button>
			<button class="btn cancel" onclick="contentsDelete()" title="삭제">
				<span>삭제</span>
			</button>
			</c:if>
		</c:if>
		
		<%-- 비회원이면서 답글쓰기 권한이 있는경우 --%>
		<c:if test="${empty s_user_no }">
			<c:if test="${contentsinfo.pass_yn eq 'Y'}">
			<button class="btn save" onclick="contentsEdit()" title="수정">
				<span>수정</span>
			</button>
			<button class="btn cancel" onclick="contentsDelete()" title="삭제">
				<span>삭제</span>
			</button>
			</c:if>
		</c:if>
		
		<button class="btn list" onclick="goList()" title="목록">
			<span>목록</span>
		</button>
	</div>
</div>
<!--// button_area -->


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

<c:if test="${fn:indexOf(boardinfo.item_use, 'charge_info_use_yn') != -1 or fn:indexOf(boardinfo.item_use, 'satisfy') != -1}">

	<div class="list_foot_area">
	
		<%-- 담당정보 --%>
		<c:if test="${fn:indexOf(boardinfo.item_use, 'charge_info_use_yn') != -1}">
			<c:if test="${contentsinfo.charge_info != '' && contentsinfo.charge_info ne null}">
				<div class="responsibility_area">
					<ul>
						<li>
							<strong>${contentsinfo.charge_info}</strong>
						</li>
					</ul>
				</div>
			</c:if>
		</c:if>
	       	
		<%-- 만족도사용여부 --%>
		<c:if test="${fn:indexOf(boardinfo.item_use, 'satisfy') != -1}">
	
		<form id="satisfyFrm" name="satisfyFrm" onsubmit="return false;">
	
			<input type='hidden' name='contents_id' value="${param.contents_id}" />
			<input type='hidden' id='s_userip' name='s_userip' value="<%= request.getRemoteAddr() %>"/>
				            	
			<!-- satisfaction_area -->
			<div class="satisfy_area">
		
				<strong class="satisfaction_txt">현재 페이지의 콘텐츠 안내 및 정보 제공에 만족하십니까?</strong>
				<div class="satisfaction_radio_area">
				 	<ul>
				 		<li>
				 			<input type="radio" id="sat1" name="point" value="5" checked />
				 			<label for="sat1" class="marginr20">매우 만족</label>
				 		</li>
				 		<li>
				 			<input type="radio" id="sat2" name="point" value="4" />
				 			<label for="sat2" class="marginr20">만족</label>
				 		</li>
				 		<li>
				 			<input type="radio" id="sat3" name="point" value="3" />
				 			<label for="sat3" class="marginr20">보통</label>
				 		</li>
				 		<li>
				 			<input type="radio" id="sat4" name="point" value="2" />
				 			<label for="sat4" class="marginr20">불만족</label>
				 		</li>
				 		<li>
				 			<input type="radio" id="sat5" name="point" value="1" />
				 			<label for="sat5" class="marginr20">매우 불만족</label>
				 		</li>
				 	</ul>	
				 	
				 	<button class="btn sati btn satisfaction" onclick="saveSatisfy()" title="확인">
				 		<span>확인</span>
				 	</button>		 	
				</div>     		 	
			</div>  
		</form>
		<!--// satisfaction_area -->
		
		</c:if>          			            		
	</div>
</c:if>

<script language="javascript">
$(document).ready(function(){
	loadRecommend(); // 추천수 가져오기
	
	<c:if test="${fn:indexOf(boardinfo.item_use, 'comment') != -1}">
	loadCommentList(); // 댓글 불러오기		
	</c:if>
	
});

// 댓글 리스트 불러오기
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
        	$("#commentCnt").text($(".commentData").length);   	
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

//댓글 저장
function saveComment(frm) {	
    
	var sid = "${s_user_no}";
	var chk = false;
	
	if(sid != ""){
		<c:if test="${fn:indexOf(boardinfo.grant_write, 'M') != -1}">
			chk = true;
		</c:if>
	} else {
		<c:if test="${fn:indexOf(boardinfo.grant_write, 'G') != -1}">
			chk = true;
		</c:if>
	}	
	
	
	if(!chk){
		alert("댓글 쓰기 권한이 없습니다.");
		return;
	}
	
	if(frm.mode.value =="W" || frm.mode.value =="R"){
		
		if(frm.name.value == ""){
			alert("이름을 입력하여야 합니다.");
			return;
		}
		
		if(frm.pass.value == ""){
			alert("비밀번호을 입력하여야 합니다.");
			return;
		}		
	}
		
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


function delComment(commentid) {
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            type: 'post',
            url: deleteCommentUrl,
            dataType: 'json',
            data: {
            	contents_id : "${param.contents_id}",
            	comment_id : commentid
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


function chkComment(el, commentid, mode) {	
	
	cmt_el = el;
	cmt_commentid = commentid;
	cmt_mode = mode;
	
	 // 비밀번호 팝업
	 window.open(passPopupUrl, 'pwChangePop', 'width=490,height=255,top=100,left=100');
}

function passchk(pass){
	
	var contents_id = "${param.contents_id}";
	
	$.ajax({
        type: 'post',
        url: chkCommentUrl,
        dataType: 'json',
        data: {
        	contents_id : contents_id,
        	comment_id : cmt_commentid,
        	pass : pass
        },
        success: function(data) {
        	if(data.success == "true"){
                if(cmt_mode == "E"){
                	modComment(cmt_el,cmt_commentid);
                }else{
                	delComment(cmt_commentid);
                }
            } else {
            	alert("비밀번호가 맞지 않습니다.");
            }
        }
    });
	
}


function reComment(el, idx, grp, sort) {
    
    var fid = "reFrm"+idx;
    var contents_id = "${param.contents_id}";
    var sid = "${s_user_no }";
    var name = "${name }";
    
    if ($('.'+fid).length>0) return;
    var date = getTimeStamp();

    var html = '<li class="' + fid + '">';
    if(sid != ""){
    	html += '<div class="info_arae"><strong>'+name+'</strong><span>' + date + '</span></div>';
    }
    
    html += '<form id="modFrm_'+idx+'" method="post" onsubmit="return false;">';
    html += '	<input type="hidden" name="mode" value="R" />';
    html += '	<input type="hidden" name="contents_id" value="'+contents_id+'" />';
    html += '	<input type="hidden" id="grp" name="grp" value="'+grp+'" />';
    html += '	<input type="hidden" id="sort" name="sort" value="'+sort+'" />';
    html += '	<input type="hidden" id="depth" name="depth" value="1" />';
    
    html += '<div class="txtinput_area">';
    
    html += '    <div class="re_input_area">';
    
    if(sid == ""){
	    html += '	<input type="text" class="" name="name" id="input_name"  maxlength="10" data-parsley-required="true" placeholder="이름 *" />';
	    html += '	<label for="input_name" class="hidden">이름 등록</label>';
	    html += '	<input type="password" class="" style="height: 23px;" id="input_pass" name="pass" value="" maxlength="10" data-parsley-required="true" placeholder="비밀번호 *" />';
	    html += '	<label for="input_pass" class="hidden">비밀번호 등록</label>';
    } else {
    	html += '	<input type="hidden" id="name" name="name" value="'+name+'" />';
    }
    
    html += '        <div class="input_box">';
    html += '            <textarea cols="1" rows="1" class="txtinput" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this, 2)"></textarea>';
    html += '        </div>';
    html += '        <div class="re_count_number">';
    html += '            <span>0Byte</span> /300Byte';
    html += '        </div>';
    html += '    </div>';
    html += '    <div class="re_button_area">';
    html += '        <button class="btn s_save_btn" title="저장" onclick="saveComment(document.getElementById(\'modFrm_' + idx + '\')); return false;">';
    html += '            <span>저장</span>';
    html += '        </button>';
    html += '        <button type="button" class="btn s_cancel_btn" title="취소" onclick="removeFrm(this); return false;">';
    html += '            <span>취소</span>';
    html += '        </button>';
    html += '    </div>';
    html += '</div>';
    html += '</form></li>';

    if ($('#child_'+idx).length) {
        $('#child_'+idx).append(html);
    } else {
        var div = '<li class="' + fid + '"><div class="recommentbox">';
		div += '<ul class="comment_list">' + html + '<ul></div></li>';
		
		$(el).parent().parent().parent().next().after(div);
    }
}

function modComment(el, idx) {
    
    if ($("#modFrm_"+idx).length>0) return;
    
    var cont = $(el).parent().parent().parent().siblings(".contents");
    var contents_id = "${param.contents_id}";
    
    var txt = $(cont).text();
    txt = $.trim(txt);
    
    var html = "";
    html += '<form id="modFrm_'+idx+'" method="post" onsubmit="return false;">';
    html += '<input type="hidden" name="mode" value="E" />';
    html += '<input type="hidden" name="contents_id" value="'+contents_id+'" />';
    html += '<input type="hidden" id="comment_id" name="comment_id" value="'+idx+'" />';
    html += '<div class="txtinput_area">';
    html += '  <div class="re_input_area">';
    html += '      <div class="input_box">';
    html += '        <textarea class="txtinput" name="contents" title="댓글 입력" onkeyup="pubByteCheckTextarea(this)">' + txt + ' </textarea>';
    html += '      </div>';
    html += '      <div class="re_count_number">';
    html += '          <span>0Byte</span> /300Byte';
    html += '      </div>';
    html += '    </div>';
    html += '    <div class="re_button_area">';
    html += '      <button class="btn s_save_btn" title="저장" onclick="saveComment(document.getElementById(\'modFrm_' + idx + '\')); return false;">';
    html += '        <span>등록하기</span>';
    html += '      </button>';
    html += '      <button class="btn s_cancel_btn" title="취소" onclick="removeFrm(this); return false;">';
    html += '        <span>취소</span>';
    html += '      </button>';
    html += '    </div>';
    html += '  </div>';
    html += '</form>';

    $(cont).hide();
    $(el).parent().parent().parent().after(html);
}

function removeFrm(el) {
    $(el).parent().parent().parent().siblings('.contents').show();
    $(el).parent().parent().parent().remove();
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


//byte check
function pubByteCheckTextarea(obj, type) {
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
    	if(type == 1){
        	$(obj).next().children().children().eq(0).html( byte($(obj).val()) );
    	}else{
    		$(obj).parent().next().children().html( byte($(obj).val()) );
    	}
    }
}

</script>