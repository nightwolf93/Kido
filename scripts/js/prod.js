(function() {
  var Asset, AssetStorage;

  AssetStorage = (function() {
    function AssetStorage() {
      this.storage = [];
      this.count = 0;
      this.loaded = 0;
    }

    AssetStorage.prototype.loadManifest = function(manifest) {
      var asset, definition, _i, _len, _results;
      this.count = manifest.length;
      _results = [];
      for (_i = 0, _len = manifest.length; _i < _len; _i++) {
        definition = manifest[_i];
        asset = new Asset(definition.alias, definition.path, true);
        _results.push(this.storage[definition.alias] = asset);
      }
      return _results;
    };

    AssetStorage.prototype.get = function(alias) {
      return this.storage[alias];
    };

    return AssetStorage;

  })();

  Asset = (function() {
    function Asset(alias, path, preload) {
      this.alias = alias;
      this.path = path;
      this.texture = void 0;
      this.size = new Kido.Size(0, 0);
      this.ready = false;
      if (preload) {
        this.load();
      }
    }

    Asset.prototype.load = function() {
      var _this;
      if (this.texture === void 0) {
        _this = this;
        this.texture = new Image();
        this.texture.onload = function() {
          Kido.AssetStorage.loaded++;
          _this.ready = true;
          _this.size = new Kido.Size(this.width, this.height);
          if (Kido.AssetStorage.loaded === Kido.AssetStorage.count) {
            Kido.AssetStorage.loaded = 0;
            Kido.AssetStorage.count = 0;
            return Kido.EventEmitter.dispatch('assets.complete');
          }
        };
        return this.texture.src = this.path;
      }
    };

    return Asset;

  })();

  if (window.Kido === void 0) {
    window.Kido = {};
  }

  Kido.Asset = Asset;

  Kido.AssetStorage = new AssetStorage();

}).call(this);

(function() {
  var EventEmitter;

  EventEmitter = (function() {
    function EventEmitter() {}

    EventEmitter.emitters = [];

    EventEmitter.when = function(alias, callback) {
      return this.emitters[alias] = callback;
    };

    EventEmitter.dispatch = function(alias) {
      return this.emitters[alias]();
    };

    return EventEmitter;

  })();

  if (window.Kido === void 0) {
    window.Kido = {};
  }

  Kido.EventEmitter = EventEmitter;

}).call(this);

(function() {
  var KidoEngine;

  KidoEngine = (function() {
    function KidoEngine(canvasId) {
      var _this;
      this.canvas = document.getElementById(canvasId);
      this.ctx = this.canvas.getContext('2d');
      this.gametime = 0;
      _this = this;
      Kido.SceneManager.setScene(new Kido.Scenes.InGame());
      setInterval(function() {
        return _this.gameloop();
      }, 1000 / 60);
    }

    KidoEngine.prototype.gameloop = function() {
      this.canvas.width = this.canvas.width;
      this.update();
      return this.render();
    };

    KidoEngine.prototype.update = function() {
      Kido.SceneManager.update(this.gametime);
      return this.gametime++;
    };

    KidoEngine.prototype.render = function() {
      return Kido.SceneManager.render(this);
    };

    return KidoEngine;

  })();

  if (window.Kido === void 0) {
    window.Kido = {
      KidoEngine: KidoEngine,
      Scenes: {}
    };
  } else {
    Kido.KidoEngine = KidoEngine;
    if (Kido.Scenes === void 0) {
      Kido.Scenes = {};
    }
  }

}).call(this);

(function() {
  var GameBootstrap;

  $(function() {
    var bootstrap;
    return bootstrap = new GameBootstrap();
  });

  GameBootstrap = (function() {
    function GameBootstrap() {
      this.engine = new Kido.KidoEngine('game');
    }

    return GameBootstrap;

  })();

  Kido.GameBootstrap = GameBootstrap;

}).call(this);

