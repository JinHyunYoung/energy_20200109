<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

var newsApplyWriteUrl = '<c:url value="/web/newsApply/newsApplyWrite.do" />';

$( document ).ready( function(){
	
	$( '#input_email_02' ).attr( 'readonly' , 'readonly' );
	
	$( '#input_email_03' ).bind( 'change' , function(){
		if( $( this ).val() =='direct' ){
			$( '#input_email_02' ).removeAttr( 'readonly' );
			$( '#input_email_02' ).focus();
		}else{
			$( '#input_email_02' ).val( $( this ).val() );
			$( '#input_email_02' ).attr( 'readonly' , 'readonly' );
		}
	})
		
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

function newsApplyWrite( _app_stt_cd ){

	if( ! $( '#personal_chk' ).get(0).checked ){
		alert( '개인정보 수집 및 이용에 동의해야 신청(해지)가능합니다.' );
		$( '#personal_chk' ).focus();
		return false;		
	}
	
	if( $( '#name' ).val().replace( / /gi , '' ) == '' ){
		alert( '이름을 입력하십시오.' );
		$( '#name' ).focus();
		return false;		
	}
	
	if( $( '#input_email_01' ).val().replace( / /gi , '' ) == '' ){
		alert( '이메일 아이디를 입력하십시오.' );
		$( '#input_email_01' ).focus();
		return false;		
	}
	
	if( $( '#input_email_02' ).val().replace( / /gi , '' ) == '' ){
		alert( '이메일 도메인을 입력하십시오.' );
		$( '#input_email_02' ).focus();
		return false;		
	}
	
	var msg = '';
	if( _app_stt_cd == 'Y' ){
		msg = '뉴스레터 구독신청하시겠습니까?';		
	}else{
		msg = '뉴스레터 구독을 해지하시겠습니까?';
	}
	if( ! confirm( msg ) ) return false;	
	
	$( '#app_stt_cd' ).val( _app_stt_cd );
	$( '#email' ).val( $( '#input_email_01' ).val() + '@' + $( '#input_email_02' ).val() );

	$.ajax({
        url: newsApplyWriteUrl ,
        dataType: 'json' ,
        type: 'post' ,
        data: jQuery("#writeForm").serialize() ,
        success: function( data ){
        	if( data.result == 1 ){
        		alert( '뉴스레터를 이미 신청한 이메일입니다.' );
        	}else if( data.result == 2 ){
        		alert( '해당 이메일은 뉴스레터가 해지된 이메일입니다. 다시 구독신청되었습니다.' );
        	}else if( data.result == 3 ){
        		alert( '신청시 입력하신 이름이 정확하지 않습니다..' );
        	}else if( data.result == 4 ){
        		alert( '해당 이메일의 뉴스레터 구독이 해지되었습니다.' );
        	}else if( data.result == 5 ){
        		alert( '뉴스레터 구독 신청을 하지 않은 이메일입니다.' );
        	}else if( data.result == 6 ){
        		alert( '이미 뉴스레터 구독이 해지된 이메일입니다.' );
        	}else if( data.result == 7 ){
        		alert( '뉴스레터 구독신청이 완료되었습니다.' );
        		$( '#personal_chk' ).get(0).checked = false;
        		$("#writeForm").get(0).reset();
        	}else{
        		alert( '뉴스레터 구독신청(해지)하는데 실패하였습니다.' );
        	}
        },
        error: function(e) {
            alert( "뉴스레터 구독신청(해지)하는데 실패하였습니다." );
        }
    });
		
	
	return false;
	
}

</script>

<div class="basic_txt marginb20">
	물시장종합정보센터에서 제공하는 정보를 뉴스레터를 통해 편리하게 받아보실 수 있으시면 됩니다.<br>
	아래 정보를 입력 후 [신청]을 클릭하시면 뉴스레터가 이메일로 발송됩니다. 기존 신청하신 분 중 더 이상 뉴스레터 수신을 원하지 않으실 경우에는 [해지]를 클릭해주시기 바랍니다. 
</div>
	
<!-- 개인정보수집동의 -->
<div class="personal_chk_area marginb40">
	<div class="personal_chk_close">
	
		<div class="personal_chk_txt">
			<input id="personal_chk" type="checkbox" name="personal_chk" />
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

	<input type="hidden" name="email" id="email" value="" /> 
	<input type="hidden" name="app_stt_cd" id="app_stt_cd" value="" />
	
<div class="table_area">
	<h5 class="normal_title">뉴스레터 구독신청/해지</h5>
	<table class="write fixed __se_tbl_ext">
		<caption>뉴스레터 구독신청/해지 작성 화면</caption>
		<colgroup>
			<col style="width: 15%;">
			<col>
		</colgroup>
		<tbody>
		<tr>
			<th scope="row">
				<label for="name"><strong class="color_pointr">*</strong> 이름</label>
			</th>
			<td>
				<input class="in_w100" name="name" id="name" type="text">
			</td>
		</tr>
		<tr>
			<th scope="row">
				<strong class="color_pointr">*</strong> 이메일
			</th>
			<td>
				<label class="hidden" for="input_email_01">이메일 01</label>
				<input class="in_w30" name="input_email_01" id="input_email_01" type="text"> @ 
				<label class="hidden" for="input_email_02">이메일 02</label>
				<input class="in_w30" name="input_email_02" id="input_email_02" type="text">
				<label class="hidden" for="input_email_03">이메일 03</label>
				<select class="in_wp150" name="input_email_03" id="input_email_03">
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
		</tbody>
	</table>
</div>
<!--// table_area -->
</form>
<!-- button_area -->
<div class="button_area alignc">
	<button title="신청" class="btn save" onclick="newsApplyWrite( 'Y' );">
		<span>신청</span>
	</button>
	<a title="해지" class="btn cancel" href="#cancel" onclick="newsApplyWrite( 'N' );">
		<span>해지</span>
	</a>
</div>

