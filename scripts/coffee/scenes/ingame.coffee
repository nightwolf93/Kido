class InGame extends Kido.Scene
  constructor: ->
    super 'ingame', []

  enter: ->
    Kido.AssetStorage.loadManifest([
        { alias: 'kido', path: 'assets/kido.png' },
        { alias: 'perso1', path: 'assets/spritesheet1.png' }
      ])
    super

  initialized: ->
    spritesheet = Kido.SpriteSheet.fromStorage('perso1', new Kido.Size(50, 50), 6, 13)
    console.log spritesheet

  update: (gametime) ->

    super gametime

  render: (g) ->

    super g

if(window.Kido == undefined) then window.Kido = {}
Kido.Scenes.InGame = InGame
