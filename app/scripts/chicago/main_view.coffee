namespace('Chicago')

class Chicago.MainView extends Backbone.View
  template: JST['app/scripts/chicago/main_view_template.ejs']

  events:
    "click [data-id=landing-button]" : "backToLanding"

  mapOptions: ->
    center: new @options.google.maps.LatLng(41.833, -87.732)
    minZoom: 10
    zoom: 11

  render: ->
    @$el.html(@template())
    mapCanvas = @$el.find('[data-id=map-canvas]')[0]
    incidents = new Chicago.Incidents()
    @mapUtility = new Map.Utility(@options.google, mapCanvas, @mapOptions(), incidents)
    incidents.fetch
      success: =>
        @mapUtility.displayIncidents()
    @

  backToLanding: ->
    @$el.empty()
    Backbone.history.navigate("", {trigger: true})
