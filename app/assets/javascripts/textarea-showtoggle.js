Module.register('textarea-showtoggle', function() {
  'use strict';

    $(document).ready(function() {

        var maxHeight = 400;
        var moretext = "Show more";
        var lesstext = "Show less";
        

        $('.post__showToggle').each(function() {
            if ($(this).parent().height() > maxHeight) {
                $(this).parent().css("height", $(this).parent().find('post__showToggle').height());
                $(this).parent().addClass("hide");
                $(this).parent().parent().find('.post__showMore').html(moretext);
            }
        });

        $(".post__showMore").click(function(){

            $(this).html() == moretext ? $(this).html(lesstext) : $(this).html(moretext);

            if($(this).parent().find('.post__content').length) {

                if($(this).prev().hasClass('hide')){

                    $(this).parent().find('.post__content').css('max-height', $(this).parent().find('.post__content').find('.post__showToggle').css('height'));

                    $(this).prev().removeClass('hide');

                } else {

                    $(this).prev().addClass('hide');
                    $(this).parent().find('.hide').css('max-height', maxHeight);

                }

            }
        });
    });

});