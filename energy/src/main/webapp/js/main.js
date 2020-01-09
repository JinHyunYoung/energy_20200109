$(window).load(function(){
	$( ".webzin_more_bt" ).hide();
	$( ".webzin_list" ).hide();

	$( ".w_obj_more_1" ).show();
	$( ".w_obj_1" ).show();

	$( "#w_bt_1" ).click(function(){
		$( ".webzin_more_bt" ).hide();
		$( ".webzin_list" ).hide();
		$( ".w_obj_more_1" ).show();
		$( ".w_obj_1" ).show();
	});

	$( "#w_bt_2" ).click(function(){
		$( ".webzin_more_bt" ).hide();
		$( ".webzin_list" ).hide();
		$( ".w_obj_more_2" ).show();
		$( ".w_obj_2" ).show();
	});

	$( "#w_bt_3" ).click(function(){
		$( ".webzin_more_bt" ).hide();
		$( ".webzin_list" ).hide();
		$( ".w_obj_more_3" ).show();
		$( ".w_obj_3" ).show();
	});


	$( ".board_more_bt" ).hide();
	$( ".board_list" ).hide();

	$( ".b_obj_more_1" ).show();
	$( ".b_obj_1" ).show();


	var ma_wsize = $( window ).width();
	if(ma_wsize > 650){
		$( "#b_bt_1 " ).find("span").show();
	}

	$( "#b_bt_1" ).click(function(){
		$( ".viewlink" ).removeClass( "active" );
		$( ".more_bt" ).hide();
		$( this ).addClass( "active" );
		$( this ).find("span").show();
		$( ".board_more_bt" ).hide();
		$( ".board_list" ).hide();
		$( ".b_obj_more_1" ).show();
		$( ".b_obj_1" ).show();
	});

	$( "#b_bt_2" ).click(function(){
		$( ".viewlink" ).removeClass( "active" );
		$( ".more_bt" ).hide();
		$( this ).addClass( "active" );
		$( this ).find("span").show();
		$( ".board_more_bt" ).hide();
		$( ".board_list" ).hide();
		$( ".b_obj_more_2" ).show();
		$( ".b_obj_2" ).show();
	});

	/*$( "#b_bt_3" ).click(function(){
		$( ".viewlink" ).removeClass( "active" );
		$( ".more_bt" ).hide();
		$( this ).addClass( "active" );
		$( this ).find("span").show();
		$( ".board_more_bt" ).hide();
		$( ".board_list" ).hide();
		$( ".b_obj_more_3" ).show();
		$( ".b_obj_3" ).show();
	});*/

	$( "#b_bt_4" ).click(function(){
		$( ".viewlink" ).removeClass( "active" );
		$( ".more_bt" ).hide();
		$( this ).addClass( "active" );
		$( this ).find("span").show();
		$( ".board_more_bt" ).hide();
		$( ".board_list" ).hide();
		$( ".b_obj_more_4" ).show();
		$( ".b_obj_4" ).show();
	});

	$( "#b_bt_5" ).click(function(){
		$( ".viewlink" ).removeClass( "active" );
		$( ".more_bt" ).hide();
		$( this ).addClass( "active" );
		$( this ).find("span").show();
		$( ".board_more_bt" ).hide();
		$( ".board_list" ).hide();
		$( ".b_obj_more_5" ).show();
		$( ".b_obj_5" ).show();
	});




	$('.bgcounter1').counterUp({delay: 10, time: 1000});
	$('.bgcounter2').counterUp({delay: 10, time: 1000});
	$('.bgcounter3').counterUp({delay: 10, time: 1000});
	$('.bgcounter4').counterUp({delay: 10, time: 1000});
	$('.bgcounter5').counterUp({delay: 10, time: 1000});
	$('.bgcounter6').counterUp({delay: 10, time: 1000});
	$('.bgcounter7').counterUp({delay: 10, time: 1000});
	$( ".radubg_1" ).animate({ "opacity": "1", "top": "180px", "left":"412px" }, 500);
	$( ".radubg_2" ).delay( 100 ).animate({ "opacity": "1", "top": "200px", "left":"746px" }, 450);
	$( ".radubg_3" ).delay( 200 ).animate({ "opacity": "1", "top": "380px", "left":"328px" }, 400);
	$( ".radubg_4" ).delay( 300 ).animate({ "opacity": "1", "top": "330px", "left":"790px" }, 350);
	$( ".radubg_5" ).delay( 400 ).animate({ "opacity": "1", "top": "465px", "left":"398px" }, 300);
	$( ".radubg_7" ).delay( 400 ).animate({ "opacity": "1", "top": "290px", "left":"412px" }, 300);

	$( ".radubg_6" ).delay( 500 ).animate({ "opacity": "1", "top": "460px", "left":"675px" }, 250, function(){
		var bgck = 1
		playAlert = setInterval(function() {
			if(bgck == 1){
				$( ".radubg_1" ).animate({ "opacity": "1", "top": "190px", "left":"412px" }, 1000);
				$( ".radubg_2" ).animate({ "opacity": "1", "top": "190px", "left":"746px" }, 1000);
				$( ".radubg_3" ).animate({ "opacity": "1", "top": "390px", "left":"328px" }, 1000);
				$( ".radubg_4" ).animate({ "opacity": "1", "top": "340px", "left":"790px" }, 1000);
				$( ".radubg_5" ).animate({ "opacity": "1", "top": "475px", "left":"398px" }, 1000);
				$( ".radubg_6" ).animate({ "opacity": "1", "top": "470px", "left":"675px" }, 1000);
				$( ".radubg_7" ).animate({ "opacity": "1", "top": "295px", "left":"412px" }, 1000);
				bgck = 0;
			} else {
				$( ".radubg_1" ).animate({ "opacity": "1", "top": "180px", "left":"412px" }, 1000);
				$( ".radubg_2" ).animate({ "opacity": "1", "top": "200px", "left":"746px" }, 1000);
				$( ".radubg_3" ).animate({ "opacity": "1", "top": "380px", "left":"328px" }, 1000);
				$( ".radubg_4" ).animate({ "opacity": "1", "top": "330px", "left":"790px" }, 1000);
				$( ".radubg_5" ).animate({ "opacity": "1", "top": "465px", "left":"398px" }, 1000);
				$( ".radubg_6" ).animate({ "opacity": "1", "top": "460px", "left":"675px" }, 1000);
				$( ".radubg_7" ).animate({ "opacity": "1", "top": "290px", "left":"412px" }, 1000);
				bgck = 1;
			}
		}, 1000);

		$( ".ani_right_banner" ).delay( 400 ).animate({ "opacity": "1" }, 1000);
	});	


	$( "#foot_tab1" ).click(function(){
		clearInterval(playAlert);
		$( ".radubg_1" ).css({"top": "0px", "left": "0px", "opacity": "0"});
		$( ".radubg_2" ).css({"top": "0px", "left": "0px", "opacity": "0"});
		$( ".radubg_3" ).css({"top": "0px", "left": "0px", "opacity": "0"});
		$( ".radubg_4" ).css({"top": "0px", "left": "0px", "opacity": "0"});
		$( ".radubg_5" ).css({"top": "0px", "left": "0px", "opacity": "0"});
		$( ".radubg_6" ).css({"top": "0px", "left": "0px", "opacity": "0"});
		$( ".radubg_7" ).css({"top": "0px", "left": "0px", "opacity": "0"});

		$( ".tab_bt" ).removeClass( "active" );
		$( this ).addClass( "active" );
		
		$( ".back_slider_area > li:first-child" ).stop().animate({ "left": "0px" }, 500 );
		$( ".line_animation" ).stop().animate({ "width": "0%" }, 500 );
		$( ".radu_1, .radu_1 > div" ).css({"width": "0px", "height": "0px"});
		$( ".radu_2, .radu_2 > div" ).css({"width": "0px", "height": "0px"});
		$( ".radu_3, .radu_3 > div" ).css({"width": "0px", "height": "0px"});
		$( ".radu_4, .radu_4 > div" ).css({"width": "0px", "height": "0px"});
		$( ".radu_5, .radu_5 > div" ).css({"width": "0px", "height": "0px"});
		$( ".number1" ).css({"top": "304px", "opacity": "0"});
		$( ".number2" ).css({"top": "434px", "opacity": "0"});
		$( ".number3" ).css({"top": "304px", "opacity": "0"});
		$( ".number4" ).css({"top": "434px", "opacity": "0"});
		$( ".number5" ).css({"top": "304px", "opacity": "0"});

		$('.bgcounter1').counterUp({delay: 10, time: 1000});
		$('.bgcounter2').counterUp({delay: 10, time: 1000});
		$('.bgcounter3').counterUp({delay: 10, time: 1000});
		$('.bgcounter4').counterUp({delay: 10, time: 1000});
		$('.bgcounter5').counterUp({delay: 10, time: 1000});
		$('.bgcounter6').counterUp({delay: 10, time: 1000});
		$('.bgcounter7').counterUp({delay: 10, time: 1000});
		$( ".radubg_1" ).delay( 1000 ).animate({ "opacity": "1", "top": "180px", "left":"412px" }, 500);
		$( ".radubg_2" ).delay( 1100 ).animate({ "opacity": "1", "top": "200px", "left":"746px" }, 450);
		$( ".radubg_3" ).delay( 1200 ).animate({ "opacity": "1", "top": "380px", "left":"328px" }, 400);
		$( ".radubg_4" ).delay( 1300 ).animate({ "opacity": "1", "top": "330px", "left":"790px" }, 350);
		$( ".radubg_5" ).delay( 1400 ).animate({ "opacity": "1", "top": "465px", "left":"398px" }, 300);
		$( ".radubg_7" ).delay( 1400 ).animate({ "opacity": "1", "top": "290px", "left":"412px" }, 300);

		$( ".radubg_6" ).delay( 1500 ).animate({ "opacity": "1", "top": "460px", "left":"675px" }, 250, function(){
			var bgck = 1
			playAlert = setInterval(function() {
				if(bgck == 1){
					$( ".radubg_1" ).animate({ "opacity": "1", "top": "190px", "left":"412px" }, 1000);
					$( ".radubg_2" ).animate({ "opacity": "1", "top": "190px", "left":"746px" }, 1000);
					$( ".radubg_3" ).animate({ "opacity": "1", "top": "390px", "left":"328px" }, 1000);
					$( ".radubg_4" ).animate({ "opacity": "1", "top": "340px", "left":"790px" }, 1000);
					$( ".radubg_5" ).animate({ "opacity": "1", "top": "475px", "left":"398px" }, 1000);
					$( ".radubg_6" ).animate({ "opacity": "1", "top": "470px", "left":"675px" }, 1000);
					$( ".radubg_7" ).animate({ "opacity": "1", "top": "295px", "left":"412px" }, 1000);
					bgck = 0;
				} else {
					$( ".radubg_1" ).animate({ "opacity": "1", "top": "180px", "left":"412px" }, 1000);
					$( ".radubg_2" ).animate({ "opacity": "1", "top": "200px", "left":"746px" }, 1000);
					$( ".radubg_3" ).animate({ "opacity": "1", "top": "380px", "left":"328px" }, 1000);
					$( ".radubg_4" ).animate({ "opacity": "1", "top": "330px", "left":"790px" }, 1000);
					$( ".radubg_5" ).animate({ "opacity": "1", "top": "465px", "left":"398px" }, 1000);
					$( ".radubg_6" ).animate({ "opacity": "1", "top": "460px", "left":"675px" }, 1000);
					$( ".radubg_7" ).animate({ "opacity": "1", "top": "290px", "left":"412px" }, 1000);
					bgck = 1;
				}
			}, 1000);
		});	

	});

	$( "#foot_tab2" ).click(function(){
		clearInterval(playAlert);


		$( ".tab_bt" ).removeClass( "active" );
		$( this ).addClass( "active" );
		$( ".back_slider_area > li:first-child" ).stop().animate({ "left": "-3000px" }, 500 );
		$( ".line_animation" ).delay( 200 ).animate({ "width": "100%" }, 200 );
		$( ".radu_1" ).delay( 300 ).animate({ "width": "30px", "height": "30px" }, 100 );
		$( ".radu_1 > div" ).delay( 300 ).animate({ "width": "20px", "height": "20px" }, 100 );
		$( ".number1" ).delay( 330 ).animate({ "top": "294px", "opacity": "1" }, 100, function(){
			$('.counter1').counterUp({
				delay: 10,
				time: 1000
			});
		});


		$( ".radu_2" ).delay( 400 ).animate({ "width": "30px", "height": "30px" }, 100 );
		$( ".radu_2 > div" ).delay( 400 ).animate({ "width": "20px", "height": "20px" }, 100 );
		$( ".number2" ).delay( 430 ).animate({ "top": "424px", "opacity": "1" }, 100, function(){
			$('.counter2').counterUp({
				delay: 10,
				time: 1000
			});
		});


		$( ".radu_3" ).delay( 500 ).animate({ "width": "30px", "height": "30px" }, 100 );
		$( ".radu_3 > div" ).delay( 500 ).animate({ "width": "20px", "height": "20px" }, 100 );
		$( ".number3" ).delay( 530 ).animate({ "top": "294px", "opacity": "1" }, 100, function(){
			$('.counter3').counterUp({
				delay: 10,
				time: 1000
			});
		});


		$( ".radu_4" ).delay( 600 ).animate({ "width": "30px", "height": "30px" }, 100 );
		$( ".radu_4 > div" ).delay( 600 ).animate({ "width": "20px", "height": "20px" }, 100 );
		$( ".number4" ).delay( 630 ).animate({ "top": "424px", "opacity": "1" }, 100, function(){
			$('.counter4').counterUp({
				delay: 10,
				time: 1000
			});
		});


		$( ".radu_5" ).delay( 700 ).animate({ "width": "30px", "height": "30px" }, 100 );
		$( ".radu_5 > div" ).delay( 700 ).animate({ "width": "20px", "height": "20px" }, 100 );
		$( ".number5" ).delay( 730 ).animate({ "top": "294px", "opacity": "1" }, 100, function(){
			$('.counter5').counterUp({
				delay: 10,
				time: 1000
			});
		});


	});

});


