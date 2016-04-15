Module.register('div-showToggle', function() {
  'use strict';

  $(document).ready(function() {
    $(".post__optionButton").click(function(){
      $(this).parent().find('#post_modMenu').toggle('slow');
      return false;
    });

    $(".hdrToolbar__user").click(function(){
      $(this).find('#hdr_userMenu').toggle();
      return false;
    });
  });

});