$(function(){



	//lnb
	/*$('nav').hover(function(){
		$('.lnb .snb').css({display:'block'})
	},function(){
		$('.lnb .snb').css({display:'none'})
	})*/
	
    $('.lnb').mouseenter(function(){
       $('.lnb .snb').slideToggle(100);
    });

	$('.lnb').mouseleave(function(){
       $('.lnb .snb').slideToggle(100);
    });

	//aside
	$(document).on('click', '.lnbParent h3', function(){
		$('.lnbParent').removeClass('on');
		if ( $(this).parent().hasClass('on') ){
			if ( !$(this).parent().hasClass('marking') ){ $(this).parent().removeClass('on'); }
		} else {
			$(this).parent().addClass('on');
		}
		if ( !$(this).parent().hasClass('marking') ){ $(this).parent().find('ul').toggle(); }
		location.href = $(this).find('a').attr('href');
		return false;
	});
	


});