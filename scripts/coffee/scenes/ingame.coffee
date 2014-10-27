class InGame extends Kido.Scene
  constructor: ->
    super 'ingame', []

  enter: ->
    Kido.AssetStorage.loadManifest([
        { alias: 'kido', path: 'assets/kido.png' }
      ])
    super

  initialized: ->
    @kido = Kido.Sprite.fromStorage 'kido'
    @stage.addChild @kido

  update: (gametime) ->
    super gametime

if(window.Kido == undefined) then window.Kido = {}
Kido.Scenes.InGame = InGame
