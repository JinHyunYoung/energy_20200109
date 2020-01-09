<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="year" value="${now}" pattern="yyyy" />

<script language="javascript">

var year = ${year} + 1;
var statApplyWriteUrl = '<c:url value="/web/wbiz/statInspApplyWrite.do" />';
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
		
	$('.personal_chk_btn button.close').hide(); 
	
	//개인정보 수집 및 이용에 동의 닫기
	$('.personal_chk_btn button.close').on("click",function(){
	    $(".personal_chk_btn").removeClass('on');
	    $(".personal_chk_open").removeClass('on');
	    $('.personal_chk_btn button.close').hide();
	    $('.personal_chk_btn button.open').show();
	});
	
	//개인정보 수집 및 이용에 동의 자세히보기
	$('.personal_chk_btn button.open').on("click",function(){
	    $(".personal_chk_btn").addClass('on');
	    $(".personal_chk_open").addClass('on');
	    $('.personal_chk_btn button.open').hide();
	    $('.personal_chk_btn button.close').show();
	});
	
});



function setAddr( a , b , _zipNo , _admCd  ){
	
	$( '#post' ).val( _zipNo );
	$( '#addr1' ).val( a );
	
}


function statApplyWrite( _app_stt_cd ){

	if( ! $( '#personal_chk' ).get(0).checked ){
		alert( '개인정보 수집 및 이용에 동의해야 신청 가능합니다.' );
		$( '#personal_chk' ).focus();
		return false;		
	}
	
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

	
	
	if( ! confirm( '차년도 통계조사를 신청하시겠습니까?' ) ){
		return false;		
	}
	
	$( '#biz_reg_no' ).val( $( '#biz_reg_no_1' ).val() + '-' +  $( '#biz_reg_no_2' ).val() + '-' + $( '#biz_reg_no_3' ).val() );
	$( '#pic_email' ).val( $( '#pic_email_1' ).val() + '@' + $( '#pic_email_2' ).val() );
	$( '#telno' ).val( $( '#telno_1' ).val() + '-' + $( '#telno_2' ).val() + '-' + $( '#telno_3' ).val() );
	$( '#pic_clph_no' ).val( $( '#pic_clph_no_1' ).val() + '-' + $( '#pic_clph_no_2' ).val() + '-' + $( '#pic_clph_no_3' ).val() );
	
	$.ajax({
        url: statApplyWriteUrl ,
        dataType: 'json' ,
        type: 'post' ,
        data: jQuery("#writeForm").serialize() ,
        success: function( data ){
        	if( data.result == 0 ){
        		alert( '이미 [' + year + '년] 통계조사 신청을 하셨습니다.' );
        	}else if( data.result == 1 ){
        		alert( '[' + year + '년] 통계조사 신청을 완료하였습니다.' );
        	}
        },
        error: function(e) {
            alert( "차년도 통계조사 신청하는데 실패하였습니다." );
        }
    });
	
	return false;
	
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

<div class="basic_txt marginb20">
	물산업통계조사는 매년 5월 중, 물산업 사업체 3,000여개사를 대상으로 표본조사를 실시하고 있습니다.<br>
	물산업 기업인 경우, 참여가 가능하며 아래 신청서를 제출하여 주시면 차년도 조사대상으로 검토하겠습니다.
</div>

<!-- 개인정보수집동의 -->
<div class="personal_chk_area marginb40">
	<div class="personal_chk_close">
		<div class="personal_chk_txt">
			<input id="personal_chk" type="checkbox">
			<label for="personal_chk">개인정보 수집 및 이용에 동의 <span>(필수)</span></label>
		</div>
		
		<!-- 열고 닫기 class에 on 추가/삭제로 컨트롤하시면 됩니다 -->
		<div class="personal_chk_btn on">
			<button title="자세히 보기" class="open">자세히 보기 ▼</button>
			<button title="닫기" class="close">닫기 ▲</button>
		</div>
	</div>
	
	<!-- 열고 닫기 class에 on 추가/삭제로 컨트롤하시면 됩니다 -->
	<div class="personal_chk_open">
		<strong>개인정보 수집 및 이용에 대한 안내</strong>
		<br><br>
		<p>물산업종합정보시스템은 개인정보보호법 등 관련법령에 의거하여, 개인정보를 수집 · 이용함에 있어서 정보 주체로 부터의 이용 동의 여부를 사전에 고지하고 있습니다. 정보주체가 되는 이용자께서는 아래 내용을 확인하시고, 동의 여부를 결정하여 주시기 바랍니다.</p>
		<br>
		<p>1.개인정보의 수집 및 이용목적</p>
		<p>- 물산업종합정보시스템 뉴스레터, 설문발송 등을 위한 목적으로 한다.</p>
		<br>
		<p>2.수집하는 개인정보의 항목</p>
		<p>- 이름, 이메일</p>
		<br>
		<p>3.개인정보의 보유 및 이용기간</p>
		<p>- 서비스신청 거부시까지</p>
		<br>
		<p>4.동의를 거부할 권리 및 동의 거부에 따른 안내</p> 
		<p>- 이용자는 본 안내에 따른 개인정보 수집에 대하여 거부할 권리가 있습니다.</p>
		<p>- 본 개인정보 수집에 대하여 거부하시는 경우, 메일서비스 신청이 이루어지지 않음에 따라 물산업종합정보시스템 이메일 관련서비스를 이용하실 수 없습니다.</p>
	</div>
</div>
<!--// 개인정보수집동의 -->

<form name="writeForm" id="writeForm" method="post">
<input type="hidden" name="biz_reg_no" id="biz_reg_no" value="" />
<input type="hidden" name="pic_email" id="pic_email" value="" />
<input type="hidden" name="telno" id="telno" value="" />
<input type="hidden" name="pic_clph_no" id="pic_clph_no" value="" />

<div class="table_area">
	<h5 class="normal_title">신청서 작성</h5>
	<table class="write fixed __se_tbl_ext">
		<caption>신청서 작성 화면</caption>
		<colgroup>
			<col style="width: 15%;">
			<col>
		</colgroup>
		<tbody>
		<tr>
			<th scope="row">
				<label for="cmpy_nm"><strong class="color_pointr">*</strong> 소속 기업명</label>
			</th>
			<td>
				<input class="in_w100" name="cmpy_nm" id="cmpy_nm" type="text" maxlength="100" />
			</td>
		</tr>
		<tr>
			<th scope="row">
				<strong class="color_pointr">*</strong> 사업자번호
			</th>
			<td>
				<label class="hidden" for="biz_reg_no_1">사업자번호 첫번째</label>
				<input class="in_wp80" id="biz_reg_no_1" name="biz_reg_no_1" type="text" maxlength="3" /> - 
				<label class="hidden" for="biz_reg_no_2">사업자번호 두번째</label>
				<input class="in_wp60" id="biz_reg_no_2" name="biz_reg_no_2" type="text" maxlength="2" /> - 
				<label class="hidden" for="biz_reg_no_3">사업자번호 세번째</label>
				<input class="in_wp100" id="biz_reg_no_3" name="biz_reg_no_3" type="text" maxlength="5" />
			</td>
		</tr>
		<tr>
			<th scope="row">
				<strong class="color_pointr">*</strong> 물산업 분류(주업종)
			</th>
			<td>
				<label class="hidden" for="inds_tp_cd">물산업 분류(주업종)</label>
				<select class="in_wp150" id="inds_tp_cd" name="inds_tp_cd">
					<option value="">선택</option>
					<c:forEach items="${indsTypeCodeList}" var="code">
						<option value="${code.code}">${code.code_nm}</option>					
					</c:forEach>
				</select>
				<label class="hidden" for="wbiz_tp_l_cd">물산업 분류(주업종) 2</label>
				<select class="in_wp150" id="wbiz_tp_l_cd" name="wbiz_tp_l_cd">
					<option value="">선택</option>
				</select>
				<label class="hidden" for="wbiz_tp_m_cd">물산업 분류(주업종) 3</label>
				<select class="in_wp150" id="wbiz_tp_m_cd" name="wbiz_tp_m_cd">
					<option value="">선택</option>
				</select>
				<label class="hidden" for="wbiz_tp_s_cd">물산업 분류(주업종) 4</label>
				<select class="in_wp150" id="wbiz_tp_s_cd" name="wbiz_tp_s_cd">
					<option value="">선택</option>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row">
				<label for="empl_cnt"><strong class="color_pointr">*</strong> 종사자수(사원수)</label>
			</th>
			<td>
				<input class="in_w50" id="empl_cnt" name="empl_cnt" type="text" maxlength="10" />
			</td>
		</tr>
		<tr>
			<th scope="row">
				<strong class="color_pointr">*</strong> 주소
			</th>
			<td>
				<input class="in_w40" id="post" name="post" type="text" maxlength="5" />
				<a title="주소찾기" class="btn basic" href="#post" onclick="jusoPopupShow();return false;">
					<span>주소찾기</span>
				</a>
				<div class="margint5">
					<label class="hidden" for="addr1">기본주소</label>
					<input class="in_w45" id="addr1" name="addr1" type="text" maxlength="150" />
					<label class="hidden" for="addr2">상세주소</label>
					<input class="in_w45" id="addr2" name="addr2" type="text" maxlength="150" />
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">
				<label for="pic_nm"><strong class="color_pointr">*</strong> 이름</label>
			</th>
			<td>
				<input class="in_w100" id="pic_nm" name="pic_nm" type="text" maxlength="15" />
			</td>
		</tr>
		<tr>
			<th scope="row">전화번호</th>
			<td>
				<div class="m_phone_area">
					<label class="hidden" for="telno_1">전화번호 앞자리</label>
					<select class="in_wp80" id="telno_1" name="telno_1">
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>
						<option value="070">070</option>
					</select>
					-
					<label class="hidden" for="telno_2">전화번호 중간자리</label>
					<input class="in_wp80" id="telno_2" name="telno_2" type="text" maxlength="4" />
					-
					<label class="hidden" for="telno_3">전화번호 뒷자리</label>
					<input class="in_wp80" id="telno_3" name="telno_3" type="text" maxlength="4" />
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">휴대전화</th>
			<td>
				<div class="m_phone_area">
					<label class="hidden" for="pic_clph_no_1">휴대전화 앞자리</label>
					<select class="in_wp80" id="pic_clph_no_1" name="pic_clph_no_1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					-
					<label class="hidden" for="pic_clph_no_2">휴대전화 중간자리</label>
					<input class="in_wp80" id="pic_clph_no_2" name="pic_clph_no_2" type="text" maxlength="4" />
					-
					<label class="hidden" for="pic_clph_no_3">휴대전화 뒷자리</label>
					<input class="in_wp80" id="pic_clph_no_3" name="pic_clph_no_3" type="text" maxlength="4" />
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row">
				<strong class="color_pointr">*</strong> 이메일
			</th>
			<td>
				<label class="hidden" for="pic_email_1">이메일 01</label>
				<input class="in_w30" id="pic_email_1" name="pic_email_1" type="text" maxlength="100" /> @ 
				<label class="hidden" for="pic_email_2">이메일 02</label>
				<input class="in_w30" id="pic_email_2" name="pic_email_2" type="text" maxlength="100" />
				<label class="hidden" for="pic_email_select">이메일 03</label>
				<select class="in_wp150" id="pic_email_select" name="pic_email_select">
					<option value="">선택</option>			    				
				    <option value="naver.com">네이버</option>				
				    <option value="daum.com">다음</option>
				    <option value="gmail.com">지메일</option>
				    <option value="hanmail.net">한메일</option>
				    <option value="paran.com">파란</option>
				    <option value="empal.com">엠파스</option>
				    <option value="nate.com">네이트</option>
				    <option value="yahoo.co.kr">야후코리아</option>
				    <option value="dreamwiz.com">드림위즈</option>
				    <option value="freechal.com">프리챌</option>
				    <option value="hotmail.com">핫메일</option>
				    <option value="korea.com">코리아닷컴</option>
				    <option value="direct">직접입력</option>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row">
				<label for="pic_dept">소속부서</label>
			</th>
			<td>
				<input class="in_w100" id="pic_dept" name="pic_dept" type="text" maxlength="50" />
			</td>
		</tr>
		<tr>
			<th scope="row">
				<label for="pstn_nm">직위</label>
			</th>
			<td>
				<input class="in_w100" id="pstn_nm" name="pstn_nm" type="text" maxlength="25" />
			</td>
		</tr>
		</tbody>
	</table>
</div>
<!--// table_area -->
</form>

<!-- button_area -->
<div class="button_area alignc">
	<button title="신청완료" class="btn save" onclick="statApplyWrite();">
		<span>신청완료</span>
	</button>
	<a title="취소" class="btn cancel" href="#cancel" onclick="statApplyCancel();">
		<span>취소</span>
	</a>
</div>
<!--// button_area -->

