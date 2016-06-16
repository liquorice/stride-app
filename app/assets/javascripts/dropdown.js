Module.register('dropdown', function() {
  'use strict';

  $('body').on('change', 'select[data-type=dropdown]', function() {
    var el;
    var display;

    el = $(this);
    display = el.parent('.js-dropdown').find('.js-display');

    display.html(el.find(':selected').text());
  });

});
