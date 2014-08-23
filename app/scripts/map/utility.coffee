namespace('Map')

class Map.Utility

  constructor: (@google, @mapEl, @mapOptions) ->
    @markers = []
    @renderMap()

  renderMap: ->
    @map = new @google.maps.Map(@mapEl, @mapOptions)
