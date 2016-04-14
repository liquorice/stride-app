Module.register('textarea-showtoggle', function() {
  'use strict';

  $(document).ready(function() {
    var showChar = 1000;
    var moretext = "Show more";
    var lesstext = "Show less";
    

    $('.post__showToggle').each(function() {
        var content = $(this).html();
 
        if(content.length > showChar) {
 
            var c = content.substr(0, showChar);
            var h = content.substr(showChar, content.length - showChar);

            var showBtn = '<a href="" class="post__showMore">' + moretext + '</a>';

            var quoteBtn = '<a href="" class="post__quote">"Quote</a>';

            var html = '<span id="prevContent" class="fadeContent">' + c + '</span><span class="moreContent"><span>' + h + '</span><div>' + showBtn + quoteBtn + '</div></span>';
 
            $(this).html(html);
        }
    });
 
    $(".post__showMore").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
            if($(this).parent().parent().parent().find('#prevContent').length) {
              $(this).parent().parent().parent().find('#prevContent').addClass("fadeContent");
          }
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
            if($(this).parent().parent().parent().find('#prevContent').length) {
              $(this).parent().parent().parent().find('#prevContent').removeClass("fadeContent");
          }
        }
        $(this).parent().prev().toggle('slow');
        $(this).prev().toggle('slow');

        return false;
    });
  });

});