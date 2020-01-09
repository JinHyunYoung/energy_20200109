////////////////////////////////////////////////////////////////
// 페이지 초기화 이벤트  
////////////////////////////////////////////////////////////////

// 메뉴, GNB(사용자 이동경로 네비게이션) 관련
$(document).ready(function(){

    // GNB 히든 처리
    $('.gnb nav div').hide();

    // GNB 에서 on 삭제
    $('.gnb nav a').removeClass('on');

    // 화면 스크롤 설정
    $('html').css('overflow-x','auto');

    // 메뉴 높이 설정
    $('.nav').css('min-height', $(document).height() - 0 );


});





////////////////////////////////////////////////////////////////
// 메뉴 관련 이벤트
////////////////////////////////////////////////////////////////

// 메뉴 선택시 이벤트 처리
$(".liMn").each(function(idx, obj){

    // 페이지 열릴때 모든매뉴 닫기 (첫번째꺼 빼고)
    if(idx != 0){
        $(".Depth1_area").eq(idx).hide();
    } else {
        $(this).attr("class","on liMn");
    }

    // 토글버튼
    $(this).children("[name=aTag]").click(function(){

        if($(this).parent().attr("class").indexOf("on")){
            $(this).parent().attr("class","on liMn");
        }else{
            $(this).parent().attr("class","liMn");
        }

        $(this).next("ul").slideToggle();
    });
});


// GNB 메뉴의 on 이벤트 처리
$('.gnb nav').on({
    mouseenter:function(){
        if($(window).width() > 1024){
            $(this).addClass('on');
            $('.gnb nav').append('<div class="nav_bg"><span></span></div>');
            $('.gnb div').show();
            $('html').css('overflow-x','hidden');
        }
    }
});


// GNB 메뉴의 하위 메뉴 이벤트 처리
$('.gnb nav > ul > li > div').each(function(i, e){

    $(e).mouseenter(function(){
        $(this).prev().addClass('on');
        $(this).parent().siblings().children('a').removeClass('on');
    });

    $(e).prev().mouseleave(function(){
        $(this).removeClass('on');
    });
});


// GNB 메뉴에서 마우스가 벗어날 때 이벤트 처리
$('.gnb').mouseleave(function(){

    $('.gnb nav div').hide();
    $('.gnb nav a').removeClass('on');
    $('html').css('overflow-x','auto');

});


////////////////////////////////////////////////////////////////
// 메뉴 생성
////////////////////////////////////////////////////////////////

//메뉴 조회
function loadMenu(){

    $.ajax ({

        type: "POST",
        url: "/web/user/homepageMenuList.do",
        dataType: 'json',
        async:false,
        success:function(data){
            createTopMenu(data.topMenuList);
            // createMobileMenu(data.topMenuList);
        }

    });
}


