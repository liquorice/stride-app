Module.register('justPinned', function() {
  'use strict';

  var fragment;
  var just_pinned_id;

  fragment = location.hash;

  // Remove potential leading hash
  if (fragment.substr(0, 1) == '#') {
    fragment = fragment.substr(1);
  }

  if (fragment.substr(0, 7) == 'pinned-') {
    just_pinned_id = fragment.substr(7);
    $('.thread[data-thread-id=' + just_pinned_id + ']').addClass('justPinned');
  }

});