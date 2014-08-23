namespace('Seattle')

class Seattle.MainView extends Backbone.View
  template: JST['app/scripts/seattle/main_view_template.ejs']

  render: ->
    @$el.html(@template())
