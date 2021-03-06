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
    'primary_type'      : @options.incident.get('primary_type')
    'description'       : @options.incident.get('description')
    'incident_location' : @options.incident.get('location_description')
    'incident_date'     : @formattedDate()

  formattedDate: ->
    rawDate = @options.incident.get('date')
    dateSplit = rawDate.split("T")[0].split("-")
    time = @getTime(rawDate)
    result = ""
    if @isDayTime(time)
      result += '<span class="icon-sun info-view-icon"></span>'
    else
      result += '<span class="icon-moon info-view-icon"></span>'
    result += "#{dateSplit[1]}/#{dateSplit[2]}/#{dateSplit[0]} #{time}"

  getTime: (rawDate) ->
    splitTime = rawDate.split("T")[1].split(":")
    [splitTime[0], splitTime[1]].join(":")

  isDayTime: (time) ->
    time < "22:00" && time >= "06:00"

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
