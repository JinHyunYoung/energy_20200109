<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var reply_status = "N";
var link = "N";
var secret_yn = "N";
var comment_yn = "N";
var selectBoardContentsPageListUrl = "<c:url value='/admin/board/selectBoardContentsPageList.do'/>";

$(document).ready(function(){
	
	//alert($("#SubMenu > li").removeClass("on"));
	//alert($("#SubMenu > li").eq(1).addClass("on"));
	
	<c:if test="${fn:indexOf(boardinfo.view_print, 'secret') != -1}">secret_yn = "Y";</c:if>
	<c:if test="${fn:indexOf(boardinfo.view_print, 'reply_status') != -1}">reply_status = "Y";</c:if>
	<c:if test="${fn:indexOf(boardinfo.view_print, 'link') != -1}">link = "Y";</c:if>
	<c:if test="${fn:indexOf(boardinfo.view_print, 'comment') != -1}">comment_yn = "Y";</c:if>
	
	$('#contents_list').jqGrid({
		datatype: 'json',
		url: selectBoardContentsPageListUrl,
		mtype: 'POST',
		colModel: [
		<c:forEach items="${viewSortList }" var="list">
			<c:if test="${list.v_print ne 'secret' &&  list.v_print ne 'reply_status' && list.v_print ne 'link' && view.v_print ne 'comment'}">
			<c:if test="${list.v_print eq 'number' }">{ label: '번호', index: 'rnum', name: 'rnum', width: '${list.v_size}', align : 'center', sortable:false, formatter:jsRownumFormmater},</c:if>
			<c:if test="${list.v_print eq 'domestic_yn' }">{ label: '국내외구분', index: 'domestic_yn', name: 'domestic_yn', width: '${list.v_size}', align : 'center', formatter:jsDomesticFormmater},</c:if>
			<c:if test="${list.v_print eq 'cate' }">{ label: '카테고리', index: 'cate_nm', name: 'cate_nm', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'title' }">{ label: '제목', index: 'title', name: 'title', width: '${list.v_size}', align : 'left', sortable:false, formatter:jsTitleFormmater},</c:if>
			<c:if test="${list.v_print eq 'url' }">{ label: 'URL', index: 'url', name: 'url', width: '${list.v_size}', align : 'left', sortable:false, formatter:jsUrlFormmater},</c:if>
			<c:if test="${list.v_print eq 'origin' }">{ label: '출처', index: 'origin', name: 'origin', width: '${list.v_size}', sortable:false, align : 'center'},</c:if>			
			<c:if test="${list.v_print eq 'country' }">{ label: '국가', index: 'country', name: 'country', width: '${list.v_size}', sortable:false, align : 'center'},</c:if>	
			<c:if test="${list.v_print eq 'etc' }">{ 
				<c:if test="${boardinfo.etc_label_nm eq '1' }">label: '기타'</c:if>
				<c:if test="${boardinfo.etc_label_nm eq '2' }">label: '출원번호'</c:if>
				<c:if test="${boardinfo.etc_label_nm eq '3' }">label: '발행처'</c:if>
				<c:if test="${boardinfo.etc_label_nm eq '4' }">label: '운영기관'</c:if>
			    , index: 'etc', name: 'etc', width: '${list.v_size}', sortable:false, align : 'center'},</c:if>			
			<c:if test="${list.v_print eq 'contents_date' }">{ 
				<c:if test="${boardinfo.contents_date_label_nm eq '1' }">label: '날짜'</c:if>
				<c:if test="${boardinfo.contents_date_label_nm eq '2' }">label: '출원일'</c:if>
				<c:if test="${boardinfo.contents_date_label_nm eq '3' }">label: '발간일'</c:if>			    
			    , index: 'contents_date', name: 'contents_date', width: '${list.v_size}', sortable:false, align : 'center'},</c:if>
			<c:if test="${list.v_print eq 'contents' }">{ label: '내용', index: 'contents', name: 'contents', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'thumb' }">{ label: '썸네일', index: 'thumb', name: 'thumb', width: '${list.v_size}', align : 'center', sortable:false, formatter:jsThumbFormmater},</c:if>
			<c:if test="${list.v_print eq 'attach' }">{ label: '첨부파일', index: 'attach', name: 'attach', width: '${list.v_size}', align : 'center', sortable:false, formatter:jsAttachFormmater},</c:if>
			<c:if test="${list.v_print eq 'name' }">{ label: '작성자', index: 'name', name: 'name', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			// <c:if test="${list.v_print eq 'phone' }">{ label: '휴대전화', index: 'handphone', name: 'handphone', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'email' }">{ label: '이메일', index: 'email', name: 'email', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'reg_date' }">{ label: '작성일', index: 'reservation_date', name: 'reservation_date', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'ip_addr' }">{ label: 'IP', index: 'ip_addr', name: 'ip_addr', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'recommend' }">{ label: '추천', index: 'recommend', name: 'recommend', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'satisfy' }">{ label: '만족도', index: 'satisfy', name: 'satisfy', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
			<c:if test="${list.v_print eq 'hits' }">{ label: '조회수', index: 'hits', name: 'hits', width: '${list.v_size}', align : 'center', sortable:false},</c:if>
		</c:if>
		</c:forEach>
		],
		postData :{	
			board_id : $("#board_id").val(),
			cate_id : $("#cate_id").val(),
        	reply_ststus : $("#reply_ststus").val(),
        	searchkey : $("#searchkey").val(),
        	searchtxt : $("#searchtxt").val()
		},
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",
		pager : '#contents_pager',
		viewrecords : true,
		sortname : "reservation_date DESC, ref_seq DESC, restep_seq",
		sortorder : "asc",
		height : "350px",
		gridview : true,
		autowidth : true,
		beforeProcessing: function (data) {
			$("#LISTOP").val(data.LISTOPVALUE);
			$("#miv_pageNo").val(data.page);
			$("#miv_pageSize").val(data.size);
			$("#total_cnt").val(data.records);
        },
        
      	//표의 완전한 로드 이후 실행되는 콜백 메소드이다.
		loadComplete : function(data) {
			showJqgridDataNon(data, "contents_list", 5);
		}
        
	});
	//jq grid 끝
	
	bindWindowJqGridResize("contents_list", "contents_list_div");	
	
});


function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.noti == "Y"){
		str = "공지";
	}else{
		str = $("#total_cnt").val() - (rowObject.rnum-1);
	}
	return str;
}

function jsDomesticFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.domestic_yn == "Y"){
		str = "국내";
	}else{
		str = "해외";
	}
	return str;
}


function replaceAll(inputString, targetString, replacement){
	  var v_ret = null;
	  var v_regExp = new RegExp(targetString, "g");
	  v_ret = inputString.replace(v_regExp, replacement);
	  return v_ret;
}

// 제목
function jsTitleFormmater(cellvalue, options, rowObject) {
	var str = "";
	var title = rowObject.title;
	title = replaceAll(title,"RE : ", "");
	
	<%-- 제목링크 확인 --%>
	if(rowObject.title_link == null){
	    
		<%-- 디테일 사용여부 확인 --%>
		if("${boardinfo.detail_yn}" == "Y"){
		    
		    <%-- 비밀글 추가 --%>
			if(secret_yn == "Y" && rowObject.secret == "Y" ){
				str += " <img src=\"/images/admin/icon/icon_lock.png\" alt=\"비밀글\" /> ";
			}
			
			<%-- 답글여부 --%>
			if(rowObject.relevel_seq > 0){
				for(var i=0; i<rowObject.relevel_seq; i++){
					str += "<img src=\"/images/admin/icon/icon_reply.png\" alt=\"답글\" /> ";
				}
			}
			
			str += "<a href=\"javascript:contentsView('"+rowObject.contents_id+"')\">"+title+"</a>";

			<%-- 답변대기 --%>
			if(reply_status == "Y" && rowObject.reply_yn != "Y"){
				str += " <img src=\"/images/admin/icon/icon_txt_01_01.png\" alt=\"답변대기\" /> ";
			}
			
			<%-- 답변완료 --%>
			if(reply_status == "Y" && rowObject.reply_yn == "Y" ){
				str += " <img src=\"/images/admin/icon/icon_txt_01_02.png\" alt=\"답변완료\" /> ";
			}
			
			<%-- 댓글여부 --%>
			if(comment_yn == "Y" && rowObject.comment_cnt > 0){
				str += "[<strong class=\"color_pointr\">"+rowObject.comment_cnt+"</strong>]";
			}
			
		} else {
			str = title;
		}
		
	} else {
		str = "<a href=\""+rowObject.title_link+"\"  target=\"_blank\">"+title+"</a>";
	}
	
	return str;
}

// URL
function jsUrlFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.url_title != undefined) {
		str += rowObject.url_title;
	}
	if(rowObject.url_link != undefined) {
		str += "<br/><a href=\""+rowObject.url_link+"\">"+rowObject.url_link+"</a>";
	}
	return str;
}

// 썸네일
function jsThumbFormmater(cellvalue, options, rowObject) {
	var str = "";
	var img = "/contents/board/"+rowObject.image_file_nm;
	if(rowObject.image_file_nm != undefined) {
		str = "<img src=\""+img+"\" alt=\"썸네일\" width=\"82\" height=\"100\" />";
	}else{
		str = '<img src="/images/admin/common/no_img.png" alt="썸네일" />';
	}
	return str;
}

// 첨부파일
function jsAttachFormmater(cellvalue, options, rowObject) {
	var str = "";
	if(rowObject.group_id != undefined) {
		str = '<img src="/images/admin/icon/icon_file.png" alt="첨부파일" />';
	}
	return str;
}

</script>

<table id="contents_list"></table>
<div id="contents_pager"></div>