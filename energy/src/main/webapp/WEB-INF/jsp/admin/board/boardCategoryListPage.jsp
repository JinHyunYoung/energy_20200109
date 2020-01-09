<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$(document).ready(function(){

	$('#category_list').jqGrid({
		datatype: 'json',
		url: selectBoardCategoryListUrl,
		mtype: 'post',
		colModel: [
			{ label: 'board_id', index: 'board_id', name: 'board_id', hidden:true },
			{ label: 'cate_id', index: 'cate_id', name: 'cate_id', hidden:true },
			{ label: '코드', index: 'sort', name: 'sort', width: 130, align : 'center', sortable:false},
			{ label: '카테고리명', index: 'title', name: 'title', align : 'left', sortable:false, width:300, formatter:jsTitleLinkFormmater},
			{ label: '사용여부', index: 'use_yn_nm', name: 'use_yn_nm', align : 'center', sortable:false, width:130}
		],
		postData :{	
			board_id : $("#board_id").val()
		},
		viewrecords : true,
		gridview : true,
		autowidth : true,
		loadComplete : function(data) {
			showJqgridDataNon(data, "category_list",3);
		}
	});
	//jq grid 끝
	
	//bindWindowJqGridResize("category_list", "category_list_div");

});

</script>

<form id="listFrm2" name="listFrm2" method="post">

	<input type='hidden' id="board_id" name='board_id' value="${param.board_id}" />
	<input type='hidden' id="cate_id" name='cate_id' value="" />
	<input type='hidden' id="sort" name='sort' value="" />
	<input type='hidden' id="mode" name='mode' value="W" />

	<!-- tabel_search_area -->
	<div class="table_search_area" style="margin-top:10px;padding-left:10px;padding-right:10px">
		<div class="float_right">
			<a href="javascript:categoryFrm('W')" class="btn acti" title="등록">
				<span>등록</span>
			</a>
		</div>
	</div>
	<!--// tabel_search_area -->
	
	<!-- table 1dan list -->
	<div class="table_area" id="category_list_div" style="margin-top:10px;padding-left:10px;padding-right:10px">
	    <table id="category_list"></table>
	       <div id="category_pager"></div>
	</div>
	<!--// table 1dan list -->
	
	
	<div id="categoryWriteDiv" class="table_area" style="margin :10px;padding-left:10px;padding-right:10px;display:none">
	
		<!-- write_basic -->
		<table class="write">
			<tbody>
		 		<tr id="regTd" style="display:none">
					<td class="col-md-3 use-head">등록자</td>
					<td class="col-md-3">
						<div class="input-group" id="reg_usernm" style="width:100%"></div>
					</td>
					<td class="col-md-3 use-head">등록일</td>
					<td class="col-md-3">
						<div class="input-group" id="reg_date" style="width:100%"></div>
					</td>
				</tr>
				<tr>
					<td class="col-md-3 use-head">카테고리명 <span class="asterisk">*</span></td>
					<td class="col-md-9" colspan="3">
						<div class="input-group" style="width:100%">
							<input class="form-control" type="text" id="title1" name="title" value="" placeholder="카테고리명" style="width:100%" data-parsley-required="true" data-parsley-maxlength="100"  />
						</div>
					</td>
				</tr>
				<tr>
					<td class="col-md-3 use-head">사용여부</td>
					<td class="col-md-9" colspan="3">
						<div class="input-group" style="width:100%">
							<input type="radio" name="use_yn" value="Y" checked> 사용 
							<input type="radio" name="use_yn" value="N"> 미사용 
						</div>
					</td>
				</tr>	
		 	</tbody>
		</table>
		<!--// write_basic -->
		
		<!-- footer --> 
		<footer>
			<div class="button_area alignc"  style="padding-top:10px;">
				<a href="javascript:categorySave()" class="btn save" title="저장">
					<span>저장</span>
				</a>
				<a id="deleteA"  href="javascript:categoryDelete()" class="btn cancel" title="삭제">
					<span>삭제</span>
				</a>
				<a href="javascript:popupClose()" class="btn cancel" title="닫기">
					<span>취소</span>
				</a>
			</div>
		</footer>
		<!--// footer --> 
		
	</div>

</form>
