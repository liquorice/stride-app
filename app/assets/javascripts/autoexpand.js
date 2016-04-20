Module.register('autoexpand', function(_container) {
  'use strict';

  _container.on('input', function(){
    if ($(this).val().length) {
      if ($(this).parent().find('.postReply__button').length) {
        $(this).parent().find('.postReply__button').addClass("hasContent");
      }
    }
    else {
      if ($(this).parent().find('.postReply__button').length) {
        $(this).parent().find('.postReply__button').removeClass("hasContent");
      }
    }

    $(this).css('height', 0).css('height', this.scrollHeight + 'px');
  }).trigger('input');

});