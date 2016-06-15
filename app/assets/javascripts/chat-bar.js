Module.register('chatbar', function(_container) {
  'use strict';

  var init = function() {
    _container.on('click', function() {
      _container.toggleClass('expanded');
    });
  }

  init();
});
