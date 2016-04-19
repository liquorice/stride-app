Module.register('autoexpand', function(_container) {
  'use strict';

  _container.on('input', function(){
    $(this).css('height', 0).css('height', this.scrollHeight + 'px');
  }).trigger('input');

});