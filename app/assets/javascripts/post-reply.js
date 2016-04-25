Module.register('postReply', function(_container) {
  'use strict';

  var textarea;
  var container;

  var init = function() {
    container = _container;
    textarea = _container.find('.js-textarea');

    container.find('.js-clear').on('click', function() {
      textarea.val('').trigger('input');
    });

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