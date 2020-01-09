<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>
	
<script language="javascript">

$( document ).ready( function(){
	
	$( '#btn_cmpy_dir' ).bind( 'click' , function(){
		popupCmpyDir();
	});
	
	setCmpyDirEvent();
	
});	

//기본정보 로딩 후 상세보기에서 기본 정보 화면 외의 항목들 셋팅
function setCmpyDirEvent(){
	$( '#cmpyDirBrec' ).html( $( '#view_brec_cn' ).val() );		
	$( '#cmpyDirMap' ).html( $( '#view_map_cn' ).val() );	

	setCmpyDirMapAPI( $( '#view_addr1' ).val());
}

</script>

		<input type='hidden' id="view_addr1" name='view_addr1' value="${cmpyDir.addr1}" />
		<input type='hidden' id="app_stt_cd" name='app_stt_cd' value="${cmpyDir.app_stt_cd}" />
<%-- 		<input type='hidden' id="view_brec_cn" name='view_brec_cn' value="${cmpyDir.brec_cn}" /> --%>
<%-- 		<input type='hidden' id="view_map_cn" name='view_map_cn' value="${cmpyDir.map_cn}" /> --%>
		<textarea id="view_brec_cn" name="view_brec_cn" style="display: none">${cmpyDir.brec_cn}</textarea>
		<textarea id="view_map_cn" name="view_map_cn" style="display: none">${cmpyDir.map_cn}</textarea>
	
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">기본정보</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir" title="수정" >
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<!-- table_area -->
		<div class="table_area">
			<table class="write">
				<caption>기본정보 화면</caption>
				<colgroup>
					<col style="width: 140px;">
					<col style="width: *;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" style="min-width: 140px;">기업명(국문)<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.cmpy_nm}</td>
					</tr>
					<tr>
						<th scope="row">기업명(영문)<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.cmpy_nm_en}</td>
					</tr>
					<tr>
						<th scope="row">사업자번호<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.biz_reg_no}</td>
					</tr>
					<tr>
						<th scope="row">대표자명(국문)<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.ceo_nm}</td>
					</tr>
					<tr>
						<th scope="row">대표자명(영문)<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.ceo_nm_en}</td>
					</tr>
					<tr>
						<th scope="row">설립년도<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.est_yy}년도 ${cmpyDir.est_mm}월</td>
					</tr>
					<tr>
						<th scope="row">조직형태<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.ogn_frm_nm}</td>
					</tr>
					<tr>
						<th scope="row">법인형태<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.cp_tp_cd_nm}</td>
					</tr>
					<tr>
						<th scope="row">물산업 분류<br />(주업종)<strong class="color_pointr">*</strong>
						</th>
						<td>${cmpyDir.inds_tp_cd_nm} > ${cmpyDir.wbiz_tp_l_cd_nm} > ${cmpyDir.wbiz_tp_m_cd_nm} > ${cmpyDir.wbiz_tp_s_cd_nm}</td>
					</tr>
					<tr>
						<th scope="row">물산업 분류<br />(부업종)
						</th>
						<td>
							<c:forEach items="${cmpyDirCslfList}" var="list">
								${list.inds_tp_cd_nm} > ${list.wbiz_tp_l_cd_nm} > ${list.wbiz_tp_m_cd_nm} > ${list.wbiz_tp_s_cd_nm} <br/>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">사원 수(명)</th>
						<td>${cmpyDir.empl_cnt}</td>
					</tr>
					<tr>
						<th scope="row">홈페이지 주소</th>
						<td><a href="" title="홈페이지 바로가기" target="_blank">${cmpyDir.url}</a></td>
					</tr>
					<tr>
						<th scope="row">회사 전화번호</th>
						<td>${cmpyDir.tel}</td>
					</tr>
					<tr>
						<th scope="row">회사 팩스번호</th>
						<td>${cmpyDir.fax}</td>
					</tr>
					<tr>
						<th scope="row">회사 주소(국문)</th>
						<td>${cmpyDir.post}, ${cmpyDir.addr1} ${cmpyDir.addr2}</td>
					</tr>
					<tr>
						<th scope="row">회사 주소(영문)</th>
						<td>${cmpyDir.post}, ${cmpyDir.addr2_en} ${cmpyDir.addr1_en}</td>
					</tr>
					<tr>
						<th scope="row">회사 로고(국문)</th>
						<td>
							<div class="file_area">
								<ul class="file_list">
									<li>							
										<a href="/commonfile/fileidDownLoad.do?file_id=${cmpyDir.logo_file_id}" target="_blank" class="download" title="다운받기">${cmpyDir.logo_file_nm}</a> 										
									</li>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">회원사구분</th>
						<td>
							<c:if test="${empty cmpyDir.member_yn_nm}">비회원사</c:if>
							<c:if test="${not empty cmpyDir.member_yn_nm}">회원사</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">승인상태</th>
						<td>${cmpyDir.app_stt_cd_nm}</td>
					</tr>
					<tr>
						<th scope="row">공개여부</th>
						<td>
							<c:if test="${cmpyDir.opn_yn eq 'Y'}">공개</c:if>
							<c:if test="${cmpyDir.opn_yn ne 'Y'}">비공개</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--// table_area -->