//Top 메뉴 생성
function createTopMenu(list){

    var str = "", url = "", sizepos = "", topMenuId = "", upMenuId = "",  preLevel = 0, lvl3_sub_cnt = 0;
    var menu;

    // 메뉴 구성
    for(var i = 0; i < list.length;i++){

        menu = list[i];

        url = "";
        sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);

        if(preLevel == 1){

            // str += '<button class="btn_nav_close" onclick="closeMenu();" title="메뉴닫기">';
            // str += '	<span>메뉴닫기</span>';
            // str += '</button>';

            str += '</li>';
        }

        else if(preLevel == 2 && menu.level == 1){
            //close2
            str += '		</ul>';
            str += '	</div>';
            str += '</li>';
        }

        else if(preLevel == 3 && menu.level == 1){
            //close3
            str += '		</ul>';
            str += '	</div>';
            str += '</li>';

            //close2
            str += '		</ul>';
            str += '	</div>';
            str += '</li>';
        } else if(preLevel == 3 && menu.level == 2){
            //close3
            str += '		</ul>';
        }

        url = "";

        // Top 메뉴 일 경우 (1 레벨)
        if(menu.level == 1){

            str += '<li>';

            // Folder
            if(menu.menu_type == "F"){
                url += menu.ref_menu_url;
                str += '<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\''+menu.ref_menu+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'" >'+menu.menu_nm+'</a>';
            }

            // Board
            else if(menu.menu_type == "B"){
                url += "/web/board/boardContentsListPage.do?board_id="+menu.board;
                str += '<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'" >'+menu.menu_nm+'</a>';
            }

            // Contents
            else if(menu.menu_type == "C"){
                url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
                str += '<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'" >'+menu.menu_nm+'</a>';
            }

            // Function or Link
            else {
                url += menu.url;
                str += '<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'" >'+menu.menu_nm+'</a>';
            }

            if(menu.sub_cnt > 0){

                // str += '  <div id="submenu_'+menu.sort+'" class="sub_menu" >';
                // str += '  	<dl class="web_gnb">';
                // str += '  		<dt class="title">';
                // str += '  			<div><strong class="title">'+menu.menu_nm+'</strong></div>';
                // str += '  		</dt>';
                // str += '  		<dd class="menu_list">';
                str += '<ul class="snb_list snb_area_'+i+'">';
            }
        }

        // Sub 메뉴 일 경우 (2 레벨)
        else if(menu.level == 2){

            str += '<li>';

            // Folder
            if(menu.menu_type == "F"){
                url += menu.ref_menu_url;
                str += '				<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a>';
            }

            // Board
            else if(menu.menu_type == "B"){
                url += "				/web/board/boardContentsListPage.do?board_id="+menu.board;
                str += '				<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a>';
            }

            // Contents
            else if(menu.menu_type == "C"){
                url += "				/web/intropage/intropageShow.do?page_id="+menu.contents;
                str += '				<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a>';
            }

            // Function or Link
            else{
                url += menu.url;
                str += '				<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a>';
            }

            lvl3_sub_cnt = menu.sub_cnt;

            if(menu.sub_cnt > 0){
                str += '  				<ul>';
            }
        }

         // Sub 메뉴 일 경우 (3 레벨) 퍼블리싱 변경으로 메인 top 3레벨 제거
         else if(menu.level == 3){
        
         	// Folder
         	if(menu.menu_type == "F"){
         		url += menu.ref_menu_url;
         		str += '      				<li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.ref_menu+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a></li>';
         	}
        
         	// Board
         	else if(menu.menu_type == "B"){
         		url += "					/web/board/boardContentsListPage.do?board_id="+menu.board;
         		str += '      				<li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a></li>';
         	}
        
         	// Contents
         	else if(menu.menu_type == "C"){
         		url += "					/web/intropage/intropageShow.do?page_id="+menu.contents;
         		str += '      				<li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a></li>';
         	}
        
         	// Function or Link
         	else{
         		url += menu.url;
         		str += '      				<li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">'+menu.menu_nm+'</a></li>';
         	}
        
         }

        preLevel = menu.level;

    }

    if(preLevel == 2 && lvl3_sub_cnt == 0){
        //close2
        str += '</li>';

    } else if(preLevel == 2 && lvl3_sub_cnt != 0) {
        //close2
        str += '		</ul>';
        str += '	</div>';
        str += '</li>';
    } else if(preLevel == 3) {
        str += '			</ul>'
        str += '		</ul>';
        str += '	</div>';
        str += '</li>';
    }
    //close1

    str += '</li>';

    $("#TopMenu").html(str);
}


// 메뉴 닫기
function closeMenu(){

    $('.gnb nav div').hide();
    $('.gnb nav a').removeClass('on');
    $('html').css('overflow-x','auto');
}


// 모바일 메뉴 생성
function createMobileMenu(list){

    var str = "", url = "",upMenuId = "", subCnt = 0, sizepos = "";
    var menu;

    for(var i = 0; i < list.length;i++){

        menu = list[i];

        url = "";
        sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);

        if(upMenuId != menu.up_menu_id){

            if(i > 0){
                str += '    </ul>';
                str += '</li>';
            }

            str += '<li class="liMn">';
            str += '  <a href="#" title="'+menu.menu_nm+'" id="atag'+menu.sort+'" name="aTag"><span>'+menu.menu_nm+'</span></a>';

            if(menu.sub_cnt > 0){
                str += '  <ul class="Depth1_area">';
                subCnt = menu.sub_cnt;
            } else {
                subCnt = 0;
            }

        }

        else {

            if(menu.menu_type == "F"){
                str += '      <li><a href="javascript:goSubMenu(\''+menu.ref_menu_url+'\',\''+menu.ref_menu+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'"><span>'+menu.menu_nm+'</span></a></li>';
            }

            else if(menu.menu_type == "B"){
                url += "/web/board/boardContentsListPage.do?board_id="+menu.board;
                str += '      <li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'"><span>'+menu.menu_nm+'</span></a></li>';
            }

            else if(menu.menu_type == "C"){
                url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
                str += '      <li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'"><span>'+menu.menu_nm+'</span></a></li>';
            }

            else{
                url += menu.url;
                str += '      <li><a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'"><span>'+menu.menu_nm+'</span></a></li>';
            }
        }

        upMenuId = menu.up_menu_id;
    }

    str += '    </ul>';
    str += '</li>';

    $("#MobileTopMenu").html(str);
}


