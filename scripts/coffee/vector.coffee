class Size
  constructor:(@width=0, @height=0) ->

class Vector2f
  constructor:(@x=0, @y=0) ->

if(window.Kido == undefined) then window.Kido = {}
Kido.Size = Size
Kido.Vector2f = Vector2f
