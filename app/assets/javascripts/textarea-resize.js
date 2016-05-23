Module.register('freeText', function(_container) {
  'use strict';

  var textarea;
  var container;
  var quoted_container;
  var quoted_input;
  var quoted_display;

  var init = function() {
    container = _container;
    textarea = container.find('.js-free-text');

    setup_growing_textarea();
  }

  var setup_growing_textarea = function() {
    textarea.on('input', function() {
      if (textarea.val().length) {
        container.addClass('hasContent');
      }
      else {
        container.removeClass('hasContent');
      }

      textarea
        .css('height', 0)
        .css('height', textarea[0].scrollHeight + 'px');
    });

    textarea.trigger('input');
  }

  init();

});