// Top 메뉴로 이동
function goTopMenu(url, topMenu, topMenuNm, subMenu, targetSet, sizepos){

    if(url == "undefined"){
        alert("준비중입니다.");
        return;
    }

    sizepos = sizepos.split("/");

    $.ajax ({

        type: "POST",
        url: "/web/user/sessionMenu.do",
        data:{
            topmenu_id : topMenu,
            topmenu_nm : topMenuNm,
            submenu_id : subMenu
        },
        dataType: 'json',
        success:function(data){
            goUrl(targetSet, url,  sizepos[0], sizepos[1], sizepos[2], sizepos[3]);
        }
    });
}


//서브 메뉴로 이동
function goSubMenu(url, subMenu, targetSet, sizepos){

    if(url == "undefined"){
        alert("준비중입니다.");
        return;
    }

    sizepos = sizepos.split("/");

    $.ajax	({

        type: "POST",
        url: "/web/user/sessionMenu.do",
        data:{
            submenu_id : subMenu
        },
        dataType: 'json',
        success:function(data){
            goUrl(targetSet, url, sizepos[0],sizepos[1], sizepos[2], sizepos[3]);
        }
    });
}

//서브 메뉴 보여주기
function showSubMenu(idx){
    $("#submenu_"+idx).show();
}


//서브 메뉴 숨기기
function hideSubMenu(idx){
    $("#submenu_"+idx).hide();
}


