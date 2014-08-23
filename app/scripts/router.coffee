namespace('App')

class App.Router extends Backbone.Router
  routes:
    ""        : "landing"
    "chicago" : "chicagoIncidents"
    "seattle" : "seattleIncidents"

  landing: ->
    view = new Landing.View()
    $('[data-id=app]').html(view.render())

  chicagoIncidents: ->
    console.log "chicago here"

  seattleIncidents: ->
    console.log "seattle"
