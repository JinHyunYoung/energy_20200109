<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<link href="/assets/jquery-ui/themes/base/jquery.ui.datepicker.css" rel="stylesheet" />
<script type="text/javascript" src="/assets/jquery/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/js/announce.js"></script>

<script language="javascript">
var selectEduseqUrl = '<c:url value="/admin/education/eduseqListPage.do" />';
var insertEduseqUrl = '<c:url value="/admin/education/insertEduseq.do" />';
var updateEduseqUrl = "<c:url value='/admin/education/updateEduseq.do'/>"
var deleteEduseqUrl = "<c:url value='/admin/education/deleteEduseq.do'/>";
var eduseqCompleteUrl = "<c:url value='/admin/education/eduseqComplete.do'/>";

$( document ).ready( function(){
	
	$(".onlynum").keyup( setNumberOnly );
	
	$('.datepicker').each(function(){
	    $(this).datepicker({
			  format: "yyyy-mm-dd",
			  language: "kr",
			  keyboardNavigation: false,
			  forceParse: false,
			  autoclose: true,
			  todayHighlight: true,
			  showOn: "button",
			  buttonImage:"/images/icon/icon_calendar.png",
			  buttonImageOnly:true,
			  changeMonth: true,
	          changeYear: true,
	          showButtonPanel:false
			 });
	});
});

function eduseqInsert(){

   if($("#seq").val() == ""){
	   alert("회차는 필수 입력사항입니다.");
	   $("#seq").focus();
	   return;
   }
 
   $("#apply_strdt").val($("#apply_strdt_date").val()+$("#apply_strdt_hh").val()+$("#apply_strdt_mm").val()+"00");
   $("#apply_enddt").val($("#apply_enddt_date").val()+$("#apply_enddt_hh").val()+$("#apply_enddt_mm").val()+"00");
   
	$('input[name=subj_score]').each(function(){
	    if(this.value == "") this.value = "0";
	});
	
   if ( $("#writeFrm").parsley().validate() ){	   
	   var url = insertEduseqUrl;	
	   if($("#seq_id").val() != "") url = updateEduseqUrl;
		   
	   // 데이터를 등록 처리해준다.
		$("#writeFrm").ajaxSubmit({
			success: function(responseText, statusText){
				alert(responseText.message);
				if(responseText.success == "true"){
					eduseqList();
				}	
			},
			dataType: "json",
			url: url
	    });	
   }	

}

function addSubj(){
	 var str = "";
	 var dupCheck = true;
	 var subjCd = $("#subj_list").val();
	 var subjText = $("#subj_list option:checked").text();
	$('input[name=subj_cd]').each(function(){
	    if(this.value == subjCd){
	    	alert("이미 등록된 과목입니다.");
	    	dupCheck = false;
	    	return;
	    }
	});
	
	if(!dupCheck) return;
	
	str += '<tr id="subj_'+subjCd+'">';
	str += '<td class="first">'+subjText+'</td>';
	str += '<td class="alignc">';
	str += '<input type="hidden" name="subj_cd" value="'+subjCd+'"/>';
	str += '<input type="text" class="in_wp80 onlynum" name="subj_score" value="0"/>점 이상';
	str += '</td>';
	str += '<td class="alignc last">';
	str += '<button type="button" class="btn nomal" onClick="delSubj(\''+subjCd+'\')">삭제</button>';
	str += '</td>';
	str += '</tr>';
	
	$("#subj_table").append(str);
	$(".onlynum").keyup( setNumberOnly );
}

function delSubj(subjCd){
	$("#subj_"+subjCd).remove();
}

function eduseqComplete(){
	if(!confirm("교육완료 처리를 하시게 되면 신청정보를 더 이상 수정하시지 못합니다. 처리를 진행하시겠습니까?")) return;
	
	$.ajax
	({
		type: "POST",
         	url: eduseqCompleteUrl,
         	data:{
         		seq_id : $("#seq_id").val()
         	},
			success:function(data, dataType){					
				alert(data.message);					
			}
	});
}

