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
	var lang = $( '#lang' ).val();
	var logo_file_nm = $( '#view_logo_file_nm' ).val();
	var logo_file_nm_en = $( '#view_logo_file_nm_en' ).val();
	var cmpy_nm = $( '#view_cmpy_nm' ).val();
	var cmpy_nm_en = $( '#view_cmpy_nm_en' ).val();
	var url = $( '#view_url' ).val();
	var myDirectory = $( '#myDirectory' ).val();

	$( '#dir_logo' ).html( '' );	
	
	var str = "";
	
	str += '<h1 class="firm_logo">';
	if(lang == 'en'){
		if(logo_file_nm_en != null && logo_file_nm_en != ''){
	 		str += '	<img src="/contents/directory/'+logo_file_nm_en+'" alt="'+cmpy_nm_en+'" />';
		} else {
	 		// str += '	<img src="/images/web/common/no_album_img.png" alt="No Image" />';			
		}
	} else {
		if(logo_file_nm != null && logo_file_nm != ''){
 			str += '	<img src="/contents/directory/'+logo_file_nm+'" alt="'+cmpy_nm+'" />';
		} else {
	 		// str += '	<img src="/images/web/common/no_album_img.png" alt="이미지 없음" />';			
		}
	}        	
	str += '</h1>';

	if(lang == 'en'){
		str += '<a href="/web/user/main.do" class="btn_return_home" title="Ministry of Environment Homepage">Ministry of Environment Homepage</a>';
	} else {
		str += '<a href="/web/user/main.do" class="btn_return_home" title="물시장종합정보센터 홈페이지 돌아가기">물시장종합정보센터 홈페이지 돌아가기</a>';		
	}
	
	str += '<div class="dhsection_btnarea">';
	if(lang == 'en'){
				
		if(url != null && url != ''){
			str += '	<a href="'+url+'" id="cmpyDir_url" class="btn list" title="Homepage" target="_blank">';
			str += '		<span><img src="/images/web/sub/directory/icon_home.png" alt="icon_home" /> Homepage</span>';
			str += '	</a>';
		}
		
	} else {
		
		str += '	<button class="btn save" id="btn_cmpy_dir_auth" name="btn_cmpy_dir_auth" title="인증하기" onclick="javascript:popupCmpyDirAuth()">';
		str += '		<span>인증하기</span>';
		str += '	</button>';
		
		if(url != null && url != ''){
			str += '	<a href="'+url+'" id="cmpyDir_url" class="btn list" title="기업 홈페이지" target="_blank">';
			str += '		<span><img src="/images/web/sub/directory/icon_home.png" alt="icon_home" /> 기업 홈페이지</span>';
			str += '	</a>';
		}
	}
	str += '</div>';
	
	$( '#dir_logo' ).html( str );	
	
	if(lang == 'en'){		
		$( '#cmpyDirBrec' ).html( $( '#view_brec_cn_en' ).val() );	
		$( '#cmpyDirMap' ).html( $( '#view_map_cn_en' ).val() );			
	} else {
		$( '#cmpyDirBrec' ).html( $( '#view_brec_cn' ).val() );		
		$( '#cmpyDirMap' ).html( $( '#view_map_cn' ).val() );	
	}
	
	document.title = cmpy_nm;
	
// 	if(lang == 'en'){
// 		setCmpyDirMapAPI( $( '#view_addr1_en' ).val());
// 	} else {
		setCmpyDirMapAPI( $( '#view_addr1' ).val());
// 	}

    setButton('#btn_cmpy_dir_auth');
}

</script>
	
					<input type='hidden' id="view_logo_file_nm" name='view_logo_file_nm' value="${cmpyDir.logo_file_nm}" />
					<input type='hidden' id="view_logo_file_nm_en" name='view_logo_file_nm_en' value="${cmpyDir.logo_file_nm_en}" />  	
					<input type='hidden' id="view_cmpy_nm" name='view_cmpy_nm' value="${cmpyDir.cmpy_nm}" /> 		
					<input type='hidden' id="view_cmpy_nm_en" name='view_cmpy_nm_en' value="${cmpyDir.cmpy_nm_en}" /> 	
					<input type='hidden' id="view_url" name='view_url' value="${cmpyDir.url}" />
					<input type='hidden' id="view_addr1" name='view_addr1' value="${cmpyDir.addr1}" />
					<input type='hidden' id="view_addr1_en" name='view_addr1_en' value="${cmpyDir.addr1_en}" />
					
