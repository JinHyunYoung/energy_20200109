<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var boardContentsListPageUrl = "<c:url value='/admin/board/boardContentsListPage.do'/>";
var boardContentsWriteUrl = "<c:url value='/admin/board/boardContentsWrite.do'/>";
var boardContentsListUrl = "<c:url value='/admin/board/boardContentsList.do'/>";
var boardContentsViewUrl = "<c:url value='/admin/board/boardContentsView.do'/>";

$(document).ready(function(){
	
	$("#board_list_div").html("");
	
	if($("#board_id").val() != ""){
		if("${param.miv_pageNo}" != null ){
			goContentsPage("${param.miv_pageNo}");
		}else{
			search();
		}
	}
	
});

// 게시판 선택
function changeBoard(){
	var f = document.listFrm;
	   
    f.target = "_self";
    f.action = boardContentsListPageUrl;
    f.submit();	
}

// 게시물 등록
function contentsWrite(){
	var f = document.listFrm;
	   
    f.target = "_self";
    f.action = boardContentsWriteUrl;
    f.submit();
}

//게시물 뷰
function contentsView(contentsid){
	var f = document.listFrm;
	
	$("#contents_id").val(contentsid);
	   
    f.target = "_self";
    f.action = boardContentsViewUrl;
    f.submit();
}

// 게시판 리스트 불러오기
function boardList(board_id){
	$.ajax({
        url: boardContentsListUrl,
        dataType: "html",
        type: "post",
        data: jQuery("#listFrm").serialize(),
        success: function(data) {
        	$("#contentslist").html(data);
        },
        error: function(e) {
            alert("테이블을 가져오는데 실패하였습니다.");
        }
    });
}

function search(){
    boardList($("#board_id").val());
}

// 초기화
function formReset(){
	$("#reply_ststus").val("");
	$("#cate_id").val("");
	$("#searchkey").val("T");
	$("#searchtxt").val("");
}

// 페이지 이동
function goContentsPage(page){
	$("#miv_pageNo").val(page);
	search();
}

</script>

<!--// content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title" id="headTitle">
				<c:if test="${gubun eq 'M'}" >${admin_g_submenu_nm}</c:if>
				<c:if test="${gubun ne 'M'}" >${boardinfo.title}</c:if>
			</h3>
		</div>
		<!--// main_title -->
		
		<jsp:include page="/WEB-INF/jsp/admin/integration/menuDescInclude.jsp"/>
		
	</div>
	<!--// title_and_info_area -->
	
	<form id="listFrm" name="listFrm" method="post" onsubmit="return false;">
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="mode" name='mode' value="W" />
		<input type='hidden' id="contents_id" name='contents_id' value="" />
		<input type='hidden' id="gubun" name='gubun' value="${gubun }" />
	
	<!-- search_area -->
	<div class="search_area">
		<table class="search_box">
			<caption>게시물관리 검색</caption>
			<colgroup>
				<col style="width: 80px;" />
				<col style="width: *;" />
				<col style="width: 80px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>
			
			<c:if test="${gubun eq 'M' }" >
				<tr>
					<th>게시판</th>
					<td>${list }
	                    <select class="in_wp200" id="board_id" name="board_id" onChange="changeBoard()">
							<option value="">- 선택 -</option>
							<c:forEach items="${boardList }" var="list">
								<option value="${list.board_id }"<c:if test="${list.board_id == param.board_id}">selected</c:if> >
									${list.board_id}/${list.title }/
									<c:choose>
										<c:when test="${list.type eq 'N'}">일반형</c:when>
										<c:when test="${list.type eq 'A'}">앨범형</c:when>
										<c:when test="${list.type eq 'W'}">요약형</c:when>
										<c:when test="${list.type eq 'Q'}">QnA형</c:when>
										<c:when test="${list.type eq 'R'}">보고서형</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>			
			
			<c:if test="${gubun ne 'M' }" >
				<input type='hidden' id="board_id" name='board_id' value="${param.board_id }" />
			</c:if>
			
			<c:if test="${!empty boardinfo}">
										
				<c:if test="${fn:indexOf(boardinfo.item_use, 'domestic_yn') != -1}"> 
					<tr>	
						<th>국내외구분</th>
						<td>
							<select class="in_wp200" id="domestic_yn" name="domestic_yn">
								<option value="">- 전체 -</option>
								<option value="Y" <c:if test="${param.domestic_yn eq 'Y' }" >selected</c:if> >국내</option>
								<option value="N" <c:if test="${param.domestic_yn eq 'N' }" >selected</c:if> >해외</option>
							</select>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${fn:indexOf(boardinfo.item_use, 'cate') != -1}"> 
					<tr>	
						<th>카테고리</th>
						<td>
							<select class="in_wp200" id="cate_id" name="cate_id">
								<option value="">- 전체 -</option>
								<c:forEach items="${category }" var="list">
								<option value="${list.cate_id}" <c:if test="${list.cate_id eq param.cate_id}" >selected</c:if>>${list.title}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${boardinfo.board_type eq 'Q'}">
					<tr>	
						<th>답변상태</th>
						<td>
							<select class="in_wp80" id="reply_ststus" name="reply_ststus" >
								<option value="">- 전체 -</option>
								<option value="S" <c:if test="${param.reply_ststus eq 'S' }" >selected</c:if> >답변완료</option>
								<option value="W" <c:if test="${param.reply_ststus eq 'W' }" >selected</c:if> >답변대기</option>
							</select>
						</td>
					</tr>	
				</c:if>
				
				<tr>		
					<th>검색어</th>
					<td>
						<select class="in_wp80" title="검색 값 구분 선택" id="searchkey" name="searchkey" >
							<option value="T" <c:if test="${param.searchkey eq 'T' }" >selected</c:if>>제목</option>
							<option value="C" <c:if test="${param.searchkey eq 'C' }" >selected</c:if>>내용</option>
							<option value="U" <c:if test="${param.searchkey eq 'U' }" >selected</c:if>>작성자</option>
						</select>
						<label for="input_text" class="hidden">검색어 입력</label>
						<input type="input" class="in_w50" id="searchtxt" name="searchtxt" value="${param.searchtxt}"  placeholder="검색어 입력">
					</td>
				</tr>
				
			</c:if>
			
		</tbody>
		
		</table>
		<div class="search_area_btnarea">
			<a href="javascript:search();" class="btn sch" title="조회">
				<span>조회</span>
			</a>
			<a href="javascript:formReset();" class="btn clear" title="초기화">
				<span>초기화</span>
			</a>
		</div>
	</div>
	<!--// search_area -->
	
	<c:if test="${!empty boardinfo}">
	
		<%-- 게시판 유형별 리스트  --%>
		<div class="table_area" id="contents_list_div">
			<div id="contentslist"></div>
		</div>		
		<%--// 게시판 유형별 리스트 --%>
		
		<!-- button_area -->
		<div class="button_area">
			<div class="float_right">
				<button onclick="contentsWrite()" class="btn save" title="등록하기">
					<span>등록</span>
				</button>
			</div>
		</div>
		<!--// button_area -->
		
	</c:if>
	
	</form>
</div>