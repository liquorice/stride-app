Module.register('userSearch', function() {
  'use strict';

  var search_input;
  var access_levels;

  var init = function() {
    search_input = $('body').find('.js-user-search');

    if (search_input.length) {
      setup_clear($('body').find('.js-user-clear'));
      access_levels = $('body').find('.js-access-level');
      search_input.on('keyup', do_search);
    }
  }

  var setup_clear = function(clear) {
    clear.on('click', function() {
      search_input.val('');
      do_search();
    });
  }

  var update_total = function(level, count) {
    if ((count == 0) && (!level.hasClass('hidden'))) {
      level.addClass('hidden');
    }
    else if (count > 0) {

      if (level.hasClass('hidden')) {
        level.removeClass('hidden');
      }
      level.find('.js-user-count').text("("+count+")");

    }
  };

  var hide_user = function(user) {
    if (user.hasClass('visible')) {
      user.removeClass('visible');
    }
  };

  var show_user = function(user) {
    if (!user.hasClass('visible')) {
      user.addClass('visible');
    }
  };

  var do_search = function() {
    var query;
    query = search_input.val().toLowerCase();

    access_levels.each(function() {
      var user_count = 0;

      $(this).find('.js-user').filter(function() {
        var haystack = $(this).attr('data-name').toLowerCase();

        if (!query.length || haystack.indexOf(query) >= 0) {
          show_user($(this));
          user_count++;
        }
        else if (!haystack || haystack.indexOf(query) == -1) {
          hide_user($(this));
        }
      });

      update_total($(this), user_count);

    });
  }

  init();

});