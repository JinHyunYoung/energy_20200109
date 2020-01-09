////////////////////////////////////////////////////////////////
// 페이지 초기화 이벤트  
////////////////////////////////////////////////////////////////

// 메뉴, GNB(사용자 이동경로 네비게이션) 관련
$(document).ready(function(){
	
	$('.left_area').css('min-height', $(document).height() - 0 );

	$('#lnb_split').css('min-height', $(document).height() - 114 );

	$('.lnb_split_box').css('min-height', $(document).height() - 0 );

	$('.btn_split').css('min-height', $(document).height() - 0 );
	
});






////////////////////////////////////////////////////////////////
// 메뉴 생성
////////////////////////////////////////////////////////////////

//메뉴 조회
function loadMenu(s_auth_id, g_topmenu_id, g_submenu_id){
    
    	$.ajax ({
    	    type: "POST",
    	    url: "/admin/menu/authMenuList.do",
    	    data:{
	    		auth_id : s_auth_id,
	    		menu_id : g_topmenu_id,
	    		submenu_id : 'g_submenu_id'
    	    },
    	    dataType: 'json',
    	    success:function(data){
    	    	createTopMenu(data.topMenuList);
    	    	createSubMenu(data.subMenuList);
    	    }
	});
}


//Top 메뉴 생성
function createTopMenu(list){
    
	var str = "", url = "", sizepos = "";
	var menu;
	for(var i =0; i < list.length;i++){
	    
		menu = list[i];
		
		url = "";
		sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
		
		if($.trim(admin_g_topmenu_id) == $.trim(menu.menu_id)){
			str += '<li class="on">';
		} else {
			str += '<li>'; //  class="on"
		}
		
		if(menu.menu_type == "F"){
			url += menu.ref_menu_url;
			str += '	<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\''+menu.ref_menu+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
		}
		
		else if(menu.menu_type == "B"){
			url += "/admin/board/boardContentsListPage.do?board_id="+menu.board;
			str += '	<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
		}
		
		else if(menu.menu_type == "C"){
			url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
			str += '	<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
		}
		
		else{
			url += menu.url;
			str += '	<a href="javascript:goTopMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.menu_nm+'\',\'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
		}
		
		str += '		<span>'+menu.menu_nm+'</span>';
		str += '	</a>';
		str += '</li>';
	}
	
	$("#TopMenu").html(str);
}


