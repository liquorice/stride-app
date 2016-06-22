Module.register('datetimePicker', function(_container) {
  'use strict';

  var container;
  var date_input;
  var time_input;

  var init = function() {

    container = _container;
    date_input = container.find('.js-datepicker');
    time_input = container.find('.js-timepicker');

    date_input.Zebra_DatePicker({
      direction: true,
      format: 'D, M d Y'
    });

    time_input.wickedpicker();

  };

  init();

});