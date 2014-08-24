namespace ('Shared')

class Shared.InfoView extends Backbone.View
  template: JST['app/scripts/shared/info_view_template.ejs']

  render: ->
    @$el.html(@template(@presenterData()))
    @renderStreetView()
    @

  presenterData: ->
    'primary_type'  : @options.incident.get('primary_type')
    'description'   : @options.incident.get('description')
    'incident_date' : @options.incident.get('date')

  renderStreetView: ->
    panorama = new @options.google.maps.StreetViewPanorama(@$el.find('[data-id=pano]')[0], {position: @options.coordinates, disableDefaultUI: true, clickToGo: true})
    @options.map.setStreetView(panorama)
