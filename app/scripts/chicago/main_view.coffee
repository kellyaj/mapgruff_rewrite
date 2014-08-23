namespace('Chicago')

class Chicago.MainView extends Backbone.View
  template: JST['app/scripts/chicago/main_view_template.ejs']

  mapOptions: ->
    center: new @options.google.maps.LatLng(41.833, -87.732)
    minZoom: 10
    zoom: 11

  render: ->
    @$el.html(@template())
    mapCanvas = @$el.find('[data-id=map-canvas]')[0]
    @mapUtility = new Map.Utility(@options.google, mapCanvas, @mapOptions())
    @