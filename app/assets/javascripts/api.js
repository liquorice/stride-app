(function() {

  'use strict';

  var kb_url;
  var api_url;

  var survey_wrapper;
  var get_support_wrapper;
  var footer_wrapper;

  var init = function() {

    kb_url = 'http://' + document.domain.split('.').slice(1).join('.');
    api_url = kb_url + '/api';

    var forums_overview_wrapper = $('.js-forums_overview');
    var chats_overview_wrapper = $('.js-chats_overview');

    var preferences_overview_wrapper = $('.js-preferences_overview');
    var preferences_notification_wrapper = $('.js-preferences_notification');

    var community_overview_wrapper = $('.js-community_overview');
    var community_rules_wrapper = $('.js-community_content');

    survey_wrapper = $('.js-survey_api');
    get_support_wrapper = $('.js-get_support');
    footer_wrapper = $('.js-footer_wrapper');


    if (forums_overview_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["forums_overview"]) {
          forums_overview_wrapper[0].innerHTML = data["forums_overview"];
        }
      }, "json");
    }

    if (chats_overview_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["chats_overview"]) {
          chats_overview_wrapper[0].innerHTML = data["chats_overview"];
        }
      }, "json");
    }

    if (preferences_overview_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["preferences"]) {
          preferences_overview_wrapper[0].innerHTML = data["preferences"]["overview"];
        }
      }, "json");
    }

    if (preferences_notification_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["preferences"]) {
          preferences_notification_wrapper[0].innerHTML = data["preferences"]["notifications_desc"];
        }
      }, "json");
    }

    if (community_overview_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["community_rules"]) {
          community_overview_wrapper[0].innerHTML = data["community_rules"]["overview"];
        }
      }, "json");
    }

    if (community_rules_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["community_rules"]) {
          community_rules_wrapper[0].innerHTML = data["community_rules"]["content"];
        }
      }, "json");
    }

    if (survey_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["survey"]) {
          survey_wrapper.find('.js-survey_content')[0].innerHTML = data["survey"]["content"];
          survey_wrapper.find('.js-survey_link')[0].setAttribute('href', data["survey"]["link"]);
        }
      }, "json");
    }

    if (get_support_wrapper.length) {
      $.get( api_url, function( data ) {
        if (data["footer"]) {
          get_support_wrapper[0].innerHTML = data["footer"]["get_support"];
        }
      }, "json");
    }

    if (footer_wrapper.length) {
      $.get( api_url, function( data ) {
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
      }, "json");
    }
  };

  $(init);

})();
