class KidoEngine
  constructor: (canvasId) ->
    @canvas = new Kido.Canvas(@, document.getElementById(canvasId))
    @gametime = 0

    _this = @
    Kido.SceneManager.setScene new Kido.Scenes.InGame()
    setInterval(->
      _this.gameloop()
    1000 / 60)

  gameloop: ->
    @canvas.canvas.width = @canvas.canvas.width

    @update()
    @render()

  update: ->
    Kido.SceneManager.update @gametime
    @gametime++

  render: ->
    Kido.SceneManager.render @

  setStyle: (key, value) ->
    switch key
      when 'bgcolor'
        @style_bgColor = value

class Canvas
  constructor: (@engine, @canvas) ->
    @ctx = @canvas.getContext '2d'
    @bgColor = '#ffffff'

  setVolume: (volume) ->
    for k, asset of Kido.AssetStorage.storage
      if asset.type == 'sound'
        asset.audio.volume = volume


if(window.Kido == undefined)
  window.Kido = {
    KidoEngine: KidoEngine,
    Canvas: Canvas
    Scenes: {}
  }
else
  Kido.KidoEngine = KidoEngine
  Kido.Canvas = Canvas
  if Kido.Scenes == undefined then Kido.Scenes = {}
