<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">

$( document ).ready( function(){
	
	// 물산업 불류 콤보 이벤트
	$( '#inds_tp' ).bind( 'change' , function(){
		loadWbizTypeCode( 'L', $( '#wbiz_tp_l' ) );			
	});
	
	$( '#wbiz_tp_l' ).bind( 'change' , function(){
		loadWbizTypeCode( 'M', $( '#wbiz_tp_m' ) );			
	});
	
	$( '#wbiz_tp_m' ).bind( 'change' , function(){
		loadWbizTypeCode( 'S', $( '#wbiz_tp_s' ) );			
	});

// 	$('#cmpyDirPrdtTable > tbody').on( 'click', 'tr', function () {	
// 		if($(this).attr("id") == null){
// 			seletedCmpyDirPrdtRow( $(this) );
// 		}
// 	} );
	
	
	$( 'input[name=inds_tp]' ).eq(0).click();
	$( '#inds_tp' ).change();

	setRowEvent();
	showInitBtn();
});	

function setRowEvent() {
	$('a[name=selectRow]').on( 'click', function () {
		var tr = $(this).parents('tr');
		seletedCmpyDirPrdtRow( tr );
	} );
} 

function showInsert() {
	cancelCmpyDirPrdtRow();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

var selectedRow = null;

function seletedCmpyDirPrdtRow(row){
	showUpdateBtn();
	selectedRow = row; 
	$("#inds_tp").val(selectedRow.find("input[id='inds_tp_cd']").val());
	
	loadWbizTypeCode( 'L', $( '#wbiz_tp_l' ), null, selectedRow.find("input[id='wbiz_tp_l_cd']").val() );			
	loadWbizTypeCode( 'M', $( '#wbiz_tp_m' ), null, selectedRow.find("input[id='wbiz_tp_m_cd']").val() );			
	loadWbizTypeCode( 'S', $( '#wbiz_tp_s' ), null, selectedRow.find("input[id='wbiz_tp_s_cd']").val() );			
	
	$("#nm").val(selectedRow.find("input[id='prdt_nm']").val());
	$("#nm_en").val(selectedRow.find("input[id='prdt_nm_en']").val());

	$("#cmpyDirPrdtFormRow").parsley().reset();
	$('#dataRowTitleDiv').css('display','');
	$('#dataRowTableDiv').css('display','');
}

function insertCmpyDirPrdtRow(){

	if ( $("#cmpyDirPrdtFormRow").parsley().validate() ){
		
		var inds_tp_cd = $("#inds_tp").val();
		var inds_tp_cd_nm = $("#inds_tp option:selected").text();
		
		var wbiz_tp_l_cd = $("#wbiz_tp_l").val();
		var wbiz_tp_l_cd_nm = $("#wbiz_tp_l option:selected").text();
		
		var wbiz_tp_m_cd = $("#wbiz_tp_m").val();
		var wbiz_tp_m_cd_nm = $("#wbiz_tp_m option:selected").text();
		
		var wbiz_tp_s_cd = $("#wbiz_tp_s").val();
		var wbiz_tp_s_cd_nm = $("#wbiz_tp_s option:selected").text();
		
		var prdt_nm = $("#nm").val();
		var prdt_nm_en = $("#nm_en").val();
		
		var str = "";

		str += '<tr>';
		str += '	<td id="wbiz_tp_l_cd_label" class="first alignc">' + wbiz_tp_l_cd_nm + '</td>';
		str += '	<td id="wbiz_tp_m_cd_label" class="alignc">' + wbiz_tp_m_cd_nm + '</td>';
		str += '	<td id="wbiz_tp_s_cd_label" class="alignc">' + wbiz_tp_s_cd_nm + '</td>';
		str += '	<td id="prdt_nm_label" class="last">' + prdt_nm + '</td>';
		str += '	<input type="hidden" id="inds_tp_cd" name="inds_tp_cd" value="' + inds_tp_cd + '" />';
		str += '	<input type="hidden" id="wbiz_tp_l_cd" name="wbiz_tp_l_cd" value="' + wbiz_tp_l_cd + '" />';
		str += '	<input type="hidden" id="wbiz_tp_m_cd" name="wbiz_tp_m_cd" value="' + wbiz_tp_m_cd + '" />';
		str += '	<input type="hidden" id="wbiz_tp_s_cd" name="wbiz_tp_s_cd" value="' + wbiz_tp_s_cd + '" />';
		str += '	<input type="hidden" id="prdt_nm" name="prdt_nm" value="' + prdt_nm + '" />';
		str += '	<input type="hidden" id="prdt_nm_en" name="prdt_nm_en" value="' + prdt_nm_en + '" />';
		str += '</tr>';
		
		$('#cmpyDirPrdtTable > tbody:last').append(str);		

		if($("#emptyRow") != null){
			$("#emptyRow").remove();
		}
		
// 		cancelCmpyDirPrdtRow();
		updateCmpyDirPrdt();
	}
}

function updateCmpyDirPrdtRow(){

	if ( $("#cmpyDirPrdtFormRow").parsley().validate() ){
		
		if(selectedRow != null && selectedRow.attr("id") == null){
			
			var inds_tp_cd = $("#inds_tp").val();
			var inds_tp_cd_nm = $("#inds_tp option:selected").text();
			
			var wbiz_tp_l_cd = $("#wbiz_tp_l").val();
			var wbiz_tp_l_cd_nm = $("#wbiz_tp_l option:selected").text();
			
			var wbiz_tp_m_cd = $("#wbiz_tp_m").val();
			var wbiz_tp_m_cd_nm = $("#wbiz_tp_m option:selected").text();
			
			var wbiz_tp_s_cd = $("#wbiz_tp_s").val();
			var wbiz_tp_s_cd_nm = $("#wbiz_tp_s option:selected").text();
			var prdt_nm = $("#nm").val();
			var prdt_nm_en = $("#nm_en").val();

			selectedRow.find("td[id='wbiz_tp_l_cd_label']").html(wbiz_tp_l_cd_nm);
			selectedRow.find("td[id='wbiz_tp_m_cd_label']").html(wbiz_tp_m_cd_nm);
			selectedRow.find("td[id='wbiz_tp_s_cd_label']").html(wbiz_tp_s_cd_nm);
			selectedRow.find("td[id='prdt_nm_label']").html(prdt_nm);
			selectedRow.find("input[id='inds_tp_cd']").val(inds_tp_cd);
			selectedRow.find("input[id='wbiz_tp_l_cd']").val(wbiz_tp_l_cd);
			selectedRow.find("input[id='wbiz_tp_m_cd']").val(wbiz_tp_m_cd);
			selectedRow.find("input[id='wbiz_tp_s_cd']").val(wbiz_tp_s_cd);
			selectedRow.find("input[id='prdt_nm']").val(prdt_nm);
			selectedRow.find("input[id='prdt_nm_en']").val(prdt_nm_en);
			
			updateCmpyDirPrdt();
		}
	}
}

function deleteCmpyDirPrdtRow(){
	
	if(selectedRow != null && selectedRow.attr("id") == null){
		
		selectedRow.remove();
		selectedRow = null;
		
		if($('#cmpyDirPrdtTable > tbody').children().length == 0 ){
			
			var str = "";

			str += '<tr id="emptyRow">';
			str += '	<td colspan="4" class="first alignc last">등록된 주요제품 및 기술현황이 없습니다.</td>';
			str += '</tr>';
			
			$('#cmpyDirPrdtTable > tbody:last').append(str);	
		}
// 		cancelCmpyDirPrdtRow();
		updateCmpyDirPrdt();
	}
}

function cancelCmpyDirPrdtRow(){
	showInsertBtn();
	$("#inds_tp option:eq(0)").prop("selected", true);
	$("#wbiz_tp_l option:eq(0)").prop("selected", true);
	$("#wbiz_tp_m option:eq(0)").prop("selected", true);
	$("#wbiz_tp_s option:eq(0)").prop("selected", true);
	$("#nm").val('');
	$("#nm_en").val('');
	selectedRow = null;
	$("#cmpyDirPrdtFormRow").parsley().reset();
}

function loadWbizTypeCode( _tp, _obj, _pref, _objValue ){
	if(_pref == null || _pref == undefined) {
		_pref = '';
	}
	
	if( _tp == 'L' ){
		$( '#'+_pref+'wbiz_tp_l' ).html( '<option value="">1Depth</option>' );
		$( '#'+_pref+'wbiz_tp_m' ).html( '<option value="">2Depth</option>' );			
		$( '#'+_pref+'wbiz_tp_s' ).html( '<option value="">3Depth</option>' );
		
		if(_obj == null) _obj = $( '#'+_pref+'wbiz_tp_l' );
		
	}else if( _tp == 'M' ){
		$( '#'+_pref+'wbiz_tp_m' ).html( '<option value="">2Depth</option>' );			
		$( '#'+_pref+'wbiz_tp_s' ).html( '<option value="">3Depth</option>' );
		
		if(_obj == null) _obj = $( '#'+_pref+'wbiz_tp_m' );
		
	}else if( _tp == 'S' ){
		$( '#'+_pref+'wbiz_tp_s' ).html( '<option value="">3Depth</option>' );
		
		if(_obj == null) _obj = $( '#'+_pref+'wbiz_tp_s' );
	}
	
	 $.ajax({
        url: "/web/wbiz/categoryLoad.do",
        dataType: "json",
        type: "post",
        data: {	           
        	inds_tp_cd : $( '#'+_pref+'inds_tp' ).val() ,
        	wbiz_tp_l_cd : $( '#'+_pref+'wbiz_tp_l' ).val() , 
        	wbiz_tp_m_cd : $( '#'+_pref+'wbiz_tp_m' ).val() ,	        	
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
    		}else if(_obj != null) {
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

</script>

<div id="wrap">

	<!-- header -->
	<div id="pop_header">
	<header>
		<h1 class="pop_title">주요제품 및 기술현황</h1>
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
				<!-- division -->
				
				<div class="division">
					<!-- dtitle_area -->					

					<form id="cmpyDirPrdtForm" name="cmpyDirPrdtForm" method="post" onsubmit="return false;">
						
						<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
					
						<div class="dtitle_area">
							<div class="float_left padt5">
								<h2 class="title">주요제품 및 기술현황</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div class="dtable_area">
							<table id="cmpyDirPrdtTable" class="dtable" style="min-width: 500px">
								<caption>주요제품 및 기술현황 목록 화면</caption>
								<colgroup>
									<col style="width: 20%;" />
									<col style="width: 20%;" />
									<col style="width: 20%;" />
									<col style="width: *;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col" class="first">대분류</th>
									<th scope="col">중분류</th>
									<th scope="col">세분류</th>
									<th scope="col" class="last">세부 제품명</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach items="${cmpyDirPrdtList}" var="list">	
										<tr>
											<td id="wbiz_tp_l_cd_label" class="first alignc">${list.wbiz_tp_l_cd_nm}</td>
											<td id="wbiz_tp_m_cd_label" class="alignc">${list.wbiz_tp_m_cd_nm}</td>							
											<td id="wbiz_tp_s_cd_label" class="alignc">${list.wbiz_tp_s_cd_nm}</td>
											<td id="prdt_nm_label" class="last"><a title="인증상세" href="#" id="selectRow" name="selectRow">${list.prdt_nm}</a></td>
											<input type="hidden" id="inds_tp_cd" name="inds_tp_cd" value="${list.inds_tp_cd}" />
											<input type="hidden" id="wbiz_tp_l_cd" name="wbiz_tp_l_cd" value="${list.wbiz_tp_l_cd}" />
											<input type="hidden" id="wbiz_tp_m_cd" name="wbiz_tp_m_cd" value="${list.wbiz_tp_m_cd}" />
											<input type="hidden" id="wbiz_tp_s_cd" name="wbiz_tp_s_cd" value="${list.wbiz_tp_s_cd}" />
											<input type="hidden" id="prdt_nm" name="prdt_nm" value="${list.prdt_nm}" />
											<input type="hidden" id="prdt_nm_en" name="prdt_nm_en" value="${list.prdt_nm_en}" />
										</tr>
									</c:forEach>					
									<c:if test="${empty cmpyDirPrdtList}">
										<tr id="emptyRow">
											<td colspan="4" class="first alignc last">등록된 주요제품 및 기술현황이 없습니다.</td>
										</tr>	
									</c:if>
								</tbody>
							</table>
						</div>
						<!--// dtable_area -->
						
					</form>
					
					<!-- button_area -->
					<div class="button_area">
						<div class="alignr">
							<button id="btn_save" class="btn save" title="추가" onClick="javascript:showInsert()">
								<span>추가</span>
							</button>		
						</div>
					</div>
					<!--// button_area -->
					
				</div>
				<!--// division -->
				
				<!-- division -->
				<div class="division">
						<!-- dtitle_area -->
						<div id="dataRowTitleDiv" class="dtitle_area" style="display: none">
							<div class="float_left padt5">
								<h2 class="title">주요제품 및 기술현황 등록/수정</h2>
							</div>
						</div>
						<!--// dtitle_area -->
						
						<!-- dtable_area -->
						<div id="dataRowTableDiv" class="dtable_area" style="display: none">
							<form id="cmpyDirPrdtFormRow" name="cmpyDirPrdtFormRow" method="post" onsubmit="return false;">
							<table class="dtable">
								<caption>주요제품 및 기술현황 등록/수정 화면</caption>
								<colgroup>
									<col style="width: 200px;" />
									<col style="width: *;" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" class="first">
										<strong class="color_pointr">*</strong>물산업분류
									</th>
									<td class="last">
									
										<label for="inds_tp" class="hidden">물산업분류 선택</label>
										<g:select class="in_wp120" id="inds_tp" name="inds_tp" codeGroup="INDS_TP_CD" cls="form-control" data-parsley-errors-container="#errMsgManagerwbiz" data-parsley-required="true" />  	
										
										<label for="wbiz_tp_l" class="hidden">물산업분류 1뎁스 선택</label>
										<select id="wbiz_tp_l" name="wbiz_tp_l" class="in_wp100" data-parsley-errors-container="#errMsgManagerwbiz" data-parsley-required="true">
											<option value="">1Depth</option>
										</select>
										
										<label for="wbiz_tp_m" class="hidden">물산업분류 2뎁스 선택</label>
										<select id="wbiz_tp_m" name="wbiz_tp_m" class="in_wp100" data-parsley-errors-container="#errMsgManagerwbiz" data-parsley-required="true">
											<option value="">2Depth</option>
										</select>
										
										<label for="wbiz_tp_s" class="hidden">물산업분류 3뎁스 선택</label>
										<select id="wbiz_tp_s" name="wbiz_tp_s" class="in_wp100" data-parsley-errors-container="#errMsgManagerwbiz" data-parsley-required="true">
											<option value="">3Depth</option>
										</select>
										<div class="parsely-single-error" id="errMsgManagerwbiz" />
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="nm">
											<strong class="color_pointr">*</strong>세부 제품명(국문)
										</label>
									</th>
									<td class="last">
										<input type="text" id="nm" name="nm" class="in_w100" data-parsley-maxlength="300" data-parsley-required="true"/>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="nm_en">
											<strong class="color_pointr">*</strong>세부 제품명(영문)
										</label>
									</th>
									<td class="last">
										<input type="text" id="nm_en" name="nm_en" class="in_w100" data-parsley-maxlength="300" data-parsley-required="true"/>
									</td>
								</tr>
								</tbody>
							</table>
							</form>
						</div>
						<!--// dtable_area -->
						
					
					
					<!-- button_area -->
					<div id="sub_btn" class="button_area">
						<div class="alignr">
							<button class="btn save" title="저장" onClick="javascript:insertCmpyDirPrdtRow()">
								<span>저장</span>
							</button>
							<button class="btn save" title="수정" onClick="javascript:updateCmpyDirPrdtRow()">
								<span>수정</span>
							</button>
							<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDirPrdtRow()">
								<span>삭제</span>
							</button>
							<button class="btn cancel" title="취소" onClick="javascript:cancel()">
								<span>취소</span>
							</button>		
						</div>
					</div>
					<!--// button_area -->
					
					<!-- button_area -->
					<div class="button_area" style="display: none">
						<div class="alignr">
							<button class="btn save" title="저장" onClick="javascript:updateCmpyDirPrdt()">
								<span>저장</span>
							</button>
							<button class="btn cancel" title="취소" onClick="javascript:popupClose()">
								<span>취소</span>
							</button>		
						</div>
					</div>
					<!--// button_area -->
					
				</div>
				<!--// division -->
				
			</div>
			<!--// pop_content -->
			
		</div>
	</article>	
	</div>
	<!-- //container -->
</div>