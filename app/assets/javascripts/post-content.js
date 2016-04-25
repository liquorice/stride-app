Module.register('postContent', function(_container) {
  'use strict';

  var container;
  var content;
  var toggle;
  var MAX_HEIGHT = 400;

  var init = function() {
    container = _container;
    content = container.find('.js-postContent');
    toggle = container.find('.js-post-toggle');

    if (content.height() > MAX_HEIGHT) {
      container.addClass('needsCropping');

      toggle.on('click', function() {
        container.toggleClass('expanded');
      });
    }
  }

  init();

});
