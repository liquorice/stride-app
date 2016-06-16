Module.register('radiobutton', function(_container) {
  'use strict';

  _container.on('click', function() {
    _container.closest("form").submit();
  });

});
