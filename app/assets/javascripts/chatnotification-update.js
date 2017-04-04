Module.register('chatnotification-update', function(_container) {
  'use strict';

  var init = function() {
    // setInterval(update_startsin_text, 60000);
    setInterval(update_startsin_text, 5000);
  }

  var update_startsin_text = function() {

    $.get("/api/upcoming_chat", function(data) {

      console.log('MEOW');

      if (data) {
        if (data["chat"]) {

          var notification = _container;
          var startsin_text = _container.find('.js-chatNotification_startsin');

          if (data["chat"]["status"] == "open") {
            notification.attr('data-open', 'open');
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
