Module.register('chatHistory', function(_container) {
  'use strict';

  var bar_width;

  var init = function() {
    var bar_width = _container.width();
    var bar_position = _container.offset().top - $('header').height();

    $(window).bind('scroll', function() {
      if ($(window).scrollTop() > bar_position) {
        _container.addClass('fixed');
        _container.width(bar_width);
       }
       else {
         _container.removeClass('fixed');
       }
    });
  }

  init();
});
