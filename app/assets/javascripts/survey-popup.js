Module.register('survey', function(_container) {
  'use strict';

  var container;
  var survey;
  var close;
  var closed;

  var time_delay;

  var cookieName = "surveyShown=";
  var cookiePath = "path=/;";
  var cookieExpire;

  var init = function() {
    container = _container;
    survey = container.find('.js-survey_api');
    close = container.find('.js-survey-close');
    closed = false;

    $.get(
      KB_API_URL,
      process_survey_data,
      "JSON"
    );
  }

  var process_survey_data = function(data) {
    if (data["survey"]) {
      console.log(data["survey"]);
      if (data["survey"]["delay"]) {
        survey[0].setAttribute('data-time', data["survey"]["delay"]);
      }
      if (data["survey"]["delay"]) {
        survey[0].setAttribute('data-expire', data["survey"]["expiry"]);
      }
      survey.find('.js-survey_content')[0].innerHTML = data["survey"]["content"];
      survey.find('.js-survey_link')[0].setAttribute('href', data["survey"]["link"]);
    }

    setSurvey();
  };

  var setSurvey = function() {
    if (surveyShown() != "true") {
      close.on('click', function() {
        container.toggleClass('hidden');
        closed = true;

        cookieExpire = new Date();
        cookieExpire.setTime( cookieExpire.getTime() + (parseInt(survey.attr('data-expire'), 10) * 24 * 60 * 60 * 1000));
        
        document.cookie = cookieName + "true;" + cookiePath + "expires=" + cookieExpire.toUTCString();
      });

      if (!closed) {
        console.log(survey);
        console.log(survey.attr('data-time'));
        setTimeout(function() {
          container.toggleClass("hidden");
        }, parseInt(survey.attr('data-time'), 10));
      }
    }
  };

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