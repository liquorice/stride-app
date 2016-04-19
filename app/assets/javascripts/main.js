(function() {

  'use strict';

  var init = function() {
    Module.include('textarea-showtoggle');
    Module.apply($('.js-autoexpand'), 'autoexpand');
    Module.include('dropdown');
    Module.include('href');
  };

  $(init);

})();
