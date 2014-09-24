namespace('Shared')

class Shared.MainView extends Backbone.View
  template: JST['app/scripts/shared/main_view_template.ejs']

  events:
    "click [data-id=landing-button]" : "backToLanding"
    "click [data-id=show-chart]"     : "showChart"

  render: ->
    @$el.html(@template())
    mapCanvas = @$el.find('[data-id=map-canvas]')[0]
    @incidents = new @options.incidents()
    @incidents.fetch
      success: =>
        @mapUtility = new Map.Utility(@options.google, mapCanvas, @options.mapOptions, @incidents)
        @listenTo(@mapUtility, "expandInfoView", @expandInfoView)
        @mapUtility.displayIncidents()
    @

  backToLanding: ->
    @$el.empty()
    Backbone.history.navigate("", {trigger: true})

  showChart: ->
    city = @incidents.models[0].get('city')
    chartView = new Shared.ChartView(city: city)
    @$el.find('[data-id=chart-container]').html(chartView.render().el)

  expandInfoView: ->
    # manipulate the size of the map container and info view container
