Module.register('chatnotification-update', function(_container) {
  'use strict';

  var init = function() {
    // setInterval(update_startsin_text, 60000);
    // setInterval(update_startsin_text, 5000);
    update_startsin_text();
  }

  var update_startsin_text = function() {
    

    $.get("/api/upcoming_chat", function(data) {
      // $("#elem_to_place_foo").html(data.integer);
      // console.log(_container.find('.js-chatNotification_startsin'));
      console.log('MEOW');


      if (data) {
        if (data["chat"]) {

          var startsin_text = _container.find('.js-chatNotification_startsin');

          if (data["chat"]["status"] == "open") {
            console.log("OPEN");
          }
          else {
            console.log(data["chat"]["starts_in"]);
          }

        }
      }



    }, "json");
  }

  init();
});
