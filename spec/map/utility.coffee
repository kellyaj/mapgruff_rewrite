describe 'Map.Utility', ->

  fakeData =
    "id":998
    "city":"Seattle WA"
    "primary_type":"CAR PROWL"
    "latitude":"47.610018897"
    "longitude":"-122.342821734"
    "description":"THEFT-CARPROWL"
    "local_identifier":"2014263120"
    "date":"2014-08-09T09:28:00"
    "location_icon":null
    "location_description":"19XX BLOCK OF PIKE PL"
    "arrest_status":null
    "block":"19XX BLOCK OF PIKE PL"
    "category":"PROPERTY"

  it 'renders the map on creation', ->
    setFixtures("<div id=the-map></div>")
    google =
      maps:
        Map: ->
    incidents = new Backbone.Collection([fakeData])
    mapSpy = spyOn(google.maps, 'Map')
    mapUtility = new Map.Utility(google, $('#the-map'), {}, incidents)

    expect(mapSpy).toHaveBeenCalled()
