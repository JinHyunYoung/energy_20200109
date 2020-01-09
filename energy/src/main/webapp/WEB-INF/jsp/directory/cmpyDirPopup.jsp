<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$(document).ready(function(){
	
	// 물산업 불류 콤보 이벤트
	$( '#inds_tp_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'L', $( '#wbiz_tp_l_cd' ) );			
	});
	
	$( '#wbiz_tp_l_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'M', $( '#wbiz_tp_m_cd' ) );			
	});
	
	$( '#wbiz_tp_m_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'S', $( '#wbiz_tp_s_cd' ) );			
	});
	
	$( '#ogn_frm' ).bind( 'change' , function(){
		changeOgnFrm();
	});	
	
	// 파일 삭제
	$('.file_area .btn_file_delete').click(function() {
	    
        if (confirm('첨부된 파일을 삭제하시겠습니까?')) {
            
            var el = this;
            
            $.post(        	    
                "/commonFile/deleteOneCommonFile.do",
                {file_id : $(el).data("file_id")},
                function(data) {
                    if (data.success == "true") {
                        var len =$(el).parent().siblings().length;
                        if (len <= 0) {
                            $(el).closest('div').siblings('input').val('');
                        }
                        $(el).parent().remove();
                    } else {
                        alert(data.message);
                    }
                }
            );
        }
    });
	
	changeOgnFrm();
	
	setWbizTypeCode();
	setCmpyDirCslf();
	
});

function changeOgnFrm(){
	
	if( $( '#ogn_frm' ).val() == '2' )
		$( "#lst_yn_span" ).show();
	else
		$( "#lst_yn_span" ).hide();	
}

function setWbizTypeCode() {
	
	var inds_tp_cd = $( '#inds_tp_cd' ).val();
	var wbiz_tp_l_cd = $( '#wbiz_tp_l_cd' ).val(); 
	var wbiz_tp_m_cd = $( '#wbiz_tp_m_cd' ).val();
	var wbiz_tp_s_cd = $( '#wbiz_tp_s_cd' ).val();
	
	if(inds_tp_cd != "") {
		loadWbizTypeCode( 'L', $( '#wbiz_tp_l_cd' ), null, wbiz_tp_l_cd );			
	}
	
	if(wbiz_tp_l_cd != "") {
		loadWbizTypeCode( 'M', $( '#wbiz_tp_m_cd' ), null, wbiz_tp_m_cd );			
	}
	
	if(wbiz_tp_m_cd != "") {
		loadWbizTypeCode( 'S', $( '#wbiz_tp_s_cd' ), null, wbiz_tp_s_cd );			
	}
	
}

