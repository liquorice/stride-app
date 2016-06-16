Module.register('manageTopics', function(_container) {
  'use strict';

  _container.find('.js-topics-reorder').sortable({
    axis: 'y'
  });

});
