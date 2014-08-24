namespace('Map')

class Map.Utility

  constructor: (@google, @mapEl, @mapOptions, @incidents) ->
    @markers = []
    @renderMap()

  renderMap: ->
    @map = new @google.maps.Map(@mapEl, @mapOptions)

  displayIncidents: ->
    _.each @incidents.models, (incident) =>
      coordinates = new google.maps.LatLng(incident.get('latitude'), incident.get('longitude'))
      marker = new google.maps.Marker
        icon: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
        position: coordinates
        map: @map
