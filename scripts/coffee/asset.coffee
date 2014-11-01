class AssetStorage
  constructor: ->
    @storage = []
    @count = 0
    @loaded = 0

  loadManifest: (manifest) ->
    @count = manifest.length
    for definition in manifest
      if definition.path.indexOf('.mp3') == -1
        asset = new Asset(definition.alias, definition.path, true)
        @storage[definition.alias] = asset
      else # Its a sound
        sound = new Sound(definition.alias, definition.path, true)
        @storage[definition.alias] = sound

  get: (alias) ->
    return @storage[alias];

class Asset
  constructor: (@alias, @path, preload) ->
    @texture = undefined
    @size = new Kido.Size 0, 0
    @ready = false
    @type = 'asset'
    if preload then @load()

  load: ->
    if @texture == undefined
      _this = @
      @texture = new Image()
      @texture.onload = ->
        Kido.AssetStorage.loaded++
        _this.ready = true
        _this.size = new Kido.Size @.width, @.height
        if Kido.AssetStorage.loaded == Kido.AssetStorage.count
          Kido.AssetStorage.loaded = 0
          Kido.AssetStorage.count = 0
          Kido.EventEmitter.dispatch 'assets.complete'
      @texture.src = @path

class Sound
  constructor: (@alias, @path, preload) ->
    @audio = undefined
    @ready = false
    @type = 'sound'
    if preload then @load()

  load: ->
    @audio = new Audio @path
    @ready = true
    Kido.AssetStorage.loaded++
    if Kido.AssetStorage.loaded == Kido.AssetStorage.count
      Kido.AssetStorage.loaded = 0
      Kido.AssetStorage.count = 0
      Kido.EventEmitter.dispatch 'assets.complete'

  play: ->
    @audio.play()

if(window.Kido == undefined) then window.Kido = {}
Kido.Asset = Asset
Kido.AssetStorage = new AssetStorage()