(function() {
  var Scene, SceneManager;

  SceneManager = (function() {
    function SceneManager() {
      this.currentScene = void 0;
    }

    SceneManager.prototype.setScene = function(scene) {
      if (this.currentScene !== void 0) {
        console.log('Leave scene : ' + this.currentScene.name);
        this.currentScene.leave();
      }
      this.currentScene = scene;
      console.log('Enter scene : ' + this.currentScene.name);
      return this.currentScene.enter();
    };

    SceneManager.prototype.update = function(gametime) {
      if (this.currentScene !== void 0) {
        return this.currentScene.update(gametime);
      }
    };

    SceneManager.prototype.render = function(g) {
      if (this.currentScene !== void 0) {
        return this.currentScene.render(g);
      }
    };

    return SceneManager;

  })();

  Scene = (function() {
    function Scene(name, overlays) {
      var _this;
      this.name = name;
      this.overlays = overlays;
      this.stage = new Kido.Container();
      this.sceneDiv = '#scene-' + this.name;
      _this = this;
      Kido.EventEmitter.when('assets.complete', function() {
        return _this.initialized();
      });
    }

    Scene.initialized = function() {};

    Scene.prototype.enter = function() {
      return $(this.sceneDiv).css('display', 'block');
    };

    Scene.prototype.leave = function() {
      return $(this.sceneDiv).css('display', 'none');
    };

    Scene.prototype.update = function(gametime) {
      return this.stage.update(gametime);
    };

    Scene.prototype.render = function(g) {
      return this.stage.render(g);
    };

    return Scene;

  })();

  if (window.Kido === void 0) {
    window.Kido = {};
  }

  Kido.Scene = Scene;

  Kido.SceneManager = new SceneManager;

}).call(this);

(function() {
  var Container, GraphicObject, Sprite,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  GraphicObject = (function() {
    function GraphicObject(pos, size, visible) {
      this.pos = pos;
      this.size = size;
      this.visible = visible;
    }

    return GraphicObject;

  })();

  Sprite = (function(_super) {
    __extends(Sprite, _super);

    function Sprite(asset) {
      this.asset = asset;
      Sprite.__super__.constructor.call(this, new Kido.Vector2f(0, 0), new Kido.Size(this.asset.size.width, this.asset.size.height), true);
    }

    Sprite.fromStorage = function(alias) {
      return new Sprite(Kido.AssetStorage.get(alias));
    };

    Sprite.prototype.update = function(gametime) {};

    Sprite.prototype.render = function(g) {};

    return Sprite;

  })(GraphicObject);

  Container = (function(_super) {
    __extends(Container, _super);

    function Container(position) {
      this.position = position;
      this.childrens = new Array();
      this.visible = true;
    }

    Container.prototype.addChild = function(sprite) {
      return this.childrens.push(sprite);
    };

    Container.prototype.update = function(gametime) {
      var child, _i, _len, _ref, _results;
      _ref = this.childrens;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _results.push(child.update(gametime));
      }
      return _results;
    };

    Container.prototype.render = function(g) {
      var child, _i, _len, _ref, _results;
      if (this.visible) {
        _ref = this.childrens;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          _results.push(child.render(g));
        }
        return _results;
      }
    };

    return Container;

  })(GraphicObject);

  if (window.Kido === void 0) {
    window.Kido = {};
  }

  Kido.GraphicObject = GraphicObject;

  Kido.Sprite = Sprite;

  Kido.Container = Container;

}).call(this);

(function() {
  var Size, Vector2f;

  Size = (function() {
    function Size(width, height) {
      this.width = width != null ? width : 0;
      this.height = height != null ? height : 0;
    }

    return Size;

  })();

  Vector2f = (function() {
    function Vector2f(x, y) {
      this.x = x != null ? x : 0;
      this.y = y != null ? y : 0;
    }

    return Vector2f;

  })();

  if (window.Kido === void 0) {
    window.Kido = {};
  }

  Kido.Size = Size;

  Kido.Vector2f = Vector2f;

}).call(this);

(function() {
  var InGame,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  InGame = (function(_super) {
    __extends(InGame, _super);

    function InGame() {
      InGame.__super__.constructor.call(this, 'ingame', []);
    }

    InGame.prototype.enter = function() {
      Kido.AssetStorage.loadManifest([
        {
          alias: 'kido',
          path: 'assets/kido.png'
        }
      ]);
      return InGame.__super__.enter.apply(this, arguments);
    };

    InGame.prototype.initialized = function() {
      this.kido = Kido.Sprite.fromStorage('kido');
      return this.stage.addChild(this.kido);
    };

    InGame.prototype.update = function(gametime) {
      return InGame.__super__.update.call(this, gametime);
    };

    return InGame;

  })(Kido.Scene);

  if (window.Kido === void 0) {
    window.Kido = {};
  }

  Kido.Scenes.InGame = InGame;

}).call(this);
