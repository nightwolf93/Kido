(function() {
  var KidoEngine;

  KidoEngine = (function() {
    function KidoEngine(canvasId) {
      var _this;
      this.canvas = document.getElementById(canvasId);
      this.ctx = this.canvas.getContext('2d');
      _this = this;
      Kido.SceneManager.setScene(new Kido.Scenes.Login());
      setInterval(function() {
        return _this.gameloop();
      }, 1000 / 60);
    }

    KidoEngine.prototype.gameloop = function() {
      this.update();
      return this.render();
    };

    KidoEngine.prototype.update = function() {};

    KidoEngine.prototype.render = function() {};

    return KidoEngine;

  })();

  window.Kido = {
    KidoEngine: KidoEngine,
    Scenes: {}
  };

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

    return SceneManager;

  })();

  Scene = (function() {
    function Scene(name, overlays) {
      this.name = name;
      this.overlays = overlays;
      this.sceneDiv = '#scene-' + this.name;
    }

    Scene.prototype.enter = function() {
      return $(this.sceneDiv).css('display', 'block');
    };

    Scene.prototype.leave = function() {
      return $(this.sceneDiv).css('display', 'none');
    };

    return Scene;

  })();

  Kido.Scene = Scene;

  Kido.SceneManager = new SceneManager;

}).call(this);

(function() {
  var Login,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Login = (function(_super) {
    __extends(Login, _super);

    function Login() {
      Login.__super__.constructor.call(this, 'login', []);
    }

    return Login;

  })(Kido.Scene);

  Kido.Scenes.Login = Login;

}).call(this);
