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
    mapOptions =
      center: new google.maps.LatLng(41.833, -87.732)
      minZoom: 10
      zoom: 11
    @appContainer().html(new Shared.MainView(google: google, mapOptions: mapOptions, incidents: Chicago.Incidents).render().$el)

  seattleIncidents: ->
    mapOptions =
      center: new google.maps.LatLng(47.6097, -122.3331)
      minZoom: 10
      zoom: 11
    @appContainer().html(new Shared.MainView(google: google, mapOptions: mapOptions, incidents: Seattle.Incidents).render().$el)
