class GraphicObject
  constructor: (@pos, @size, @visible) ->

class Sprite extends GraphicObject
  constructor: (@asset, @alias='undefined') ->
    @scale = 1
    @rotation = 0
    super new Kido.Vector2f(0, 0), new Kido.Size(@asset.size.width, @asset.size.height), true

  @fromStorage: (name, alias) ->
    return new Sprite Kido.AssetStorage.get(name), alias

  rotate: (deg) ->
    @rotation += deg

  update: (gametime) ->

  render: (g) ->
    g.canvas.ctx.save()
    g.canvas.ctx.translate(@pos.x, @pos.y)
    g.canvas.ctx.rotate(@rotation*Math.PI/180)
    g.canvas.ctx.translate(-@pos.x, -@pos.y)
    g.canvas.ctx.drawImage(@asset.texture, @pos.x - (@size.width / 2), @pos.y - (@size.height / 2), @size.width, @size.height)
    g.canvas.ctx.restore()

class Container extends GraphicObject
  constructor: (@position) ->
    @childrens = new Array()
    @visible = true

  addChild: (sprite) ->
    @childrens.push sprite
    return sprite

  getChildByAlias: (alias) ->
    for child in @childrens
      if child.alias == alias then return child
    return undefined

  update: (gametime) ->
    for child in @childrens
      child.update gametime

  render: (g) ->
    if @visible
      for child in @childrens
        child.render g

class SpriteSheet
  constructor: (@asset, @size, @collums, @rows) ->
    @mapping = new Array()
    @animations = []
    for r in [0..@rows - 1]
      for c in [0..@collums - 1]
        @mapping.push { x: c * @size.width, y: r * @size.height }

  @fromStorage: (name, size, collums, rows) ->
    return new SpriteSheet(Kido.AssetStorage.get(name), size, collums, rows)

  buildAnimation: (alias, animations) ->
    anim = new Array()
    for a in animations
      anim.push @mapping[a]
    @animations[alias] = anim

  getAnimatedSprite: (alias, speed, pos) ->
    return new AnimatedSprite @animations, alias, @, speed, pos, @size

class AnimatedSprite extends GraphicObject
  constructor: (@animations, @currentAnim, @spritesheet, @speed, pos, size) ->
    @currentFrame = 0
    @currentGametime = 0
    @rotation = 0
    @scale = 0
    super pos, size

  setAnim: (anim, reset=false) ->
    if @currentAnim != anim
      @currentAnim = anim
      if reset then @currentFrame = 0

  rotate: (deg) ->
    @rotation += deg

  update: (gametime) ->
    @currentGametime++
    if @currentGametime % @speed == 0
      anim = @animations[@currentAnim]
      @currentFrame++
      if @currentFrame == anim.length then @currentFrame = 0

  render: (g) ->
    g.canvas.ctx.save()
    g.canvas.ctx.translate(@pos.x, @pos.y)
    g.canvas.ctx.rotate(@rotation*Math.PI/180)
    g.canvas.ctx.translate(-@pos.x, -@pos.y)
    g.canvas.ctx.drawImage(@spritesheet.asset.texture, @animations[@currentAnim][@currentFrame].x, @animations[@currentAnim][@currentFrame].y, @size.width, @size.height, @pos.x - (@size.width / 2), @pos.y - (@size.height / 2), @size.width, @size.height)
    g.canvas.ctx.restore()

if(window.Kido == undefined) then window.Kido = {}
Kido.GraphicObject = GraphicObject
Kido.Sprite = Sprite
Kido.Container = Container
Kido.SpriteSheet = SpriteSheet
Kido.AnimatedSprite = AnimatedSprite