$(function(){
	var play=true;
	var focus=false;
	var slider=$("#banner_slider").sudoSlider({
		speed:1000,
		slideCount:5,
		auto:true,
		pause:3000,
		resumePause:3000,
		continuous:true,
		prevHtml:'<button type="button" id="banner_prev"><span class="sound_only">이전 배너</span></button>',
		nextHtml:'<button type="button" id="banner_next"><span class="sound_only">다음 배너</span></button>',
		autoHeight:false,autoWidth:false
		}).mouseenter(function(){
			if(play){
				slider.stopAuto();
			}
		}).mouseleave(function(){
			if(play&&!focus){
				slider.startAuto();
			}
		});
		
	$("#banner_slider ul li a").focus(function(){
		var i=$(this).parent().index()+1;
		if(slider.getOption('continuous')){
			i-=slider.getOption('slideCount');
		}
		$("#banner_slider").scrollLeft(-156*i);
		slider.goToSlide(i);
		focus=true;
	}).blur(function(){
		if(play){
			slider.startAuto();
		}
		focus=false;
	});
	
	$("#banner_prev,#banner_next").on('mouseenter focus',function(){
		if(play){
			slider.stopAuto();
		}
	}).on('mouseleave blur',function(){
		if(play&&!focus){
			slider.startAuto();
		}
	});
	
	$("#banner_control button").click(function(){
		if(play){
			slider.stopAuto();
			$(this).css('background','url("../../images/main/lmi_play.gif") no-repeat');
			$(this).children('span').text('배너 시작');
			play=false;
		}else{
			slider.startAuto();
			$(this).css('background','url("../../images/main/lmi_stop.gif") no-repeat');
			$(this).children('span').text('배너 정지');
			play=true;
		}
		return false;
	});
	
	$("#banner_control").show();
	if(slider.getOption('continuous')){
		$("#banner_slider ul li a").attr('tabindex',-1);
		for(var i=slider.getOption('slideCount'); i<slider.getValue('totalSlides')+slider.getOption('slideCount'); i++){
			$("#banner_slider ul li a").eq(i).removeAttr('tabindex');
		}
	}
});