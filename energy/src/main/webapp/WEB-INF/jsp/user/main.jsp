<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>
<%@ page import="kr.or.wabis.framework.util.StringUtil"%>
<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 레이어 팝업 시작  -->
<script>
function show_layer() {

	var lay_pop = $('#popup_wrap');
	var jb = $('#sliderA');

	var divX = jb.offset().left-100;
	var divY = jb.offset().top + 200;

	$('#popup_wrap').css("left", divX + "px");
	$('#popup_wrap').css("top", divY + "px");
	
}
function closeButtonOver(){
	
	$('#mdiv').css("display","block");
	
}
function closeButtonDown(){
	
	$('#mdiv').css("display","none");
	
}
</script>
<script> 
$(document).ready(function(){ 
	$("#mdiv").click(function(){
		$("#popup_wrap").css("display", "none");
	});	
}); 
</script>
<style>    
#popup_wrap {width:460px; height:300px; background:#fff; border: solid 1px #666666; position: absolute; top: 250px; left: 150px; margin:-250px 0 0 -250px; z-index:9999; display:none;}
#mask {width:100%; height:100%; position:fixed; background:rgba(0,0,0,0.7) repeat; top:0; left:0; z-index:999; display:none;}
.popup-cont01 {width:478px; margin:0px -8px;    text-align: center;}
.popup-cont01 button { width: 138px; height: 36px; line-height: 36px; background: #9f2f60; color: #ffffff; text-align: center; border: none; font-size: 16px;}

@media screen and (max-width: 1200px){
	#popup_wrap {display:none;}
}
#mdiv
{
width:25px;
height:25px;
border:0px solid black;
position: absolute;
background-color: lightslategrey; 
z-index: 9999;
display: none;
}
.mdiv
{
height:25px;
width:2px;
margin-left:12px;
background-color:white;
transform: rotate(45deg);
-ms-transform: rotate(45deg); /* IE 9 */
-webkit-transform: rotate(45deg); /* Safari and Chrome */
Z-index:1;
}
.md
{
height:25px;
width:2px;

background-color: white;
transform: rotate(90deg);
-ms-transform: rotate(90deg); /* IE 9 */
-webkit-transform: rotate(90deg); /* Safari and Chrome */
Z-index:2;

}
</style>
<!--   레이어 팝업 끝   -->
    <!-- main_visual -->
    <div class="main_vs_area_right">
	    <c:choose>
	    	<c:when test="${videoList.apply_type eq 'VIDEO_LOCAL'}" >
				<div><img src="/images/main/slogun.png" alt="슬로건"></div>
					<!-- <div id="mask" class="popup_wrap"> -->
					<div id="popup_wrap" class="popup_wrap" onmouseover="closeButtonOver();" onmouseout="closeButtonDown();">
						<div id="mdiv" >
							<div class="mdiv">      
								<div class="md"></div>
							</div>
						</div>  					
						<div class="popup-cont01">      
							<video width="461" height="300" controls="controls" style="background: rgb(1,1,1);"  alt="${videoList.titl_alt}" title="${videoList.titl_nm}"  autoplay="autoplay" muted="muted" loop>
						    	<source  src="/contents/banner/${videoList.image_nm}"  type="video/mp4">
						        <source src="mov_bbb.ogg" type="video/ogg">
						              Your browser does not support HTML5 video.
						    </video>
					  </div>
					</div>
					<script>
					$('#popup_wrap').css("display", "block");					
					</script>					    	
	    	</c:when>
	    	<c:when test="${videoList.apply_type eq 'IMAGE_LOCAL'}" >
	    	<div  style="width: 461px; height: 217px;" >   
				<img src="/contents/banner/${videoList.image_nm}" alt="${videoList.titl_alt}" style="width: 461px;height: 217px;"  title="${videoList.titl_nm}">
	        </div>    
	    	</c:when>  
	    	
	    	<c:when test="${videoList.apply_type eq 'VIDEO_URL'}" >
				<div><img src="/images/main/slogun.png" alt="슬로건"></div>
					<!-- <div id="mask" class="popup_wrap"> -->
					<div id="popup_wrap" class="popup_wrap" onmouseover="closeButtonOver();" onmouseout="closeButtonDown();">
						<div id="mdiv" >
							<div class="mdiv">      
								<div class="md"></div>
							</div>
						</div>	
						 	<div class="popup-cont01">
							<video width="461" height="300" controls="controls" style="background: rgb(1,1,1);"  alt="${videoList.titl_alt}" title="${videoList.titl_nm}"  autoplay="autoplay" muted="muted" loop>
						    	<source src="${videoList.url}"  type="video/mp4">
						        <source src="mov_bbb.ogg" type="video/ogg">
						              Your browser does not support HTML5 video.
						    </video>
						</div>    
					</div>
					<script>
					$('#popup_wrap').css("display", "block");					
					</script>	    	       	    	
	    	</c:when>
	    	<c:when test="${videoList.apply_type eq 'IMAGE_URL'}" >
	    	<div  style="width: 461px; height: 217px;" >   
				<img src="${videoList.url}" alt="${videoList.titl_alt}" style="width: 461px;height: 217px;"  title="${videoList.titl_nm}">
	        </div>   	    	
	    	</c:when>
	    	
	    	<c:otherwise>
				<div><img src="/images/main/slogun.png" alt="슬로건"></div>
	    	</c:otherwise>    	    
	    </c:choose>
        <div id ="sliderA">
            <iframe id="sliderframe" name="sliderframe" src="/web/user/slider.do?region=2" frameborder="0" scrolling="no" title="오른쪽 슬라이드 프레임"></iframe>

        </div>
    </div>
    <div class="main_vs_area">
        <ul>
            <li>

                <div class="swiper-container">
                    <div class="swiper-wrapper">
                       <c:forEach items="${bannerList}" var="list">
				       <div class="swiper-slide" style="background-image:url('/contents/banner/${list.image_nm}')">
						   <c:if test="${not empty list.url }">
							<a href="javascript:moveUrl('${list.target}', '${list.url}')" target="_top" class="slider_link" title="${list.titl_nm}">
								<span class="hidden">${list.titl_nm}</span>
							</a>
						   </c:if>	
						</div>
				       </c:forEach>
                    </div>

                    <div class="swiper-pagination swiper-pagination-white"></div>

                    <div class="swiper-button-next swiper-button-white"></div>
                    <div class="swiper-button-prev swiper-button-white"></div>
                </div>


                <script>
                    var swiper = new Swiper('.swiper-container', {
                        pagination: '.swiper-pagination',
                        paginationClickable: true,
                        loop: true,
                        nextButton: '.swiper-button-next',
                        prevButton: '.swiper-button-prev',
                        spaceBetween: 0,
                        effect: 'slider',
                        autoplay: 5000,
                        autoplayDisableOnInteraction: false
                    });
                </script>

            </li>

        </ul>
    </div>

    <div class="main_vs_mobile_area">
        <img src="/images/main/slogun.png" alt="슬로건">
    </div>

    <!-- //main_visual -->
    
<!-- container_본문 전체 영역 표시 -->
<div id="container">
	<h1>Container</h1>
	<article>
		<!-- container_area -->
		<div class="container_area">

			<!-- content_area 본문 전체 묶음 -->
			<div class="content_area">

				<!-- content -->
				<div id="content">

					<div class="area_contents_01">
						<div class="title_txt">한국에너지재단</div>
						<div class="comment_txt">한국에너지재단에서 진행하는 사업을 소개합니다.</div>
						<div class="comment_txt">
							<a href="javascript:goSubMenu('				/web/intropage/intropageShow.do?page_id=c6f45ac061f14c4caeada2a9c1e3e4b4','ba1c54d2e0544003914a194ede088b48','1','///');" title="about korea energy foundation" target="_self">
								about korea energy foundation
							</a>
						</div>

						<ul class="area_01_banner">
							<li>
								<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=3876622a82e546cc80af25537679401a','0f01e40bcaa14c40a55679a5322e5ce8','1','///');" title="에너지복지란?" target="_self">
									<img src="/images/main/area1-01.jpg" alt="에너지복지란?">
								</a>
							</li>
							<li>
								<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=37840ebcd7004927bbb095d0a1dd58d6','6bb8b46f37734a6086748812ae93f75d','1','///');" title="에너지효율개선사업" target="_self">
									<img src="/images/main/area1-02.jpg" alt="에너지효율개선사업">
								</a>
							</li>
							<li>
								<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=d856dd0070f246f2afb5e0c6436fa835','9b2de291c1414f069454456959679f78','1','///');" title="에너지사회공헌" target="_self">
									<img src="/images/main/area1-03.jpg" alt="에너지사회공헌">
								</a>
							</li>
							<li>
								<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=2abd22a4e8804e7d9219a18e0267231f','63f42904da9143c78293b66a49988d94','1','///');" title="에너지협력사업" target="_self">
									<img src="/images/main/area1-04.jpg" alt="에너지협력사업">
								</a>
							</li>
						</ul>
					</div>

					<div class="area_contents_02">
						<div class="title_txt">에너지알리미</div>
						<div class="comment_txt">한국에너지재단에서 진행하는 새로운 소식을 알려드립니다.</div>

						<div class="board_div_area">
							<div class="board_area">
								<a href="#boar_link" id="b_bt_1" class="viewlink active" title="공지사항" target="_self">
									공지사항
									<span class="more_bt"><img src="/images/main/more_bt.png" alt="더보기 버튼" onclick="goSubMenu('/web/board/boardContentsListPage.do?board_id=27','fd20fda33e39499a93bbec362155e145','1','///');"></span>
								</a>

								<div class="board_list b_obj_1">
                                    <ul class="board_3line" id="main_board_27"></ul>
								</div>

								<a href="#board_link" id="b_bt_4" class="viewlink" title="입찰정보" target="_self">
									입찰정보
									<span class="more_bt"><img src="/images/main/more_bt.png" alt="더보기 버튼" onclick="goSubMenu('/web/board/boardContentsListPage.do?board_id=28','75cfef9badc24788a145f8836d849803','1','///');"></span>
								</a>

								<div class="board_list b_obj_4">
                                    <ul class="board_3line" id="main_board_28"></ul>
								</div>

								<a href="#board_link" id="b_bt_2" class="viewlink" title="보도자료" target="_self">
									보도자료
									<span class="more_bt"><img src="/images/main/more_bt.png" alt="더보기 버튼" onclick="goSubMenu('/web/board/boardContentsListPage.do?board_id=29','ce13ce40f41348fdb7ce706b249e1de6','1','///');"></span>
								</a>

								<div class="board_list b_obj_2">
                                    <ul class="board_3line" id="main_board_29"></ul>
								</div>

								<!-- a href="#board_link" id="b_bt_3" class="viewlink" title="언론속재단" target="_self">
									언론속재단
									<span class="more_bt"><img src="/images/main/more_bt.png" alt="더보기 버튼" onclick="goSubMenu('/web/board/boardContentsListPage.do?board_id=31','c06fce73d41942b5bbf5155f9cd12dc3','1','///');"></span>
								</a>

								<div class="board_list b_obj_3">
                                    <ul class="board_3line" id="main_board_31"></ul>
								</div -->

								<a href="#board_link" id="b_bt_5" class="viewlink" title="갤러리" target="_self">
									갤러리
									<span class="more_bt"><img src="/images/main/more_bt.png" alt="더보기 버튼" onclick="goSubMenu('/web/board/boardContentsListPage.do?board_id=30','69779fd8d5874a08a4676e5d64c69247','1','///');"></span>
								</a>

								<div class="board_list b_obj_5">
									<ul class="board_3line" id="main_board_30"></ul>
								</div>

							</div>

						</div>
					</div>



					<div class="area_contents_03">
						<div class="title_txt">전자민원</div>
						<div class="comment_txt">국민참여 사이버신문고, 복지.보조금 부정신고, 청탁금지법안내, 청렴자료실을 제공합니다.</div>

						<ul class="area_03_banner">
							<li>
								<a href="javascript:goSubMenu('/web/request/requestCerti.do','1c87c24c4e394e89b8ecfb182e18d610 ','1','///');" title="사이버신문고" target="_self">
									<img src="/images/main/area3-01.png" alt="사이버신문고">
								</a>
								<div class="title_txt">
									<a href="javascript:goSubMenu('/web/request/requestCerti.do','1c87c24c4e394e89b8ecfb182e18d610 ','1','///');" title="사이버신문고" target="_self">
										사이버신문고
									</a>
								</div>
							</li>
							<li>
								<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=43e1dea126994c9cbe8c537fc6015891','40841c709f0b4999b5bc57381e9375ea','1','///');" title="복지.보조금 부정신고센터" target="_self">
									<img src="/images/main/area3-02.png" alt="복지.보조금 부정신고센터">
								</a>
								<div class="title_txt">
									<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=43e1dea126994c9cbe8c537fc6015891','40841c709f0b4999b5bc57381e9375ea','1','///');" title="복지.보조금 부정신고센터" target="_self">
										복지.보조금 부정신고센터
									</a>
								</div>
							</li>
							<li>
								<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=f82550f9b4534cc5ac4aa345f6cefe4c','583f3668196449afa6dab2a24da9912b','1','///');" title="청탁금지법안내" target="_self">
									<img src="/images/main/area3-03.png" alt="청탁금지법안내">
								</a>
								<div class="title_txt">
									<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=f82550f9b4534cc5ac4aa345f6cefe4c','583f3668196449afa6dab2a24da9912b','1','///');" title="청탁금지법안내" target="_self">
										청탁금지법안내
									</a>
								</div>
							</li>
							<li>
								<a href="javascript:goSubMenu('/web/board/boardContentsListPage.do?board_id=32','f4f400fd006f4930b77dfa81cf8d0a24','1','///');" title="청렴자료실" target="_self">
									<img src="/images/main/area3-04.png" alt="청렴자료실">
								</a>
								<div class="title_txt">
									<a href="javascript:goSubMenu('/web/board/boardContentsListPage.do?board_id=32','f4f400fd006f4930b77dfa81cf8d0a24','1','///');" title="청렴자료실" target="_self">
										청렴자료실
									</a>
								</div>
							</li>
						</ul>
					</div>

                    <div class="area_contents_04">
                        <div class="title_and_bt">
                            <div class="title_txt">에너지재단 누적현황</div>
                            <ul class="tab_bt_area">
                                <li class="tab_bt active" id="foot_tab1">지원사업 통계</li>
                                <li class="tab_bt" id="foot_tab2">모금 및 후원 통계</li>
                            </ul>
                        </div>
                        <ul class="back_slider_area">
                            <li>

                                <div class="animation_area map_data">
                                    <img src="/images/main/map_bg.png" class="map_bg" alt="지도 이미지">
                                    <div class="radius_bg radubg_1"><div><span class="bgcounter1">${busiStat.R11}</span><BR />서울</div></div>
                                    <div class="radius_bg radubg_2"><div><span class="bgcounter2">${busiStat.R42}</span><BR />강원지역</div></div>
                                    <div class="radius_bg radubg_3"><div><span class="bgcounter3">${busiStat.R30}</span><BR />충청지역</div></div>
                                    <div class="radius_bg radubg_4"><div><span class="bgcounter4">${busiStat.R26}</span><BR />경상지역</div></div>
                                    <div class="radius_bg radubg_5"><div><span class="bgcounter5">${busiStat.R29}</span><BR />전라지역</div></div>
                                    <div class="radius_bg radubg_6"><div><span class="bgcounter6">${busiStat.R50}</span><BR />제주지역</div></div>
                                    <div class="radius_bg radubg_7"><div><span class="bgcounter7">${busiStat.R28}</span><BR />수도권지역</div></div>

                                    <!-- <ul class="ani_right_banner">
                                        <li>
                                            <img src="/images/main/hand_money.png" alt="손 및 달라 이미지"><BR />
                                            <span>${busiAmtTotal}</span><BR />
                                            후원금액(단위:원)
                                        </li>
                                        <li>
                                            <img src="/images/main/people.png" alt="사람들이미지"><BR />
                                            <span>${busiHouseTotal}</span><BR />
                                            후원금 참여건수
                                        </li>
                                    </ul> -->
                                </div>

                            </li>
                            <li>

                                <div class="line_animation"></div>

                                <div class="animation_area">
                                	<c:forEach items="${fundStat}" var="list">
                                    <div class="radius_icon radu_${list.rnum }" <c:if test="${empty list.year }">style="display:none"</c:if>><div></div></div>
                                    <div class="numbering number${list.rnum }" <c:if test="${empty list.year }">style="display:none"</c:if>><div class="counter${list.rnum }">${list.amt }</div></div>
                                    <div class="year_txt ytext${list.rnum }" <c:if test="${empty list.year }">style="display:none"</c:if>>${list.year }년</div>
                                    </c:forEach>
                                </div>

                                <img src="/images/main/windmill_base.png" class="winmaill_base_1" alt="풍차 기둥"/>
                                <img src="/images/main/windmill.png" class="winmaill_1" alt="풍차 날개"/>

                                <img src="/images/main/windmill_base.png" class="winmaill_base_2" alt="풍차 기둥"/>
                                <img src="/images/main/windmill.png" class="winmaill_2" alt="풍차 날개"/>

                                <img src="/images/main/windmill_base.png" class="winmaill_base_3" alt="풍차 기둥"/>
                                <img src="/images/main/windmill.png" class="winmaill_3" alt="풍차 날개"/>
                            </li>
                        </ul>
                    </div>

                    <script type="text/javascript">
						<!--
						$(document).ready(function(){
							var angle = 0;
							setInterval(function(){
								angle+=7;
								$(".winmaill_1").rotate(angle);
								$(".winmaill_2").rotate(angle);
								$(".winmaill_3").rotate(angle);
							},50);
						});
						//-->
					</script>
					<script type="text/javascript" src="/js/waypoints.min.js"></script>
					<script type="text/javascript" src="/js/jquery.counterup.min.js"></script>
					<script type="text/javascript" src="/js/jQueryRotate.js"></script>


					<ul class="area_contents_05">
						<li>
							<h2>관련사이트</h2>
							<div id="banner">
								<ul>
									<li id="banner_control">
										<button type="button"><span class="sound_only">배너 정지</span></button>
									</li>
									<li>
										<div id="banner_slider">
											<ul>
										       <c:forEach items="${tickerSite}" var="list">
												<li>
													<a href="javascript:moveUrl('${list.target}', '${list.url}');" title="${list.titl_nm}" ><img src="/contents/banner/${list.image_nm}" height="53" alt="${list.titl_nm}"/></a>
												</li>
                                               </c:forEach>
											</ul>
										</div>
									</li>
								</ul>
							</div>
						</li>
					</ul>

				</div>
				<!--// content -->

			</div>
			<!--// content_area -->

		</div>
		<!--// container_area -->

	</article>
</div>
<!--// container -->

<!-- footer -->
<div id="footer">
	<h1>Footer</h1>
	<footer>
		<ul class="area_footer_01">
			<li>
				<h2>하단 로고</h2>
				<a href="/energy/web/WEB-INF/jsp/index.html" title="한국에너지재단 로고" target="_self">
					<img src="/images/common/logo.png" alt="한국에너지재단 로고">
				</a>
			</li>
			<li>
				<div class="foot_link">
					<h2>하단 링크</h2>
					<a href="javascript:goSubMenu('/web/infopage/clauseShow.do','66532170e21f4bd28b8f54da5c1b4ce5','1','///');" title="이용약관" target="_self">이용약관</a>
					<a href="javascript:goSubMenu('/web/infopage/privacyShow.do','4c5810db9ca9477796162f004f1a0b16','1','///');" title="개인정보처리방침" target="_self">개인정보처리방침</a>
					<a href="javascript:goSubMenu('/web/intropage/intropageShow.do?page_id=8042f3dc855b4216ad30df5169b136e9','b3695e6983bf4816a8d0252c1cb8ee67','1','///');" title="찾아오시는 길" target="_self">찾아오시는 길</a>
				</div>

				<!-- address_주소 내용 영역 -->
				<address>
					<ul class="area_footer_02">
						<h2>주소</h2>
						<li>
							(우:04337) 서울특별시 용산구 신흥로 152 FAX 02-6913-2119 | <b>콜센터 1670-7653</b><br/>
							Copyright 2010. 한국에너지재단 All rights reserved.
						</li>

						<li>
							본 페이지에 게시된 이메일 주소가 자동수집 되는것을 거부하며 이를 위반시 정보통신법에 의해 처벌됨을 유념하시기 바랍니다.
						</li>
					</ul>
				</address>
				<!-- //address -->
			</li>
		</ul>

		<div class="family_site_area" style="display:none">
			<h2>패밀리사이트</h2>
			<select name="family_site" id="family_site" title="패밀리사이트">
				<option value="" selected>패밀리사이트
				<option value="http://naver.com">네이버
			</select>
			<button type="button" id="family_site_bt">이동</button>
		</div>
	</footer>
</div>
<!-- //footer -->