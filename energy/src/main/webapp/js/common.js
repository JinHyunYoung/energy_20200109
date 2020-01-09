$(window).load(function(){
	
	
	$( ".gnb_menu > ul, .snb_hader_bg" ).hover(
		function(){
			gnb_over_ck( $( window ).width(), "show" );
		}, function(){
			gnb_over_ck( $( window ).width(), "hide" );
		}
	);

	$('.gnb_menu > ul > li > a').focusin(function() {
		gnb_over_ck( $( window ).width(), "show" );
	});

	$('.snb_list > li > a').focusin(function() {
		gnb_over_ck( $( window ).width(), "show" );
	});
	$('.snb_list > li:last-child > a').focusout(function() {
		gnb_over_ck( $( window ).width(), "hide" );
	});


	$( ".mobile_menu" ).click(function(){
		gnb_mobile_ck( $( window ).width(), "toggle" );
	});

	$( ".gnb_menu > ul > li" ).click(function(){
		gnb_mobile_ck_s( $( window ).width(), this );
	});

	$( "#family_site_bt" ).click(function(){
		var site_value = $( "select[name='family_site']" ).val();
		if(site_value == ""){
			alert( "패밀리사이트를 선택해주세요." );
			return;
		}
		window.open( site_value );
	});

	$( ".layer_close" ).click(function(){
		// alert('111111');
		$( ".layer_sitemap" ).hide();
	});
	$( ".sitemap_bt" ).click(function(){
		$( ".layer_sitemap" ).show();

		$.ajax({
			type:"POST",
			url: "/web/integration/siteMapShow.do",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				$(".layer_sitemap").html(data);
				console.log(data);
			},
			error: function(xhr,status,error){
				//에러!
				alert("code:"+xhr.status);
			}
		});

	});
	$( ".sitemap_bt2" ).click(function(){
		$( ".layer_sitemap" ).show();

		jQuery.ajax({
			type:"GET",
			url: "/web/integration/siteMapShow.do",
			dataType: "html",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				$( ".layer_sitemap" ).html(data);
			},
			error: function(xhr,status,error){
				//에러!
				alert("code:"+xhr.status);
			}
		});

	});


});

function gnb_over_ck(wsize, viewtype){
	if(wsize > 1024){
		if(viewtype == "show"){
			$( ".snb_list" ).show();
			$( ".snb_hader_bg" ).show();
		} else {
			$( ".snb_list" ).hide();
			$( ".snb_hader_bg" ).hide();
		}
	}
}

function gnb_mobile_ck(wsize, viewtype){
	if(wsize < 1024){
		$( "#nav > nav > div.gnb > ul > li.gnb_menu" ).toggle( "fast" );
	}
}

function gnb_mobile_ck_s(wsize, data){
	if(wsize < 1024){
		$( data ).find( "ul" ).toggle( "fast" );
	}
}

$( window ).resize(function() {
	if($( window ).width() > 1024){
		$( "#nav > nav > div.gnb > ul > li.gnb_menu" ).show();
	} else {
		$( "#nav > nav > div.gnb > ul > li.gnb_menu" ).hide();
	}
});

/*
* 이메일 체크
* 
* @param email
* @return boolean
*/
function isEmail(email) {
	re = /[^@]+@[A-Za-z0-9_-]+[.]+[A-Za-z]+/;

	if (re.test(email)) {
		return true;
	}

	return false;
}