function eduseqDelete(){
	
	  if($("#apply_cnt").val() > 0) {
		  alert("수강신청자가 존재하여 삭제할 수 없습니다.");
		  return;
	  }
	
	  if(!confirm("삭제하시겠습니까?")) return;
 	 
	    $.ajax({
	        url: deleteEduseqUrl,
	        dataType: "json",
	        type: "post",
	        data: {
	        	seq_id : $("#seq_id").val()
			},
	        success: function(data) {
	        	alert(data.message);
	        	if(data.success == "true") eduseqList();
	        },
	        error: function(e) {
	            alert("테이블을 가져오는데 실패하였습니다.");
	        }
	    });	
}

function eduseqList(){
	document.writeFrm.action = selectEduseqUrl;
	document.writeFrm.submit();
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
       <form id="writeFrm" name="writeFrm" method="post" class="form-horizontal text-left" data-parsley-validate="true">
			<input type='hidden' id="miv_pageNo" name='miv_pageNo' value="${LISTOP.ht.miv_pageNo}" /> 
			<input type='hidden' id="miv_pageSize" name='miv_pageSize' value="${LISTOP.ht.miv_pageSize}" /> 
			<input type='hidden' id="LISTOP" name='LISTOP' value="${LISTOP.value}" />
			<input type='hidden' id="mode" name='mode' value="${param.mode}" />
		    <input type='hidden' id="seq_id" name='seq_id' value="${param.seq_id}" />
		    <input type='hidden' id="p_year" name='p_year' value="${param.p_year}" />
		    <input type='hidden' id='apply_strdt' name='apply_strdt' value="${eduseq.apply_strdt}" />
		    <input type='hidden' id='apply_enddt' name='apply_enddt' value="${eduseq.apply_enddt}" />
		    <input type='hidden' id='apply_cnt' name='apply_cnt' value="${eduseq.apply_cnt}" />
         
       <div class="table_area">
		<table class="write">
			<caption>운영정보 등록</caption>
			<colgroup>
				<col style="width:180px;">
				<col style="width:*;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">
					    <strong class="color_pointr">*</strong>
						<label for="seq">회차</label>
					</th>
					<td>
						<input type="text" id="seq" name="seq" class="in_wp100 onlynum" value="${eduseq.seq}" data-parsley-required="true" data-parsley-maxlength="9" />
					</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong>
						<label for="run_year">운영년도</label>
					</th>
					<td>
						<select id="run_year" name="run_year" class="in_wp100">
	                     <c:forEach begin="0" end="10" var="idx" step="1">
	                     	 <option value="${curYear-idx}" <c:if test="${(curYear-idx) == eduseq.seq}">selected</c:if>>${curYear-idx}</option>
	                     </c:forEach>
	                    </select>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<strong class="color_pointr">*</strong>신청기간
					</th>
					<td>
						<label for="apply_strdt_date" class="hidden">신청기간 시작일 달력 선택</label>
						<input id="apply_strdt_date" name="apply_strdt_date" type="text" class="in_wp80 datepicker" data-parsley-required="true" value="${eduseq.apply_strdt_date}" readonly />
						<label for="apply_strdt_hh" class="hidden">신청기간 시작 시간 선택</label>
						<select class="in_wp40" id="apply_strdt_hh" name="apply_strdt_hh">
						 <c:forEach var="i" begin="0" end="23">
						      <c:set var="hour" value="${i}"/>
						      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
						<option value="${hour}" <c:if test="${hour == eduseq.apply_strdt_hh}">selected</c:if>>${hour}</option>
						</c:forEach>
						</select>
						<label for="apply_strdt_mm" class="hidden">신청기간 시작 분 선택</label>
						<select class="in_wp40" id="apply_strdt_mm" name="apply_strdt_mm">
						 <c:forEach var="i" begin="0" end="59">
						      <c:set var="min" value="${i}"/>
						      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
						<option value="${min}" <c:if test="${min == eduseq.apply_strdt_mm}">selected</c:if>>${min}</option>
						</c:forEach>
						</select>
						&nbsp;~&nbsp;
						<label for="apply_enddt_date" class="hidden">신청기간 종료일 달력 선택</label>
						<input id="apply_enddt_date" name="apply_enddt_date" type="text" class="in_wp80 datepicker" data-parsley-required="true" value="${eduseq.apply_enddt_date}" readonly />
						<label for="apply_enddt_hh" class="hidden">신청기간 종료 시간 선택</label>
						<select class="in_wp40" id="apply_enddt_hh" name="apply_enddt_hh">
						 <c:forEach var="i" begin="0" end="23">
						      <c:set var="hour" value="${i}"/>
						      <c:if test="${i < 10}"><c:set var="hour" value="0${i}"/></c:if>
						<option value="${hour}" <c:if test="${hour == eduseq.apply_enddt_hh}">selected</c:if>>${hour}</option>
						</c:forEach>
						</select>
						<label for="apply_enddt_mm" class="hidden">신청기간 종료 분 선택</label>
						<select class="in_wp40" id="apply_enddt_mm" name="apply_enddt_mm">
						 <c:forEach var="i" begin="0" end="59">
						      <c:set var="min" value="${i}"/>
						      <c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
						<option value="${min}" <c:if test="${min == eduseq.apply_enddt_mm}">selected</c:if>>${min}</option>
						</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">과목명</th>
					<td>
						<label for="table_label04_01" class="hidden">과목추가</label>
                        <g:select id="subj_list" name="subj_list" codeGroup="EDUCATION_SUBJ" cls="in_wp300" style="margin-bottom:11px;" />
						<button type="button" class="btn acti marginb10" title="과목추가" onClick="addSubj()">
							<span>과목추가</span>
						</button>

						<!--table_area-->
						<div class="table_area">
							<table id="subj_table" class="list">
								<caption>추가된 과목들</caption>
								<colgroup>
									<col style="width:*;">
									<col style="width:20%;">
									<col style="width:20%;">
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="alignc first">과목명</th>
										<th scope="col" class="alignc">합격기준</th>
										<th scope="col" class="alignc last">삭제</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="row" items="${subjList}">
									<tr id="subj_${row.subj_cd}">
										<td class="first">${row.subj_nm}</td>
										<td class="alignc">
										<input type="hidden" name="subj_cd" value="${row.subj_cd}"/>
										<input type="text" class="in_wp80 onlynum" name="subj_score" value="${row.score}"/>점 이상
										</td>
										<td class="alignc last">
											<button type="button" class="btn nomal" onClick="delSubj('${row.subj_cd}')">삭제</button>
										</td>
									</tr>
								</c:forEach>								
								</tbody>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">
						<label for="seq">이론실기 평균점수</label>
					</th>
					<td>
						<input type="text" id="score" name="score" class="in_wp100 onlynum" value="${eduseq.score}" data-parsley-maxlength="9" />점 이상
					</td>
				</tr>
				<tr>
					<th scope="row">공개여부</th>
					<td>
						<input id="open_yn1" type="radio" name="open_yn" value="Y" <c:if test="${eduseq.open_yn == 'Y'}">checked</c:if> />
						<label for="open_yn1" class="marginl5">공개</label>
						<input id="open_yn2" type="radio" name="open_yn" value="N" <c:if test="${eduseq.open_yn == 'N'}">checked</c:if> />
						<label for="open_yn2">비공개</label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

		<!-- button_area -->
		<div class="button_area">
			<div class="float_left" style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
				<button type="button" class="btn basic" title="교육완료" onClick="eduseqComplete()">
					<span>교육완료</span>
				</button>
			</div>

			<div class="float_right">
				<button type="button" class="btn save" title="저장하기" onClick="eduseqInsert()">
					<span>저장</span>
				</button>
				<button type="button" class="btn cancel" title="삭제하기" onClick="eduseqDelete()" style="display:<c:if test="${param.mode != 'E'}">none</c:if>">
					<span>삭제</span>
				</button>
				<a href="javascript:eduseqList()" title="목록" class="btn list">
					<span>목록</span>
				</a>
			</div>
		</div>
		
</form>
</div>
<!--// content -->
