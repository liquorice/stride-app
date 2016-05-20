Module.register('search', function(_container) {
  'use strict';

  var form;
  var input;

  var init = function() {
    form = _container;
    input = form.find('.js-search-input');

    form.on('submit', function(e) {
      document.location.href = form.attr('action') + '/' + encodeURIComponent(input.val());
      e.preventDefault();
      return false;
    });
  }

  init();

});
