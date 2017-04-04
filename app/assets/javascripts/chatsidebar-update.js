Module.register('chatsidebar-update', function(_container) {
  'use strict';

  var init = function() {
    if (_container.is('[data-upcoming]')) {
      setInterval(update_sidebar_chat, 90000);
    }
  }

  var update_sidebar_chat = function() {
    $.get("/api/upcoming_chat", function(data) {
      if (data) {
        if (data["chat"]) {
          if (data["chat"]["status"] == "open") {

            var container = _container;
            var startsin_text = _container.find('.js-chatSidebar_startsin');
            var btn = _container.find('.js-chatSidebar_btn');

            container.attr('data-open', '');
            container.removeAttr('data-upcoming');
            startsin_text[0].innerText = "IN PROGRESS";

            btn.attr('href', data["chat"]["url"]);
            btn.removeAttr('data-modal');
            btn[0].innerHTML = "Join chat now";

          }
        }
      }
    }, "json");
  }

  init();
});
