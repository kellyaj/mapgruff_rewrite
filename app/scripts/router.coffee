namespace('App')

class App.Router extends Backbone.Router
  routes:
    "chicago" : "chicagoIncidents"
    "seattle" : "seattleIncidents"

  chicagoIncidents: ->
    console.log "chicago"

  seattleIncidents: ->
    console.log "seattle"
