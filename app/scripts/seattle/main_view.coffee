namespace('Seattle')

class Seattle.MainView extends Backbone.View
  template: JST['app/scripts/seattle/main_view_template.ejs']

  mapOptions: ->
    center: new @options.google.maps.LatLng(47.6097, -122.3331)
    minZoom: 10
    zoom: 11

  render: ->
    @$el.html(@template())
    mapCanvas = @$el.find('[data-id=map-canvas]')[0]
    @mapUtility = new Map.Utility(@options.google, mapCanvas, @mapOptions())
    @
