Module.register('notification', function(_container) {
  'use strict';

  var close;

  var init = function() {
    close = _container.find('.js-notification-close');

    close.on('click', function() {
      _container.addClass('hidden');
    });
  };

  init();

  setTimeout(function() {
    _container.addClass('hidden');
  }, 5000);

});
