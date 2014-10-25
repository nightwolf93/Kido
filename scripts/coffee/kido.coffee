class KidoEngine
  constructor: (canvasId) ->
    @canvas = document.getElementById canvasId
    @ctx = @canvas.getContext '2d'
    _this = @
    Kido.SceneManager.setScene new Kido.Scenes.Login()
    setInterval(->
      _this.gameloop()
    1000 / 60)

  gameloop: ->
    @update()
    @render()

  update: ->
    #todo

  render: ->
    #todo

window.Kido = {
  KidoEngine: KidoEngine,
  Scenes: {}
}