// 서브 메뉴 생성
function createSubMenu(list,up_menu_id){
    
    var str = "", url = "", sizepos = "";
    var menu;
    var subIdx = 0;
    var sub_cnt =0;
    var preLevel =0;
    var lvl3_sub_cnt = 0;
    var close =0;
    var up_2lv_menu_id;
	var s_menu = new Array();
    debugger;
    for(var i =0; i < list.length;i++){

        menu = list[i];

        url = "";
        sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
        // console.log(menu);
        // var  = $('#web_g_submenu_id').val();
        var ck_level2 = $.trim(menu.up_menu_id);
        var ck_ref_menu = $.trim(menu.ref_menu);
        if(menu.level == "2" ){
            if(menu.up_menu_id ==web_g_topmenu_id){
                if($.trim(menu.menu_id) == $.trim(web_g_submenu_id) || $.trim(menu.menu_id) == web_g_up_menu_id){
					s_menu[menu.menu_id] = $.trim(menu.menu_id);
                    str += '<li class="active">';
                }else{
                    str += '<li>';
                }

                if(menu.menu_type == "F" && ck_ref_menu == ''){
                    url += menu.ref_menu_url;
                    str += '	<a   href="#collapseOne">';
                }

                else if(menu.menu_type == "B"){
                    url += "/web/board/boardContentsListPage.do?board_id="+menu.board;
                    str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
                }

                else if(menu.menu_type == "C"){
                    url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
                    str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
                }

                else if(ck_ref_menu != '' ){
                    str += '	<p>';
                }

                else{
                    url += menu.url;
                    str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
                }

                str += '		<span>'+menu.menu_nm+'</span>';

                if(ck_ref_menu != '' ){
                    str += '	</p>';
                } else {
                    str += '	</a>';
                }
                if(menu.sub_cnt > 0){
                    sub_cnt=menu.sub_cnt;
                    up_2lv_menu_id =menu.menu_id; //3차메뉴가 발견되면 자신의 메뉴아이디를 반환
                }
            }
        }

        else if(menu.level == "3"){
            if(menu.up_menu_id == up_2lv_menu_id) {
                if (subIdx == 0) {
					if(s_menu[menu.up_menu_id] == menu.up_menu_id){
	                    str += '<ul style="" class="ndispnone sub3level">';
					} else {
	                    str += '<ul style="" class="sub3level">';
					}
                }

                if ($.trim(menu.menu_id) == $.trim(web_g_submenu_id)) {
                    str += '<li class="active">';
                } else {
                    str += '<li>';
                }

                if (menu.menu_type == "F") {
                    url += menu.ref_menu_url;
                    str += '	<a href="javascript:goSubMenu(\'' + url + '\',\'' + menu.menu_id + '\',\'' + menu.target_set + '\',\'' + sizepos + '\');" title="' + menu.menu_nm + '">';
                }

                else if (menu.menu_type == "B") {
                    url += "/admin/board/boardContentsListPage.do?board_id=" + menu.board;
                    str += '	<a href="javascript:goSubMenu(\'' + url + '\',\'' + menu.menu_id + '\',\'' + menu.target_set + '\',\'' + sizepos + '\');" title="' + menu.menu_nm + '">';
                }

                else if (menu.menu_type == "C") {
                    url += "/web/intropage/intropageShow.do?page_id=" + menu.contents;
                    str += '	<a href="javascript:goSubMenu(\'' + url + '\',\'' + menu.menu_id + '\',\'' + menu.target_set + '\',\'' + sizepos + '\');" title="' + menu.menu_nm + '">';
                }

                else {
                    url += menu.url;
                    str += '	<a href="javascript:goSubMenu(\'' + url + '\',\'' + menu.menu_id + '\',\'' + menu.target_set + '\',\'' + sizepos + '\');" title="' + menu.menu_nm + '">';
                }

                str += '		<span> - ' + menu.menu_nm + '</span>';
                str += '	</a>';
                str += '</li>';
                if (subIdx <= sub_cnt) {
                    subIdx++;

                }
                if (subIdx == sub_cnt) {
                    str += '</ul>';
                    subIdx = 0;
                }
            }
        }
        // if(subIdx == menu.sub_cnt) {
        //     str += '</ul>';
        // }

    }



    str += '</li>';

    $(".lnb_list").html(str);

}


////////////////////////////////////////////////////////////////
// 네비게이션 서브 메뉴 생성
////////////////////////////////////////////////////////////////

// 네비게이션 서브 메뉴 생성
function createNaviSubmenu(list){

    var mstr = "";

    $("#NaviSubMenu").html("");
    // $(".lnb_list").html("");
    // mstr += '<ul class="lnb_list">';
    var web_g_submenu_id = $('#web_g_submenu_id').val();

    debugger;
    var menu;
    // var listRef;
    //서브페이지 3차메뉴
    for(var i =0; i < list.length;i++){
        menu = list[i];
        if($.trim(menu.menu_id) == $.trim(web_g_submenu_id)){
            mstr += '<span class="active">';
        }else{
            mstr += '<span>';
        }

        mstr += 	'<a href="javascript:goPage(\''+menu.menu_id+'\',\'\',\'\');" title="'+menu.menu_nm+'">';
        mstr += menu.menu_nm;
        mstr += 	'</a>';
        // mstr += '</li>';

    }

    // mstr += '</ul>';
    // $(".lnb_list").html(mstr);
    $("#NaviSubMenu").html(mstr);
}

// 네비게이션 메뉴 보여주기
function showNaviSubmenu(){

    if($("#NaviSubMenu").css("display") == "none"){
        $("#NaviSubMenu").show();
    } else {
        $("#NaviSubMenu").hide();
    }

}




////////////////////////////////////////////////////////////////
// 탭 관련
////////////////////////////////////////////////////////////////

