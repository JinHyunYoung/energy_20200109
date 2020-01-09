<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">


var year = ${year} + 1;
var statApplyUpdateUrl = '<c:url value="/admin/wbiz/statInspApplyUpdate.do" />';
var categoryLoadUrl = '<c:url value="/web/wbiz/categoryLoad.do" />';

$( document ).ready( function(){
	
	$( '#pic_email_2' ).attr( 'readonly' , 'readonly' );
	
	$( '#pic_email_select' ).bind( 'change' , function(){
		if( $( this ).val() =='direct' ){
			$( '#pic_email_2' ).removeAttr( 'readonly' );
			$( '#pic_email_2' ).focus();
		}else{
			$( '#pic_email_2' ).val( $( this ).val() );
			$( '#pic_email_2' ).attr( 'readonly' , 'readonly' );
		}
	});
	
	$( '#inds_tp_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'L' );
	});
	
	$( '#wbiz_tp_l_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'M' );
	});
	
	$( '#wbiz_tp_m_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'S' );
	});
	
});

function setAddr( a , b , _zipNo , _admCd  ){
	
	$( '#post' ).val( _zipNo );
	$( '#addr1' ).val( a );
	
}

function statApplyWrite( _app_stt_cd ){

	if( $( '#cmpy_nm' ).val().replace( / /gi , '' ) == '' ){
		alert( '소속 기업명을 입력하십시오.' );
		$( '#cmpy_nm' ).focus();
		return false;		
	}
	
	if( $( '#biz_reg_no_1' ).val().replace( / /gi , '' ) == '' ){
		alert( '사업자번호를 입력하십시오.' );
		$( '#biz_reg_no_1' ).focus();
		return false;		
	}
	
	if( $( '#biz_reg_no_2' ).val().replace( / /gi , '' ) == '' ){
		alert( '사업자번호를 입력하십시오.' );
		$( '#biz_reg_no_2' ).focus();
		return false;		
	}
	
	if( $( '#biz_reg_no_3' ).val().replace( / /gi , '' ) == '' ){
		alert( '사업자번호를 입력하십시오.' );
		$( '#biz_reg_no_3' ).focus();
		return false;		
	}
	
	var reg_biz_no_1 = /^\d{3}$/;
	var reg_biz_no_2 = /^\d{2}$/;
	var reg_biz_no_3 = /^\d{5}$/;
	
	if( ! reg_biz_no_1.test( $( '#biz_reg_no_1' ).val() ) ){
		alert( '사업자번호(숫자3자리)를 확인하십시오.' );
		$( '#biz_reg_no_1' ).focus();
		return false;		
	}
	
	if( ! reg_biz_no_2.test( $( '#biz_reg_no_2' ).val() ) ){
		alert( '사업자번호(숫자2자리)를 확인하십시오.' );
		$( '#biz_reg_no_2' ).focus();
		return false;		
	}
	
	if( ! reg_biz_no_3.test( $( '#biz_reg_no_3' ).val() ) ){
		alert( '사업자번호(숫자5자리)를 확인하십시오.' );
		$( '#biz_reg_no_3' ).focus();
		return false;		
	}
	
	if( $( '#inds_tp_cd' ).val() == '' ){
		alert( '물산업 분류(산업구분)를 선택하십시오.' );
		$( '#inds_tp_cd' ).focus();
		return false;		
	}
	
	if( $( '#wbiz_tp_l_cd' ).val() == '' ){
		alert( '물산업 분류(대분류)를 선택하십시오.' );
		$( '#wbiz_tp_l_cd' ).focus();
		return false;		
	}
	
	if( $( '#wbiz_tp_m_cd' ).val() == '' ){
		alert( '물산업 분류(중분류)를 선택하십시오.' );
		$( '#wbiz_tp_m_cd' ).focus();
		return false;		
	}
	
	if( $( '#wbiz_tp_s_cd' ).val() == '' ){
		alert( '물산업 분류(소분류)를 선택하십시오.' );
		$( '#wbiz_tp_s_cd' ).focus();
		return false;		
	}
	
	if( $( '#empl_cnt' ).val().replace( / /gi , '' ) == '' ){
		alert( '종사자수(사원수)를 입력하십시오.' );
		$( '#empl_cnt' ).focus();
		return false;		
	}
	
	if( $( '#post' ).val().replace( / /gi , '' ) == '' ){
		alert( '주소(우편번호)를 입력하십시오.' );
		$( '#post' ).focus();
		return false;		
	}
	
	if( $( '#addr1' ).val().replace( / /gi , '' ) == '' ){
		alert( '주소(기본주소)를 입력하십시오.' );
		$( '#addr1' ).focus();
		return false;		
	}
	
	if( $( '#addr2' ).val().replace( / /gi , '' ) == '' ){
		alert( '주소(상세주소)를 입력하십시오.' );
		$( '#addr2' ).focus();
		return false;		
	}
	
	if( $( '#pic_nm' ).val().replace( / /gi , '' ) == '' ){
		alert( '이름을 입력하십시오.' );
		$( '#pic_nm' ).focus();
		return false;		
	}
	
	if( $( '#pic_email_1' ).val().replace( / /gi , '' ) == '' ){
		alert( '이메일(아이디)을 입력하십시오.' );
		$( '#pic_email_1' ).focus();
		return false;		
	}
	
	if( $( '#pic_email_2' ).val().replace( / /gi , '' ) == '' ){
		alert( '이메일(도메인)을 입력하십시오.' );
		$( '#pic_email_2' ).focus();
		return false;		
	}
	
	if( $( '#pic_dept' ).val().replace( / /gi , '' ) == '' ){
		alert( '소속부서를 입력하십시오.' );
		$( '#pic_dept' ).focus();
		return false;		
	}
	
	if( $( '#pstn_nm' ).val().replace( / /gi , '' ) == '' ){
		alert( '직위를 입력하십시오.' );
		$( '#pstn_nm' ).focus();
		return false;		
	}

	
	
	if( ! confirm( '통계조사신청을 수정하시겠습니까?' ) ){
		return false;		
	}
	
	$( '#biz_reg_no' ).val( $( '#biz_reg_no_1' ).val() + '-' +  $( '#biz_reg_no_2' ).val() + '-' + $( '#biz_reg_no_3' ).val() );
	$( '#pic_email' ).val( $( '#pic_email_1' ).val() + '@' + $( '#pic_email_2' ).val() );
	$( '#telno' ).val( $( '#telno_1' ).val() + '-' + $( '#telno_2' ).val() + '-' + $( '#telno_3' ).val() );
	$( '#pic_clph_no' ).val( $( '#pic_clph_no_1' ).val() + '-' + $( '#pic_clph_no_2' ).val() + '-' + $( '#pic_clph_no_3' ).val() );
	
	$.ajax({
        url: statApplyUpdateUrl ,
        dataType: 'json' ,
        type: 'post' ,
        data: jQuery("#writeForm").serialize() ,
        success: function( data ){
        	if( data.success == 'true' ){
        		alert( '통계조사신청 수정을 완료하였습니다.' );
        		self.close();
        	}else{
        		alert( "통계조사신청을 수정하는데 실패하였습니다." );
        	}
        },
        error: function(e) {
            alert( "통계조사신청을 수정하는데 실패하였습니다." );
        }
    });
	
	
}

