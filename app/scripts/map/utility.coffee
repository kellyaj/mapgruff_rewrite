namespace('Map')

class Map.Utility extends Backbone.View

  constructor: (@google, @mapEl, @mapOptions, @incidents) ->
    @renderMap()

  renderMap: ->
    @map = new @google.maps.Map(@mapEl, @mapOptions)

  displayIncidents: ->
    _.each @incidents.models, (incident) =>
      coordinates = new google.maps.LatLng(incident.get('latitude'), incident.get('longitude'))
      marker = new google.maps.Marker
        icon: @getIcon(incident)
        position: coordinates
        map: @map
      infoView = new Shared.InfoView
        incident: incident
        map: @map
        google: @google
        coordinates: coordinates
      @listenTo(infoView, "expandInfoView", @triggerExpand)
      @listenTo(infoView, "collapseInfoView", @triggerCollapse)
      @google.maps.event.addListener marker, "click", ->
        $('[data-id=info-container]').html(infoView.render().$el)

  getIcon: (incident) ->
    switch incident.get('category')
      when "VIOLENT" then "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
      when "PROPERTY" then "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
      when "PERSONAL" then "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"
      else "http://maps.google.com/mapfiles/ms/icons/green-dot.png"

  triggerExpand: (infoView) ->
    @trigger("expandInfoView", infoView)

  triggerCollapse: (infoView) ->
    @trigger("collapseInfoView", infoView)

  getCurrentCenter: ->
    @map.getCenter()

  resizeMap: (center) ->
    @google.maps.event.trigger(@map, 'resize')
    @map.setCenter(center)
