<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<style type="text/css">

.schedule_area .schedule_detail > div + div {
    margin-top: 0px;
}
.marginb20 {
    margin-bottom: 50px;
}

</style>

<script type="text/javascript">

var schedule = {
	_y : 0 , 
	_m : 0 , 
	_date : new Date() , 
	_today : new Date() ,
	_data : null , 
	_d_end : 0 , 
	text : function(){
		$( '.go_pop_calendar strong' ).html( this._date.getFullYear() + "." + ( ( ( this._date.getMonth() + 1 ) < 10  ) ? '0' + ( this._date.getMonth() + 1 ) : ( this._date.getMonth() + 1 ) ) );
	} ,
	init : function( _y , _m ){
		
		this._date.setDate( 1 );
		this._y = ( _y == undefined ) ? ( new Date() ).getFullYear() : _y;
		this._m = ( _m == undefined ) ? ( new Date() ).getMonth() : _m;
		this._date.setFullYear( this._y );
		this._date.setMonth( this._m );
		
	} ,
	current : function(){
		this.init();
		this.make();
	} , 
	prev : function(){
		this._date.setMonth( this._date.getMonth() - 1 );
		this.make();
	} , 
	next : function(){
		this._date.setMonth( this._date.getMonth() + 1 );
		this.make();
	} ,
	load : function(){
		var _this = this;
		var s_start_dt = this._date.getFullYear() + '-' + mk2( this._date.getMonth() + 1 ) + '-01';
		var s_end_dt = this._date.getFullYear() + '-' + mk2( this._date.getMonth() + 1 ) + '-' + mk2( this._d_end );
		$.ajax({
	        url: '<c:url value="/admin/support/loadScheduleList.do" />' ,
	        dataType: 'json' ,
	        type: 'post' ,
	        data: 'evt_strt_dt=' + s_start_dt + '&evt_end_dt=' + s_end_dt ,
	        success: function( data ){
	        	$( '.schedule_detail' ).empty();
	        	if( data != null ){
	        		if( data.list ){
	        			for( var i = 0 ; i < data.list.length ; i++ ){
	        				_this.unit( data.list[i] );	
	        			}	        			
	        		}
	        	}
	        },
	        error: function(e) {
	            alert( "일정을 불러오는데 실패하였습니다." );
	        }
	    });
	} , 
	unit : function( _row ){
		
		var s_start_dt = _row.evt_strt_dt.split( '-' );
		var s_end_dt = _row.evt_end_dt.split( '-' );
		var d_start = ( ( ( s_start_dt[1] * 1 ) -1 ) != this._date.getMonth() ) ? 1 : ( s_start_dt[2] * 1 ) ;
		var d_end = ( ( ( s_end_dt[1] * 1 ) -1 ) != this._date.getMonth() ) ? this._d_end : ( s_end_dt[2] * 1 ) ;
		var colors = { 'RED' : '01' , 'ORANGE' : '02' , 'YELLOW' : '03' , 'GREEN' : '04' , 'BLUE' : '05' , 'NAVY' : '06' , 'PURPLE' : '07' };
		
		for( var i = d_start ; i <= d_end ; i++ ){
			
			var targetTd = $( '#day_' + i ); 
			var targetDiv = ( targetTd.find( '.day_memo' ).size() == 0 ) ? $( '<div class="day_memo"></div>').appendTo( targetTd ) :  targetTd.find( '.day_memo' ) ;
			
			$( '<a href="#detail" onclick="showSchedule(\'' + _row.evt_sn + '\');" class="schedule_' + colors[ _row.evt_tp_icon ] + '" title="' + _row.evt_ttle + '"><span>일정있음</span></a>' ).appendTo( targetDiv );
			
		}
		
		var detail = $( '.schedule_detail' );		
		var _html = '';
		_html += '<div class="division" data-sn="' + _row.evt_sn + '">';
		_html += '		<div class="schedule_detail_box marginb10">';
		_html += '			<strong>[' + ( ( _row.domestic_yn == 'Y' ) ? '국내' : '국외' ) + '] ' + _row.evt_ttle + '</strong>';
		_html += '			<dl class="sch_dl">';
		_html += '				<dt class="sch_dt">기간</dt>';
		_html += '				<dd class="sch_dd">' + _row.evt_strt_dt + ' ~ ' + _row.evt_end_dt + '</dd>';
		_html += '			</dl>';
		_html += '			<div class="detail_txt">';
		_html += '				' + _row.evt_cn ;
		_html += '			</div>';
		_html += '		</div>';

		/*
		_html += '	<div class="title_area">';
		_html += '		<h4 class="title">첨부파일</h4>';
		_html += '	</div>';
		*/
		//첨부파일 시작
    	if( _row.attach != null ){
    			for( var i = 0 ; i < _row.attach.length ; i++ ){
    				_html += '<dl class="view">';
    				_html += '	<dt class="vdt"><span>첨부파일</span></dt>';
    				_html += '	<dd class="vdd file">';
    				var nsize = Math.round(_row.attach[i].file_size/1024);
    				var nf = new Intl.NumberFormat();
    				nf.format(nsize);
    				_html += '		<a href="/commonfile/fileidDownLoad.do?file_id='+_row.attach[i].file_id+'"  target="_blank" class="download" title="다운받기">';
    				switch(_row.attach[i].file_type ) {
        				case "hwp"  : _html += '<img src="/images/admin/icon/icon_hwp.png" alt="한글파일" />';
        				case "pdf"  : _html += '<img src="/images/admin/icon/icon_pdf.png" alt="pdf파일" />';
        				case "xls"  : _html += '<img src="/images/admin/icon/icon_excel.png" alt="엑셀파일" />';
        				case "xlsx" : _html += '<img src="/images/admin/icon/icon_excel.png" alt="엑셀파일" />';
        				default     : _html += '<img src="/images/admin/icon/icon_file.png" alt="파일" />';
    				}
    				
    				_html += _row.attach[i].origin_file_nm +"("+nsize+" KB)";
    				_html += '		</a>';
    				_html += '  </dd>';
    				_html += '</dl>';
    			}	        			
    	}
		//첨부파일 끝
		_html += '</div>';
		_html += '		<div class="button_area">';
		_html += '			<div class="float_right">';
		_html += '				<button class="btn save" title="수정" onclick="goSchedule(' + _row.evt_sn + ');">';
		_html += '					<span>수정</span>';
		_html += '				</button>';
		_html += '				<button class="btn cancel" title="삭제하기" onclick="deleteSchedule( \'' + _row.evt_sn + '\' )">';
		_html += '					<span>삭제</span>';
		_html += '				</button>';
		_html += '			</div>';
		_html += '		</div>';
		
		/**  **/
		$( _html ).appendTo( detail );
		
	} , 
	make : function(){
		
		var tbl_calendar = $( '.tbl_calendar tbody' );
		var startDay = this._date.getDay();
		var endDate = ( new Date( this._date.getFullYear() , this._date.getMonth() + 1 ,  this._date.getDate() - 1 ) ).getDate();
		this._d_end = endDate;
		var isStart = false;
		var isEnd = false;
		var _html = '';
		var _offset = 0;
		for( var i = 0 ; i <= 42 ; i++ ){
			
			if( i == startDay ){ 
				isStart = true;
				_offset = i;
			}
			
			if( isStart && ( i - _offset + 1 ) > endDate ){
				isEnd = true;
			}
			
			if( i % 7 == 0 ){
				_html += '<tr>';
			}
			
			_html += '<td>';			
			if( isStart && ! isEnd ){
				_html += '	<div class="day_area" id="day_' + ( i - _offset + 1 ) + '">';
				_html += '		<div class="day_info">';
				_html += '			<strong class="day">' + ( i - _offset + 1 ) + '</strong>';
			}else{
				_html += '	<div class="day_area">';
				_html += '		<div class="day_info dayoff">';
				_html += '			<strong class="day">&nbsp;</strong>';
			}
			_html += '		</div>';
			_html += '	</div>';
			_html += '</td>';
			
			if( i % 7 == 6 ){
				_html += '</tr>';
				if( isEnd ){ break; }
			}
			
		}
		tbl_calendar.html( _html );
		
		this.text();
		this.load();
		
	}
		
};
//jqgrid 파일 첨부 이미지 출력 format
function formatFile(cellvalue, options, rowObject){
	var str ="";
	var opt = rowObject[2]; 
	
	//이미지 추가
	  if( opt != "" ){                      
	   str += "<img src=\"/images/admin/icon/icon_file2.png\" />";   
	  }
	  return str;
}

