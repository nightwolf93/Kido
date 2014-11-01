class SceneManager
  constructor: ->
    @currentScene = undefined

  setScene: (scene) ->
    if @currentScene != undefined
      @currentScene.leave()
    @currentScene = scene
    @currentScene.enter()

  update: (gametime) ->
    if @currentScene != undefined
      @currentScene.update gametime

  render: (g) ->
    if @currentScene != undefined
      @currentScene.render g

class Scene
  constructor: (@name, @overlays) ->
    @stage = new Kido.Container()
    @sceneDiv = '#scene-' + @name
    Kido.EventEmitter.when 'assets.complete', =>
      @initialized()

  @initialized: ->

  enter: ->
    $(@sceneDiv).css 'display', 'block'

  leave: ->
    $(@sceneDiv).css 'display', 'none'

  update: (gametime) ->
    @stage.update gametime

  render: (g) ->
    @stage.render g

if(window.Kido == undefined) then window.Kido = {}
Kido.Scene = Scene
Kido.SceneManager = new SceneManager
