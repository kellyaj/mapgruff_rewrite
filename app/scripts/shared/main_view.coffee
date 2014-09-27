namespace('Shared')

class Shared.MainView extends Backbone.View
  template: JST['app/scripts/shared/main_view_template.ejs']

  events:
    "click [data-id=landing-button]" : "backToLanding"
    "click [data-id=show-chart]"     : "showChart"
    "click [data-id=incident-count]" : "adjustIncidentCount"

  render: ->
    @$el.html(@template())
    mapCanvas = @$('[data-id=map-canvas]')[0]
    @incidents = new @options.incidents()
    @incidents.fetch
      success: =>
        @lastFiveHundredIncidents = new @options.incidents(@incidents.slice(0, 500))
        @lastThousandIncidents = new @options.incidents(@incidents.slice(0, 1000))
        @mapUtility = new Map.Utility(@options.google, mapCanvas, @options.mapOptions, @lastFiveHundredIncidents)
        @listenTo(@mapUtility, "expandInfoView", @expandInfoView)
        @listenTo(@mapUtility, "collapseInfoView", @collapseInfoView)
        @mapUtility.displayIncidents()
    @

  backToLanding: ->
    @$el.empty()
    Backbone.history.navigate("", {trigger: true})

  showChart: ->
    city = @incidents.models[0].get('city')
    chartView = new Shared.ChartView(city: city)
    @$('[data-id=chart-container]').html(chartView.render().el)

  expandInfoView: (infoView) ->
    currentCenter = @mapUtility.getCurrentCenter()
    @$("[data-id=map-container]").css('width', '20%')
    @$("[data-id=info-container]").css('width', '70%')
    @resizeMaps(infoView, currentCenter)

  collapseInfoView: (infoView) ->
    currentCenter = @mapUtility.getCurrentCenter()
    @$("[data-id=map-container]").css('width', '60%')
    @$("[data-id=info-container]").css('width', '30%')
    @resizeMaps(infoView, currentCenter)

  resizeMaps: (infoView, center) ->
    infoView.renderStreetView()
    @mapUtility.resizeMap(center)

  incidentCountSelector: ->
    @$("[data-id=incident-count]")

  adjustIncidentCount: ->
    if @incidentCountSelector().data("count") == 500
      @adjustSelectorValues(1000)
      @mapUtility.incidents = @lastThousandIncidents
      @mapUtility.displayIncidents()
    else
      @adjustSelectorValues(500)
      @mapUtility.incidents = @lastFiveHundredIncidents
      @mapUtility.displayIncidents()

  adjustSelectorValues: (value) ->
    @incidentCountSelector().html("Count: #{value}")
    @incidentCountSelector().data("count", value)