$( document ).ready( function(){
	
	schedule.init();
	schedule.make();	

	
	$( 'a[href="#prev"]' ).bind( 'click' , function(){
		$( '.choice_layear' ).css( { display : 'none' } );
		schedule.prev();
	});
	
	$( 'a[href="#next"]' ).bind( 'click' , function(){
		$( '.choice_layear' ).css( { display : 'none' } );
		schedule.next();
	});
	
	$( '.this_month' ).bind( 'click' , function(){
		$( '.choice_layear' ).css( { display : 'none' } );
		schedule.current();
		
	});
	
	$( 'a[href="#current"]' ).bind( 'click' , function(){
		
		$( '.choice_layear' ).css( { display : '' } );
		
		var yearChoice = $( '.choice_layear ul:eq(0)' );
		var monthChoice = $( '.choice_layear ul:eq(1)' );	
		
		yearChoice.find( 'a' ).removeClass( 'on' );
		monthChoice.find( 'a' ).removeClass( 'on' );
		
		yearChoice.find( 'a[data-year="' + schedule._date.getFullYear() + '"]' ).addClass( 'on' );
		monthChoice.find( 'a[data-month="' + ( schedule._date.getMonth() + 1 ) + '"]' ).addClass( 'on' );		
		
		
	});
	
	$( 'a[href="#closeChoice"]' ).bind( 'click' , function(){		
		$( '.choice_layear' ).css( { display : 'none' } );
	});
	
	$( '.choice_layear ul:eq(0) a' ).bind( 'click' , function(){
		
		$( this ).parent().parent().find( 'a' ).removeClass( 'on' );
		$( this ).addClass( 'on' );
		schedule.init( $( this ).data( 'year' ) , schedule._date.getMonth() );
		schedule.make();
		
		return false;
		
	});
	
	$( '.choice_layear ul:eq(1) a' ).bind( 'click' , function(){
		
		$( this ).parent().parent().find( 'a' ).removeClass( 'on' );
		$( this ).addClass( 'on' );
		schedule.init( schedule._date.getFullYear() , ( $( this ).data( 'month' ) * 1 - 1 ) );
		schedule.make();
		
		return false;
		
	});

	$('#modal-schedule').popup();	
	
});

