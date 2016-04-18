Module.register('div-showToggle', function() {
  'use strict';

  $(document).ready(function() {
    $(".hdrToolbar__user").click(function(){
      $(this).find('#hdr_userMenu').toggle();
      return false;
    });
  });

});