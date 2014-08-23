namespace('Landing')

class Landing.View extends Backbone.View
  template: JST['app/scripts/landing/view_template.ejs']

  events:
    "click [data-id=seattle]": "selectSeattle"
    "click [data-id=chicago]": "selectChicago"

  render: ->
    @$el.html(@template())

  selectSeattle: ->
    @navigateTo("#seattle")

  selectChicago: ->
    @navigateTo("#chicago")

  navigateTo: (route) ->
    @$el.empty()
    Backbone.history.navigate(route, {trigger: true})

