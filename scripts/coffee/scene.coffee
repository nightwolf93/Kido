class SceneManager
  constructor: ->
    @currentScene = undefined

  setScene: (scene) ->
    if @currentScene != undefined
      console.log 'Leave scene : ' + @currentScene.name
      @currentScene.leave()
    @currentScene = scene
    console.log 'Enter scene : ' + @currentScene.name
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
    _this = @
    Kido.EventEmitter.when 'assets.complete', ->
      _this.initialized()

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