function deleteSchedule( _sn ){
	
	if( ! confirm( '일정을 삭제하시겠습니까?' ) ) return false;
	
	$.ajax({
        url: '<c:url value="/admin/support/deleteSchedule.do" />' ,
        dataType: 'json' ,
        type: 'post' ,
        data: 'evt_sn=' + _sn ,
        success: function( data ){
        	if( data.success == 'true' ){
        		alert( "행사일정 삭제를 성공하였습니다." );
        		schedule.make();
        	}else if( data.success == 'false' ){
        		alert( "행사일정 삭제를 실패하였습니다." );
        	}
        },
        error: function(e) {
            alert( "일정을 삭제하는데 실패하였습니다." );
        }
    });
	
	
}

function showSchedule( _sn ){
	
	$( '.division' ).css( { display : 'none' } );
	$( '.division[data-sn=' + _sn + ']' ).css( { display : 'block' } );
	
}

function mk2( n ){
	return ( n < 10 ) ? '0' + n : n.toString();
}

function goSchedule( _evt_sn ){
	$.ajax({
	    url: '/admin/support/selectSchedule.do',
	    dataType: "html",
	    type: "post",
	    data: {
	    	evt_sn : _evt_sn
		},
	    success: function(data) {
	    	$('#pop_content').html(data);
	    	popupShow();
	    },
	    error: function(e) {
	        alert("테이블을 가져오는데 실패하였습니다.");
	    }
	});
}

//팝업 열기
function popupShow(){
	$('#modal-schedule').popup('show');
}

//팝업 닫기
function popupClose(){
	$('#modal-schedule').popup('hide');
}

