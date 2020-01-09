<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, user-scalable=yes, target-densitydpi=medium-dpi" />
	
	<title></title>
	
	<link rel="stylesheet" type="text/css" href="/assets/jquery-ui/themes/base/jquery-ui.css" />
	
	<link rel="stylesheet" type="text/css" href="/css/web/default.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/nanumgothic.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/common.css" />
	<link rel="stylesheet" type="text/css" href="/css/modal.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directory.css" />
	<link rel="stylesheet" type="text/css" href="/css/web/directorySub.css" />

	<script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
    <script type="text/javascript" src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   
    
   	<script type="text/javascript" src="/assets/bootstrap/js/bootstrap.js"></script>
    
	<script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>
	<script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>
	
	<script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>
	<script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>
	
	<script type="text/javascript" src="/js/directory.js"></script>	
	
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=5_eIOVdKRzwrAXq79hRn&callback=initMap&submodules=geocoder"></script>
	
	<!--[if lt IE 9]>
		<script type="text/javascript" src="/js/html5.js"></script>
	<![endif]-->	
	
	<script type="text/javascript">
		
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
    		    return 
			}
		});
		$("#modal-cmpyDirCert").popup({
			blur : false
		});
		
		$( '#btn_cmpy_dir' ).bind( 'click' , function(){
			popupCmpyDir();
		});
		
		$( '#btn_cmpy_dir_manager' ).bind( 'click' , function(){
			popupCmpyDirManager();
		});
		
		$( '#btn_cmpy_dir_brec' ).bind( 'click' , function(){
			popupCmpyDirBrec();
		});

		$( '#btn_cmpy_dir_map' ).bind( 'click' , function(){
			popupCmpyDirMap();
		});
				
		selectCmpyDir();
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
	
</head>

