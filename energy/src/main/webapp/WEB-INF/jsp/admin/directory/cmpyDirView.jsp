<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript" src="/js/directory.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=5_eIOVdKRzwrAXq79hRn&callback=initMap&submodules=geocoder"></script>

<script language="javascript">

$( document ).ready( function(){
	
	$("#modal-cmpyDir").popup({
 		closetransitionend: function(e) {
 			var _title = $(e).find('div > div[id=pop_header] > header > h1').text();
 			if(_title == '제품사진') {
 				selectCmpyDirPrdtPctr();	
 			}
 			else if(_title == '기업 동영상') {
 				selectCmpyDirVdo();
 			}
		}
	});
	$("#modal-cmpyDirCert").popup({
		blur : false
	});
	
	$( '#btn_cmpy_dir_brec' ).bind( 'click' , function(){
		popupCmpyDirBrec();
	});
	
	$( '#btn_cmpy_dir_map' ).bind( 'click' , function(){
		popupCmpyDirMap();
	});
	
	selectCmpyDir();
	selectCmpyDirManager();
	selectCmpyDirFnc();
	selectCmpyDirExp();
	selectCmpyDirCert();
	selectCmpyDirHstr();
	selectCmpyDirPrdt();
	selectCmpyDirPrdtPctr();
	selectCmpyDirVdo();	

});	

var map = null;
var marker = null;

function initMap() {
	if(map == null) {
	    map = new naver.maps.Map('cmpyDirMapAPI', {
	        center: new naver.maps.LatLng(37.3595704, 127.105399),
	        zoom: 10
	    });
	}
	
	if(marker == null) {
		marker = new naver.maps.Marker({
    	    position: new naver.maps.LatLng(37.3595704, 127.105399),
    	    map: map
    	});
	}
}

function setCmpyDirMapAPI(addr){
	if(map == null) {
		 map = new naver.maps.Map('cmpyDirMapAPI', {
		        center: new naver.maps.LatLng(37.3595704, 127.105399),
		        zoom: 10
		    });
	}
	
	if(marker == null) {
		marker = new naver.maps.Marker({
    	    position: new naver.maps.LatLng(37.3595704, 127.105399),
    	    map: map
    	});
	}
	
    if(map != null && addr != '') {
    	naver.maps.Service.geocode({
	        address: addr
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.ERROR) {
	            return;
	        }
			
	        var item = response.result.items[0],
	            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
	            point = new naver.maps.Point(item.point.x, item.point.y);
			map.setCenter(point);
	        marker.setPosition(point);
	        
	    });
    }
}

</script>

<!-- content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">기업디렉토리관리</h3>
		</div>
		<!--// main_title -->
		
	</div>	
	<!--// title_and_info_area -->
	
	<form id="cmpyDirForm" name="cmpyDirForm" method="post">
		<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
		<input type='hidden' id="lang" name='lang' value="${param.lang}" /> 
		<input type='hidden' id="myDirectory" name='myDirectory' value="${param.myDirectory}" />
		<input type='hidden' id="homepage_tp" name='homepage_tp' value="${homepage_tp}" /> 		
	</form>
		
	<!-- 기본정보 -->
	<div id="cmpyDir" class="division50">		
	</div>
	
	<!-- 재무현황 -->
	<div id="cmpyDirFnc" class="division50">		
	</div>
	
	<!-- 수출현황 -->
	<div id="cmpyDirExp" class="division50">
	</div>
	
	<!-- 인증 및 기술획득현황 -->
	<div id="cmpyDirCert" class="division50">		
	</div>
	
	<!-- 주요제품 및 기술현황 -->
	<div id="cmpyDirPrdt" class="division50">
	</div>
	
	<!-- 연혁 -->
	<div id="cmpyDirHstr" class="division50">		
	</div>
	
	<!-- 국내외 주요공사 및 납품실적현황 -->
	<div class="division50">
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">국내외 주요공사 및 납품실적현황</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_brec" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<div id="cmpyDirBrec" class="f4box marginb20">${cmpyDir.brec_cn}</div>
	</div>
	
	<!-- 제품사진 -->
	<div id="cmpyDirPrdtPctr" class="division50">
	</div>
	
	<!-- 기업 동영상 -->
	<div id="cmpyDirVdo" class="division50">
	</div>
	
	<!-- 찾아오시는 길 -->
	<div class="division50">
		<!-- title_area -->
		<div class="title_area">
			<h4 class="title">찾아오시는 길</h4>
		</div>
		<!--// title_area -->
		
		<!-- table_search_area -->
		<div class="table_search_area">
			<div class="float_right">
				<button class="btn acti" id="btn_cmpy_dir_map" title="수정">
					<span>수정</span>
				</button>
			</div>
		</div>
		<!--// table_search_area -->
		
		<div id="cmpyDirMapAPI" style="width:100%;height:400px;"></div>
		<div id="cmpyDirMap" class="f4box marginb20"></div>
	</div>
	
	<!-- 담당자 정보 -->	
	<div id="cmpyDirManager" class="division50">
	</div>
	
	<!-- button_area -->
	<div class="button_area">
		<div class="float_right">
			<button class="btn delete" title="삭제" onClick="javascript:deleteCmpyDir()">
				<span>삭제</span>
			</button>
				<a href="javascript:goList()" class="btn list" title="목록"> <span>목록</span>
			</a>
		</div>
	</div>
	<!--// button_area -->
	
</div>
<!--// content -->

<div id="modal-cmpyDir" style="background-color:white">
	<div id="wrap">
	
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			    <div  id="pop_contentCmpyDir" >
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->
		
	</div>
 </div>
 <div id="modal-cmpyDirCert" style="background-color:white">
<!-- 	<div id="wrap"> -->
	
		<!-- container -->
		<div id="pop_containerCert">
		<article>
			<div class="pop_content_area">
			    <div  id="pop_contentCert" >
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->
		
<!-- 	</div> -->
 </div>