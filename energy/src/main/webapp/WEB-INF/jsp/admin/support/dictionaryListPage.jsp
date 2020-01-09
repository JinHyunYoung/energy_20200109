<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
var savedRow = null;
var savedCol = null;
var dictionaryPageListUrl = "<c:url value='/admin/dictionary/dictionaryPageList.do'/>";
var dictionaryWriteUrl =  "<c:url value='/admin/dictionary/dictionaryWrite.do'/>";

$(document).ready(function(){
    
	$('#dictionary_list').jqGrid({
		datatype: 'json',
		url: dictionaryPageListUrl,
		mtype: 'POST',
		colModel: [		
 			{ label: '번호', index: 'rnum', name: 'rnum', width: 40, align : 'center', sortable:false, formatter:jsRownumFormmater},
			{ label: '국문색인', index: 'kr_idx', name: 'kr_idx', align : 'center', width:50, sortable:false},
			{ label: '영문색인', index: 'en_idx', name: 'en_idx', align : 'center', width:50, sortable:false},
			{ label: '국문명', index: 'term_kr_nm', name: 'term_kr_nm', align : 'left', width:80, sortable:false,formatter:jsTitleLinkFormmater},
			{ label: '영문명', index: 'term_en_nm', name: 'term_en_nm', width: 80, align : 'left', sortable:false},
			{ label: '등록자', index: 'reg_usernm', name: 'reg_usernm', width: 40, align : 'center', sortable:false},
			{ label: '등록일', index: 'reg_date', name: 'reg_date', width: 40, align : 'center', sortable:false}			
		],
		postData :{	
			kr_idx : $("#p_kr_idx").val(),
			en_idx : $("#p_en_idx").val(),
			term_kr_nm : $("#p_term_kr_nm").val(),
			term_en_nm : $("#p_term_en_nm").val()
		},		
		page : "${LISTOP.ht.miv_pageNo}",
		rowNum : "${LISTOP.ht.miv_pageSize}",		
		pager : '#dictionary_pager',
		viewrecords : true,
		sortname : "term_kr_nm",
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
		loadComplete : function(data) {
			showJqgridDataNon(data, "dictionary_list", 7);
		}
	});
	 
	
	jQuery("#dictionary_list").jqGrid('navGrid', '#dictionary_list_pager', {
			add : false,
			search : false,
			refresh : false,
			del : false,
			edit : false
		});
	
	bindWindowJqGridResize("dictionary_list", "dictionary_list_div");

});

//번호 정렬
function jsRownumFormmater(cellvalue, options, rowObject) {
	var str = $("#total_cnt").val() - (rowObject.rnum-1);
	return str;
}


function jsTitleLinkFormmater(cellvalue, options, rowObject) {
	var str = "<a href=\"javascript:dictionaryWrite('"+rowObject.term_sn+"')\">"+rowObject.term_kr_nm+"</a>";
	return str;
}

function search() {
		
	jQuery("#dictionary_list").jqGrid('setGridParam', {
		datatype : 'json',
		url : dictionaryPageListUrl,
		page : 1,
		postData : {
			kr_idx : $("#p_kr_idx").val(),
			en_idx : $("#p_en_idx").val(),
			term_kr_nm : $("#p_term_kr_nm").val(),
			term_en_nm : $("#p_term_en_nm").val()
		},
		mtype : "POST"
	}

	).trigger("reloadGrid");
	
}

function dictionaryWrite(term_sn) {
	
    var f = document.listFrm;
    var mode = "W";
    
    if(term_sn != ""){
    	mode = "E";
    }
    	
	$("#mode").val(mode);
	
	$("#term_sn").val(term_sn);
	
    f.action = dictionaryWriteUrl;
    f.submit();
}

