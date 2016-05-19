Module.register('postReply', function(_container) {
  'use strict';

  var textarea;
  var container;
  var quoted_container;
  var quoted_input;
  var quoted_display;

  var init = function() {
    container = _container;
    textarea = container.find('.js-textarea');

    quoted_container = container.find('.js-quoted');
    quoted_input = quoted_container.find('.js-quoted-post-id');
    quoted_display = quoted_container.find('.js-quoted-display');

    setup_clear();
    setup_growing_textarea();
    setup_quoting();
  }

  var setup_clear = function() {
    container.find('.js-clear').on('click', function() {
      textarea.val('').trigger('input');
    });
  }

  var setup_growing_textarea = function() {
    textarea.on('input', function() {
      if (textarea.val().length) {
        container.addClass('hasContent');
      }
      else {
        container.removeClass('hasContent');
      }

      textarea
        .css('height', 0)
        .css('height', textarea[0].scrollHeight + 'px');
    });

    textarea.trigger('input');
  }

  var setup_quoting = function() {
    var quote_buttons;

    quote_buttons = $('.js-post-quote');

    quote_buttons.on('click', function() {
      var quote_button;
      quote_button = $(this);

      quoted_container.addClass('active');
      quoted_input.val(quote_button.attr('data-post-id'));
      quoted_display.text(quote_button.attr('data-post-description'));
    });

    quoted_container.find('.js-quoted-clear').on('click', clear_quote);

    clear_quote();
  }

  var clear_quote = function() {
    quoted_container.removeClass('active');
    quoted_input.val('');
    quoted_display.text('');
  }

  init();

});