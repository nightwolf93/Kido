class EventEmitter
  @emitters = []
  @when: (alias, callback) ->
    @emitters[alias] = callback
  @dispatch: (alias) ->
    @emitters[alias]()

if(window.Kido == undefined) then window.Kido = {}
Kido.EventEmitter = EventEmitter
