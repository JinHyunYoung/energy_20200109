<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
$(document).ready(function(){
	// 물산업 불류 콤보 이벤트
	$( '#wbiz_tp_l_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'M' );			
	});
	
	$( '#wbiz_tp_m_cd' ).bind( 'change' , function(){
		loadWbizTypeCode( 'S' );			
	});
});

function loadWbizTypeCode( _tp ){	
	
	var lang = $('#lang').val();
	
	if( _tp == 'M' ){
		$( '#wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' );			
		$( '#wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );
	} else if( _tp == 'S' ){
		$( '#wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' );			
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
        	
        	var _option = '';
        	if( data.list != null && data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
        			if( _tp == 'M' && lang == 'en' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_m_cd + '">' + data.list[i].wbiz_clsf_nm_en + '</option>';
        			}
        			else if( _tp == 'M' && lang != 'en' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_m_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        			else if( _tp == 'S' && lang == 'en' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_s_cd + '">' + data.list[i].wbiz_clsf_nm_en + '</option>';
        			}
        			else if( _tp == 'S' && lang != 'en' ){
        				_option += '<option value="' + data.list[i].wbiz_tp_s_cd + '">' + data.list[i].wbiz_clsf_nm + '</option>';
        			}
        		}        		
        	}
        	
        	if( _tp == 'M' ){
    			$( '#wbiz_tp_m_cd' ).html( '<option value="">2Depth</option>' + _option );
    		}
    		else if( _tp == 'S' ){
    			$( '#wbiz_tp_s_cd' ).html( '<option value="">3Depth</option>' + _option );
    		}
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
	});	
}
</script>

<!-- table_top_area -->	
<div class="table_top_area">

	<div class="table_top_left">
	    <p><strong class="table_count">${totalcnt}</strong>건</p>
	</div>
             
    <div class="table_top_right">
    	<label for="wbiz_tp_l_cd" class="hidden">1Depth</label>
        <select id="wbiz_tp_l_cd" name="wbiz_tp_l_cd" class="in_wp100">
            <option value="">1Depth</option>
            <c:forEach items="${wbiz_tp_l_category}" var="list">
            	<c:if test="${param.lang eq 'en' }">
					<option value="${list.wbiz_tp_l_cd}" <c:if test="${param.wbiz_tp_l_cd == list.wbiz_tp_l_cd}">selected</c:if> >${list.wbiz_clsf_nm_en}</option>
				</c:if>	
				<c:if test="${param.lang ne 'en' }">
					<option value="${list.wbiz_tp_l_cd}" <c:if test="${param.wbiz_tp_l_cd == list.wbiz_tp_l_cd}">selected</c:if> >${list.wbiz_clsf_nm}</option>
				</c:if>	
            	
            </c:forEach>		
        </select>
        
    	<label for="wbiz_tp_m_cd" class="hidden">2Depth</label>
        <select id="wbiz_tp_m_cd" name="wbiz_tp_m_cd" class="in_wp100">
            <option value="">2Depth</option>
            <c:forEach items="${wbiz_tp_m_category}" var="list">
            	<c:if test="${param.lang eq 'en' }">
					<option value="${list.wbiz_tp_m_cd}" <c:if test="${param.wbiz_tp_m_cd == list.wbiz_tp_m_cd}">selected</c:if> >${list.wbiz_clsf_nm_en}</option>
				</c:if>	
				<c:if test="${param.lang ne 'en' }">
					<option value="${list.wbiz_tp_m_cd}" <c:if test="${param.wbiz_tp_m_cd == list.wbiz_tp_m_cd}">selected</c:if> >${list.wbiz_clsf_nm}</option>
				</c:if>	
            	
            </c:forEach>
        </select>
        
    	<label for="wbiz_tp_s_cd" class="hidden">3Depth</label>
        <select id="wbiz_tp_s_cd" name="wbiz_tp_s_cd" class="in_wp100">
            <option value="">3Depth</option>
            <c:forEach items="${wbiz_tp_s_category}" var="list">
            	<c:if test="${param.lang eq 'en' }">
					<option value="${list.wbiz_tp_s_cd}" <c:if test="${param.wbiz_tp_s_cd == list.wbiz_tp_s_cd}">selected</c:if> >${list.wbiz_clsf_nm_en}</option>
				</c:if>	
				<c:if test="${param.lang ne 'en' }">
					<option value="${list.wbiz_tp_s_cd}" <c:if test="${param.wbiz_tp_s_cd == list.wbiz_tp_s_cd}">selected</c:if> >${list.wbiz_clsf_nm}</option>
				</c:if>	
            </c:forEach>
        </select>
        
        <label for="cmpy_nm" class="hidden">검색</label>
        <input id="cmpy_nm" type="text" name="cmpy_nm" class="in_wp200" value="${param.cmpy_nm}" />
        
        <button class="btn table_search" title="검색" onclick="search();">
			<c:if test="${param.lang eq 'en' }">
			<span>Search</span>
			</c:if>	
			<c:if test="${param.lang ne 'en' }">
			<span>검색</span>
			</c:if>	
        </button>
    </div>
    
</div>
<!--// table_top_area -->
         
<!-- table_area -->  		          	
<div class="table_area">

    <ul class="directory_list">
    
		<c:forEach items="${cmpyDirList}" var="list">		
		
	    	<!-- list_row -->
	    	<li>
	    		<a href="javascript:goCmpyDir('${list.dir_sn}')" title="${list.cmpy_nm}">
	    			<div class="directory_info">	    			
	    			
						<c:if test="${not empty list.logo_file_id}">
							<img src="/contents/directory/${list.logo_file_nm}" alt="기업로고" />
						</c:if>
						<c:if test="${empty list.logo_file_id}">
							<img src="/images/web/sub/directory/none_img.png" alt="이미지 없음" />
						</c:if>
				
	    				<strong class="title">${list.cmpy_nm}</strong>
	    				<div class="directory_sort">
	    					<span>${list.wbiz_tp_l_cd_nm}</span>
	    					<span>${list.wbiz_tp_m_cd_nm}</span>
	    					<span>${list.wbiz_tp_s_cd_nm}</span>
	    				</div>
	    			</div>
	    		</a>
	    	</li>
	    	<!--// list_row -->
    	
		</c:forEach>
    	
	</ul>
</div>
<!--// list_table_area -->
         
<!-- button_area -->
<c:if test="${param.lang ne 'en' }">
<div class="button_area">
	<div class="float_right">
		<button class="btn save" title="기업디렉토리 만들기" onclick="javascript:goCmpyDirMake()"; >		
			<span>기업디렉토리 만들기</span>
		</button>
	</div>
</div>
</c:if>
<!--// button_area -->

<!-- paging_area -->
${cmpyDirPagging}
<!--// paging_area -->