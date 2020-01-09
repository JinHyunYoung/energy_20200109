<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

	var saveSatisfyUrl = "<c:url value='/web/board/saveSatisfy.do'/>";

	$(document).ready(function(){
		loadFiles();
	});

	// 만족도 저장
	function saveSatisfy(){

// 기존 소스 - 시작 /////////////////
// 	// 로그인 여부 확인하기
// 	var sid = "${s_user_no }";
// 	if(sid == ""){
// 		alert("로그인이 후 참여 가능합니다.");
// 		return;
// 	}

// 	var yn = "${intropage.satisfy_yn }";
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

	// 첨부파일을 조회
	function loadFiles(){
		var group_id = $("#group_id").val();
		var prm = {"group_id":group_id};

		$.ajax({
			type: "POST",
			url: "/web/intropage/intropageFileList.do",
			data :prm,
			dataType: 'json',
			success:function(data){
				if(data.success == "true"){

					if(data.files.length > 0){
						$("#file_layer").show();

						hideViewFile();

					} else {
						$("#file_layer").hide();
					}

					var sub_html = "";
					sub_html += '<ul class="downfile_list">';
					for (i = 0; i < data.files.length; i++) {
						sub_html += '<li>';
						sub_html += '	<a href="/commonfile/fileidDownLoad.do?file_id='+data.files[i].file_id+'" target="_blank" class="download" title="다운받기">'+data.files[i].file_title+'</a>';
						sub_html += '</li>';
					}
					sub_html += '</ul>';
					$("#viewFile").html(sub_html);
				}
			}
		});
	}

	// 파일을 보여준다.
	function showViewFile(){
		$("#viewFile").show();
		$("#show_filelist_btn").hide();
		$("#hide_filelist_btn").show();
	}

	// 파일을 숨긴다.
	function hideViewFile(){
		$("#viewFile").hide();
		$("#show_filelist_btn").show();
		$("#hide_filelist_btn").hide();
	}
</script>

<div id="file_layer" class="file_layer_area" style="display: none;">
	<div class="file_layerpop">
		<div>
			<button id="show_filelist_btn" class="btn_filedown" title="자료목록 열기" onclick="showViewFile();">
				<span class="before">자료받기</span>
			</button>
			<button id="hide_filelist_btn" class="btn_filedown" title="자료목록 닫기" onclick="hideViewFile();">
				<span class="after">자료받기</span>
			</button>
		</div>
		<div id="viewFile" class="downfile_area" style="display: none;"></div>
	</div>
</div>

<input type="hidden" id="group_id" value="${intropage.group_id}">

<div class="editor">${intropage.contents}</div>

<c:if test="${intropage.cpr_use_yn eq 'Y' && intropage.cpr_cmrc_use_yn eq 'Y' && intropage.cpr_chng_use_yn eq 'Y'}">
	<div class="kogl_area kogl_01">
		<p>본 저작물은 <strong>"공공누리 제1유형 : 출처표시"</strong> 조건에 따라 이용할 수 있습니다.</p>
	</div>
</c:if>

<c:if test="${intropage.cpr_use_yn eq 'Y' && intropage.cpr_cmrc_use_yn eq 'N' && intropage.cpr_chng_use_yn eq 'Y'}">
	<div class="kogl_area kogl_02">
		<p>본 저작물은 <strong>"공공누리 제2유형 : 출처표시+상업적이용금지"</strong> 조건에 따라 이용할 수 있습니다.</p>
	</div>
</c:if>

<c:if test="${intropage.cpr_use_yn eq 'Y' && intropage.cpr_cmrc_use_yn eq 'Y' && intropage.cpr_chng_use_yn eq 'N'}">
	<div class="kogl_area kogl_03">
		<p>본 저작물은 <strong>"공공누리 제3유형 : 출처표시+변경금지"</strong> 조건에 따라 이용할 수 있습니다.</p>
	</div>
</c:if>

<c:if test="${intropage.cpr_use_yn eq 'Y' && intropage.cpr_cmrc_use_yn eq 'N' && intropage.cpr_chng_use_yn eq 'N'}">
	<div class="kogl_area kogl_04">
		<p>본 저작물은 <strong>"공공누리 제4유형 : 출처표시+상업적이용금지+변경금지"</strong> 조건에 따라 이용할 수 있습니다.</p>
	</div>
</c:if>

<div class="list_foot_area">

	<%-- 담당정보 --%>
	<c:if test="${intropage.charge_info != '' && intropage.charge_info ne null}">
		<div class="responsibility_area">
			<ul>
				<li>
					<strong>${intropage.charge_info}</strong>
				</li>
			</ul>
		</div>
	</c:if>

	<%-- 만족도사용여부 --%>
	<c:if test="${intropage.satis_yn eq 'Y'}">

		<form id="satisfyFrm" name="satisfyFrm" onsubmit="return false;">

			<input type='hidden' id="contents_id" name='contents_id' value="${intropage.page_id}" />
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
			<!--// satisfaction_area -->

		</form>

	</c:if>

</div>

