Module.register('mobileMenu', function(_container) {
  'use strict';

  var container;
  var content;
  var toggle;

  var init = function() {
    container = _container;
    toggle = container.find('.js-menu-toggle');

    toggle.on('click', function() {
      container.toggleClass('expanded');
    });
  }

  init();

});
