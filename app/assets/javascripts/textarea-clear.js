Module.register('textarea-clear', function(_container) {
  'use strict';

  _container.click(function(){
    if ($(this).parent().find('#postReply__content').length) {
      $(this).parent().find('#postReply__content').val("");
    }

    if ($(this).parent().find('.postReply__button').length) {
      $(this).parent().find('.postReply__button').removeClass("hasContent");
    }
  });

});