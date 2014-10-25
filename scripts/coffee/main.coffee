$ ->
  bootstrap = new GameBootstrap()

class GameBootstrap
  constructor: ->
    @engine = new Kido.KidoEngine('game')

Kido.GameBootstrap = GameBootstrap
