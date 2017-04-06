Module.register('chatnotification-update', function(_container) {
  'use strict';

  var init = function() {
    if (_container.css('display') != 'none') {
      setInterval(update_startsin_text, 90000);
    }
  }

  var update_startsin_text = function() {
    $.get("/api/upcoming_chat", function(data) {
      if (data) {
        if (data["chat"]) {

          var notification = _container;
          var startsin_text = _container.find('.js-chatNotification_startsin');

          if (data["chat"]["status"] == "open") {
            notification.attr('data-open', '');
            notification.find('a').attr('href', data["chat"]["url"]);
            startsin_text[0].innerText = "Chat now LIVE";
          }
          else {
            startsin_text[0].innerText = "Chat starts in " + data["chat"]["starts_in"];
          }

        }
      }
    }, "json");
  }

  init();
});
