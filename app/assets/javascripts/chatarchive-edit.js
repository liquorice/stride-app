Module.register('noteEdit', function(_container) {
  'use strict';

  var container;
  var cancel;

  var init = function() {
    container = _container;
    cancel = container.find('.js-edit');

    cancel.on('click', function() {
      container.toggleClass('edit');
    });
  }

  init();
});
