Module.register('datetimePicker', function(_container) {
  'use strict';

  var container;
  var date_input;
  var time_input;
  var time_icon;
  var time_picker;

  var init = function() {

    container = _container;
    date_input = container.find('.js-datepicker');
    time_input = container.find('.js-timepicker');
    time_icon = container.find('.js-timepicker-icon');
    time_picker = document.getElementsByClassName("wickedpicker");

    date_input.Zebra_DatePicker({
      direction: true,
      format: 'D, M d Y',
      default_position: 'below',
      select_other_months: true
    });

    var time_display = displayTime(time_input[0].value);

    time_input.wickedpicker({
      now: time_display
    });

    time_icon.on('click', function() {
      time_input.trigger('click');
      time_picker[0].style.display = "block";
    });

  };

  var displayTime = function (stringTime) {
    var default_time = "19:00";

    if (stringTime.length) {
      var meridiem = stringTime.split(' ');
      meridiem = $.grep(meridiem,function(n){ return n == " " || n });
      var time = meridiem[0].split(':');

      if (meridiem[1].match(/am/gi)) {
        return meridiem[0];
      } else if (meridiem[1].match(/pm/gi)) {
        time[0] = ((parseInt(time[0], 10)) + 12).toString();
        return (time[0] + ":" + time[1]);
      } else {
        return default_time;
      }
    }
    return default_time;
  };

  init();

});