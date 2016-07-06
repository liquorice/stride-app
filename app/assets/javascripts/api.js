(function() {

  'use strict';

  var init = function() {
    $.get(
      KB_API_URL,
      process_api_response,
      "JSON"
    );
  };

  var process_api_response = function(data) {
    var get_support_wrapper;
    var footer_wrapper;

    var forums_overview_wrapper = $('.js-forums_overview');
    var chats_overview_wrapper = $('.js-chats_overview');

    var preferences_overview_wrapper = $('.js-preferences_overview');
    var preferences_notification_wrapper = $('.js-preferences_notification');

    var community_overview_wrapper = $('.js-community_overview');
    var community_rules_wrapper = $('.js-community_content');

    get_support_wrapper = $('.js-get_support');
    footer_wrapper = $('.js-footer_wrapper');

    if (forums_overview_wrapper.length) {
      if (data["forums_overview"]) {
        forums_overview_wrapper[0].innerHTML = data["forums_overview"];
      }
    }

    if (chats_overview_wrapper.length) {
      if (data["chats_overview"]) {
        chats_overview_wrapper[0].innerHTML = data["chats_overview"];
      }
    }

    if (preferences_overview_wrapper.length) {
      if (data["preferences"]) {
        preferences_overview_wrapper[0].innerHTML = data["preferences"]["overview"];
      }
    }

    if (preferences_notification_wrapper.length) {
      if (data["preferences"]) {
        preferences_notification_wrapper[0].innerHTML = data["preferences"]["notifications_desc"];
      }
    }

    if (community_overview_wrapper.length) {
      if (data["community_rules"]) {
        community_overview_wrapper[0].innerHTML = data["community_rules"]["overview"];
      }
    }

    if (community_rules_wrapper.length) {
      if (data["community_rules"]) {
        community_rules_wrapper[0].innerHTML = data["community_rules"]["content"];
      }
    }

    if (get_support_wrapper.length) {
      if (data["footer"]) {
        get_support_wrapper[0].innerHTML = data["footer"]["get_support"];
      }
    }

    if (footer_wrapper.length) {
      if (data["footer"]) {
        var beyondblue_anchors = footer_wrapper.find('.js-beyondblue_link');
        var movember_anchors = footer_wrapper.find('.js-movember_link');

        for (var i = 0; i < beyondblue_anchors.length; i++) {
          beyondblue_anchors[i].setAttribute('href', data["footer"]["beyondblue"]);
        }

        for (var j = 0; j < movember_anchors.length; j++) {
          movember_anchors[j].setAttribute('href', data["footer"]["movember"]);
        }

        footer_wrapper.find('.js-vac_link')[0].setAttribute('href', data["footer"]["vac"]);
        footer_wrapper.find('.js-acon_link')[0].setAttribute('href', data["footer"]["acon"]);
        footer_wrapper.find('.js-csrh_link')[0].setAttribute('href', data["footer"]["csrh"]);
        footer_wrapper.find('.js-additional_link')[0].setAttribute('href', data["footer"]["additional"]);
      }
    }
  };

  $(init);

})();