function loadWbizTypeCode( _tp ){		
	
	if( _tp == 'L' ){
		$( '#wbiz_tp_l_cd' ).html( '<option value=""> 선택</option>' );
		$( '#wbiz_tp_m_cd' ).html( '<option value=""> 선택</option>' );			
		$( '#wbiz_tp_s_cd' ).html( '<option value=""> 선택</option>' );
	}else if( _tp == 'M' ){
		$( '#wbiz_tp_m_cd' ).html( '<option value=""> 선택</option>' );			
		$( '#wbiz_tp_s_cd' ).html( '<option value=""> 선택</option>' );
	}else if( _tp == 'S' ){
		$( '#wbiz_tp_s_cd' ).html( '<option value=""> 선택</option>' );
	}
	
	 $.ajax({
        url: categoryLoadUrl,
        dataType: "json",
        type: "post",
        data: {	           
        	inds_tp_cd : $( '#inds_tp_cd' ).val() ,
        	wbiz_tp_l_cd : $( '#wbiz_tp_l_cd' ).val() , 
        	wbiz_tp_m_cd : $( '#wbiz_tp_m_cd' ).val() ,	        	
        	wbiz_cd_tp : _tp
		},
        success: function( data ){
        	
        	var _option = '<option value=""> 선택</option>';
        	if( data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
        			if( _tp == 'L' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_l_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}else if( _tp == 'M' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_m_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}else if( _tp == 'S' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_s_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        		}        		
        	}
        	if( _tp == 'L' ){
    			$( '#wbiz_tp_l_cd' ).html( _option );
    		}else if( _tp == 'M' ){
    			$( '#wbiz_tp_m_cd' ).html( _option );
    		}else if( _tp == 'S' ){
    			$( '#wbiz_tp_s_cd' ).html( _option );
    		}
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
    });		
	
}

</script>

<form name="writeForm" id="writeForm" method="post" onsubmit="return false">
<input type="hidden" name="biz_reg_no" id="biz_reg_no" value="" />
<input type="hidden" name="pic_email" id="pic_email" value="" />
<input type="hidden" name="telno" id="telno" value="" />
<input type="hidden" name="pic_clph_no" id="pic_clph_no" value="" />
<input type="hidden" name="stats_app_sn" id="stats_app_sn" value="${statInspApply.stats_app_sn}" />


<c:set var="array_biz_reg_no" value="${fn:split(statInspApply.biz_reg_no,'-')}"/>
<c:set var="array_telno" value="${fn:split(statInspApply.telno,'-')}"/>
<c:set var="array_pic_clph_no" value="${fn:split(statInspApply.pic_clph_no,'-')}"/>
<c:set var="array_pic_email" value="${fn:split(statInspApply.pic_email,'@')}"/>

	<div id="wrap">
		
		<!-- popup_content -->
		
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">신청자 정보</h1>
			<a href="javascript:closePopup()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
				<div id="pop_content">
				
					<!-- division -->
					<div class="division">
					
						<!-- table_area -->
						<div class="table_area">
							<table class="write">
								<caption>신청자 정보 수정 화면</caption>
								<colgroup>
									<col style="width: 140px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">
										<label for="invg_yy">신청년도<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<select id="invg_yy" name="invg_yy">
											<option value="2018" <c:if test="${statInspApply.invg_yy eq '2018' }" >selected="selected"</c:if> >2018</option>
											<option value="2019" <c:if test="${statInspApply.invg_yy eq '2019' }" >selected="selected"</c:if> >2019</option>
											<option value="2020" <c:if test="${statInspApply.invg_yy eq '2020' }" >selected="selected"</c:if> >2020</option>
											<option value="2021" <c:if test="${statInspApply.invg_yy eq '2021' }" >selected="selected"</c:if> >2021</option>
											<option value="2022" <c:if test="${statInspApply.invg_yy eq '2022' }" >selected="selected"</c:if> >2022</option>
											<option value="2023" <c:if test="${statInspApply.invg_yy eq '2023' }" >selected="selected"</c:if> >2023</option>
											<option value="2024" <c:if test="${statInspApply.invg_yy eq '2024' }" >selected="selected"</c:if> >2024</option>
											<option value="2025" <c:if test="${statInspApply.invg_yy eq '2025' }" >selected="selected"</c:if> >2025</option>
											<option value="2026" <c:if test="${statInspApply.invg_yy eq '2026' }" >selected="selected"</c:if> >2026</option>
											<option value="2027" <c:if test="${statInspApply.invg_yy eq '2027' }" >selected="selected"</c:if> >2027</option>
											<option value="2028" <c:if test="${statInspApply.invg_yy eq '2028' }" >selected="selected"</c:if> >2028</option>
											<option value="2029" <c:if test="${statInspApply.invg_yy eq '2029' }" >selected="selected"</c:if> >2029</option>							
											<option value="2030" <c:if test="${statInspApply.invg_yy eq '2030' }" >selected="selected"</c:if> >2030</option>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="cmpy_nm">소속 기업명<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="cmpy_nm" id="cmpy_nm" class="in_wp200" value="${statInspApply.cmpy_nm}" maxlength="100" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										사업자번호<strong class="color_pointr">*</strong>
									</th>
									<td>
										<input type="text" name="biz_reg_no_1" id="biz_reg_no_1" class="in_wp100" value="${array_biz_reg_no[0]}" maxlength="3" />
										<label for="biz_reg_no_1" class="hidden">사업자번호 첫번째</label> - 
										<input type="text" name="biz_reg_no_2" id="biz_reg_no_2" class="in_wp80" value="${array_biz_reg_no[1]}" maxlength="2" />
										<label for="biz_reg_no_2" class="hidden">사업자번호 두번째</label> - 
										<input type="text" name="biz_reg_no_3" id="biz_reg_no_3" class="in_wp100" value="${array_biz_reg_no[2]}" maxlength="5" />
										<label for="biz_reg_no_3" class="hidden">사업자번호 세번째</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										물산업 분류<br />(주업종)<strong class="color_pointr">*</strong>
									</th>
									<td>
										<select class="in_wp120" id="inds_tp_cd" name="inds_tp_cd">
											<option value="">선택</option>
											<c:forEach items="${indsTypeCodeList}" var="code">											
											<option value="${code.code}" <c:if test="${statInspApply.inds_tp_cd == code.code }">selected="selected"</c:if>>${code.code_nm}</option>					
											</c:forEach>
										</select>
										<label for="inds_tp_cd" class="hidden">주업종 1depth</label>
										
										<select class="in_wp120" id="wbiz_tp_l_cd" name="wbiz_tp_l_cd">
											<option value="">선택</option>
											<c:forEach var="item" items="${list_wbiz_tp_l_cd}">
												<option value="${item.wbiz_tp_l_cd}" <c:if test="${ item.wbiz_tp_l_cd == statInspApply.wbiz_tp_l_cd}">selected="selected"</c:if>>${item.wbiz_clsf_nm}</option>
											</c:forEach>											
										</select>
										<label for="wbiz_tp_l_cd" class="hidden">주업종 2depth</label>
										
										<select class="in_wp120" id="wbiz_tp_m_cd" name="wbiz_tp_m_cd">
											<option value="">선택</option>
											<c:forEach var="item" items="${list_wbiz_tp_m_cd}">
												<option value="${item.wbiz_tp_m_cd}" <c:if test="${ item.wbiz_tp_m_cd == statInspApply.wbiz_tp_m_cd}">selected="selected"</c:if>>${item.wbiz_clsf_nm}</option>
											</c:forEach>
										</select>
										<label for="wbiz_tp_m_cd" class="hidden">주업종 3depth</label>
										
										<select class="in_wp120" id="wbiz_tp_s_cd" name="wbiz_tp_s_cd">
											<option value="">선택</option>
											<c:forEach var="item" items="${list_wbiz_tp_s_cd}">
												<option value="${item.wbiz_tp_s_cd}" <c:if test="${ item.wbiz_tp_s_cd == statInspApply.wbiz_tp_s_cd}">selected="selected"</c:if>>${item.wbiz_clsf_nm}</option>
											</c:forEach>
										</select>
										<label for="wbiz_tp_s_cd" class="hidden">주업종 4depth</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="empl_cnt">종사자수(사원수)<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="empl_cnt" id="empl_cnt" class="in_wp100" maxlength="10" value="${statInspApply.empl_cnt}" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										주소<strong class="color_pointr">*</strong>
									</th>
									<td>
										<div class="">
											<input type="text" name="post" id="post" class="in_wp100" maxlength="5" value="${statInspApply.post}" />
											<label for="post" class="hidden">우편번호</label>
											<button class="btn active" title="주소찾기" onclick="jusoPopupShow();return false;">
												<span>주소찾기</span>
											</button>
										</div>
										<div class="margint5">
											<input type="text" name="addr1" id="addr1" class="in_w30" maxlength="150" value="${statInspApply.addr1}" />
											<label for="addr1" class="hidden">기본주소</label>
											<input type="text" name="addr2" id="addr2" class="in_w30" maxlength="150" value="${statInspApply.addr2}" />
											<label for="addr2" class="hidden">상세주소</label>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="pic_nm">이름<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="pic_nm" id="pic_nm" class="in_w120" maxlength="15" value="${statInspApply.pic_nm}" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										전화번호
									</th>
									<td>
										<select class="in_wp80" id="telno_1" name="telno_1">
											<option value="02" <c:if test="${array_telno[0] == '02'}">selected="selected"</c:if>>02</option>
											<option value="031" <c:if test="${array_telno[0] == '031'}">selected="selected"</c:if>>031</option>
											<option value="032" <c:if test="${array_telno[0] == '032'}">selected="selected"</c:if>>032</option>
											<option value="033" <c:if test="${array_telno[0] == '033'}">selected="selected"</c:if>>033</option>
											<option value="041" <c:if test="${array_telno[0] == '041'}">selected="selected"</c:if>>041</option>
											<option value="042" <c:if test="${array_telno[0] == '042'}">selected="selected"</c:if>>042</option>
											<option value="043" <c:if test="${array_telno[0] == '043'}">selected="selected"</c:if>>043</option>
											<option value="051" <c:if test="${array_telno[0] == '051'}">selected="selected"</c:if>>051</option>
											<option value="052" <c:if test="${array_telno[0] == '052'}">selected="selected"</c:if>>052</option>
											<option value="053" <c:if test="${array_telno[0] == '053'}">selected="selected"</c:if>>053</option>
											<option value="054" <c:if test="${array_telno[0] == '054'}">selected="selected"</c:if>>054</option>
											<option value="055" <c:if test="${array_telno[0] == '055'}">selected="selected"</c:if>>055</option>
											<option value="061" <c:if test="${array_telno[0] == '061'}">selected="selected"</c:if>>061</option>
											<option value="062" <c:if test="${array_telno[0] == '062'}">selected="selected"</c:if>>062</option>
											<option value="063" <c:if test="${array_telno[0] == '063'}">selected="selected"</c:if>>063</option>
											<option value="064" <c:if test="${array_telno[0] == '064'}">selected="selected"</c:if>>064</option>
											<option value="070" <c:if test="${array_telno[0] == '070'}">selected="selected"</c:if>>070</option>
										</select>
										<label for="telno_1" class="hidden">회사 전화번호 앞번호 선택</label> - 
										<input type="text" class="in_wp100" id="telno_2" name="telno_2" maxlength="4" value="${array_telno[1]}" /> - 
										<label for="telno_2" class="hidden">회사 전화번호 중간번호 입력</label>
										<input type="text" class="in_wp100" id="telno_3" name="telno_3" maxlength="4" value="${array_telno[2]}" />
										<label for="telno_3" class="hidden">회사 전화번호 뒷번호 입력</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										휴대전화
									</th>
									<td>
										<select class="in_wp80" id="pic_clph_no_1" name="pic_clph_no_1">
											<option value="010" <c:if test="${array_pic_clph_no[0] == '010'}">selected="selected"</c:if>>010</option>
											<option value="011" <c:if test="${array_pic_clph_no[0] == '011'}">selected="selected"</c:if>>011</option>
											<option value="016" <c:if test="${array_pic_clph_no[0] == '016'}">selected="selected"</c:if>>016</option>
											<option value="017" <c:if test="${array_pic_clph_no[0] == '017'}">selected="selected"</c:if>>017</option>
											<option value="018" <c:if test="${array_pic_clph_no[0] == '018'}">selected="selected"</c:if>>018</option>
											<option value="019" <c:if test="${array_pic_clph_no[0] == '019'}">selected="selected"</c:if>>019</option>
										</select>
										<label for="pic_clph_no_1" class="hidden">핸드폰번호 앞번호 선택</label> - 
										<input type="text" class="in_wp100" id="pic_clph_no_2" name="pic_clph_no_2" maxlength="4" value="${array_pic_clph_no[1]}" /> - 
										<label for="pic_clph_no_2" class="hidden">핸드폰번호 중간번호 입력</label>
										<input type="text" class="in_wp100" id="pic_clph_no_3" name="pic_clph_no_3" maxlength="4" value="${array_pic_clph_no[2]}" />
										<label for="pic_clph_no_3" class="hidden">핸드폰번호 뒷번호 입력</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										이메일<strong class="color_pointr">*</strong>
									</th>
									<td>
										<label for="pic_email_1" class="hidden">이메일 앞주소</label>
										<input type="text" name="pic_email_1" id="pic_email_1" class="in_wp100" maxlength="100" value="${array_pic_email[0]}" /> @ 
										<label for="pic_email_2" class="hidden">이메일 뒷주소</label>
										<input type="text" name="pic_email_2" id="pic_email_2" class="in_wp120" maxlength="100" value="${array_pic_email[1]}" />
										<label for="pic_email_select" class="hidden">이메일 뒷주소 선택</label>
										<select id="pic_email_select" name="pic_email_select" class="in_wp120">
											<option value="" <c:if test="${array_pic_email[1] == ''}">selected="selected"</c:if>>선택</option>
											<option value="naver.com" <c:if test="${array_pic_email[1] == 'naver.com'}">selected="selected"</c:if>>네이버</option>				
										    <option value="daum.com" <c:if test="${array_pic_email[1] == 'daum.com'}">selected="selected"</c:if>>다음</option>
										    <option value="gmail.com" <c:if test="${array_pic_email[1] == 'gmail.com'}">selected="selected"</c:if>>지메일</option>
										    <option value="hanmail.net" <c:if test="${array_pic_email[1] == 'hanmail.net'}">selected="selected"</c:if>>한메일</option>
										    <option value="paran.com" <c:if test="${array_pic_email[1] == 'paran.com'}">selected="selected"</c:if>>파란</option>
										    <option value="empal.com" <c:if test="${array_pic_email[1] == 'empal.com'}">selected="selected"</c:if>>엠파스</option>
										    <option value="nate.com" <c:if test="${array_pic_email[1] == 'nate.com'}">selected="selected"</c:if>>네이트</option>
										    <option value="yahoo.co.kr" <c:if test="${array_pic_email[1] == 'yahoo.co.kr'}">selected="selected"</c:if>>야후코리아</option>
										    <option value="dreamwiz.com" <c:if test="${array_pic_email[1] == 'dreamwiz.com'}">selected="selected"</c:if>>드림위즈</option>
										    <option value="freechal.com" <c:if test="${array_pic_email[1] == 'freechal.com'}">selected="selected"</c:if>>프리챌</option>
										    <option value="hotmail.com" <c:if test="${array_pic_email[1] == 'hotmail.com'}">selected="selected"</c:if>>핫메일</option>
										    <option value="korea.com" <c:if test="${array_pic_email[1] == 'korea.com'}">selected="selected"</c:if>>코리아닷컴</option>
										    <option value="direct">직접입력</option>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="pic_dept">소속부서</label>
									</th>
									<td>
										<input type="text" name="pic_dept" id="pic_dept" class="in_wp200" maxlength="50" value="${statInspApply.pic_dept}" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="pstn_nm">직위</label>
									</th>
									<td>
										<input type="text" name="pstn_nm" id="pstn_nm" class="in_wp200" maxlength="25" value="${statInspApply.pstn_nm}" />
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
						
						<!-- button_area -->
						<div class="button_area">
							<div class="float_right">
								<button class="btn save" title="저장" onclick="statApplyWrite();return false;">
									<span>저장</span>
								</button>
								<button class="btn cancel" title="취소" onclick="self.close();">
									<span>취소</span>
								</button>
							</div>
						</div>
						<!--// button_area -->
						
					</div>
					<!--// division -->
					
				</div>
			</div>
		</article>	
		</div>
		<!--// popup_content -->
		
	</div>
	
</form>

<script type="text/javascript" src="/assets/bootstrap/js/bootstrap.js"></script>
<jsp:include page="/WEB-INF/jsp/admin/common/jusoSearchPopup.jsp"/>