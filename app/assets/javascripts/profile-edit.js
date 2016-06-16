Module.register('profileEdit', function(_container) {
  'use strict';

  var container;
  var cancel;
  var avatar;
  var userFace;
  var userColour;

  var init = function() {
    container = _container;
    cancel = container.find('.js-profile-edit');
    avatar = container.find('.js-profile-avatar').find('.avatar')[0];
    if (avatar) {
      userFace = avatar.getAttribute('data-face');
      userColour = avatar.getAttribute('data-colour');
    }

    cancel.on('click', function() {
      if (avatar) {
        avatar.setAttribute('data-face', userFace);
        avatar.setAttribute('data-colour', userColour);
      }
      container.toggleClass('edit');
    });
  }

  init();

  container.find('.js-profile-face').on('click', function(selected) {
    avatar.setAttribute('data-face', (selected.target.getAttribute('data-face')));
  });

  container.find('.js-profile-colour').on('click', function(selected) {
    avatar.setAttribute('data-colour', (selected.target.getAttribute('data-colour')));
  });
});
