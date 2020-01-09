var $ = jQuery.noConflict();

//JSHint Validated Custom JS Code
//CAROUSEL--------------------------------------------------------

(function ($) {
    $(document).ready(function () {
        initialize();
        // Add classes for other carousels
        var $carousel = $('.latest-work-jc, .latest-posts-jc, .testimonials-jc');

        var scrollCount;

        function adjustScrollCount() {
            if ($(window).width() < 768) {
                scrollCount = 1;
            } else {
                scrollCount = 1;
            }

        }

        function adjustCarouselHeight() {

            $carousel.each(function () {
                var $this = $(this);
                var maxHeight = -1;
                $this.find('li').each(function () {
                    maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
                });
                $this.height(maxHeight);
            });
        }
        function initCarousel() {
            adjustCarouselHeight();
            adjustScrollCount();
            var i = 0;
            var g = {};
            $carousel.each(function () {
                i++;

                var $this = $(this);
                g[i] = $this.jcarousel({
                    animation: 500,
                    scroll: scrollCount,
                    wrap: 'circular'
                });
                $this.jcarousel('scroll', 0);
                $this.prev().find('.jcarousel-prev').bind('active.jcarouselcontrol', function () {
                    $(this).addClass('active');
                }).bind('inactive.jcarouselcontrol', function () {
                    $(this).removeClass('active');
                }).jcarouselControl({
                    target: '-=' + scrollCount,
                    carousel: g[i]
                });

                $this.prev().find('.jcarousel-next').bind('active.jcarouselcontrol', function () {
                    $(this).addClass('active');
                }).bind('inactive.jcarouselcontrol', function () {
                    $(this).removeClass('active');
                }).jcarouselControl({
                    target: '+=' + scrollCount,
                    carousel: g[i]
                });

                $this.touchwipe({
                    wipeLeft: function () {
                        $this.jcarousel('scroll', '+=' + scrollCount);
                    },
                    wipeRight: function () {
                        $this.jcarousel('scroll', '-=' + scrollCount);
                    }
                });

            });
        }
        $(window).load(function () {
            initCarousel();
        });

        $(window).resize(function () {
            $carousel.each(function () {
                var $this = $(this);
                $this.jcarousel('destroy');
            });
            initCarousel();
        });


    });

})(this.jQuery);
/**
* jQuery Plugin to obtain touch gestures from iPhone, iPod Touch and iPad, should also work with Android mobile phones (not tested yet!)
* Common usage: wipe images (left and right to show the previous or next image)
*
* @author Andreas Waltl, netCU Internetagentur (http://www.netcu.de)
* @version 1.1.1 (9th December 2010) - fix bug (older IE's had problems)
* @version 1.1 (1st September 2010) - support wipe up and wipe down
* @version 1.0 (15th July 2010)
*/
(function ($) { $.fn.touchwipe = function (settings) { var config = { min_move_x: 20, min_move_y: 20, wipeLeft: function () { }, wipeRight: function () { }, wipeUp: function () { }, wipeDown: function () { }, preventDefaultEvents: true }; if (settings) $.extend(config, settings); this.each(function () { var startX; var startY; var isMoving = false; function cancelTouch() { this.removeEventListener('touchmove', onTouchMove); startX = null; isMoving = false } function onTouchMove(e) { if (config.preventDefaultEvents) { e.preventDefault() } if (isMoving) { var x = e.touches[0].pageX; var y = e.touches[0].pageY; var dx = startX - x; var dy = startY - y; if (Math.abs(dx) >= config.min_move_x) { cancelTouch(); if (dx > 0) { config.wipeLeft() } else { config.wipeRight() } } else if (Math.abs(dy) >= config.min_move_y) { cancelTouch(); if (dy > 0) { config.wipeDown() } else { config.wipeUp() } } } } function onTouchStart(e) { if (e.touches.length == 1) { startX = e.touches[0].pageX; startY = e.touches[0].pageY; isMoving = true; this.addEventListener('touchmove', onTouchMove, false) } } if ('ontouchstart' in document.documentElement) { this.addEventListener('touchstart', onTouchStart, false) } }); return this } })(jQuery);