function loadWbizTypeCode( _tp, _obj, _pref, _objValue ){
	if(_pref == null || _pref == undefined) {
		_pref = '';
	}
	
	if( _tp == 'L' ){
		$( '#'+_pref+'wbiz_tp_l_cd' ).html( '<option value="">1Depth</option>' );
		$( '#'+_pref+'wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' );			
		$( '#'+_pref+'wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );
		
		if(_obj == null) _obj = $( '#'+_pref+'wbiz_tp_l_cd' );
		
	}else if( _tp == 'M' ){
		$( '#'+_pref+'wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' );			
		$( '#'+_pref+'wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );
		
		if(_obj == null) _obj = $( '#'+_pref+'wbiz_tp_m_cd' );
		
	}else if( _tp == 'S' ){
		$( '#'+_pref+'wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );
		
		if(_obj == null) _obj = $( '#'+_pref+'wbiz_tp_s_cd' );
	}
	
	 $.ajax({
        url: "/web/wbiz/categoryLoad.do",
        dataType: "json",
        type: "post",
        async: false,
        data: {	           
        	inds_tp_cd : $( '#'+_pref+'inds_tp_cd' ).val() ,
        	wbiz_tp_l_cd : $( '#'+_pref+'wbiz_tp_l_cd' ).val() , 
        	wbiz_tp_m_cd : $( '#'+_pref+'wbiz_tp_m_cd' ).val() ,	        	
        	wbiz_cd_tp : _tp
		},
        success: function( data ){
        	
        	var _option = '';
        	if( data.list != null && data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
        			if( _tp == 'L' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_l_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'M' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_m_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'S' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_s_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        		}        		
        	}
        	
        	if( _tp == 'L' ){
        		_obj.html( '<option value="">1Depth</option>' + _option );
    		}
        	else if( _tp == 'M' ){
        		_obj.html( '<option value="">2Depth</option>' + _option );
    		}
    		else if( _tp == 'S' ){
    			_obj.html( '<option value="">3Depth</option>' + _option );
    		}
    		else if(_obj != null) {
        		_obj.html( '<option value="">-선택-</option>' + _option );
        	}
        	
        	if(_objValue != null) {
    			_obj.val(_objValue);
        	}
        	
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
    });		
}

//주소 설정
function setAddr(roadAddr, jibunAddr, zipNo, admCd){	
	$("#post").val(zipNo);
	$("#addr1").val(roadAddr);
	$("#addr2").val("");
}

function setCmpyDirCslf() {
	
	var tr = $('#cmpyDirCsflTable > tbody > tr');
	tr.each(function(){
		
		var inds_tp_cd = $(this).find('select').eq(0).val();
		var wbiz_tp_l_cd = $(this).find('select').eq(1).val();
		var wbiz_tp_m_cd = $(this).find('select').eq(2).val();
		var wbiz_tp_s_cd = $(this).find('select').eq(3).val();
		
		if(inds_tp_cd != null && inds_tp_cd != '' && inds_tp_cd != undefined  ) {
			loadCmpyDirCslf( 'L', $(this), wbiz_tp_l_cd );		
			loadCmpyDirCslf( 'M', $(this), wbiz_tp_m_cd );
			loadCmpyDirCslf( 'S', $(this), wbiz_tp_s_cd );
		}
		
	});
	
	setCmpyDirCslfEvent();
}

function setCmpyDirCslfEvent() {
	
	$( 'select[name=sub_inds_tp_cd]' ).unbind( 'change' );
	
	$( 'select[name=sub_wbiz_tp_l_cd]' ).bind( 'change' );
	
	$( 'select[name=sub_wbiz_tp_m_cd]' ).bind( 'change' );
	
	
	$( 'select[name=sub_inds_tp_cd]' ).bind( 'change' , function(){
		var row = $(this).closest("tr");
		loadCmpyDirCslf( 'L', row );		
	});
	
	$( 'select[name=sub_wbiz_tp_l_cd]' ).bind( 'change' , function(){
		var row = $(this).closest("tr");
		loadCmpyDirCslf( 'M', row );
	});
	
	$( 'select[name=sub_wbiz_tp_m_cd]' ).bind( 'change' , function(){
		var row = $(this).closest("tr");
		loadCmpyDirCslf( 'S', row );
	});	
	
}

function loadCmpyDirCslf( _tp, _row, _objValue){
	var row = $(_row);
	
	var _obj = null;
	
	var inds_tp_cd = row.find('select').eq(0);
	var wbiz_tp_l_cd = row.find('select').eq(1);
	var wbiz_tp_m_cd = row.find('select').eq(2);
	var wbiz_tp_s_cd = row.find('select').eq(3);
	
	if( _tp == 'L' ){
		wbiz_tp_l_cd.html( '<option value="">1Depth</option>' );
		wbiz_tp_m_cd.html( '<option value="">2Depth</option>' );			
		wbiz_tp_s_cd.html( '<option value="">3Depth</option>' );
		
	}else if( _tp == 'M' ){
		wbiz_tp_m_cd.html( '<option value="">2Depth</option>' );			
		wbiz_tp_s_cd.html( '<option value="">3Depth</option>' );
	}else if( _tp == 'S' ){
		wbiz_tp_s_cd.html( '<option value="">3Depth</option>' );
	}
	
	 $.ajax({
        url: "/web/wbiz/categoryLoad.do",
        dataType: "json",
        type: "post",
        async: false,
        data: {	           
        	inds_tp_cd : inds_tp_cd.val() ,
        	wbiz_tp_l_cd : wbiz_tp_l_cd.val() , 
        	wbiz_tp_m_cd : wbiz_tp_m_cd.val() ,	        	
        	wbiz_cd_tp : _tp
		},
        success: function( data ){
        	
        	var _option = '';
        	if( data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
        			if( _tp == 'L' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_l_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'M' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_m_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'S' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_s_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        		}        		
        	}
        	
        	if( _tp == 'L' ){
        		wbiz_tp_l_cd.html( '<option value="">1Depth</option>' + _option );
            	if(_objValue != null) {
            		wbiz_tp_l_cd.val(_objValue);
            	}
    		}
        	else if( _tp == 'M' ){
        		wbiz_tp_m_cd.html( '<option value="">2Depth</option>' + _option );
            	if(_objValue != null) {
            		wbiz_tp_m_cd.val(_objValue);
            	}
    		}
    		else if( _tp == 'S' ){
    			wbiz_tp_s_cd.html( '<option value="">3Depth</option>' + _option );
            	if(_objValue != null) {
            		wbiz_tp_s_cd.val(_objValue);
            	}
    		}
        	
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
    });		
}

function insertCmpyDirCslfRow(){

	var str = "";

	var tp_cd = $('#inds_tp_cd option');
	
	str += '<tr>';
	str += '	<td>';						
	str += '		<select class="in_wp120" id="sub_inds_tp_cd" name="sub_inds_tp_cd" data-parsley-required="true">';
	str += '				<option value="">선택</option>';	
	tp_cd.each(function(){
		str += '			<option value="'+ $(this).val() + '">' + $(this).text() + '</option>';	
	}); 
	str += '		</select>';
	str += '		<label for="sub_inds_tp_cd" class="hidden">부업종 1depth</label>';
	str += '	</td>';
	str += '	<td>';
	str += '		<select class="in_wp120" id="sub_wbiz_tp_l_cd" name="sub_wbiz_tp_l_cd" data-parsley-required="true">';
	str += '			<option value="">1Depth</option>';
	str += '		</select>';
	str += '		<label for="sub_wbiz_tp_l_cd" class="hidden">주업종 2depth</label>';
	str += '	</td>';
	str += '	<td>';
	str += '		<select class="in_wp120" id="sub_wbiz_tp_m_cd" name="sub_wbiz_tp_m_cd" data-parsley-required="true">';
	str += '			<option value="">2Depth</option>';
	str += '		<label for="sub_wbiz_tp_m_cd" class="hidden">주업종 3depth</label>';
	str += '	</td>';
	str += '	<td>';
	str += '		<select class="in_wp120" id="sub_wbiz_tp_s_cd" name="sub_wbiz_tp_s_cd" data-parsley-required="true">';
	str += '			<option value="">3Depth</option>';
	str += '		</select>';
	str += '		<label for="sub_wbiz_tp_s_cd" class="hidden">주업종 4depth</label>';
	str += '	</td>';
	str += '	<td>';
	str += '		<button class="btn" onclick="javascript:deleteCmpyDirCslfRow(this)" title="삭제">';
	str += '			<img src="/images/admin/common/btn_file_delete.png" alt="삭제" />';
	str += '		</button>';
	str += '	</td>';
	str += '</tr>';
	
	$('#cmpyDirCsflTable > tbody > tr:last').before(str);
	
	setCmpyDirCslfEvent();
	
}

function deleteCmpyDirCslfRow(_btn){
	var trNum = $(_btn).closest('tr').prevAll().length;
	$('#cmpyDirCsflTable > tbody > tr').eq(trNum).remove();
}

</script>

<form id="cmpyDirUpdateForm" name="cmpyDirUpdateForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
	<input type='hidden' id="tel" name='tel' value="${param.tel}" /> 
	<input type='hidden' id="fax" name='fax' value="${param.fax}" /> 

	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">기본정보</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->
		
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			
				<!-- pop_content -->
				<div id="pop_content">
				
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">기본정보</h2>
						</div>
					</div>
					<!--// dtitle_area -->
					
					<!-- dtable_area -->
					<div class="dtable_area">
						<table class="dtable">
							<caption>기본정보 화면</caption>
							<colgroup>
								<col style="width: 180px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>기업명(국문)
								</th>
								<td class="last">
									<input type="text" name="cmpy_nm" id="cmpy_nm" value="${cmpyDir.cmpy_nm}" class="in_w80" data-parsley-maxlength="300" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>기업명(영문)
								</th>
								<td class="last">
									<input type="text" name="cmpy_nm_en" id="cmpy_nm_en" value="${cmpyDir.cmpy_nm_en}" class="in_w80" data-parsley-maxlength="300" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>사업자번호
								</th>
								<td class="last">
									<input type="text" name="biz_reg_no" id="biz_reg_no" value="${cmpyDir.biz_reg_no}" class="in_w80" data-parsley-pattern="\d{3}-\d{2}-\d{5}" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>대표자명(국문)
								</th>
								<td class="last">
									<input type="text" name="ceo_nm" id="ceo_nm" value="${cmpyDir.ceo_nm}" class="in_w80" data-parsley-maxlength="300" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>대표자명(영문)
								</th>
								<td class="last">
									<input type="text" name="ceo_nm_en" id="ceo_nm_en" value="${cmpyDir.ceo_nm_en}" class="in_w80" data-parsley-maxlength="300" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>설립연도
								</th>
								<td class="last">
									<select class="in_wp80" id="est_yy" name="est_yy" data-parsley-errors-container="#email_error_est" data-parsley-required="true">
										<option value="" <c:if test="${cmpyDir.est_yy == ''}">selected="selected"</c:if>>-선택-</option>
										<c:set var="now" value="<%=new java.util.Date()%>" />
         								<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
										<c:forEach begin="0" end="100" var="result" step="1">
											<option value="${yearStart - result}" <c:if test="${(yearStart - result) eq cmpyDir.est_yy}">selected</c:if> >${yearStart - result}년</option>
										</c:forEach>
									</select>
									<label for="est_yy" class="hidden">설립연도 선택</label>
									
									<select class="in_wp80" id="est_mm" name="est_mm" data-parsley-errors-container="#email_error_est" data-parsley-required="true">
										<option value="" <c:if test="${cmpyDir.est_mm == ''}">selected="selected"</c:if>>-선택-</option>
										<c:forEach var="i" begin="1" end="12">
											<option value="${i}" <c:if test="${i eq cmpyDir.est_mm}">selected</c:if> >${i}월</option>
										</c:forEach>
									</select>
									<label for="est_mm" class="hidden">설립월 선택</label>
									<div class="parsely-single-error" id="email_error_est" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>조직형태
								</th>
								<td class="last">
									<g:select id="ogn_frm" name="ogn_frm" codeGroup="OGN_FRM" selected="${cmpyDir.ogn_frm}" cls="form-control" titleCode="선택" data-parsley-required="true"/>
									<label for="ogn_frm" class="hidden">조직형태 선택</label>
																														
									<span id="lst_yn_span" class="marginl10">(
										<input type="radio" name="lst_yn" id="lst_yn_y" class="" value="Y" <c:if test="${cmpyDir.lst_yn eq 'Y'}">checked="checked"</c:if> />
										<label for="lst_yn_y" class="marginr10">상장</label>
										<input type="radio" name="lst_yn" id="lst_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.lst_yn eq 'N'}">checked="checked"</c:if> />
										<label for="lst_yn_n">비상장</label>
									)</span>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>법인형태
								</th>
								<td class="last">
									<g:select id="co_tp_cd" name="co_tp_cd" codeGroup="CO_TP_CD" selected="${cmpyDir.co_tp_cd}" cls="form-control" titleCode="선택" data-parsley-required="true" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<strong class="color_pointr">*</strong>기업 디렉토리<br />(주업종)
								</th>
								<td class="last">
									<table class="sectors">
										<caption>주업종</caption>
										<colgroup>
											<col style="width: 120px;">
											<col style="width: 120px;">
											<col style="width: 120px;">
											<col style="width: *;">
										</colgroup>
										<tbody>
											<tr>
												<td>
													<g:select class="in_wp120" id="inds_tp_cd" name="inds_tp_cd" codeGroup="INDS_TP_CD" selected="${cmpyDir.inds_tp_cd}" cls="form-control"  data-parsley-required="true" />  	
													<label for="inds_tp_cd" class="hidden">주업종 1depth</label>
												</td>
												<td>
													<select class="in_wp120" id="wbiz_tp_l_cd" name="wbiz_tp_l_cd" data-parsley-required="true">
														<c:if test="${not empty cmpyDir.wbiz_tp_l_cd}">
															<option value="${cmpyDir.wbiz_tp_l_cd}">${cmpyDir.wbiz_tp_l_cd_nm}</option>
														</c:if>
														<c:if test="${empty cmpyDir.wbiz_tp_l_cd}">
															<option value="">1Depth</option>
														</c:if>
													</select>
													<label for="wbiz_tp_l_cd" class="hidden">주업종 2depth</label>
												</td>
												<td>
													<select class="in_wp120" id="wbiz_tp_m_cd" name="wbiz_tp_m_cd" data-parsley-required="true">
														<c:if test="${not empty cmpyDir.wbiz_tp_m_cd}">
															<option value="${cmpyDir.wbiz_tp_m_cd}">${cmpyDir.wbiz_tp_m_cd_nm}</option>
														</c:if>
														<c:if test="${empty cmpyDir.wbiz_tp_m_cd}">
															<option value="">2Depth</option>
														</c:if>
													</select>
													<label for="wbiz_tp_m_cd" class="hidden">주업종 3depth</label>
												</td>
												<td>
													<select class="in_wp120" id="wbiz_tp_s_cd" name="wbiz_tp_s_cd" data-parsley-required="true">
														<c:if test="${not empty cmpyDir.wbiz_tp_s_cd}">
															<option value="${cmpyDir.wbiz_tp_s_cd}">${cmpyDir.wbiz_tp_s_cd_nm}</option>
														</c:if>
														<c:if test="${empty cmpyDir.wbiz_tp_s_cd}">
															<option value="">3Depth</option>
														</c:if>
													</select>
													<label for="wbiz_tp_s_cd" class="hidden">주업종 4depth</label>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									기업 디렉토리<br />(부업종)
								</th>
								<td class="last">
									<table id="cmpyDirCsflTable" class="sectors">
									<caption>주업종</caption>
										<colgroup>
											<col style="width: 120px;">
											<col style="width: 120px;">
											<col style="width: 120px;">
											<col style="width: 120px;">
											<col style="width: *;">
										</colgroup>
										<tbody>
											<c:forEach items="${cmpyDirCslfList}" var="list" varStatus="status">
												<tr>
													<td>		
														<g:select class="in_wp120" id="sub_inds_tp_cd" name="sub_inds_tp_cd" codeGroup="INDS_TP_CD" selected="${list.inds_tp_cd}" cls="form-control" data-parsley-required="true"/>  	
														<label for="sub_inds_tp_cd" class="hidden">부업종 1depth</label>
													</td>
													<td>
														<select class="in_wp120" id="sub_wbiz_tp_l_cd" name="sub_wbiz_tp_l_cd" data-parsley-required="true">
															<option value="${list.wbiz_tp_l_cd}">${list.wbiz_tp_l_cd_nm}</option>
														</select>
														<label for="sub_wbiz_tp_l_cd" class="hidden">주업종 2depth</label>
													</td>
													<td>
														<select class="in_wp120" id="sub_wbiz_tp_m_cd" name="sub_wbiz_tp_m_cd" data-parsley-required="true">
															<option value="${list.wbiz_tp_m_cd}">${list.wbiz_tp_m_cd_nm}</option>
														</select>
														<label for="sub_wbiz_tp_m_cd" class="hidden">주업종 3depth</label>
													</td>
													<td>
														<select class="in_wp120" id="sub_wbiz_tp_s_cd" name="sub_wbiz_tp_s_cd" data-parsley-required="true">
															<option value="${list.wbiz_tp_s_cd}">${list.wbiz_tp_s_cd_nm}</option>
														</select>
														<label for="sub_wbiz_tp_s_cd" class="hidden">주업종 4depth</label>
													</td>
													<td>
														<button class="btn" onclick="javascript:deleteCmpyDirCslfRow(this)" title="삭제">
															<img src="/images/web/common/btn_file_delete.png" alt="삭제" />
														</button>
													</td>
												</tr>
											</c:forEach>
											<tr id="emptyRow">
												<td colspan="5">
													<button class="btn" onclick="javascript:insertCmpyDirCslfRow()" title="추가">
														<img src="/images/web/common/btn_file_add.png" alt="추가" />
													</button>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<label for="empl_cnt">사원 수</label>									
								</th>
								<td class="last">
									<input type="text" class="in_w80" name="empl_cnt" id="empl_cnt" value="${cmpyDir.empl_cnt}" data-parsley-maxlength="10" data-parsley-type="integer" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<label for="url">홈페이지 주소</label>
								</th>
								<td class="last">
									<input type="text" class="in_w80" name="url" id="url"  value="${cmpyDir.url}" data-parsley-maxlength="300" data-parsley-type="url" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">회사 전화번호</th>
								<td class="last">
									<select id="tel_1" name="tel_1" class="in_wp100">	
										<option value="" <c:if test="${cmpyDir.tel_1 == ''}">selected="selected"</c:if>>-선택-</option>
										<option value="02" <c:if test="${cmpyDir.tel_1 == '02'}">selected="selected"</c:if>>02</option>
										<option value="031" <c:if test="${cmpyDir.tel_1 == '031'}">selected="selected"</c:if>>031</option>
										<option value="032" <c:if test="${cmpyDir.tel_1 == '032'}">selected="selected"</c:if>>032</option>
										<option value="033" <c:if test="${cmpyDir.tel_1 == '033'}">selected="selected"</c:if>>033</option>
										<option value="041" <c:if test="${cmpyDir.tel_1 == '041'}">selected="selected"</c:if>>041</option>
										<option value="042" <c:if test="${cmpyDir.tel_1 == '042'}">selected="selected"</c:if>>042</option>
										<option value="043" <c:if test="${cmpyDir.tel_1 == '043'}">selected="selected"</c:if>>043</option>
										<option value="051" <c:if test="${cmpyDir.tel_1 == '051'}">selected="selected"</c:if>>051</option>
										<option value="052" <c:if test="${cmpyDir.tel_1 == '052'}">selected="selected"</c:if>>052</option>
										<option value="053" <c:if test="${cmpyDir.tel_1 == '053'}">selected="selected"</c:if>>053</option>
										<option value="054" <c:if test="${cmpyDir.tel_1 == '054'}">selected="selected"</c:if>>054</option>
										<option value="055" <c:if test="${cmpyDir.tel_1 == '055'}">selected="selected"</c:if>>055</option>
										<option value="061" <c:if test="${cmpyDir.tel_1 == '061'}">selected="selected"</c:if>>061</option>
										<option value="062" <c:if test="${cmpyDir.tel_1 == '062'}">selected="selected"</c:if>>062</option>
										<option value="063" <c:if test="${cmpyDir.tel_1 == '063'}">selected="selected"</c:if>>063</option>
										<option value="064" <c:if test="${cmpyDir.tel_1 == '064'}">selected="selected"</c:if>>064</option>
										<option value="070" <c:if test="${cmpyDir.tel_1 == '070'}">selected="selected"</c:if>>070</option>
									</select>
									<label for="tel_1" class="hidden">회사 앞번호 선택</label> - 
									
									<label for="tel_2" class="hidden">회사 중간번호 입력</label>
									<input type="text" id="tel_2" name="tel_2" value="${cmpyDir.tel_2}" class="in_wp100" maxlength="4" data-parsley-type="number" /> - 
									
									<label for="tel_3" class="hidden">회사 뒷번호 입력</label>
									<input type="text" id="tel_3" name="tel_3" value="${cmpyDir.tel_3}" class="in_wp100" maxlength="4" data-parsley-type="number" />
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">회사 팩스번호</th>
								<td class="last">
									<select id="fax_1" name="fax_1" class="in_wp100">
										<option value="" <c:if test="${cmpyDir.fax_1 == ''}">selected="selected"</c:if>>-선택-</option>
										<option value="02" <c:if test="${cmpyDir.fax_1 == '02'}">selected="selected"</c:if>>02</option>
										<option value="031" <c:if test="${cmpyDir.fax_1 == '031'}">selected="selected"</c:if>>031</option>
										<option value="032" <c:if test="${cmpyDir.fax_1 == '032'}">selected="selected"</c:if>>032</option>
										<option value="033" <c:if test="${cmpyDir.fax_1 == '033'}">selected="selected"</c:if>>033</option>
										<option value="041" <c:if test="${cmpyDir.fax_1 == '041'}">selected="selected"</c:if>>041</option>
										<option value="042" <c:if test="${cmpyDir.fax_1 == '042'}">selected="selected"</c:if>>042</option>
										<option value="043" <c:if test="${cmpyDir.fax_1 == '043'}">selected="selected"</c:if>>043</option>
										<option value="051" <c:if test="${cmpyDir.fax_1 == '051'}">selected="selected"</c:if>>051</option>
										<option value="052" <c:if test="${cmpyDir.fax_1 == '052'}">selected="selected"</c:if>>052</option>
										<option value="053" <c:if test="${cmpyDir.tel_1 == '053'}">selected="selected"</c:if>>053</option>
										<option value="054" <c:if test="${cmpyDir.fax_1 == '054'}">selected="selected"</c:if>>054</option>
										<option value="055" <c:if test="${cmpyDir.fax_1 == '055'}">selected="selected"</c:if>>055</option>
										<option value="061" <c:if test="${cmpyDir.fax_1 == '061'}">selected="selected"</c:if>>061</option>
										<option value="062" <c:if test="${cmpyDir.fax_1 == '062'}">selected="selected"</c:if>>062</option>
										<option value="063" <c:if test="${cmpyDir.fax_1 == '063'}">selected="selected"</c:if>>063</option>
										<option value="064" <c:if test="${cmpyDir.fax_1 == '064'}">selected="selected"</c:if>>064</option>
										<option value="070" <c:if test="${cmpyDir.fax_1 == '070'}">selected="selected"</c:if>>070</option>
									</select>										
									<label for="fax_1" class="hidden">회사 팩스번호 앞번호 선택</label> - 
									
									<input type="text" id="fax_2" name="fax_2" value="${cmpyDir.fax_2}" class="in_wp100" maxlength="4" data-parsley-type="number" /> - 
									<label for="fax_2" class="hidden">회사 팩스번호 중간번호 입력</label>
									
									<input type="text" id="fax_3" name="fax_3" value="${cmpyDir.fax_3}" class="in_wp100" maxlength="4" data-parsley-type="number" />
									<label for="fax_3" class="hidden">회사 팩스번호 뒷번호 입력</label>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">회사 주소(국문)</th>
								<td class="last">
									<input type="text" name="post" id="post" value="${cmpyDir.post}" class="in_wp100"  maxlength="5" data-parsley-type="integer"/>
									<label for="post" class="hidden">주소 우편번호 찾기</label>
									<button class="btn basic" title="주소찾기" onclick="javascript:jusoPopupShow();">
										<span>주소찾기</span>
									</button>
									<div class="margint5">
										<input type="text" name="addr1" id="addr1" value="${cmpyDir.addr1}" class="in_w40" placeholder="기본주소" data-parsley-maxlength="300" />
										<label for="addr1" class="hidden">기본주소 입력</label>
										<input type="text" name="addr2" id="addr2" value="${cmpyDir.addr2}" class="in_w40" placeholder="상세주소" data-parsley-maxlength="300" />
										<label for="addr2" class="hidden">상세주소 입력</label>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">회사 주소(영문)</th>
								<td class="last">
									<input type="text" class="in_w40" name="addr1_en" id="addr1_en" value="${cmpyDir.addr1_en}" placeholder="기본주소" data-parsley-maxlength="300" />
									<label for="addr1_en" class="hidden">기본주소 입력</label>
									<input type="text" class="in_w40" name="addr2_en" id="addr2_en" value="${cmpyDir.addr2_en}" placeholder="상세주소" data-parsley-maxlength="300" />
									<label for="addr2_en" class="hidden">상세주소 입력</label>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<label for="kor_logo">회사 로고(국문)</label>
								</th>
								<td class="last">
									<label for="file_id" class="hidden">파일 선택하기</label>
									<input id="file_id" name="file_id" type="file" class="in_w100" />
									<c:if test="${not empty cmpyDir.logo_file_nm}">
									<div class="file_area">
										<ul class="file_list">
											<li>					
												<a href="/commonfile/fileidDownLoad.do?file_id=${cmpyDir.logo_file_id}" target="_blank" class="download" title="다운받기">${cmpyDir.logo_file_nm}</a> 
												<a href="javascript:;" class="btn_file_delete" data-file_id="${cmpyDir.logo_file_id}" title="파일 삭제"> 
													<img src="/images/admin/icon/icon_delete.png" alt="삭제" />
												</a>
											</li>
										</ul>
									</div>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">
									<label for="eng_logo">회사 로고(영문)</label>
								</th>
								<td class="last">
									<label for="file_id_en" class="hidden">파일 선택하기</label>
									<input id="file_id_en" name="file_id_en" type="file" class="in_w100" />
									<c:if test="${not empty cmpyDir.logo_file_nm_en}">
									<div class="file_area">
										<ul class="file_list">
											<li>
												<a href="/commonfile/fileidDownLoad.do?file_id=${cmpyDir.logo_file_id_en}" target="_blank" class="download" title="다운받기">${cmpyDir.logo_file_nm_en}</a> 
												<a href="javascript:;" class="btn_file_delete" data-file_id="${cmpyDir.logo_file_id_en}" title="파일 삭제"> 
													<img src="/images/admin/icon/icon_delete.png" alt="삭제" />
												</a>
											</li>
										</ul>
									</div>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row" class="first">공개여부</th>
								<td class="last">
									<input type="radio" id="opn_yn_y" name="opn_yn" value="Y" class="" <c:if test="${cmpyDir.opn_yn eq 'Y'}">checked="checked"</c:if> />
									<label for="opn_yn_y" class="marginr10">공개</label>
									<input type="radio" id="opn_yn_n" name="opn_yn" value="N" class="marginl10" <c:if test="${cmpyDir.opn_yn ne 'Y'}">checked="checked"</c:if> />
									<label for="opn_yn_n" >비공개</label>
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<!--// dtable_area -->
					
				</div>
				<!--// pop_content -->
				
			</div>
		</article>	
		</div>
		<!-- //container -->
		
		<!-- footer --> 
		<div id="pop_footer">
		<footer>
		
			<!-- dbutton_area -->
			<div class="dbutton_area alignr marginr10">
				<button class="btn save" title="수정" onClick="javascript:updateCmpyDir()">
					<span>수정</span>
				</button>
				<button class="btn cancel" title="취소" onClick="javascript:popupClose()">
					<span>취소</span>
				</button>
			</div>
			<!--// dbutton_area -->
			
		</footer>
		</div>
		<!-- //footer -->
	</div>

</form>

 <jsp:include page="/WEB-INF/jsp/common/jusoSearchPopup.jsp"/>
