class KidoEngine
  constructor: (canvasId) ->
    @canvas = document.getElementById canvasId
    @ctx = @canvas.getContext '2d'
    @gametime = 0
    _this = @
    Kido.SceneManager.setScene new Kido.Scenes.InGame()
    setInterval(->
      _this.gameloop()
    1000 / 60)

  gameloop: ->
    @canvas.width = @canvas.width
    @update()
    @render()

  update: ->
    Kido.SceneManager.update @gametime
    @gametime++

  render: ->
    Kido.SceneManager.render @

if(window.Kido == undefined)
  window.Kido = {
    KidoEngine: KidoEngine,
    Scenes: {}
  }
else
  Kido.KidoEngine = KidoEngine
  if Kido.Scenes == undefined then Kido.Scenes = {}
