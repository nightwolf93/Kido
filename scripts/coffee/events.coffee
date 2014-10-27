class EventEmitter
  @emitters = []
  @when: (alias, callback) ->
    @emitters[alias] = callback
  @dispatch: (alias) ->
    if @emitters[alias] != undefined
      @emitters[alias]()

if(window.Kido == undefined) then window.Kido = {}
Kido.EventEmitter = EventEmitter
