Module.register('modal', function() {
  'use strict';

  var popup;
  var popup_content;
  var body;

  var init = function() {
    body = $('body');
    popup = $('.js-popup');
    popup_content = $('.js-popup-content')

    $('body').on('click', 'a[data-modal]', load_popup);
    if (popup.length) {
      $('body').on('click', '.js-popup-close', hide_popup);
    } else {
      setup_go_back();
    }
    $(document).on('keydown', keypress);
  };

  var load_popup = function(e) {
    var el;
    var href;

    el = $(this);
    href = el.attr('href');

    show_popup();
    show_loading();
    popup_content.empty();

    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: href,
      dataType: 'html',
      type: 'get',
      success: function(response) {
        var new_content;
        new_content = $( "<div>" ).append($.parseHTML(response));

        hide_loading();
        popup_content.append(new_content.find('.modalContainer'));

        window.init_applies(popup_content);

        // Put focus on first input in modal
        popup_content.find('input').not('[type=hidden]').eq(0).trigger('focus');
      }
    });

    e.preventDefault();
  };

  var setup_go_back = function() {
    body.find('.js-popup-close').on('click', function() {
      window.history.back();
    });
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

  var keypress = function(e) {
    if (e.keyCode == 27) {
      hide_popup();
    }
  };

  init();

});
