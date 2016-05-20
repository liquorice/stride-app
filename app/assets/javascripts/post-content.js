Module.register('postContent', function(_container) {
  'use strict';

  var container;
  var content;
  var toggle;
  var MAX_HEIGHT = 400;
  var HEIGHT_TOLERANCE = 100;

  var init = function() {
    container = _container;
    content = container.find('.js-postContent').not('[data-quoted]');
    toggle = container.find('.js-post-toggle');

    if (content.height() > MAX_HEIGHT + HEIGHT_TOLERANCE) {
      container.addClass('needsCropping');

      toggle.on('click', function() {
        container.toggleClass('expanded');
      });
    }
  }

  init();

});
