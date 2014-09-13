namespace('Shared')

class Shared.ChartView extends Backbone.View
  template: JST['app/scripts/shared/chart_view_template.ejs']

  render: ->
    console.log @options.incidents
    @$el.html(@template())
    ctx = @$el.find('#myChart')[0].getContext("2d")
    data = @generateChartData()
    chart = new Chart(ctx).Doughnut(data)
    @

  generateChartData: ->
    data =
      [
        {value: 300, color: "#F7464A", highlight: "#FF5A5E", label: "Red"},
        {value: 50, color: "#46BFBD", highlight: "#5AD3D1", label: "Green"},
        {value: 100, color: "#FDB45C", highlight: "#FFC870", label: "Yellow"},
      ]