<body>
<div id="dwrap">

	<!-- skip_nav --> 
	<div id="skip_nav">  
		<a href="#nav">메인메뉴 바로가기</a>
		<a href="#content">본문내용 바로가기</a>
	</div>
	<!-- //skip --> 
	
	<!-- header -->
	<div id="dheader">	
	<header>
	
		<!-- dheader_area -->
		<div class="dheader_area">
		
			<!-- dhsection -->
			<div id="dir_logo" class="dhsection">				
			</div>
			<!--// dhsection -->
			
		</div>
		<!--// dheader_area -->
		
	</header>	
	</div>
	
	<!--// header -->
	<hr class="hidden" />
	
	<!-- dcontainer -->
	<div id="dcontainer">
	<article>
	
		<!-- dcontent_area -->
		<div class="dcontent_area">
		
			<!-- content -->
			<div id="dcontent">
				<form id="cmpyDirForm" name="cmpyDirForm" method="post">
					<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" />
					<input type='hidden' id="lang" name='lang' value="${param.lang}" /> 
					<input type='hidden' id="myDirectory" name='myDirectory' value="${param.myDirectory}" /> 
					<input type='hidden' id="homepage_tp" name='homepage_tp' value="${homepage_tp}" />  
					<input type='hidden' id="inds_tp_cd" name='inds_tp_cd' value="${param.inds_tp_cd}" />
				</form>
			
				<!-- dtitle_area -->
				<div class="dtitle_area">
					<div class="float_left padt5">
						<h2 class="title">
							<c:if test="${param.lang == 'en'}">
							Overview
							</c:if>
							<c:if test="${param.lang != 'en'}">
							기본정보
							</c:if>
						</h2>
					</div>
					<div class="float_right">				
						<button class="btn cancel" id="btn_cmpy_dir" title="수정">
							<span>
								<c:if test="${param.lang == 'en'}">
								Update
								</c:if>
								<c:if test="${param.lang != 'en'}">
								수정
								</c:if>
							</span>
						</button>
					</div>
				</div>
				<!--// dtitle_area -->
				
				<!-- 기본정보 -->
				<div id="cmpyDir" class="dtable_area">
				</div>
				<!--// 기본정보 -->
				
				<!-- dbutton_area -->
				<div class="dbutton_area margb50 alignr">
					<button class="btn save" id="btn_cmpy_dir_manager" title="수정">
						<span>
							<c:if test="${param.lang == 'en'}">
							Manager Information
							</c:if>
							<c:if test="${param.lang != 'en'}">
							담당자 정보보기
							</c:if>
						</span>
					</button>
				</div>
				<!--// dbutton_area -->
				
				<!-- division -->
				<div class="division40">
				
					<!-- 재무현황 -->
					<div id="cmpyDirFnc" class="half_area">
					</div>
					<!--// 재무현황 -->
					
					<!-- 수출현황 -->
					<div id="cmpyDirExp" class="half_area">
					</div>
					<!--// 수출현황 -->
					
				</div>
				<!--// division -->
				
				<!-- 인증 및 기술획득현황 -->
				<div id="cmpyDirCert" class="division50">
				</div>
				<!--// 인증 및 기술획득현황 -->
				
				<!-- 주요제품 및 기술현황-->
				<div id="cmpyDirPrdt" class="division50">
				</div>
				<!--// 주요제품 및 기술현황 -->
				
				<!-- 연혁 -->
				<div id="cmpyDirHstr" class="division50">
				</div>
				<!--// 연혁 -->
				
				<!-- 국내외 주요공사 및 납품실적현황 -->
				<div class="division50">
			
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								Domestic and Global Project and Delivery Performance Condition
								</c:if>
								<c:if test="${param.lang != 'en'}">
								국내외 주요공사 및 납품실적 현황
								</c:if>				
							</h2>
						</div>
						<div class="float_right">
							<button class="btn cancel" id="btn_cmpy_dir_brec" title="수정">
								<span>
									<c:if test="${param.lang == 'en'}">
									Update
									</c:if>
									<c:if test="${param.lang != 'en'}">
									수정
									</c:if>
								</span>
							</button>
						</div>
					</div>
					<!--// dtitle_area -->
					
					<!-- deditor_area -->
					<div id="cmpyDirBrec" class="deditor_area view"></div>
					<!--// deditor_area -->
					
				</div>
				<!--// 국내외 주요공사 및 납품실적현황 -->
				
				<!-- 제품사진 -->
				<div id="cmpyDirPrdtPctr" class="division50">					
				</div>
				<!--// 제품사진 -->
				
				<!-- 기업 동영상 -->
				<div id="cmpyDirVdo" class="division50">					
				</div>
				<!--// 기업 동영상 -->
				
				<!-- 찾아오시는 길 -->
				<div class="division50">	
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								Location
								</c:if>
								<c:if test="${param.lang != 'en'}">
								찾아오시는 길
								</c:if>								
							</h2>
						</div>
						<div class="float_right">
							<button class="btn cancel" id="btn_cmpy_dir_map" title="수정">
								<span>
									<c:if test="${param.lang == 'en'}">
									Update
									</c:if>
									<c:if test="${param.lang != 'en'}">
									수정
									</c:if>
								</span>
							</button>
						</div>
					</div>
					<!--// dtitle_area -->
					
					<!-- dmap_area -->
					<div id="cmpyDirMapAPI" class="dmap_area" style="width:100%;height:400px;"></div>					
					<!--// dmap_area -->
					
					<!-- deditor_area -->
					<div id="cmpyDirMap" class="deditor_area view"></div>
					<!--// deditor_area -->				
				</div>
				<!--// 찾아오시는 길  -->
				
				<!-- dbutton_area -->
				<div class="dbutton_area alignc">
					<a href="javascript:goList()" class="btn list" title="목록페이지로 이동">
						<span>
							<c:if test="${param.lang == 'en'}">
							List
							</c:if>
							<c:if test="${param.lang != 'en'}">
							목록
							</c:if>
						</span>
					</a>
				</div>
				<!--// dbutton_area -->
				
			</div>	
			<!--// dcontent -->

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
				<div id="wrap">
				
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
				</div>
			 </div>
			
		</div>
		<!--// dcontent_area -->
		
	</article>	
	</div>
	<!--// dcontainer -->
	
</div>
<!--// dwrap -->

</body>
	
</html>


