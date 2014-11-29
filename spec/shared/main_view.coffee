describe 'Shared.MainView', ->

  fakeServer = null

  beforeEach ->
    fakeServer = sinon.fakeServer.create()

  afterEach ->
    fakeServer.restore()

  google =
    maps:
      StreetViewPanorama: ->
      Map: ->
      LatLng: ->

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

  createView = (incidents, mapOptions) ->
    new Shared.MainView
      google: google
      incidents: incidents || Seattle.Incidents
      mapOptions: mapOptions || {}

  beforeEach ->
    fakeServer.respondWith("GET", "http://198.58.110.111/all_seattle", [200, {'application/json'}, JSON.stringify([fakeData])])

  afterEach ->
    fakeServer.restore()

  it "fetches incidents on render and has the mapUtility display them", ->
    view = createView()
    displaySpy = spyOn(view, 'displayIncidents')

    view.render()
    fakeServer.respond()

    expect(fakeServer.requests[0].url).toEqual(new Seattle.Incidents().url)
    expect(displaySpy).toHaveBeenCalled()

