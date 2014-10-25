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

class Scene
  constructor: (@name, @overlays) ->
    @sceneDiv = '#scene-' + @name

  enter: ->
    $(@sceneDiv).css 'display', 'block'

  leave: ->
    $(@sceneDiv).css 'display', 'none'

Kido.Scene = Scene
Kido.SceneManager = new SceneManager
