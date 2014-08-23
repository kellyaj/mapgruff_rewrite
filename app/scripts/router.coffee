namespace('App')

class App.Router extends Backbone.Router
  routes:
    ""        : "landing"
    "chicago" : "chicagoIncidents"
    "seattle" : "seattleIncidents"

  appContainer: ->
    $('[data-id=app]')

  landing: ->
    @appContainer().html(new Landing.View().render())

  chicagoIncidents: ->
    console.log "chicago here"

  seattleIncidents: ->
    @appContainer().html(new Seattle.MainView(google: google).render().$el)