// 서브 메뉴 생성		
function createSubMenu(list){
    
	var str = "", url = "", sizepos = "";
	var menu;
	var subIdx = 0;

	for(var i =0; i < list.length;i++){
	    
		menu = list[i];
		console.log(admin_g_submenu_id);
		url = "";
		sizepos = jsNvl(menu.width)+"/"+jsNvl(menu.height)+"/"+jsNvl(menu.left)+"/"+jsNvl(menu.top);
		
		if(menu.lvl == "1"){
		    
			if(subIdx > 0)  {
			    str += '</ul>';
			}
			
			subIdx = 0;
		    if(i > 0) { 
				str += '</li>';
		    }
		    
			str += '<li ';						
			if($.trim(menu.menu_id) == $.trim(admin_g_submenu_id)) {
			    str += 'class="on"';
			}
			
			str += '>';
			if(menu.menu_type == "F"){
				url += menu.ref_menu_url;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.ref_menu+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			else if(menu.menu_type == "B"){
				url += "/admin/board/boardContentsListPage.do?board_id="+menu.board;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			else if(menu.menu_type == "C"){
				url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			else{
				url += menu.url;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			
			str += '		<span>'+menu.menu_nm+'</span>';
			str += '	</a>';
			
		} 
		
		else if(menu.lvl == "2"){
		    
			if(subIdx == 0) { 
			    str += '<ul class="lnb_submenu">'; 
			}

			str += '<li ';
			if($.trim(menu.menu_id) == $.trim(admin_g_submenu_id)) {
				str += 'class="on"';
			}
			str += '>';
			
			if(menu.menu_type == "F"){
				url += menu.ref_menu_url;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			
			else if(menu.menu_type == "B"){
				url += "/admin/board/boardContentsListPage.do?board_id="+menu.board;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			
			else if(menu.menu_type == "C"){
				url += "/web/intropage/intropageShow.do?page_id="+menu.contents;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			
			else{
				url += menu.url;
				str += '	<a href="javascript:goSubMenu(\''+url+'\',\''+menu.menu_id+'\',\''+menu.target_set+'\',\''+sizepos+'\');" title="'+menu.menu_nm+'">';
			}
			
			str += '		<span>'+menu.menu_nm+'</span>';
			str += '	</a>';
			str += '</li>';
			
			subIdx++;
		}
	}
	
	if(subIdx > 0) { 
	    str += '</ul>';
	}
	
	str += '</li>';

	$("#SubMenu").html(str);
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
	    url: "/admin/user/sessionMenu.do",
	    data:{
			topmenu_id : topMenu,
			topmenu_nm : topMenuNm,
			submenu_id : subMenu
	    },
	    dataType: 'json',
	    success:function(data){
	    	goUrl(targetSet, url,  sizepos[0],sizepos[1], sizepos[2], sizepos[3]);
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
	    url: "/admin/user/sessionMenu.do",
	    data:{
	    	submenu_id : subMenu
	    },
	    dataType: 'json',
	    success:function(data){
	    	goUrl(targetSet, url,  sizepos[0],sizepos[1], sizepos[2], sizepos[3]);
	    }
	});
}

//권한 변경
function changeAuth(){
    
	var authId = $("#AuthSelect").val();
	
	$.ajax	({
	    type: "POST",
	    url: "/admin/user/sessionChangeAuthId.do",
	    data:{
        	   auth_id : authId
	    },
	    dataType: 'json',
	    success:function(data){
	    	document.location.href = "/admin/user/main.do";
	    }
	});
}

//메인으로 이동
function goMain(){
	document.location.href = "/admin/user/main.do";
}


// 폴더 여부
var foldYn = "Y";
function changeSplit(){
    
	if(foldYn == "Y"){
	    $("#SplitBar").removeClass("fold");
	    $("#SplitBar").addClass("unfold");
	    $("#MenuArea").hide();
	    foldYn = "N";
	}
	else{
	    $("#SplitBar").removeClass("unfold");
	    $("#SplitBar").addClass("fold");
	    $("#MenuArea").show();
	    foldYn = "Y";					
	}
	
}

//메뉴 설명 오픈
var menuOpenYn = "N";
function menuDescOpen(){
		    
    if(menuOpenYn == "N"){
		$("#menu_desc_area").show();
		$("#menu_desc_btn").html("<img src='/images/admin/common/btn_info_fold.png' alt='닫기' />");
		menuOpenYn = "Y";
    }
    else{
		$("#menu_desc_area").hide();
		$("#menu_desc_btn").html("<img src='/images/admin/common/btn_info_unfold.png' alt='열기' />");
		menuOpenYn = "N";
    }
				
}



////////////////////////////////////////////////////////////////
// 네비게이션 서브 메뉴 생성
////////////////////////////////////////////////////////////////

// 네비게이션 서브 메뉴 생성
function createNaviSubmenu(list){

	var mstr = "";
	$("#NaviSubMenu").html("");
	mstr += '<ul>';
    
	var menu;
	for(var i =0; i < list.length;i++){
		menu = list[i];
		mstr += '<li>';
		mstr += '	<a href="javascript:goPage(\''+menu.menu_id+'\',\'\',\'\');" title="'+menu.menu_nm+'">';
		mstr += '		<span>'+menu.menu_nm+'</span>';
		mstr += '	</a>';
		mstr += '</li>';
	}	
    
	mstr += '</ul>';
    
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



// 페이지로 이동
function goPage(menuId, param, linkurl){

	$.ajax ({
	    type: "POST",
	    url: "/admin/user/sessionPage.do",
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
			    	url += "/admin/board/boardContentsListPage.do?board_id="+data.menu.board;
			    }
	
			    // 컨텐츠
			    else if(data.menu.menu_type == "C"){
			    	url += "/admin/intropage/intropageShow.do?page_id="+data.menu.contents;
			    }
						    
			    // Function, Link
			    else{
			    	url += data.menu.url;
			    }
						
			} else {
			    url += linkurl;
			}
	    			  
			if(param != "") { 
			    url += ( url.indexOf("?") > -1 ? "&" : "?" ) + param;
			}
				  
			goUrl(data.menu.target_set, url, data.menu.width, data.menu.height, data.menu.left, data.menu.top);
			
	    }
	});
}


// URL로 이동
function goUrl(target, url, width,height, xPos, yPos){
    
	if(target == "1")
	    document.location.href = url;
	
	else if(target == "2")
	    window.open(url);
	
	else if(target == "3")
	    openPosPopUp(url, "Popup", width, height, xPos, yPos);
}