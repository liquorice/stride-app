(function() {

  'use strict';

  var init_applies = function(container) {
    Module.apply(container.find('.js-post'), 'postContent');
    Module.apply(container.find('.js-postReply'), 'postReply');
    Module.apply(container.find('.js-notification'), 'notification');
    Module.apply(container.find('.js-tags'), 'tags');
  }

  var init = function(container) {
    init_applies($('body'));
    Module.include('dropdown');
    Module.include('href');
    Module.include('modal');

    window.init_applies = init_applies;
  };

  $(init);

})();
