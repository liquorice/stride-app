(function() {
  'use strict';

  var form;
  var input;
  var duration_display;
  var messages_container;
  var last_seen = -1;
  var queue = [];
  var template;
  var chat_open = true;

  var init = function() {
    form = $('.js-chat-form');
    input = form.find('.js-chat-content');
    messages_container = $('.js-chat-messages');
    duration_display = $('.js-chat-duration');
    template = $('.js-chat-template').text();

    form.on('submit', function(e) {
      e.preventDefault();
      send_message();
      return false;
    })

    send_to_server({ task: 'history' });
    setTimeout(flush_queue, POLL_INTERVAL);
  };

  // Rendering

  var add_message = function(message_data) {
    var vars;
    var templated;

    vars = template.match(/\$[a-zA-Z_-]+/g);
    templated = template;

    message_data['self'] = (message_data['user_id'] == USER_ID) ? 'true' : 'false';

    for (var i = 0; i < vars.length; i++) {
      var var_name;
      var_name = vars[i].substr(1);

      templated = templated.replace(
        RegExp('\\$' + var_name, 'g'),
        message_data[var_name]
      );
    };

    $(templated).appendTo(messages_container);
  };

  var update_duration = function(timestamp) {
    var duration;
    var display_text;

    duration = Math.floor((timestamp - START_TIME) / 60);
    display_text = duration + ' ' + (duration == 1 ? 'min' : 'mins');

    duration_display.text(display_text);
  }

  // Queue

  var flush_queue = function() {
    send_to_server({
      task: 'update',
      queue: queue,
      last_seen: last_seen
    });

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

    if (response.last_seen) {
      last_seen = response.last_seen;
    }

    if (response.messages) {
      for (var i = 0; i < response.messages.length; i++) {
        add_message(response.messages[i]);
      }
    }

    if (response.timestamp) {
      update_duration(response.timestamp);
    }
  };

  // Messaging

  var send_message = function() {
    var message_content;
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
      avatar_face: AVATAR_FACE
    });

    input.val('');
  };


  $(init);

})();