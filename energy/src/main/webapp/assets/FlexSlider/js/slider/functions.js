// =============== Flex slider functions =============== //
//JSHint Validated Custom JS Code

(function () {
    "use strict";

    $(document).ready(function () {

        flexSliderCaption();

    });

    $(window).load(function () {

        setupFlexSlider();

    });
    function flexSliderCaption() {
        $('.flexslider .slides li')
            .mouseenter(function () {
                $(this).find('.flex-caption').stop().animate({
                    opacity: 1
                }, 500);
            })
            .mouseleave(function () {
                $(this).find('.flex-caption').stop().animate({
                    opacity: 0
                }, 500);
            });
    }

    function setupFlexSlider() {
        $('.flexslider').flexslider({
            animation: "slide",
            slideshow: true,
            startAt: 1
        });
    }
})();
// =============== Flex slider functions END =============== //
