namespace ('Shared')

class Shared.InfoView extends Backbone.View
  template: JST['app/scripts/shared/info_view_template.ejs']

  events:
    "click [data-id=close-button]": "close"
    "click [data-id=expand-button]": "expand"

  render: ->
    @$el.html(@template(@presenterData()))
    @renderStreetView()
    @

  presenterData: ->
    'primary_type'  : @options.incident.get('primary_type')
    'description'   : @options.incident.get('description')
    'incident_date' : @options.incident.get('date')

  renderStreetView: ->
    panorama = new @options.google.maps.StreetViewPanorama(@$('[data-id=pano]')[0], {position: @options.coordinates, disableDefaultUI: true, clickToGo: true})
    @options.map.setStreetView(panorama)

  close: ->
    @$el.empty()

  expandButton: ->
    @$('[data-id=expand-button]')

  expand: ->
    if @isExpanded()
      @setToCollapsed()
      @trigger('collapseInfoView', @)
    else
      @setToExpanded()
      @trigger('expandInfoView', @)

  isExpanded: ->
    @expandButton().data("expanded")

  setToCollapsed: ->
    @expandButton().data("expanded", false)
    @expandButton().html("expand")

  setToExpanded: ->
    @expandButton().data("expanded", true)
    @expandButton().html("collapse")
