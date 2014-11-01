class InGame extends Kido.Scene
  constructor: ->
    super 'ingame', []

  enter: ->
    Kido.AssetStorage.loadManifest([
        { alias: 'kido', path: 'assets/kido.png' },
        { alias: 'perso1', path: 'assets/spritesheet1.png' }
        { alias: 'sound1', path: 'assets/1.mp3' }
      ])
    super

  initialized: ->
    @spritesheet = Kido.SpriteSheet.fromStorage('perso1', new Kido.Size(165, 292), 6, 13)
    @spritesheet.buildAnimation 'run', [0..13]
    @spritesheet.buildAnimation 'jump', [14..33]
    @guy = @spritesheet.getAnimatedSprite 'run', 3, new Kido.Vector2f(50, 250)
    @stage.addChild @guy
    @music = Kido.AssetStorage.get('sound1')
    #@music.play()
    Bootstrap.engine.canvas.setVolume 0.5

  update: (gametime) ->
    @guy.pos.x += 2
    @guy.rotate(1)
    if @guy.pos.x == 300
      @guy.setAnim 'jump', true
    if @guy.pos.x > 600
      @guy.pos.x = 0
      @guy.setAnim 'run', true
    super gametime

  render: (g) ->

    super g

if(window.Kido == undefined) then window.Kido = {}
Kido.Scenes.InGame = InGame
