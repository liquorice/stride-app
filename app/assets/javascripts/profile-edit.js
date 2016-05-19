Module.register('profileEdit', function(_container) {
  'use strict';

  var container;
  var content;
  var cancel;

  var init = function() {
    container = _container;
    cancel = container.find('.js-profile-edit');

    cancel.on('click', function() {
      container.toggleClass('edit');
    });
  }

  init();

});
