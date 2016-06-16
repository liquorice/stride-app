Module.register('tags', function(_container) {
  'use strict';

  var container;
  var input;
  var template;

  var init = function() {
    container = _container;
    input = container.find('.js-tags-entry');
    template = container.find('.js-template').text();

    input.on('keydown', keydown);
    input.on('focus', function() {
      container.addClass('focus');
    });
    input.on('blur', function() {
      container.removeClass('focus');
    });

    container.on('click', function() {
      input.trigger('focus');
    });

    container.on('click', '.js-tag-remove', function(e) {
      var el;
      el = $(this).parents('.js-tag');
      el.remove();
      input.trigger('change').trigger('focus');
    });

    container.on('click', '.js-tag', function(e) {
      e.preventDefault();
      return false;
    });

  };


  var keydown = function(e) {
    var keycode;
    var val;
    var new_tag;

    keycode = e.keyCode;
    val = input.val();

    if (keycode != 13 && keycode != 8) {
      return;
    }

    if (keycode == 8) {
      if (val == "") {
        container.find('.js-tag').last().remove();
      }
      return;
    }

    e.preventDefault();


    val = $.trim(val);
    if (val.length == 0) {
      return;
    }

    new_tag = $(template);
    new_tag.find('input').val(val);
    new_tag.find(".js-tag-display").text(val);
    new_tag.insertBefore(input);

    input.val('').trigger('change').focus();
  };

  init();

});
