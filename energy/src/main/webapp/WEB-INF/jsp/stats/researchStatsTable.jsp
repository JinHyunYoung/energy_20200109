<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/assets/jquery/jquery.number.js"></script>   

<script language="javascript">
var researchCodeLoadUrl = '<c:url value="/web/stats/researchCodeList.do" />';
$(document).ready(function(){
	loadResearchCode( "T", "" );			
});


function selectTypeCode(_id, _code, _text) {
	changeLiClass(_id);
	$("#inds_tp_cd").attr("value", _code);
	$("#inds_tp_nm").attr("value", _text);
};

function selectStatsResearchMCode(_id, _code, _text) {
	changeLiClass(_id);
	$('#stats_l_cd').attr("value", _code);
	$('#stats_l_nm').attr("value", _text);
};

function selectStatsResearchSCode(_id, _code, _text) {
	changeLiClass(_id);
	
	researchFrm.action = "/web/stats/researchStatsList.do";
	$('#stats_m_cd').attr("value", _code);
	$('#stats_m_nm').attr("value", _text);
	researchFrm.submit();
}

function changeLiClass(_id) {
	$('#'+ _id).parent().find("li").removeClass('on');
	$('#'+ _id).addClass('on');
}


function loadResearchCode(_gubun, _code ){	

	 $.ajax({
        url: researchCodeLoadUrl,
        dataType: "json",
        type: "post",
        data: {	     
        	gubun : _gubun,
        	inds_tp_cd : $("#inds_tp_cd").val(),
        	code : _code
		},
        success: function( data ){
        	var _html = '';
        	if( data.list.length > 0 ){
        		for( var i = 0 ; i < data.list.length ; i++ ){
        			
        			if( _gubun == 'T' ){
        				_html += '<li id=\'tp_cd_'+i+'\' class="off" onclick="javascript:selectTypeCode(\'tp_cd_'+ i + '\',\'' + data.list[i].code +'\',\'' + data.list[i].code_nm +'\')" > '
        					   + ' <a href="javascript:loadResearchCode(\'L\', \'\');"  title="' + data.list[i].code_nm + '">' 
        					   + data.list[i].code_nm + '</a> </li> ';
        			}
        			else if( _gubun == 'L' ){
        				_html += '<li id=\'l_cd_'+i+'\' class="off" onclick="javascript:selectStatsResearchMCode(\'l_cd_'+i+ '\',\'' + data.list[i].code +'\',\'' + data.list[i].code_nm +'\')"> '
        						+ ' <a href=\"javascript:loadResearchCode(\'M\', \''+data.list[i].code +'\');\"  title="' + data.list[i].code_nm + '">' 
        						+ data.list[i].code_nm + '</a> </li> ';
        			}
        			else if( _gubun == 'M'  ){
        				_html += '<li id=\'m_cd_'+i+'\' class="off" onclick="javascript:selectStatsResearchSCode(\'m_cd_'+i+ '\',\'' + data.list[i].code +'\',\'' + data.list[i].code_nm +'\')"> '
        						+ ' <a href=\"#" title="' + data.list[i].code_nm + '">'
        						+ data.list[i].code_nm + '</a> </li> ';
        			}
        		}        	
        	}
        	
    		if( _gubun == 'T' ){
    			$( '#stats_research_tp_h' ).attr("class","stati_title_area on");
    			$( '#stats_research_tp_c' ).attr("class","stati_list_area on");
    			$( '#stats_research_tp_list' ).html( _html );
    		}
    		else if( _gubun == 'L' ){
    			$( '#stats_research_l_h' ).attr("class","stati_title_area on");
    			$( '#stats_research_l_c' ).attr("class","stati_list_area on");
    			$( '#stats_research_l_list' ).html( _html );
    		}
    		else if( _gubun == 'M' ){
    			$( '#stats_research_m_h' ).attr("class","stati_title_area on");
    			$( '#stats_research_m_c' ).attr("class","stati_list_area on");
    			$( '#stats_research_m_list' ).html( _html );
    		}
        },
        error: function(e) {
            alert( '데이터를 가져오는데 실패했습니다.' );
        }
	});	
}

function searchReset(){
	$( '#stats_research_l_h' ).attr("class","stati_title_area off");
	$( '#stats_research_l_c' ).attr("class","stati_list_area off noselect");
	$( '#stats_research_m_h' ).attr("class","stati_title_area off");
	$( '#stats_research_m_c' ).attr("class","stati_list_area off noselect");
	$( '#stats_research_l_list' ).empty();
	$( '#stats_research_m_list' ).empty();
	$('li').removeClass('on');
}
</script>

<div class="sub_content">
		<form id="researchFrm" name="researchFrm" method="post" >
			<input type='hidden' id="inds_tp_cd" name="inds_tp_cd" /> 
			<input type='hidden' id="inds_tp_nm" name="inds_tp_nm" /> 
			<input type='hidden' id="stats_l_cd" name='stats_l_cd'  />
			<input type='hidden' id="stats_l_nm" name='stats_l_nm'  />
			<input type='hidden' id="stats_m_cd" name='stats_m_cd'  />
			<input type='hidden' id="stats_m_nm" name='stats_m_nm'  />
	
			<!-- search_area -->
			<div class="statistics_search_area">
				<a href="javascript:submitResearchCode();" class="statistics_btn">
					<span>통계표 찾기</span>
				</a>
			</div>
			<div class="stati_search_area">
				<dl class="srh_dl">
					<dt class="srh_dt">
						<label for="bs_yy">
							<strong class="color_pointr">*</strong> 보고년도(기준년도)
						</label>
					</dt>
					<dd class="srh_dd">
						<select class="in_wp130" id="bs_yy" name="bs_yy" >
							<c:forEach var="years" items="${list}">
								<option value="${years.bs_yy}" >${years.issue_yy}(${years.bs_yy})</option>
							</c:forEach>
	                     </select>
					</dd>
				</dl>
				<div class="topbtn_area">
					<button class="btn_reset" title="초기화" onclick="searchReset()">
						<span>초기화</span>
					</button>
				</div>
			</div>
			<!--// stati_search_area -->
			<!-- division -->
			<div id="div_codes" class="division">
				<!-- 1Depth -->
				<div class="area30">
					<div id="stats_research_tp_h" class="stati_title_area off">
						<span>[1] 구분을 선택하세요.</span>
					</div>
					<div id="stats_research_tp_c" class="stati_list_area on">
						<ul id="stats_research_tp_list" class="stati_list">
						</ul>
					</div>
				</div>
				<!--// 1Depth -->
				<div class="bg_arrow_next">&nbsp;</div>
				<!-- 2Depth -->
				<div class="area30">
					<div  id="stats_research_l_h" class="stati_title_area off">
						<span>[2] 통계구분을 선택하세요.</span>
					</div>
					<div  id="stats_research_l_c" class="stati_list_area off noselect">
						<ul id="stats_research_l_list" class="stati_list">
						</ul>
					</div>
				</div>
				<!--// 2Depth -->
				<div class="bg_arrow_next">&nbsp;</div>
				<!-- 3Depth -->
				<div class="area30">
					<div  id="stats_research_m_h" class="stati_title_area off">
						<span>[3] 통계표를 선택하세요.</span>
					</div>
					<div  id="stats_research_m_c" class="stati_list_area off noselect">
						<ul id="stats_research_m_list" class="stati_list">
						</ul>
					</div>
				</div>
				<!--// 3Depth -->
			</div>
			<!--// division -->
	
		</form>
</div>