function formReset(){
	$("select[name=p_kr_idx] option[value='']").attr("selected",true);
	$("select[name=p_en_idx] option[value='']").attr("selected",true);	
	$("#p_term_kr_nm").val("");
	$("#p_term_en_nm").val("");
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
	
	<form id="listFrm" name="listFrm" method="post">
	
		<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
		<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" />
		<input type='hidden' id="total_cnt" name='total_cnt' value="" />
		<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
		<input type='hidden' id="term_sn" name='term_sn' value="" />
		<input type='hidden' id="mode" name='mode' value="W" />
	
		<!-- search_area -->
		<div class="search_area">
			 <table class="search_box">
				<caption>팝업검색</caption>
				<colgroup>
					<col style="width: 80px;" />
					<col style="width: 20%;" />
				    <col style="width: 80px;" />
					<col style="width: 40%;" />
					<col style="width: 20%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
				<tr>
					<th>검색구분</th>
					<td colspan="5">
						<select id="p_kr_idx" name="p_kr_idx">
							<option value="">- 국문전체 -</option>
							<option value="ㄱ" <c:if test="${param.p_kr_idx eq 'ㄱ' }" >selected="selected"</c:if> >ㄱ</option>
							<option value="ㄴ" <c:if test="${param.p_kr_idx eq 'ㄴ' }" >selected="selected"</c:if> >ㄴ</option>
							<option value="ㄷ" <c:if test="${param.p_kr_idx eq 'ㄷ' }" >selected="selected"</c:if> >ㄷ</option>
							<option value="ㄹ" <c:if test="${param.p_kr_idx eq 'ㄹ' }" >selected="selected"</c:if> >ㄹ</option>
							<option value="ㅁ" <c:if test="${param.p_kr_idx eq 'ㅁ' }" >selected="selected"</c:if> >ㅁ</option>
							<option value="ㅂ" <c:if test="${param.p_kr_idx eq 'ㅂ' }" >selected="selected"</c:if> >ㅂ</option>
							<option value="ㅅ" <c:if test="${param.p_kr_idx eq 'ㅅ' }" >selected="selected"</c:if> >ㅅ</option>
							<option value="ㅇ" <c:if test="${param.p_kr_idx eq 'ㅇ' }" >selected="selected"</c:if> >ㅇ</option>
							<option value="ㅈ" <c:if test="${param.p_kr_idx eq 'ㅈ' }" >selected="selected"</c:if> >ㅈ</option>
							<option value="ㅊ" <c:if test="${param.p_kr_idx eq 'ㅊ' }" >selected="selected"</c:if> >ㅊ</option>
							<option value="ㅋ" <c:if test="${param.p_kr_idx eq 'ㅋ' }" >selected="selected"</c:if> >ㅋ</option>
							<option value="ㅌ" <c:if test="${param.p_kr_idx eq 'ㅌ' }" >selected="selected"</c:if> >ㅌ</option>
							<option value="ㅍ" <c:if test="${param.p_kr_idx eq 'ㅍ' }" >selected="selected"</c:if> >ㅍ</option>
							<option value="ㅎ" <c:if test="${param.p_kr_idx eq 'ㅎ' }" >selected="selected"</c:if> >ㅎ</option>
						</select>						
						<select id="p_en_idx" name="p_en_idx">
							<option value="">- 영문전체 -</option>
							<option value="A" <c:if test="${param.p_en_idx eq 'A' }" >selected="selected"</c:if> >A</option>
							<option value="B" <c:if test="${param.p_en_idx eq 'B' }" >selected="selected"</c:if> >B</option>
							<option value="C" <c:if test="${param.p_en_idx eq 'C' }" >selected="selected"</c:if> >C</option>
							<option value="D" <c:if test="${param.p_en_idx eq 'D' }" >selected="selected"</c:if> >D</option>
							<option value="E" <c:if test="${param.p_en_idx eq 'E' }" >selected="selected"</c:if> >E</option>
							<option value="F" <c:if test="${param.p_en_idx eq 'F' }" >selected="selected"</c:if> >F</option>
							<option value="G" <c:if test="${param.p_en_idx eq 'G' }" >selected="selected"</c:if> >G</option>
							<option value="H" <c:if test="${param.p_en_idx eq 'H' }" >selected="selected"</c:if> >H</option>
							<option value="I" <c:if test="${param.p_en_idx eq 'I' }" >selected="selected"</c:if> >I</option>
							<option value="J" <c:if test="${param.p_en_idx eq 'J' }" >selected="selected"</c:if> >J</option>
							<option value="K" <c:if test="${param.p_en_idx eq 'K' }" >selected="selected"</c:if> >K</option>
							<option value="L" <c:if test="${param.p_en_idx eq 'L' }" >selected="selected"</c:if> >L</option>
							<option value="M" <c:if test="${param.p_en_idx eq 'M' }" >selected="selected"</c:if> >M</option>
							<option value="N" <c:if test="${param.p_en_idx eq 'N' }" >selected="selected"</c:if> >N</option>
							<option value="O" <c:if test="${param.p_en_idx eq 'O' }" >selected="selected"</c:if> >O</option>
							<option value="P" <c:if test="${param.p_en_idx eq 'P' }" >selected="selected"</c:if> >P</option>
							<option value="Q" <c:if test="${param.p_en_idx eq 'Q' }" >selected="selected"</c:if> >Q</option>
							<option value="R" <c:if test="${param.p_en_idx eq 'R' }" >selected="selected"</c:if> >R</option>
							<option value="S" <c:if test="${param.p_en_idx eq 'S' }" >selected="selected"</c:if> >S</option>
							<option value="T" <c:if test="${param.p_en_idx eq 'T' }" >selected="selected"</c:if> >T</option>
							<option value="U" <c:if test="${param.p_en_idx eq 'U' }" >selected="selected"</c:if> >U</option>
							<option value="V" <c:if test="${param.p_en_idx eq 'V' }" >selected="selected"</c:if> >V</option>
							<option value="W" <c:if test="${param.p_en_idx eq 'W' }" >selected="selected"</c:if> >W</option>
							<option value="X" <c:if test="${param.p_en_idx eq 'X' }" >selected="selected"</c:if> >X</option>
							<option value="Y" <c:if test="${param.p_en_idx eq 'Y' }" >selected="selected"</c:if> >Y</option>
							<option value="Z" <c:if test="${param.p_en_idx eq 'Z' }" >selected="selected"</c:if> >Z</option>
							<option value="etc" <c:if test="${param.p_en_idx eq 'etc' }" >selected="selected"</c:if> >etc</option>
						</select>
						
					</td>					
				</tr>			
				<tr>
					<th>한글명</th>
					<td>
						<input type="input" id="p_term_kr_nm" name="p_term_kr_nm" value="<c:out value="${param.p_term_kr_nm}" escapeXml="true" />"  placeholder="한글명" class="in_w70"> 
					</td>
					<th>영문명</th>
					<td>
		            	<input type="input" id="p_term_en_nm" name="p_term_en_nm" value="<c:out value="${param.p_term_en_nm}" escapeXml="true" />"  placeholder="영문명" class="in_w70">                      
					</td>
				</tr>				
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
	
		<!-- table 1dan list -->
		<div class="table_area" id="dictionary_list_div" >
		    <table id="dictionary_list"></table>
	        <div id="dictionary_pager"></div>
		</div>
		<!--// table 1dan list -->
	
		<!-- tabel_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<a href="javascript:dictionaryWrite('')" class="btn save" title="관리자등록">
					<span>등록</span>
				</a>
			</div>
		</div>
		<!--// tabel_search_area -->
		
</div>
<!--// content -->