// 탭 더보기 이벤트
function goTabMore(tab){

    var tabIndex = 0;

    if(tab == 1){
        if($("#first_tab > li:eq(0)").attr('class') == 'active') tabIndex = 0;
        else if($("#first_tab > li:eq(1)").attr('class') == 'active') tabIndex = 1;
    }
    else if(tab == 2){
        if($("#second_tab > li:eq(0)").attr('class') == 'active') tabIndex = 0;
        else if($("#second_tab > li:eq(1)").attr('class') == 'active') tabIndex = 1;
        else if($("#second_tab > li:eq(2)").attr('class') == 'active') tabIndex = 2;
    }

    // 인증정보(국내)
    if( tab == 1 && tabIndex == 0 ) {
        goPage('a03180a4be024e73aae8cde4c3674d58', '','');
    }

    // 인증정보(해외)
    else if ( tab == 1 && tabIndex == 1 ) {
        goPage('a03180a4be024e73aae8cde4c3674d58', '','');
    }

    // 특허정보
    else if ( tab == 2 && tabIndex == 0 ) {
        goPage('006d79006a604f24910d52714a0b1478', '','');
    }

    // 신기술정보
    else if ( tab == 2 && tabIndex == 1 ) {
        goPage('7aaac68f3f3e47308214146493d9b360', '','');
    }

    // 참고자료
    else if ( tab == 2 && tabIndex == 2 ) {
        goPage('4da865c6d5754d68a881d905f6afff99', '','');
    }
}


// 언어 변경
function changeLanguage(lang){

    if(lang == "lan_kor"){
        $("a.lan_kor").addClass('active');
        $("a.lan_eng").removeClass('active')
    } else {
        $("a.lan_kor").removeClass('active')
        $("a.lan_eng").addClass('active');
    }
}


////////////////////////////////////////////////////////////////
// 게시판 관련
////////////////////////////////////////////////////////////////

// 게시판 조회
function loadBoard(boardid, size, domesticyn){

    $.ajax({

        type: "POST",
        url: "/web/board/loadMainBoard.do",
        data:{
            board_id : boardid,
            size : size,
            domestic_yn : domesticyn
        },
        dataType: 'json',
        success:function(data){
            makeBoard(data.list, boardid, domesticyn);
        }
    });
}


// 게시판 화면 설정
function makeBoard(data, boardid, domesticyn){

    var html = "";
    if(data != null){

        $.each(data,function(key,obj){

            // 인증 및 규격정보
            if(boardid == "30") {
            	html += '<li><div class="first_comments">';
            	if(obj.image_file_nm != undefined){
            	html += '	<div class="th_img" style="background-image: url(\'/contents/board/'+obj.image_file_nm+'\');">';
            	html += '		<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'" target="_self"></a>';
            	html += '	</div>';
            	}
            	html += '	<div class="title_txt">';
            	html += '	  <a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'" target="_self">'+obj.title+'</a>';
            	html += '	</div>';
            	html += '</div></li>';
            }
            // 물산업 보고서
            else if(boardid == "9") {
                html += '<li>';
                html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';

                if(obj.image_file_nm != undefined){
                    html += '	<img src="/contents/board/'+obj.image_file_nm+'" width="88" height="122" alt="썸네일" />';
                }

                html += '	</a>';
                html += '</li>';
            }

            // 뉴스레터
            else if(boardid == "10") {
                html += '	<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
                html += '		'+obj.title+'';
                html += '	</a>';
            }

            // 신기술정보, 특허정보, 참고자료, 기업지원사업, 법령 및 정책, 공지사항
            else {
                html += '<li>';
                html +=     '<div class="first_comments">';
                html +=         '<div class="title_txt">';
                html +=             '<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
                html +=             ''+obj.title+'';
                html +=             '</a>';
                html +=         '</div>';
                html +=         '<div class="contents_txt">';
                html +=             '<a href="javascript:contentsViewMain(\''+boardid+'\',\''+obj.contents_id+'\')" title="'+obj.title+'">';
                html +=             ''+obj.contents+'';
                html +=             '</a>';
                html +=         '</div>';
                html +=         '<div class="date_txt">'+obj.reg_date+'</div>';
                html +=     '</div>';
                html += '</li>';
            }
            //goTabMore 구분
            if(boardid == "1" || boardid=="2"){
                html += '<li class="more">';
                html += '<a href="javascript:goTabMore(\'1\')" class="btn_more" title="정보 더보기">';
                html += '<img src="/images/web/main/btn_more.png" alt="더보기" />';
                html += '</a>';
                html += '</li>';
            }
            else if(boardid == "3" || boardid=="5"){
                // html += '<li class="more">';
                // html += '<a href="javascript:goTabMore(\'2\')" class="btn_more" title="정보 더보기">';
                // html += '<img src="/images/web/main/btn_more.png" alt="더보기" />';
                // html += '</a>';
                // html += '</li>';
                // html += '<li>
            }
        });

    } else{
        html += '<li><a href="#"">등록된 내용이 없습니다.</a></li>';
    }

    // 동일한 게시판에서 정보를 수집할 경우
    if(domesticyn != null && domesticyn != ""){
        boardid = boardid + "_" + domesticyn;
    }
    $("#main_board_"+boardid).html(html);
}


