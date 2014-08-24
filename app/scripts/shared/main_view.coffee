namespace('Shared')

class Shared.MainView extends Backbone.View
  template: JST['app/scripts/shared/main_view_template.ejs']

  events:
    "click [data-id=landing-button]" : "backToLanding"

  render: ->
    @$el.html(@template())
    mapCanvas = @$el.find('[data-id=map-canvas]')[0]
    incidents = new @options.incidents()
    @mapUtility = new Map.Utility(@options.google, mapCanvas, @options.mapOptions, incidents)
    incidents.fetch
      success: =>
        @mapUtility.displayIncidents()
    @

  backToLanding: ->
    @$el.empty()
    Backbone.history.navigate("", {trigger: true})
