Module.register('div-showToggle', function() {
  'use strict';

  $(document).ready(function() {
    $(".post__optionButton").click(function(){
      $(this).parent().find('#post_modMenu').toggle('slow');
      return false;
    });
  });

});