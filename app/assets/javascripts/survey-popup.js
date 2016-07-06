Module.register('survey', function(_container) {
  'use strict';

  var container;
  var data;
  var close;
  var closed;

  var cookieName = "surveyShown=";
  var cookiePath = "path=/;";
  var cookieExpire;

  var init = function() {
    container = _container;
    data = container.find('.js-survey_api');
    close = container.find('.js-survey-close');
    closed = false;

    if (surveyShown() != "true") {
      close.on('click', function() {
        container.toggleClass('hidden');
        closed = true;

        cookieExpire = new Date();
        cookieExpire.setTime( cookieExpire.getTime() + (parseInt(data.attr('data-expire'), 10) * 24 * 60 * 60 * 1000));
        
        document.cookie = cookieName + "true;" + cookiePath + "expires=" + cookieExpire.toUTCString();
      });

      if (!closed) {
        console.log(data);
        console.log(data.attr('data-time'));
        setTimeout(function() {
          container.toggleClass("hidden");
        }, parseInt(data.attr('data-time'), 10));
      }
    }

  }

  var surveyShown = function() {
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
      var c = cookies[i];
      while (c.charAt(0)==' ') {
        c = c.substring(1);
      }
      if (c.indexOf(cookieName) == 0) {
        return c.substring(cookieName.length,c.length);
      }
    }
    return null;
  }

  init();

});