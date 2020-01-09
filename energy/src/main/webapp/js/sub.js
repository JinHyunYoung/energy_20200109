$(window).load(function(){

	$( "#closer_table" ).click(function(){
		$( ".popup_page" ).hide();
	});

	$( ".lnb_list > li > p" ).click(function(){
		$( this ).next( "ul" ).toggle( 100 );
	});

});



