Module.register('modal', function() {
  'use strict';

  var popup;
  var popup_content;
  var body;

  var init = function() {
    body = $('body');
    popup = $('.js-popup');
    popup_content = $('.js-popup-content')

    $('a[data-modal]').on('click', load_popup);
    popup.find('.js-popup-close').on('click', hide_popup);
  };

  var load_popup = function(e) {
    var el;
    var href;

    el = $(this);
    href = el.attr('href');

    show_popup();
    show_loading();

    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: href,
      dataType: 'html',
      type: 'get',
      success: function(response) {
        var new_content;
        new_content = $( "<div>" ).append($.parseHTML(response)).find('.modalContainer');
        hide_loading();
        popup_content.empty().append(new_content);
      }
    });

    e.preventDefault();
  };

  var show_popup = function() {
    body.addClass('modal-visible');
  };

  var hide_popup = function() {
    body.removeClass('modal-visible');
  };

  var show_loading = function() {
    popup.addClass('loading');
  };

  var hide_loading = function() {
    popup.removeClass('loading');
  };

  init();

});