//컨텐츠 상세화면 바로가기
function contentsViewMain(boardid, contentsid){

    var menuid = "";


    // 공지사항
    if(boardid == "27"){
        menuid = "fd20fda33e39499a93bbec362155e145";
    }
    if(boardid == "28"){
        menuid = "75cfef9badc24788a145f8836d849803";
    }
    if(boardid == "29"){
        menuid = "ce13ce40f41348fdb7ce706b249e1de6";
    }
    //if(boardid == "31"){
    //    menuid = "c06fce73d41942b5bbf5155f9cd12dc3";
    //}
    if(boardid == "30"){
        menuid = "69779fd8d5874a08a4676e5d64c69247";
    }

    goPage(menuid, 'contents_id='+contentsid, '/web/board/boardContentsView.do');
}


// 페이지로 이동
function goPage(menuId, param, linkurl){

    $.ajax ({

        type: "POST",
        url: "/web/user/sessionPage.do",
        data:{
            menu_id : menuId
        },
        dataType: 'json',
        success:function(data){

            url = "";
            if(linkurl == undefined || linkurl == "") {

                // Folder
                if(data.menu.menu_type == "F"){
                    url += data.menu.ref_menu_url;
                }

                // 게시판
                else if(data.menu.menu_type == "B"){
                    url += "/web/board/boardContentsListPage.do?board_id="+data.menu.board;
                    console.log(url);
                }

                // 컨텐츠
                else if(data.menu.menu_type == "C"){
                    url += "/web/intropage/intropageShow.do?page_id="+data.menu.contents;
                }

                // Function, Link
                else{
                    url += data.menu.url;
                }

            } else {
                url += linkurl;
            }

            if(param != "") url += ( url.indexOf("?") > -1 ? "&" : "?" ) + param;

            goUrl(data.menu.target_set, url, data.menu.width,data.menu.height, data.menu.left, data.menu.top);

        }
    });
}


// URL로 이동
function goUrl(target, url, width, height, xPos, yPos){

    if(target == "1")
        document.location.href = url;

    else if(target == "2")
        window.open(url);

    else if(target == "3")
        openPosPopUp(url, "Popup", width, height, xPos, yPos);
}




////////////////////////////////////////////////////////////////
// 배너 관련
////////////////////////////////////////////////////////////////

// 배너 조회
function loadBanner(region){

    $.ajax({

        type: "POST",
        url: "/web/banner/loadMainBanner.do",
        data:{
            region : region,
        },
        dataType: 'json',
        success:function(data){
            makeBanner(region, data.list);
        }
    });
}


//배너 화면 설정
function makeBanner(region, data){

    var html = "";
    var target =  "";
    var cnt = 0;
    var go = "";

    if(data != null){

        html = "";

        jQuery.each(data,function(key,obj){

            cnt++;

            if(obj.target == 3){
                target = "_blank";
            } else {
                target =  "_self";
            }

            if(region == 1){

                go = "javascript:goPage('"+obj.url+"', '', '')";

                html += '<li>';
                html += '	<a href="'+go+'" title="'+obj.titl_nm+'" target="'+target+'" >';
                html += '		<img src="/contents/banner/'+obj.image_nm+'" alt="'+obj.titl_alt+'" title="'+obj.titl_alt+'" />';
                html += '		<span>'+obj.titl_nm+'</span>';
                html += '	</a>';
                html += '</li>';

            } else if(region == 2){

                html += '<li>';
                html += '	<img src="/contents/banner/'+obj.image_nm+'" alt="'+obj.titl_alt+'" title="'+obj.titl_alt+'" />';
                html += '</li>';

            }

        });

    } else {
        html += '<p>등록된 내용이 없습니다.</p>';
    }

    $("#main_banner"+region).html(html);

}




