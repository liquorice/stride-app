Module.register('search', function(_container) {
  'use strict';

  var form;
  var input;
  var toggle;

  var init = function() {
    form = _container.find('.js-search-form');
    input = form.find('.js-search-input');
    toggle = form.find('.js-search-toggle');

    form.on('submit', function(e) {
      document.location.href = form.attr('action') + '/' + encodeURIComponent(input.val());
      e.preventDefault();
      return false;
    });

    toggle.on('click', function() {
      _container.toggleClass('expand');
    });
  }

  init();

});