</script>
<!-- content -->
<div id="content">

	<!-- title_and_info_area -->
	<div class="title_and_info_area">
	
		<!-- main_title -->
		<div class="main_title">
			<h3 class="title">행사일정 관리</h3>
		</div>
		<!--// main_title -->
		
	</div>	
	<!--// title_and_info_area -->
	
	<div class="sub_content">
		<div class="schedule_area">
			<div class="schedule_calendar">
				<div class="calendar_top">
					<button class="btn this_month">
						<span>이번달</span>
					</button>
					<a href="#prev" title="이전달 보기">
						<img src="/images/admin/calendar/btn_calendar_prev.png" alt="이전달 보기 버튼" />
					</a>
					<a href="#current" class="go_pop_calendar" title="달력 보기">
						<strong>2017.04</strong>
					</a>
					<a href="#next" title="다음달 보기">
						<img src="/images/admin/calendar/btn_calendar_next.png" alt="다음달 보기 버튼" />
					</a>
					<!-- 달력 년도 및 달 선택 -->
					<div class="choice_layear" style="display:none;">
						<div class="choice_titlearea">
							<strong>직접 선택</strong>
							<a href="#closeChoice">
								<img src="/images/admin/calendar/btn_calendar_pop_close.png" alt="선택 취소" title="선택 취소" />
							</a>
						</div>
						<ul>
							<li>
								<a href="#" data-year="2015">2015년</a>
							</li>
							<li>
								<a href="#" data-year="2016">2016년</a>
							</li>
							<li>
								<a href="#" data-year="2017">2017년</a>
							</li>
							<li>
								<a href="#" data-year="2018">2018년</a>
							</li>
							<li>
								<a href="#" data-year="2019">2019년</a>
							</li>
							<li>
								<a href="#" data-year="2020">2020년</a>
							</li>
							<li>
								<a href="#" data-year="2021">2021년</a>
							</li>
							<li>
								<a href="#" data-year="2022">2022년</a>
							</li>
							<li>
								<a href="#" data-year="2023">2023년</a>
							</li>
							<li>
								<a href="#" data-year="2024">2024년</a>
							</li>
							<li>
								<a href="#" data-year="2025">2025년</a>
							</li>
						</ul>
						<ul>
							<li>
								<a href="#" data-month="1">1월</a>
							</li>
							<li>
								<a href="#" data-month="2">2월</a>
							</li>
							<li>
								<a href="#" data-month="3">3월</a>
							</li>
							<li>
								<a href="#" data-month="4">4월</a>
							</li>
							<li>
								<a href="#" data-month="5">5월</a>
							</li>
							<li>
								<a href="#" data-month="6">6월</a>
							</li>
							<li>
								<a href="#" data-month="7">7월</a>
							</li>
							<li>
								<a href="#" data-month="8">8월</a>
							</li>
							<li>
								<a href="#" data-month="9">9월</a>
							</li>
							<li>
								<a href="#" data-month="10">10월</a>
							</li>
							<li>
								<a href="#" data-month="11">11월</a>
							</li>
							<li>
								<a href="#" data-month="12">12월</a>
							</li>
						</ul>
					</div>
					<!-- //달력 년도 및 달 선택 -->
				</div>
				<div class="calendar_detail">
					<table class="tbl_calendar">
						<caption>달력 화면</caption>
						<colgroup>
							<col style="width: 14%" />
							<col style="width: 14.4%" />
							<col style="width: 14.4%" />
							<col style="width: 14.4%" />
							<col style="width: 14.4%" />
							<col style="width: 14.4%" />
							<col style="width: 14%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">SUN</th>
								<th scope="col">MON</th>
								<th scope="col">TUE</th>
								<th scope="col">WED</th>
								<th scope="col">THU</th>
								<th scope="col">FRI</th>
								<th scope="col">SAT</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				
				<!-- button_area -->
				<div class="button_area margint20">
					<div class="float_right">
						<button class="btn save" title="등록" onclick="goSchedule();">
							<span>등록</span>
						</button>
					</div>
				</div>
				<!--// button_area -->
				
			</div>
			
			<div class="schedule_detail">
				
			</div>
		</div>
	</div>
</div>
<!--// content -->

<div id="modal-schedule" style="background-color:white">
	<div id="wrap">
	
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
			    <div  id="pop_content" >
			    </div>
			</div>
		</article>	
		</div>
		<!-- //container -->
		
	</div>
 </div>