////////////////////////////////////////////////////////////////
//팝업 공지 관련
////////////////////////////////////////////////////////////////

//팝업 공지 조회
function loadPopupNoti(){

    $.ajax({

        type: "POST",
        url: "/web/popnoti/popnotiList.do",
        dataType: 'json',
        success:function(data){
            makePopupNoti(data.list);
        }
    });

}


//팝업 공지 생성
function makePopupNoti(data){

    var html = "";
    var cnt = 0;

    if(data != ""){

        $.each(data,function(key,obj){

            if (getCookie(obj.noti_id) != "done"){

                html = "";
                html += '<div id="layerPop_'+cnt+'" style="position:absolute; background-color:white; top: '+obj.top+'px; left: '+obj.left+'px; width: '+obj.width+'px; height: '+obj.height+'px;overflow:auth;z-index:99999;" >';

                html += '	<div id="pop_header">';
                html += '		<header>';
                html += '			<h1 class="pop_title">'+obj.title+'</h1>';
                html += '			<a href="#" class="pop_close" title="페이지 닫기" onClick="closeNoti('+cnt+')">';
                html += '				<span>닫기</span>';
                html += '			</a>';
                html += '		</header>';
                html += '	</div>';

                html += '	<div id="pop_container" style="background-color:white;" class="pop_wrap">';
                html += '		<article>';
                html += '			<div class="pop_content_area">';
                html += '				<div class="pop_content_line">';
                html += '					<div id="pop_content" style="height: '+obj.height+'px;overflow:auto;">'+obj.contents+'</div>';
                html += '				</div>';
                html += '			</div>';

                if(obj.file_id != undefined){
                    html += '			<div class="file_box">';
                    html += '				<strong>첨부파일 : </strong>';
                    html += '				<ul>';
                    html += '					<li>';
                    html += '					<a href="/commonfile/fileidDownLoad.do?file_id='+obj.file_id+'"  target="_blank" title="다운받기"><span>'+obj.file_nm+'</span></a>';
                    html += '					</li>';
                    html += '				</ul>';
                    html += '			</div>';
                }

                html += '		</article>';
                html += '	</div>';

                html += '	<div id="pop_footer" style="background-color:white; border-top: 0px;" class="pop_wrap">';
                html += '		<footer>';
                html += '			<div class="close_area">';
                html += '				<input type="checkbox" id="chk" name="chk" value="Y" onClick="showWeekNot(\''+obj.noti_id+'\',\''+cnt+'\')"><span>일주일 동안 보지 않기</span>';
                html += '				<a href="#" title="팝업창 닫기" onClick="closeNoti('+cnt+')"><span>[닫기]</span></a>';
                html += '			</div>';
                html += '		</footer>';
                html += '	</div>';

                html += '</div>';

                $("body").append(html);

                cnt++;
            }

        });

    }
}


//공지 닫기
function closeNoti(num){
    $('#layerPop_'+num).hide();
}


//주간 공지 보여주기
function showWeekNot(id, num){
    setCookie(id , "done" , 7);
    closeNoti(num);
}






////////////////////////////////////////////////////////////////
//배너 관련
////////////////////////////////////////////////////////////////

//배너 조회
function loadOrgan(){

    $.ajax({

        type: "POST",
        url: "/web/organ/loadMainOrganList.do",
        data:{
        },
        dataType: 'json',
        success:function(data){
            makeOrgan(data.list);
        }
    });
}


//배너 화면 설정
function makeOrgan(data){

    var html = "", html_1 = "", html_2 = "", html_3 = "", html_4 = "";

    if(data != null){

        $.each(data,function(key,obj){

            html = "";
            html += '<li>';
            html += '	<a href="javascript:goOrganHomepage(\''+obj.organ_gb+'\',\''+obj.organ_homepage+'\')" title="'+obj.organ_nm+'">';
            html += '		<span>'+obj.organ_nm+'</span>';
            html += '	</a>';
            html += '</li>';

            if(obj.organ_gb == 1) html_1 += html;
            else if(obj.organ_gb == 2) html_2 += html;
            else if(obj.organ_gb == 3) html_3 += html;
            else if(obj.organ_gb == 4) html_4 += html;

        });

    }

    $("#main_footer_sub_menu_1").html(html_1);
    $("#main_footer_sub_menu_2").html(html_2);
    $("#main_footer_sub_menu_3").html(html_3);
    $("#main_footer_sub_menu_4").html(html_4);

}

