Module.register('href', function() {
  'use strict';

  $(document).on('click', '[data-href] [href]', function(e) {
    e.stopPropagation();
  });

  $(document).on('click', '[data-href]', function(e) {
    document.location.href = $(this).data('href');
    e.preventDefault();
    return false;
  });
});