<%-- 					<input type='hidden' id="view_brec_cn" name='view_brec_cn' value="${cmpyDir.brec_cn}" /> --%>
<%-- 					<input type='hidden' id="view_brec_cn_en" name='view_brec_cn_en' value="${cmpyDir.brec_cn_en}" /> --%>
<%-- 					<input type='hidden' id="view_map_cn" name='view_map_cn' value="${cmpyDir.map_cn}" /> --%>
<%-- 					<input type='hidden' id="view_map_cn_en" name='view_map_cn_en' value="${cmpyDir.map_cn_en}" /> --%>

					<textarea id="view_brec_cn" name="view_brec_cn" style="display: none">${cmpyDir.brec_cn}</textarea>
					<textarea id="view_brec_cn_en" name="view_brec_cn_en" style="display: none">${cmpyDir.brec_cn_en}</textarea>
					<textarea id="view_map_cn" name="view_map_cn" style="display: none">${cmpyDir.map_cn}</textarea>
					<textarea id="view_map_cn_en" name="view_map_cn_en" style="display: none">${cmpyDir.map_cn_en}</textarea>
					

					<table class="dtable">
						<caption>
							<c:if test="${param.lang == 'en'}">
							Overview
							</c:if>
							<c:if test="${param.lang != 'en'}">
							기본정보 화면
							</c:if>						
						</caption>
						<colgroup>
							<col style="width: 180px;" />
							<col style="width: *;" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row" class="first" style="min-width: 180px;">
								<c:if test="${param.lang == 'en'}">
								Company Name
								</c:if>
								<c:if test="${param.lang != 'en'}">
								기업명
								</c:if>
							</th>
							<td class="last">							
								<c:if test="${param.lang == 'en'}">
								${cmpyDir.cmpy_nm_en}
								</c:if>
								<c:if test="${param.lang != 'en'}">
								${cmpyDir.cmpy_nm}
								</c:if>							
							</td>
						</tr>
						<tr>
							<th scope="row" class="first">						
								<c:if test="${param.lang == 'en'}">
								Business Number
								</c:if>
								<c:if test="${param.lang != 'en'}">
								사업자번호
								</c:if>	
							</th>
							<td class="last">${cmpyDir.biz_reg_no}</td>
						</tr>
						<tr>
							<th scope="row" class="first">					
								<c:if test="${param.lang == 'en'}">
								President and CEO
								</c:if>
								<c:if test="${param.lang != 'en'}">
								대표자명
								</c:if>								
							</th>
							<td class="last">			
								<c:if test="${param.lang == 'en'}">
								${cmpyDir.ceo_nm_en}
								</c:if>
								<c:if test="${param.lang != 'en'}">
								${cmpyDir.ceo_nm}
								</c:if>								
							</td>
						</tr>
						<tr>
							<th scope="row" class="first">	
								<c:if test="${param.lang == 'en'}">
								Foundation Year
								</c:if>
								<c:if test="${param.lang != 'en'}">
								설립년도
								</c:if>				
							</th>
							<td class="last">
								<c:if test="${param.lang == 'en'}">
								${cmpyDir.est_yy} Year ${cmpyDir.est_mm} Month
								</c:if>
								<c:if test="${param.lang != 'en'}">
								${cmpyDir.est_yy}년도 ${cmpyDir.est_mm}월
								</c:if>		
							</td>
						</tr>
						<tr>
							<th scope="row" class="first">
								<c:if test="${param.lang == 'en'}">
								Organication Type
								</c:if>
								<c:if test="${param.lang != 'en'}">
								조직형태
								</c:if>
							</th>
							<td class="last">
								<c:if test="${param.lang == 'en'}">
								${cmpyDir.ogn_frm_nm_en}
								</c:if>
								<c:if test="${param.lang != 'en'}">
								${cmpyDir.ogn_frm_nm}
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row" class="first">
								<c:if test="${param.lang == 'en'}">
								Corporation Type
								</c:if>
								<c:if test="${param.lang != 'en'}">
								법인형태
								</c:if>
							</th>
							<td class="last">
								<c:if test="${param.lang == 'en'}">
								${cmpyDir.cp_tp_cd_nm_en}
								</c:if>
								<c:if test="${param.lang != 'en'}">
								${cmpyDir.cp_tp_cd_nm}
								</c:if>
							
							</td>
						</tr>
						<tr>
							<th scope="row" class="first">
								<c:if test="${param.lang == 'en'}">
								Corporate Directory
								</c:if>
								<c:if test="${param.lang != 'en'}">
								기업 디렉토리
								</c:if>							
							</th>
							<td class="last">
								<c:if test="${param.lang == 'en'}">
								${cmpyDir.inds_tp_cd_nm_en} > ${cmpyDir.wbiz_tp_l_cd_nm_en} > ${cmpyDir.wbiz_tp_m_cd_nm_en} > ${cmpyDir.wbiz_tp_s_cd_nm_en}
								</c:if>
								<c:if test="${param.lang != 'en'}">
								${cmpyDir.inds_tp_cd_nm} > ${cmpyDir.wbiz_tp_l_cd_nm} > ${cmpyDir.wbiz_tp_m_cd_nm} > ${cmpyDir.wbiz_tp_s_cd_nm}
								</c:if>							
							</td>
						</tr>
						<tr>
							<th scope="row" class="first">
								<c:if test="${param.lang == 'en'}">
								Number of Employee
								</c:if>
								<c:if test="${param.lang != 'en'}">
								사원 수
								</c:if>						
							</th>
							<td class="last">${cmpyDir.empl_cnt}</td>
						</tr>
						<tr>
							<th scope="row" class="first">
								<c:if test="${param.lang == 'en'}">
								TEL
								</c:if>
								<c:if test="${param.lang != 'en'}">
								전화번호
								</c:if>
							</th>
							<td class="last">${cmpyDir.tel}</td>
						</tr>
						<tr>
							<th scope="row" class="first">
								<c:if test="${param.lang == 'en'}">
								FAX
								</c:if>
								<c:if test="${param.lang != 'en'}">
								팩스번호
								</c:if>
							</th>
							<td class="last">${cmpyDir.fax}</td>
						</tr>
						</tbody>
					</table>