(function() {

  'use strict';

  var init = function() {
    Module.apply($('.js-post'), 'postContent');
    Module.apply($('.js-postReply'), 'postReply');
    Module.include('dropdown');
    Module.include('href');
  };

  $(init);

})();
