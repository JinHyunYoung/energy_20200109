<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<form id="writeFrm" name="writeFrm" method="post" data-parsley-validate="true">
	
	<input type="hidden" name="wbix_clsf_sn" value="${category.wbix_clsf_sn}" />
	<c:if test="${param.mode == 'E'}">
	<input type="hidden" name="wbiz_tp_l_cd" value="${category.wbiz_tp_l_cd}" />
	<input type="hidden" name="wbiz_tp_m_cd" value="${category.wbiz_tp_m_cd}" />
	<input type="hidden" name="wbiz_tp_s_cd" value="${category.wbiz_tp_s_cd}" />
	<input type="hidden" name="wbiz_cd_tp" value="${category.wbiz_cd_tp}" />			
	</c:if>
	
	
	<!-- write_basic -->
	<div class="table_area" style="margin-top:10px;padding-left:10px;padding-right:10px;">
	
		<table class="write">
			<caption>물산업분류 등록/수정</caption>
			<colgroup>
				<col style="width: 120px;" />
				<col style="width: *;" />
			</colgroup>
			<tbody>			
			<c:if test="${param.mode == 'E'}">	
			<tr>
				<th scope="row">분류코드 <span class="asterisk">*</span></th>
				<td>
					<c:choose>
						<c:when test="${ category.wbiz_cd_tp == 'L' }">${category.wbiz_tp_l_cd}</c:when>
						<c:when test="${ category.wbiz_cd_tp == 'M' }">${category.wbiz_tp_m_cd}</c:when>
						<c:when test="${ category.wbiz_cd_tp == 'S' }">${category.wbiz_tp_s_cd}</c:when>
					</c:choose>				    
				</td>
			</tr>
			</c:if>
			<tr>
				<th scope="row">업종구분  <span class="asterisk">*</span></th>
				<td>
					<c:if test="${param.mode == 'E'}">
					<c:forEach var="item" items="${indsTypeCodeList}">
						<c:if test="${ item.code == category.inds_tp_cd }">
							${item.code_nm}
						</c:if> 						
 					</c:forEach>
					</c:if>
					<c:if test="${param.mode == 'W'}">
 					<select class="in_wp120" name="inds_tp_cd" id="inds_tp_cd">
 					<c:forEach var="item" items="${indsTypeCodeList}">
 						<option value="${item.code}" <c:if test="${ ! empty( category.inds_tp_cd ) && category.inds_tp_cd == item.code }">checked="checked"</c:if>>${item.code_nm}</option>
 					</c:forEach>
 					</select>
 					</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">분류구분  <span class="asterisk">*</span></th>
				<td>
				<c:if test="${param.mode == 'E'}">
					<c:choose>
						<c:when test="${ category.wbiz_cd_tp == 'L' }">대분류</c:when>
						<c:when test="${ category.wbiz_cd_tp == 'M' }">중분류</c:when>
						<c:when test="${ category.wbiz_cd_tp == 'S' }">소분류</c:when>
					</c:choose>		
				</c:if>
				<c:if test="${param.mode == 'W'}">			
 					<input type="radio" id="wbiz_cd_tp_01" name="wbiz_cd_tp" value="L" checked="checked" />
					<label for="wbiz_cd_tp_01">대분류</label>
					<input type="radio" id="wbiz_cd_tp_02" name="wbiz_cd_tp" value="M" />
					<label for="wbiz_cd_tp_02">중분류</label>
					<input type="radio" id="wbiz_cd_tp_03" name="wbiz_cd_tp" value="S" />
					<label for="wbiz_cd_tp_03">소분류</label>				
				</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">분류선택  <span class="asterisk">*</span></th>
				<td>
					<c:if test="${param.mode == 'W'}">			
 					<select class="in_wp120" id="wbiz_tp_l_cd" name="wbiz_tp_l_cd">
						<option value="">선택</option>
					</select>
					<label for="wbiz_tp_l_cd" class="hidden">대분류 선택</label>
					<select class="in_wp120" id="wbiz_tp_m_cd" name="wbiz_tp_m_cd">
						<option value="">선택</option>
					</select>
					<label for="wbiz_tp_m_cd" class="hidden">중분류 선택</label>
					</c:if>
					<c:if test="${param.mode == 'E'}">
						<c:choose>
							<c:when test="${ category.wbiz_cd_tp == 'L' }">${category.wbiz_tp_l_nm}</c:when>
						<c:when test="${ category.wbiz_cd_tp == 'M' }">${category.wbiz_tp_l_nm}&nbsp;>&nbsp;${category.wbiz_tp_m_nm}</c:when>
						<c:when test="${ category.wbiz_cd_tp == 'S' }">${category.wbiz_tp_l_nm}&nbsp;>&nbsp;${category.wbiz_tp_m_nm}&nbsp;>&nbsp;${category.wbiz_tp_s_nm}</c:when>
						</c:choose>			
					</c:if>					
				</td>
			</tr>
			<c:if test="${param.mode == 'W'}">			
			<tr>
				<th scope="row">분류코드 <span class="asterisk">*</span></th>
				<td>
 					<input type="text" name="wbiz_tp_cd" id="wbiz_tp_cd" class="in_wp120" maxlength="20" data-parsley-required="true" data-parsley-maxlength="20" />
				</td>
			</tr>
			</c:if>
			<tr>
				<th scope="row">분류명(국문) <span class="asterisk">*</span></th>
				<td>
			         <input type="text" name="wbiz_clsf_nm" id="wbiz_clsf_nm" value="${category.wbiz_clsf_nm}" class="in_w98" data-parsley-required="true" data-parsley-maxlength="100" />
				</td>
			</tr>
			<tr>
				<th scope="row">분류명(영문) <span class="asterisk">*</span></th>
				<td>
			         <input type="text" name="wbiz_clsf_nm_en" id="wbiz_clsf_nm_en" value="${category.wbiz_clsf_nm_en}" class="in_w98" data-parsley-required="true" data-parsley-maxlength="100" />
				</td>
			</tr>
			<tr>
				<th scope="row">사용여부 <span class="asterisk">*</span></th>
				<td>
			        <input type="radio" id="use_yn_01" name="use_yn" value="Y" <c:if test="${ category.use_yn == 'Y' }">checked="checked"</c:if> />
					<label for="use_yn_01" class="marginr10">사용</label>
					<input type="radio" id="use_yn_02" name="use_yn" value="N" <c:if test="${ category.use_yn == 'N' }">checked="checked"</c:if> />
					<label for="use_yn_02">미사용</label>
				</td>
			</tr>													
			</tbody>
		</table>
	</div>
	<!--// write_basic -->
	
	<!-- footer --> 
	<div id="footer">
		<footer>
			<div class="button_area alignc">
			   <c:if test="${param.mode == 'W'}">
				<a href="javascript:categoryInsert()" class="btn save" title="등록">
					<span>등록</span>
				</a>
			  </c:if>
	          <c:if test="${param.mode == 'E' }">
	           	<a href="javascript:categoryModify()" class="btn save" title="수정">
					<span>수정</span>
				</a>
				<a href="javascript:categoryDelete()" class="btn save" title="삭제">
					<span>삭제</span>
				</a>
				</c:if>
				<a href="javascript:popupClose()" class="btn cancel" title="닫기">
					<span>취소</span>
				</a>
			</div>
		</footer>
	</div>
	<!-- //footer -->                  
