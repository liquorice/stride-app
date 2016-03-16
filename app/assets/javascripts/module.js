var Module = (function() {
  var modules = {};
  var listeners = {};

  var register_module = function(name, module) {
    modules[name] = module;
  };

  var include_module = function(name) {
    return new modules[name]();
  };

  var add_listener = function(event_name, routine) {
    if (!listeners[event_name]) listeners[event_name] = [];
    listeners[event_name].push(routine);
  };

  var trigger_listeners = function(event_name, payload) {
    if (!listeners[event_name]) return;

    for (var i = 0; i < listeners[event_name].length; i++) {
      listeners[event_name][i](payload);
    }
  };

  var apply_module = function(elements, module_name) {
    elements.each(function() {
      new modules[module_name]($(this));
    });
  };

  return {
    register: register_module,
    include: include_module,
    on: add_listener,
    trigger: trigger_listeners,
    apply: apply_module
  };

})();