/*jslint smarttabs:true */
//FANCYBOX-------------------------------------------------------
$(document).ready(function () {
    //    $('.fancybox').fancybox();
    $(".fancybox").live("mousedown", function () {
        $(this).fancybox(
			{
			    'titleShow': false,
			    'overlayShow': false,
			    'transitionIn': 'elastic',
			    'transitionOut': 'elastic'
			});
    });
    $("a.iframe").fancybox(

	  {
	      'titleShow': true,
	      'autoDimensions': true,
	      'width': 800,
	      'height': 450,
	      'autoScale': true,
	      'type': 'iframe'

	  });

    $(".show_maps").fancybox({
        'width': '75%',
        'height': '75%',
        'autoScale': false,
        'transitionIn': 'none',
        'transitionOut': 'none',
        'type': 'iframe'
    });

});

//JSHint Validated Custom JS Code
$(document).ready(function () {
    //Transition images Our Offers
    $('#offers1').hover(function () {
        $('#offers1 .images_travel1').hide(1000);
        $('#offers1 .images_travel2').show(2000);
    },
            function () {
                $('#offers1 .images_travel2').hide(1000);
                $('#offers1 .images_travel1').show(2000);

            }
        );
    $('#offers2').hover(function () {
        $('#offers2 .images_travel1').hide(1000);
        $('#offers2 .images_travel2').show(2000);
    },
            function () {
                $('#offers2 .images_travel2').hide(1000);
                $('#offers2 .images_travel1').show(2000);

            }
        );
    $('#offers3').hover(function () {
        $('#offers3 .images_travel1').hide(1000);
        $('#offers3 .images_travel2').show(2000);
    },
            function () {
                $('#offers3 .images_travel2').hide(1000);
                $('#offers3 .images_travel1').show(2000);

            }
        );
    //Menu Portfolio
    $('#africa_folio').click(function () {
        $('.europe').hide(1000);
        $('.america').hide(1000);
        $('.africa').show(2000);
        $('#city_folio li').removeClass('active');
        $(this).addClass('active');
    });
    $('#europe_folio').click(function () {
        $('.africa').hide(1000);
        $('.america').hide(1000);
        $('.europe').show(2000);
        $('#city_folio li').removeClass('active');
        $(this).addClass('active');
    });
    $('#america_folio').click(function () {
        $('.europe').hide(1000);
        $('.africa').hide(1000);
        $('.america').show(2000);
        $('#city_folio li').removeClass('active');
        $(this).addClass('active');
    });
});

/*jslint smarttabs:true */
/*jshint eqnull:true, eqeqeq:false */
/*jslint eqeq:true */
//JSHint Validated Custom JS Code
jQuery(document).ready(function ($) {


    $(window).stellar();


    var links = $('.navigation').find('li');
    slide = $('.slidePoint');
    button = $('.button');
    mywindow = $(window);
    htmlbody = $('html,body');

    /**/
    if (mywindow.scrollTop() < 1) {
        $('.navigation li[data-slide="1"]').addClass('active');
    }
    /**/

    slide.waypoint(function (event, direction) {

        dataslide = $(this).attr('data-slide');

        if (direction === 'down') {
            $('.navigation li[data-slide="' + dataslide + '"]').addClass('active').prev().removeClass('active');

            $('.navigation li[data-slide="1"]').removeClass('active');

        }
        else {
            $('.navigation li[data-slide="' + dataslide + '"]').addClass('active').next().removeClass('active');
        }

    });

    mywindow.scroll(function () {
        if (mywindow.scrollTop() === 0) {
            $('.navigation li[data-slide="1"]').addClass('active');
            $('.navigation li[data-slide="2"]').removeClass('active');
        }
    });


    function goToByScroll(dataslide) {
        var goal = $('.slidePoint[data-slide="' + dataslide + '"]').offset().top;
        var goalPx;
        if (mywindow.scrollTop() < goal) {
            goalPx = goal + 5;
        } else {
            goalPx = goal - 50;
        }
        htmlbody.animate({
            scrollTop: goalPx
        }, 2000, 'easeInOutQuint');
    }

    links.click(function (e) {
        e.preventDefault();
        dataslide = $(this).attr('data-slide');
        goToByScroll(dataslide);
    });

    button.click(function (e) {
        e.preventDefault();
        dataslide = $(this).attr('data-slide');
        goToByScroll(dataslide);

    });


    //CALENDAR
    $("#datepicker, #datepicker2").datepicker({
        inline: true
    });

    // Hover states on the static widgets
    $("#dialog-link, #icons li").hover(
		function () {
		    $(this).addClass("ui-state-hover");
		},
		function () {
		    $(this).removeClass("ui-state-hover");
		}
	);

    $("#slide1, #slide2, #slide4").each(function () {
        var slide_h = $(this).height();

        $(this).css('background-size', '100% ' + slide_h + 'px');

    });



});