//해당 기관 목록 보여주기
function goOrganHomepage ( organ_gb, url ){
    window.open(url);
    $('#footer_sub_menu_'+organ_gb).toggle();
}

// 해당 기관 목록 보여주기
function showOrganList( organ_gb ){
    $('#footer_sub_menu_'+organ_gb).toggle();
}



// 관련기관 상세 바로가기
function goOrganList( organ_gb ){
    goPage( '12036f4b80644b32b6c6da5b0ad5e292' , 'organ_gb=' + organ_gb , '' );
}




////////////////////////////////////////////////////////////////
// 행사일정 관련
////////////////////////////////////////////////////////////////

// 행사일정 조회
function loadSchedule(size){

    $.ajax({

        type: "POST",
        url: "/web/support/loadMainScheduleList.do",
        data:{
            size : size
        },
        dataType: 'json',
        success:function(data){
            makeSchedule(data.list);
        }
    });
}


// 행사일정 화면 설정
function makeSchedule(data){

    var html = "";
    var cnt = 0;
    if(data != null){
        jQuery.each(data,function(key,obj){
            html += '<li>';
            html += '	<a href="javascript:scheduleView( \'' + obj.evt_sn + '\' , \'' + obj.evt_strt_dt.substring( 0 , 7 ) + '\' );" title="해당페이지로 이동">';
            html += '		' + obj.evt_ttle;
            html += '	</a>';
            if(obj.evt_strt_dt == obj.evt_end_dt){
                html += '	<span class="date">'+ obj.evt_strt_dt + '</span>';
            } else {
                html += '	<span class="date">'+ obj.evt_strt_dt + ' ~ ' + obj.evt_end_dt + '</span>';
            }
            html += '</li>';
        });
    } else {
        html += '<p>등록된 내용이 없습니다.</p>';
    }

    $("#main_schedule").html(html);
}


// 행사일정 상세 바로가기
function scheduleView( evt_sn , evt_yymm ){
    goPage( '7643ca0399b549d9b38c96ce01324aef' , 'evt_sn=' + evt_sn + '&evt_yymm=' + evt_yymm , '' );
}



////////////////////////////////////////////////////////////////
// FAQ 관련
////////////////////////////////////////////////////////////////

// FAQ 조회
function loadFaq(size){

    $.ajax({
        type: "POST",
        url: "/web/board/loadMainFaq.do",
        data:{
            size : size
        },
        dataType: 'json',
        success:function(data){
            makeFaq(data.list);
        }
    });
}

// FAQ 화면 설정
function makeFaq(data){

    var html = "";
    var cnt = 0;
    if(data != null){
        jQuery.each(data,function(key,obj){
            cnt++;
            html += '<li>';
            html += '	<span class="num">'+cnt+'</span>';
            html += '	<a href="javascript:faqView(\''+obj.faq_id+'\')"" class="notice_contents_list_txt" title="해당페이지로 이동">';
            html += '		<span>'+obj.title+'</span>';
            html += '	</a>';
            html += '</li>';
        });
    } else {
        html += '<p>등록된 내용이 없습니다.</p>';
    }

    $("#main_faq").html(html);
}

// FAQ 상세 바로가기
function faqView(faqid){
    goPage('b935fd907c2d4be287bc23139c6cd4fc', 'faq_id='+faqid, '');
}

////////////////////////////////////////////////////////////////
// 기타
////////////////////////////////////////////////////////////////

// 현재 포커스 알아오기
function menuBlur(){
    $(".sub_menu").css("display","none");
    $(".nav_bg").css("display","none");
}

// 웹툰 이동
function fn_webtoon_go(val){
    var windowHeight=document.all?document.body.clientHeight:window.sub_menuHeight;
    var height = windowHeight - 90;
    window.open("/info/webtoon_view.php?no=" +val, "webtoon_01", "width=720,height="+height+",scrollbars=1,top=90");
}