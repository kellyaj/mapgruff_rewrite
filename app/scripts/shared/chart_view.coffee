namespace('Shared')

class Shared.ChartView extends Backbone.View
  template: JST['app/scripts/shared/chart_view_template.ejs']

  render: ->
    $.ajax({
      url: @getChartUrl()
      success: (data) =>
        @$el.html(@template())
        ctx = @$el.find('#myChart')[0].getContext("2d")
        chart = new Chart(ctx).Pie(JSON.parse(data), @chartOptions())
    })
    @

  chartOptions: ->
    animation: false

  getChartUrl: ->
    if @options.city == "Chicago IL"
      "http://198.58.110.111/chicago_chart"
    else
      "http://198.58.110.111/seattle_chart"