</form>

<script type="text/javascript">
	
	$( document ).ready( function(){
		
		$( '#inds_tp_cd' ).bind( 'change' , function(){
			loadWbizTypeCode( 'L' );			
		});
		
		$( '#wbiz_tp_l_cd' ).bind( 'change' , function(){
			loadWbizTypeCode( 'M' );			
		});
		
		$( 'input[name=wbiz_cd_tp]' ).bind( 'click' , function(){
			if( $( this ).val() == 'L' ){
				$( '#wbiz_tp_l_cd' ).css( { display : 'none' } );
				$( '#wbiz_tp_m_cd' ).css( { display : 'none' } );
			}else if( $( this ).val() == 'M' ){
				$( '#wbiz_tp_l_cd' ).css( { display : '' } );
				$( '#wbiz_tp_m_cd' ).css( { display : 'none' } );				
			}else if( $( this ).val() == 'S' ){
				$( '#wbiz_tp_l_cd' ).css( { display : '' } );
				$( '#wbiz_tp_m_cd' ).css( { display : '' } );				
			}
		}); 
		$( 'input[name=wbiz_cd_tp]' ).eq(0).click();
		$( '#inds_tp_cd' ).change();
		
		
	});
	
	function categoryModify(){
		
		if( ! confirm( "물산업분류를 수정하시겠습니까?" ) ) return false;
		
		if( $("#writeFrm").parsley().validate() ){
			$.ajax({
		        url: categoryUpdateUrl ,
		        dataType: 'json' ,
		        type: 'post' ,
		        data: jQuery("#writeFrm").serialize() ,
		        success: function( data ){
		        	if( data.success == 'true' ){
		        		alert( "물산업분류 수정을 성공하였습니다." );	  
		        		categorySelect();
		        		popupClose();
		        	}else if( data.success == 'false' ){
		        		alert( "물산업분류 수정을 실패하였습니다." );
		        	}
		        },
		        error: function(e) {
		            alert( "물산업분류를 수정하는데 실패하였습니다." );
		        }
		    });
		}		
	}
	
	function categoryDelete(){
		
		if( ! confirm( "물산업분류를 삭제하시겠습니까?" ) ) return false;		
		
		$.ajax({
	        url: categoryDeleteUrl ,
	        dataType: 'json' ,
	        type: 'post' ,
	        data: jQuery("#writeFrm").serialize() ,
	        success: function( data ){
	        	if( data.success == 'true' ){
	        		alert( "물산업분류 삭제를 성공하였습니다." );	  
	        		categorySelect();
	        		popupClose();
	        	}else if( data.success == 'false' ){
	        		alert( "물산업분류 삭제를 실패하였습니다." );
	        	}
	        },
	        error: function(e) {
	            alert( "물산업분류를 삭제하는데 실패하였습니다." );
	        }
	    });	
	}
	
	function categoryInsert(){
		
		if( ! confirm( "물산업분류를 등록하시겠습니까?" ) ) return false;
		
		$( '#wbiz_tp_l_cd' ).attr( 'data-parsley-required' , 'false' );
		$( '#wbiz_tp_m_cd' ).attr( 'data-parsley-required' , 'false' );
		
		if( $( '#wbiz_cd_tp_02' ).get(0).checked  ){
			$( '#wbiz_tp_l_cd' ).attr( 'data-parsley-required' , 'true' );
		}
		
		if( $( '#wbiz_cd_tp_03' ).get(0).checked  ){
			$( '#wbiz_tp_l_cd' ).attr( 'data-parsley-required' , 'true' );
			$( '#wbiz_tp_m_cd' ).attr( 'data-parsley-required' , 'true' );
		}		
		
		if( $("#writeFrm").parsley().validate() ){
			$.ajax({
		        url: categoryInsertUrl ,
		        dataType: 'json' ,
		        type: 'post' ,
		        data: jQuery("#writeFrm").serialize() ,
		        success: function( data ){
		        	if( data.success == 'true' ){
		        		alert( "물산업분류 등록을 성공하였습니다." );
		        		categorySelect();
		        		popupClose();
		        	}else if( data.success == 'false' ){
		        		alert( "물산업분류 등록을 실패하였습니다." );
		        	}
		        },
		        error: function(e) {
		            alert( "물산업분류를 등록하는데 실패하였습니다." );
		        }
		    });
		}
		
	}
	
	function loadWbizTypeCode( _tp ){		
		
		if( _tp == 'L' ){
			$( '#wbiz_tp_l_cd' ).html( '<option value=""> 선택</option>' );
			$( '#wbiz_tp_m_cd' ).html( '<option value=""> 선택</option>' );			
		}else if( _tp == 'M' ){
			$( '#wbiz_tp_m_cd' ).html( '<option value=""> 선택</option>' );			
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
	        			}
	        		}        		
	        	}
	        	if( _tp == 'L' ){
        			$( '#wbiz_tp_l_cd' ).html( _option );
        		}else if( _tp == 'M' ){
        			$( '#wbiz_tp_m_cd' ).html( _option );
        		}
	        },
	        error: function(e) {
	            alert( '데이터를 가져오는데 실패했습니다.' );
	        }
	    });		
		
	}
	

</script>