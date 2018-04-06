var components = (function () {
  'use strict';

  var is_1 = is;
  is.fn = isFunction;
  is.str = isString;
  is.num = isNumber;
  is.obj = isObject;
  is.lit = isLiteral;
  is.bol = isBoolean;
  is.truthy = isTruthy;
  is.falsy = isFalsy;
  is.arr = isArray;
  is.null = isNull;
  is.def = isDef;
  is.in = isIn;
  is.promise = isPromise;
  is.stream = isStream;
  function is(v) {
      return function (d) {
          return d == v;
      };
  }

  function isFunction(d) {
      return typeof d == 'function';
  }

  function isBoolean(d) {
      return typeof d == 'boolean';
  }

  function isString(d) {
      return typeof d == 'string';
  }

  function isNumber(d) {
      return typeof d == 'number';
  }

  function isObject(d) {
      return typeof d == 'object';
  }

  function isLiteral(d) {
      return d.constructor == Object;
  }

  function isTruthy(d) {
      return !(!d) == true;
  }

  function isFalsy(d) {
      return !(!d) == false;
  }

  function isArray(d) {
      return d instanceof Array;
  }

  function isNull(d) {
      return d === null;
  }

  function isDef(d) {
      return typeof d !== 'undefined';
  }

  function isPromise(d) {
      return d instanceof Promise;
  }

  function isStream(d) {
      return !(!(d && d.next));
  }

  function isIn(set) {
      return function (d) {
          return !set ? false : set.indexOf ? ~set.indexOf(d) : d in set;
      };
  }

  var to = {
      arr: toArray,
      obj: toObject
  };
  function toArray(d) {
      return Array.prototype.slice.call(d, 0);
  }

  function toObject(d) {
      var by = 'id';
      return arguments.length == 1 ? (by = d, reduce) : reduce.apply(this, arguments);
      function reduce(p, v, i) {
          if (i === 0) 
              { p = {}; }
          p[is_1.fn(by) ? by(v, i) : v[by]] = v;
          return p;
      }
      
  }

  var commonjsGlobal = typeof window !== 'undefined' ? window : typeof global !== 'undefined' ? global : typeof self !== 'undefined' ? self : {};

  function createCommonjsModule(fn, module) {
  	return module = { exports: {} }, fn(module, module.exports), module.exports;
  }

  var client = typeof window != 'undefined';

  var owner = client ? window : commonjsGlobal;

  var log = function log(ns) {
      return function (d) {
          if (!owner.console || !console.log.apply) 
              { return d; }
          is_1.arr(arguments[2]) && (arguments[2] = arguments[2].length);
          var args = to.arr(arguments), prefix = '[log][' + new Date().toISOString() + ']' + ns;
          args.unshift(prefix.grey ? prefix.grey : prefix);
          return console.log.apply(console, args), d;
      };
  };

  var ready = function ready(fn) {
      return document.body ? fn() : document.addEventListener('DOMContentLoaded', fn.bind(this));
  };

  var _class = function (definition) { return assign(definition.class ? definition.class : !definition.prototype ? classed(definition) : definition.prototype.render ? definition : definition.prototype.connected ? definition : classed(definition)); };
  var assign = Object.assign;
  var classed = function (render) { return render.class = render.class || (function () {
          function anonymous () {}

          anonymous.prototype.render = function render$1 () {
          render.apply(this, arguments);
      };

          return anonymous;
      }()); };

  var promise_1 = promise;
  function promise() {
      var resolve, reject, p = new Promise(function (res, rej) {
          resolve = res, reject = rej;
      });
      arguments.length && resolve(arguments[0]);
      p.resolve = resolve;
      p.reject = reject;
      return p;
  }

  var flatten = function flatten(p, v) {
      if (v instanceof Array) 
          { v = v.reduce(flatten, []); }
      return p = p || [], p.concat(v);
  };

  var has = function has(o, k) {
      return k in o;
  };

  var def = function def(o, p, v, w) {
      if (o.host && o.host.nodeName) 
          { o = o.host; }
      if (p.name) 
          { v = p, p = p.name; }
      !has(o, p) && Object.defineProperty(o, p, {
          value: v,
          writable: w
      });
      return o[p];
  };

  var noop = function () {};
  var emitterify = function emitterify(body, hooks) {
      body = body || {};
      hooks = hooks || {};
      def(body, 'emit', emit, 1);
      def(body, 'once', once, 1);
      def(body, 'off', off, 1);
      def(body, 'on', on, 1);
      body.on['*'] = body.on['*'] || [];
      return body;
      function emit(type, pm, filter) {
          var li = body.on[type.split('.')[0]] || [], results = [];
          for (var i = 0;i < li.length; i++) 
              { if (!li[i].ns || !filter || filter(li[i].ns)) 
              { results.push(call(li[i].isOnce ? li.splice(i--, 1)[0] : li[i], pm)); } }
          for (var i = 0;i < body.on['*'].length; i++) 
              { results.push(call(body.on['*'][i], [type,pm])); }
          return results.reduce(flatten, []);
      }
      
      function call(cb, pm) {
          return cb.next ? cb.next(pm) : pm instanceof Array ? cb.apply(body, pm) : cb.call(body, pm);
      }
      
      function on(type, opts, isOnce) {
          var id = type.split('.')[0], ns = type.split('.')[1], li = body.on[id] = body.on[id] || [], cb = typeof opts == 'function' ? opts : 0;
          return !cb && ns ? (cb = body.on[id]['$' + ns]) ? cb : push(observable(body, opts)) : !cb && !ns ? push(observable(body, opts)) : cb && ns ? push((remove(li, body.on[id]['$' + ns] || -1), cb)) : cb && !ns ? push(cb) : false;
          function push(cb) {
              cb.isOnce = isOnce;
              cb.type = id;
              if (ns) 
                  { body.on[id]['$' + (cb.ns = ns)] = cb; }
              li.push(cb);
              (hooks.on || noop)(cb);
              return cb.next ? cb : body;
          }
          
      }
      
      function once(type, callback) {
          return body.on(type, callback, true);
      }
      
      function remove(li, cb) {
          var i = li.length;
          while (~--i) 
              { if (cb == li[i] || cb == li[i].fn || !cb) 
              { (hooks.off || noop)(li.splice(i, 1)[0]); } }
      }
      
      function off(type, cb) {
          remove(body.on[type] || [], cb);
          if (cb && cb.ns) 
              { delete body.on[type]['$' + cb.ns]; }
          return body;
      }
      
      function observable(parent, opts) {
          opts = opts || {};
          var o = emitterify(opts.base || promise_1());
          o.i = 0;
          o.li = [];
          o.fn = opts.fn;
          o.parent = parent;
          o.source = opts.fn ? o.parent.source : o;
          o.on('stop', function (reason) {
              o.type ? o.parent.off(o.type, o) : o.parent.off(o);
              return o.reason = reason;
          });
          o.each = function (fn) {
              var n = fn.next ? fn : observable(o, {
                  fn: fn
              });
              o.li.push(n);
              return n;
          };
          o.pipe = function (fn) {
              return fn(o);
          };
          o.map = function (fn) {
              return o.each(function (d, i, n) {
                  return n.next(fn(d, i, n));
              });
          };
          o.filter = function (fn) {
              return o.each(function (d, i, n) {
                  return fn(d, i, n) && n.next(d);
              });
          };
          o.reduce = function (fn, acc) {
              return o.each(function (d, i, n) {
                  return n.next(acc = fn(acc, d, i, n));
              });
          };
          o.unpromise = function () {
              var n = observable(o, {
                  base: {},
                  fn: function (d) {
                      return n.next(d);
                  }
              });
              o.li.push(n);
              return n;
          };
          o.next = function (value) {
              o.resolve && o.resolve(value);
              return o.li.length ? o.li.map(function (n) {
                  return n.fn(value, n.i++, n);
              }) : value;
          };
          o.until = function (stop) {
              (stop.each || stop.then).call(stop, function (reason) {
                  return o.source.emit('stop', reason);
              });
              return o;
          };
          o.off = function (fn) {
              return remove(o.li, fn), o;
          };
          o.start = function (fn) {
              o.source.emit('start');
              return o;
          };
          o[Symbol.asyncIterator] = function () {
              return {
                  next: function () {
                      return o.wait = new Promise(function (resolve) {
                          o.wait = true;
                          o.map(function (d, i, n) {
                              delete o.wait;
                              o.off(n);
                              resolve({
                                  value: d,
                                  done: false
                              });
                          });
                          o.emit('pull', o);
                      });
                  }
              };
          };
          return o;
      }
      
  };

  var event = function event(node, index) {
      node = node.host && node.host.nodeName ? node.host : node;
      if (node.on) 
          { return; }
      node.listeners = {};
      var on = function (o) {
          var type = o.type.split('.').shift();
          if (!node.listeners[type]) 
              { node.addEventListener(type, node.listeners[type] = (function (event) { return !event.detail || !event.detail.emitted ? emit(type, event) : 0; })); }
      };
      var off = function (o) {
          if (!node.on[o.type].length) {
              node.removeEventListener(o.type, node.listeners[o.type]);
              delete node.listeners[o.type];
          }
      };
      emitterify(node, {
          on: on,
          off: off
      });
      var emit = node.emit;
      node.emit = function (type, params) {
          var detail = {
              params: params,
              emitted: true
          }, event = new CustomEvent(type, {
              detail: detail,
              bubbles: false,
              cancelable: true
          });
          node.dispatchEvent(event);
          return emit(type, event);
      };
  };

  var client$1 = typeof window != 'undefined';

  var define = createCommonjsModule(function (module) {
      var noop = function () {}, HTMLElement = client$1 && window.HTMLElement || (function () {
          function anonymous () {}

          return anonymous;
      }()), registry = client$1 && window.customElements || {};
      module.exports = function define(name, component) {
          if (arguments.length == 1) {
              component = name, name = "anon-" + (registry.anon++);
          }
          if (component.wrapper) 
              { return component.wrapper; }
          if (!name.includes('-')) 
              { return; }
          if (!client$1) 
              { return wrap(_class(component)); }
          var wrapped = registry.get(name);
          if (wrapped) {
              if (wrapped.class == _class(component)) 
                  { return wrapped; }
              wrapped.class = _class(component);
              var instances = Array.from(document.querySelectorAll(name));
              instances.map(function (node) {
                  node.disconnectedCallback();
                  node.methods.map(function (method) {
                      delete node[method];
                  });
                  node.connectedCallback();
              });
          } else {
              registry.define(name, wrapped = wrap(_class(component)));
          }
          return wrapped;
      };
      var wrap = function (component) {
          component.wrapper = component.wrapper || (function (HTMLElement) {
              function anonymous () {
                  HTMLElement.apply(this, arguments);
              }

              if ( HTMLElement ) anonymous.__proto__ = HTMLElement;
              anonymous.prototype = Object.create( HTMLElement && HTMLElement.prototype );
              anonymous.prototype.constructor = anonymous;

              anonymous.prototype.connectedCallback = function connectedCallback () {
                  var this$1 = this;

                  var ref = component.wrapper.class;
                  var prototype = ref.prototype;
                  event(this);
                  this.state = this.state || {};
                  this.methods = Object.getOwnPropertyNames(prototype).filter(function (method) { return !(method in disallowed); }).map(function (method) { return (this$1[method] = prototype[method].bind(this$1), method); });
                  return Promise.resolve((this.connected || noop).call(this, this, this.state)).then(function (d) {
                      this$1.initialised = true;
                      this$1.render();
                  });
              };
              anonymous.prototype.render = function render () {
                  var ref = component.wrapper.class;
                  var prototype = ref.prototype;
                  if (!this.initialised) 
                      { return; }
                  return prototype.render.call(this, this, this.state);
              };
              anonymous.prototype.disconnectedCallback = function disconnectedCallback () {
                  (this.disconnected || noop).call(this, this, this.state);
                  this.dispatchEvent(new CustomEvent('disconnected'));
                  this.initialised = false;
              };

              return anonymous;
          }(HTMLElement));
          component.wrapper.class = component;
          return component.wrapper;
      };
      var disallowed = {
          length: 1,
          prototype: 1,
          name: 1,
          render: 1
      };
      registry.anon = registry.anon || 1;
  });

  var components = function components(ripple) {
      if (!client) 
          { return ripple; }
      log$1('creating');
      Node.prototype.render = function () {
          var name = this.nodeName.toLowerCase();
          if (name.includes('-')) 
              { this.fn$ = this.fn$ || ripple.subscribe(name).map(function (component) { return define(name, component); }); }
      };
      Node.prototype.draw = function () {
          this.render();
      };
      ready(function () { return Array.from(document.querySelectorAll('*')).filter(function (d) { return d.nodeName.includes('-'); }).map(function (node) { return node.render(); }); });
      return ripple;
  };
  var log$1 = log('[ri/components]');

  return components;

}());
