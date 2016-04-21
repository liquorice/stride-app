Module.register('textarea-showtoggle', function() {
  'use strict';

    $(document).ready(function() {

        var maxHeight = 400;
        var moretext = "Show more";
        var lesstext = "Show less";
        

        $('.post__showToggle').each(function() {
            if ($(this).parent().height() > maxHeight) {
                $(this).parent().css("height", $(this).height());
                $(this).parent().addClass("hide");
                $(this).parent().parent().find('.post__showMore').html(moretext);
                $(this).parent().parent().find('.post__showMore').css('display', 'inline-block');
            }
        });

        $(".post__showMore").click(function(){

            $(this).html() == moretext ? $(this).html(lesstext) : $(this).html(moretext);

            if($(this).parent().parent().find('.post__content').length) {

                if($(this).parent().parent().find('.post__content').hasClass('hide')){

                    $(this).parent().parent().find('.post__content').css('max-height', $(this).parent().parent().find('.post__content').find('.post__showToggle').css('height'));
                    $(this).parent().parent().find('.post__content').removeClass('hide');

                } else {

                    $(this).parent().parent().find('.post__content').addClass('hide');
                    $(this).parent().parent().find('.hide').css('max-height', maxHeight);

                }

            }
        });
    });

});