(function() {

  'use strict';

  var init = function() {
    Module.apply($('.js-post'), 'postContent');
    Module.apply($('.js-postReply'), 'postReply');
    Module.apply($('.js-notification'), 'notification');
    Module.include('dropdown');
    Module.include('href');
    Module.include('modal');
  };

  $(init);

})();
