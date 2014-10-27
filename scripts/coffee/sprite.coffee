class GraphicObject
  constructor: (@pos, @size, @visible) ->

class Sprite extends GraphicObject
  constructor: (@asset) ->
    super new Kido.Vector2f(0, 0), new Kido.Size(@asset.size.width, @asset.size.height), true

  @fromStorage: (alias) ->
    return new Sprite Kido.AssetStorage.get(alias)

  update: (gametime) ->

  render: (g) ->
    

class Container extends GraphicObject
  constructor: (@position) ->
    @childrens = new Array()
    @visible = true

  addChild: (sprite) ->
    @childrens.push sprite

  update: (gametime) ->
    for child in @childrens
      child.update gametime

  render: (g) ->
    if @visible
      for child in @childrens
        child.render g

if(window.Kido == undefined) then window.Kido = {}
Kido.GraphicObject = GraphicObject
Kido.Sprite = Sprite
Kido.Container = Container
