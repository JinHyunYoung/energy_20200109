<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>
<link rel="stylesheet" href="/assets/jstree/dist/themes/proton/style.min.css" />
<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>
<script type="text/javascript" src="/assets/jstree/dist/jstree.js"></script>


<script language="javascript">



function selectArea(_type){
	if (_type =="1") {
		$("#div_tree").attr("class","stati_title_area on");
		$("#div_item").attr("class","stati_title_area off");
	} else {
		$("#div_tree").attr("class","stati_title_area off");
		$("#div_item").attr("class","stati_title_area on");
	}
//	$( '#stats_research_m_h' ).attr("class","stati_title_area off");

}
 
</script>

<div id="wrap" >

		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">항목설정</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->		
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
				<!-- pop_content -->
				<div id="pop_content">
					<!-- search_area -->
					<div class="stati_search_area">
						<ul class="stati_location_list">
							<li>업종별</li>
							<li>사업체현황</li>
							<li>
								<strong>물산업 사업체수</strong>
							</li>
						</ul>
						<div class="topbtn_area">
							<button class="btn_stati_search" title="통계표 조회" onclick="javascript:selectStatsListResult()">
								<span>통계표 조회</span>
							</button>
							<button class="btn_reset" title="초기화" onclick="javascript:resetCondition()">
								<span>초기화</span>
							</button>
						</div>
					</div>
					<!--// stati_search_area -->
					<!-- division -->
					<div class="division">
						<form id="statListFrm" name="statListFrm" method="post" on submit="return false;">

							<div class="area55" onclick='javascript:selectArea("1")'> 
								<div class="marginr20">
									<div id="div_tree" class="stati_title_area off">
										<span>업종</span>
									</div>
									<!-- tree_box_area -->
									<div class="tree_area" style="height: 280px;">
										<div id="menu_jstree" >
											
										</div>
									</div>
									<!--// tree_box_area -->
								</div>
							</div>
							<div class="area45"  onclick='javascript:selectArea("2")'>
								<div id="div_item" class="stati_title_area off">
									<span>항목</span>
								</div>
								<div class="tree_area" style="height: 280px;">
									<ul id="stats_s_list" class="check_list">
									</ul>
								</div>
							</div>
						</form>
					</div>
					<!--// division -->
					
				</div>
				<!--// pop_content -->
			</div>
		</article>	
		</div>
		<!-- //container -->
</div>