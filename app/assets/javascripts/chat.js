(function() {
  'use strict';

  var form;
  var input;
  var duration_display;
  var local_start_time;
  var messages_container;
  var messages_area;
  var last_seen_message = 0;
  var last_seen_notification = 0;
  var queue = [];
  var template;
  var chat_open = true;
  var can_post;

  var init = function() {
    form = $('.js-chat-form');
    input = form.find('.js-chat-content');
    messages_container = $('.js-chat-messages');
    messages_area = $('.js-chat-area');
    duration_display = $('.js-chat-duration');
    template = $('.js-chat-template').text();

    local_start_time = Date.now();

    // If no USER_ID is present, we are in view-only mode
    can_post = (typeof USER_ID !== 'undefined');

    setup_moderator_tools();
    setup_clear();
    setup_growing_textarea();

    form.on('submit', function(e) {
      e.preventDefault();
      send_message();
      return false;
    })

    send_to_server({ task: 'history' });
    setTimeout(flush_queue, POLL_INTERVAL);
    setInterval(update_duration, 500);
  };

  // Textarea input auto-resize and clear

  var setup_clear = function() {
    form.find('.js-clear').on('click', function() {
      input.val('').trigger('input');
    });
  }

  var setup_growing_textarea = function() {
    input.on('input', function() {
      if (input.val().length) {
        form.addClass('hasContent');
      }
      else {
        form.removeClass('hasContent');
      }

      input
        .css('height', 0)
        .css('height', input[0].scrollHeight + 'px');
    });

    input.trigger('input');
  }

  // Rendering

  var add_message = function(message_data) {
    var vars;
    var templated;

    vars = template.match(/\$[a-zA-Z_-]+/g);
    templated = template;

    message_data['self'] = (can_post && message_data['user_id'] == USER_ID) ? 'true' : 'false';

    message_data['content'] = message_data['content'].replace(/(?:\r\n|\r|\n)/g, '<br>');

    for (var i = 0; i < vars.length; i++) {
      var var_name;
      var_name = vars[i].substr(1);

      templated = templated.replace(
        RegExp('\\$' + var_name, 'g'),
        message_data[var_name]
      );
    };

    $(templated).appendTo(messages_container);

    messages_area.stop().animate({
      scrollTop: messages_container.height()
    }, 900);
  };

  var update_duration = function(timestamp) {
    var duration;
    var hours, minutes, seconds;
    var display_text;

    duration = Math.floor(EXISTING_DURATION + (Date.now() - local_start_time) / 1000);

    hours = Math.floor(duration / 60 / 60);
    minutes = Math.floor((duration - (hours * 60 * 60)) / 60);
    seconds = Math.floor(duration % 60);

    display_text = [
      hours + (hours == 1 ? 'hr' : 'hrs'),
      minutes + (minutes == 1 ? 'min' : 'mins'),
      seconds + 's'
    ].join(" ");

    duration_display.text(display_text);
  }

  // Queue

  var flush_queue = function() {
    if (can_post) {
      send_to_server({
        task: 'update',
        queue: queue,
        last_seen_message: last_seen_message,
        last_seen_notification: last_seen_notification
      });
    }
    else {
      send_to_server({
        task: 'view_only',
        last_seen_message: last_seen_message,
        last_seen_notification: last_seen_notification
      });
    }

    queue = [];
    setTimeout(flush_queue, POLL_INTERVAL);
  }

  var add_to_queue = function(type, payload) {
    queue.push({
      type: type,
      payload: payload
    });
  }

  // Comms

  var send_to_server = function(payload) {
    if (!chat_open) return;
    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: POST_PATH,
      dataType: 'json',
      type: 'post',
      data: payload,
      success: process_response
    });
  }

  var process_response = function(response) {
    if (response.status && response.status == 'archived') {
      chat_open = false;
      alert('This chat has ended');
      return;
    }

    if (response.last_seen_message) {
      last_seen_message = response.last_seen_message;
    }

    if (response.last_seen_notification) {
      last_seen_notification = response.last_seen_notification;
    }

    if (response.messages) {
      for (var i = 0; i < response.messages.length; i++) {
        add_message(response.messages[i]);
      }
    }
  };

  // Messaging

  var send_message = function() {
    var message_content;
    if (input.val().trim()) {
      message_content = input.val();

      add_to_queue(
        'message',
        {
          content: message_content
        }
      );

      add_message({
        content: message_content,
        user_name: USER_NAME,
        user_id: USER_ID,
        avatar_colour: AVATAR_COLOUR,
        avatar_face: AVATAR_FACE,
        user_path: USER_PATH,
        user_type: ""
      });

      input.val('');
    }
  };

  // Moderation

  var setup_moderator_tools = function() {
    messages_container.on('click', '.js-chat-delete', function() {
      var message_el;
      var message_id;

      message_el = $(this).parents('.js-message');
      message_id = message_el.attr('data-id');

      add_to_queue(
        'delete',
        {
          message_id: message_id
        }
      );

      message_el.addClass('deleted');
    });

    messages_container.on('click', '.js-chat-private', function() {
      var message_el;
      var user_id;

      message_el = $(this).parents('.js-message');
      user_id = message_el.attr('data-user-id');

      add_to_queue(
        'create_private',
        {
          user_id: user_id
        }
      );

    });
  };

  $(init);

})();