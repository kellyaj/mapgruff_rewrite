describe 'Shared.InfoView', ->

  google =
    maps:
      StreetViewPanorama: ->
      Map: ->
      LatLng: ->

  map =
    setStreetView: ->

  fakeData =
    "id": 998
    "city": "Seattle WA"
    "primary_type": "CAR PROWL"
    "latitude": "47.610018897"
    "longitude": "-122.342821734"
    "description": "THEFT-CARPROWL"
    "local_identifier": "2014263120"
    "date": "2014-08-09T09:28:00"
    "location_icon": null
    "location_description": "19XX BLOCK OF PIKE PL"
    "arrest_status": null
    "block": "19XX BLOCK OF PIKE PL"
    "category": "PROPERTY"

  createView = (data=fakeData) ->
    new Shared.InfoView
      google: google
      map: map
      incident: new Backbone.Model(data)

  it 'renders with the primary type and description of an incident', ->
    view = createView()

    view.render()

    expect(view.$el).toContainText(fakeData.primary_type)
    expect(view.$el).toContainText(fakeData.description)

  it 'renders the datetime in a human readable format', ->
    view = createView()

    view.render()

    expect(view.$el).toContainText("08/09/2014 09:28")

  it 'appends the sun icon if the incident was during the daytime', ->
    view = createView()

    view.render()

    expect(view.$('h3 span')).toHaveClass("icon-sun")

  it 'appends the moon icon if the incident was during the nighttime', ->
    nightIncident =
      date: "2014-08-09T23:28:00"
    view = createView(nightIncident)

    view.render()

    expect(view.$('h3 span')).toHaveClass("icon-moon")

  it 'removes all content when the close button is clicked', ->
    view = createView()
    view.render()

    view.$('[data-id=close-button]').click()

    expect(view.$el).toBeEmpty()

  it 'defaults to being collapsed and with a button to expand it', ->
    view = createView()

    view.render()

    expect(view.$('[data-id=expand-button]').data('expanded')).toBeFalsy()
    expect(view.$('[data-id=expand-button]').html()).toEqual("expand")

  it 'triggers the expand call, adds the expanded attribute, and changes to a collapse button', ->
    view = createView()
    view.render()
    triggerSpy = spyOn(view, 'trigger')

    view.$('[data-id=expand-button]').click()

    expect(view.$('[data-id=expand-button]').data('expanded')).toBeTruthy()
    expect(view.$('[data-id=expand-button]').html()).toEqual("collapse")
    expect(triggerSpy).toHaveBeenCalledWith('expandInfoView', view)

  it 'collapses after having been expanded', ->
    view = createView()
    view.render()
    triggerSpy = spyOn(view, 'trigger')

    view.$('[data-id=expand-button]').click()
    view.$('[data-id=expand-button]').click()

    expect(view.$('[data-id=expand-button]').data('expanded')).toBeFalsy()
    expect(view.$('[data-id=expand-button]').html()).toEqual("expand")
    expect(triggerSpy).toHaveBeenCalledWith('collapseInfoView', view)
